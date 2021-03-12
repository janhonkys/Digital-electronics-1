------------------------------------------------------------------------
--
-- N-bit Up/Down binary counter.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2019-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for n-bit counter
------------------------------------------------------------------------
entity cnt_up_down is
    generic(
        g_CNT_WIDTH : natural := 4      -- Number of bits for counter --cnt_width: ���ka �ita�e, po�et vodi��,
    );
    port(
        clk      : in  std_logic;       -- Main clock
        reset    : in  std_logic;       -- Synchronous reset
        en_i     : in  std_logic;       -- Enable input
        cnt_up_i : in  std_logic;       -- Direction of the counter
        cnt_o    : out std_logic_vector(g_CNT_WIDTH - 1 downto 0) -- 4-1 downto 0, ���ka cnt_o bude 4 bity
    );
end entity cnt_up_down;

------------------------------------------------------------------------
-- Architecture body for n-bit counter
------------------------------------------------------------------------
architecture behavioral of cnt_up_down is

    -- Local counter
    signal s_cnt_local : unsigned(g_CNT_WIDTH - 1 downto 0);    --vhdl neumo�nuje ��st z v�stupu, mus�me definovat nov� sign�l

begin
    --------------------------------------------------------------------
    -- p_cnt_up_down:
    -- Clocked process with synchronous reset which implements n-bit 
    -- up/down counter.
    --------------------------------------------------------------------
    p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then    --spou�t� se s n�stupnou hranou(rising_edge), kdyby sestupn� tak falling_edge
        
            if (reset = '1') then               -- Synchronous reset    --asynchronn� reset, radek 50 a 51 p�esunout nad if rising_edge a za clk 48 p�idat , reset
                s_cnt_local <= (others => '0'); -- Clear all bits   --reset v 1, vyma�eme ��ta�, '0' se pou�ije proto�e nev�me kolika bitov� je �ita�

            elsif (en_i = '1') then       -- Test if counter is enabled  --kdy� enable v 1, p�i�teme 1, kdy� v 0, ned�je se nic


                -- TEST COUNTER DIRECTION HERE


                s_cnt_local <= s_cnt_local + 1;


            end if;
        end if;
    end process p_cnt_up_down;

    -- Output must be retyped from "unsigned" to "std_logic_vector"
    cnt_o <= std_logic_vector(s_cnt_local);

end architecture behavioral;
