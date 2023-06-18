%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char* s);

int x = 8;
int y = 34;

%}

%union {
    int iValue;
    char* sValue;
};

%token INTEGER IDENTIFIER SEMICOLON ASSIGN WHILE IF THEN ELSE PRINT

%%

program:
    stmt_list
    ;

stmt_list:
    stmt
    | stmt stmt_list
    ;

stmt:
    IDENTIFIER ASSIGN expr SEMICOLON
    | WHILE '(' expr ')' '{' stmt_list '}'
    | IF '(' expr ')' THEN stmt_list ELSE stmt_list
    | PRINT expr SEMICOLON
    ;

expr:
    INTEGER
    | IDENTIFIER
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}
