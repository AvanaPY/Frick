%{
    int yylex();
    void yyerror(char* c);
%}

%token CLASS_TOK
%token PUBLIC PRIVATE
%token INT BOOLEAN STRING
%token IF ELSE WHILE
%token PRINTLN
%token ASSIGN_OP ADD_OP MIN_OP MUL_OP DIV_OP
%token EQ NOT_EQ LT GT LTE GTE 
%token INTEGER 
%token IDENTIFIER

%precedence IF ELSE
%precedence INT BOOLEAN STRING 
%%

START   
    :   START ClassDeclaration{
            printf("Class\n\n");
        }
    |   ClassDeclaration {
            printf("Class\n\n");
        }
    ;

ClassDeclaration 
    :   CLASS_TOK IDENTIFIER '{' ClassBodyDeclaration '}' {
            printf("Class Body\n");
        }
    |   CLASS_TOK IDENTIFIER '{' '}' {
            printf("Class Body\n");
        }
    ;

ClassBodyDeclaration
    :   ClassBodyDeclaration MethodDeclaration
    |   MethodDeclaration
    |   VarDeclarations
    ;

MethodDeclaration
    :   MethodAccessibility Type IDENTIFIER '(' ParameterDeclaration ')' '{' OptionalBody '}' {
            printf("Method\n");
        }
    ;

MethodAccessibility
    :   PUBLIC
    |   PRIVATE
    ;

ParameterDeclaration
    :   %empty
    |   ParameterDeclaration ',' Type IDENTIFIER
    |   Type IDENTIFIER
    ;

VarDeclarations
    :   VarDeclarations VarDeclaration
    |   VarDeclaration
    ;

VarDeclaration
    :   Type IDENTIFIER ASSIGN_OP EXPR ';'
    |   Type Identifier ';'
    ;

Body
    :   Body Statement
    |   Statement
    ;

OptionalBody  
    :   Body
    |   %empty
    ;

Statement
    :   Type IDENTIFIER ASSIGN_OP EXPR ';' {
            printf("Declare Var W Value\n");   
        }
    |   Type IDENTIFIER ';' {
            printf("Declare Var\n");
        }
    |   IDENTIFIER ASSIGN_OP EXPR ';' {
            printf("Assign Var\n");   
        }
    |   IfStatement {
        }
    |   WhileStatement{
            printf("While\n");
        }
    |   PRINTLN '(' EXPR ')' ';' {
            printf("PRINTLN\n");
        }
    |   IDENTIFIER '.' IDENTIFIER '(' OptionalArgumentList ')' ';'
    ;

IfStatement 
    :   IF '(' EXPR ')' '{' OptionalBody '}' {
            printf("IF\n");
        }
    |   IF '(' EXPR ')' '{' OptionalBody '}' ELSE '{' OptionalBody '}' {
            printf("IF-ELSE\n");
        }
    |   IF '(' EXPR ')' '{' OptionalBody '}' ElseIf {
            printf("IF-ELSEIF\n");
        }
    |   IF '(' EXPR ')' '{' OptionalBody '}' ElseIf ELSE '{' OptionalBody '}' {
            printf("IF-ELSEIF-ELSE\n");
        }
    ;

ElseIf 
    :   ElseIf ELSE IF '{' OptionalBody '}' ELSE '{' OptionalBody '}'
    |   ELSE IF '{' OptionalBody '}' 
    ;

WhileStatement
    :   WHILE '(' EXPR ')' '{' OptionalBody '}'
    ;

OptionalArgumentList
    :   OptionalArgumentList ',' EXPR
    |   EXPR
    ;

EXPR
    :   Identifier EQ Identifier   {
            printf("EQUALS\n");
        }
    |   Identifier NOT_EQ Identifier   {
            printf("NOT EQUALS\n");
        }
    |   Identifier LT Identifier   {
            printf("LESS THAN\n");
        }
    |   Identifier LTE Identifier   {
            printf("LESS THAN EQUALS\n");
        }
    |   Identifier GT Identifier   {
            printf("GREATER THAN\n");
        }
    |   Identifier GTE Identifier   {
            printf("GREATER THAN EQUALS\n");
        }
    |   Identifier ADD_OP Identifier   {
            printf("ADD\n");
        }
    |   Identifier MIN_OP Identifier   {
            printf("MINUS\n");
        }
    |   Identifier MUL_OP Identifier   {
            printf("MULTIPLY\n");
        }
    |   Identifier DIV_OP Identifier   {
            printf("DIVIDE\n");
        }
    |   Identifier
    ;
Type
    :   PrimitiveType
    |   PrimitiveType '[' ']'
    ;

PrimitiveType
    :   INT
    |   BOOLEAN
    |   STRING

Identifier 
    :   IDENTIFIER
    |   INTEGER
    ;
%%