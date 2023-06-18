%{
#include <stdio.h>
int yylex();
void yyerror(const char* s);
int sym[26];
%}

%token NUM ID WHILE IF THEN ELSE PRINT GE LE NE EQ

%%

stmt_seq: stmt ';' stmt_seq | stmt ';'
    ;

stmt: ID '=' expr
    {
        sym[$1] = $3;
    }
    | WHILE '(' expr ')' '{' stmt_seq '}'
    {
        while ($3) {
            $6;
        }
    }
    | IF '(' expr ')' THEN stmt_seq ELSE stmt_seq
    {
        if ($3) {
            $6;
        } else {
            $8;
        }
    }
    | PRINT expr
    {
        printf("%d\n", $2);
    }
    ;

expr: NUM
    {
        $$ = $1;
    }
    | ID
    {
        $$ = sym[$1];
    }
    | expr '+' expr
    {
        $$ = $1 + $3;
    }
    | expr '-' expr
    {
        $$ = $1 - $3;
    }
    | expr '*' expr
    {
        $$ = $1 * $3;
    }
    | expr '/' expr
    {
        $$ = $1 / $3;
    }
    | expr '<' expr
    {
        $$ = ($1 < $3) ? 1 : 0;
    }
    | expr '>' expr
    {
        $$ = ($1 > $3) ? 1 : 0;
    }
    | expr GE expr
    {
        $$ = ($1 >= $3) ? 1 : 0;
    }
    | expr LE expr
    {
        $$ = ($1 <= $3) ? 1 : 0;
    }
    | expr NE expr
    {
        $$ = ($1 != $3) ? 1 : 0;
    }
    | expr EQ expr
    {
        $$ = ($1 == $3) ? 1 : 0;
    }
    | '-' expr %prec UMINUS
    {
        $$ = -$2;
    }
    | '(' expr ')'
    {
        $$ = $2;
    }
    ;

%%

void yyerror(const char* s) {
    printf("Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
