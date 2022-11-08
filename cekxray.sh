#!/bin/bash
#########################

# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

MYIP=$(curl -sS ipv4.icanhazip.com)

clear
echo "${GREEN}Check Perizinan VPS!!!${NC}"
sleep 3

clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo "|----------=[ ${GREEN}XRAY USER LOGIN${NC} ]=---------|";
echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
log=$(tail -1 /var/log/xray/access.log | grep "$akun" | awk '{print $2}');
for login in "${log[@]}"
do
echo -n > /tmp/ipvmess.txt
data2=$(tail /var/log/xray/access.log | grep "$akun" | cut -d: -f3 | awk '{print $2}' | sort | uniq);
for ip in "${data2[@]}"
do
jum=$(tail /var/log/xray/access.log | grep "$akun" | awk '{print $3}' | cut -d: -f1 | grep "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo -e "${GREEN}User : $akun ${NC}";
echo -e "${RED}Last Login: $login${NC}"
echo "$jum2";
echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
fi
rm -rf /tmp/ipvmess.txt
done
done
oth=$(cat /tmp/other.txt | sort | uniq | nl)
echo "$oth";
echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{NC}"
rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
