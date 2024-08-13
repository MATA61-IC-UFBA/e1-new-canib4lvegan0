%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int chars = 0;
int words = 0;
int lines = 0;

int yylex();
%}

%option noyywrap

%%
[a-zA-ZÀ-ÖØ-öø-ÿ0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~`]+ { words++; chars += strlen(yytext); }
\n                                                         { chars++; lines++; }                
.                                                          { chars++; }              
%%

int main(int argc, char **argv)
{   
    // printf("(II) mywc-linux\n");
    FILE *file;

    if (argc != 2) {
        fprintf(stderr, "Uso: %s <nome_do_arquivo>\n", argv[0]);
        return 1;
    }

    file = fopen(argv[1], "r");
    if (!file) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }
    yyin = file;
    yylex();
    fclose(file);
    printf("%8d%8d%8d %s\n", lines, words, chars, argv[1]);
    return 0;
}
