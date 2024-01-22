#!/bin/bash

brightYellow=$'\e[1;93m'
defaultcolor=$'\e[0m'
echo -e "\e[34m---------------------- Tables List -------------------------\e[0m"
ls -p . | grep -v / 
echo -e "\e[34m------------------------------------------------------------\e[0m"

read -p "Enter the name of table to select from it: " tablename
if [ -e "$tablename" ]; then
    PS3="$brightYellow$tablename$defaultcolor > "
    clear
    select option in "Select All" "Select by ID" "Select by column" "Back to previous menu"; do
        case $REPLY in
        1)
            clear
            echo -e "\e[34m-------------------- Selected Table -----------------------\e[0m"
            awk 'NR!=2' "$tablename" | tr ":" " " | column -t
            echo -e "\e[34m------------------------------------------------------------\e[0m"
            . table-menu.sh
            ;;
        2)
            clear
            read -p "Enter the ID to search: " search_id

            awk -v search_id="$search_id" -v IGNORECASE=1 '
                /^([Ii][Dd]|'"$search_id"')/ {
                    gsub(":", " ", $0);
                    print $0;
                }
            ' "$tablename" | column -t
            echo -e "\e[34m------------------------------------------------------------\e[0m"
            . table-menu.sh
            ;;
        3)
            clear
            # print the first row of the table using awk
            colname=$(awk -F: 'NR==1 {print $0}' "$tablename" | tr ":" " ")
            echo $colname
            echo -e "\e[34m------------------------------------------------------------\e[0m"
            read -p "Enter a column name: " search_column
            field_number=$(awk -F: -v word="$search_column" '{
                for(i=1; i<=NF; i++)
                if($i == word)
                print i;
                exit
                }' "$tablename")
            if [ -z "$field_number" ]; then
                echo -e "\e[91mError: Column '$search_column' not found in '$tablename' table.\e[0m"
                . table-menu.sh
            else
                awk -F: -v field="$field_number" 'NR!=2 { print $field }' "$tablename"
                . table-menu.sh
            fi
            ;;
        4)
            . table-menu.sh
            ;;
        *)
            echo -e "\e[91mInvalid option. Please try again.\e[0m"
            ;;
        esac
    done
else
    echo -e "\e[91mTable doesn't exist.\e[0m"
    . table-menu.sh
fi
