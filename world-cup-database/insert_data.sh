#! /bin/bash

if [[ $1 == "test" ]]
then
    PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
    PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# ================
# echo $($PSQL "TRUNCATE teams, games")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPP_GOALS
do
    if [[ $YEAR != 'year' ]]
    then
        # get team id's
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

        # if winner not found
        if [[ -z $WINNER_ID ]]
        then
            # insert winner team
            INSERT_WINNER_RES=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            if [[ $INSERT_WINNER_RES == "INSERT 0 1" ]]
            then
                echo Inserted into teams: $WINNER
            fi
            # get new winner id
            WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        fi

        # if opponent not found
        if [[ -z $OPP_ID ]]
        then
            # insert opponent team
            INSERT_OPP_RES=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            if [[ $INSERT_OPP_RES == "INSERT 0 1" ]]
            then
                echo Inserted into teams: $OPPONENT
            fi
            # get new opponent id
            OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        fi
        
        # insert into games
        INSERT_GAME_RES=$(
            $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
            VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPP_ID, $WINNER_GOALS, $OPP_GOALS)"
        )
        if [[ $INSERT_GAME_RES == 'INSERT 0 1' ]]
        then
            echo Inserted into games: $WINNER VS $OPPONENT $ROUND - $YEAR
        fi
    fi
done
