## Labs 4

https://github.com/janhonkys/Digital-electronics-1

### 1. Preparation tasks
#### Tables with connection on Nexys A7 board
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

### Cathodes
LEDs light is ON, cathode is low, 0 V.




#### VHDL
```vhdl
 
```
#### Screenshot

![Screenshot](/Labs/04-segment/Images/led.png)
