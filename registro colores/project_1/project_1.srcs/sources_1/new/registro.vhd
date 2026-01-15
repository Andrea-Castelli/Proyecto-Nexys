library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registro is
port(
    clk: in std_logic;
    CE_SUMA: in std_logic;
    CE_RESTA: in std_logic;
    cuenta: out std_logic_vector(3 downto 0); --de momento 4 bits
    rst_n: in std_logic
    
    );
end registro;

architecture Behavioral of registro is
    signal cuenta_i: unsigned(3 downto 0):= (others => '0'); --inicializo a 0
begin

    process(clk, rst_n)
    begin 
        if(rst_n='0') then
            cuenta_i <= (others=>'0');
        elsif rising_edge(clk) then
            if CE_SUMA='1' and cuenta_i /="1111" then
                cuenta_i<=cuenta_i +1;
            elsif CE_RESTA='1' and cuenta_i /="0000"then
                cuenta_i <=cuenta_i -1;
            end if;
        end if;
    end process;
    
    cuenta<= std_logic_vector(cuenta_i);
end Behavioral;
