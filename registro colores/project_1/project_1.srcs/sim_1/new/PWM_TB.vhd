----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2025 01:57:07
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
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

entity pwm_tb is
generic(
k : time := 20 ns
);
end pwm_tb;
 
architecture Behavioral of pwm_tb is
signal clk_p0 : std_logic:='0';
signal duty0 : integer range 0 to 15 := 0;
signal pwm_out0 : std_logic;
component pwm is
port(
clk_p : in std_logic;
duty : in integer range 0 to 15;
pwm_out : out std_logic
);
end component;
begin
pwm0 : pwm 
port map(
  clk_p => clk_p0,
  duty => duty0,
  pwm_out => pwm_out0
);
clk_p0 <= not clk_p0 after 0.25*k;
stim: process
begin
duty0 <= 0;
wait for 1 ms;

duty0 <= 4;
wait for 1 ms;

duty0 <= 8;
wait for 1 ms;

duty0 <= 12;
wait for 1 ms;

duty0 <= 15;
wait for 1 ms;

assert false 
  report "[PASSED] : simulation finished."
  severity failure;
end process;
end Behavioral;
