%{
#include <stdio.h>
int yylex();
void yyerror(const char* s);
int x, y; // Declare variables to hold the values of x and y
%}

%token NUMBER WHILE IF THEN ELSE PRINT

%%
program:
    statements                  { printf("x = %d\n", x); }  // Print the value of x
    ;

statements:
    statement                   { }
    | statements statement       { }
    ;

statement:
    assignment_statement        { }
    | while_loop                 { }
    | print_statement            { }
    ;

assignment_statement:
    'x' '=' expr                { x = $3; }  // Assign the value of expr to x
    | 'y' '=' expr              { y = $3; }  // Assign the value of expr to y
    ;

while_loop:
    WHILE '(' expr ')' '{' statements '}'   // Evaluate the loop condition and execute statements
    ;

if_statement:
    IF expr THEN statements ELSE statements   // Evaluate the condition and execute statements based on the result
    ;

print_statement:
    PRINT expr                  { printf("%d\n", $2); }  // Print the value of expr
    ;

expr:
    NUMBER                      { $$ = $1; }
    | expr '+' expr             { $$ = $1 + $3; }
    | expr '-' expr             { $$ = $1 - $3; }
    | expr '*' expr             { $$ = $1 * $3; }
    | expr '/' expr             { $$ = $1 / $3; }
    ;

%%

void yyerror(const char* s) {
    printf("Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
