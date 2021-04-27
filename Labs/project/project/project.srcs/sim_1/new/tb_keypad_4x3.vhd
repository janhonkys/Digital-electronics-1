----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2021 11:31:44
-- Design Name: 
-- Module Name: tb_keypad_4x3 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_keypad_4x3 is
--  Port ( );
end tb_keypad_4x3;

architecture Behavioral of tb_keypad_4x3 is
    
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    signal  s_clk_100MHz     : std_logic;
    signal  s_hor_1 :   std_logic;
    signal  s_hor_2 :   std_logic;
    signal  s_hor_3 :   std_logic;
    signal  s_hor_4 :   std_logic;
    signal  s_ver_1 :   std_logic;
    signal  s_ver_2 :   std_logic;
    signal  s_ver_3 :   std_logic;
    signal  s_number_i  : std_logic_vector(4 - 1 downto 0);   

begin
     uut_keypad_4x3 : entity work.keypad_4x3
        port map(
            clk     => s_clk_100MHz,
            hor_1   => s_hor_1,
            hor_2   => s_hor_2,
            hor_3   => s_hor_3,
            hor_4   => s_hor_4,
            ver_1   => s_ver_1,
            ver_2   => s_ver_2,
            ver_3   => s_ver_3,
            number_o => s_number_i
        );

p_clk_gen : process
    begin
        while now < 100000000 ns loop   -- 10 usec of simulation
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
     p_stimulus : process
    begin
        
        
        s_hor_1 <= '0';
        s_hor_2 <= '0';
        s_hor_3 <= '0';
        s_hor_4 <= '0';
        s_ver_1 <= '0';
        s_ver_2 <= '0';
        s_ver_3 <= '0';
        
        s_hor_4 <= '1';     --0
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_4 <= '0';     --0
        s_ver_2 <= '0';
        wait for 40 ns;
        
        s_hor_1 <= '1';      --1
        s_hor_3 <= '1'; 
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_1 <= '0';      --1
        s_hor_3 <= '0'; 
        s_ver_1 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';     --2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';     --2
        s_ver_2 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';     --3
        s_ver_3 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';     --3
        s_ver_3 <= '0';
        wait for 40 ns;
        
        s_hor_2 <= '1';     --4
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_2 <= '0'; 
        s_ver_1 <= '0';
        wait for 40 ns;
        
        s_hor_2 <= '1';     --5
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_2 <= '0'; 
        s_ver_2 <= '0';
        wait for 40 ns;
                 
        s_hor_2 <= '1';     --6
        s_ver_3 <= '1';
        wait for 40 ns;
        s_hor_2 <= '0'; 
        s_ver_3 <= '0';
        wait for 40 ns;   
        
        s_hor_1 <= '1';     --7
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_1 <= '0'; 
        s_ver_1 <= '0';
        wait for 40 ns;     
        
        s_hor_1 <= '1';     --8
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_1 <= '0'; 
        s_ver_2 <= '0';
        wait for 40 ns;   
        
        s_hor_1 <= '1';     --9
        s_ver_3 <= '1';
        wait for 40 ns;
        s_hor_1 <= '0'; 
        s_ver_3 <= '0';
        wait for 40 ns; 
        
        s_hor_4 <= '1';     --enter
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_4 <= '0'; 
        s_ver_1 <= '0';
        wait for 40 ns; 
        
        s_hor_4 <= '1';     --cancel
        s_ver_3 <= '1';
        wait for 40 ns;
        s_hor_4 <= '0'; 
        s_ver_3 <= '0';
        wait for 40 ns; 
        
        wait; 
        wait;
    end process p_stimulus;     
        
end Behavioral;
