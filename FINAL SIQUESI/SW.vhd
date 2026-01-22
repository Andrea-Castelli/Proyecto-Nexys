library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SELECTOR_COLOR is
    Port (
        sw           : in  STD_LOGIC_VECTOR (1 downto 0);
        tick_suma    : in  STD_LOGIC;
        tick_resta   : in  STD_LOGIC;
        
        ce_suma_r    : out STD_LOGIC;
        ce_resta_r   : out STD_LOGIC;
        
        ce_suma_g    : out STD_LOGIC;
        ce_resta_g   : out STD_LOGIC;
        
        ce_suma_b    : out STD_LOGIC;
        ce_resta_b   : out STD_LOGIC
    );
end SELECTOR_COLOR;

architecture Behavioral of SELECTOR_COLOR is
begin
    process(sw, tick_suma, tick_resta)
    begin
        ce_suma_r  <= '0'; ce_resta_r <= '0';
        ce_suma_g  <= '0'; ce_resta_g <= '0';
        ce_suma_b  <= '0'; ce_resta_b <= '0';

        case sw is
            when "01" => 
                ce_suma_r  <= tick_suma;
                ce_resta_r <= tick_resta;
            when "10" => 
                ce_suma_g  <= tick_suma;
                ce_resta_g <= tick_resta;
            when "11" => 
                ce_suma_b  <= tick_suma;
                ce_resta_b <= tick_resta;
            when others =>
                null; 
        end case;
    end process;
end Behavioral;
