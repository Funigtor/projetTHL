%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string>
  using namespace std;

  #include "calculette.bison.hpp"
%}

%%

[0-9]+(\.[0-9]*)?([Ee][0-9]+)? {  yylval.dval = atof(yytext); return NUM; }
Pi|PI|pi    {  yylval.dval = 3.14159265359; return NUM; }
sin|sinus|Sin|Sinus|SINUS|SIN {  return SIN; }
cos|cosinus|Cosinus|Cos|COSINUS|COS {  return COS; }
tan|TAN|Tan {  return TAN; }
exp|Exp|EXP {  return EXP; }
log|Log|LOG {  return LOG; }
sqrt|Sqrt|SQRT {  return SQRT; }
pow|Pow|POW {  return POW; }
Acos|ACOS|acos {  return ACOS; }
ASIN|Asin|asin {  return ASIN; }
Atan|ATAN|atan {  return ATAN; }
sinh|sinush|Sinh|Sinush|SINUSH|SINH {  return SINH; }
cosh|cosinush|Cosinush|Cosh|COSINUSH|COSH {  return COSH; }
tanh|TANH|Tanh {  return TANH; }
Acosh|ACOSH|acosh {  return ACOSH; }
ASINH|Asinh|asinh {  return ASINH; }
Atanh|ATANH|atanh {  return ATANH; }
Fmod|FMOD|fmod { return FMOD; }
abs|Abs|ABS { return ABS; }
fact|Fact|FACT { return FACT; }
bino|Bino|BINO { return BINO; }

\n     {  return '\n'; }
[a-zA-Z_][a-zA-Z_0-9]* { strcpy( yylval.sval, yytext); return VAR; }
" "    {}
.      {  return yytext[0]; }

%%

int yywrap(){}
