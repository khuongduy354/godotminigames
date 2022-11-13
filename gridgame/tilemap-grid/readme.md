TYPES: enum of EMPTY, ACTOR, OBSTACLE
Grid control the object position using TYPES: 
+ inside grid use MAP coordinates, outside use WORLD coordinates
+ Before moving, check the next cell TYPE & collisions 
+ After moving, set the next cell TYPE, clear prev cell TYPE
