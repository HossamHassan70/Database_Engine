#!/usr/bin/bash

while true
do
    echo -e "\e[94mEnter Name of the table to Remove From or '0' to back: \e[0m"
    read name
    if [[ $name == "0" ]]; then
        break
        . table-menu.sh
    fi
    #check if the entered table name is exist or not
    if [ -f "$name" ]
    then
        break
    else
        echo "Table [$name] does not exist. Please Try Again"
    fi
done

#start a loop to let user select from their options
select choice in Delete-all Delete-row
do 
    case $REPLY in 
    1 )
        echo -e "\e[33mAre you sure you want will delete all data in table (yes/no)?\e[0m"
        select choice in "yes" "no"
        do
            case $REPLY in 
            1)
                sed -i '/^[[:digit:]]/d' $name
                echo -e "\e[92mYou delete the data from [$name] successfully\e[0m"
                . table-menu.sh
                ;;
            2)
                . table-menu.sh
                ;;
            * )
                echo -e "\e[91mInvalid choice\e[0m"
                . table-menu.sh
                ;;
            esac
        done
        ;;
    2)
        read -p "Enter the Id of the record That want to delete: " id
        while  [[ ! $id =~ ^[0-9]*$ ]] || [[ $id =~ ['!@#$%^&*():_+'] ]] || [[ $id == "" ]] || [[ $id =~ [a-zA-z] ]]
        do
            echo -e "\e[91mInvalid input, Please try again or type 'back' to return\e[0m"
            if [[ $id == "back" ]]; then
                break
                . table-menu.sh
            fi
            read id
        done
        if [ `awk '(NR>2)' "$name"  | awk -F: ' {print $1}'| grep $id ` ]; then
            echo -e "\e[33mAre you sure you will delete this record (Yes\No) $id\e[0m"
            select choice in "Yes" "No"
            do 
                case $REPLY in
                1)
                    `sed -i '/^'$id'/ d' "$name"`;
                    echo -e "\e[92mRecord was deleted successfully\e[0m";
                    ;;
                2)
                break
                    . table-menu.sh
                    ;;
                *) 
                    echo "Invalid choice"
                    . table-manu.sh
                    ;;
                esac
            done
        else 
            echo -e "\e[33mThere are No record with ID : $id\e[0m"
            . table-menu.sh
        fi
    ;;
    * )
        echo -e "\e[33mInvalid choice\e[0m"
        . table-menu.sh
    ;;
    esac
done
