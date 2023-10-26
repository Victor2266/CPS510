#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/passwword@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.cs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF
set sqlblanklines on

/*
Select players from FC Barcelona who have a yellow card or Red card
*/
SELECT 'FC_Barcelona PLayers with yellow or red card', FIRST_NAME, LAST_NAME
FROM PLAYERS, PERSONS
WHERE Member_of = 'FC Barcelona'
      AND (Yellow_cards > 0 or Red_cards > 0)
      AND PLAYERS.PLAYER_ID = PERSONS.PERSON_ID
ORDER BY FIRST_NAME ASC;

/*
Select players who have at least 15 matches played and at least 10 wins
*/
SELECT 'Players with atleast 15 matches and 10 wins', FIRST_NAME, LAST_NAME
FROM  PLAYERS, PERSONS
WHERE Num_matches >= 15
    AND Matches_won >=10
    AND PLAYERS.PLAYER_ID = PERSONS.PERSON_ID
ORDER BY Matches_won DESC;

/*
Query that shows the number of players who have won over 4 matches [HAS COUNT]
*/
SELECT COUNT(*) AS PlayersWithMoreThan4Wins
FROM PLAYERS p
WHERE Matches_won > 4;

/*
Query that shows the clubs that have scored the greatest average of goals [HAS AVG, GROUP BY]
*/
WITH ClubAvgGoals AS (
    SELECT p.Member_Of AS Club, AVG(p.Goals) AS AvgGoals
    FROM PLAYERS p
    GROUP BY p.Member_Of
)
SELECT Club AS HighestAvgScoringClubs
FROM ClubAvgGoals
WHERE AvgGoals = (
    SELECT MAX(AvgGoals) 
    FROM ClubAvgGoals
);

/*
Query to show which games do not have a referee [HAS NOT EXIST]
*/
SELECT *
FROM GAMES
WHERE NOT EXISTS (
    SELECT REFEREEING_LOG.UNIQUE_ID
    FROM REFEREEING_LOG, GAMES
    WHERE REFEREEING_LOG.Game = GAMES.Unique_ID
);


/*
selects clubs with average goal more than 5 or equal to 1
*/
SELECT p.Member_Of AS Club_GR_5_or_EQ_1, AVG(p.Goals) AS AvgGoals
FROM PLAYERS p
GROUP BY p.Member_Of
HAVING AVG(p.Goals) > 5
UNION
SELECT p.Member_Of AS Club_GR_5_or_EQ_1, AVG(p.Goals) AS AvgGoals
FROM PLAYERS p
GROUP BY p.Member_Of
HAVING AVG(p.Goals) = 1;

/*
All the clubs that do not have the rogers centre as a home stadium
*/
SELECT CLUBS.CLUB_NAME AS CLUBS_EXCLUDING_ROGERS_CENTRE FROM CLUBS MINUS SELECT CLUBS.CLUB_NAME FROM CLUBS WHERE CLUBS.HOME_STADIUM = 'Rogers Centre';

exit;
EOF