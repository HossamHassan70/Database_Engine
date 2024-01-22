#!/usr/bin/bash
    while true
    do
        echo "Enter the name of the table you want to modify: "
        read name
        #check if the entered table name is exist or not
        if [ -f "$name" ]
        then
            break
        else
            echo "Table $name does not exist. Please enter an existing table name."
        fi
    done

    #start a loop to let user select from their options
    select choice in Delete-all Delete-row
    do 
    case $REPLAY in 
    1 )
    echo "are you sure to delete all data in table"
    select choice in "yes" "no"
    do
    case $REPLY in 
    1)
    sed -i '/^[[:digit:]]/d' $name
    echo "You delete the data from $name successfully"
    . table-menu.sh
    ;;
    2)
    . table-menu.sh
    ;;
    * )
    echo "Invalid choice"
    ;;
    esac
    done
    ;;
    2)
    read -p "enter the Id of the record you want to delete : " id
    while ! [[ $id =~ ^[0-9]*$ ]] || [[ $id =~ ['!@#$%^&*():_+'] ]] || [[ $id == "" ]] || [[ $id =~ [a-zA-z] ]]
    do
    echo  "Invalid value for the id! enter your value again"
    read id
    done
    if [ `awk '(NR>2)' "$name"  | awk -F : ' {print $1}'| grep $id ` ]; then
    echo "Are you sure you want to delete this record $id"
    select choice in "Yes" "No"
    do 
    case $REPLY in
    1)
    `sed -i '/^'$id'/ d' "$name"`;
    echo "record was deleted successfully";
    ;;
    2)
    . table-menu.sh
    ;;
    *) 
    echo "Invalid choice"
    ;;
    esac
    done
    else 
    echo "There is no record with ID : $id"
    . table-menu.sh
    fi
    esac
    done
    ;;
    * )
    echo "Invalid choice"
    continue
    ;;
    esac
    done
