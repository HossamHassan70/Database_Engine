#!/usr/bin/bash
PS3="Enter the number you want to choice from this menu: "
select choice in Create-table List-tables Drop-table Insert-in-table Select-from-table Update-table Remove-from-table
do
case $choice in
   Create-table )
   echo "You can create table now"
   ./create-table.sh
   ;;
   List-tables )
   echo "You can listing tables now"
   ./list-tables.sh
   ;;
   Drop-table )
   echo "You can drop the table you want now"
   ./drop-table.sh
   ;;
   Insert-in-table )
   echo "You can insert in table now"
   ./insert-in-table.sh
   ;;
   Select-from-table )
   echo "You can select from table now" 
   ./select-from-table.sh
   ;;
   Update-table )
   echo "You can update table"
   ./update-table.sh
   ;;
   Remove-from-table )
   echo "You can remove from table"
   ./remove-from-table.sh
   ;;
   * )
   echo "The number you entered not match any choice from menu"
   ;;
esac
done
