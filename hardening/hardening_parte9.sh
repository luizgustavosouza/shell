#!/bin/bash

IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
NC='\033[0m'       		  # Text Reset

HOST=$(hostname)
SETOR='9'
FILE="hardening_$HOST_$SETOR.log"

# Parte 9 do hardening Linux

# Manutenção do sistema

echo -e "${IYellow}Listando todos os pacotes instalados...${NC}" | tee -a /var/log/$FILE
rpm -Va --nomtime --nosize --nomd5 --nolinkto >> /var/log/$FILE
if [[ $? -eq 0 ]]; then
 echo -e "Pacotes instalados listados...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Verificando permissões de /etc/passwd...${NC}" | tee -a /var/log/$FILE
RES=$(ls -lh /etc/passwd | awk -F " " '{print $1" "$3" "$4}')
if [[ $RES != '-rw-r--r--. root root' ]]; then
 chmod 644 /etc/passwd && chown root:root /etc/passwd
 if [[ $? -eq 0 ]]; then
  echo -e "Permissões corrigidas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
else
 echo -e "Permissões...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Verificando permissões de /etc/gshadow...${NC}" | tee -a /var/log/$FILE
RES=$(ls -lh /etc/gshadow | awk -F " " '{print $1" "$3" "$4}')
if [[ $RES != '---------. root root' ]]; then
 chmod 000 /etc/gshadow && chown root:root /etc/gshadow
 if [[ $? -eq 0 ]]; then
  echo -e "Permissões corrigidas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
else
 echo -e "Permissões...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Verificando permissões de /etc/group...${NC}" | tee -a /var/log/$FILE
RES=$(ls -lh /etc/group | awk -F " " '{print $1" "$3" "$4}')
if [[ $RES != '-rw-r--r--. root root' ]]; then
 chmod 644 /etc/group && chown root:root /etc/group
 if [[ $? -eq 0 ]]; then
  echo -e "Permissões corrigidas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
else
 echo -e "Permissões...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Verificando arquivos e diretórios sem dono...${NC}" | tee -a /var/log/$FILE
df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser -ls >> /var/log/$FILE
if [[ $? -eq 0 ]]; then
 echo -e "Arquivos e diretórios sem dono...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Verificando arquivos e diretórios sem grupo...${NC}" | tee -a /var/log/$FILE
df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup -ls >> /var/log/$FILE
if [[ $? -eq 0 ]]; then
 echo -e "Arquivos e diretórios sem grupo...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Listando usuários sem senha em /etc/shadow...${NC}" | tee -a /var/log/$FILE
cat /etc/shadow | awk -F: '($2 == "") {print $1 "Não possui senha"}' >> /var/log/$FILE
if [[ $? -eq 0 ]]; then
 echo -e "Listando usuários sem senha em /etc/shadow...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Listando entradas no legacy em /etc/shadow...${NC}" | tee -a /var/log/$FILE
grep '^+:' /etc/passwd >> /var/log/$FILE
if [[ $? -eq 0 ]]; then
 echo -e "Listando entradas no legacy em /etc/shadow...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi
