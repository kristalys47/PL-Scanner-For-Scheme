
%%
%standalone



//Programs
program = {form}*
form = {definition} | {expression}

//Definitions
definition = {variable_definition}
  | {syntax_definition}
  | {open_p}"begin" {definition}*{close_p}
  |	{open_p}"let-syntax" {open_p}{syntax_binding}*{close_p} {definition}*{close_p}
  |	{open_p}"letrec-syntax" {open_p}{syntax_binding}*{close_p} {definition}*{close_p}
  |	{derived_definition}
variable_definition = {open_p}"define" {variable} {expression}{close_p}
	|	{open_p}"define" {open_p}{variable} {variable}*{close_p} {body}{close_p}
	|	{open_p}"define" {open_p}{variable} {variable}* . {variable}{close_p} {body}{close_p}
variable = {identifier}
body = {definition}* {expression}+
syntax_definition = {open_p}"define-syntax" {keyword} {transformer_expression}{close_p}
keyword	= {identifier}
syntax_binding = {open_p}{keyword} {transformer_expression}{close_p}

//Expressions
expression = {constant}
  |	{variable}
  |	{open_p}"quote" {datum}{close_p} | "'" {datum}
  |	{open_p}"lambda" {formals} {body}{close_p}
  |	{open_p}"if" {expression} {expression} {expression}{close_p}
  | {open_p}"if" {expression} {expression}{close_p}
  |	{open_p}"set!" {variable} {expression}{close_p}
  |	{application}
  |	{open_p}"let-syntax" {open_p}{syntax_binding}*{close_p} {expression}+{close_p}
  |	{open_p}"letrec-syntax" {open_p}{syntax_binding}*{close_p} {expression}+{close_p}
  |	{derived_expression}
derived_expression = "and" | "begin" | "case" | "cond" | "delay" | "do" | "let" | "let*" | "letrec" | "or" | "quasiquote"
constant = {boolean} | {number} | {character} | {string}
formals =		{variable} | {open_p}{variable}*{close_p} | {open_p}{variable}+ . {variable}{close_p}
application =		{open_p}{expression} {expression}*{close_p}

//Identifiers
identifier = {initial} {subsequent} * | "+" | "-" | "..."
initial	=	{letter} | {symbols}
subsequent= {initial} | {digit} | "."| "+" | "-"
letter = [a-z]
digit	=	[0-9]

//Data
datum = {boolean} | {number} | {character} | {string} | {symbol} | {list} | {vector}
boolean =	"#t" | "#f"
number = {num_2} | {num_8} | {num_10} | {num_16}
character =		{sharp}{slash}{anycharacter} | {sharp}{slash}{newline} | {sharp}{slash}{space}
string =		{quotes}{string_character}* {quotes}
string_character = {slash}{quotes} | {slash}{slash} | [^\\\"]
symbol = {identifier}
list =		{open_p}{datum}*{close_p} | {open_p}{datum}+ "." {datum}{close_p} | {abbreviation}
abbreviation = "'" {datum} | "`" {datum} | "," {datum} | ",@" {datum}
vector =		{sharp}{open_p}{datum}*{close_p}

//Numbers
suffix = {empty} | {exponent}
exponent_marker = "e" | "s" | "f" | "d" | "l"
sign = {empty} | "+" | "-"
exactness = {empty}| "#i" | "#e"
radix_2 =	"#b"
radix_8 =	"#o"
radix_10 = {empty} | "#d"
radix_16 = "#x"
digit_2 = [0-1]
digit_8 = [0-7]
digit_10 = {digit}
digit_16 = {digit} | [a-f]

//Base 10
num_10 =	{prefix_10}{complex_10}
complex_10 =	{real_10}
  | {real_10} "@" {real_10}
  |	{real_10} "+" {imag_10}
  | {real_10} "-" {imag_10}
  |	"+" {imag_10}
  | "-" {imag_10}
imag_10 = "i" | {ureal_10} "i"
real_10 =		{sign} {ureal_10}
ureal_10 =	{uinteger_10} | {uinteger_10} "/" {uinteger_10} | {decimal_10}
uinteger_10 =		{digit_10}+ "#"*
prefix_10 =		{radix_10} {exactness} | {exactness} {radix_10}
decimal_10 =		{uinteger_10} {exponent}
  |	"." {digit_10}+ "#"* {suffix}
  |	{digit_10}+ "." {digit_10}* "#"* {suffix}
  |	{digit_10}+ "#"+ "." "#"* {suffix}
exponent = {exponent_marker} {sign} {digit_10}+

//Base 2
num_2 =	{prefix_2} {complex_2}
complex_2 =	{real_2}
  | {real_2} "@" {real_2}
  |	{real_2} "+" {imag_2}
  | {real_2} "-" {imag_2}
  |	"+" {imag_2}
  | "-" {imag_2}
imag_2 = "i" | {ureal_2} "i"
real_2 =		{sign} {ureal_2}
ureal_2 =	{uinteger_2} | {uinteger_2} "/" {uinteger_2}
uinteger_2 =		{digit_2}+ "#"*
prefix_2 =		{radix_2} {exactness} | {exactness} {radix_2}

//Base 8
num_8 =	{prefix_8} {complex_8}
complex_8 =	{real_8}
  | {real_8} "@" {real_8}
  |	{real_8} "+" {imag_8}
  | {real_8} "-" {imag_8}
  |	"+" {imag_8}
  | "-" {imag_8}
imag_8 = "i" | {ureal_8} "i"
real_8 =		{sign} {ureal_8}
ureal_8 =	{uinteger_8} | {uinteger_8} "/" {uinteger_8}
uinteger_8 =		{digit_8}+ "#"*
prefix_8 =		{radix_8} {exactness} | {exactness} {radix_8}


//Base 16
num_16 =	{prefix_16}{complex_16}
complex_16 =	{real_16}
  | {real_16} "@" {real_16}
  |	{real_16} "+" {imag_16}
  | {real_16} "-" {imag_16}
  |	"+" {imag_16}
  | "-" {imag_16}
imag_16 = "i" | {ureal_16} "i"
real_16 =		{sign} {ureal_16}
ureal_16 =	{uinteger_16} | {uinteger_16} "/" {uinteger_16}
uinteger_16 =		{digit_16}+ "#"*
prefix_16 =		{radix_16} {exactness} | {exactness} {radix_16}

//Defined by me:
open_p = "("
close_p = ")"
empty = [] | ""
newline = "\n"
space = " "
sharp = "#"
symbols = "!" | "$" | "%" | "&" | "*" | "/" | ":" | "<" | "=" | ">" | "?" | "~" | "_" | "^"
quotes = "\""
slash = "\\"
anycharacter = .
begin = "begin"
if = "if"
special_characters = {begin} | "let-syntax" | "letrec-syntax" | "define" | "define-syntax" | "quote" | "lambda" | {if} | "set!"
unquotation_marks = "," | ",@"
quotation_mark = "'" | "`"
dot = "."
open_vector = "#("
whitespace = " " | \s
comment = ";"~\n





%%
{comment} {}
\s {}
{number} {System.out.println("Number: " + yytext());}
{dot} {System.out.println("Dot: " + yytext());}
{quotation_mark} {System.out.println("Quotation Mark: " + yytext());}
{open_p} {System.out.println("Left Parenthesis: " + yytext());}
{close_p} {System.out.println("Right Parenthesis: " + yytext());}
{character} {System.out.println("Character: " + yytext());}
{string} {System.out.println("String: " + yytext());}
{unquotation_marks} {System.out.println("Unquotation Mark: " + yytext());}
{open_vector} {System.out.println("Open Vector: " + yytext());}
{boolean} {System.out.println("Boolean: " + yytext());}
{identifier} {System.out.println("Identifier: " + yytext());}
