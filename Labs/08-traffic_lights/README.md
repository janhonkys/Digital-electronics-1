## Labs 8

https://github.com/janhonkys/Digital-electronics-1

### 1. Preparation tasks


### Completed state table
| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **State** | A | A | B | C | C | D | A | B | C | D | B | B | B | C | D | B |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `1` | `0` |

### Connection of RGB LEDs on Nexys A7 board and completed table
![Screenshot](/Labs/08-traffic_lights/Images/zap.png)

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |


### 2. Display driver

#### Listing of VHDL code of sequential process p_traffic_fsm with syntax highlighting,
```vhdl
  p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits, resetování 

            elsif (s_en = '1') then     --když není reset v 1, zkontrolujeme, jestli je s_en v 1
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then --když je s_cnt menší, než čekání 1 sekundy
                            s_cnt <= s_cnt + 1; --zvedneme s_cnt o 1
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;  --vymazat čítač
                        end if;

                    when WEST_GO =>
                        if(s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt +1;
                        else
                            s_state <= WEST_WAIT;
                            s_cnt <= c_ZERO;
                        end if;

                        -- WRITE YOUR CODE HERE
                    when WEST_WAIT =>
                        if(s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= STOP2;
                            s_cnt <= c_ZERO;
                        end if;
                    
                    when STOP2 =>
                        if(s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SOUTH_GO;
                            s_cnt <= c_ZERO;
                        end if;
                    
                    when SOUTH_GO =>
                        if(s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SOUTH_WAIT;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when SOUTH_WAIT =>
                        if(s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= STOP1;
                            s_cnt <= c_ZERO;
                        end if;
                                 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;
```
#### Listing of VHDL code of combinatorial process p_output_fsm with syntax highlighting,
```vhdl 
p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= "100";   --red, RGB (100)
                west_o  <= "100";
                -- WRITE YOUR CODE HERE
            when WEST_GO =>
                south_o <= "100";   --red, RGB (100)
                west_o  <= "010";
            
            when WEST_WAIT =>
                south_o <= "100";   --red, RGB (100)
                west_o  <= "110";
                
            when STOP2 =>
                south_o <= "100";   --red, RGB (100)
                west_o  <= "100";
                
            when SOUTH_GO =>
                south_o <= "010";   --green
                west_o  <= "100";

            when SOUTH_WAIT =>
                south_o <= "110";   --yellow
                west_o  <= "100";   

            when others =>
                south_o <= "100";   --red
                west_o  <= "100";   --red
        end case;
    end process p_output_fsm;

``` 
#### Screenshot with simulated time waveforms

![Screenshot](/Labs/08-traffic_lights/Images/sig.jpg)

### 3. Smart controller
| **Next state<br />v Current state** | No cars <br />west = 0, east = 0 | Cars from west<br />west = 1, east = 0 | Cars from east<br />west = 0, east = 1 | Cars from both<br />west = 1, east = 1 |
| :-- | :-: | :-: | :-: | :-: |
| **`STOP1`**  | `WEST_GO` | `WEST_GO` | `SOUTH_GO` | `WEST_GO` |
| **`WEST_GO`** | `WEST_WAIT` | ``WEST_GO`` | `WEST_WAIT` | ``WEST_GO`` |
| **`WEST_WAIT`** | ``STOP2`` | `STOP2` | ``STOP2`` | ``STOP2`` |
| **`STOP2`**  | `SOUTH_GO` | `WEST_GO` | `SOUTH_GO` | ``SOUTH_GO`` |
| **`SOUTH_GO`** | `SOUTH_WAIT` | `SOUTH_WAIT` | `SOUTH_GO` | ```SOUTH_GO``` |
| **`SOUTH_WAIT`** | `STOP1` | `STOP1` | `STOP1` | ``STOP1`` |


