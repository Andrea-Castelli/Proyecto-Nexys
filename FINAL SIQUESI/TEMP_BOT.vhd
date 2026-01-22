library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TEMPORIZADOR_BOTONES is
    generic (
        PERIODO_MS : integer := 200
    );
    port (
        clk    : in std_logic;
        rst_n  : in std_logic;
        enable : in std_logic;
        tick   : out std_logic
    );
end TEMPORIZADOR_BOTONES;

architecture Behavioral of TEMPORIZADOR_BOTONES is
    constant FREC_CLK : integer := 100_000_000; 
    constant CICLOS   : integer := (FREC_CLK / 1000) * PERIODO_MS; 
    signal contador : integer range 0 to CICLOS := 0;
    signal tick_i   : std_logic := '0';
    signal enable_prev : std_logic := '0';
begin
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            contador <= 0;
            tick_i <= '0';
            enable_prev <= '0';
        elsif rising_edge(clk) then
            tick_i <= '0';
            if enable = '1' then
                if enable_prev = '0' then
                    tick_i <= '1';
                    contador <= 0;
                elsif contador >= CICLOS - 1 then
                    contador <= 0;
                    tick_i <= '1';
                else
                    contador <= contador + 1;
                end if;
            else
                contador <= 0;
            end if;
            enable_prev <= enable;
        end if;
    end process;
    tick <= tick_i;
end Behavioral;
