#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
# check for arguments
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
        #get name
        NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER;");
        #get symbol
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER;");
        #get type
        TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER;");
        #get atomic_mass
        ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;");
        #get melting_point
        MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;");
        #get boiling_point
        BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;");
        
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
fi
