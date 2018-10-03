#!/bin/bash
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
BBlue='\033[1;34m'        # Blue
NC='\033[0m'       # Text Reset
FILE=hardening_$(hostname).log
#Iniciando Escrita de Relatório


echo -e "${BBlue}Hardening Services no $(hostname)${NC}"  | tee -a /var/log/$FILE

#umask
echo -e "${IYellow}Configure o daemon 'umask'...${NC}" | tee -a /var/log/$FILE
echo 'umask 027' > /etc/sysconfig/init | tee -a /var/log/$FILE
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo  -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


#X Window
echo -e "${IYellow}Removendo o 'X Window System'...${NC}" | tee /var/log/$FILE
cd /etc/system/system/ 
unlink default.target 
ln -s /usr/lib/system?system/multi-user.target defaul.target
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
else
  echo  -e "${IRed}FAIL${NC}" | tee -a /var/log/$FILE
fi


#Removendo Pacotes Desnecessários
echo -e "${IYellow}Removendo Pacotes...${NC}" | tee -a /var/log/$FILE
for package in $(cat packages_remove.txt); do
  rpm -q $package >> /var/log/$FILE
  if [[ $? -eq 1 ]]; then
    echo -e "${IGreen}Pacote Não Instalado${NC}" | tee -a /var/log/$FILE
  else
    yum remove $package -y 2>&1 | tee -a /var/log/hardening_$(hostname) ; echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/$FILE
  fi
done


#Desabilitando Serviços Desnecessários
echo -e "${IYellow}Desabilitando Serviços${NC}" | tee -a /var/log/$FILE
for service in $(cat services_disable.txt);do
  systemctl is-enabled $service
  if [[ $? -eq 0 ]]; then
    echo -e "${IRed}Serviço $service habilitado${NC}" | tee -a /var/log/$FILE
    systemctl disable $service
  elif [[ $? -eq 1 ]]; then
    echo -e "${IGreen}Serviço $service desabilitado${NC}" | tee -a /var/log/$FILE
  fi
done
