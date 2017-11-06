all:
	#rm calculette calculette.c calculette.tab.c calculette.tab.h
	flex -o calculette.cpp calculette.l
	bison -d calculette.y 
	g++ calculette.cpp calculette.tab.c -o calculette -lm
	clear
	./calculette
