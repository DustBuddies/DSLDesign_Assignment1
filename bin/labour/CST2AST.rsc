module labour::CST2AST

/* 
 * Group 18
 * Arthur Kernkamp 1329529
 * Jeffrey Lint 1529471
 */
 
import labour::AST;
import labour::Syntax;

import String;

/*
 * Implement a mapping from concrete syntax trees (CSTs) to abstract syntax trees (ASTs)
 * Hint: Use switch to do case distinction with concrete patterns
 * Map regular CST arguments (e.g., *, +, ?) to lists
 * Map lexical nodes to Rascal primitive types (bool, int, str)
 */

/* 
 * Function call inputs the root of the CST into the load function and returns the corresponding AST.
 */
RouteA cst2ast(start[Route] r) {
	return load(r.top);
}

/*
 * For each data type, all possible received a transformation rule into appropriate AST.
 */
RouteA load((Route)`bouldering_route { <Desc d> }`) = route(load(d));

DescA load((Desc)`<RDesc rdescriptor>`) = rdesc(load(rdescriptor));
DescA load((Desc)`hold { <HDesc hdescriptor> }`) = hdesc(load(hdescriptor));
DescA load((Desc)`<Desc desc1>, <Desc desc2>`) = joinDesc(load(desc1), load(desc2));

RDescA load((RDesc)`grade: <Str gradeID>`) = grade("<gradeID>");
RDescA load((RDesc)`grid_base_point { <Coord coord> }`) = grid_base_point(load(coord));
RDescA load((RDesc)`identifier: <Str id>`) = identifier("<id>");

CoordA load((Coord)`x: <Int xCoord>`) = xC(toInt("<xCoord>"));
CoordA load((Coord)`y: <Int yCoord>`) = yC(toInt("<yCoord>"));
CoordA load((Coord)`<Coord coord1>, <Coord coord2>`) = joinCoord(load(coord1), load(coord2));

HDescA load((HDesc)`x: <Int xHold>`) = xH(toInt("<xHold>"));
HDescA load((HDesc)`y: <Int yHold>`) = yH(toInt("<yHold>"));
HDescA load((HDesc)`shape: <Str shapeName>`) = shape("<shapeName>");
HDescA load((HDesc)`rotation: <Int degrees>`) = rotation(toInt("<degrees>"));
HDescA load((HDesc)`colour: <Colour colourName>`) = colour("<colourName>");
HDescA load((HDesc)`starting_labels: <Int labels>`) = starting_labels(toInt("<labels>"));
HDescA load((HDesc)`end_label`) = end_label();
HDescA load((HDesc)`<HDesc hdesc1>, <HDesc hdesc2>`) = joinHDesc(load(hdesc1), load(hdesc2));