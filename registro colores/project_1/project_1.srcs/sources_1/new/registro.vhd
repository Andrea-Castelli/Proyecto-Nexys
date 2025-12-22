library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registro is
port(
    clk: in std_logic;
    CE: in std_logic;
    cuenta: out std_logic_vector(3 downto 0); --de momento 4 bits
    rst_n: in std_logic
    
    );
end registro;

architecture Behavioral of registro is
    signal cuenta_i: unsigned(cuenta'range);
begin

    process(clk, rst_n)
    begin 
        if(rst_n='0') then
            cuenta_i <= (others=>'0');
        elsif rising_edge(clk) then
            if CE='1' then
                cuenta_i<=cuenta_i +1;
            end if;
        end if;
    end process;
    
    cuenta<= std_logic_vector(cuenta_i);
end Behavioral;
