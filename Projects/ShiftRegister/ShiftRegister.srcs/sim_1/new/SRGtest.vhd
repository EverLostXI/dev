-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sat, 06 Dec 2025 10:48:53 GMT
-- Request id : cfwk-fed377c2-69340a155ca90

library ieee;
use ieee.std_logic_1164.all;

entity SRGtest is
end SRGtest;

architecture Behavioral of SRGtest is

    component shiftregister
        port (J       : in std_logic;
              K_bar   : in std_logic;
              SH_LD_bar : in  std_logic;
              CLR_bar : in std_logic;
              CLK     : in  std_logic;
              D       : in std_logic_vector (3 downto 0);
              Q       : out std_logic_vector (3 downto 0));
    end component;

    signal J_tb       : std_logic := '0';
    signal K_bar_tb   : std_logic := '0';
    signal SH_LD_bar_tb : std_logic := '1';
    signal CLR_bar_tb : std_logic := '1';
    signal CLK_tb     : std_logic := '0';
    signal D_tb       : std_logic_vector (3 downto 0) := "0000";
    signal Q_tb       : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 20 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : shiftregister
    port map (CLK     => CLK_tb,
              CLR_bar => CLR_bar_tb,
              J       => J_tb,
              K_bar   => K_bar_tb,
              SH_LD_bar => SH_LD_bar_tb,
              D       => D_tb,
              Q       => Q_tb);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    CLK_tb <= TbClock;

    --  ***EDIT*** Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        wait for TbPeriod / 2;
        J_tb <= '0';
        K_bar_tb <= '0';
        SH_LD_bar_tb <= '1';
        D_tb <= (others => '0');
        CLR_bar_tb <= '1';
        wait for TbPeriod / 4;
    
        
        CLR_bar_tb <= '0';
        wait for TbPeriod * 3 / 4;
        CLR_bar_tb <= '1';
        wait for TbPeriod / 2;
        
        J_tb <= '1';
        K_bar_tb <= '1';
        wait for TbPeriod;
        
        J_tb <= '0';
        K_bar_tb <= '0';
        wait for TbPeriod / 4;
        
        J_tb <= '1';
        wait for TbPeriod * 2.5;
        
        J_tb <= '0';
        wait for TbPeriod * 1.25;

        D_tb <= "0101";
        wait for TbPeriod / 4;
        
        SH_LD_bar_tb <= '0';
        wait for TbPeriod * 3 / 4;
        
        SH_LD_bar_tb <= '1';
        D_tb <= "0000";
        wait for TbPeriod * 1.25;
        
        K_bar_tb <= '1';
        wait for TbPeriod * 2;
        
        K_bar_tb <= '0';
        wait for TbPeriod * 3;
    
        TbSimEnded <= '1';
        wait;
    end process;

end Behavioral;
