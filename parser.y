%{
    int yylex();
    void yyerror(char* c);
%}

%token CLASS_TOK

%token PUBLIC PRIVATE

%token INT BOOLEAN STRING

%token IF ELSE WHILE


%token ASSIGN_OP ADD_OP MIN_OP MUL_OP DIV_OP

%token EQ NOT_EQ LT GT LTE GTE 

%token IDENTIFIER INTEGER

%token PRINTLN
%token THIS "this"
%token DOT 

%left ADD_OP MIN_OP
%left MUL_OP DIV_OP

%left DOT ASSIGN_OP EQ NOT_EQ LT GT LTE GTE
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
    :   VarDeclarations VarDeclaration{
            printf("Class var Declaration\n");
        }
    |   VarDeclaration{
            printf("Class var Declaration\n");
        }
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
            printf("System.out.println\n");
        }
    |   EXPR ';'
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
    :   ElseIf ELSE IF '{' OptionalBody '}'
    |   ELSE IF '{' OptionalBody '}' 
    ;

WhileStatement
    :   WHILE '(' EXPR ')' '{' OptionalBody '}'
    ;

OptionalArgumentList
    :   OptionalArgumentList ',' EXPR
    |   EXPR
    |   %empty
    ;

EXPR
    :   EXPR EQ EXPR   {
            printf("EQUALS\n");
        }
    |   EXPR NOT_EQ EXPR   {
            printf("NOT EQUALS\n");
        }
    |   EXPR LT EXPR   {
            printf("LESS THAN\n");
        }
    |   EXPR LTE EXPR   {
            printf("LESS THAN EQUALS\n");
        }
    |   EXPR GT EXPR   {
            printf("GREATER THAN\n");
        }
    |   EXPR GTE EXPR   {
            printf("GREATER THAN EQUALS\n");
        }
    |   EXPR ADD_OP EXPR   {
            printf("ADD\n");
        }
    |   EXPR MIN_OP EXPR   {
            printf("MINUS\n");
        }
    |   EXPR MUL_OP EXPR   {
            printf("MULTIPLY\n");
        }
    |   EXPR DIV_OP EXPR   {
            printf("DIVIDE\n");
        }
    |   Identifier
    |   INTEGER
    |   "this"
    |   EXPR DOT IDENTIFIER '(' OptionalArgumentList ')' {
            printf("Function call\n");
        }
    ;
Type
    :   PrimitiveType
    |   PrimitiveType '[' ']'
    ;

PrimitiveType
    :   INT
    |   BOOLEAN
    |   STRING
    ;

Identifier 
    :   IDENTIFIER
    ;
%%