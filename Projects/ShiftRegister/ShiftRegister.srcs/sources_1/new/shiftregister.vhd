----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2025 20:48:24
-- Design Name: 
-- Module Name: shiftregister - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shiftregister is
    port(
        J : in std_logic;
        K_bar : in std_logic;
        SH_LD_bar : in std_logic;
        CLR_bar : in std_logic;
        CLK : in std_logic;
        D : in std_logic_vector(3 downto 0);
        Q : out std_logic_vector(3 downto 0)
    );
end shiftregister;

architecture Behavioral of shiftregister is
    --初始化寄存器内部信号
    signal Q_internal : std_logic_vector(3 downto 0) := "0000";
    --搞一个K方便看
    signal K : std_logic;
begin
     K <= not K_bar;
    
    --运算逻辑，当收到CLK或者CLR变化时才触发
    process (CLK, CLR_bar)
    begin
        --定义清零
        if CLR_bar = '0' then
            Q_internal <= "0000";
            
        --设置收到时钟信号时候的判断
        elsif rising_edge(CLK) then
            --如果是LOAD那就直接输入
            if SH_LD_bar = '0' then
                Q_internal <= D;
            else
                --先更新后三位信号
                Q_internal(3) <= Q_internal(2);
                Q_internal(2) <= Q_internal(1);
                Q_internal(1) <= Q_internal(0);
                
                --第一位的输出，写一个JK触发器的行为
                case std_logic_vector'(J & K) is
                    when "00" =>
                        Q_internal(0) <= Q_internal(0);
                    when "01" =>
                        Q_internal(0) <= '0';
                    when "10" =>
                        Q_internal(0) <= '1';
                    when "11" =>
                        Q_internal(0) <= not Q_internal(0);
                    when others =>
                        Q_internal(0) <= Q_internal(0);
                end case;
            end if;
        end if;
    end process;
    --process结束，把内部信号输出
    Q <= Q_internal;
end Behavioral;
