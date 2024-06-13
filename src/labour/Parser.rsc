module labour::Parser

/* 
 * Group 18
 * Arthur Kernkamp 1329529
 * Jeffrey Lint 1529471
 */

import ParseTree;
import labour::Syntax;

/*
 * Define the parser for the LaBouR language. The name of the function must be parserLaBouR.
 * This function receives as a parameter the path of the file to parse represented as a loc, and returns a parse tree that represents the parsed program.
 */
 
 // Parse function that takes a file at location l and returns the parse tree corresponding to the concrete LaBouR bouldering route.
 start[Route] parserLaBouR(loc l) = parse(#start[Route], l);