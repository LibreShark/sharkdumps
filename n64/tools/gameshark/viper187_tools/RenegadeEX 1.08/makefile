NAME = RenegadeEx
CC = gcc.exe
WINDRES = windres.exe
RES  = mainrc.res
OBJ  = main.o tab_hook.o lib_api.o lib_misc.o tab_codesearch.o lib_memory.o tab_options.o lib_fileio.o lib_search.o tab_results.o lib_listview.o tab_memedit.o tab_cheat.o lib_cheat.o lib_memory_2.o $(RES)
LDFLAGS = -s -mwindows -lcomctl32 -lpsapi
CFLAGS = -O2

.PHONY: all
all: $(NAME)

.PHONY: clean
clean:
	rm -f $(OBJ)

$(NAME): $(OBJ)
	$(CC) $(OBJ) -o $(NAME) $(LDFLAGS)

main.o: main.c
	$(CC) -c main.c -o main.o $(CFLAGS)

tab_hook.o: tab_hook.c
	$(CC) -c tab_hook.c -o tab_hook.o $(CFLAGS)

lib_api.o: lib_api.c
	$(CC) -c lib_api.c -o lib_api.o $(CFLAGS)

lib_misc.o: lib_misc.c
	$(CC) -c lib_misc.c -o lib_misc.o $(CFLAGS)

tab_codesearch.o: tab_codesearch.c
	$(CC) -c tab_codesearch.c -o tab_codesearch.o $(CFLAGS)

lib_memory.o: lib_memory.c
	$(CC) -c lib_memory.c -o lib_memory.o $(CFLAGS)

lib_fileio.o: lib_fileio.c
	$(CC) -c lib_fileio.c -o lib_fileio.o $(CFLAGS)

lib_search.o: lib_search.c
	$(CC) -c lib_search.c -o lib_search.o $(CFLAGS)

tab_results.o: tab_results.c
	$(CC) -c tab_results.c -o tab_results.o $(CFLAGS)

lib_listview.o: lib_listview.c
	$(CC) -c lib_listview.c -o lib_listview.o $(CFLAGS)

tab_memedit.o: tab_memedit.c
	$(CC) -c tab_memedit.c -o tab_memedit.o $(CFLAGS)

tab_cheat.o: tab_cheat.c
	$(CC) -c tab_cheat.c -o tab_cheat.o $(CFLAGS)

lib_cheat.o: lib_cheat.c
	$(CC) -c lib_cheat.c -o lib_cheat.o $(CFLAGS)

lib_memory_2.o: lib_memory_2.c
	$(CC) -c lib_memory_2.c -o lib_memory_2.o $(CFLAGS)

mainrc.res: mainrc.rc 
	$(WINDRES) -i mainrc.rc -J rc -o mainrc.res -O coff
