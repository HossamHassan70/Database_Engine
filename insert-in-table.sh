#!/usr/bin/bash

#define a function named validation_table_name
validation_table_name() {
    while true
    do
        echo "Enter the name of the table you want to insert data into: "
        read name
        #check if the entered table name is exist or not
        if [ -f "$name" ]
        then
            break
        else
            echo "Table $name does not exist. Please enter an existing table name."
        fi
    done
}
#define a funcion named get_metadata: this function used to display the columns of 
#the table when gathering metadata about the table
get_metadata() {
    #read the first line of the file with the entered name and store it in "columns"
    local columns=$(head -n 1 "$name")
    #use tr to replace commas with spaces and store the result as an array in "col_array"
    read -a col_array <<< "$(echo $columns | tr ',' ' ')"
    #loop that iterates over each element in "col_array"
    for col in "${col_array[@]}"
    do
    #print the current value of the col variable, which represents each column name in the "col_array" array
        echo "$col"
    done
}
#call this function 
validation_table_name

echo "Columns in the table $name are:"
#call the function get_metadata and store the result (column names) in the metadata array
metadata=($(get_metadata))
#declare an array to store the data types for each column
declare -a col_types
for col in "${metadata[@]}"
do
    select data_type in integer string
    do
        case $data_type in
            integer )
                col_types+=("integer")
                break
                ;;
            string )
                col_types+=("string")
                break
                ;;
            * )
                echo "Invalid data type. Please enter a valid one."
                ;;
        esac
    done
done
echo "Metadata of your table is:"
for ((i=0; i<${#metadata[@]}; i++))
do
    #print each column name followed by its data type
    echo "${metadata[$i]}:${col_types[$i]}"
done
while true
do
    #declare an empty array to store the value of a new entry
    entry_values=()
    for ((i=0; i<${#metadata[@]}; i++))
    do
        while true
        do
           #prompt the user to enter a value for the current column
            echo "Enter the value for ${metadata[$i]} (${col_types[$i]}): "
            read value
            #check if the enttered value matches the expected data type
            if [[ "${col_types[$i]}" == "integer" && ! "$value" =~ [^0-9] ]] ||
               [[ "${col_types[$i]}" == "string" && ! "$value" =~ [^a-zA-Z0-9_] ]]
            then
                #store the entered vlue to the "entry_values"
                entry_values+=("$value")
                break
            else
                echo "Invalid ${col_types[$i]} value. Please enter a valid value."
            fi
        done
    done
    #concatenate the values in "entry_values" into a single string, separated by space
    new_entry="${entry_values[*]}"
    #append the new entry to the entered table file
    echo "$new_entry" >> "$name"
    echo "Data inserted successfully."
    break
done
