%{
#include <stdio.h>
%}

%%
[a-z] { lower_count++; }
[A-Z] { upper_count++; }
. ;

%%

int lower_count = 0;
int upper_count = 0;

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yylex();
    fclose(file);

    printf("Lowercase count: %d\n", lower_count);
    printf("Uppercase count: %d\n", upper_count);
    return 0;
}
