## Labs 2


### 1. Figure or table with connection of 16 slide switches and 16 LEDs on Nexys A7 board.
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
