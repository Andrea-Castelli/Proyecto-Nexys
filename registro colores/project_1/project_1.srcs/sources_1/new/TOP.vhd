
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BLOQUE_REGISTRO is
 port (
    rst : in std_logic;
    clk : in std_logic;
    pushbutton_suma : in std_logic;
    pushbutton_resta : in std_logic;
    contador : out std_logic_vector(3 downto 0)
 );
end BLOQUE_REGISTRO;

architecture Behavioral of BLOQUE_REGISTRO is
    signal sync_suma_i: std_logic;
    --signal edge_suma_i: std_logic;
    signal sync_resta_i: std_logic;
    --signal edge_resta_i: std_logic;
    signal contador_i: std_logic_vector(contador'range);
    
    signal tick_suma_i: std_logic;
    signal tick_resta_i: std_logic;
    
    component SYNC
        port (
             CLK : in std_logic;
             ASYNC_IN : in std_logic;
             SYNC_OUT : out std_logic
         );
    end component;
    
--    component DETECTOR_FLANCO
--        port (
--            CLK : in std_logic;
--            SYNC_IN : in std_logic;
--            EDGE : out std_logic
--        );
--    end component;
    
    component TEMPORIZADOR_BOTONES
        generic (
            PERIODO_MS : integer := 50
        );
        port (
            clk    : in std_logic;
            rst_n  : in std_logic;
            enable : in std_logic;
            tick   : out std_logic
        );
    end component;
    
    component REGISTRO
    port(
        clk          : IN std_logic;
        CE_SUMA      : IN std_logic;
        CE_RESTA     : IN std_logic;
        RST_N        : IN std_logic;
        CUENTA       : OUT std_logic_vector(3 downto 0)
    );
    end component;
begin

contador<= contador_i;
inst_SYNC_SUMA: SYNC port map(
    CLK => CLK,
    ASYNC_IN => pushbutton_suma,
    SYNC_OUT => sync_suma_i
);

inst_SYNC_RESTA: SYNC port map(
    CLK => CLK,
    ASYNC_IN => pushbutton_resta,
    SYNC_OUT => sync_resta_i
);
        

--inst_DETECTOR_FLANCO_SUMA: DETECTOR_FLANCO port map(
--    CLK => CLK,
--    SYNC_IN => sync_suma_i,
--    EDGE =>edge_suma_i
--);

--inst_DETECTOR_FLANCO_RESTA: DETECTOR_FLANCO port map(
--    CLK => CLK,
--    SYNC_IN => sync_resta_i,
--    EDGE =>edge_resta_i
--);

    inst_TEMP_SUMA: TEMPORIZADOR_BOTONES
        generic map (PERIODO_MS => 50)
        port map (
            clk    => clk,
            rst_n  => rst,
            enable => sync_suma_i,
            tick   => tick_suma_i
        );
    
    inst_TEMP_RESTA: TEMPORIZADOR_BOTONES
        generic map (PERIODO_MS => 50)
        port map (
            clk    => clk,
            rst_n  => rst,
            enable => sync_resta_i,
            tick   => tick_resta_i
        );
    
        
inst_REGISTRO: REGISTRO PORT MAP (
    CLK => clk,
    cuenta => contador_i,
    CE_SUMA => tick_suma_i,
    CE_RESTA => tick_resta_i,
    RST_N => rst
        );

end Behavioral;
