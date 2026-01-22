library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_CONTROLLER is
    port(
        clk     : in std_logic;
        rst_n   : in std_logic;
        ce      : in std_logic;
        valor   : in std_logic_vector(3 downto 0);
        pwm_out : out std_logic
    );
end PWM_CONTROLLER;

architecture Behavioral of PWM_CONTROLLER is
    signal counter : unsigned(3 downto 0);
begin
    process(clk, rst_n)
    begin
        if rst_n = '1' then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            if ce = '1' then
                counter <= counter + 1;
            end if;
        end if;
    end process;
    pwm_out <= '1' when counter < unsigned(valor) else '0';
end Behavioral;