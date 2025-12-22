library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TOP_TB is
end TOP_TB;

architecture Behavioral of TOP_TB is
    -- Señales del testbench
    signal clk_tb       : std_logic := '0';
    signal rst_tb       : std_logic := '0';
    signal pushbutton_tb : std_logic := '0';
    signal contador_tb  : std_logic_vector(3 downto 0);
    
    constant CLK_PERIOD : time := 10 ns;
    
    component TOP
        port (
            rst       : in std_logic;
            clk       : in std_logic;
            pushbutton: in std_logic;
            contador  : out std_logic_vector(3 downto 0)
        );
    end component;
    
begin
    DUT: TOP port map (
        rst => rst_tb,
        clk => clk_tb,
        pushbutton => pushbutton_tb,
        contador => contador_tb
    );
    
    -- Generador de reloj
    clk_process: process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD/2;
            clk_tb <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;
    
    -- Proceso de estimulación simplificado
    stim_proc: process
    begin
        -- Reset
        rst_tb <= '0';
        wait for 100 ns;
        rst_tb <= '1';
        wait for 50 ns;
        
        -- Pulsaciones de prueba
        pushbutton_tb <= '1';
        wait for 50 ns;
        pushbutton_tb <= '0';
        wait for 100 ns;
        
        pushbutton_tb <= '1';
        wait for 40 ns;
        pushbutton_tb <= '0';
        wait for 40 ns;
        
        pushbutton_tb <= '1';
        wait for 40 ns;
        pushbutton_tb <= '0';
        wait for 40 ns;
        
        -- Reset
        rst_tb <= '0';
        wait for 50 ns;
        rst_tb <= '1';
        wait for 50 ns;
        
        -- Más pulsaciones
        for i in 1 to 5 loop
            pushbutton_tb <= '1';
            wait for 30 ns;
            pushbutton_tb <= '0';
            wait for 30 ns;
        end loop;
        
        wait for 200 ns;
        report "Simulación completada";
        wait;
    end process;
    
end Behavioral;