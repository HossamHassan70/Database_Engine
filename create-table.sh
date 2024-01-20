#!/usr/bin/bash

regex="^[a-zA-Z][a-zA-Z0-9_]*$"
read -p "Enter name of a new table (or '0' to back): " name
if [[ $name == "0" ]]; then
    clear
    cd ../../
    . table-menu.sh
fi
if [[ ${#name} -gt 1 ]]; then
    if [ -f "$name" ]; then
        echo "Sorry, you entered an existing table"
        . table-menu.sh
    elif [[ -z "$name" ]] || ! [[ "$name" =~ $regex ]]; then
        echo "Sorry, you entered an invalid name."
        . table-menu.sh
    else
        touch "$name"
        echo "Table created successfuly"
    fi
else
    echo -e "\e[91mError: Invalid Table Name (should be more than one character)\e[0m"
    . table-menu.sh
fi
clear
while true 
do  
    echo -e "Enter the number of fields of \e[93m[$name]\e[0m: " 
    read num
    if [[ $num -eq 0 ]]; then
        echo "You can't enter $num as a number of fields."
    elif [[ $num =~ ^[1-9][0-9]*$ ]]; then
        echo "Number of fields: $num"
        break
    else
        echo "Invalid number. Please enter a valid one."
    fi 
done
echo "Now you can enter metadata for your table :)"
echo "Your primary key Must be the first column"
rowtype=""
pk_column=""
declare -A column_names
for ((i=1; i<=$num; i++))
do  
    column_names=()
    while true
    do 
        read -p "Name of column number $i is: " cname
        # check if cname value in column_name or not
        if [[ "${column_names[@]}" =~ "$cname" ]]; then
            echo "This name has already been used. Try another one."
            continue
        fi
        column_names+=("$cname") 
        # while [[ -z "$cname" ]] || [[ -n "${column_names[$cname]}" ]]
        # do
        #     if [[ -n "${column_names[$cname]}" ]]; then
        #         echo "This column name already exists. Please enter a different name."
        #     else
        #         echo "Name can't be empty, please enter valid name"
        #     fi
        #     # read cname
        # done
        column_names["$cname"]=1
        if [[ $cname =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
            if [[ $i -eq 1 ]]; then
                pk_column="$cname"
            fi
            rowtype+=" $cname"
            break
        else
            echo "Invalid name."
        fi
    done
    select choice in integer string
    do 
        case $choice in 
            integer )
                rowtype+=":integer"
                break
                ;;
            string )
                echo "String"
                rowtype+=":string"
                break
                ;;
            * )
                echo "You entered an invalid datatype. Only integer and string are valid."
                ;;
        esac 
    done
done
echo "$rowtype" >> "$name"
echo "Metadata of your table is: $rowtype"
    echo "Do you want to make $pk_column as the primary key? (y/n): "
    read pk_choice
    case $pk_choice in
        [yY]) 
            echo "$pk_column:integer:unique(Not NULL)" >> "$name"
            echo "Primary key added successfully"
            ;;
        [nN])
            echo "Primary key does not added."
            ;;
        *)
            echo -e "\e[91mInvalid choice. Please enter 'yes' or 'no'.\e[0m"
            rm -r $name 
            echo -e "\e[91mThe Table [$name] will be deleted, Try Again\e[0m"
            . create-table.sh
            ;;
    esac
. table-menu.sh
