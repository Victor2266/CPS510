#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/passwword@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.cs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF
set sqlblanklines on
#/*This is the start of table creations*/
CREATE TABLE SEASONS(
    Season_Name varchar(255) NOT NULL PRIMARY KEY,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL
);

CREATE TABLE CITIES(
    City_ID varchar(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,
    City_name varchar(255) NOT NULL,
    State_province varchar(255),
    Country varchar(255)
);

CREATE TABLE STADIUMS(
    Stadium_name varchar(255) NOT NULL PRIMARY KEY,
    Capacity int,
    Street_num int,
    Street_name varchar(255),
    City_ID varchar(255) NOT NULL,

    CONSTRAINT FK_City_ID FOREIGN KEY (City_ID)
    REFERENCES CITIES(City_ID)
);


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

CREATE TABLE MANAGERS(
	Num_matches INT DEFAULT 0,
	Matches_won INT DEFAULT 0,
	Matches_draw INT DEFAULT 0,
	Matches_lost INT DEFAULT 0,
	Manager_ID VARCHAR(100) NOT NULL PRIMARY KEY,
    CONSTRAINT FK_Manager_ID FOREIGN KEY (Manager_ID)
    REFERENCES PERSONS(Person_ID)
);

CREATE TABLE REFEREES(
    Num_matches INT DEFAULT 0,
    Yellow_cards INT DEFAULT 0,
    Red_cards INT DEFAULT 0,
    Num_whistles INT DEFAULT 0,
    Referee_ID VARCHAR(100) NOT NULL PRIMARY KEY,
    CONSTRAINT FK_Referee_ID FOREIGN KEY (Referee_ID)
    REFERENCES PERSONS(Person_ID) 
);

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

CREATE TABLE REFEREEING_LOG(
    Unique_ID varchar(100) DEFAULT SYS_GUID() NOT NULL PRIMARY KEY,

    Referee varchar(100),
    CONSTRAINT FK_Referee FOREIGN KEY (Referee)
    REFERENCES REFEREES(Referee_ID),

    Game varchar(100),
    CONSTRAINT FK_Game FOREIGN KEY (Game)
    REFERENCES GAMES(Unique_ID)
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




exit;
EOF