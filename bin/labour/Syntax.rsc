module labour::Syntax

/* 
 * Group 18
 * Arthur Kernkamp 1329529
 * Jeffrey Lint 1529471
 */

/*
 * Define a concrete syntax for LaBouR. The langauge's specification is available in the PDF (Section 2)
 */

/*
 * The route contains one description (Desc).
 */ 
start syntax Route = route: "bouldering_route" "{" Desc "}";

/*
 * The Desc is a recursion of:
 * - RDesc (Basic route descriptors, i.e. grade, grid_base_point and identifier).
 * - HDesc (Hold descriptions).
 */
syntax Desc = desc: RDesc rdesc
 				  | "hold" "{" HDesc hdesc "}"
 				  > left Desc "," Desc;

/*
 * The RDesc describes either the grade, grid_base_point or identifier of the route.
 * The grid_base_point is described by a coordinate (Coord).
 */
syntax RDesc = rdesc: "grade:" Str rdesc
 				    | "grid_base_point" "{" Coord coord "}"
 				    | "identifier:" Str;

/*
 * The Coord is a recursion of either the x/y-coordinate of the lower left corner.
 */
syntax Coord = coord: "x:" Int
 				    | left "y:" Int
 				    > left Coord "," Coord;
 				    
/*
 * The HDesc is a recursion of either:
 * - The x/y-coordinate of the hold.
 * - The shape of the hold.
 * - The Rotation of the hold.
 * - The Colour of the hold.
 * - (Optionally) the amount of starting_labels of the hold.
 * - (Optionally) The indiction that hold has the end_label.
 */
syntax HDesc = hdesc: "x:" Int
                    | left "y:" Int
                    | left "shape:" Str
                    | left "rotation:" Int
                    | left "colour:" Colour
                    | left "starting_labels:" Int
                    | left "end_label"
                    > left HDesc "," HDesc;

/*
 * Data types used:
 * - Int: integer.
 * - Str: a string surrounded by " symbols.
 * - Colour: sequence of letters/numbers not surround by " symbols.
 */
lexical Int = [\-]? [0-9]+ !>> [0-9];
lexical Str = "\"" ![\"]*  "\"";
lexical Colour = [a-zA-Z0-9]+;

layout Whitespace = [\ \t\n\r]*;