module labour::Parser

import ParseTree;
import labour::Syntax;

/*
 * Define the parser for the LaBouR language. The name of the function must be parserLaBouR.
 * This function receives as a parameter the path of the file to parse represented as a loc, and returns a parse tree that represents the parsed program.
 */
 
 start[Route] parserLaBouR(loc l) = parse(#start[Route], l);