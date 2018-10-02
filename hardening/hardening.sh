#!/bin/bash
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
BBlue='\033[1;34m'        # Blue
NC='\033[0m'       # Text Reset
FILE=hardening_$(hostname).log
#Iniciando Escrita de Relatório
touch /var/log/$FILE

echo -e "${BBlue}Aplicando hardening no $(hostname)${NC}"  | tee -a /var/log/$FILE


#echo -e "${IYellow}Configurando Stick Bit nos diretório com permissão de escrita...${NC}" | tee -a /var/log/$FILE
#df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | xargs -I '{}' chmod a+t '{}'
#if [[ $? -eq 0 ]]; then
#  echo -e "${IGreen}SUCESS${NC}" | tee tee -a /var/log/$FILE
#fi

echo -e "${IYellow}Configurando gpccheck no yum.conf...${NC}" | tee -a /var/log/$FILE
sed 's/gpgcheck=0/gpgcheck=1/g'  /etc/yum.conf
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo  -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi

echo -e "${IYellow}Desbilitando Repositório do Rancher...${NC}" | tee -a /var/log/$FILE
yum-config-manager --disable docker-ce-stable/x86_64

echo -e "${IYellow}Atualizando S.O${NC}" | tee -a /var/log/$FILE
yum update -y
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo  -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi
echo -e "${IYellow}Habilitando SElinux no grub${NC}" | tee -a /var/log/$FILE
sed 's/selinux=0//g' /boot/grub2/grub.cfg
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo  -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi

echo -e "${IYellow}Habilitando Repositório do Rancher...${NC}" | tee -a /var/log/$FILE
yum-config-manager --enable docker-ce-stable/x86_64
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo  -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi
