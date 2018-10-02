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

#Daemon anacron
echo -e "${IYellow}Instalando anacron...${NC}" | tee -a /var/log/$FILE
rpm -q cronie-anacron
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}Pacote já Instalado${NC}" | tee -a /var/log/$FILE
else
  yum install cronie-anacron -y
  if [[ $? -eq 0 ]]; then
     echo -e "${IGreen}Pacote Instalado${NC}" | tee -a /var/log/$FILE
  fi
fi


#Habilitando Crond
echo -e "${IYellow}Habilitando Crond...${NC}" | tee -a /var/log/$FILE
systemctl is-enabled crond
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}Serviço já habilitado${NC}" | tee -a /var/log/$FILE
else
  systemctl enable crond ; echo -e "${IGreen}Serviço habilitado${NC}" | tee -a /var/log/$FILE
fi


# Configurando os Usuários/Dono de Grupo e as permissões de /etc/anacrontab
echo -e "${IYellow}Configurando os Usuários/Dono de Grupo ${NC}" | tee -a /var/log/$FILE
chown root:root /etc/cron.*
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Configurando as permissões${NC}" | tee -a /var/log/$FILE
chmod og-rwx /etc/cron.*
if [[ $? -eq 0 ]]; then
   echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
 echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


#Restringindo daemon at
rm /etc/cron.deny ; rm /etc/at.deny
echo -e "${IYellow}Garantindo que cron.deny e at.deny sejam removidos${NC}" | tee -a /var/log/$FILE
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
fi
echo -e "${IYellow}Configurando as permissões sejam configuradas corretamente${NC}" | tee -a /var/log/$FILE
chmod og-rwx /etc/{cron.allow,at.allow}
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
fi
chown root:root /etc/{cron.allow,at.allow}
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
fi
