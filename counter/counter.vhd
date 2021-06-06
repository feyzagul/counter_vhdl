library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity counter is
generic (
    frekans: integer := 50_000_000
);
port (
    clk: in std_logic;
    anahtar: in std_logic;
    counter: out std_logic_vector (7 downto 0)
);
end counter;

architecture Behavioral of counter is
    constant timer_0_5 : integer := frekans/2;
    constant timer_0_25: integer := frekans/4;
    signal timer: integer range 0 to timer_0_5:= 0;
    signal timer_son: integer range 0 to timer_0_5:= 0;
    signal say: std_logic_vector (7 downto 0) := (others => '0'); 
    signal counter_son: std_logic_vector (7 downto 0) := "11111111";
    begin
        timer_son	<= 	timer_0_5	when anahtar = '1' else
				        timer_0_25  when anahtar = '0' ;
    process (clk) begin
        if (rising_edge(clk)) then

	       if (timer >= timer_son-1) then
		      say	<= say + 1;
		      timer <= 0;
		      if (say=counter_son) then
		          say <= "00000000";
		      end if;
	       else
		      timer <= timer + 1;
	       end if;
        end if;
    end process;
    counter <= say;
end Behavioral;
