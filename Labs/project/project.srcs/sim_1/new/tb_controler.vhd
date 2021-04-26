----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2021 18:32:00
-- Design Name: 
-- Module Name: tb_tlc_improved - Behavioral
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

entity tb_controler is
--  Port ( );
end tb_controler;

architecture testbench of tb_controler is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz     : std_logic;
    signal s_reset          : std_logic;
    signal s_number_i       : std_logic_vector(4 - 1 downto 0);
    signal s_door_i         : std_logic;
    signal s_alarm_o        : std_logic;
    signal s_locker_o       : std_logic;
    
    signal  s_hor_1 :   std_logic;
    signal  s_hor_2 :   std_logic;
    signal  s_hor_3 :   std_logic;
    signal  s_hor_4 :   std_logic;
    signal  s_ver_1 :   std_logic;
    signal  s_ver_2 :   std_logic;
    signal  s_ver_3 :   std_logic;
    
    signal  s_data0_o :   std_logic_vector(4-1 downto 0);
    signal  s_data1_o :   std_logic_vector(4-1 downto 0);
    signal  s_data2_o :   std_logic_vector(4-1 downto 0);
    signal  s_data3_o :   std_logic_vector(4-1 downto 0);
    
    signal  s_rgb_o :   std_logic_vector(3-1 downto 0);
    
    
    
begin
            -- signals shift from controler to signals in this tb
    uut_controler : entity work.controler
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            number_i => s_number_i,
            door_i   => s_door_i ,
            alarm_o   => s_alarm_o ,
            locker_o  => s_locker_o, 
            
            rgb_o => s_rgb_o,
       
            data0_o => s_data0_o,
            data1_o => s_data1_o,
            data2_o => s_data2_o,
            data3_o => s_data3_o        
            
        );
            -- -- signals shift from keypad to signals in this tb
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
         -- proces for clock
    p_clk_gen : process
    begin
        while now < 100000000 ns loop       -- while is time less than 10s
            s_clk_100MHz <= '0';            -- then clk_100MHz is 0
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';            -- after 5 ns is 1 
            wait for c_CLK_100MHZ_PERIOD / 2;
                                            -- and loop until time will be 10s
        end loop;
        wait;
    end process p_clk_gen;
    
    p_stimulus : process
    begin
        
        
        s_hor_1 <= '0';
        s_hor_2 <= '0';            -- set to 0
        s_hor_3 <= '0';
        s_hor_4 <= '0';
        s_ver_1 <= '0';
        s_ver_2 <= '0';
        s_ver_3 <= '0';
        s_door_i <= '0';
        
        s_reset <= '1';             -- set reset to 1
        wait for 100 ns;
        s_reset <= '0';             -- set reset to 0
        wait for 10 ns;
        
        s_hor_3 <= '1';             -- press 1
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_1 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 1
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_1 <= '0';
        wait for 40 ns;
        
        s_hor_4 <= '1'; 
        s_ver_3 <= '1';             -- press cancel
        wait for 40 ns;
        s_hor_4 <= '0';             -- set signal to zero
        s_ver_3 <= '0';
        wait for 40 ns;
        
        
        s_hor_3 <= '1';             -- press 2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_2 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_2 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_2 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_2 <= '0';
        wait for 40 ns;
        
        
        s_hor_4 <= '1';             -- press enter
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_4 <= '0';             -- set signals to zero
        s_ver_1 <= '0';
        
        wait for 1.6 us;
        s_door_i <= '1';            -- door will be closed
         wait for  40 ns;
        
        wait for 1 us;
        
        s_hor_3 <= '1';             -- press 2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_2 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_2 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_2 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 2
        s_ver_2 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_2 <= '0';
        wait for 40 ns;
                
        s_hor_4 <= '1'; 
        s_ver_1 <= '1';             -- press enter
        wait for 40 ns;
        s_hor_4 <= '0';             -- set signal to zero
        s_ver_1 <= '0';
        wait for 40 ns;        
        s_door_i <= '0';            -- door will be closed 
        wait for 2 us;      
              
        s_hor_3 <= '1';             -- press 1
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_1 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 1
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_1 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 1
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_1 <= '0';
        wait for 40 ns;
        
        s_hor_3 <= '1';             -- press 1
        s_ver_1 <= '1';
        wait for 40 ns;
        s_hor_3 <= '0';             -- set signals to zero
        s_ver_1 <= '0';
        wait for 40 ns;
                
        s_hor_4 <= '1'; 
        s_ver_1 <= '1';             -- press enter
        wait for 40 ns;
        s_hor_4 <= '0'; 
        s_ver_1 <= '0';       
                
        wait; 
         
        wait;
    end process p_stimulus;        

end testbench;