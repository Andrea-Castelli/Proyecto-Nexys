library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM_CONTROLLER is
    Port (
        clk      : in  STD_LOGIC;
        rst_n    : in  STD_LOGIC;
        valor    : in  STD_LOGIC_VECTOR (3 downto 0); -- Intensidad (0-15)
        pwm_out  : out STD_LOGIC                     -- Salida al LED
    );
end PWM_CONTROLLER;

architecture Behavioral of PWM_CONTROLLER is
    signal contador_interno : std_logic_vector(3 downto 0) := (others => '0');
begin


    process(clk, rst_n)
    begin
        if rst_n = '0' then
            contador_interno <= (others => '0');
        elsif rising_edge(clk) then
            contador_interno <= contador_interno + 1;
        end if;
    end process;

--LED
    pwm_out <= '1' when (contador_interno < valor) else '0';

end Behavioral;
