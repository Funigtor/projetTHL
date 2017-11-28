%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <iostream>
  #include <fstream>
  #include <math.h>
  #include <map>
  #include <string>
  #include <vector>
  #include <stack>

  using namespace std;
  extern int yylex ();
  extern char* yytext;
  extern FILE* yyin;
  double varx = 0.;
  vector< pair<string,double> > expression;
  stack <double> calculons;
  vector <double> result;

  double fact(int n){
    return (n == 1 || n == 0) ? 1 : fact(n - 1) * n;
  }

  double bino(int n, int k){
    return (fact(n)/(fact(k)*fact(n-k)));
  }

  void calcul_exp (double x){
    double temp1;
    double temp2;
    for (auto j : expression){
      if (j.first == "NUM"){        //detecte les nombres
        calculons.push(j.second);
      }else if (j.first == "VAR"){  // detecte les variable
        calculons.push(x);
      }else if (j.first == "+"){
        temp2 = calculons.top();
        calculons.pop();
        temp1 = calculons.top();
        calculons.pop();
        temp1+= temp2;
        calculons.push(temp1);
      }else if (j.first == "-"){
        temp2 = calculons.top();
        calculons.pop();
        temp1 = calculons.top();
        calculons.pop();
        temp1 -= temp2;
        calculons.push(temp1);
      }else if (j.first == "_"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = -temp1;
        calculons.push(temp1);
      }else if (j.first == "*"){
        temp2 = calculons.top();
        calculons.pop();
        temp1 = calculons.top();
        calculons.pop();
        temp1 *= temp2;
        calculons.push(temp1);
      }else if (j.first == "/"){
        temp1 = calculons.top();
        calculons.pop();
        temp2 = calculons.top();
        calculons.pop();
        if(temp2 == 0){
          calculons.push(0);
        }else{
          temp1 /= temp2;
          calculons.push(temp1);
        }
      }else if (j.first == "sin"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = sin(temp1);
        calculons.push(temp1);
      }else if (j.first == "cos"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = cos(temp1);
        calculons.push(temp1);
      }else if (j.first == "tan"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = tan(temp1);
        calculons.push(temp1);
      }else if (j.first == "asin"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = asin(temp1);
        calculons.push(temp1);
      }else if (j.first == "acos"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = asin(temp1);
        calculons.push(temp1);
      }else if (j.first == "atan"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = atan(temp1);
        calculons.push(temp1);
      }else if (j.first == "exp"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = exp(temp1);
        calculons.push(temp1);
      }else if (j.first == "log"){
        temp1 = calculons.top();
        calculons.pop();
        if (temp1 <= 0){
          calculons.push(0);
        }else{
          temp1 = log(temp1);
          calculons.push(temp1);
        }
      }else if (j.first == "sqrt"){
        temp1 = calculons.top();
        calculons.pop();
        if (temp1 < 0){
          calculons.push(0);
        }else{
          temp1 = sqrt(temp1);
          calculons.push(temp1);
        }
      }else if (j.first == "^"){
        temp2 = calculons.top();
        calculons.pop();
        temp1 = calculons.top();
        calculons.pop();
        temp1 =pow(temp1,temp2);
        calculons.push(temp1);
      }else if (j.first == "cosh"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = cosh(temp1);
        calculons.push(temp1);
      }else if (j.first == "sinh"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = sinh(temp1);
        calculons.push(temp1);
      }else if (j.first == "tanh"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = tanh(temp1);
        calculons.push(temp1);
      }else if (j.first == "acosh"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = acosh(temp1);
        calculons.push(temp1);
      }else if (j.first == "asinh"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = asinh(temp1);
        calculons.push(temp1);
      }else if (j.first == "atanh"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = atanh(temp1);
        calculons.push(temp1);
      }else if (j.first == "abs"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = fabs(temp1);
        calculons.push(temp1);
      }else if (j.first == "%"){
        temp2 = calculons.top();
        calculons.pop();
        temp1 = calculons.top();
        calculons.pop();
        temp1 = fmod(temp1,temp2);
        calculons.push(temp1);
      }else if (j.first == "!"){
        temp1 = calculons.top();
        calculons.pop();
        temp1 = atanh(temp1);
        calculons.push(temp1);
      }else if (j.first == "bino"){
        temp2 = calculons.top();
        calculons.pop();
        temp1 = calculons.top();
        calculons.pop();
        if ( temp1 >= 0 && temp2 >= 0){
          temp1 = bino(temp1,temp2);
          calculons.push(temp1);
        }else{
          calculons.push(0);
        }
      }
    }
    result.push_back(calculons.top());
    calculons.pop();
  }

  void final_calcule(){
    double Xmin, Xmax, pas;
    ifstream textXmin("/tmp/debutCALC");
    textXmin >> Xmin;
    ifstream textXmax("/tmp/finCALC");
    textXmax >> Xmax;
    pas = (Xmax - Xmin)/1000;
    textXmax.close(); textXmin.close();
    for (double o = Xmin; o<=Xmax; o+=pas){
      calcul_exp(o);
    }
    for (auto p: result){
      cout << p << " " ;
    }
    while (!result.empty()){
      result.pop_back();
    }
    while (!expression.empty()){
      expression.pop_back();
    }
  }

  void final_calcule(double Xmin, double Xmax, double pas){
    for (double o = Xmin; o<=Xmax; o+=pas){
      calcul_exp(o);
    }
    while (!result.empty()){
      result.pop_back();
    }
    while (!expression.empty()){
      expression.pop_back();
    }
  }

  int yyerror(char *s) { printf("%s\n", s); }

%}

%union
{
  double dval;
  char sval[40];
}

%token <dval> NUM
%token <sval> VAR
%type <dval> expr

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

%left '+' '-'
%left '*' '/'
%left '^' '%' '!'

%%
program: /* empty */
       | program line
	   ;

line: '\n'
	| expr '\n' { cout<< " " <<endl;final_calcule(); }
  | VAR '=' expr   { /*cout<<"affectation"<<endl;*/ }
	;

expr:
     NUM                            { expression.push_back(make_pair("NUM",$1));}
     |VAR                           { expression.push_back(make_pair("VAR",0)); }
     | expr '+' expr                { expression.push_back(make_pair("+", 0));}
     | '-' expr                     { expression.push_back(make_pair("_", 0));}
     | expr '-' expr                { expression.push_back(make_pair("-", 0));}
     | expr '*' expr                { expression.push_back(make_pair("*", 0));}
     | expr '/' expr                { expression.push_back(make_pair("/", 0));}
     | '(' expr ')'                 { }
     | COS '(' expr ')'             { expression.push_back(make_pair("cos", 0));}
     | SIN '(' expr ')'             { expression.push_back(make_pair("sin", 0));}
     | TAN '(' expr ')'             { expression.push_back(make_pair("tan", 0));}
     | ACOS '(' expr ')'            { expression.push_back(make_pair("acos", 0));}
     | ASIN '(' expr ')'            { expression.push_back(make_pair("asin", 0));}
     | ATAN '(' expr ')'            { expression.push_back(make_pair("atan", 0));}
     | EXP '(' expr ')'             { expression.push_back(make_pair("exp", 0));}
     | LOG '(' expr ')'             { expression.push_back(make_pair("log", 0));}
     | SQRT '(' expr ')'            { expression.push_back(make_pair("sqrt", 0));}
     | POW '('expr ',' expr ')'     { expression.push_back(make_pair("^", 0));}
     | expr '^' expr                { expression.push_back(make_pair("^", 0));}
     | COSH '(' expr ')'            { expression.push_back(make_pair("cosh", 0));}
     | SINH '(' expr ')'            { expression.push_back(make_pair("sinh", 0));}
     | TANH '(' expr ')'            { expression.push_back(make_pair("tanh", 0));}
     | ACOSH '(' expr ')'           { expression.push_back(make_pair("acosh", 0));}
     | ASINH '(' expr ')'           { expression.push_back(make_pair("asinh", 0));}
     | ATANH '(' expr ')'           { expression.push_back(make_pair("atanh", 0));}
     | FMOD '(' expr ',' expr ')'   { expression.push_back(make_pair("%", 0));}
     | expr '%' expr                { expression.push_back(make_pair("%", 0));}
     | ABS '(' expr ')'             { expression.push_back(make_pair("abs", 0));}
     | '|' expr '|'                 { expression.push_back(make_pair("abs", 0));}
     | FACT '(' expr ')'            { expression.push_back(make_pair("!", 0));}
     | '!' expr                     { expression.push_back(make_pair("!", 0));}
     | BINO '(' expr ',' expr ')'   { expression.push_back(make_pair("bino", 0));};

%%

int main(int argc, char* argv[]) {
	if (argc>= 2){
    yyin = fopen(argv[1],"r");
    yyparse();
    fclose(yyin);
  }

  //
  return 0;

}
