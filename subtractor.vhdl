library ieee;
use ieee.std_logic_1164.all;

entity subtractor is
    port (
        a, b, bin : in  std_logic;
        d, bout   : out std_logic
    );
end entity;

architecture arch of subtractor is
begin
    d    <= a xor (b xor bin);
    bout <= (not a and b) or (b and bin) or (not a and bin);
end arch;