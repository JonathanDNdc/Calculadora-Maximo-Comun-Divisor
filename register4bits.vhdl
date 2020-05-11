library ieee;
use ieee.std_logic_1164.all;

entity register4bits is
    port (
        d            : in  std_logic_vector(3 downto 0);
        clk, ld, rst : in  std_logic;
        q            : out std_logic_vector(3 downto 0)
    );
end entity;

architecture arch of register4bits is begin
    process (rst, clk)
    begin
        if rst = '1' then
            q <= x"0";
        elsif rising_edge(clk) then
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
end arch ; 