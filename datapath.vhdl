library ieee;
use ieee.std_logic_1164.all;

entity datapath is
    port (
        clk, rst               : in  std_logic;
        X_i, Y_i               : in  std_logic_vector(3 downto 0);
        X_sel, Y_sel           : in  std_logic;
        X_ld, Y_ld             : in  std_logic;
        O_enb                  : in  std_logic;
        X_gt_Y, X_eq_Y, X_lt_Y : out std_logic;
        Data_o                 : out std_logic_vector(3 downto 0)
    );
end datapath;

architecture arch of datapath is
    component mux is
        port (
            x, y : in  std_logic_vector(3 downto 0);
            sel  : in  std_logic;
            res  : out std_logic_vector(3 downto 0)
        );
    end component;

    component register4bits is
        port (
            d            : in  std_logic_vector(3 downto 0);
            clk, ld, rst : in  std_logic;
            q            : out std_logic_vector(3 downto 0)
        );
    end component;

    component comparator is
        port (
            X, Y                : in  std_logic_vector(3 downto 0);
            xy_eq, xy_gt, xy_lt : out std_logic;
            R                   : out std_logic_vector(3 downto 0)
        );
    end component;

    component subtractor4bits is
        port (
            a, b : in  std_logic_vector(3 downto 0);
            bin  : in  std_logic;
            bout : out std_logic;
            d    : out std_logic_vector(3 downto 0)
        );
    end component;

    signal x1, x2, x3 : std_logic_vector(3 downto 0);
    signal y1, y2, y3 : std_logic_vector(3 downto 0);
    signal res        : std_logic_vector(3 downto 0);
begin
        mux_x : mux port map (X_i, x3, X_sel, x1);
        mux_y : mux port map (Y_i, y3, Y_sel, y1);

        reg_x : register4bits port map (x1, clk, X_ld, rst, x2);
        reg_y : register4bits port map (y1, clk, Y_ld, rst, y2);

        comp : comparator port map (x2, y2, X_eq_Y, X_gt_Y, X_lt_Y, res);

        x_sub_y : subtractor4bits port map (x2, y2, '0', open, x3);
        y_sub_x : subtractor4bits port map (y2, x2, '0', open, y3);

        reg_o : register4bits port map(res, clk, O_enb, rst, Data_o);
end arch;