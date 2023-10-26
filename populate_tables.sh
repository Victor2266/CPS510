#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/passwword@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.cs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF

INSERT INTO SEASONS
VALUES('Fall 2023', DATE '2023-09-01', DATE '2023-11-30');
INSERT INTO SEASONS
VALUES('Winter 2023', DATE '2023-12-01', DATE '2024-02-29');
INSERT INTO SEASONS
VALUES('Spring 2024', DATE '2024-03-01', DATE '2024-05-31');
INSERT INTO SEASONS
VALUES('Summer 2024', DATE '2024-06-01', DATE '2024-08-31');

INSERT INTO CITIES(City_name, State_province, Country)
VALUES('East Brampton', 'Ontario', 'Canada');
INSERT INTO CITIES(City_name, State_province, Country)
VALUES('Toronto', 'Ontario', 'Canada');
INSERT INTO CITIES(City_name, State_province, Country)
VALUES('Munich', 'Bavaria', 'Germany');
INSERT INTO CITIES(City_name, State_province, Country)
VALUES('Barcelona', 'Catalonia', 'Spain');
INSERT INTO CITIES(City_name, State_province, Country)
VALUES('Liverpool', '', 'England');
INSERT INTO CITIES(City_name, State_province, Country)
VALUES('Manchester', '', 'England');

INSERT INTO STADIUMS
VALUES('Rogers Centre', 49286, 1, 'Blue Jays Way', (SELECT City_ID FROM CITIES WHERE City_name = 'Toronto'));
INSERT INTO STADIUMS
VALUES('Allianz Arena', 75024, 25, 'Werner-Heisenberg-Allee', (SELECT City_ID FROM CITIES WHERE City_name = 'Munich'));
INSERT INTO STADIUMS
VALUES('Spotify Camp Nou', 99354, 12, 'C/ dArístides Maillol', (SELECT City_ID FROM CITIES WHERE City_name = 'Barcelona'));
INSERT INTO STADIUMS
VALUES('Anfield Stadium', 54074, 1, 'Anfield Rd', (SELECT City_ID FROM CITIES WHERE City_name = 'Liverpool'));
INSERT INTO STADIUMS
VALUES('Etihad Stadium', 53400, 1, 'Ashton New Rd', (SELECT City_ID FROM CITIES WHERE City_name = 'Manchester'));

INSERT INTO CLUBS
VALUES('Toronto FC Juniors', (SELECT City_ID FROM CITIES WHERE City_name = 'Toronto'), (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Rogers Centre'), NULL);
INSERT INTO CLUBS
VALUES('SC Toronto Clubhouse', (SELECT City_ID FROM CITIES WHERE City_name = 'Toronto'), (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Rogers Centre'), NULL);
INSERT INTO CLUBS
VALUES('FC Bayern Munich', (SELECT City_ID FROM CITIES WHERE City_name = 'Munich'), (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Allianz Arena'), NULL);
INSERT INTO CLUBS
VALUES('FC Barcelona', (SELECT City_ID FROM CITIES WHERE City_name = 'Barcelona'), (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Spotify Camp Nou'), NULL);
INSERT INTO CLUBS
VALUES('FC Liverpool', (SELECT City_ID FROM CITIES WHERE City_name = 'Liverpool'), (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Anfield Stadium'), NULL);
INSERT INTO CLUBS
VALUES('Manchester City', (SELECT City_ID FROM CITIES WHERE City_name = 'Manchester'), (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Etihad Stadium'), NULL);


INSERT INTO GAMES (Team_Home, Team_Away, Held_in_stadium)
VALUES (
    (SELECT Club_name FROM CLUBS WHERE Club_name = 'Toronto FC Juniors'),
    (SELECT Club_name FROM CLUBS WHERE Club_name = 'SC Toronto Clubhouse'),
    (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Rogers Centre')
);
INSERT INTO GAMES (Team_Home, Team_Away, Held_in_stadium)
VALUES (
    (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Bayern Munich'),
    (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Liverpool'),
    (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Allianz Arena')
);
INSERT INTO GAMES (Team_Home, Team_Away, Held_in_stadium)
VALUES (
    (SELECT Club_name FROM CLUBS WHERE Club_name = 'Manchester City'),
    (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Barcelona'),
    (SELECT Stadium_name FROM STADIUMS WHERE Stadium_name = 'Etihad Stadium')
);

INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Jose', 'Altidore', DATE'2008-11-11', 180 , (SELECT City_ID FROM CITIES WHERE City_name = 'Toronto'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Alphonso', 'Davies', DATE'2000-11-02', 183 , (SELECT City_ID FROM CITIES WHERE City_name = 'Munich'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Harry', 'Kane', DATE'1993-07-28', 188 , (SELECT City_ID FROM CITIES WHERE City_name = 'Munich'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Robert', 'Lewandowski', DATE'1988-08-21', 185 , (SELECT City_ID FROM CITIES WHERE City_name = 'Barcelona'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Virgil', 'Van Dijk', DATE'1991-07-08', 195 , (SELECT City_ID FROM CITIES WHERE City_name = 'Liverpool'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Bernardo', 'Silvia', DATE'1994-08-10', 173 , (SELECT City_ID FROM CITIES WHERE City_name = 'Manchester'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Thomas', 'Tuchel', DATE'1973-08-29', 192 , (SELECT City_ID FROM CITIES WHERE City_name = 'Munich'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Jurgen', 'Klopp', DATE'1967-06-16', 191 , (SELECT City_ID FROM CITIES WHERE City_name = 'Liverpool'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Xavier', 'Creus', DATE'1980-01-25', 170 , (SELECT City_ID FROM CITIES WHERE City_name = 'Barcelona'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Josep', 'Guardiola', DATE'1971-01-18', 170 , (SELECT City_ID FROM CITIES WHERE City_name = 'Manchester'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Martin', 'Tyler', DATE'1970-10-17', 176 , (SELECT City_ID FROM CITIES WHERE City_name = 'Barcelona'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Jorj', 'Santos', DATE'1974-06-16', 173 , (SELECT City_ID FROM CITIES WHERE City_name = 'Manchester'));
INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Mateu', 'Lahoz', DATE'1978-04-14', 180 , (SELECT City_ID FROM CITIES WHERE City_name = 'Toronto'));

INSERT INTO MANAGERS(Manager_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE (First_name = 'Jose' AND Last_name = 'Altidore')));
INSERT INTO MANAGERS(Manager_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE (First_name = 'Thomas' AND Last_name = 'Tuchel')));
INSERT INTO MANAGERS(Manager_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE (First_name = 'Jurgen' AND Last_name = 'Klopp')));
INSERT INTO MANAGERS(Manager_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE (First_name = 'Xavier' AND Last_name = 'Creus')));
INSERT INTO MANAGERS(Manager_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE (First_name = 'Josep' AND Last_name = 'Guardiola')));


INSERT INTO REFEREES(Referee_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Jose' AND Last_name = 'Altidore'));
INSERT INTO REFEREES(Referee_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Martin' AND Last_name = 'Tyler'));
INSERT INTO REFEREES(Referee_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Jorj' AND Last_name = 'Santos'));
INSERT INTO REFEREES(Referee_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Mateu' AND Last_name = 'Lahoz'));

INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(5, 'Right Wing', 25, 13, 3, 9, 10, 140, 5, 3, 150.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'Jose' AND Last_name = 'Altidore'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Jose' AND Last_name = 'Altidore' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'Toronto FC Juniors'));
INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(11, 'Left Wing', 15, 10, 1, 4, 6, 70, 2, 0, 100.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'Alphonso' AND Last_name = 'Davies'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Thomas' AND Last_name = 'Tuchel' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Bayern Munich'));
INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(7, 'Defender', 8, 4, 2, 2, 2, 60, 0, 1, 90.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'Harry' AND Last_name = 'Kane'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Thomas' AND Last_name = 'Tuchel' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Bayern Munich'));
INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(2, 'Center', 20, 8, 4, 8, 2, 120, 3, 1, 80.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'Robert' AND Last_name = 'Lewandowski'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Xavier' AND Last_name = 'Creus' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Barcelona'));
INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(10, 'Left Wing', 30, 17, 3, 10, 10, 200, 4, 2, 200.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'Virgil' AND Last_name = 'Van Dijk'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Jurgen' AND Last_name = 'Klopp' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Liverpool'));
INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(16, 'Right Wing', 12, 5, 1, 6, 1, 70, 0, 1, 60.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'Bernardo' AND Last_name = 'Silvia'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Josep' AND Last_name = 'Guardiola' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'Manchester City'));

INSERT INTO REFEREEING_LOG(Referee, Game)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Jose'), 
        (SELECT Unique_ID FROM GAMES WHERE Team_Home = 'Toronto FC Juniors')
);
/* These three statements insert randomized values into the refereeing log*/
INSERT INTO REFEREEING_LOG(Referee, Game)
VALUES(
(SELECT REFEREE_ID FROM (SELECT REFEREE_ID FROM REFEREES ORDER BY dbms_random.value) where rownum = 1), 
(SELECT Unique_ID FROM (SELECT Unique_ID FROM GAMES ORDER BY dbms_random.value) where rownum = 1)
);
INSERT INTO REFEREEING_LOG(Referee, Game)
VALUES(
(SELECT REFEREE_ID FROM (SELECT REFEREE_ID FROM REFEREES ORDER BY dbms_random.value) where rownum = 1), 
(SELECT Unique_ID FROM (SELECT Unique_ID FROM GAMES ORDER BY dbms_random.value) where rownum = 1)
);
INSERT INTO REFEREEING_LOG(Referee, Game)
VALUES(
(SELECT REFEREE_ID FROM (SELECT REFEREE_ID FROM REFEREES ORDER BY dbms_random.value) where rownum = 1), 
(SELECT Unique_ID FROM (SELECT Unique_ID FROM GAMES ORDER BY dbms_random.value) where rownum = 1)
);


INSERT INTO PLAYS_IN(PlayingPlayer, Game)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Jose'),
        (SELECT Unique_ID FROM GAMES WHERE Team_Home = 'Toronto FC Juniors')
);
INSERT INTO PLAYS_IN(PlayingPlayer, Game)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Harry'),
        (SELECT Unique_ID FROM GAMES WHERE Team_Home = 'Bayern Munich')
);
INSERT INTO PLAYS_IN(PlayingPlayer, Game)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Alphonso'),
        (SELECT Unique_ID FROM GAMES WHERE Team_Home = 'Bayern Munich')
);

UPDATE PLAYS_IN
SET Goals_in_game = 2
WHERE (PlayingPlayer = (Select Person_ID FROM PERSONS WHERE first_name = 'Jose'));

UPDATE PLAYS_IN
SET Goals_in_game = 2
WHERE (PlayingPlayer = (Select Person_ID FROM PERSONS WHERE first_name = 'Harry'));

UPDATE PLAYS_IN
SET Goals_in_game = 1
WHERE (PlayingPlayer = (Select Person_ID FROM PERSONS WHERE first_name = 'Alphonso'));


INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Jose'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'Toronto FC Juniors'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Fall 2023')
);

INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Alphonso'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Bayern Munich'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Fall 2023')
);

INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Harry'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Bayern Munich'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Fall 2023')
);

INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Robert'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Barcelona'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Fall 2023')
);

INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Virgil'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Liverpool'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Fall 2023')
);

INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Bernardo'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'Manchester City'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Fall 2023')
);

INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Robert'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Barcelona'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Winter 2023')
);
INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Virgil'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Liverpool'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Spring 2024')
);
INSERT INTO MEMBERSHIP_LOG(Player, Club, Season)
VALUES(
(SELECT PLAYERS.Player_ID
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Bernardo'),
(SELECT Club_name FROM CLUBS WHERE Club_name = 'Manchester City'),
(SELECT Season_Name From SEASONS WHERE Season_Name = 'Summer 2024')
);



exit;
EOF