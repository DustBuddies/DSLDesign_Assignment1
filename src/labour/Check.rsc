module labour::Check

/* 
 * Group 18
 * Arthur Kernkamp 1329529
 * Jeffrey Lint 1529471
 */
 
import labour::AST;

/*
 * -Implement a well-formedness checker for the LaBouR language. For this you must use the AST. 
 * - Hint: Map regular CST arguments (e.g., *, +, ?) to lists 
 * - Hint: Map lexical nodes to Rascal primitive types (bool, int, str)
 * - Hint: Use switch to do case distinction with concrete patterns
 */

 /*
 * Create a function called checkBoulderRouteConfiguration(...), which is responsible for calling all the required functions that check the program's well-formedness as described in the PDF (Section 2.2.) 
 * This function takes as a parameter the program's AST and returns true if the program is well-formed or false otherwise.
 */
 
/*
* Define a function per each verification defined in the PDF (Section 2.2.)
*/

bool checkBoulderRouteConfiguration(RouteA r) {
	// Return true if all checks pass.
    return (
        checkNrHold(r) 		  &&
        checkNrStartHolds(r)  &&
        checkCompleteRDesc(r) &&
        checkGridBasePoint(r) &&
        checkSumStartHolds(r) &&
        checkEndHolds(r) 	  &&
        checkSameColour(r) 	  &&
        checkCompleteHDesc(r) &&
        checkValidColours(r)  &&
        checkRotationBounds(r)
    );
}
 
/*
 * Define a function per each verification defined in the PDF (Section 2.2.)
 */


// Checks whether the route has more than two holds.
bool checkNrHold(RouteA r) {
    nr = 0;
    visit(r) {
        // Count the number of 'hdesc' nodes in the tree, these correspond exactly to roots of subtrees with hold descriptors (i.e. the subtrees describing 1 hold each)
        case hdesc(HDescA h): nr = nr + 1;
    };
    // Return true if at least 2 holds were found.
    return (nr >= 2);
}

// Checks whether the route has at most two start holds.
bool checkNrStartHolds(RouteA r) {
    nr = 0;
    visit(r) {
        // Count the number of 'starting_labels' nodes in the tree, this node exists if and only if the hold it is a subelement of is a start hold.
        case starting_labels(int n): nr = nr + 1;
    };
    // Return true if at most 2 holds with starting labels were found.
    return (nr <= 2);
}

// Checks whether the route has a grade, grid_base_point and identifier.
bool checkCompleteRDesc(RouteA r) {
	// Create flags for each of the required route descriptors.
    grade_flag = false;
    grid_base_flag = false;
    id_flag = false;
    visit(r) {
    	// If route descriptors are found, set corresponding flag to true.
        case grade(str s): grade_flag = true;
        case grid_base_point(CoordA c): grid_base_flag = true;
        case identifier(str s): id_flag = true;
    };
   	
   	// Return true if all route descriptors are present.
    return (grade_flag && grid_base_flag && id_flag);
}

// Checks whether the grid_base_point includes x and y.
bool checkGridBasePoint(RouteA r) {
	// Create flags for both of the required coordinates.
    x_flag = false;
    y_flag = false;
    visit(r) {
    	// If coordinates are found, set corresponding flag to true.
        case xC(int n): x_flag = true;
        case yC(int n): y_flag = true;
    };
    // Return true if both coordinates are present.
    return (x_flag && y_flag);
}

// Checks whether the start holds have at most two strips combined.
bool checkSumStartHolds(RouteA r) {
    nr = 0;
    visit(r) {
    	// Sum up the values of 'starting_labels' nodes in the tree.
        case starting_labels(int n): nr = nr + n;
    };
    // Return true if at most 2 starting labels strips exist.
    return (nr <= 2);
}

// Checks whether the route has at most one end hold.
bool checkEndHolds(RouteA r) {
    nr = 0;
    visit(r) {
    	// Count the number of 'end_label' nodes in the tree, this node exists if and only if the hold it is a subelement of is a end hold.
        case end_label(): nr = nr + 1;
    };
    // Return true if at most 1 end hold was found.
    return (nr <= 1);
}

// Checks whether the route has at most one end hold.
bool checkSameColour(RouteA r) {
    first_colour = "";
    
    top-down-break visit(r) {
    	// Locate the first hold colour and save it in variable first_colour.
        case colour(str s): first_colour = s;
    };
    same = true;
    visit(r) {
    	// Check whether all hold colours are the same as first_colour.
        case colour(str s): same = ((first_colour == s) ? same : false);
    };
    // Return true if all colours are the same.
    return (same);
}

// Checks whether each hold description contains a x, y, shape, rotation and colour.
bool checkCompleteHDesc(RouteA r) {
	visit(r) {
		// Find all holds.
		case hdesc(HDescA h): {
			// Create a flag for hold descriptor of the current hold.
	    	xH_flag = false;
    		yH_flag = false;
    		shape_flag = false;
    		rotation_flag = false;
    		colour_flag = false;
    		
			visit(h) {
				// If hold descriptors are found, set corresponding flag to true.
		        case xH(int x): xH_flag = true;
        		case yH(int y): yH_flag = true;
        		case shape(str s): shape_flag = true;
        		case rotation(int x): rotation_flag = true;
        		case colour(str c): colour_flag = true;
			};
			// If not all hold descriptors are found for a hold, return false. Otherwise, check remaining holds.
			if (xH_flag && yH_flag && shape_flag && rotation_flag && colour_flag) 0; else return false;
		}
	};
	// Return true if all holds have complete descriptions.
    return true;
}

// Checks whether all of the colours in the route are valid.
bool checkValidColours(RouteA r) {
	visit(r) {
		// If colour is not in the set of valid colours, return false. Otherwise, check remaining colours.
		case colour(str c): if (c in {"white", "yellow", "green", "blue", "red", "purple", "pink", "black", "orange"}) 0; else return false;
	};
	// Return true if all found colours are valid.
	return true;
}

// Checks whether all of the rotations in the route are between 0 and 359 inclusive.
bool checkRotationBounds(RouteA r) {
	visit(r) {
		// If rotation is not within the bounds, return false. Otherwise, check remaining rotations.
		case rotation(int n): if (n >= 0 && n <= 359) 0; else return false;
	};
	// Return true if all found rotations are valid.
	return true;
}