library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
    Port (
        clk              : in  STD_LOGIC;
        rst              : in  STD_LOGIC;
        pushbutton_suma  : in  STD_LOGIC;
        pushbutton_resta : in  STD_LOGIC;
        sw               : in  STD_LOGIC_VECTOR (1 downto 0);
        led_rgb_r        : out STD_LOGIC;
        led_rgb_g        : out STD_LOGIC;
        led_rgb_b        : out STD_LOGIC
    );
end TOP;

architecture Behavioral of TOP is

    signal sync_suma, edge_suma, tick_suma   : std_logic;
    signal sync_resta, edge_resta, tick_resta : std_logic;
    signal pulse_suma, pulse_resta           : std_logic;
    signal sel_R, sel_G, sel_B               : std_logic;
    signal cuenta_R, cuenta_G, cuenta_B      : std_logic_vector(3 downto 0);

    component SYNC
        port ( CLK, ASYNC_IN : in std_logic; SYNC_OUT : out std_logic );
    end component;

    component DETECTOR_FLANCO
        port ( CLK, SYNC_IN : in std_logic; EDGE : out std_logic );
    end component;

    component SELECTOR_COLOR
        port ( sw_in : in std_logic_vector(1 downto 0); sel_R, sel_G, sel_B : out std_logic );
    end component;

    component TEMPORIZADOR_BOTONES
        generic ( PERIODO_MS : integer := 50 );
        port ( clk, rst_n, enable : in std_logic; tick : out std_logic );
    end component;

    component REGISTRO
        port( clk, CE_SUMA, CE_RESTA, RST_N : in std_logic; CUENTA : out std_logic_vector(3 downto 0) );
    end component;

    component PWM_CONTROLLER
        port( clk, rst_n : in std_logic; valor : in std_logic_vector(3 downto 0); pwm_out : out std_logic );
    end component;

begin

    inst_SYNC_S: SYNC port map( clk, pushbutton_suma, sync_suma );
    inst_SYNC_R: SYNC port map( clk, pushbutton_resta, sync_resta );

    inst_EDG_S: DETECTOR_FLANCO port map( clk, sync_suma, edge_suma );
    inst_EDG_R: DETECTOR_FLANCO port map( clk, sync_resta, edge_resta );

    inst_SELECTOR: SELECTOR_COLOR port map( sw, sel_R, sel_G, sel_B );

    inst_TEMP_S: TEMPORIZADOR_BOTONES 
        generic map ( PERIODO_MS => 200 )
        port map( clk, rst, sync_suma, tick_suma );
        
    inst_TEMP_R: TEMPORIZADOR_BOTONES 
        generic map ( PERIODO_MS => 200 ) 
        port map( clk, rst, sync_resta, tick_resta );

    pulse_suma  <= edge_suma or tick_suma;
    pulse_resta <= edge_resta or tick_resta;

    inst_REG_R: REGISTRO port map ( clk, (pulse_suma and sel_R), (pulse_resta and sel_R), rst, cuenta_R );
    inst_REG_G: REGISTRO port map ( clk, (pulse_suma and sel_G), (pulse_resta and sel_G), rst, cuenta_G );
    inst_REG_B: REGISTRO port map ( clk, (pulse_suma and sel_B), (pulse_resta and sel_B), rst, cuenta_B );

    inst_PWM_R: PWM_CONTROLLER port map ( clk, rst, cuenta_R, led_rgb_r );
    inst_PWM_G: PWM_CONTROLLER port map ( clk, rst, cuenta_G, led_rgb_g );
    inst_PWM_B: PWM_CONTROLLER port map ( clk, rst, cuenta_B, led_rgb_b );

end Behavioral;