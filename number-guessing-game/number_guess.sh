#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
# echo $($PSQL "TRUNCATE TABLE games, users")

GUESS_NUMBER() {
    if [[ ! $1 ]]
    then
        echo "Guess the secret number between 1 and 1000:"
    fi
    # prompt for a number
    read GUESS
    # if not a number
    if [[ ! $GUESS =~ ^[0-9]+$ ]]
    then
        echo "That is not an integer, guess again:"
    else
        if [[ $GUESS -gt $N ]]
        then
            echo "It's lower than that, guess again:"
        elif [[ $GUESS -lt $N ]]; then
            echo "It's higher than that, guess again:"
        fi
        NUM_OF_TRIES=$(($NUM_OF_TRIES+1))
    fi
    
}

# prompt for username
echo "Enter your username:"
read USERNAME
# find user
USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME'")
# if not found
if [[ -z $USER_ID ]]
then
    # create new user
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME')")
    # get freshly created user id
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME'")
else
    # get user data
    IFS='|' read NAME GAMES BEST_SCORE <<< $(
        $PSQL "
        SELECT
            name, COUNT(game_id), MIN(num_of_tries)
        FROM
            games
        INNER JOIN
            users USING(user_id)
        WHERE
            name='$USERNAME'
        GROUP BY
            name
    ")
    echo "Welcome back, $NAME! You have played $GAMES games, and your best game took $BEST_SCORE guesses."
fi
# generate random number between 1 and 1000
N=$((1 + $RANDOM % 1000))
NUM_OF_TRIES=0

GUESS_NUMBER
until [[ $GUESS -eq $N ]]
do
    GUESS_NUMBER again
done

# insert game record
INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(user_id, num_of_tries) VALUES($USER_ID, $NUM_OF_TRIES)")
echo "You guessed it in $NUM_OF_TRIES tries. The secret number was $N. Nice job!"
