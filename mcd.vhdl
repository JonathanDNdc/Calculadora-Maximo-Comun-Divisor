library ieee;
use ieee.std_logic_1164.all;

entity mcd is
    port(
        clk, rst : in  std_logic;
        GO_i     : in  std_logic;
        X_i      : in  std_logic_vector(3 downto 0);
        Y_i      : in  std_logic_vector(3 downto 0);
        Data_o   : out std_logic_vector(3 downto 0)
    );
end mcd;

architecture arch of mcd is
    component datapath is
        port (
            clk, rst               : in  std_logic;
            X_i, Y_i               : in  std_logic_vector(3 downto 0);
            X_sel, Y_sel           : in  std_logic;
            X_ld, Y_ld             : in  std_logic;
            O_enb                  : in  std_logic;
            X_gt_Y, X_eq_Y, X_lt_Y : out std_logic;
            Data_o                 : out std_logic_vector(3 downto 0)
        );
    end component;

    component controller is
        port(
            clk, rst : in  std_logic;
            GO_i     : in  std_logic;
            X_gt_Y   : in  std_logic;
            X_eq_Y   : in  std_logic;
            X_lt_Y   : in  std_logic;
            X_sel    : out std_logic;
            Y_sel    : out std_logic;
            X_ld     : out std_logic;
            Y_ld     : out std_logic;
            O_enb    : out std_logic
        );
    end component;

    signal X_sel, Y_sel           : std_logic;
    signal X_ld, Y_ld             : std_logic;
    signal X_gt_Y, X_eq_Y, X_lt_Y : std_logic;
    signal O_enb                  : std_logic;

begin
        ctrl : controller port map(
            clk, rst, GO_i,
            X_gt_Y, X_eq_Y,X_lt_Y,
            X_sel, Y_sel,
            X_ld, Y_ld, O_enb
        );

        dp : datapath port map(
            clk, rst,
            X_i, Y_i,
            X_sel, Y_sel,
            X_ld, Y_ld,
            O_enb,
            X_gt_Y, X_eq_Y, X_lt_Y,
            Data_o
        );

end arch;