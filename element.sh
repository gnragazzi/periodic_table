#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c";
if [[ -z $1 ]]
then
    #if no arguments echo message
    echo "Please provide an element as an argument.";
else
    #check if argument contains a letter (hence, not being a valid atomic number)
    
fi