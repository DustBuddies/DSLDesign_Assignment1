module labour::Syntax

extend lang::std::Layout;
extend lang::std::Id;

/*
 * Define a concrete syntax for LaBouR. The langauge's specification is available in the PDF (Section 2)
 */

start syntax Route = route: "bouldering_route {" RDesc rdesc Hold* holds "}";
syntax Hold = hold: "hold {" HDesc* hdesc "},";

// Route description
syntax RDesc = rdesc: "grade: \"" Str "\","
 				  | "grid_base_point { x: " Int ", y: " Int "},"
 				  | "identifier: \"" Str "\",";

// Hold description
syntax HDesc = hdesc: "x: " Int
                  | "y: " Int
                  | "shape: \"" Str "\""
                  | "rotation: " Int
                  | "colour: " Str
                  | "starting_labels: " Int
                  | "end_label";

lexical Str = [A-Za-z0-9\-]*;
lexical Int = [0-9]*;

layout Whitespace = [\ \t\n\r]*;