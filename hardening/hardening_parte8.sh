#!/bin/bash

IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
NC='\033[0m'       		  # Text Reset

HOST=$(hostname)
SETOR='8'
FILE="hardening_$HOST_$SETOR.log"

# Parte 8 do hardening Linux

# Banners e Alertas

echo -e "${IYellow}Configurando banner de alerta para serviços de ligin padrão...${NC}" | tee -a /var/log/$FILE
RES=$(ls -lh /etc/motd | awk -F " " '{print $1 $3 $3}')

if [[ $RES != '-rw-r--r--. root root' ]]; then
 touch /etc/motd
 echo 'This is a private commercial server residing on a private commercial network which is operated within the jurisdiction of The United States of America. This server and network are the property of Stone Co. Although this server has been hardened and secured against unauthorized access, Users of this server (authorized or unauthorized) have no explicit or implicit expectation of communications privacy. Any and all access to this system and all files on this system are monitored for security purposes and may be intercepted, monitored, recorded, copied, audited and inspected to maintain server and network security. A ttempts to breach this system or network security may be disclosed to authorized local, state, and federal law enforcement personnel, and to authorized of ficials of other government agencies, as required. By using this server, the user consents to such interception, monitoring, recording, copying, auditing, inspection, and disclosure at the discretion of Stone Co. or Law Enforcement personnel. Unauthorized or improper use of this system may result in administrative disciplinary action or civil and criminal penalties. By continuing to use this system you indicate your awareness of and consent to these terms and conditions of use.

LOG OFF NOW if you do not agree to these conditions of use!' > /etc/motd
 chown root:root /etc/motd && chmod 644 /etc/motd
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando banner de alerta para serviços de ligin padrão...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando banner de alerta para serviços de ligin padrão...${NC}" | tee -a /var/log/$FILE
RES=$(ls -lh /etc/issue | awk -F " " '{print $1 $3 $3}')

if [[ $RES != '-rw-r--r--. root root' ]]; then
 touch /etc/issue
 echo 'This is a private commercial server residing on a private commercial network which is operated within the jurisdiction of The United States of America. This server and network are the property of Stone Co. Although this server has been hardened and secured against unauthorized access, Users of this server (authorized or unauthorized) have no explicit or implicit expectation of communications privacy. Any and all access to this system and all files on this system are monitored for security purposes and may be intercepted, monitored, recorded, copied, audited and inspected to maintain server and network security. A ttempts to breach this system or network security may be disclosed to authorized local, state, and federal law enforcement personnel, and to authorized of ficials of other government agencies, as required. By using this server, the user consents to such interception, monitoring, recording, copying, auditing, inspection, and disclosure at the discretion of Stone Co. or Law Enforcement personnel. Unauthorized or improper use of this system may result in administrative disciplinary action or civil and criminal penalties. By continuing to use this system you indicate your awareness of and consent to these terms and conditions of use.

LOG OFF NOW if you do not agree to these conditions of use!' > /etc/issue
 chown root:root /etc/issue && chmod 644 /etc/issue
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando banner de alerta para serviços de ligin padrão...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando banner de alerta para serviços de ligin padrão...${NC}" | tee -a /var/log/$FILE
RES=$(ls -lh /etc/issue.net | awk -F " " '{print $1 $3 $3}')

if [[ $RES != '-rw-r--r--. root root' ]]; then
 touch /etc/issue.net
 echo 'This is a private commercial server residing on a private commercial network which is operated within the jurisdiction of The United States of America. This server and network are the property of Stone Co. Although this server has been hardened and secured against unauthorized access, Users of this server (authorized or unauthorized) have no explicit or implicit expectation of communications privacy. Any and all access to this system and all files on this system are monitored for security purposes and may be intercepted, monitored, recorded, copied, audited and inspected to maintain server and network security. A ttempts to breach this system or network security may be disclosed to authorized local, state, and federal law enforcement personnel, and to authorized of ficials of other government agencies, as required. By using this server, the user consents to such interception, monitoring, recording, copying, auditing, inspection, and disclosure at the discretion of Stone Co. or Law Enforcement personnel. Unauthorized or improper use of this system may result in administrative disciplinary action or civil and criminal penalties. By continuing to use this system you indicate your awareness of and consent to these terms and conditions of use.

LOG OFF NOW if you do not agree to these conditions of use!' > /etc/issue.net
 chown root:root /etc/issue.net && chmod 644 /etc/issue.net
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando banner de alerta para serviços de ligin padrão...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Removendo informações de SO de banners e alertas de login...${NC}" | tee -a /var/log/$FILE
RES=$(egrep '(\\v|\\r|\\m|\\s)' /etc/motd)

if [[ $RES -eq '1' ]]; then
 echo -e "Removendo informações de SO de banners e alertas de login MOTD...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 echo -e "Removendo informações de SO de banners e alertas de login MOTD...${IRed}ERROR${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Removendo informações de SO de banners e alertas de login...${NC}" | tee -a /var/log/$FILE
RES=$(egrep '(\\v|\\r|\\m|\\s)' /etc/issue)

if [[ $RES -eq '1' ]]; then
 echo -e "Removendo informações de SO de banners e alertas de login ISSUE...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 echo -e "Removendo informações de SO de banners e alertas de login ISSUE...${IRed}ERROR${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Removendo informações de SO de banners e alertas de login...${NC}" | tee -a /var/log/$FILE
RES=$(egrep '(\\v|\\r|\\m|\\s)' /etc/issue.net)

if [[ $RES -eq '1' ]]; then
 echo -e "Removendo informações de SO de banners e alertas de login ISSUE.NET...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 echo -e "Removendo informações de SO de banners e alertas de login ISSUE.NET...${IRed}ERROR${NC}" | tee tee -a /var/log/$FILE
fi
