#!/usr/bin/bash
validation_table_name() {
    while true
    do
        echo -e "\e[34m---------------------- Tables List -------------------------\e[0m"
        ls -p | grep -v / 
        echo -e "\e[34m------------------------------------------------------------\e[0m"
        echo "Enter the name of the table you want to insert data into: "
        read name
        if [ -f "$name" ]
        then
            break
        else
            echo "Table $name does not exist. Please enter an existing table name."
        fi
    done
}
clear
get_metadata() {
    local columns=$(head -n 1 "$name")
    read -a col_array <<< "$(echo $columns | tr ',' ' ')"
    for col in "${col_array[@]}"
    do
        echo "$col"
    done
}
validation_table_name

echo "Columns in the table $name are:"
metadata=($(get_metadata))
declare -a col_types=("integer" "string")
for ((i=0; i<${#metadata[@]}; i++))
do 
    echo "${metadata[$i]}"
done
while true
do
    entry_values=()
    for ((i=0; i<${#metadata[@]}; i++))
    do
        while true
        do
            echo "Enter the value for ${metadata[$i]}"
            read value
            if [[ "${col_types[$i]}" == "integer" && ! "$value" =~ [^0-9]+$ ]] ||
               [[ "${col_types[$i]}" == "string" && ! "$value" =~ [^a-zA-Z0-9_] ]];
               then
                entry_values+=("$value")
                clear
                break
            else
                echo "Invalid value. Please enter a valid value."
            fi
        done
    done
    new_entry="${entry_values[*]}"
    echo "$new_entry" >> "$name"
    echo "Data inserted successfully."
    break
done
cd ../../
. table-menu.sh
