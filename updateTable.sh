#!/bin/bash

echo -e "\e[34m---------------------- Tables List -------------------------\e[0m"
ls -p | grep -v / 
echo ""
echo -e "\e[34m------------------------------------------------------------\e[0m"
read -p "Enter the table name: " tablename
if [ -e "$tablename" ]; then
    PS3="$tablename > "
    clear
    select option in "Update by column" "Back to previous menu"; do
        case $REPLY in
        1)
            clear

            column_names=($(awk -F':' 'NR==1 {for (i=1; i<=NF; i++) print $i}' "$tablename"))
            echo -e "\e[94m---------------------- Table Columns --------------------------\e[0m"
            for ((i = 0; i < ${#column_names[@]}; i++)); do
                echo "${column_names[$i]}"
            done
            echo -e "\e[94m-------------------------------------------------------------\e[0m"
            read -p "Enter the name of the column to search in: " col_name

            field_number=$(
                awk -F':' -v col_name="$col_name" 'NR==1 {
                    for (i=1; i<=NF; i++) 
                    if ($i == col_name) 
                    {print i; exit}}
                ' "$tablename")

            if [ -z "$field_number" ]; then
                echo -e "\e[31mError: Column '$col_name' not found.\e[0m"
            else
                read -p "Enter the value to update (Old Value): " value_toUpdate
                if
                    awk -F':' -v col_number="$field_number" -v value_toUpdate="$value_toUpdate" '
                        $col_number == value_toUpdate {
                            found = 1
                            exit 0
                        }
                        END {
                            if (found != 1) {
                                exit 1
                            }
                        }
                    ' "$tablename"
                then
                    while true; do
                        data_type=$(awk -F':' -v col_number="$field_number" 'NR==2 {print $col_number}' "$tablename")
                        read -p "Enter the new value: " new_value
                        if [ "$data_type" == "int" ]; then
                            if [[ "$new_value" =~ ^[0-9]+$ ]]; then
                                break
                            else
                                echo -e "\e[31mInvalid data. Expected an integer.\e[0m"
                            fi
                        elif [ "$data_type" == "str" ]; then
                            if [[ "$new_value" =~ ^[[:alpha:]]+$ ]]; then
                                break
                            else
                                echo -e "\e[31mInvalid data. Expected a string with no spaces.\e[0m"
                            fi
                        fi
                    done
                    awk -F':' -v OFS=':' -v col_num="$field_number" -v value="$value_toUpdate" -v new_value="$new_value" '{if (NR > 2 && $col_num == value) {$col_num = new_value;}print;}' "$tablename" >tmp && mv tmp "$tablename"
                    echo -e "\e[92mUpdated '$value_toUpdate' to '$new_value' successfully in '$col_name' column.\e[0m"
                else
                    echo -e "\e[31mValue '$value_toUpdate' does not exist in column '$col_name'.\e[0m"
                fi
            fi
            . tableMenu.sh
            ;;
        2)
            clear
            . tableMenu.sh
            ;;

        *)
            echo -e "\e[31mInvalid option. Please try again.\e[0m"
            ;;
        esac
    done
else
    echo -e "\e[31mError: There is no table named $tablename.\e[0m"
    . tableMenu.sh
fi
