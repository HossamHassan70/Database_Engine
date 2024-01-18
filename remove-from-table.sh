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
    case $choice in 
    Delete-all ) 
        #use sed to delete all rows that start with digits to avoid to delete the metadata
        sed -i '/^[[:digit:]]/d' $name
        echo "You delete the data from $name successfully"
    ;;
    Delete-row )
        while true 
        do 
        #prompt user to enter the primary key of the row to be deleted
        echo "Enter the primary key of the row: " 
        read pk_column
        #use awk to find the row in the table that matches the entered primary key
        row=`awk -F':' '{ if ($1=='$pk_column') print $0}' $name`
        #check if the row with the entered primary key exists in the table or not
        if grep -Fxq "$row" "$name" &>~/../../dev/null;
        then
        #delete the row with the entered primary key from the table
        sed -i '/'$row'/d' $name
        echo "You deleted the row successfullt"
        break
        else
        echo "The primary key is not exist"
        continue
        fi
        done 
        break
    ;;
    * )
       echo "Pleace enter a valid choice"
       continue
    ;;
    esac
    done
