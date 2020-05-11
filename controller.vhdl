library ieee;
use ieee.std_logic_1164.all;

entity controller is
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
end controller;

architecture arch of controller is
    type state_type is (START, INPUT, TEST, UPDATE_X, UPDATE_Y, DONE);
    signal present_state, next_state : state_type;
begin

process (clk, rst)
begin
    if (rst = '1') then
        present_state <= START;
    elsif rising_edge(clk) then
        present_state <= next_state;
    end if;
end process;

process (present_state, GO_i, X_gt_Y, X_eq_Y, X_lt_Y)
begin 
    case present_state is
        when START =>
            if (GO_i = '1') then
                next_state <= INPUT;
            else
                next_state <= START;
            end if;
        when INPUT =>
            next_state <= TEST;
        when TEST =>
            if (X_eq_Y = '1') then
                next_state <= DONE;
            elsif (X_gt_Y = '1') then
                next_state <= UPDATE_X;
            else
                next_state <= UPDATE_Y;
            end if;
        when UPDATE_X =>
            next_state <= TEST;
        when UPDATE_Y =>
            next_state <= TEST;
        when DONE =>
            next_state <= DONE;
        when others => null;
    end case;
end process;

process (present_state)
begin
    X_ld <= '0';
    Y_ld <= '0';
    O_enb <= '0';
    X_sel <= '1';
    Y_sel <= '1';

    case present_state is
        when INPUT =>
            X_ld <= '1';
            Y_ld <= '1';
            X_sel <= '0';
            Y_sel <= '0';
        when UPDATE_X =>
            X_ld <= '1';
        when UPDATE_Y =>
            Y_ld <= '1';
        when DONE =>
            O_enb <= '1';
        when others => null;
    end case;
end process;
    
end arch;