module labour::AST

/*
 * Define the Abstract Syntax for LaBouR
 *
 * - make sure there is an almost one-to-one correspondence with the grammar in Syntax.rsc
 */
 
 data Route = route(list[RDesc] rDescriptors,
                     Hold holds);
                     
 data RDesc = grade(str gradeID)
             | grid_base_point(Coord coord)
             | identifier(str id);
 
 data Coord = xC(int xCoord)
             | yC(int yCoord)
             | joinCoord(Coord lhc, Coord rhc);
 
 data Hold = hold(HDesc hDescriptor)
            | joinHold(Hold lhh, Hold rhh);
            
 data HDesc = xH(int xHold)
             | yH(int yHold)
             | shape(str shapeName)
             | rotation(int degrees)
             | colour(str colourName)
             | starting_labels(int labels)
             | end_label(bool ending)
             | joinHDesc(HDesc lhhd, HDesc rhhd);