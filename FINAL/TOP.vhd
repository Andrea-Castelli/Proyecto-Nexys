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

    signal tick_suma_global, tick_resta_global : std_logic;
    signal rst_n_internal : std_logic;
    
    signal cuenta_R, cuenta_G, cuenta_B : std_logic_vector(3 downto 0);

    signal ce_s_r, ce_r_r, ce_s_g, ce_r_g, ce_s_b, ce_r_b : std_logic;

    component TEMPORIZADOR_BOTONES
        generic ( PERIODO_MS : integer );
        port ( clk, rst_n, enable : in std_logic; tick : out std_logic );
    end component;

    component SELECTOR_COLOR
        port (
            sw : in std_logic_vector(1 downto 0);
            tick_suma, tick_resta : in std_logic;
            ce_suma_r, ce_resta_r, ce_suma_g, ce_resta_g, ce_suma_b, ce_resta_b : out std_logic
        );
    end component;

    component REGISTRO
        port( clk, CE_SUMA, CE_RESTA, RST_N : IN std_logic; CUENTA : OUT std_logic_vector(3 downto 0) );
    end component;

    component PWM_CONTROLLER
        port( clk, rst_n : in std_logic; valor : in std_logic_vector(3 downto 0); pwm_out : out std_logic );
    end component;

begin
    rst_n_internal <= not rst;

    inst_T_SUMA: TEMPORIZADOR_BOTONES generic map(200) 
        port map(clk => clk, rst_n => rst_n_internal, enable => pushbutton_suma, tick => tick_suma_global);

    inst_T_RESTA: TEMPORIZADOR_BOTONES generic map(200) 
        port map(clk => clk, rst_n => rst_n_internal, enable => pushbutton_resta, tick => tick_resta_global);

    inst_SELECTOR: SELECTOR_COLOR 
        port map(
            sw         => sw,
            tick_suma  => tick_suma_global,
            tick_resta => tick_resta_global,
            ce_suma_r  => ce_s_r, ce_resta_r => ce_r_r,
            ce_suma_g  => ce_s_g, ce_resta_g => ce_r_g,
            ce_suma_b  => ce_s_b, ce_resta_b => ce_r_b
        );

    inst_REG_R: REGISTRO port map(clk=>clk, RST_N=>rst, CE_SUMA=>ce_s_r, CE_RESTA=>ce_r_r, CUENTA=>cuenta_R);
    inst_REG_G: REGISTRO port map(clk=>clk, RST_N=>rst, CE_SUMA=>ce_s_g, CE_RESTA=>ce_r_g, CUENTA=>cuenta_G);
    inst_REG_B: REGISTRO port map(clk=>clk, RST_N=>rst, CE_SUMA=>ce_s_b, CE_RESTA=>ce_r_b, CUENTA=>cuenta_B);

    inst_PWM_R: PWM_CONTROLLER port map(clk=>clk, rst_n=>rst, valor=>cuenta_R, pwm_out=>led_rgb_r);
    inst_PWM_G: PWM_CONTROLLER port map(clk=>clk, rst_n=>rst, valor=>cuenta_G, pwm_out=>led_rgb_g);
    inst_PWM_B: PWM_CONTROLLER port map(clk=>clk, rst_n=>rst, valor=>cuenta_B, pwm_out=>led_rgb_b);

end Behavioral;
