all:
	#rm calculette.exe calculette.lex.cpp calculette.bison.cpp calculette.bison.h
	flex -o calculette.lex.cpp calculette.l
	bison -d calculette.y -o calculette.bison.cpp
	g++ -std=c++11 calculette.lex.cpp calculette.bison.cpp -o calculette
	
