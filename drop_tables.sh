#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF

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
exit;
EOF