module labour::Syntax

/*
 * Define a concrete syntax for LaBouR. The langauge's specification is available in the PDF (Section 2)
 */

start syntax Route = route: "bouldering_route" "{" RDesc+ rdesc Hold holds "}";
syntax Hold = hold: "hold" "{" HDesc hdesc "}"
				  > left Hold "," Hold;

// Route description
syntax RDesc = rdesc: "grade:" Str ","
 				    | "grid_base_point" "{" Coord coord "},"
 				    | "identifier:" Str ",";

// Coordinate description
syntax Coord = coord: "x:" Int
 				    | left "y:" Int
 				    > left Coord "," Coord;
 				    
// Hold description
syntax HDesc = hdesc: "x:" Int
                    | left "y:" Int
                    | left "shape:" Str
                    | left "rotation:" Int
                    | left "colour:" Colour
                    | left "starting_labels:" Int
                    | left "end_label"
                    > left HDesc "," HDesc;

lexical Int = [\-]? [0-9]+ !>> [0-9];
lexical Colour = "white" | "yellow" | "green" | "blue" | "red" | "purple" | "pink" | "black" | "orange";
lexical Str = "\"" ![\"]*  "\"";

layout Whitespace = [\ \t\n\r]*;