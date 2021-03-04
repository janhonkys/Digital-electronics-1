----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2021 19:26:30
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port 
    ( 
        SW : in STD_LOGIC_VECTOR (4 - 1 downto 0);
        CA : out STD_LOGIC;
        CB : out STD_LOGIC;
        CC : out STD_LOGIC;
        CD : out STD_LOGIC;
        CF : out STD_LOGIC;
        CG : out STD_LOGIC;
        CA : out STD_LOGIC;
        CA : out STD_LOGIC;
        LED : out STD_LOGIC_VECTOR (8 - 1 downto 0); 
        AN : out STD_LOGIC_VECTOR (8 - 1 downto 0)
    );
end top;

architecture Behavioral of top is

begin

-- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => SW, 
            seg_o(6) => CA, --6 vodiè pøiøadí na CA, 6 MSB 
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );
        
    --Connect one common anode to 3,3V    
    AN <= b"1111_0111"; --binární hodnota
    
    -- Display input value on LEDs
    LED(3 downto 0) <= SW;  -- spodní 4 vystupy LED
    LED(5) <= '1' when (SW > "1000") else '0';
    LED(6) <= '1' when (SW = "0001");
    LED(6) <= '1' when (SW = "0011");
    LED(6) <= '1' when (SW = "0101");
    LED(6) <= '1' when (SW = "0111");
    LED(6) <= '1' when (SW = "1001");
    LED(6) <= '1' when (SW = "1011");
    LED(6) <= '1' when (SW = "1101");
    LED(6) <= '1' when (SW = "1111") else '0';
    LED(7) <= '1' when (SW = "0001");
    LED(7) <= '1' when (SW = "0010");
    LED(7) <= '1' when (SW = "0100");
    LED(7) <= '1' when (SW = "1000");
    
end Behavioral;
