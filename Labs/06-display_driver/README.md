## Labs 5

https://github.com/janhonkys/Digital-electronics-1

### 1. Preparation tasks
####  Timing diagram figure for displaying value 3.142

![Screenshot](/Labs/06-display_driver/Images/timing.png)

### 2. Display driver




#### VHDL p_cnt_up_down
```vhdl
  
```
#### VHDL reset processes 
```vhdl 

``` 
#### VHDL stimulus processes 
```vhdl 

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

#### Schema

![Screenshot](/Labs/05-counter/Images/schema.jpg)
