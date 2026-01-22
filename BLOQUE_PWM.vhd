library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BLOQUE_PWM is
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        rst_n_i : in  std_logic;
        valor   : in  std_logic_vector(3 downto 0);
        pwm_out : out std_logic
    );
end BLOQUE_PWM;

architecture Behavioral of BLOQUE_PWM is
    signal ce_internal : std_logic;

    component prescaler
        port ( clk, rst_n : in std_logic; ce_out : out std_logic );
    end component;

    component PWM_CONTROLLER
        port ( clk, rst_n, ce : in std_logic; valor : in std_logic_vector(3 downto 0); pwm_out : out std_logic );
    end component;

begin
    inst_PRE: prescaler 
        port map( clk => clk, rst_n => rst_n_i, ce_out => ce_internal );

    inst_PWM: PWM_CONTROLLER 
        port map( clk => clk, rst_n => rst, ce => ce_internal, valor => valor, pwm_out => pwm_out );
end Behavioral;