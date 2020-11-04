library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_async is
	port(
	clock 	 : in std_logic;
	address  : in std_logic_vector(7 downto 0);
	start    : in std_logic;
	data     : out std_logic_vector(31 downto 0);
	done     : out std_logic := '0';
        found    : out std_logic := '0';
	data_A   : in std_logic_vector(15 downto 0);
	data_B   : out std_logic_vector(15 downto 0));
end entity;

architecture rom_async_arch of rom_async is

	--signal start_flag : std_logic := '0';
	--signal complete_flag : std_logic := '0';

type t_rec1 is record                  
   f1 : std_logic_vector(15 downto 0);
   f2 : std_logic_vector(15 downto 0);
end record t_rec1;

type t_rec1_array is array (natural range 0 to 255) of t_rec1;

--ROM data
constant recarr1 : t_rec1_array := (
   1    => (f1 => x"FFFF", f2 => x"FFFF"),
   2      => (f1 => x"0000", f2 => x"0000"),
   others => (f1 => x"1111", f2 => x"1111"));

function get_f2 (chkvalue : std_logic_vector(15 downto 0)) return std_logic_vector is
  variable result : std_logic_vector(31 downto 0);

begin

--loop through rom and exit on found e
  for i in recarr1'range loop
    if (recarr1(i).f1 = chkvalue) then
      result := recarr1(i).f1 & recarr1(i).f2;
      exit;
    end if;
  end loop;

  return result;
end function get_f2;

	begin

	MEMORY: process(start, clock)
		 variable complete_run : std_logic := '0';
		 variable data_eval     : std_logic_vector(31 downto 0);
		 variable data_a_chk    : std_logic_vector(15 downto 0);

	    begin

		if(rising_edge(start))then 
			done <= '0';
		 	found <= '0';
		elsif(rising_edge(clock)) then
			data_eval := get_f2(data_A);
			data_B <= data_eval(15 downto 0);
			data_a_chk := data_eval(31 downto 16);
			data <= data_eval;
		end if;
	end process;

end architecture;