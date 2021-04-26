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
        clk       : in  std_logic;                                  -- input for clock
        reset     : in  std_logic;                                  -- input for reset
        number_i  : in  std_logic_vector(4 - 1 downto 0);           -- input for number
        door_i    : in  std_logic;                                  -- input for door
        alarm_o   : out  std_logic;                                 -- output for alarm
        locker_o  : out  std_logic;                                 -- output for "locker"
        
        rgb_o     : out  std_logic_vector(3 - 1 downto 0);          -- output for RGB diode
        
        data0_o   : out  std_logic_vector(4 - 1 downto 0);          -- output for first number of password
        data1_o   : out  std_logic_vector(4 - 1 downto 0);          -- output for second number of password
        data2_o   : out  std_logic_vector(4 - 1 downto 0);          -- output for third number of password
        data3_o   : out  std_logic_vector(4 - 1 downto 0)           -- output for fourth number of password
        
    );
end controler;

architecture Behavioral of controler is
    
    type   t_state is (CLOSE, OPENED, WAITH, AFTERTIME, ALARM, MASTER);             -- types of states
    signal s_state  : t_state;                                                      -- assign state to signal
    
    type   t_state_pass is (POS1, POS2, POS3, POS4, ENT);                           -- types of states by pressing of buttons
    signal s_state_pass  : t_state_pass;                                            -- assign state_pass to signal
    
    signal   s_clk  : std_logic;                                                    -- signal for clock
    
    signal   s_cnt  : unsigned(32 - 1 downto 0):= b"0000_0000_0000_0000_0000_0000_0000_0000"; -- nejak neviem zisti? ?o je to s_cnt
    
    signal   s_alarm  : std_logic;                              -- signal for alarm
    signal   s_reset_pass : std_logic;                          -- signal for reset password
    
    signal   s_pass_1  : std_logic_vector(4 - 1 downto 0);      -- signal for first password position 
    signal   s_pass_2  : std_logic_vector(4 - 1 downto 0);      -- for second
    signal   s_pass_3  : std_logic_vector(4 - 1 downto 0);      -- for third
    signal   s_pass_4  : std_logic_vector(4 - 1 downto 0);      -- for last
    signal   s_pass : std_logic_vector(16 - 1 downto 0);        -- signal for whole password
                                                               
    
    constant c_DELAY_10SEC : unsigned(32 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_0110_0100";       -- time constant for 10s (but changed to 100ns, becose we want see that in our simulation)
    constant c_ZERO       : unsigned(32 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_0000_0000";        -- time constant for 0s
                                                                                                          
    constant c_MASTER_pass : std_logic_vector(16 - 1 downto 0) := b"0001_0001_0001_0001";                   -- master password is 1111
    constant c_SLAVE_pass : std_logic_vector(16 - 1 downto 0) := b"0010_0010_0010_0010";                    -- normal password is 2222
    constant c_UNDEFINED_pass : std_logic_vector(16 - 1 downto 0) := b"1111_1111_1111_1111";                -- undefined password
    
    constant c_UNDEFINED : std_logic_vector(4 - 1 downto 0) := b"1111";                                     -- constant for unexistent button
    constant c_CANCEL : std_logic_vector(4 - 1 downto 0) := b"1011";                                        -- constant for cancel
    constant c_ENTER : std_logic_vector(4 - 1 downto 0) := b"1010";                                         -- constant for enter
    
    constant c_RED : std_logic_vector(3 - 1 downto 0) := b"100";                                            -- constants for rgb diode   - for red
    constant c_GREEN : std_logic_vector(3 - 1 downto 0) := b"010";                                          --                           - for green
    constant c_YELOW : std_logic_vector(3 - 1 downto 0) := b"110";                                          --                           - for yellow

    begin
    
    
    p_keypad_watcher : process(clk, s_reset_pass, reset)
    begin
        
    if reset = '1' then
        s_pass <= c_UNDEFINED_pass;                         -- password will be undefined
        s_pass_1 <= c_UNDEFINED;                            -- first position will be undefined
        s_pass_2 <= c_UNDEFINED;                            -- second
        s_pass_3 <= c_UNDEFINED;                            -- third
        s_pass_4 <= c_UNDEFINED;
        s_state_pass <= POS1;    
    
    else    
        if s_reset_pass = '1' then -- treba dako vyhutat        -- if s_reset_pass = 1 then
            s_pass <= c_UNDEFINED_pass;                         -- password will be undefined
            s_pass_1 <= c_UNDEFINED;                            -- first position will be undefined
            s_pass_2 <= c_UNDEFINED;                            -- second
            s_pass_3 <= c_UNDEFINED;                            -- third
            s_pass_4 <= c_UNDEFINED;                            -- and last
        end if;
        
        if falling_edge(clk) then
            
                if(number_i = c_UNDEFINED)then
                
                                                                    -- proces for enter password
                else
     
                    case (s_state_pass) is
                        when POS1 =>                                                -- assign first position
                            if (number_i = c_CANCEL OR number_i = c_ENTER)then      -- if is pressed cancel or enter
                                s_pass_1 <= c_UNDEFINED;                            -- then first position will be undefined
                                s_pass_2 <= c_UNDEFINED;                            -- second
                                s_pass_3 <= c_UNDEFINED;                            -- third
                                s_pass_4 <= c_UNDEFINED;                            -- fourth
                                s_state_pass <= POS1;                               -- and whole password
                            else 
                                s_pass_1 <= number_i;                               -- if it is number 1-9 then we have first position 
                                s_state_pass <= POS2;                               -- and change state to POS2
                            end if;
                            
                        when POS2 => 
                                                                                    -- pos2
                            if (number_i = c_CANCEL OR number_i = c_ENTER)then      -- same as pos1
                                s_pass_1 <= c_UNDEFINED;
                                s_pass_2 <= c_UNDEFINED;
                                s_pass_3 <= c_UNDEFINED;
                                s_pass_4 <= c_UNDEFINED;
                                s_state_pass <= POS1;
                            else 
                                s_pass_2 <= number_i;                               -- now we have second position
                                s_state_pass <= POS3;                               -- and change state to POS3
                            end if;
                            
                        when POS3 =>                                                -- same as pos2
                            if (number_i = c_CANCEL OR number_i = c_ENTER)then    
                                s_pass_1 <= c_UNDEFINED;
                                s_pass_2 <= c_UNDEFINED;
                                s_pass_3 <= c_UNDEFINED;
                                s_pass_4 <= c_UNDEFINED;
                                s_state_pass <= POS1;
                            else 
                                s_pass_3 <= number_i;
                                s_state_pass <= POS4;
                            end if;  
                            
                        when POS4 =>                                                -- same as pos2
                            if (number_i = c_CANCEL)then
                                s_pass_1 <= c_UNDEFINED;
                                s_pass_2 <= c_UNDEFINED;
                                s_pass_3 <= c_UNDEFINED;
                                s_pass_4 <= c_UNDEFINED;
                                s_state_pass <= POS1;
                            else 
                                s_pass_4 <= number_i;
                                s_state_pass <= ENT;                                    -- but state will be changed to ENT
                            end if;
                            
                         when ENT =>                                                    -- state ENT
                            if (number_i = c_CANCEL)then                                -- if is pressed CANCEL 
                                s_pass_1 <= c_UNDEFINED;                                -- then first position will be undefined
                                s_pass_2 <= c_UNDEFINED;                                -- second
                                s_pass_3 <= c_UNDEFINED;                                -- third
                                s_pass_4 <= c_UNDEFINED;                                -- forth
                                s_state_pass <= POS1;                                   -- and whole password
                            elsif (number_i = c_ENTER)then                              -- if is pressed ENTER
                                s_state_pass <= POS1;                                   -- state will change to POS1
                                s_pass <= s_pass_1 & s_pass_2 & s_pass_3 & s_pass_4 ;   -- pass_1, pass_2, pass_3 nad pass_4 will be merged
                                s_pass_1 <= c_UNDEFINED; -- abo nejaky znak iny         -- then all password position will be undefined
                                s_pass_2 <= c_UNDEFINED;
                                s_pass_3 <= c_UNDEFINED;
                                s_pass_4 <= c_UNDEFINED;
                            else
                                s_state_pass <= ENT;                                    -- if we dont press enter or cancel then we are again in ENT
                            end if;
                         when others =>
                            s_state_pass <= POS1;                                       -- else state is again pos1
                    end case;
              
                end if;
                   
            end if;
    end if;    
    end process p_keypad_watcher;
    

    p_result_controler : process(clk, reset)                               -- proces for result
    begin
    
    if reset = '1' then
        s_state <= CLOSE;    
        locker_o <= '0';
        rgb_o <= c_RED;
        s_alarm <= '0';
        
    else
    
        if rising_edge(clk) then
                     
                case s_state is
                                            
                    when CLOSE =>                                                           -- state close
                                                                                          
                        if ((s_pass = c_MASTER_pass) OR (s_pass = c_SLAVE_pass))then        -- if password is rigth (1111 or 2222)
                            s_state <= OPENED; -- mozna led                                 -- then state is changed to opened
                        else                                                                
                            s_state <= CLOSE;  -- mozna led                                 -- else
                            locker_o <= '0';                                                -- door is locked
                            rgb_o <= c_RED;                                                 -- and color of diode is red
                        end if;
                    
                    when OPENED =>                                          -- state opened

                        if (s_cnt < c_DELAY_10SEC) then                     -- if the time is less than 10s 
                            s_cnt <= s_cnt + 1;                             
                            locker_o <= '1';                                -- then door will be opened
                            rgb_o <= c_GREEN;                               -- and diode is green
                        else
                            s_state <= WAITH;                               -- if is time more than 10s
                            locker_o <= '0';                                -- door will be closed
                            s_cnt   <= c_ZERO;                              -- and time is reset (0)
                        end if;
                    
                    when WAITH =>                                           -- state waith
                    
                        if (s_cnt < c_DELAY_10SEC) then                     -- if the time is less than 10s
                            s_cnt <= s_cnt + 1;
                            rgb_o <= c_YELOW;                               -- then color of diode will be yellow
                        elsif (door_i = '1') then                           -- if the door will be closed 
                            s_state <= CLOSE;                               -- then we go to state close
                            s_reset_pass <= '1';                            -- password is reseted
                            s_cnt   <= c_ZERO;                              -- and time will be reset too
                        else
                            s_state <= AFTERTIME;                           -- it the time is more than 10s then we go to state AFTERTIME
                            s_cnt   <= c_ZERO;                              -- time is 0
           
                        end if;
                    
                    when AFTERTIME =>                                       -- state aftertime
                        if (s_pass = c_MASTER_pass) then                    -- if was password 1111 (master password)                                                              
                            s_state <= MASTER;                              -- then state is changed to MASTER
                            s_reset_pass <= '1';                            -- and password is reseted
                        else                                                      
                        s_reset_pass <= '1';                                -- else password is reseted
                        s_state <= ALARM;                                   -- and state is changed to ALARM
                        end if;
                        
                    when ALARM =>                                           -- state alarm
                        s_alarm <= '1';                                     -- if the alarm is on
                        s_state <= CLOSE;                                   -- then we go to state CLOSE    
                                         
                    when MASTER =>                                          -- state master
                        if (door_i = '1') then                              -- if door is closed 
                            s_state <= CLOSE;                               -- then we go to state CLOSE
                        else    
                            s_state <= MASTER;                              -- if the door is open 
                            rgb_o <= c_GREEN;                               -- then we stay in state MASTER and diode is green
                        end if;
                    when others =>
                        s_state <= CLOSE;                                   -- ielse state is close

                end case;
              end if;
          
            if falling_edge(clk) then
            
            s_reset_pass <= '0';
            
            if (s_alarm = '1') then                         -- alarm is on
                if (s_pass = c_MASTER_pass)then             -- if the password was master password 
                    s_alarm <= '0';                         -- then alarm is off
                    s_reset_pass <= '1';                    -- and password is reseted
                     s_state <= CLOSE;                    
                else 
                    s_alarm <='1';                          -- else alarm is on
                end if; 
            end if; -- Alarm
        end if; -- Falling edge
    end if;
    end process p_result_controler;                   
                                        
    alarm_o <= s_alarm ;                -- signal shift from architecture to entity (alarm)
    
    data0_o <= s_pass_1;                -- signal shift from architecture to entity (all parts of password)
    data1_o <= s_pass_2;
    data2_o <= s_pass_3;
    data3_o <= s_pass_4;
    
end Behavioral;
