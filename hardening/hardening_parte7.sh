#!/bin/bash
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
BBlue='\033[1;34m'        # Blue
NC='\033[0m'       # Text Reset
FILE=/var/log/hardening_$(hostname).log


touch /var/log/$FILE
echo -e "${BBlue}Aplicando hardening no $(hostname)${NC}"  | tee -a /var/log/$FILE

echo -e "${IYellow}Configurando dias para expiração de senha${NC}" | tee -a /var/log/hardening_$(hostname)
sed 's/PASS_MAX_DAYS   99999"/"PASS_MAX_DAYS   90' /etc/login.defs






echo -e "${IYellow}Desabilitando a conta Root${NC}" | tee -a /var/log/hardening_$(hostname)
usermod -L root
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi

echo -e "${IYellow}Desabilitando contas de Sistema${NC}" | tee -a /var/log/hardening_$(hostname)
egrep -v "^\+" /etc/passwd | awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $3<1000 && $7!="/sbin/nologin") {print}'
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  for user in `awk -F: '($3 < 1000) {print $1 }' /etc/passwd`; do
    if [ $user != "root" ]
    then
        /usr/sbin/usermod -L $user
        if [ $user != "sync" ] && [ $user != "shutdown" ] && [ $user != "halt" ]
        then
            /usr/sbin/usermod -s /sbin/nologin $user
        fi
    fi
done
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
fi

echo -e "${IYellow}Defina Grupo Padrão para conta root${NC}" | tee -a /var/log/hardening_$(hostname)
usermod –g 0 root
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi
