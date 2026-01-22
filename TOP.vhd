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
        led_rgb_b        : out STD_LOGIC  -- He quitado el punto y coma de aquí
    );
end TOP;

architecture Behavioral of TOP is
    signal rst_high : std_logic;
    signal c_r, c_g, c_b : std_logic_vector(3 downto 0);

    component BLOQUE_REGISTRO
        generic ( PERIODO_MS : integer );
        port ( clk, rst, rst_n_int, pushbutton_suma, pushbutton_resta : in std_logic;
               sw : in std_logic_vector(1 downto 0); cuenta_R, cuenta_G, cuenta_B : out std_logic_vector(3 downto 0) );
    end component;

    component BLOQUE_PWM
        port ( clk, rst, rst_n_i : in std_logic; valor : in std_logic_vector(3 downto 0); pwm_out : out std_logic );
    end component;

begin
    rst_high <= not rst;

    inst_CONTROL: BLOQUE_REGISTRO 
        generic map(200)
        port map(
            clk => clk, rst => rst_high, rst_n_int => rst,
            pushbutton_suma => pushbutton_suma, pushbutton_resta => pushbutton_resta,
            sw => sw, cuenta_R => c_r, cuenta_G => c_g, cuenta_B => c_b
        );

    inst_PWM_R: BLOQUE_PWM port map(clk => clk, rst => rst_high, rst_n_i => rst, valor => c_r, pwm_out => led_rgb_r);
    inst_PWM_G: BLOQUE_PWM port map(clk => clk, rst => rst_high, rst_n_i => rst, valor => c_g, pwm_out => led_rgb_g);
    inst_PWM_B: BLOQUE_PWM port map(clk => clk, rst => rst_high, rst_n_i => rst, valor => c_b, pwm_out => led_rgb_b);

end Behavioral;