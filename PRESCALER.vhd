library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prescaler is
    port(
        clk     : in  std_logic;
        rst_n   : in  std_logic;
        ce_out  : out std_logic
    );
end prescaler;

architecture Behavioral of prescaler is
    signal cnt : integer range 0 to 19 := 0;
begin
    process (clk, rst_n)
    begin
        if rst_n = '0' then
            cnt <= 0;
            ce_out <= '0';
        elsif rising_edge(clk) then
            ce_out <= '0';
            if cnt = 19 then
                cnt <= 0;
                ce_out <= '1';
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
end Behavioral;