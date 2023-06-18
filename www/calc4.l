%{
#include "y.tab.h"
%}

%%
[ \t]+                  /* ignore whitespace */
";"                     { return ';'; }
"="                     { return '='; }
"while"                 { return WHILE; }
"if"                    { return IF; }
"then"                  { return THEN; }
"else"                  { return ELSE; }
"print"                 { return PRINT; }
[a-zA-Z][a-zA-Z0-9]*    { yylval.id = *yytext - 'a'; return ID; }
[0-9]+                  { yylval.num = atoi(yytext); return NUM; }
\n                      { /* ignore newlines */ }
.                       { return *yytext; }
%%

int yywrap() {
    return 1;
}
