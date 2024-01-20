#!/usr/bin/bash

regex="^[a-zA-Z][a-zA-Z0-9_]{0,14}$"

read -p "Enter name of a new table (or '0' to back): " name
if [[ $name == "0" ]]; then
    clear
    cd ../../
    . table-menu.sh
fi
name=$(echo "$name" | sed 's/[^a-zA-Z0-9_ ]//g' | tr " " "_")
if [[ ${#name} -gt 1 ]] && [[ ${#name} -le 16 ]]; then
    if [ -f "$name" ]; then
        echo -e "\e[91mSorry, you entered an existing table\e[0m"
        cd ../../
        . table-menu.sh
    elif [[ -z "$name" ]] || [[ ! "$name" =~ $regex ]]; then
        echo -e "\e[91mSorry, you entered an invalid name\e[0m"
        cd ../../
        . table-menu.sh
    else
        touch "$name"
    fi
else
    echo -e "\e[91mError: Invalid Table Name (should be more than one character)\e[0m"
    cd ../../
    . table-menu.sh
fi
clear
echo -e "\e[92mTable \e[93m[$name] \e[92mcreated successfuly\e[0m"
PS3="$name > "

while true; 
do
    echo -e "Enter The number of fields in \e[93m[$name]\e[0m table: "
    read num
    if [[ $num -eq 0 ]]; then
        echo "You can't enter $num as a number of fields."
    elif [[ $num =~ ^([1-9]|1[0-9])$ ]]; then
        echo "Number of fields: $num"
        break
    else
        echo "Invalid number. Maximum Columns is '19' ."
    fi
done
echo -e "\e[33mNow you can enter metadata for your table\e[0m"
echo "Your primary key is 'int' & Must be the first column"
echo -e "\e[34m--------------------------------------------------------\e[0m"
# rowtype=""
read -p "Name of column number 1 is (Recommended be ID): " one_name
echo -n "$one_name" >>"$name"
echo -n ":" >>"$name"

for ((i = 2; i <= $num; i++)); 
do
    while true; 
    do
        read -p "Name of column number $i is: " cname
        if [[ $cname =~ $regex ]]; then
            echo -n "$cname">>"$name"
            # break
            if [ $i -lt $num ];then
                echo -n ":" >>"$name"
            fi 
            break
        else
            echo -e "\e[91mInvalid name. Try again \e[0m"
        fi
    done
done
echo "" >>"$name"
echo -n "int" >>"$name"
for ((i = 2; i <= $num; i++)); 
do
    echo -e "\e[34mType of column number $i is: \e[0m"  
        select choice in int str; 
        do
            case $REPLY in
            1)
                echo -n ":int">>"$name"
                # rowtype+=":integer"
                break
                ;;
            2)
                echo -n ":str">>"$name"
                # rowtype+=":string"
                break
                ;;
            *)
                echo -e "\e[91mError,invalid datatype.. only '1' for int & '2' for str are valid\e[0m"
                ;;
            esac
        done
done
# this line to make a new line in table file 
echo "" >>"$name"
echo -e "\e[94m------------------------------------------------------------\e[0m"
echo -e "\e[92mTable Metadata added to \e[93m[$name] \e[92mSuccessfully\e[0m"
echo -e "\e[94m------------------------------------------------------------\e[0m"

cd ../../
. table-menu.sh
