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

double test(){
	for (int i = 0; i <= 100 ; i++ ){
		return i;
	}
}

double ans=0;

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
		ans = $1;
	}	
	;

expr:
     NUM                            { $$ = $1 ;}
     | expr '+' expr                { $$ = $1 + $3; 		std::cout << $1 << " + " << $3 << " = " << $$ <<std::endl; }
     | '-' expr                     { $$ = - $2; }
     | expr '-' expr                { $$ = $1 - $3; 		std::cout << $1 << " - " << $3 << " = " << $$ <<std::endl; }	
     | expr '*' expr                { $$ = $1 * $3; 		std::cout << $1 << " * " << $3 << " = " << $$ <<std::endl; }
     | expr '/' expr	            { $$ = $1 / $3; 		std::cout << $1 << " / " << $3 << " = " << $$ <<std::endl; }
     | '(' expr ')'                 { $$ = $2;  }
     | COS '(' expr ')'             { $$ = cos($3); 		std::cout << "cos(" << $3 << ")" << " = " << $$ <<std::endl; }
     | SIN '(' expr ')'             { $$ = sin($3); 		std::cout << "sin(" << $3 << ")" << " = " << $$ <<std::endl; }
     | TAN '(' expr ')'             { $$ = tan($3); 		std::cout << "tan(" << $3 << ")" << " = " << $$ <<std::endl; }
     | ACOS '(' expr ')'            { $$ = acos($3); 		std::cout << "acos(" << $3 << ")" << " = " << $$ <<std::endl; }
     | ASIN '(' expr ')'            { $$ = asin($3); 		std::cout << "asin(" << $3 << ")" << " = " << $$ <<std::endl; }
     | ATAN '(' expr ')'            { $$ = atan($3); 		std::cout << "atan(" << $3 << ")" << " = " << $$ <<std::endl; }
     | EXP '(' expr ')'             { $$ = exp($3); 		std::cout << "exp(" << $3 << ")" << " = " << $$ <<std::endl; }
     | LOG '(' expr ')'             { $$ = log($3); 		std::cout << "log(" << $3 << ")" << " = " << $$ <<std::endl; }
     | SQRT '(' expr ')'            { $$ = sqrt($3); 		std::cout << "sqrt(" << $3 << ")" << " = " << $$ <<std::endl; }
     | POW '('expr ',' expr ')'     { $$ = pow($3,$5); 		std::cout << "pow(" << $3 << "," << $5 << ")" << " = " << $$ <<std::endl; }
     | expr '^' expr                { $$ = pow($1,$3); 		std::cout << "pow(" << $1 << "," << $3 << ")" << " = " << $$ <<std::endl; }
     | COSH '(' expr ')'            { $$ = cosh($3); 		std::cout << "cosh(" << $3 << ")" << " = " << $$ <<std::endl; }
     | SINH '(' expr ')'            { $$ = sinh($3); 		std::cout << "sinh(" << $3 << ")" << " = " << $$ <<std::endl; }
     | TANH '(' expr ')'            { $$ = tanh($3); 		std::cout << "tanh(" << $3 << ")" << " = " << $$ <<std::endl; }
     | ACOSH '(' expr ')'           { $$ = acosh($3); 		std::cout << "acosh(" << $3 << ")" << " = " << $$ <<std::endl; }
     | ASINH '(' expr ')'           { $$ = asinh($3); 		std::cout << "asinh(" << $3 << ")" << " = " << $$ <<std::endl; }
     | ATANH '(' expr ')'           { $$ = atanh($3); 		std::cout << "atanh(" << $3 << ")" << " = " << $$ <<std::endl; }
     | FMOD '(' expr ',' expr ')'   { $$ = fmod($3,$5); 	std::cout << "fmod(" << $3 << "," << $5 << ")" << " = " << $$ <<std::endl; }
     | expr '%' expr                { $$ = fmod($1,$3); 	std::cout << "fmod(" << $1 << "," << $3 << ")" << " = " << $$ <<std::endl; }
     | ABS '(' expr ')'             { $$ = abs($3); 		std::cout << "abs(" << $3 << ")" << " = " << $$ <<std::endl; }
     | '|' expr '|'                 { $$ = abs($2); 		std::cout << "abs(" << $2 << ")" << " = " << $$ <<std::endl; }
     | FACT '(' expr ')'            { $$ = fact($3); 		std::cout << "fact(" << $3 << ")" << " = " << $$ <<std::endl; }
     | '!' expr                     { $$ = fact($2); 		std::cout << "fact(" << $2 << ")" << " = " << $$ <<std::endl; }
     | BINO '(' expr ',' expr ')'   { $$ = bino($3,$5); 	std::cout << "bino(" << $3 << "," << $5 << ")" << " = " << $$ <<std::endl; }
     | ANS 							{ $$ = ans; }
%%

int main(void) {
    yyparse();						
    return 0;
}