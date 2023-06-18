%{
#include <stdio.h>

int yylex();
void yyerror(const char *s);
%}


%union {
    int int_val;                 /* integer value */
    char *yytext;
};

%token INT EQUAL WHILE IF THEN ELSE PRINT NEWLINE ID DO OD

%%

program: stmtlist { printf("Program parsed successfully.\n"); }

stmtlist: stmtlist stmt
| stmt
;

stmt: assignstmt
| whilestmt
;

assignstmt: ID EQUAL expr NEWLINE {
  printf("Assigning %d to %s.\n", yylval.int_val);
}

whilestmt: WHILE expr DO stmtlist OD {
  printf("While loop parsed successfully.\n");
}

expr: INT
| ID
| expr '+' expr {
  printf("Adding %d and %d.\n", yylval.int_val, yylval.int_val);
}
| expr '-' expr {
  printf("Subtracting %d and %d.\n", yylval.int_val, yylval.int_val);
}

%%

void yyerror(const char *s) {
  printf("Error: %s\n", s);
}
