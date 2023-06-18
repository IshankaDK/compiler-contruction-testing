%{
#include <stdio.h>
%}

%token NUMBER ID

%%

program:
    { printf("Start of program\n"); }
    stmtlist
    { printf("End of program\n"); }
;

stmtlist:
    stmt
    | stmtlist stmt
;

stmt:
    assign
    | while_stmt
;

assign:
    ID '=' expr
    { printf("Assign statement\n"); }
;

expr:
    NUMBER
    | ID
    | expr '+' expr
    | expr '-' expr
;

while_stmt:
    'w' '(' expr ')' stmt
    { printf("While statement\n"); }
;

%%

int main() {
    yyparse();
    return 0;
}
