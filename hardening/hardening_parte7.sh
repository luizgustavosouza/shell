#!/bin/bash
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
BBlue='\033[1;34m'        # Blue
NC='\033[0m'       # Text Reset

touch /var/log/hardening
echo -e "${BBlue}Aplicando hardening no $(hostname)${NC}"  | tee -a /var/log/hardening_$(hostname)


echo -e "${IYellow}Configure o protocolo SSH para 2${NC}" | tee -a /var/log/hardening_$(hostname)
sed 's/'
