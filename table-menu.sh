#!/bin/bash

YELLOW=$'\e[1;33m'
defaultcolor=$'\e[0m'
PS3="$YELLOW$1$defaultcolor >"

echo "Enter Your choice From The Menu: "
select choice in Create-table List-tables Drop-table Insert-in-table Select-from-table Update-table Remove-from-table Back
do
   case $REPLY in
      1)
      echo "You can create table now"
      . create-table.sh
      ;;
      2)
      echo "You can listing tables now"
      . list-tables.sh
      ;;
      3)
      echo "You can drop the table you want now"
      . drop-table.sh
      ;;
      4)
      echo "You can insert in table now"
      . insert-in-table.sh
      ;;
      5)
      echo "You can select from table now" 
      . select-from-table.sh
      ;;
      6)
      echo "You can update table"
      . update-table.sh
      ;;
      7)
      echo "You can remove from table"
      . remove-from-table.sh
      ;;
      8)
         echo -e "\e[93mBack to Main Menu\e[0m"
         . main-menu.sh
         ;;
      * )
      echo "Invalid Input, Please Try Again"
      ;;
   esac
done
