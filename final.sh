instalador_final() {
  tput cuu1 && tput dl1
  tput cuu1 && tput dl1
  echo -e "     \033[1;4;32mLA KEY ES VALIDA FINALIZANDO INSTALACION \033[0;39m"
  ##-->> ACOPLANDO INSTALL EN /BIN
  wget /root/LATAM https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Instalador/LATAM -O /usr/bin/LATAM &>/dev/null
  chmod +x /usr/bin/LATAM
  ##-->> LIMPIAR BASHRC
  /bin/cp /etc/skel/.bashrc ~/
  ##-->> DESCARGAR FICHEROS
  cd /etc
  wget https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/SCRIPT-LATAM.tar.gz >/dev/null 2>&1
  tar -xf SCRIPT-LATAM.tar.gz >/dev/null 2>&1
  chmod +x SCRIPT-LATAM.tar.gz >/dev/null 2>&1
  rm -rf SCRIPT-LATAM.tar.gz
  cd
  ### INSTALAR VERSION DE SCRIPT
  v1=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Version")
  echo "$v1" >/etc/SCRIPT-LATAM/temp/version_instalacion
  FIns=$(printf '%(%D-%H:%M:%S)T')
  echo "$FIns" >/etc/SCRIPT-LATAM/F-Instalacion
  last_check_file="/etc/SCRIPT-LATAM/temp/last_check"
  date "+%Y-%m-%d %H:%M:%S" >"$last_check_file"
  wget -O /bin/rebootnb https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Ejecutables/rebootnb.sh &>/dev/null
  chmod +x /bin/rebootnb
  wget -O /bin/autoinicios https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Ejecutables/autoinicios &>/dev/null
  chmod +rwx /bin/autoinicios
  wget -O /etc/systemd/system/iniciolatam.service https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Ejecutables/iniciolatam.service &>/dev/null
  sudo systemctl enable -q iniciolatam.service
  wget -O /bin/check-update https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Ejecutables/check-update &>/dev/null
  chmod +rwx /bin/check-update
  wget -O /etc/SCRIPT-LATAM/temp/version_actual https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Version &>/dev/null
   echo '#!/bin/sh -e' >/etc/rc.local
    sudo chmod +x /etc/rc.local
    echo "sudo rebootnb reboot" >>/etc/rc.local
    echo "sleep 2s" >>/etc/rc.local
    echo "exit 0" >>/etc/rc.local
  msgi -bar2
  echo 'clear && clear' >>.bashrc
  echo 'rebootnb login >/dev/null 2>&1' >>.bashrc
  echo 'echo -e "\033[1;31m————————————————————————————————————————————————————" ' >>.bashrc
  echo 'echo -e "\033[1;93m════════════════════════════════════════════════════" ' >>.bashrc
  echo 'sudo figlet -w 85 -f smslant "         SCRIPT
         LATAM"   | lolcat' >>.bashrc
  echo 'echo -e "\033[1;93m════════════════════════════════════════════════════" ' >>.bashrc
  echo 'echo -e "\033[1;31m————————————————————————————————————————————————————" ' >>.bashrc
  echo 'mess1="$(less -f /etc/SCRIPT-LATAM/message.txt)" ' >>.bashrc
  echo 'echo "" ' >>.bashrc
  echo 'echo -e "\033[92m  -->> SLOGAN:\033[93m $mess1 "' >>.bashrc
  echo 'echo "" ' >>.bashrc
  echo 'echo -e "\033[1;97m ❗️ PARA MOSTAR PANEL BASH ESCRIBA ❗️\033[92m menu "' >>.bashrc
  echo 'wget -O /etc/SCRIPT-LATAM/temp/version_actual https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Version &>/dev/null' >>.bashrc
  echo 'echo ""' >>.bashrc
  echo "${SCPdir}/menu.sh" >/usr/bin/menu && chmod +x /usr/bin/menu
  echo "${SCPdir}/menu.sh" >/usr/bin/MENU && chmod +x /usr/bin/MENU
  echo "$Key" >${SCPdir}/key.txt
  #-BASH SOPORTE ONLINE
  wget https://raw.githubusercontent.com/NetVPS/LATAM_Oficial/main/Fixs%20Remotos/SPR.sh -O /usr/bin/SPR >/dev/null 2>&1
  chmod +x /usr/bin/SPR
  SPR >/dev/null 2>&1
  timeespera="1"
  times="10"
  if [ "$timeespera" = "1" ]; then
    echo -e "\033[1;97m        ❗️ REGISTRANDO IP y KEY EN LA BASE ❗️            "
    msgi -bar2
    while [ $times -gt 0 ]; do
      echo -ne "                         -$times-\033[0K\r"
      sleep 1
      : $((times--))
    done
    tput cuu1 && tput dl1
    tput cuu1 && tput dl1
    tput cuu1 && tput dl1
    msgi -bar2
    echo -e " \033[1;93m              LISTO REGISTRO COMPLETO "
    echo -e " \033[1;97m       COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
    echo -e "                   \033[1;41m  menu o MENU  \033[0;37m                 " && msgi -bar2
  fi
  meu_ip() {
    if [[ -e /tmp/IP ]]; then
      echo "$(cat /tmp/IP)"
    else
      MEU_IP=$(wget -qO- ipinfo.io/ip || wget -qO- ifconfig.me)
      echo "$MEU_IP" >/tmp/IP
    fi
  }
  meu_ip &>/dev/null
  exit
}