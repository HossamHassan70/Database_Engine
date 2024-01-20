#!/bin/bash

YELLOW=$'\e[1;33m'
defaultcolor=$'\e[0m'
PS3="$YELLOW$1$defaultcolor >"
newname=$1
echo -e "\e[34mEnter Your choice From The Menu: \e[0m"
select choice in Create-table List-tables Drop-table Insert-in-table Select-from-table Update-table Remove-from-table Back
do
   case $REPLY in
      1)
         echo -e "\e[34m---------------------- Create Table ------------------------\e[0m"
         if [[ ! $(pwd) =~ DB/$1 ]]; then
            cd DB/$1
         fi         
         . create-table.sh 
         ;;
      2)
         echo -e "\e[34m---------------------- List Table --------------------------\e[0m"
         if [[ ! $(pwd) =~ DB/$1 ]]; then
            cd DB/$1
         fi   
         . list-tables.sh
         ;;
      3)
         echo -e "\e[34m---------------------- Drop Table --------------------------\e[0m"
         if [[ ! $(pwd) =~ DB/$1 ]]; then
            cd DB/$1
         fi   
         . drop-table.sh
         ;;
      4)
         echo -e "\e[34m------------------ Insert Into Table -----------------------\e[0m"
         if [[ ! $(pwd) =~ DB/$1 ]]; then
            cd DB/$1
         fi   
         . insert-in-table.sh $newname
         ;;
      5)
         echo -e "\e[34m------------------- Select From Table ----------------------\e[0m"
         if [[ ! $(pwd) =~ DB/$1 ]]; then
            cd DB/$1
         fi   
         . select-from-table.sh
         ;;
      6)
         echo -e "\e[34m---------------------- Update Table ------------------------\e[0m"
         if [[ ! $(pwd) =~ DB/$1 ]]; then
            cd DB/$1
         fi   
         . update-table.sh
         ;;
      7)
         echo -e "\e[34m------------------ Remove From Table -----------------------\e[0m"
         if [[ ! $(pwd) =~ DB/$1 ]]; then
            cd DB/$1
         fi   
         . remove-from-table.sh
         ;;
      8)
         echo -e "\e[93m------------------ Back to Main Menu --------------------\e[0m"
         . main-menu.sh
         ;;
      * )
      echo "Invalid Input, Please Try Again"
      ;;
   esac
done
