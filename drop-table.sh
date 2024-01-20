#!/usr/bin/bash
clear
echo -e "\e[34m---------------------- Drop Table -------------------------\e[0m"
ls -p | grep -v / 
echo -e "\e[34m-----------------------------------------------------------\e[0m"
read -p "Enter The Name Table Want to Drop : " droptable
if [[ -f $droptable ]];then
    read -p "Are You Sure you want to delete [$droptable] (y/n)? " answer 
    if [[ $answer == [yY] ]]; then
        rm -r $droptable
        echo -e "\e[92mTable [$droptable] Deleted Successfully.\e[0m"
        echo -e "\e[34m--------------------------------------------------------------\e[0m"
        . table-menu.sh
    elif [[ $answer == [nN] ]]; then
        . table-menu.sh
    else
        echo "Invalid Input Please Try Again ..."
        . table-menu.sh
    fi
else
    echo -e "\e[91m$droptable !, this table is not found\e[0m"
    echo -e "\e[34m--------------------------------------------------------------\e[0m"
    cd ../../
    . table-menu.sh
fi
