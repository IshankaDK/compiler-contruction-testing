%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
extern YYSTYPE yylval;
%}

%%
[0-9]+              { yylval.iValue = atoi(yytext); return INTEGER; }
[a-zA-Z][a-zA-Z0-9]* { yylval.sValue = strdup(yytext); return IDENTIFIER; }
[ \t]               ; /* Skip whitespace */
\n                  return SEMICOLON;
.                   return yytext[0];
%%

int yywrap() {
    return 1;
}
