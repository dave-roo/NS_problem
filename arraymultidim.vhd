-- Creates a 4x3 array for a number pad
type t_Row_Col is array (0 to 3, 0 to 2) of integer range 0 to 9;
signal r_Number : t_Row_Col;
 
-- Accessing The Array:
r_Choice <= r_Number(0, 1);
 
r_Number(3, 2) <= 9;