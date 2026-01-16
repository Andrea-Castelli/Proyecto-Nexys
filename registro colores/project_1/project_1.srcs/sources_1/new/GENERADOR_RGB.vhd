library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GENERADOR_RGB is
    Port (
        clk_placa   : in std_logic;
        rst_n       : in std_logic; 
        boton_suma  : in std_logic;
        boton_resta : in std_logic;
        LED         : out std_logic
    );
end GENERADOR_RGB;

architecture Structural of GENERADOR_RGB is
    signal s_suma_sync, s_resta_sync : std_logic;
    signal tick_suma, tick_resta     : std_logic;
    signal valor_cuenta              : std_logic_vector(3 downto 0);
begin

    -- Instancias respetando tu jerarquía (image_1f53c6.png)
    sync_s : entity work.SYNC
        port map (CLK => clk_placa, ASYNC_IN => boton_suma, SYNC_OUT => s_suma_sync);

    temp_s : entity work.TEMPORIZADOR_BOTONES
        port map (clk => clk_placa, rst_n => rst_n, enable => s_suma_sync, tick => tick_suma);

    sync_r : entity work.SYNC
        port map (CLK => clk_placa, ASYNC_IN => boton_resta, SYNC_OUT => s_resta_sync);

    temp_r : entity work.TEMPORIZADOR_BOTONES
        port map (clk => clk_placa, rst_n => rst_n, enable => s_resta_sync, tick => tick_resta);

    inst_reg : entity work.registro
        port map (clk => clk_placa, rst_n => rst_n, CE_SUMA => tick_suma, 
                  CE_RESTA => tick_resta, cuenta => valor_cuenta);

    inst_pwm : entity work.pwm
        port map (clk_p => clk_placa, duty => to_integer(unsigned(valor_cuenta)), pwm_out => LED);

end Structural;