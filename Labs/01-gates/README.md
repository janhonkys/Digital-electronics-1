## Labs 1

https://github.com/janhonkys/Digital-electronics-1
#### 1. De Morgan laws sim
https://www.edaplayground.com/x/8fsS
```vhdl
architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o <= (not (not (not b_i and a_i) and not(not b_i and not c_i))); 
    fnor_o <= (not (b_i or not a_i) or not (c_i or b_i));
end architecture dataflow;

```
### Screenshot

![Screenshot](/Labs/01-gates/Images/1a.png)


Tabulka
| **c** | **b** |**a** | **f(c,b,a)** | **f(c,b,a)nand** | **f(c,b,a)nor** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 1 | 1 | 1 |
| 0 | 1 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 0 | 0 | 0 |
| 1 | 1 | 0 | 1 | 1 | 1 |
| 1 | 1 | 1 | 0 | 0 | 0 |

#### 2. Verification of Distributive laws
https://www.edaplayground.com/x/Aqyz


```vhdl
architecture dataflow of gates is
begin
    --f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    --fnand_o <= (not (not (not b_i and a_i) and not(not b_i and not c_i)));
    --fnor_o <= (not (b_i or not a_i) or not (c_i or b_i));
    f1_o <= ((a_i and b_i)or(a_i and c_i));
    f2_o <= (a_i and (b_i or c_i));
    f3_o <= ((a_i or b_i) and (a_i or c_i));
    f4_o <= (a_i or (b_i and c_i));
end architecture dataflow;
```
### Screenshot
![Screenshot](/Labs/01-gates/Images/2a.png)
