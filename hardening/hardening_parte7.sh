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

echo -e "${IYellow}Configurando dias para expiração de senha${NC}" | tee -a /var/log/$FILE
sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS   90' /etc/login.defs
cat /etc/login.defs  | grep "PASS_MAX_DAYS   90"
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Configurando tamanho mínimo de senha${NC}" | tee -a /var/log/$FILE
sed -i '/^PASS_MIN_LEN/ c\PASS_MIN_LEN    10' /etc/login.defs
grep PASS_MIN_LEN /etc/login.defs
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Configurando número mínimo de dias para trocar as senhas${NC}" | tee -a /var/log/$FILE
sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS    0' /etc/login.defs
grep PASS_MIN_DAYS /etc/login.defs
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Desabilitando a conta Root${NC}" | tee -a /var/log/$FILE
usermod -L root
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Desabilitando contas de Sistema${NC}" | tee -a /var/log/$FILE
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

echo -e "${IYellow}Defina Grupo Padrão para conta root${NC}" | tee -a /var/log/$FILE
usermod –g 0 root
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


echo -e "${IYellow}Travando Contas de Usuários Inativos${NC}" | tee -a /var/log/$FILE
useradd -D -f 35
