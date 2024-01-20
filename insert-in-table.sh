#!/usr/bin/bash

YELLOW=$'\e[1;33m'
defaultcolor=$'\e[0m'
PS3="$YELLOW$1$defaultcolor >"
dirloc=$1

echo -e "\e[34m---------------------- Tables List -------------------------\e[0m"
ls -p | grep -v /
echo -e "\e[34m------------------------------------------------------------\e[0m"

read -p "Enter the table name to Insert (or '0' to back): " tablename

if [[ $tablename == "0" ]]; then
    clear
    cd ../../
    . table-menu.sh $dirloc
fi

if [ -e "$tablename" ]; then
    clear
    num_columns=$(awk -F':' 'NR==1{print NF}' "$tablename")
    echo -e "Columns number: \e[93m$num_columns\e[0m"

    line_number=$(( $(awk -F':' 'END{print $1}' "$tablename") + 1))
    echo -n "$line_number:" >>"$tablename"

    for ((i = 2; i <= num_columns; i++)); do
        column_name=$(awk -F':' -v col="$i" 'NR==1{print $col}' "$tablename")
        data_type=$(awk -F':' -v col="$i" 'NR==2{print $col}' "$tablename")

        while true; do
            read -p "Enter data for [$column_name] column ($data_type): " data

            case $data_type in
                int)
                    if [[ "$data" =~ ^[0-9]+$ ]]; then
                        break
                    else
                        echo -e "\e[91mInvalid data. Expected an integer.\e[0m"
                    fi
                    ;;
                str)
                    if [[ "$data" =~ ^[a-zA-Z]+$ ]]; then
                        break
                    else
                        echo -e "\e[91mInvalid data. Expected a string with no spaces.\e[0m"
                    fi
                    ;;
                *)
                    echo -e "\e[91mInvalid data type.\e[0m"
                    ;;
            esac
        done

        echo -n "$data" >>"$tablename"

        [ "$i" -lt "$num_columns" ] && echo -n ":" >>"$tablename"
    done

    echo "" >>"$tablename"

    echo -e "\e[92mData added successfully! with ID: $line_number\e[0m"
    cd ../../
    . table-menu.sh
else
    echo -e "\e[91mTable doesn't exist.\e[0m"
    cd ../../
    . table-menu.sh
fi

