#!bin/bash

IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
BBlue='\033[1;34m'        # Blue
NC='\033[0m'       # Text Reset

#Iniciando Escrita de Relatório
touch /var/log/hardening_$(hostname)

echo -e "${BBlue}Aplicando hardening no $(hostname)${NC}"  | tee -a /var/log/hardening_$(hostname)

#umask
echo "${IYellow}Configure o daemon 'umask'...${NC}" | tee -a /var/log/hardening_$(hostname)
echo 'umask 027' > /etc/sysconfig/init | tee -a /var/log/hardening_$(hostname)
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/hardening_$(hostname)
else
  echo  -e "${IRed}FAIL${NC}" | tee -a /var/log/hardening_$(hostname)
fi


#X Window
echo "${IYellow}Removendo o 'X Window System'...${NC}" | tee /var/log/hardening_$(hostname)
cd /etc/system/system/ ; unlink default.target ; ln –s /usr/lib/system?system/multi-user.target defaul.target
if [[ $? -eq 0 ]]; then
  echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/hardening_$(hostname)
else
  echo  -e "${IRed}FAIL${NC}" | tee -a /var/log/hardening_$(hostname)
fi


#Removendo Pacotes Desnecessários
echo -e "${IYellow}Removendo Pacotes...${NC}" | tee -a /var/log/hardening_$(hostname)
for package in $(cat packages_remove.txt); do
  rpm -q $package >> /var/log/hardening_$(hostname)
  if [[ $? -eq 1 ]]; then
    echo -e "${IGreen}Pacote Não Instalado${NC}" | tee -a /var/log/hardening_$(hostname)
  else
    yum remove $package 2>&1 | tee -a /var/log/hardening_$(hostname) ; echo -e "${IGreen}SUCESS${NC}" | tee -a /var/log/hardening_$(hostname)
  fi
done


#Desabilitando Serviços Desnecessários
echo "${IYellow}Desabilitando Serviços${NC}" | tee -a /var/log/hardening_$(hostname)
for service in $(cat services_disable.txt);do
  if [[ $? -eq 0 ]]; then
    echo -e "${IRed}Serviço $service habilitado${NC}" | tee -a /var/log/hardening_$(hostname)
  else
    systemctl disable $service ; echo -e "${IGreen}Serviço $service desabilitado${NC}" | tee -a /var/log/hardening_$(hostname)
  fi
done
