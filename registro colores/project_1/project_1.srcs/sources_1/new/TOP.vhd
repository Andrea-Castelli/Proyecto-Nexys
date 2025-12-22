
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TOP is
 port (
    rst : in std_logic;
    clk : in std_logic;
    pushbutton : in std_logic;
    contador : out std_logic_vector(0 TO 3)
 );
end TOP;

architecture Behavioral of TOP is
    signal sync_i: std_logic;
    signal edge_i: std_logic;
    signal contador_i: std_logic_vector(contador'range);
    
    component SYNC
        port (
             CLK : in std_logic;
             ASYNC_IN : in std_logic;
             SYNC_OUT : out std_logic
         );
    end component;
    
    component DETECTOR_FLANCO
        port (
            CLK : in std_logic;
            SYNC_IN : in std_logic;
            EDGE : out std_logic
        );
    end component;
    
    component registro
    port(
        clk     : IN std_logic;
        CE      : IN std_logic;
        RST_N   : IN std_logic;
        CUENTA    : OUT std_logic_vector(3 downto 0)
    );
    end component;
begin

contador<= contador_i;
        inst_SYNC: SYNC port map(
             CLK => CLK,
             ASYNC_IN => PUSHBUTTON,
             SYNC_OUT => sync_i
        );
        
        inst_DETECTOR_FLANCO: DETECTOR_FLANCO port map(
            CLK => CLK,
            SYNC_IN => sync_i,
            EDGE =>edge_i
        );
        
        inst_registro: registro PORT MAP (
           CLK => clk,
           cuenta => contador_i,
           CE => sync_i,
           RST_N => rst
        );

end Behavioral;
