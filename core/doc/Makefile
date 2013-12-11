CC      = /usr/bin/gcc
CFLAGS  = -Wall -g
LIBS    = /usr/include/mysql
MORE    = /usr/lib/arm-linux-gnueabihf -lmysqlclient -lpthread -lz -lm -lrt -ldl
LIST_BIN = mysql_list_tables

.PHONY: clean
all: $(LIST_BIN)

$(LIST_BIN): $(LIST_BIN).o
	$(CC) -o $@ $@.o -I $(LIBS) -L$(MORE)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -I $(LIBS) -L$(MORE)

clean:
	rm -rf $(BINS)
