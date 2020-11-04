library ieee;
use ieee.std_logic_1164.all;

entity rom16x8 is
port(
address: in integer range 0 to 15;
data_out : out std_logic_vector(7 downto 0));

end entity;

architecture sevenseg of rom16x8 is

type NIBBLE is array (1 downto 0) of std_logic_vector(3 downto 0);
type MEM is array (0 to 3) of NIBBLE;
-- an array "array of array" type
constant MEM8X4 : MEM := (("0000", "0000"), ("0000", "0000"), ("0000", "0000"), ("0000", "0000"));


begin
--X_2D <= ((0,0), (1,1), (2,2), (3,3));
--test <= MEM8X4 (to_integer(unsigned("0000")));

data_out <= MEM8X4("0000");
end architecture;