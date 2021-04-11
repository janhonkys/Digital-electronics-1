## Terminál pro odemčení/zamčení dveří pomocí 4místného PIN kódu



### Členové týmu
Adam Hora, Daniel Haluška, Marek Halaš, Jan Honkyš


### Cíle projektu
Cílem projektu je vytvořit terminál pro odemčení/zamčení dveří pomocí 4místného PIN kódu, s použitím 4x3 tlačítek, 4 sedmisegmentového displeje, relé pro ovládání zámku dveří.


#### Vizualizace řešení
![Screenshot](/Labs/project/Images/doorschema1.jpg)

### Popis hardwaru
#### Základní deska Arty A7: Artix-7 FPGA
Parametry: 4 přepínače, 4 tlačítka, 1 tlačítko reset, 4 LEDs, 4 RGB LEDs

### Popis VHDL modulů a simulací

#### Seven-segment display decoder
#### Architecture
```vhdl
architecture Behavioral of hex_7seg is
begin
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


### Popis TOP modulu a simulace
#### Listing of VHDL code of sequential process p_traffic_fsm with syntax highlighting,
```vhdl
 
```
#### Listing of VHDL code of combinatorial process p_output_fsm with syntax highlighting,
```vhdl 


``` 
### Video

### Reference
https://github.com/shahjui2000/Push-Button-Door-VHDL-
https://www.kth.se/social/files/5458faeef276544021bdf437/codelockVHDL_eng.pdf


