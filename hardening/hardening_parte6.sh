#!/bin/bash

IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
NC='\033[0m'       # Text Reset

HOST=$(hostname)
SETOR='6'
FILE="hardening_$HOST_$SETOR.log"

# Parte 6 do hardening Linux

touch /var/log/$FILE

# CONFIGURANDO O AT E O CRON

echo -e "${IYellow}Instalando o cronie-anacron...${NC}" | tee -a /var/log/$FILE
RES=$(rpm -qa cronie-anacron)

if [[ $RES != '' ]]; then
 echo -e "Instalando o cronie-anacron...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 yum install -y cronie-anacron
 if [[ $? -eq 0 ]]; then
  echo -e "Instalando o cronie-anacron...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Ativando o serviço Crond...${NC}" | tee -a /var/log/$FILE
RES=$(systemctl is-enabled crond)

if [[ $RES = 'enabled' ]]; then
 echo -e "Serviço Crond ativado...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 systemctl enable crond
 if [[ $? -eq 0 ]]; then
  echo -e "Serviço Crond ativado...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando os Usuários/Dono de Grupo e as permissões de /etc/anacrontab...${NC}" | tee -a /var/log/$FILE
RES=$(stat -L -c "%a %u %g" /etc/anacrontab | egrep ".00 0 0")

if [[ $RES != '' ]]; then
 echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/anacrontab...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chown root:root /etc/anacrontab && chmod og-rwx /etc/anacrontab
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/anacrontab...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando os Usuários/Dono de Grupo e as permissões de /etc/crontab...${NC}" | tee -a /var/log/$FILE
RES=$(stat -L -c "%a %u %g" /etc/crontab | egrep ".00 0 0")

if [[ $RES != '' ]]; then
 echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/crontab...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chown root:root /etc/crontab && chmod og-rwx /etc/crontab
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/crontab...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.hourly...${NC}" | tee -a /var/log/$FILE
RES=$(stat -L -c "%a %u %g" /etc/cron.hourly | egrep ".00 0 0")

if [[ $RES != '' ]]; then
 echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.hourly...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chown root:root /etc/cron.hourly && chmod og-rwx /etc/cron.hourly
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.hourly...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.daily...${NC}" | tee -a /var/log/$FILE
RES=$(stat -L -c "%a %u %g" /etc/cron.daily | egrep ".00 0 0")

if [[ $RES != '' ]]; then
 echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.daily...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chown root:root /etc/cron.daily && chmod og-rwx /etc/cron.daily
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.daily...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.weekly...${NC}" | tee -a /var/log/$FILE
RES=$(stat -L -c "%a %u %g" /etc/cron.weekly | egrep ".00 0 0")

if [[ $RES != '' ]]; then
 echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.weekly...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chown root:root /etc/cron.weekly && chmod og-rwx /etc/cron.weekly
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.weekly...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.monthly...${NC}" | tee -a /var/log/$FILE
RES=$(stat -L -c "%a %u %g" /etc/cron.monthly | egrep ".00 0 0")

if [[ $RES != '' ]]; then
 echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.monthly...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chown root:root /etc/cron.monthly && chmod og-rwx /etc/cron.monthly
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.monthly...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.d...${NC}" | tee -a /var/log/$FILE
RES=$(stat -L -c "%a %u %g" /etc/cron.d | egrep ".00 0 0")

if [[ $RES != '' ]]; then
 echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.d...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chown root:root /etc/cron.d && chmod og-rwx /etc/cron.d
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando os Usuários/Dono de Grupo e as permissões de /etc/cron.d...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Restringindo o daemon at...${NC}" | tee -a /var/log/$FILE
stat -L /etc/at.deny > /dev/null
if [[ $? -eq 0 ]]; then
 rm -rf /etc/at.deny
 echo -e "Restringindo o daemon at...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

RES=$(stat -L -c "%a %u %g" /etc/at.allow | egrep ".00 0 0")

if [[ $RES != '' ]]; then
 echo -e "Restringindo o daemon at...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 touch /etc/at.allow && chown root:root /etc/at.allow && chmod og-rwx /etc/at.allow
 if [[ $? -eq 0 ]]; then
  echo -e "Restringindo o daemon at...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Restringindo o daemon cron.deny...${NC}" | tee -a /var/log/$FILE
ls -l /etc/cron.deny

if [[ $? -eq 0 ]]; then
 echo -e "Restringindo o daemon cron.deny...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 rm -rf /etc/cron.deny
 if [[ $? -eq 0 ]]; then
  echo -e "Restringindo o daemon cron.deny...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Restringindo o daemon at.deny...${NC}" | tee -a /var/log/$FILE
ls -l /etc/at.deny

if [[ $? -eq 0 ]]; then
 echo -e "Restringindo o daemon at.deny...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 rm -rf /etc/at.deny
 if [[ $? -eq 0 ]]; then
  echo -e "Restringindo o daemon at.deny...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Restringindo o daemon cron.allow...${NC}" | tee -a /var/log/$FILE
RES=$(ls -l /etc/cron.allow | awk -F " " '{print $1" "$3" "$4}')

if [[ $RES = '-rw------- root root' ]]; then
 echo -e "Restringindo o daemon cron.allow...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chmod og-rwx /etc/cron.allow && chown root:root /etc/cron.allow
 if [[ $? -eq 0 ]]; then
  echo -e "Restringindo o daemon cron.allow...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Restringindo o daemon at.allow...${NC}" | tee -a /var/log/$FILE
RES=$(ls -l /etc/at.allow | awk -F " " '{print $1" "$3" "$4}')

if [[ $RES = '-rw------- root root' ]]; then
 echo -e "Restringindo o daemon at.allow...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chmod og-rwx /etc/at.allow && chown root:root /etc/at.allow
 if [[ $? -eq 0 ]]; then
  echo -e "Restringindo o daemon at.allow...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

# CONFIGURANDO O SSHD

echo -e "${IYellow}Configurando o protocolo SSH para 2...${NC}" | tee -a /var/log/$FILE
RES=$(grep "Protocol" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != '2' ]]; then
 sed -i '\/^Protocol/c\Protocol 2' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o protocolo SSH para 2...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o LogLevel SSH para INFO...${NC}" | tee -a /var/log/$FILE
RES=$(grep "LogLevel" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != 'INFO' ]]; then
 sed -i '\/^LogLevel/c\LogLevel INFO' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o LogLevel SSH para INFO...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando permissões de /etc/ssh/sshd_config...${NC}" | tee -a /var/log/$FILE
RES=$(ls -l /etc/ssh/sshd_config | awk -F " " '{print $1" "$3" "$4}')

if [[ $RES = '-rw------- root root' ]]; then
 echo -e "Configurando permissões de /etc/ssh/sshd_config...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
else
 chmod 600 /etc/ssh/sshd_config && chown root:root /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando permissões de /etc/ssh/sshd_config...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o X11Forwarding SSH para no...${NC}" | tee -a /var/log/$FILE
RES=$(grep "X11Forwarding" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != 'no' ]]; then
 sed -i '\/^X11Forwarding/c\X11Forwarding no' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o X11Forwarding SSH para no...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o MaxAuthTries SSH para 4...${NC}" | tee -a /var/log/$FILE
RES=$(grep "MaxAuthTries" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != '4' ]]; then
 sed -i '\/^MaxAuthTries/c\MaxAuthTries 4' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o MaxAuthTries SSH para 4...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o IgnoreRhosts SSH para yes...${NC}" | tee -a /var/log/$FILE
RES=$(grep "IgnoreRhosts" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != 'yes' ]]; then
 sed -i '\/^IgnoreRhosts/c\IgnoreRhosts yes' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o IgnoreRhosts SSH para yes...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o HostbasedAuthentication SSH para no...${NC}" | tee -a /var/log/$FILE
RES=$(grep "HostbasedAuthentication" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != 'no' ]]; then
 sed -i '\/^HostbasedAuthentication/c\HostbasedAuthentication no' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o HostbasedAuthentication SSH para no...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o PermitRootLogin SSH para no...${NC}" | tee -a /var/log/$FILE
RES=$(grep "PermitRootLogin" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != 'no' ]]; then
 sed -i '\/^PermitRootLogin/c\PermitRootLogin no' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o PermitRootLogin SSH para no...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o PermitEmptyPasswords SSH para no...${NC}" | tee -a /var/log/$FILE
RES=$(grep "PermitEmptyPasswords" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != 'no' ]]; then
 sed -i '\/^PermitEmptyPasswords/c\PermitEmptyPasswords no' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o PermitEmptyPasswords SSH para no...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o PermitUserEnvironment SSH para no...${NC}" | tee -a /var/log/$FILE
RES=$(grep "PermitUserEnvironment" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES != 'no' ]]; then
 sed -i '\/^PermitUserEnvironment/c\PermitUserEnvironment no' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o PermitUserEnvironment SSH para no...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando as Cifras SSH...${NC}" | tee -a /var/log/$FILE
RES=$(grep "Ciphers" /etc/ssh/sshd_config)

if [[ $RES = '' ]]; then
 echo 'Ciphers aes128-ctr,aes192-ctr,aes256-ctr' >> /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando as Cifras SSH...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o ClientAliveInterval SSH...${NC}" | tee -a /var/log/$FILE
RES=$(grep "ClientAliveInterval" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES = '300' ]]; then
 echo 'ClientAliveInterval 300' >> /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o ClientAliveInterval SSH...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o ClientAliveCountMax SSH...${NC}" | tee -a /var/log/$FILE
RES=$(grep "ClientAliveCountMax" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES = '0' ]]; then
 echo 'ClientAliveCountMax 0' >> /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o ClientAliveCountMax SSH...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o AllowUsers SSH...${NC}" | tee -a /var/log/$FILE
RES=$(grep "AllowUsers" /etc/ssh/sshd_config)

if [[ $RES = '' ]]; then
 echo '#AllowUsers' >> /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o AllowUsers SSH...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o AllowGroups SSH...${NC}" | tee -a /var/log/$FILE
RES=$(grep "AllowGroups" /etc/ssh/sshd_config)

if [[ $RES = '' ]]; then
 echo '#AllowGroups' >> /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o AllowGroups SSH...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o DenyUsers SSH...${NC}" | tee -a /var/log/$FILE
RES=$(grep "DenyUsers" /etc/ssh/sshd_config)

if [[ $RES = '' ]]; then
 echo '#DenyUsers' >> /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o DenyUsers SSH...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o DenyGroups SSH...${NC}" | tee -a /var/log/$FILE
RES=$(grep "DenyGroups" /etc/ssh/sshd_config)

if [[ $RES = '' ]]; then
 echo '#DenyGroups' >> /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o DenyGroups SSH...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o Banner SSH...${NC}" | tee -a /var/log/$FILE
RES=$(grep "Banner" /etc/ssh/sshd_config | awk -F " " '{print $2}')

if [[ $RES = '' ]]; then
 sed -i '\/^Banner/c\Banner /etc/issue.net' /etc/ssh/sshd_config
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando o Banner SSH...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

# Configure PAM

echo -e "${IYellow}Configurando a criptografia de senha para sha512...${NC}" | tee -a /var/log/$FILE
RES=$(authconfig --test | grep hashing | grep sha512 | awk -F " " '{print $5}')

if [[ $RES != 'sha512' ]]; then
 authconfig --passalgo=sha512 --update
 cat /etc/passwd | awk -F: '( $3 >=1000 && $1 != "nfsnobody" ) { print $1 }' | xargs -n 1 chage -d 0
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando a criptografia de senha para sha512...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando o requerimento de complexidade de senha...${NC}" | tee -a /var/log/$FILE
RES=$(grep pam_pwquality.so /etc/pam.d/system-auth)

if [[ $RES != 'password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=' ]]; then
 echo $RES >> /var/log/$FILE
fi

if [[ $(grep "minlen" /etc/security/pwquality.conf | awk -F= '{print $2}') != '10' ]]; then
 sed -i '\/^minlen/c\minlen=10' /etc/security/pwquality.conf
 echo -e "Minlen = 10 configurado...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

if [[ $(grep "dcredit" /etc/security/pwquality.conf | awk -F= '{print $2}') != '2' ]]; then
 sed -i '\/^dcredit/c\dcredit=2' /etc/security/pwquality.conf
 echo -e "Dcredit = 2 configurado...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

if [[ $(grep "ucredit" /etc/security/pwquality.conf | awk -F= '{print $2}') != '2' ]]; then
 sed -i '\/^ucredit/c\ucredit=2' /etc/security/pwquality.conf
 echo -e "Ucredit = 2 configurado...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

if [[ $(grep "ocredit" /etc/security/pwquality.conf | awk -F= '{print $2}') != '2' ]]; then
 sed -i '\/^ocredit/c\ocredit=-1' /etc/security/pwquality.conf
 echo -e "Ocredit = -1 configurado...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

if [[ $(grep "lcredit" /etc/security/pwquality.conf | awk -F= '{print $2}') != '2' ]]; then
 sed -i '\/^lcredit/c\lcredit=-1' /etc/security/pwquality.conf
 echo -e "Lcredit = -1 configurado...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

if [[ $? -eq 0 ]]; then
 echo -e "Configurando o requerimento de complexidade de senha...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "pam_faillock" /etc/pam.d/password-auth | grep preauth)

if [[ $RES != 'auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900' ]]; then
 echo "auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900" >> /etc/pam.d/password-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "pam_faillock" /etc/pam.d/password-auth | grep authfail)

if [[ $RES != 'auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900' ]]; then
 echo 'auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900' >> /etc/pam.d/password-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "pam_faillock" /etc/pam.d/password-auth | grep authsucc)

if [[ $RES != 'auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900' ]]; then
 echo 'auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900' >> /etc/pam.d/password-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "pam_unix.so" /etc/pam.d/password-auth | grep success=1)

if [[ $RES != 'auth [success=1 default=bad] pam_unix.so' ]]; then
 echo 'auth [success=1 default=bad] pam_unix.so' >> /etc/pam.d/password-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "pam_faillock" /etc/pam.d/system-auth | grep preauth)

if [[ $RES != 'auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900' ]]; then
 echo 'auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900' >> /etc/pam.d/system-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "pam_faillock" /etc/pam.d/system-auth | grep authfail)

if [[ $RES != 'auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900' ]]; then
 echo 'auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900' >> /etc/pam.d/system-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "pam_faillock" /etc/pam.d/system-auth | grep authsucc)

if [[ $RES != 'auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900' ]]; then
 echo 'auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900' >> /etc/pam.d/system-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "pam_unix.so" /etc/pam.d/system-auth | grep success=1)

if [[ $RES != 'auth [success=1 default=bad] pam_unix.so' ]]; then
 echo 'auth [success=1 default=bad] pam_unix.so' >> /etc/pam.d/password-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Configurando Lockout para tentativas falhas de senhas...${NC}" | tee -a /var/log/$FILE
RES=$(grep "remember" /etc/pam.d/system-auth)

if [[ $RES != 'password    sufficient    pam_unix.so remember=5' ]]; then
 echo 'password    sufficient    pam_unix.so remember=5' >> /etc/pam.d/system-auth
 if [[ $? -eq 0 ]]; then
  echo -e "Configurando Lockout para tentativas falhas de senhas...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Restringindo o acesso ao comando SU...${NC}" | tee -a /var/log/$FILE
RES=$(grep pam_wheel.so /etc/pam.d/su)

if [[ $RES != 'auth required pam_wheel.so use_uid' ]]; then
 echo 'auth required pam_wheel.so use_uid' >> /etc/pam.d/su
 if [[ $? -eq 0 ]]; then
  echo -e "Restringindo o acesso ao comando SU...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi

echo -e "${IYellow}Restringindo o acesso ao comando SU...${NC}" | tee -a /var/log/$FILE
RES=$(grep wheel /etc/group)

if [[ $RES != 'wheel:x:10:' ]]; then
 echo $RES >> /var/log/$FILE
 if [[ $? -eq 0 ]]; then
  echo -e "Restringindo o acesso ao comando SU...${IGreen}OK${NC}" | tee tee -a /var/log/$FILE
 fi
fi
