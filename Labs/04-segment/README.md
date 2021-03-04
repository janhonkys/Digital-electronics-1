## Labs 4

https://github.com/janhonkys/Digital-electronics-1

### 1. Preparation tasks

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

### 2. Seven-segment display decoder.
#### Architecture
```vhdl
architecture Behavioral of hex_7seg is

begin
 --------------------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display (Common Anode)
    -- decoder. Any time "hex_i" is changed, the process is "executed".
    -- Output pin seg_o(6) controls segment A, seg_o(5) segment B, etc.
    --       segment A
    --        | segment B
    --        |  | segment C
    --        |  |  |   ...   segment G
    --        +-+|+-+          |
    --          |||            |
    -- seg_o = "0000001"-------+
    --------------------------------------------------------------------
    p_7seg_decoder : process(hex_i)
    begin
        case hex_i is
            when "0000" =>
                seg_o <= "0000001";     -- 0
            when "0001" =>
                seg_o <= "1001111";     -- 1
            when "0010" =>
                seg_o <= "0010010";     -- 2
            when "0011" =>
                seg_o <= "0000110";     -- 3
            when "0100" =>
                seg_o <= "1001100";     -- 4
            when "0101" =>
                seg_o <= "0100100";     -- 5
            when "0110" =>
                seg_o <= "0100000";     -- 6
            when "0111" =>
                seg_o <= "0011111";     -- 7
            when "1000" =>
                seg_o <= "0000000";     -- 8
            when "1001" =>
                seg_o <= "0000100";     -- 9
            when "1010" =>
                seg_o <= "0001000";     -- A
            when "1011" =>
                seg_o <= "1100000";     -- B
            when "1100" =>
                seg_o <= "0110001";     -- C
            when "1101" =>
                seg_o <= "1000010";     -- D
            when "1110" =>
                seg_o <= "0110000";     -- E              
            when others =>
                seg_o <= "0111000";     -- F
        end case;
    end process p_7seg_decoder;


end Behavioral;

```
#### Stimulus
```vhdl
p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

        s_hex <= "0000"; wait for 50 ns;
        
        s_hex <= "0001"; wait for 50 ns;
        
        s_hex <= "0010"; wait for 50 ns;
        
        s_hex <= "0011"; wait for 50 ns;
        
        s_hex <= "0100"; wait for 50 ns;
        
        s_hex <= "0101"; wait for 50 ns;
        
        s_hex <= "0110"; wait for 50 ns;
        
        s_hex <= "0111"; wait for 50 ns;
        
        s_hex <= "1000"; wait for 50 ns;
        
        s_hex <= "1001"; wait for 50 ns;
        
        s_hex <= "1010"; wait for 50 ns;
        
        s_hex <= "1011"; wait for 50 ns;
        
        s_hex <= "1100"; wait for 50 ns;
        
        s_hex <= "1101"; wait for 50 ns;
        
        s_hex <= "1110"; wait for 50 ns;
        
        s_hex <= "1111"; wait for 50 ns;
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

```
#### Screenshot

![Screenshot](/Labs/04-segment/Images/graph.jpg)
### 3. Vivado tutorial
#### Project creation
Open Vivado, Under "Quick Start", click "Create Project", Click "Next >", Type project name and select project location, then click "Next>", Click "Next >"

#### Adding source file
Click "Create File", make sure your file type is "VHDL" and type file name, it should same as project name, Click "OK", Click "Next >", Click "Next >", Click on "Boards" and select your board, for example "Nexys A7-50T", Click "Next >", Click "Finish", Click "OK" and "Yes"

#### Adding testbench file
Under "Sources", open folder "Simulation Sources", Right click on folder "sim_1" and select "Add Sources...", Click "Next >", Click "Create File", make sure your file type is "VHDL" and type file name that begins with "tb_" and then your project name, Click "OK", Click "Finish", Click "OK" and "Yes"

#### Running simulation
Click "Run Simulation" in the left column and then select "Run Behavioral Simulation".
