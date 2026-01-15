----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2026 09:31:42
-- Design Name: 
-- Module Name: GENERADOR_RGB - Behavioral
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
use IEEE.NUMERIC_STD.ALL; --para el integer

entity GENERADOR_RGB is
    Port (
        clk_placa               : in std_logic;
        rst_n                   : in std_logic;      
        boton_suma              : in std_logic; 
        boton_resta             : in std_logic; 
        LED                     : out std_logic   
    );
end GENERADOR_RGB;

architecture Structural of GENERADOR_RGB is
    signal valor_i : std_logic_vector(3 downto 0); --valor del registro

    component BLOQUE_REGISTRO is
        port (
            rst              : in std_logic;
            clk              : in std_logic;
            pushbutton_suma  : in std_logic;
            pushbutton_resta : in std_logic;
            contador         : out std_logic_vector(3 downto 0)
        );
    end component;

    component BLOQUE_PWM is
        Port (
            clk    : in std_logic;
            duty   : in integer range 0 to 15; 
            brillo : out std_logic
        );
    end component;

begin

    inst_registro : BLOQUE_REGISTRO
        port map (
            rst              => rst_n,
            clk              => clk_placa,
            pushbutton_suma  => boton_suma,
            pushbutton_resta => boton_resta,
            contador         => valor_i
        );

    inst_pwm : BLOQUE_PWM
        port map (
            clk    => clk_placa,           -- Mismo reloj para todo el sistema
            duty   => to_integer(unsigned(valor_i)), -- convertir a integer
            brillo => LED              
        );

end Structural;