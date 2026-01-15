----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.01.2026 21:37:27
-- Design Name: 
-- Module Name: TOP_PWM - Behavioral
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

entity BLOQUE_PWM is
    Port (
        clk: in std_logic;  
        duty : in integer range 0 to 15;
        brillo : out std_logic
    );
end BLOQUE_PWM;

architecture Structural of BLOQUE_PWM is
    signal clk_i : std_logic;
    
    component prescaler is
        port(
            clk     : in std_logic;
            clk_out : out std_logic
        );
    end component;
    
    component pwm is
        port(
            clk_p   : in std_logic;
            duty    : in integer range 0 to 15;
            pwm_out : out std_logic
        );
    end component;
    
begin

    inst_prescaler: prescaler
        port map(
            clk     => clk,  
            clk_out => clk_i    
        );
    
    inst_pwm: pwm
        port map(
            clk_p   => clk_i,   
            duty    => duty,        
            pwm_out => brillo         
        );

end Structural;
