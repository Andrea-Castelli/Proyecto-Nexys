library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prescaler is
  port(
  clk: in std_logic;
  clk_out: out std_logic
  );
end prescaler;

architecture Behavioral of prescaler is
signal cnt : integer range 0 to 6249 := 0; --para que nos de el resultado en 500hz
signal clk_aux: std_logic := '0';
begin
process (clk)
begin
  if rising_edge(clk) then
    if cnt = 6249 then
      cnt <= 0;
      clk_aux<= not clk_aux;
    else
      cnt <= cnt+1;
    end if;
  end if;
end process;
clk_out<= clk_aux;
end Behavioral;