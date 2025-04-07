#!/bin/bash
clear
pkill -f ws-epro
echo Installing ws-epro
sleep 1
cd

#Install ws-epro
wget https://raw.githubusercontent.com/Truxy33/SS/main/ws-epro -O /usr/local/bin/ws-epro && chmod +x /usr/local/bin/ws-epro

#ws-epro service
wget https://raw.githubusercontent.com/Truxy33/SS/main/ws-epro.service -O /etc/systemd/system/ws-epro.service && chmod +x /etc/systemd/system/ws-epro.service

#ws-epro port
wget https://raw.githubusercontent.com/Truxy33/SS/main/port -O /usr/bin/ws-port && chmod +x /usr/bin/ws-port

#seting port
clear
echo setting port ws-epro
sleep 1
read -p "Target Port : " openssh
read -p "Listen Port : " wsopenssh
WS_DIR=/usr/local/etc/ws-epro
if [ -d "$WS_DIR" ]; then # if it exists,delete it.
    rm -rf "$WS_DIR"
fi
mkdir "$WS_DIR"
echo "Procesing to server..."
sleep 0.5
echo "# verbose level 0=info, 1=verbose, 2=very verbose" >> /usr/local/etc/ws-epro/config.yml
echo "verbose: 0" >> /usr/local/etc/ws-epro/config.yml
echo "listen:"  >> /usr/local/etc/ws-epro/config.yml

#seting port
echo "##openssh" >> /usr/local/etc/ws-epro/config.yml
echo "- target_host: 127.0.0.1" >> /usr/local/etc/ws-epro/config.yml
echo "##portopenssh" >> /usr/local/etc/ws-epro/config.yml
echo "  target_port: $openssh" >> /usr/local/etc/ws-epro/config.yml
echo "##wsopenssh" >> /usr/local/etc/ws-epro/config.yml
echo "  listen_port: $wsopenssh" >> /usr/local/etc/ws-epro/config.yml

chmod +x /usr/local/etc/ws-epro/config.yml

#Enable & Start service
systemctl enable ws-epro
systemctl start ws-epro

echo "Configuration to server..."
sleep 0.3
clear
LP='\033[1;35m'
NC='\033[0m' # No Color
echo -e "${LP}"
echo    "=========== Detail ws-epro ============"
echo    "---------------------------------------"
echo    "   Target Port : $openssh"
echo    "   Listen Port: $wsopenssh"
echo    "---------------------------------------"
echo    ""
echo    "To change port:  ws-port"
echo -e "${NC}"
rm -rf install-ws && cat /dev/null > ~/.bash_history && history -c
