#!/bin/sh

DisplayStartingText(){
    clear
    echo
    "================================================================="
    echo "| Oracle All Inclusive Tool
|"
    echo "| Main Menu - Select Desired Operation(s):
|"
    echo "| <CTRL-Z Anytime to Enter Interactive CMD Prompt>
|"
    echo "-------------------------------------------------------------
----"
    echo " $IS_SELECTEDM M) View Manual"
    echo " "
    echo " $IS_SELECTED1 1) Drop Tables"
    echo " $IS_SELECTED2 2) Create Tables"
    echo " $IS_SELECTED3 3) Populate Tables"
    echo " $IS_SELECTED4 4) Query Tables"
    echo " "
    echo " $IS_SELECTEDX X) Force/Stop/Kill Oracle DB"
    echo " "
    echo " $IS_SELECTEDE E) End/Exit"
    echo "Choose: "
}

MainMenu() {
    DisplayStartingText
    while [ "$CHOICE" != "START" ]; 
    do

        read CHOICE
        if [ "$CHOICE" == "0" ]; then
            echo "Choice was '0'."
        elif [ "$CHOICE" == "1" ]; then
            bash drop_tables.sh
            Pause
        elif [ "$CHOICE" == "2" ]; then
            bash create_tables.sh
            Pause
        elif [ "$CHOICE" == "3" ]; then
            bash populate_tables.sh
            Pause
        elif [ "$CHOICE" == "4" ]; then
            bash queries.sh
            Pause
        elif [ "$CHOICE" == "X" ]; then
            echo "You do not have permission, try to kill Oracle DB from outside this menu."
            exit
        elif [ "$CHOICE" == "E" ]; then
            exit
        elif [ "$CHOICE" == "M" ]; then
            echo "THE INSTRUCTIONS ABOVE ARE THE MANUAL, TYPE IN THE NUMBER/LETTER IN UPPERCASE TO PERFORM THE ACTION"
        elif [ "$CHOICE" == "" ]; then
            DisplayStartingText
        fi
    done
}
#--COMMENTS BLOCK--
# Main Program
#--COMMENTS BLOCK--
ProgramStart() {
    StartMessage
    while [ 1 ]; do
        MainMenu

    done
}
ProgramStart
