library ieee;
use ieee.std_logic_1164.all;

entity rom_async_TB is
end entity;

architecture rom_async_TB_arch of rom_async_TB is

    constant ClockFrequency : integer := 100e6; -- 100 MHz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
 
    signal clock    : std_logic := '1';
    signal reset_TB   : std_logic := '0';
    signal start_TB : std_logic := '0';
    signal address_TB : std_logic_vector(7 downto 0);
    signal data_TB : std_logic_vector(31 downto 0);
    signal done_TB   : std_logic := '1';
    signal found_TB : std_logic := '1';
    signal data_A_TB : std_logic_vector(15 downto 0);
    signal data_B_TB : std_logic_vector(15 downto 0);

component rom_async
	port (
	clock: std_logic;
	address : in std_logic_vector(7 downto 0);
	start    : in std_logic;
      	data : out std_logic_vector(31 downto 0) := x"00000000";
        done : out std_logic;
	found : out std_logic;
        data_A : in std_logic_vector(15 downto 0);
	data_B : out std_logic_vector(15 downto 0));
end component;

	begin

	DUT : rom_async port map (clock, address_TB, start_TB, data_TB, done_TB, found_TB, data_A_TB, data_B_TB);

        -- Process for generating the clock
        clock <= not clock after ClockPeriod / 2;

	ADDRESS_STIM : process
	begin
	
        -- Take the DUT out of reset
        reset_TB <= '1';

	-- start pulse
	wait for 5 ns;
        start_TB <= '1';
	wait for 5 ns;
        start_TB <= '0';

	--Search for the value below
	data_A_TB <= x"FFFF";
	wait for 100 ns;

        -- Reset the DUT
        reset_TB <= '0';

	end process;

end architecture;