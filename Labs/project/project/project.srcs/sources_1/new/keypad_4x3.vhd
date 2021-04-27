----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2021 19:35:01
-- Design Name: 
-- Module Name: keypad_4x3 - Behavioral
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

entity keypad_4x3 is
    port(
        clk   : in  std_logic;                              -- input for clock
        hor_1 : in  std_logic;                              -- input for first row
        hor_2 : in  std_logic;                              -- input for second row
        hor_3 : in  std_logic;                              -- input for third row
        hor_4 : in  std_logic;                              -- input for fourth row
        ver_1 : in  std_logic;                              -- input for first cloumn
        ver_2 : in  std_logic;                              -- input for second column
        ver_3 : in  std_logic;                              -- input for third column
                
        number_o : out std_logic_vector(4 - 1 downto 0)     -- output for number
         
      );  
end keypad_4x3;

architecture Behavioral of keypad_4x3 is

     signal s_number    : std_logic_vector(4 - 1 downto 0);
     
     constant number_0  : std_logic_vector(4 - 1 downto 0) := b"0000";      -- setting constants for numbel 0-9 in binary
     constant number_1  : std_logic_vector(4 - 1 downto 0) := b"0001";
     constant number_2  : std_logic_vector(4 - 1 downto 0) := b"0010";
     constant number_3  : std_logic_vector(4 - 1 downto 0) := b"0011";
     constant number_4  : std_logic_vector(4 - 1 downto 0) := b"0100";
     constant number_5  : std_logic_vector(4 - 1 downto 0) := b"0101";
     constant number_6  : std_logic_vector(4 - 1 downto 0) := b"0110";
     constant number_7  : std_logic_vector(4 - 1 downto 0) := b"0111";
     constant number_8  : std_logic_vector(4 - 1 downto 0) := b"1000";
     constant number_9  : std_logic_vector(4 - 1 downto 0) := b"1001";
     constant ENTER     : std_logic_vector(4 - 1 downto 0) := b"1010";      -- for enter
     constant CANCEL    : std_logic_vector(4 - 1 downto 0) := b"1011";      -- for cancel
     constant UNDEFINED : std_logic_vector(4 - 1 downto 0) := b"1111";      -- and for undefined   

begin


p_output_keypad : process(clk)
    begin
        
        if rising_edge(clk) then                        -- defining numbers based on inputs
            
            number_o <= UNDEFINED;          
                               
            if(hor_1 = '0' AND hor_2 = '0' AND hor_3 = '0' AND hor_4 = '1' AND ver_1 = '0' AND ver_2 = '1' AND ver_3 = '0')then         -- fourth row and second column for value 0
                s_number <= number_0;
            elsif(hor_1 = '0' AND hor_2 = '0' AND hor_3 = '1' AND hor_4 = '0' AND ver_1 = '1' AND ver_2 = '0' AND ver_3 = '0')then      -- third row and first column for value 1
                s_number <= number_1;
            elsif(hor_1 = '0' AND hor_2 = '0' AND hor_3 = '1' AND hor_4 = '0' AND ver_1 = '0' AND ver_2 = '1' AND ver_3 = '0')then      -- third row and second column for value 2
                s_number <= number_2;
            elsif(hor_1 = '0' AND hor_2 = '0' AND hor_3 = '1' AND hor_4 = '0' AND ver_1 = '0' AND ver_2 = '0' AND ver_3 = '1')then      -- third row and third column for value 3
                s_number <= number_3;
            elsif(hor_1 = '0' AND hor_2 = '1' AND hor_3 = '0' AND hor_4 = '0' AND ver_1 = '1' AND ver_2 = '0' AND ver_3 = '0')then      -- second row and first column for value 4
                s_number <= number_4;      
            elsif(hor_1 = '0' AND hor_2 = '1' AND hor_3 = '0' AND hor_4 = '0' AND ver_1 = '0' AND ver_2 = '1' AND ver_3 = '0')then      -- second row and second column for value 5
                s_number <= number_5;      
            elsif(hor_1 = '0' AND hor_2 = '1' AND hor_3 = '0' AND hor_4 = '0' AND ver_1 = '0' AND ver_2 = '0' AND ver_3 = '1')then      -- second row and third column for value 6
                s_number <= number_6;
            elsif(hor_1 = '1' AND hor_2 = '0' AND hor_3 = '0' AND hor_4 = '0' AND ver_1 = '1' AND ver_2 = '0' AND ver_3 = '0')then      -- first row and first column for value 7
                s_number <= number_7;
            elsif(hor_1 = '1' AND hor_2 = '0' AND hor_3 = '0' AND hor_4 = '0' AND ver_1 = '0' AND ver_2 = '1' AND ver_3 = '0')then      -- first row and second column for value 8
                s_number <= number_8;
            elsif(hor_1 = '1' AND hor_2 = '0' AND hor_3 = '0' AND hor_4 = '0' AND ver_1 = '0' AND ver_2 = '0' AND ver_3 = '1')then      -- first row and third column for value 9
                s_number <= number_9;
            elsif(hor_1 = '0' AND hor_2 = '0' AND hor_3 = '0' AND hor_4 = '1' AND ver_1 = '1' AND ver_2 = '0' AND ver_3 = '0')then      -- fourth row and first column for ENTER
                s_number <= ENTER;
            elsif(hor_1 = '0' AND hor_2 = '0' AND hor_3 = '0' AND hor_4 = '1' AND ver_1 = '0' AND ver_2 = '0' AND ver_3 = '1')then      -- fourth row and third column for CANCEL
                s_number <= CANCEL;
            elsif(hor_1 = '0' AND hor_2 = '0' AND hor_3 = '0' AND hor_4 = '0' AND ver_1 = '0' AND ver_2 = '0' AND ver_3 = '0')then      -- if we don't have inputs, then number is undefined
                number_o <= s_number;    -- 
                s_number <= UNDEFINED;  
            else                            -- if have been pressed 2 or more buttons in same time, then number is undefined
                number_o <= UNDEFINED;
            end if;
                 
            
        end if; -- Synchronous reset
        
    end process p_output_keypad;


end Behavioral;
