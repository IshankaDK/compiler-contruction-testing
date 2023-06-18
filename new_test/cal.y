/* calculator.y */
%{
    #include <stdio.h>
    #include <stdlib.h>

    int x, y; // Variables to store values

    void yyerror(const char *);
    int yylex(void);
%}

%token INTEGER VARIABLE ASSIGNMENT SEMICOLON WHILE IF THEN ELSE PRINT LESS_THAN GREATER_THAN MINUS IDENTIFIER

int yywrap() {
    // Provide your implementation here if needed
    return 1;
}

%left '+' '-'
%left '*' '/'

%%
program : statement_list
        | /* Empty production */
        ;

statement_list : statement
               | statement_list statement
               ;

statement : VARIABLE ASSIGNMENT expression SEMICOLON
          | WHILE '(' condition ')' '{' statement_list '}'
          | IF '(' condition ')' '{' statement_list '}' ELSE '{' statement_list '}'
          | PRINT expression SEMICOLON
          ;

expression : INTEGER
           | IDENTIFIER
           | expression '+' expression
           | expression '-' expression
           | expression '*' expression
           | expression '/' expression
           ;

condition : expression LESS_THAN expression
          | expression GREATER_THAN expression
          ;

%%
#include "lex.yy.c"

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
