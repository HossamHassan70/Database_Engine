#!/usr/bin/bash
echo "Enter the table name you want to drop : "
read droptable
if [[ -f $droptable ]]
then
    rm $droptable
    echo "You dropped the table $droptable "
else
    echo "$droptable !, this table is not found"
    echo "-------------------------------------------------"
    ./table-menu.sh
fi