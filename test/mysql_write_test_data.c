/* Simple C program that connects to MySQL Database server*/
#include <mysql.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void finish_with_error(MYSQL *con);

int main() {
	int i = 0;
	double rand_val;
	char tmp_ins[200];
	MYSQL *conn;
	MYSQL_RES *res;
	MYSQL_ROW row;
	char *server = "localhost";
	char *user = "root";
	char *password = ""; /* set me first */
	char *database = "testdb";
	conn = mysql_init(NULL);
	/* Connect to database */
	if (!mysql_real_connect(conn, server, user, password, database, 0, NULL,
			0)) {
		fprintf(stderr, "%s\n", mysql_error(conn));
		exit(1);
	}

	if (mysql_query(conn, "CREATE DATABASE IF NOT EXISTS testdb")) {
		fprintf(stderr, "%s\n", mysql_error(conn));
		mysql_close(conn);
		exit(1);
	}
	if (mysql_query(conn, "DROP TABLE Temp")) {
		finish_with_error(conn);
	}
	if (mysql_query(conn, "CREATE TABLE Temp(Id INT, Value DOUBLE)")) {
		finish_with_error(conn);
	}

	for (;;) {
		rand_val = (double) rand() / RAND_MAX;
		printf("Writing value to db: %E\n", rand_val);
		printf("Insert String: \n");
		sprintf(tmp_ins, "INSERT INTO Temp VALUES(%d, %E)", i, rand_val);
		printf("%s\n", tmp_ins);
		if (mysql_query(conn, tmp_ins)) {
			finish_with_error(conn);
		}
		i++;
		sleep(0);
	}
	mysql_close(conn);
	return 0;
}

void finish_with_error(MYSQL *con) {
	fprintf(stderr, "%s\n", mysql_error(con));
	mysql_close(con);
	exit(1);
}
