module labour::AST

/* 
 * Group 18
 * Arthur Kernkamp 1329529
 * Jeffrey Lint 1529471
 */

/*
 * Define the Abstract Syntax for LaBouR
 *
 * - make sure there is an almost one-to-one correspondence with the grammar in Syntax.rsc
 */

/*
 * All ADT's have an "A" added to differentiate them from the concrete syntax.
 * Each data/node type has (a) child node(s) corresponding directly to the concrete syntax.  
 */
data RouteA = route(DescA desc);

data DescA = rdesc(RDescA rdesc)
 		   | hdesc(HDescA hdesc)
     	   | joinDesc(DescA lhd, DescA rhd);

data RDescA = grade(str gradeID)
            | grid_base_point(CoordA coord)
            | identifier(str id);
            
data CoordA = xC(int xCoord)
            | yC(int yCoord)
            | joinCoord(CoordA lhc, CoordA rhc);
           
data HDescA = xH(int xHold)
            | yH(int yHold)
            | shape(str shapeName)
            | rotation(int degrees)
            | colour(str colourName)
            | starting_labels(int labels)
            | end_label()
            | joinHDesc(HDescA lhhd, HDescA rhhd);