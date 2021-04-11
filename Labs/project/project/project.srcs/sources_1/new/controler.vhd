----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2021 20:26:12
-- Design Name: 
-- Module Name: controler - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controler is
 port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        number_i : in  std_logic_vector(4 - 1 downto 0);
        door_i : out  std_logic;
        alarm_o : out  std_logic;
        locker_o : out  std_logic
        
    );
end controler;

architecture Behavioral of controler is
    
    
    
    type   t_state is (CLOSE, OPENED, WAITH, ALARM, MASTER);
    signal s_state  : t_state;
    
    signal   s_clk  : std_logic; 
    signal   s_pass  : std_logic_vector(16 - 1 downto 0);
    signal   s_pos_pass  : std_logic_vector(2 - 1 downto 0);
    signal   s_cnt  : unsigned(5 - 1 downto 0);
    signal   s_number  : std_logic_vector(4 - 1 downto 0);
    signal   s_alarm  : std_logic;
    signal   s_door  : std_logic;

    constant c_DELAY_10SEC : unsigned(5 - 1 downto 0) := b"1_0000"; --upravit podla cnt
    constant c_ZERO       : unsigned(5 - 1 downto 0) := b"0_0000";
    
    constant c_MASTER_pass : std_logic_vector(16 - 1 downto 0) := b"0001_0001_0001_0001";
    constant c_SLAVE_pass : std_logic_vector(16 - 1 downto 0) := b"0001_0001_0001_0001";
    
    constant UNDEFINED : std_logic_vector(4 - 1 downto 0) := b"1111";
    constant c_UNDEFINED_pass : std_logic_vector(16 - 1 downto 0) := b"1111_1111_1111_1111";
    
    begin

    p_keypad_watcher : process(clk)
    begin
        if falling_edge(clk) then
           
            if(s_number = UNDEFINED)then
            else
                if(s_pos_pass = '00')then
                    s_pass(16 - 1 downto 12) <= number_i;
                elsif(s_pos_pass = '01')then
                    s_pass(12 - 1 downto 8) <= number_i;
                elsif(s_pos_pass = '10')then
                    s_pass(8 - 1 downto 4) <= number_i;
                elsif(s_pos_pass = '11')then
                    s_pass(4 - 1 downto 0) <= number_i;
                end if;
            end if;
        end if;
    
    
    end process p_keypad_watcher;
    
    
    p_result_controler : process(clk)
    begin
        if falling_edge(clk) then
            if (s_alarm = '1') then 
                if (s_pass = c_MASTER_pass)then
                    s_alarm <= '0';
                    s_pass <= c_UNDEFINED_pass ;
                else 
                    s_alarm <='1';
                end if;
            else
                
                case s_state is

                    when CLOSE =>
                        
                        if (s_pass = c_MASTER_pass OR s_pass = c_SLAVE_pass)then
                            s_state <= OPENED;
                        else 
                            s_state <= CLOSE;
                            locker_o <= '0';
                        end if;
                    
                    when OPENED =>

                        if (s_cnt < c_DELAY_10SEC) then
                            s_cnt <= s_cnt + 1;
                            locker_o <= '1';
                        else
                            s_state <= WAITH;
                            locker_o <= '0';
                            s_cnt   <= c_ZERO;
                        end if;
                    
                    when WAITH =>
                    
                        if (s_cnt < c_DELAY_10SEC) then
                            s_cnt <= s_cnt + 1;
                            s_cnt   <= c_ZERO;
                        elsif (s_door = '1') then
                            s_state <= CLOSE;
                            s_pass <= c_UNDEFINED_pass ;
                        elsif (s_pass = c_MASTER_pass) then
                            s_state <= MASTER;
                            s_pass <= c_UNDEFINED_pass ;
                        else
                            s_state <= ALARM;
                            s_cnt   <= c_ZERO;
                            s_pass <= c_UNDEFINED_pass ;
                        end if;
                    
                    when ALARM =>
                        s_alarm <= '1';
                     
                    when MASTER =>
                        if (s_door = '1') then
                            s_state <= CLOSE;
                        else    
                            s_state <= MASTER;
                        end if;
                    when others =>
                        s_state <= CLOSE;

                end case;
            end if; -- Alarm
        end if; -- Falling edge
    end process p_result_controler;

end Behavioral;