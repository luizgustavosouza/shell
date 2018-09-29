#!/bin/bash
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
BBlue='\033[1;34m'        # Blue
NC='\033[0m'       # Text Reset


#Iniciando Escrita de Relatório
touch /var/log/hardening_$(hostname)
echo -e "${BBlue}Aplicando hardening no $(hostname)${NC}"  | tee -a /var/log/hardening_$(hostname)

#Daemon anacron
echo -e "${IYellow}Instalando anacron...${NC}" | tee -a /var/log/hardening_$(hostname)
rpm -q cronie-anacron
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}Pacote já Instalado${NC}" | tee -a /var/log/hardening_$(hostname)
else
  yum install cronie-anacron -y
  if [[ $? -eq 0 ]]; then
     echo -e "${IGreen}Pacote Instalado${NC}" | tee -a /var/log/hardening_$(hostname)
  fi
fi


#Habilitando Crond
echo -e "${IYellow}Habilitando Crond...${NC}" | tee -a /var/log/hardening_$(hostname)
systemctl is-enabled crond
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}Serviço já habilitado${NC}" | tee -a /var/log/hardening_$(hostname)
else
  systemctl enable crond ; echo -e "${IGreen}Serviço habilitado${NC}" | tee -a /var/log/hardening_$(hostname)
fi


# Configurando os Usuários/Dono de Grupo e as permissões de /etc/anacrontab
echo -e "${IYellow}Configurando os Usuários/Dono de Grupo ${NC}" | tee -a /var/log/hardening_$(hostname)
chown root:root /etc/cron.*
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/hardening_$(hostname)
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/hardening_$(hostname)
fi


echo -e "${IYellow}Configurando as permissões${NC}" | tee -a /var/log/hardening_$(hostname)
chmod og-rwx /etc/cron.*
if [[ $? -eq 0 ]]; then
   echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/hardening_$(hostname)
else
 echo -e "${IRed}FAIL${NC}" | tee -a /var/log/hardening_$(hostname)
fi


#Restringindo daemon at
echo -e "${IYellow}Configurando os Usuários/Dono de Grupo ${NC}" | tee -a /var/log/hardening_$(hostname)
