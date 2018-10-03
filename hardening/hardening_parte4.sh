#!/bin/bash

IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
NC='\033[0m'       # Text Reset

HOST=$(hostname)
SETOR='4'
FILE="hardening_$HOST_$SETOR.log"

# Parte 4 do documento de hardening Linux

echo -e "${IYellow}Configurando o redirecionamento de IP...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.ip_forward = 0' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.ip_forward=0
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Redirecionamento de IP...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Configurando o redirecionamento de envio de pacotes...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.conf.all.send_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.send_redirects = 0' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.conf.all.send_redirects=0
/sbin/sysctl -w net.ipv4.conf.default.send_redirects=0
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Redirecionamento de envio de pacotes...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Desabilitando aceitação de pacotes fonte roteados...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.conf.all.accept_source_route = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.accept_source_route = 0' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.conf.all.accept_source_route=0
/sbin/sysctl -w net.ipv4.conf.default.accept_source_route=0
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Desabilitando aceitação de pacotes fonte roteados...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Desabilitando a aceitação de redirecionamento de ICMP...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.conf.all.accept_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.accept_redirects = 0' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.conf.all.accept_redirects=0
/sbin/sysctl -w net.ipv4.conf.default.accept_redirects=0
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Desabilitando a aceitação de redirecionamento de ICMP...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Desabilitando a aceitação de redirecionamento de ICMP modo Seguro...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.conf.all.secure_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.secure_redirects = 0' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.conf.all.secure_redirects=0
/sbin/sysctl -w net.ipv4.conf.default.secure_redirects=0
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Desabilitando a aceitação de redirecionamento de ICMP modo Seguro...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Habilitando log para pacotes suspeitos...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.conf.all.log_martians = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.log_martians = 1' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.conf.all.log_martians=1
/sbin/sysctl -w net.ipv4.conf.default.log_martians=1
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Habilitando log para pacotes suspeitos...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Habilitando Ignore Broadcast Requests...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.icmp_echo_ignore_broadcasts = 1' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Habilitando Ignore Broadcast Requests...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Habilitando Bad Error Message Protection...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.icmp_ignore_bogus_error_responses = 1' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Habilitando Bad Error Message Protection...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Habilitando RFC-recommended source route validation...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.conf.all.rp_filter = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.rp_filter = 1' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.conf.all.rp_filter=1
/sbin/sysctl -w net.ipv4.conf.default.rp_filter=1
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Habilitando RFC-recommended source route validation...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Habilitando Cookies TCP SYN...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv4.tcp_syncookies = 1' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv4.tcp_syncookies=1
/sbin/sysctl -w net.ipv4.route.flush=1

if [[ $? -eq 0 ]]; then
 echo -e "Habilitando Cookies TCP SYN...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Desabilitando O IPV6...${NC}" | tee -a /var/log/$FILE
echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
/sbin/sysctl -w net.ipv6.conf.all.disable_ipv6=1

if [[ $? -eq 0 ]]; then
 echo -e "Desabilitando O IPV6...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Instalando o TCP WRAPPERS...${NC}" | tee -a /var/log/$FILE
RES=$(rpm -aq tcp_wrappers)

if [[ $RES != '' ]]; then
 echo -e "Instalando o TCP WRAPPERS...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 yum install -y tcp_wrappers
 if [[ $? -eq 0 ]]; then
  echo -e "Instalando o TCP WRAPPERS...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando hosts.allow...${NC}" | tee -a /var/log/$FILE
if [[ -f '/etc/hosts.allow' ]]; then
 /bin/chmod 644 /etc/hosts.allow
 echo -e "Configurando hosts.allow...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 touch /etc/hosts.allow
 /bin/chmod 644 /etc/hosts.allow
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando hosts.allow...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando hosts.deny...${NC}" | tee -a /var/log/$FILE
if [[ -f '/etc/hosts.deny' ]]; then
 /bin/chmod 644 /etc/hosts.deny
 echo -e "Configurando hosts.deny...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 touch /etc/hosts.deny
 /bin/chmod 644 /etc/hosts.deny
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando hosts.deny...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Desabilitando o firewalld...${NC}" | tee -a /var/log/$FILE
systemctl disable firewalld

if [[ $? -eq 0 ]]; then
 echo -e "Desabilitando o firewalld...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

