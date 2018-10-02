#!/bin/bash
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
BBlue='\033[1;34m'        # Blue
NC='\033[0m'       # Text Reset
FILE=hardening_$(hostname).log


touch /var/log/$FILE
echo -e "${BBlue}Aplicando hardening no $(hostname)${NC}"  | tee -a /var/log/$FILE

echo -e "${IYellow}Mantendo informações de auditorias${NC}"
sed 's/max_log_file_action = ROTATE/max_log_file_action = keep_logs/g' /etc/audit/auditd.conf | tee -a /var/log/$FILE
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Habilite o serviço auditd${NC}"
systemctl is-enabled auditd
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  systemctl enable auditd | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Habilite auditoria para processos que comecem antes do auditd${NC}" | tee -a /var/log/$FILE
cp /etc.default/grub /etc/default/grub.bkp
cp ./grub.tpl /etc/default/grub
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi

echo -e "${IYellow}Atualizando configuração do grub${NC}" | tee -a /var/log/$FILE
grub2-mkconfig –o /boot/grub2/grub.cfg
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Configurando o auditd${NC}" | tee -a /var/log/$FILE
cp ./audit.rules.tpl /etc/audit.rules
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi

#Tempo de execução Gigante!!!
#echo -e "${IYellow}Coletando o uso de comandos privilegiados${NC}" | tee -a /var/log/$FILE
#find / -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged" }' | tee -a /etc/audit/rules.d/audit.rules


echo -e "${IYellow}Reiniciando o auditd${NC}" | tee -a /var/log/$FILE
pkill –P 1 –HUP auditd
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi
