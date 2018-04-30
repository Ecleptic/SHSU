/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     Token_NUM = 258,
     Token_IDENT = 259,
     Token_LP = 260,
     Token_RP = 261,
     Token_ASGN = 262,
     Token_SC = 263,
     Token_COLON = 264,
     Token_POWER = 265,
     Token_MULTIPLY = 266,
     Token_DIVIDE = 267,
     Token_MOD = 268,
     Token_ADD = 269,
     Token_SUB = 270,
     Token_EQUAL = 271,
     Token_NOTEQUAL = 272,
     Token_LESSTHAN = 273,
     Token_GREATERTHAN = 274,
     Token_LESSEQUAL = 275,
     Token_GREATEREQUAL = 276,
     Token_IF = 277,
     Token_THEN = 278,
     Token_ELSE = 279,
     Token_BEGIN = 280,
     Token_END = 281,
     Token_ENDIF = 282,
     Token_ENDWHILE = 283,
     Token_WHILE = 284,
     Token_LOOP = 285,
     Token_PROGRAM = 286,
     Token_VAR = 287,
     Token_INT = 288,
     Token_WRITEINT = 289,
     Token_READINT = 290,
     Token_COMMENT = 291
   };
#endif
/* Tokens.  */
#define Token_NUM 258
#define Token_IDENT 259
#define Token_LP 260
#define Token_RP 261
#define Token_ASGN 262
#define Token_SC 263
#define Token_COLON 264
#define Token_POWER 265
#define Token_MULTIPLY 266
#define Token_DIVIDE 267
#define Token_MOD 268
#define Token_ADD 269
#define Token_SUB 270
#define Token_EQUAL 271
#define Token_NOTEQUAL 272
#define Token_LESSTHAN 273
#define Token_GREATERTHAN 274
#define Token_LESSEQUAL 275
#define Token_GREATEREQUAL 276
#define Token_IF 277
#define Token_THEN 278
#define Token_ELSE 279
#define Token_BEGIN 280
#define Token_END 281
#define Token_ENDIF 282
#define Token_ENDWHILE 283
#define Token_WHILE 284
#define Token_LOOP 285
#define Token_PROGRAM 286
#define Token_VAR 287
#define Token_INT 288
#define Token_WRITEINT 289
#define Token_READINT 290
#define Token_COMMENT 291




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 12 "zinc.y"
{
	char str[60];
	int num;
}
/* Line 1529 of yacc.c.  */
#line 126 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

