library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GENERADOR_RGB_tb is
-- Un testbench no tiene puertos
end GENERADOR_RGB_tb;

architecture Sim of GENERADOR_RGB_tb is

    -- 1. Declaración del componente que vamos a probar (UUT)
    component GENERADOR_RGB
        Port (
            clk_placa    : in std_logic;
            rst_n        : in std_logic;
            boton_suma   : in std_logic;
            boton_resta  : in std_logic;
            LED          : out std_logic
        );
    end component;

    -- 2. Señales internas para conectar con la UUT
    signal clk_tb         : std_logic := '0';
    signal rst_n_tb       : std_logic := '0';
    signal boton_suma_tb  : std_logic := '0';
    signal boton_resta_tb : std_logic := '0';
    signal LED_tb         : std_logic;

    -- Constante de periodo de reloj (100MHz para la Nexys 4 DDR)
    constant clk_period : time := 10 ns;

begin

    -- 3. Instanciación de la Unidad Bajo Prueba (UUT)
    uut: GENERADOR_RGB
        port map (
            clk_placa   => clk_tb,
            rst_n       => rst_n_tb,
            boton_suma  => boton_suma_tb,
            boton_resta => boton_resta_tb,
            LED         => LED_tb
        );

    -- 4. Generación del reloj
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;

    -- 5. Proceso de estímulos
    stim_proc: process
    begin		
        -- Mantener reset un tiempo
        rst_n_tb <= '0';
        wait for 50 ns;
        rst_n_tb <= '1'; -- Liberar reset
        wait for 50 ns;

        -- Simular pulsación de botón de suma
        -- Nota: En un TB, 'pulso' el botón poniéndolo a '1' y luego a '0'
        boton_suma_tb <= '1';
        wait for 20 ns;
        boton_suma_tb <= '0';
        
        wait for 200 ns; -- Esperar a ver cómo reacciona el PWM

        -- Simular otra pulsación de suma
        boton_suma_tb <= '1';
        wait for 20 ns;
        boton_suma_tb <= '0';

        wait for 500 ns;

        -- Simular pulsación de resta
        boton_resta_tb <= '1';
        wait for 20 ns;
        boton_resta_tb <= '0';

        -- Dejar correr la simulación un tiempo para observar el ciclo del PWM
        wait for 2000 ns;

        -- Detener simulación
        report "Simulación finalizada correctamente";
        wait;
    end process;

end Sim;