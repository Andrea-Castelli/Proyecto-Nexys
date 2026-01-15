----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2025 00:35:41
-- Design Name: 
-- Module Name: pwm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
port(
clk_p : in std_logic;
duty : in integer range 0 to 15;
pwm_out : out std_logic
);
end pwm; 

architecture Behavioral of pwm is
signal contador : integer range 0 to 15;
begin
process(clk_p)
begin
if rising_edge(clk_p) then
  if contador = 15 then
    contador <= 0; 
  else 
    contador <= contador + 1;
  end if;
  if contador < duty then
    pwm_out <= '1';
  else
    pwm_out <= '0';
  end if;
end if;
end process; 

end Behavioral;