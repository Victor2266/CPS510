#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/passwword@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle12c.cs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl12c)))" <<EOF
/*This is the start of table creations*/
CREATE TABLE SEASONS(
    Season_Name varchar(255) NOT NULL PRIMARY KEY,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL
);

exit;
EOF