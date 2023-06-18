%option noyywrap

number		[0-9]+
id		[a-zA-Z]+

%%

{number}		printf("NUMBER(%s)\n", yytext);
{id}		printf("ID(%s)\n", yytext);

%%
