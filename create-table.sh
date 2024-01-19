#!/usr/bin/bash

#Regular expression to validate table names: 
#starts with a letter, followed by letters, digits, or underscores
regex="^[a-zA-Z][a-zA-Z0-9_]*$"

while true #condtion to exit the loop (return to table menu)
do 
    echo "Press '0' To go back"
    if [[ $name == '0' ]]; then
        . table-menu.sh
    fi
    # Prompt user to enter a table name
    echo "Enter The Name of New Table : " 
    read name
    #check if a file with the entered name already exist
    if [ -f "$name" ]
    then
        echo "Sorry, you entered an existing table. Please enter another name :)"
    else 
        #check if the file with the entered name is empty or matches the regex
        if [[ -z "$name" ]] || ! [[ "$name" =~ $regex ]]
        then
            echo "Sorry, you entered an invalid name. Please try again."
        else
            #create an empty file with the entered name
            touch "$name"
            echo "Table created successfully :)"
            break
        fi
    fi
done

while true 
do  
    #prompt user to enter the number of fields for the entered table
    echo "Enter the number of fields for your table: " 
    read num
    #check if user entered the number 0 to the number of fields
    if [[ $num -eq 0 ]] 
    then
        echo "You can't enter $num as the number of fields."
    #check if the entered number matches this regex
    elif [[ $num =~ ^[1-9][0-9]*$ ]]
    then
        echo "Number of fields: $num"
        break
    else
        echo "You entered an invalid number. Please enter a valid one."
    fi 
done

echo "Now you can enter metadata for your table :)"
echo "please let the first column to be the primary key"
rowtype=""
pk_column=""
#declare an associative array named column_names
declare -A column_names

for ((i=1; i<=$num; i++))
do  
    #initialize an associative array to store column names to avoid duplicatio
    column_names=()
    while true
    do
        echo "Name of column number $i is: "
        read cname
        #loop that continues until user enter a valid column name
        while [[ -z "$cname" ]] || [[ -n "${column_names[$cname]}" ]]
        do  
            #in this if condition it must check if user entered a column name already exist or not
            #note: this part does not work, it allow user entered an existing column name
            if [[ -n "${column_names[$cname]}" ]]; then
                echo "This column name already exists. Please enter a different name."
            else
                echo "Name can't be empty, please enter valid name"
            fi
            read cname
        done
        #stored the column name in the associative array
        column_names["$cname"]=1
        
        #check if the entered column matches this regex
        if [[ $cname =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]
        then
            #when user entered the first column, set pk_column to the entered column name
            if [[ $i -eq 1 ]]; then
                pk_column="$cname"
            fi
            #Append the column name to the rowtype
            rowtype+=" $cname"
            break
        else
            echo "Invalid name."
        fi
    done
    
    #start a loop to prompt the user to select the data type for the current column 
    select choice in integer string
    do 
        case $choice in 
            integer )
            #if user selects "integer", append ":integer" to the rowtype                echo "Integer"
                rowtype+=":integer"
                break
                ;;
            string )
            #if user selects "string", append ":string" to the rowtype
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
#write the metadata to the table file
echo "$rowtype" >> "$name"
echo "Metadata of your table is: $rowtype"

# Validate primary key 
while true
do
    echo "Do you want to make $pk_column as the primary key? (y/n): "
    read primary_key_choice

    case $primary_key_choice in
        [yY]) 
            #add primary key in the table (unique)
            echo "$pk_column:integer:unique" >> "$name"
            echo "Primary key added successfully :)"
            break
            ;;
        [nN])
            echo "Primary key does not added."
            break
            ;;
        *)
            echo "Invalid choice. Please enter 'y' or 'n'."
            ;;
    esac
done
