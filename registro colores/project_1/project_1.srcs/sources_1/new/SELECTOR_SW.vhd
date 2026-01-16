library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SELECTOR_COLOR is
    Port (
        sw_in : in  STD_LOGIC_VECTOR (1 downto 0);
        sel_R : out STD_LOGIC;
        sel_G : out STD_LOGIC;
        sel_B : out STD_LOGIC
    );
end SELECTOR_COLOR;

architecture Behavioral of SELECTOR_COLOR is
begin
    sel_R <= '1' when sw_in = "01" else '0';
    sel_G <= '1' when sw_in = "10" else '0';
    sel_B <= '1' when sw_in = "11" else '0';
end Behavioral;