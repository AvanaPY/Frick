%{
    #include "parser.tab.h"

%}

%%
[ \t]+          {}
"\n"            {}

"class"         { return CLASS_TOK; }
"public"        { return PUBLIC; }
"private"       { return PRIVATE; }

"int"           { return INT; }
"bool"          { return BOOLEAN; }
"string"        { return STRING; }

"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }

"println"       { return PRINTLN; }

"="             {return ASSIGN_OP; }
"+"             {return ADD_OP; }
"-"             {return MIN_OP; }
"*"             {return MUL_OP; }
"/"             {return DIV_OP; }

"=="            { return EQ; }
"!="            { return NOT_EQ; }
"<"             { return LT; }
">"             { return GT; }
"<="            { return LTE; }
">="            { return GTE; }

[a-zA-Z_]+[0-9]* { printf("IDENTIFIER %s\n", yytext); return IDENTIFIER; }
0|[1-9][0-9]*   { printf("INTEGER    %s\n", yytext); return INTEGER;}

.               { return yytext[0]; }
%%