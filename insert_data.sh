#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

W=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

if [[ $WINNER != "winner" ]]
  then
     # get major_id
    TEAM=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    if [[ -z $TEAM ]]
    then
      # insert major
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi

fi
fi

if [[ $OPPONENT != "opponent" ]]
  then
     # get major_id
    TEAM=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $TEAM ]]
    then
      # insert major
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
fi
fi
L=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
W=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")



if [[ -n $W || -n $L ]]
then
  if [[ $YEAR!="year" && $ROUND!="round" && $WINNER_GOALS!="winner_goals" && $OPPONENT_GOALS!="opponent_goals" ]]
   then
echo $($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES('$YEAR','$ROUND','$W','$L','$WINNER_GOALS','$OPPONENT_GOALS')")

   fi
fi
done
