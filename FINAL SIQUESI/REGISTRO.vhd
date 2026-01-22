library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REGISTRO is
    port(
        clk      : IN std_logic;
        CE_SUMA  : IN std_logic;
        CE_RESTA : IN std_logic;
        RST_N    : IN std_logic;
        CUENTA   : OUT std_logic_vector(3 downto 0)
    );
end REGISTRO;

architecture Behavioral of REGISTRO is
    signal temp_cuenta : unsigned(3 downto 0);
begin
    process(clk, RST_N)
    begin
        if RST_N = '1' then
            temp_cuenta <= (others => '0');
        elsif rising_edge(clk) then
            if CE_SUMA = '1' and temp_cuenta /= "1111" then
                temp_cuenta <= temp_cuenta + 1;
            elsif CE_RESTA = '1' and temp_cuenta /= "0000" then
                temp_cuenta <= temp_cuenta - 1;
            end if;
        end if;
    end process;
    CUENTA <= std_logic_vector(temp_cuenta);
end Behavioral;
