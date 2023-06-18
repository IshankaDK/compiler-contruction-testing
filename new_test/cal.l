%option noyywrap

%{
    #include "y.tab.h"
    #include <stdlib.h>
    void yyerror(const char *);
%}


%%
[ \t]       ;       /* skip whitespace */

"x"         { return VARIABLE; }

"="         { return ASSIGNMENT; }

";"         { return SEMICOLON; }

"while"     { return WHILE; }

"if"        { return IF; }

"then"      { return THEN; }

"else"      { return ELSE; }

"print"     { return PRINT; }

"<"         { return LESS_THAN; }

">"         { return GREATER_THAN; }

"-"         { return MINUS; }

[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }

[a-zA-Z]+   { return IDENTIFIER; }

.           yyerror("Unknown character");
%%

int yywrap(void) {
    return 1;
}
