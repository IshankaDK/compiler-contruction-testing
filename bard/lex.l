%{
#include <stdlib.h>
#include "y.tab.h"
void yyerror(char *);
char *yytext;
%}

%option noyywrap

%%

[0-9]+ {
  yylval.int_val = atoi(yytext);
  return INT;
}

"=" { return EQUAL; }

"while" { return WHILE; }

"if" { return IF; }

"then" { return THEN; }

"else" { return ELSE; }

"print" { return PRINT; }

\n { return NEWLINE; }

. { return yytext[0]; }

%%

int main() {
    int x = 8;
    int y = 34;

    while (x < y) {
        if (x > y) {
            x = x - y;
        }
        else {
            y = y - x;
        }
    }

    printf("x = %d\n", x);

    return 0;
}