#!/bin/bash

currentlocation=$(pwd)
echo $(PATH="$PATH":"$currentlocation") >>~/.bashrc
# check if there are file named DB or not to create it
if [[ ! -d "DB" ]]; then
    mkdir "./DB"
fi
clear
echo -e "\e[94m-------------------------------------------------------\e[0m"
echo -e "\e[95m          Hello From Our Database Engine ...     \e[0m"
echo -e "\e[94m-------------------------------------------------------\e[0m"

PS3="Type Your Selection: "

select option in "Create Database" "List Databases" "Connect to Database" "Drop Database" "Exit"; 
do
    case $REPLY in
    1)
        clear
        echo -e "\e[34m---------------------- Create Database --------------------------\e[0m"
        echo -e "\e[34mEnter '0' to go back \e[0m"
        read -p "Enter a Name of DB: " name
        if [[ $name == "0" ]]; then
            clear
            . main-menu.sh
        fi

        if [[ ! "$name" =~ ^[0-9] ]]; then
            name=$(echo $name | sed 's/[^a-zA-Z0-9 ]//g' | tr " " "_")
            database_path="DB/$name"
            # In the line below the '#' key before name variable, to gives you the length of
            #   the string (Number of characters)
            if [[ ${#name} -gt 1 ]]; then
                if [[ -e DB/$name ]]; then
                    echo -e "\e[91mError: This Database is already exists.\e[0m"
                    . main-menu.sh
                else
                    mkdir "$database_path"
                    echo -e "\e[92m[$name] Database Created Successfully.\e[0m"
                    echo -e "\e[92m Conected to [$name] Database ...\e[0m"
                    cd DB/$name
                    . table-menu.sh $name
                fi
            else
                echo -e "\e[91mError: Please enter a valid name (should be more than one character)\e[0m"
                . main-menu.sh
            fi
        else
            echo -e "\e[91mError: Invalid Input (should start with a letter not a number)\e[0m"
            . main-menu.sh
        fi

        echo -e "\e[34m--------------------------------------------------------\e[0m"

        ;;
    2)
        clear
        echo "DB/$name"
        echo -e "\e[34m---------------------- Databases List -------------------------\e[0m"
        # in this line below '-z' checks if the result string (output of command) is empty
        # and '-A' to ignore . .. we don't need to them in this case
        if [ -z "$(ls -A DB/)" ]; then
            echo -e "\e[93mThere are No Databases Available Right Now ...\e[0m"
        else
            ls -F DB/ | grep / | tr '/' ' '
        fi
        echo -e "\e[34m---------------------------------------------------------------\e[0m"
        read -p "Type any key to go back : " var
        if [[ $var == "0" ]]; then
            . main-menu.sh
        else
            echo -e "\e[93mInvalid Input, Redirect to Main Menu\e[0m"
            . main-menu.sh
        fi
        ;;
    3)
        clear
        echo -e "\e[34m----------------- Connect to a database -----------------------\e[0m"
        if [ -z "$(ls -A DB)" ]; then
            echo -e "\e[93mThere are No Databases Right Now .. Please Add it First.\e[0m"
            . main-menu.sh
        else
            ls -F DB | grep / | tr '/' ' '
        fi
        echo -e "\e[34m---------------------------------------------------------------\e[0m"
        read -p "Enter a Database Name To Connect (or '0' to back): " name
        if [[ $name == "0" ]]; then
            clear
            . main-menu.sh
        fi
        if [[ -d DB/$name ]]; then
            clear
            echo -e "\e[92mConnected to \e[93m[$name] \e[92mDatabase\e[0m"
            cd DB/$name
            . table-menu.sh $name
        else
            echo -e "\e[91mError: Database is not found.\e[0m"
            . main-menu.sh
        fi
        ;;
    4)
        clear
        echo -e "\e[34m-------------------------Drop Database----------------------\e[0m"
        if [ -z "$(ls -A DB)" ]; then
            echo -e "\e[93mThere are No Databases Available Right Now ...\e[0m"
            . main-menu.sh
        else
            ls -F DB | grep / | tr '/' ' '
        fi
        echo -e "\e[34m--------------------------------------------------------------\e[0m"
        read -p "Enter database Name or '0' to go back : " name
        if [[ $name == "0" ]]; then
            clear
            . main-menu.sh
        fi
        if [[ -d DB/$name ]]; then
            read -p "Are You Sure you want to delete [$name] (y/n)? " answer 
            if [[ $answer == [yY] ]]; then
                rm -r DB/$name
                echo -e "\e[92mDatabase [$name] Deleted Successfully.\e[0m"
                echo -e "\e[34m--------------------------------------------------------------\e[0m"
                . main-menu.sh
            elif [[ $answer == [nN] ]]; then
                . main-menu.sh
            else
                echo "Invalid Input Please Try Again ..."
                . main-menu.sh
            fi
        else
            echo -e "\e[91mError: Database not found.\e[0m"
        echo -e "\e[34m--------------------------------------------------------------\e[0m"
        fi
            . main-menu.sh
        ;;
    5)
        echo -e "\e[93mSee You Later ..\e[0m"
        exit 1
        ;;
    *)
        echo -e "\e[91mInvalid option. Please try again.\e[0m"
        . main-menu.sh
        ;;
    esac
done
