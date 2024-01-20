#!/usr/bin/bash
clear
echo -e "\e[34m---------------------- Tables List -------------------------\e[0m"
ls -p | grep -v / 
echo -e "\e[34m------------------------------------------------------------\e[0m"
cd ../../
. table-menu.sh