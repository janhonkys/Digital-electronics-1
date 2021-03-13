## Labs 5

https://github.com/janhonkys/Digital-electronics-1

### 1. Preparation tasks
#### Tables with connection of bottoms on Nexys A7 board
When the button is off "0", 0 V is on the input pin. When on "1" 3.3 V is on the input pin. 

| **Component** | **Pin** |
| :-: | :-: |
| BTNC | N17 |
| BTND | P18 |
| BTNU | M18 |
| BTNR | M17 |
| BTNL | P17 |

### Table with calculated values of periods for frequency 100 MHz

| **Time interval** | **Number of clk periods** | **Number of clk periods in hex** | **Number of clk periods in binary** |
| :-: | :-: | :-: | :-: |
| 2&nbsp;ms | 200 000 | `x"3_0d40"` | `b"0011_0000_1101_0100_0000"` |
| 4&nbsp;ms | 400 000 | `x"6_1a80"` | `b"0010_1111_1010_1111_0000_1000_0000"` |
| 10&nbsp;ms | 1 000 000 | `x"f_4240"` | `b"1111_0100_0010_0100_0000"` |
| 250&nbsp;ms | 25 000 000 | `x"17d_7840"` | `b"0001_0111_1101_0111_1000_0100_0000"` |
| 500&nbsp;ms | 50 000 000 | `x"2fa_f080"` | `b"0010_1111_1010_1111_0000_1000_0000"` |
| 1&nbsp;sec | 100 000 000 | `x"5f5_e100"` | `b"0101_1111_0101_1110_0001_0000_0000"` |

### 2. Bidirectional counter




#### VHDL p_cnt_up_down
```vhdl
 p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then    --spouští se s nástupnou hranou(rising_edge), kdyby sestupná tak falling_edge
        
            if (reset = '1') then               -- Synchronous reset    --asynchronní reset, radek 50 a 51 přesunout nad if rising_edge a za clk 48 přidat , reset
                s_cnt_local <= (others => '0'); -- Clear all bits   --reset v 1, vymažeme čítač, '0' se použije protože nevíme kolika bitový je čitač

            elsif (en_i = '1') then       -- Test if counter is enabled  --když enable v 1, přičteme 1, když v 0, neděje se nic


                -- TEST COUNTER DIRECTION HERE


                s_cnt_local <= s_cnt_local + 1;


            end if;
        end if;
    end process p_cnt_up_down;
 
```
#### VHDL reset processes 
```vhdl 
p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 12 ns;     --reset v 0, po 12 ns dáme reset do 1, s další nástupnou hranou se s_cn dá do 0
        
        -- Reset activated
        s_reset <= '1';
        wait for 73 ns;

        s_reset <= '0';
        wait for 100 ns;
        
        s_reset <= '1';
        wait for 43 ns;
        
        s_reset <= '0';
        wait;
    end process p_reset_gen;
``` 
#### VHDL stimulus processes 
```vhdl 
p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        -- Enable counting
        s_en     <= '1';
        
        -- Change counter direction
        s_cnt_up <= '1';
        wait for 380 ns;
        s_cnt_up <= '0';
        wait for 220 ns;

        -- Disable counting
        s_en     <= '0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
``` 
#### Screenshot

![Screenshot](/Labs/05-counter/Images/2sc.png)
### 3. Top level
#### VHDL 
```vhdl 
 -- Instance (copy) of clock_enable entity
    clk_en0 : entity work.clock_enable
        generic map
        (
            --- WRITE YOUR CODE HERE
            g_MAX => 100000000
        )
        port map
        (
            --- WRITE YOUR CODE HERE
            clk     => CLK100MHZ,
            reset   => BTNC,
            ce_o    => s_en
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    bin_cnt0 : entity work.cnt_up_down
        generic map
        (
            --- WRITE YOUR CODE HERE
            g_CNT_WIDTH => 4        --stejná šířka jako signál s_cnt
        )
        port map(
            --- WRITE YOUR CODE HERE
            clk         => CLK100MHZ,
            reset       => BTNC,
            en_i        => s_en,
            cnt_up_i    => SW(0),
            cnt_o       => s_cnt
            
        );

    -- Display input value on LEDs
    LED(3 downto 0) <= s_cnt;

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_1110";
``` 

#### Screenshot

![Screenshot](/Labs/05-counter/Images/schema.jpg)
