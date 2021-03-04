## Labs 4

https://github.com/janhonkys/Digital-electronics-1

### Preparation tasks

| Hex | Inputs | A | B | C | D | E | F | G |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0001 | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
| 2 | 0010 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 0011 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |
| 4 | 0100 | 1 | 0 | 0 | 1 | 1 | 0 | 0 |
| 5 | 0101 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 6 | 0110 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 7 | 0111 | 0 | 0 | 1 | 1 | 1 | 1 | 1 |
| 8 | 1000 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 9 | 1001 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
| A | 1010 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| B | 1011 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
| C | 1100 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |
| D | 1101 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| E | 1110 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 1 | 0 | 0 | 0 |

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
Click "Run Simulation" in the left column and then select "Run Behavioral Simulation".
