library ieee;
use ieee.std_logic_1164.all;

entity recordtest is
port(
address: in integer range 0 to 3;
data_out : out std_logic_vector(15 downto 0));
end entity;

architecture recorder of recordtest is

type t_rec1 is record                  
   f1 : std_logic_vector(15 downto 0);
   f2 : std_logic_vector(15 downto 0);
end record t_rec1;

type t_rec1_array is array (natural range 0 to 255) of t_rec1;

constant recarr1 : t_rec1_array := (
   1      => (f1 => x"0111", f2 => x"0111"),
   2      => (f1 => x"0011", f2 => x"0111"),
   others => (f1 => x"1111", f2 => x"0111"));


function get_f2 (f1 : std_logic_vector(15 downto 0)) return std_logic_vector is
  variable result : std_logic_vector(15 downto 0);
begin
  result := (others => 'X');

  for i in recarr1'range loop
    if (recarr1(i).f1 = f1) then
      result := recarr1(i).f2;
      exit;
    end if;
  end loop;

  return result;
end function get_f2;

begin

data_out <= get_f2(x"0111");

end architecture;