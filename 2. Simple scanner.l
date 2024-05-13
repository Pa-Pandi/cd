%{
#include <stdio.h>
%}

DIGIT   [0-9]
NUMBER  {DIGIT}+(\.{DIGIT}*)?
WS      [ \t]+

%%

{WS}            { /* ignore whitespace */ }
\n              { yylineno++; } // Increment yylineno for each newline

"int" | "for" | "float" | "double" | "if" | "char" { printf("KEYWORD: %s (line %d)\n", yytext, yylineno); }
[{};,()]        { printf("SEPARATOR: %s (line %d)\n", yytext, yylineno); }
[+\-/*%=]       { printf("OPERATOR: %s (line %d)\n", yytext, yylineno); }
{NUMBER}        { printf("FLOAT: %s (line %d)\n", yytext, yylineno); }
[a-zA-Z][a-zA-Z0-9]* { printf("IDENTIFIER: %s (line %d)\n", yytext, yylineno); }

%%
int yywrap() {
    return 1;
}
int main() {
FILE *fp;
    char filename[100];
    printf("Enter Filename: ");
    scanf("%s", filename);
    yyin = fopen(filename, "r");
    fp = yyin;
    yylineno = 1;
    yylex();
    fclose(fp);
    return 0;
}
