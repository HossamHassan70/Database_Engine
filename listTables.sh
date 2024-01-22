#!/usr/bin/bash
clear
if [ -z "$(ls -A .)" ]; then
    echo -e "\e[34m---------------------- Tables List -------------------------\e[0m"
    echo -e "\e[93mThere aren't tables available right now ...\e[0m"
    echo -e "\e[34m------------------------------------------------------------\e[0m"
    . tableMenu.sh
else
    echo -e "\e[34m---------------------- Tables List -------------------------\e[0m"
    ls -p . | grep -v /
    echo -e "\e[34m------------------------------------------------------------\e[0m"
    . tableMenu.sh
fi
