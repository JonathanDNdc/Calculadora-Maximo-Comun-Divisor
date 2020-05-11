library ieee;
use ieee.std_logic_1164.all;

entity mcd_tb is
end mcd_tb;

architecture arch of mcd_tb is
    component mcd is
        port(
            clk, rst : in  std_logic;
            GO_i     : in  std_logic;
            X_i      : in  std_logic_vector(3 downto 0);
            Y_i      : in  std_logic_vector(3 downto 0);
            Data_o   : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk              : std_logic := '0';
    signal rst, GO_i        : std_logic;
    signal X_i, Y_i, Data_o : std_logic_vector(3 downto 0);
begin

    clk <= not clk after 1 ns;

        uut : mcd port map(clk, rst, GO_i, X_i, Y_i, Data_o);

    process
    begin
        X_i  <= "1111";
        Y_i  <= "0101";
        rst  <= '1';
        GO_i <= '0';
        wait for 10 ns;
        rst <= '0';
        GO_i <= '1', '0' after 30 ns;
        wait for 200 ns;

        X_i  <= "1010";
        Y_i  <= "0010";
        rst  <= '1';
        GO_i <= '0';
        wait for 10 ns;
        rst <= '0';
        GO_i <= '1', '0' after 30 ns;
        wait for 200 ns;

        X_i  <= "0011";
        Y_i  <= "1001";
        rst  <= '1';
        GO_i <= '0';
        wait for 10 ns;
        rst <= '0';
        GO_i <= '1', '0' after 30 ns;
        wait for 200 ns;

        X_i  <= "0111";
        Y_i  <= "0010";
        rst  <= '1';
        GO_i <= '0';
        wait for 10 ns;
        rst <= '0';
        GO_i <= '1', '0' after 30 ns;
        wait for 200 ns;

        X_i  <= "1100";
        Y_i  <= "1000";
        rst  <= '1';
        GO_i <= '0';
        wait for 10 ns;
        rst <= '0';
        GO_i <= '1', '0' after 30 ns;
        wait for 200 ns;
        wait;
    end process;

end arch;

