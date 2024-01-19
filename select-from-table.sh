#!/usr/bin/bash
validation_table_name() {
    while true
    do
        echo "Enter the name of the table you want to select data from: "
        read name
        if [ -f "$name" ]
        then
            break
        else
            echo "Table $name does not exist. Please enter an existing table name."
        fi
    done
}
get_metadata() {
    local columns=$(head -n 1 "$name")
    metadata=($(echo $columns | tr ',' ' '))
}
validation_table_name

while true
do
    PS3="Enter the number you want to choose from this menu: "
    options=("Select-All" "Select data by column" "Select a specific column of the table" "Exit")
    select choice in "${options[@]}"
    do
        case $choice in
            "Select-All" )
            #display all rows(starting from the third line) from the entered table using sed
                sed -n '3,$p' "$name"
            ;;
            "Select data by column" )
                get_metadata
                echo "Enter the primary key value:"
                read pk_value
                #use awk to filter rows where the first column matches the entered primary key value
                awk -F, -v pk="$pk_value" '$1 == pk' "$name"
                read -p "Press Enter to continue..."
            ;;
            "Select a specific column of the table" )
                get_metadata
                echo "Choose a column to select:"
                select option in "${metadata[@]}"
                do
                    #get the column number for the selected column name
                    if [[ -n "$option" ]]; then
                        #use grep to searche for the selected column name in the array and extract it
                        #use awk to print the number of fields (column number) 
                        column_number=$(echo "${metadata[@]}" | grep -o "\<$option\>" | awk '{print NF}')
                        awk -F, -v col_number="$column_number" '{print $col_number}' "$name"
                        break
                    else
                        echo "Invalid selection. Please choose a valid column."
                    fi
                done
            ;;
            "Exit" )
                echo "Exiting SELECT operation."
                exit 0
            ;;
            * )
                echo "Invalid option. Please choose a valid option."
            ;;
        esac
    done
done
