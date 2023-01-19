#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c";
if [[ -z $1 ]]
then
    #if no arguments echo message
    echo "Please provide an element as an argument.";
else
    #check if argument contains a letter (hence, not being a valid atomic number)
    if ! [[ $1 =~ [a-Z] ]]
    then
        #get atomic_number
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;");
    else
        if [[ ${#1} -le 2 ]]
        then
            ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';");
	    else
            ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';");
        fi
    fi
    if [[ -z $ATOMIC_NUMBER ]]
    then
        echo "I could not find that element in the database.";
    else
        #get data
    fi
fi