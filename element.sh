#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if ! [[ $1 =~ ^[0-9]+$ ]]
  then
    PROPERTIES=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties RIGHT JOIN types USING(type_id) RIGHT JOIN elements USING(atomic_number) WHERE symbol='$1' OR name='$1'")
  else
    PROPERTIES=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties RIGHT JOIN types USING(type_id) RIGHT JOIN elements USING(atomic_number) WHERE atomic_number=$1")
  fi
  if [[ -z $PROPERTIES ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$PROPERTIES" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
  fi
fi
