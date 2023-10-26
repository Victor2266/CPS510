/*THESE WILL REMOVE PREVIOUSLY CREATED TABLES IN ORDER
// TO MAINTAIN REFERENTIAL INTEGRITY*/
DROP TABLE MEMBERSHIP_LOG;
DROP TABLE REFEREEING_LOG;
DROP TABLE PLAYS_IN;
DROP TABLE GAMES;
DROP TABLE PLAYERS;
DROP TABLE CLUBS;
DROP TABLE STADIUMS;
DROP TABLE MANAGERS;
DROP TABLE REFEREES;
DROP TABLE PERSONS;
DROP TABLE CITIES;
DROP TABLE SEASONS;

/*This is the start of table creations*/
CREATE TABLE SEASONS(
    Season_Name varchar(255) NOT NULL PRIMARY KEY,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL
);
INSERT INTO SEASONS
VALUES('Fall 2023', DATE '2023-09-01', DATE '2023-11-30');
INSERT INTO SEASONS
VALUES('Winter 2023', DATE '2023-12-01', DATE '2024-02-29');
INSERT INTO SEASONS
VALUES('Spring 2024', DATE '2024-03-01', DATE '2024-05-31');
INSERT INTO SEASONS
VALUES('Summer 2024', DATE '2024-06-01', DATE '2024-08-31');

/* Lists the seasons in order of their start date*/
SELECT * FROM SEASONS ORDER BY START_DATE ASC;

CREATE TABLE CITIES(
    City_ID varchar(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,
    City_name varchar(255) NOT NULL,
    State_province varchar(255),
    Country varchar(255)
);

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

SELECT * FROM CITIES;

CREATE TABLE STADIUMS(
    Stadium_name varchar(255) NOT NULL PRIMARY KEY,
    Capacity int,
    Street_num int,
    Street_name varchar(255),
    City_ID varchar(255) NOT NULL,

    CONSTRAINT FK_City_ID FOREIGN KEY (City_ID)
    REFERENCES CITIES(City_ID)
);

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


CREATE TABLE CLUBS(
    Club_name varchar(255) NOT NULL PRIMARY KEY,  
    Home_City varchar(100) NOT NULL,
    Home_Stadium varchar(255),
    Badge BLOB,

    CONSTRAINT FK_Home_City_ID FOREIGN KEY (Home_City)
    REFERENCES CITIES(City_ID),
    CONSTRAINT FK_Stadium_name FOREIGN KEY (Home_Stadium)
    REFERENCES STADIUMS(Stadium_name)
);

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


CREATE TABLE GAMES(
    Unique_ID varchar(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,
    Match_date DATE DEFAULT SYSDATE,
    Team_Home varchar(255),
    Team_Away varchar(255),
    Held_in_stadium varchar(255),
    Goals_home INT DEFAULT 0,
    Goals_away INT DEFAULT 0,
    Yellow_cards INT DEFAULT 0,
    Red_cards INT DEFAULT 0,

    CONSTRAINT FK_Home_Team FOREIGN KEY (Team_Home)
    REFERENCES CLUBS(Club_name),
    CONSTRAINT FK_Away_Team FOREIGN KEY (Team_Away)
    REFERENCES CLUBS(Club_name),
    CONSTRAINT FK_Stadium FOREIGN KEY (Held_in_stadium)
    REFERENCES STADIUMS(Stadium_name)
);

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


CREATE TABLE PERSONS( 
    Person_ID VARCHAR(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,
    First_name VARCHAR(255) NOT NULL,
    Last_name VARCHAR(255) NOT NULL,
    Date_of_birth DATE,
    Picture BLOB,
    Height_In_cm INT,
    Birth_City VARCHAR(100) NOT NULL,

    CONSTRAINT FK_City FOREIGN KEY (Birth_City)
    REFERENCES CITIES(City_ID)
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


CREATE TABLE MANAGERS(
	Num_matches INT DEFAULT 0,
	Matches_won INT DEFAULT 0,
	Matches_draw INT DEFAULT 0,
	Matches_lost INT DEFAULT 0,
	Manager_ID VARCHAR(100) NOT NULL PRIMARY KEY,
    CONSTRAINT FK_Manager_ID FOREIGN KEY (Manager_ID)
    REFERENCES PERSONS(Person_ID)
);

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


CREATE TABLE REFEREES(
    Num_matches INT DEFAULT 0,
    Yellow_cards INT DEFAULT 0,
    Red_cards INT DEFAULT 0,
    Num_whistles INT DEFAULT 0,
    Referee_ID VARCHAR(100) NOT NULL PRIMARY KEY,
    CONSTRAINT FK_Referee_ID FOREIGN KEY (Referee_ID)
    REFERENCES PERSONS(Person_ID) 
);

INSERT INTO REFEREES(Referee_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Jose' AND Last_name = 'Altidore'));

INSERT INTO REFEREES(Referee_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Martin' AND Last_name = 'Tyler'));

INSERT INTO REFEREES(Referee_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Jorj' AND Last_name = 'Santos'));

INSERT INTO REFEREES(Referee_ID)
VALUES((SELECT Person_ID FROM PERSONS WHERE First_name = 'Mateu' AND Last_name = 'Lahoz'));


CREATE TABLE PLAYERS(
    Shirt_number INT,
    Position VARCHAR(20),
    Num_matches INT DEFAULT 0,
    Matches_won INT DEFAULT 0,
    Matches_draw INT DEFAULT 0,
    Matches_lost INT DEFAULT 0,
    Goals INT DEFAULT 0,
    Min_played INT DEFAULT 0,
    Yellow_Cards INT DEFAULT 0,
    Red_Cards INT DEFAULT 0,
    Wage DECIMAL(16, 2) DEFAULT 0.00,

    Player_ID VARCHAR(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,
    CONSTRAINT FK_Player_ID FOREIGN KEY (Player_ID)
    REFERENCES PERSONS(Person_ID),

    Managed_By varchar(100),
    CONSTRAINT FK_Manager FOREIGN KEY (Managed_By)
    REFERENCES MANAGERS(Manager_ID),
    Member_Of varchar(255),
    CONSTRAINT FK_Parent_Club FOREIGN KEY (Member_Of )
    REFERENCES CLUBS(Club_name)
);

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

CREATE TABLE REFEREEING_LOG(
    Unique_ID varchar(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,

    Referee varchar(100),
    CONSTRAINT FK_Referee FOREIGN KEY (Referee)
    REFERENCES REFEREES(Referee_ID),

    Game varchar(100),
    CONSTRAINT FK_Game FOREIGN KEY (Game)
    REFERENCES GAMES(Unique_ID)
);

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


CREATE TABLE PLAYS_IN(
    Unique_ID VARCHAR(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,
    
    Goals_in_game INT DEFAULT 0 NOT NULL,
    Yellow_Cards_in_game INT DEFAULT 0 NOT NULL,
    Red_Cards_in_game INT DEFAULT 0 NOT NULL,

    PlayingPlayer varchar(100),
    CONSTRAINT FK_PlayingPlayer FOREIGN KEY (PlayingPlayer)
    REFERENCES PLAYERS(Player_ID),

    Game varchar(100),
    CONSTRAINT FK_PlaysIn_Game FOREIGN KEY (Game)
    REFERENCES GAMES(Unique_ID)
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


CREATE TABLE MEMBERSHIP_LOG(
    Unique_ID VARCHAR(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,
    
    Player varchar(100),
    CONSTRAINT FK_AssociatedPlayer FOREIGN KEY (Player)
    REFERENCES PLAYERS(Player_ID),

    Club varchar(255),
    CONSTRAINT FK_AssociatedClub FOREIGN KEY (Club)
    REFERENCES CLUBS(Club_name),

    Season varchar(255),
    CONSTRAINT FK_DuringSeason FOREIGN KEY (Season)
    REFERENCES SEASONS(Season_Name)
);

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



/*This QUERY LISTS OUT ALL THE PRESENT AND PAST MEMBERSHIPS OF EVERY PLAYER */
SELECT PERSONS.first_name, PERSONS.last_name, MEMBERSHIP_LOG.club, MEMBERSHIP_LOG.season
FROM MEMBERSHIP_LOG, PERSONS
WHERE MEMBERSHIP_LOG.PLAYER = PERSONS.PERSON_ID ORDER BY PERSONS.first_name ASC;

/* Selects the player_ID(s) where the players first name which is stored in the PERSONS table matches Jose*/ 
SELECT PLAYERS.Player_ID AS "PLAYER_ID FROM FIRST NAME"
FROM PLAYERS, PERSONS
WHERE PLAYERS.Player_ID = PERSONS.Person_ID
AND PERSONS.First_Name = 'Jose';

SELECT PLAYERS.Player_ID AS "PLAYER_ID FROM FIRST NAME INNER JOIN"
FROM PLAYERS 
INNER JOIN PERSONS
ON PLAYERS.Player_ID = PERSONS.Person_ID
Where PERSONS.First_name = 'Jose';

/*Query used to order every referee according to their date of birth in ascending order. */
SELECT * FROM PERSONS ORDER BY Date_of_birth ASC;
/*Query used to obtain the average number of goals made by certain positions.*/
SELECT Position, AVG(Goals) AS AvgGoals
FROM PLAYERS
GROUP BY Position;
/*Query used to obtain players who are managed by the same person (Thomas Tuchel) */
SELECT * FROM PLAYERS WHERE Managed_By = (SELECT Person_ID FROM PERSONS WHERE First_name = 'Thomas' AND Last_name = 'Tuchel');
/*Query used to obtain stadium name that a game is being held at*/
SELECT * FROM GAMES WHERE Held_in_stadium = 'Allianz Arena';


/*Query used to order every person according to their first name in ascending order. */
SELECT REFEREES.*, PERSONS.* from REFEREES, PERSONS WHERE (REFEREES.referee_id = PERSONS.person_id) ORDER BY First_Name ASC;
/*Query used to order every club according name in ascending order. */
SELECT * FROM CLUBS ORDER BY Club_name ASC;

/*Query used to check which players have 2 goals in the game */
SELECT * FROM PLAYS_IN WHERE Goals_in_game = 2;

/*This Query lists all the players including their personal information on record*/
select *
from PERSONS, PLAYERS
where PERSONS.person_id = players.player_id;

/*tHIS VIEW SHOWS ALL THE PLAYER INFO INCLUDING PERSONAL INFO AND EXCLUDES DUPLICATE COLUMNS LIKE ID*/
DROP VIEW List_of_player_info;

CREATE VIEW List_of_Player_Info AS
SELECT PERSONS.*, PLAYERS.SHIRT_NUMBER, PLAYERS.POSITION, PLAYERS.NUM_MATCHES, PLAYERS.MATCHES_WON, PLAYERS.MATCHES_DRAW, PLAYERS.MATCHES_LOST, PLAYERS.GOALS, PLAYERS.MIN_PLAYED, PLAYERS.YELLOW_CARDS, PLAYERS.RED_CARDS, PLAYERS.WAGE, PLAYERS.MANAGED_BY, PLAYERS.MEMBER_OF
FROM PERSONS, PLAYERS
WHERE PERSONS.person_id = players.player_id;

Select * FROM List_of_Player_Info;

/*tHIS VIEW SHOWS ALL THE PLAYER INFO INCLUDING PERSONAL INFO AND EXCLUDES DUPLICATE COLUMNS LIKE ID THAT WERE ACTIVE DURING A SPECIFIC SEASON*/
DROP VIEW List_of_Player_Info_FILTERED_BY_SEASON;

CREATE VIEW List_of_Player_Info_FILTERED_BY_SEASON AS
SELECT PERSONS.*, PLAYERS.SHIRT_NUMBER, PLAYERS.POSITION, PLAYERS.NUM_MATCHES, PLAYERS.MATCHES_WON, PLAYERS.MATCHES_DRAW, PLAYERS.MATCHES_LOST, PLAYERS.GOALS, PLAYERS.MIN_PLAYED, PLAYERS.YELLOW_CARDS, PLAYERS.RED_CARDS, PLAYERS.WAGE, PLAYERS.MANAGED_BY, PLAYERS.MEMBER_OF
FROM PERSONS, PLAYERS, MEMBERSHIP_LOG
WHERE PERSONS.person_id = players.player_id
AND PERSONS.person_ID = MEMBERSHIP_LOG.PLAYER
AND MEMBERSHIP_LOG.SEASON = 'Fall 2023';
/* incorreect condition: AND PERSONS.person_id in (SELECT MEMBERSHIP_LOG.PLAYER FROM MEMBERSHIP_LOG WHERE MEMBERSHIP_LOG.SEASON = 'Fall 2023');*/

Select * FROM List_of_Player_Info_FILTERED_BY_SEASON;


/*Inserting more player into the Players table*/

INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Jose', 'Gaya', DATE'2006-8-10', 170 , (SELECT City_ID FROM CITIES WHERE 
City_name = 'East Brampton'));

INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(23, 'Left Back', 24, 17, 0, 7, 10, 140, 2, 1, 150.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'Jose' AND Last_name = 'Gaya'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Xavier' AND Last_name = 'Creus' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Barcelona'));


INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('James', 'McDonald', DATE'1998-08-23', 185 , (SELECT City_ID FROM CITIES WHERE City_name = 'Barcelona'));

INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(3, 'Left Back', 24, 18, 4, 2, 2, 125, 3, 4, 100.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'James' AND Last_name = 'McDonald'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Xavier' AND Last_name = 'Creus' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Barcelona'));


INSERT INTO PERSONS(First_name, Last_name, Date_of_birth, Height_In_cm, Birth_City)
VALUES('Lamine', 'Yamal', DATE'2007-07-23', 180 , (SELECT City_ID FROM CITIES WHERE City_name = 'Barcelona'));

INSERT INTO PLAYERS(Shirt_number, Position, Num_matches, Matches_won, Matches_draw, Matches_lost, Goals, Min_played, Yellow_cards, Red_cards, Wage, Player_ID, Managed_by, Member_of)
VALUES(27, 'Right Wing', 24, 18, 4, 2, 2, 190, 0, 0, 160.00, (SELECT Person_ID FROM PERSONS WHERE First_name = 'Lamine' AND Last_name = 'Yamal'), (SELECT Person_ID FROM PERSONS WHERE First_name = 'Xavier' AND Last_name = 'Creus' ), (SELECT Club_name FROM CLUBS WHERE Club_name = 'FC Barcelona'));


/*Query to VIEW which club players are a member of*/
DROP VIEW View_FCBarcelona_Players;

CREATE VIEW View_FCBarcelona_Players AS
SELECT * FROM Players
WHERE Member_of = 'FC Barcelona';

/*View for ALL CLUBS THAT HAVE MEMBERS ACCORDING TO THE MEMBERSHIP LOG*/
DROP VIEW CLUBS_THAT_HAVE_MEMBERS;

CREATE VIEW CLUBS_THAT_HAVE_MEMBERS AS
SELECT DISTINCT CLUBS.CLUB_NAME, CLUBS.HOME_CITY, CLUBS.HOME_STADIUM FROM CLUBS, MEMBERSHIP_LOG
WHERE CLUBS.CLUB_NAME IN (MEMBERSHIP_LOG.CLUB);

SELECT * FROM CLUBS_THAT_HAVE_MEMBERS;

/*View for ALL CLUBS THAT HAVE MEMBERS ACCORDING TO THE MEMBERSHIP LOG DURING SUMMER 2024*/
DROP VIEW CLUBS_THAT_HAVE_MEMBERS_SUMMER_2024;

CREATE VIEW CLUBS_THAT_HAVE_MEMBERS_SUMMER_2024 AS
SELECT DISTINCT CLUBS.CLUB_NAME, CLUBS.HOME_CITY, CLUBS.HOME_STADIUM FROM CLUBS, MEMBERSHIP_LOG, SEASONS
WHERE CLUBS.CLUB_NAME = MEMBERSHIP_LOG.CLUB
AND MEMBERSHIP_LOG.SEASON = 'Summer 2024';

SELECT * FROM CLUBS_THAT_HAVE_MEMBERS_SUMMER_2024;

/*Select players from FC Barcelona who have a yellow card or Red card*/

SELECT 'FC_Barcelona PLayers with yellow or red card', FIRST_NAME, LAST_NAME
FROM PLAYERS, PERSONS
WHERE Member_of = 'FC Barcelona'
      AND (Yellow_cards > 0 or Red_cards > 0)
      AND PLAYERS.PLAYER_ID = PERSONS.PERSON_ID
ORDER BY FIRST_NAME ASC;

/*Select players who have at least 15 matches played and at least 10 wins */
SELECT 'Players with atleast 15 matches and 10 wins', FIRST_NAME, LAST_NAME
FROM  PLAYERS, PERSONS
WHERE Num_matches >= 15
    AND Matches_won >=10
    AND PLAYERS.PLAYER_ID = PERSONS.PERSON_ID
ORDER BY Matches_won DESC;

/*Query that shows the number of players who have won over 4 matches*/
SELECT COUNT(*) AS PlayersWithMoreThan4Wins
FROM PLAYERS p
WHERE Matches_won > 4;

/*Query that shows the clubs that have scored the greatest average of goals*/
WITH ClubAvgGoals AS (
    SELECT p.Member_Of AS Club, AVG(p.Goals) AS AvgGoals
    FROM PLAYERS p
    GROUP BY p.Member_Of
)
SELECT Club AS HighestAvgScoringClubs
FROM ClubAvgGoals
WHERE AvgGoals = (
    SELECT MAX(AvgGoals) 
    FROM ClubAvgGoals);

/*Query to show which games do not have a referee*/
SELECT *
FROM GAMES
WHERE NOT EXISTS (
    SELECT REFEREEING_LOG.UNIQUE_ID
    FROM REFEREEING_LOG, GAMES
    WHERE REFEREEING_LOG.Game = GAMES.Unique_ID
);

/*selects clubs with average goal more than 5 or equal to 1*/
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

SELECT * FROM SEASONS;
SELECT * FROM MEMBERSHIP_LOG;
SELECT * FROM GAMES;
SELECT * FROM CLUBS;
SELECT * FROM STADIUMS;
SELECT * FROM PERSONS;
SELECT * FROM PLAYERS;
