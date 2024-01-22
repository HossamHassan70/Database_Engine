#!/bin/bash

YELLOW=$'\e[1;33m'
defaultcolor=$'\e[0m'
PS3="$YELLOW$1$defaultcolor > "
newname=$1
echo -e "\e[34mEnter Your choice From The Menu: \e[0m"
select choice in Create-table List-tables Drop-table Insert-in-table Select-from-table Update-table Remove-from-table Back
do
   case $REPLY in
      1)
         echo -e "\e[34m---------------------- Create Table ------------------------\e[0m"      
         . create-table.sh 
         ;;
      2)
         echo -e "\e[34m---------------------- List Table --------------------------\e[0m"  
         . list-tables.sh $newname
         ;;
      3)
         echo -e "\e[34m---------------------- Drop Table --------------------------\e[0m"
         . drop-table.sh
         ;;
      4)
         echo -e "\e[34m------------------ Insert Into Table -----------------------\e[0m"
         . insert-in-table.sh $newname
         ;;
      5)
         echo -e "\e[34m------------------- Select From Table ----------------------\e[0m"
         . select-from-table.sh
         ;;
      6)
         echo -e "\e[34m---------------------- Update Table ------------------------\e[0m"
         . update-table.sh
         ;;
      7)
         echo -e "\e[34m------------------ Remove From Table -----------------------\e[0m"
         . remove-from-table.sh
         ;;
      8)
         echo -e "\e[93m------------------ Back to Main Menu --------------------\e[0m"
         cd ../../
         . main-menu.sh
         ;;
      * )
      echo "Invalid Input, Please Try Again"
      ;;
   esac
done
