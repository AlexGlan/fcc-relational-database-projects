#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

DESCRIBE_ELEMENT() {
    # if no argument provided
    if [[ -z $1 ]]
    then
        echo "Please provide an element as an argument."
        return
    fi

    # if id provided
    if [[ $1 =~ ^[0-9]+$ ]]
    then
        IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING_POINT BOILING_POINT <<< $(
            $PSQL "
            SELECT
                atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
            FROM
                elements
            INNER JOIN
                properties USING(atomic_number)
            INNER JOIN
                types USING(type_id)
            WHERE
                atomic_number=$1
        ")
    # if symbol provided
    elif [[ $(echo $1 | wc -m) -le 3 && $1 =~ ^[a-zA-Z]+$ ]]
    then
        IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING_POINT BOILING_POINT <<< $(
            $PSQL "
            SELECT
                atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
            FROM
                elements
            INNER JOIN
                properties USING(atomic_number)
            INNER JOIN
                types USING(type_id)
            WHERE
                symbol='$1'
        ")
    # if name provided
    elif [[ $1 =~ ^[a-zA-Z]+$ ]]
    then
        IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING_POINT BOILING_POINT <<< $(
            $PSQL "
            SELECT
                atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
            FROM
                elements
            INNER JOIN
                properties USING(atomic_number)
            INNER JOIN
                types USING(type_id)
            WHERE
                name='$1'
        ")
    fi

    # if not found
    if [[ -z $ATOMIC_NUMBER ]]
    then
        echo "I could not find that element in the database."
    else
        echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
}

DESCRIBE_ELEMENT $1
