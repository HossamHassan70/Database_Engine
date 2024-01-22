#!/usr/bin/bash
clear
echo -e "\e[34m---------------------- Drop Table -------------------------\e[0m"
ls -p | grep -v / 
echo -e "\e[34m-----------------------------------------------------------\e[0m"
read -p "Enter The Name Table Want to Drop (or '0' to back): " droptable
if [[ $droptable == "0" ]]; then
    clear
    . tableMenu.sh
fi
if [[ -f $droptable ]];then
    read -p "Are You Sure you want to delete [$droptable] (y/n)? " answer 
    if [[ $answer == [yY] ]]; then
        rm -r $droptable
        echo -e "\e[92mTable [$droptable] Deleted Successfully.\e[0m"
        echo -e "\e[34m--------------------------------------------------------------\e[0m"
        . tableMenu.sh
    elif [[ $answer == [nN] ]]; then
        . tableMenu.sh
    else
        echo "Invalid Input Please Try Again ..."
        . tableMenu.sh
    fi
else
    echo -e "\e[91m[$droptable]!, this table is not found\e[0m"
    echo -e "\e[34m--------------------------------------------------------------\e[0m"
    . tableMenu.sh
fi
