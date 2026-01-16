library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pwm is
    port(
        clk_p   : in std_logic;
        duty    : in integer range 0 to 15;
        pwm_out : out std_logic
    );
end pwm; 

architecture Behavioral of pwm is
    signal contador : integer range 0 to 15 := 0;
begin
    process(clk_p)
    begin
        if rising_edge(clk_p) then
            -- CORRECCIÓN: Reset del contador al llegar al máximo
            if contador = 15 then contador <= 0;
            else contador <= contador + 1;
            end if;

            if contador < duty then pwm_out <= '1';
            else pwm_out <= '0';
            end if;
        end if;
    end process; 
end Behavioral;