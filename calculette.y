%{
#include <iostream>
#include <cmath> 
#include <stdio.h>

extern int yylex ();

double fact(int n){
  return (n == 1 || n == 0) ? 1 : fact(n - 1) * n;
}

double bino(int n, int k){
    return (fact(n)/(fact(k)*fact(n-k)));
}

double ans=0;

double varx =0.;

int yyerror(char *s) {                  
    printf("%s\n", s);
}
%}

%code requires
  {
    #define YYSTYPE double
  }

%token NUM
%token POW
%token EXP
%token LOG
%token SQRT
%token SIN
%token COS
%token TAN
%token ACOS
%token ASIN
%token ATAN
%token COSH
%token SINH
%token TANH
%token ACOSH
%token ASINH
%token ATANH
%token FMOD
%token ABS

%token FACT
%token BINO
%token ANS
%token VAR

%left '+' '-'
%left '*' '/'
%left '^' '%' '!'

%%
program: /* empty */		
       | program line          
	   ;

line: '\n'			 
	| expr '\n' {
		std::cout << "result : " << $1 << std::endl;
		ans = $1;}
	| VAR '=' expr { varx = $3; }
	;

expr:
     NUM                            { $$ = $1 ;}
     |VAR 							{ $$ = varx ;}
     | expr '+' expr                { $$ = $1 + $3;}
     | '-' expr                     { $$ = - $2; }
     | expr '-' expr                { $$ = $1 - $3;}	
     | expr '*' expr                { $$ = $1 * $3;}
     | expr '/' expr	            { $$ = $1 / $3;}
     | '(' expr ')'                 { $$ = $2;}
     | COS '(' expr ')'             { $$ = cos($3);}
     | SIN '(' expr ')'             { $$ = sin($3);}
     | TAN '(' expr ')'             { $$ = tan($3);}
     | ACOS '(' expr ')'            { $$ = acos($3);}
     | ASIN '(' expr ')'            { $$ = asin($3);}
     | ATAN '(' expr ')'            { $$ = atan($3);}
     | EXP '(' expr ')'             { $$ = exp($3);}
     | LOG '(' expr ')'             { $$ = log($3);}
     | SQRT '(' expr ')'            { $$ = sqrt($3);}
     | POW '('expr ',' expr ')'     { $$ = pow($3,$5);}
     | expr '^' expr                { $$ = pow($1,$3);}
     | COSH '(' expr ')'            { $$ = cosh($3);}
     | SINH '(' expr ')'            { $$ = sinh($3);}
     | TANH '(' expr ')'            { $$ = tanh($3);}
     | ACOSH '(' expr ')'           { $$ = acosh($3);}
     | ASINH '(' expr ')'           { $$ = asinh($3);}
     | ATANH '(' expr ')'           { $$ = atanh($3);}
     | FMOD '(' expr ',' expr ')'   { $$ = fmod($3,$5);}
     | expr '%' expr                { $$ = fmod($1,$3);}
     | ABS '(' expr ')'             { $$ = abs($3);}
     | '|' expr '|'                 { $$ = abs($2);}
     | FACT '(' expr ')'            { $$ = fact($3);}
     | '!' expr                     { $$ = fact($2);}
     | BINO '(' expr ',' expr ')'   { $$ = bino($3,$5);}
     | ANS 							{ $$ = ans; };
%%

int main(void) {
    yyparse();						
    return 0;
}