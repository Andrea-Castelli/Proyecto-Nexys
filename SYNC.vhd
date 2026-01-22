library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNCHRONIZER is
    Port (
        clk      : in  STD_LOGIC;
        async_in : in  STD_LOGIC;
        sync_out : out STD_LOGIC
    );
end SYNCHRONIZER;

architecture Behavioral of SYNCHRONIZER is
    signal reg : std_logic_vector(1 downto 0) := "00";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            reg(0) <= async_in;
            reg(1) <= reg(0); -- Doble etapa para estabilidad
        end if;
    end process;
    
    sync_out <= reg(1);
end Behavioral;