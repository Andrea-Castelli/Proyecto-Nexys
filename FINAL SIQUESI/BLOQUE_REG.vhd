library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BLOQUE_REGISTRO is
    generic (
        PERIODO_MS : integer := 200
    );
    port (
        clk              : in  std_logic;
        rst              : in  std_logic;
        rst_n_int        : in  std_logic;
        pushbutton_suma  : in  std_logic;
        pushbutton_resta : in  std_logic;
        sw               : in  std_logic_vector(1 downto 0);
        cuenta_R         : out std_logic_vector(3 downto 0);
        cuenta_G         : out std_logic_vector(3 downto 0);
        cuenta_B         : out std_logic_vector(3 downto 0)
    );
end BLOQUE_REGISTRO;

architecture Behavioral of BLOQUE_REGISTRO is
    signal s_btn_s, s_btn_r : std_logic;
    signal tick_s, tick_r   : std_logic;
    signal ce_s_r, ce_r_r, ce_s_g, ce_r_g, ce_s_b, ce_r_b : std_logic;

    component SYNCHRONIZER
        port ( clk, async_in : in std_logic; sync_out : out std_logic );
    end component;
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

begin
    sync_s: SYNCHRONIZER port map(clk => clk, async_in => pushbutton_suma, sync_out => s_btn_s);
    sync_r: SYNCHRONIZER port map(clk => clk, async_in => pushbutton_resta, sync_out => s_btn_r);

    temp_s: TEMPORIZADOR_BOTONES generic map(PERIODO_MS) 
        port map(clk => clk, rst_n => rst_n_int, enable => s_btn_s, tick => tick_s);
    temp_r: TEMPORIZADOR_BOTONES generic map(PERIODO_MS) 
        port map(clk => clk, rst_n => rst_n_int, enable => s_btn_r, tick => tick_r);

    sel: SELECTOR_COLOR port map(
        sw => sw, tick_suma => tick_s, tick_resta => tick_r,
        ce_suma_r => ce_s_r, ce_resta_r => ce_r_r,
        ce_suma_g => ce_s_g, ce_resta_g => ce_r_g,
        ce_suma_b => ce_s_b, ce_resta_b => ce_r_b
    );

    reg_r: REGISTRO port map(clk => clk, RST_N => rst, CE_SUMA => ce_s_r, CE_RESTA => ce_r_r, CUENTA => cuenta_R);
    reg_g: REGISTRO port map(clk => clk, RST_N => rst, CE_SUMA => ce_s_g, CE_RESTA => ce_r_g, CUENTA => cuenta_G);
    reg_b: REGISTRO port map(clk => clk, RST_N => rst, CE_SUMA => ce_s_b, CE_RESTA => ce_r_b, CUENTA => cuenta_B);
end Behavioral;
