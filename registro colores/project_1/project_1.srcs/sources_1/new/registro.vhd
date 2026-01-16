library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registro is
    port(
        clk      : in std_logic;
        rst_n    : in std_logic;
        CE_SUMA  : in std_logic; 
        CE_RESTA : in std_logic; 
        cuenta   : out std_logic_vector(3 downto 0)
    );
end registro;

architecture Behavioral of registro is
    signal cuenta_i : unsigned(3 downto 0) := (others => '0');
    signal s_ant, r_ant : std_logic := '0';
begin
    process(clk, rst_n)
    begin 
        if rst_n = '0' then
            cuenta_i <= (others => '0');
            s_ant <= '0'; r_ant <= '0';
        elsif rising_edge(clk) then
            s_ant <= CE_SUMA; r_ant <= CE_RESTA;
            -- Detecta el flanco del tick para sumar solo una vez
            if (CE_SUMA = '1' and s_ant = '0') then
                if cuenta_i /= "1111" then cuenta_i <= cuenta_i + 1; end if;
            elsif (CE_RESTA = '1' and r_ant = '0') then
                if cuenta_i /= "0000" then cuenta_i <= cuenta_i - 1; end if;
            end if;
        end if;
    end process;
    cuenta <= std_logic_vector(cuenta_i);
end Behavioral;
