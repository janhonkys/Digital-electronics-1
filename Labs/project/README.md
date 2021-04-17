# Terminál pro odemčení/zamčení dveří pomocí 4místného PIN kódu



## Členové týmu
Adam Hora, Daniel Haluška, Marek Halaš, Jan Honkyš


## Cíle projektu
Cílem projektu je vytvořit terminál pro odemčení/zamčení dveří pomocí 4místného PIN kódu, s použitím 4x3 tlačítek, 4 sedmisegmentových displejů, relé pro ovládání zámku dveří.


### Návrh vizualizace řešení
![Screenshot](/Labs/project/Images/doorschema1.jpg)
### Stavový diagram
![Screenshot](/Labs/project/Images/diagram.jpg)
## Popis hardwaru
### Základní deska Arty A7: Artix-7 FPGA
Parametry: 4 přepínače, 4 tlačítka, 1 tlačítko reset, 4 LEDs, 4 RGB LEDs

## Popis VHDL modulů a simulací
### Klávesnice
#### Převodní tabulka vstupů na výstup
| Hex | Vstup | hor_1 | hor_2 | hor_3 | hor_4 | ver_1 | ver_2 | ver_3 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 0 | 0 | 0 | 1 | 0 | 1 | 0 |
| 1 | 0001 | 1 | 0 | 1 | 0 | 1 | 0 | 0 |
| 2 | 0010 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 0011 | 0 | 0 | 1 | 0 | 0 | 0 | 1 |
| 4 | 0100 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 5 | 0101 | 0 | 1 | 0 | 0 | 0 | 1 | 0 |
| 6 | 0110 | 0 | 1 | 0 | 0 | 0 | 0 | 1 |
| 7 | 0111 | 1 | 0 | 0 | 0 | 1 | 0 | 0 |
| 8 | 1000 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| 9 | 1001 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |
| enter | 1010 | 0 | 0 | 0 | 1 | 1 | 0 | 0 |
| cancel | 1011 | 0 | 0 | 0 | 1 | 0 | 0 | 1 |

#### Architektura
```vhdl
architecture Behavioral of keypad_4x3 is

     signal s_number      : std_logic_vector(4 - 1 downto 0);
     constant number_0 : std_logic_vector(4 - 1 downto 0) := b"0000";
     constant number_1 : std_logic_vector(4 - 1 downto 0) := b"0001";
     constant number_2 : std_logic_vector(4 - 1 downto 0) := b"0010";
     constant number_3 : std_logic_vector(4 - 1 downto 0) := b"0011";
     constant number_4 : std_logic_vector(4 - 1 downto 0) := b"0100";
     constant number_5 : std_logic_vector(4 - 1 downto 0) := b"0101";
     constant number_6 : std_logic_vector(4 - 1 downto 0) := b"0110";
     constant number_7 : std_logic_vector(4 - 1 downto 0) := b"0111";
     constant number_8 : std_logic_vector(4 - 1 downto 0) := b"1000";
     constant number_9 : std_logic_vector(4 - 1 downto 0) := b"1001";
     constant ENTER : std_logic_vector(4 - 1 downto 0) := b"1010";
     constant CANCEL : std_logic_vector(4 - 1 downto 0) := b"1011";
     constant UNDEFINED : std_logic_vector(4 - 1 downto 0) := b"1111";     

begin

p_output_keypad : process(clk)
    begin
        
        if rising_edge(clk) then
            
            number_o <= UNDEFINED; 
            if(hor_4 = '1' AND ver_2 = '1')then
                s_number <= number_0;
            elsif(hor_3 = '1' AND ver_1 = '1')then
                s_number <= number_1;
            elsif(hor_3 = '1' AND ver_2 = '1')then
                s_number <= number_2;
            elsif(hor_3 = '1' AND ver_3 = '1')then
                s_number <= number_3;
            elsif(hor_2 = '1' AND ver_1 = '1')then
                s_number <= number_4;
            elsif(hor_2 = '1' AND ver_2 = '1')then
                s_number <= number_5;
            elsif(hor_2 = '1' AND ver_3 = '1')then
                s_number <= number_6;
            elsif(hor_1 = '1' AND ver_1 = '1')then
                s_number <= number_7;
            elsif(hor_1 = '1' AND ver_2 = '1')then
                s_number <= number_8;
            elsif(hor_1 = '1' AND ver_3 = '1')then
                s_number <= number_9;
            elsif(hor_4 = '1' AND ver_1 = '1')then
                s_number <= ENTER;
            elsif(hor_4 = '1' AND ver_3 = '1')then
                s_number <= CANCEL;
            elsif(hor_1 = '0' AND hor_2 = '0' AND hor_3 = '0' AND hor_4 = '0' AND ver_1 = '0' AND ver_2 = '0' AND ver_3 = '0')then
                number_o <= s_number;
                s_number <= UNDEFINED;
                 
            end if;               
        end if; -- Synchronous reset
    end process p_output_keypad;
end Behavioral;
```

### Dekodér na 7mi segmentový displej
Slouží k převodu vstupního 4 bitového signálu na výstupní 7mi bitový signál, který je zobrazen na displeji.  
#### Převodní tabulka dekodéru na 7mi segmentový displej
| Hex | Vstup | A | B | C | D | E | F | G |
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
                seg_o <= "0001111";     -- 7
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
                seg_o <= "1111111";     -- NOTHING
        end case;
    end process p_7seg_decoder;
  
end architecture Behavioral;

```


## Popis TOP modulu a simulace
### Architektura TOP modulu
```vhdl
architecture Behavioral of top is
    -- No internal signals
    
    signal   s_number  : std_logic_vector(4 - 1 downto 0);
    
    signal   s_data0  : std_logic_vector(4 - 1 downto 0);
    signal   s_data1  : std_logic_vector(4 - 1 downto 0);
    signal   s_data2  : std_logic_vector(4 - 1 downto 0);
    signal   s_data3  : std_logic_vector(4 - 1 downto 0);
    
    
begin

    --------------------------------------------------------------------
    -- Instance (copy) of driver_7seg_4digits entity
    
    uut_keypad_4x3 : entity work.keypad_4x3
        port map(
            clk     => CLK100MHZ,
            hor_1   => ja(0),
            hor_2   => ja(1),
            hor_3   => ja(2),
            hor_4   => ja(3),
            ver_1   => ja(4),
            ver_2   => ja(5),
            ver_3   => ja(6),
            number_o => s_number
        );
        
     uut_controler : entity work.controler
        port map(
            clk     => CLK100MHZ,
            reset   => btn(0),
            number_i => s_number,
            door_i   => ja(7),
            alarm_o   => jc(7),
            locker_o  => jc(6),
            data0_o => s_data0,
            data1_o => s_data1,
            data2_o => s_data2,
            data3_o => s_data3
    );
    
    driver_seg_4 : entity work.driver_7seg_4digits
        port map(
            clk        => CLK100MHZ,
            reset      => btn(0),
           
            data0_i => s_data0,
            data1_i => s_data1,
            data2_i => s_data2,
            data3_i => s_data3,
            
            
            seg_o(6) => jb(6),
            seg_o(5) => jb(5),
            seg_o(4) => jb(4),
            seg_o(3) => jb(3),
            seg_o(2) => jb(2),
            seg_o(1) => jb(1),
            seg_o(0) => jb(0)  
     );

end architecture Behavioral;
```
### Schéma top modulu
![Screenshot](/Labs/project/Images/top.jpg)
## Video

## Reference
https://github.com/shahjui2000/Push-Button-Door-VHDL-

https://www.kth.se/social/files/5458faeef276544021bdf437/codelockVHDL_eng.pdf


