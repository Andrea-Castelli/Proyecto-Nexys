----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2025 11:49:38
-- Design Name: 
-- Module Name: prescaler_tb - Behavioral
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

entity prescaler_tb is
generic (
K : time := 20 ns
);
end prescaler_tb;

architecture Behavioral of prescaler_tb is
--signal clk_ayuda: std_logic;
signal clk0: std_logic:='0';
signal clk_out0 : std_logic;
component prescaler is
  port(
  clk : in std_logic;
  clk_out: out std_logic
  );
  end component;
begin
prescaler0 : prescaler
  port map(
  clk => clk0,
  clk_out => clk_out0
  );
clk0 <= not clk0 after 0.5*K;
process
begin
wait for 5ms;
assert false 
  report "[PASSED] : simulation finished."
  severity failure;
  end process;
end Behavioral;
