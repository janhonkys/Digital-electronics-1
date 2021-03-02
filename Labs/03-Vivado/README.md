## Labs 3

https://github.com/janhonkys/Digital-electronics-1

### 1. Figure or table with connection of 16 slide switches and 16 LEDs on Nexys A7 board.

| **LED** | **Connection** | **Switch** | **Connection** | 
| :-: | :-: | :-: | :-: |
| LED0 | H17 | SW0 | J15 |
| LED1 | K15 | SW1 | L16 |
| LED2 | J13 | SW2 | M13 |
| LED3 | N14 | SW3 | R15 |
| LED4 | R18 | SW4 | R17 |
| LED5 | V17 | SW5 | T18 |
| LED6 | U17 | SW6 | U18 |
| LED7 | U16 | SW7 | R13 |
| LED8 | V16 | SW8 | T8 |
| LED9 | T15 | SW9 | U8 |
| LED10 | U14 | SW10 | R16 |
| LED11 | T16 | SW11 | T13 |
| LED12 | V15 | SW12 | H6 |
| LED13 | V14 | SW13 | U12 |
| LED14 | V12 | SW14 | U11 |
| LED15 | V11 | SW15 | V10 |

### 2. Two-bit wide 4-to-1 multiplexer. Submit:
#### Architecture
```vhdl
architecture Behavioral of mux_2bit_4to1 is
begin
    f_o <= a_i when (sel_i = "00") else  --prirazovani vstupu na vystup funkce
           b_i when (sel_i = "01") else
           c_i when (sel_i = "10") else
           d_i;

    -- WRITE "GREATER" AND "EQUALS" ASSIGNMENTS HERE


end architecture Behavioral;

```
#### Stimulus
```vhdl
p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

        s_d <= "00"; s_c <= "00"; s_b <= "00"; s_a <= "00"; 
        s_sel <= "00"; 
        wait for 10 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "00"; 
        wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "11"; 
        s_sel <= "00"; 
        wait for 100 ns; 
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "01"; 
        wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "11"; s_a <= "00"; 
        s_sel <= "01"; 
        wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "11"; s_a <= "00"; 
        s_sel <= "10"; 
        wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "11"; s_a <= "00"; 
        s_sel <= "11"; 
        wait for 100 ns;
        -- WRITE OTHER TEST CASES HERE


        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

```
#### Screenshot

![Screenshot](/Labs/03-Vivado/Images/sig.png)
### 3. Vivado tutorial
#### Project creation
Open Vivado, Under "Quick Start", click "Create Project", Click "Next >", Type project name and select project location, then click "Next>", Click "Next >"

#### Adding source file
Click "Create File", make sure your file type is "VHDL" and type file name, it should same as project name, Click "OK", Click "Next >", Click "Next >", Click on "Boards" and select your board, for example "Nexys A7-50T", Click "Next >", Click "Finish", Click "OK" and "Yes"

#### Adding testbench file
Under "Sources", open folder "Simulation Sources", Right click on folder "sim_1" and select "Add Sources...", Click "Next >", Click "Create File", make sure your file type is "VHDL" and type file name that begins with "tb_" and then your project name, Click "OK", Click "Finish", Click "OK" and "Yes"

#### Running simulation
After you add your source code to previously created files, click "Run Simulation" in the left column and then select "Run Behavioral Simulation", Wait for a moment, then your simulation graphs are opened in the new window, you can extend it by clicking the "Maximize" button in right corner of this window
