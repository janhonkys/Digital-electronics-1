## Labs 7

https://github.com/janhonkys/Digital-electronics-1

### 1. Preparation tasks
![Screenshot](/Labs/07-ffs/Images/rov.jpg)


<!--
\begin{align*}
    q_{n+1}^D = &~ d &\\
    q_{n+1}^{JK} = &~ j\cdot \overline{q_n}\ +\overline{k}\cdot q_n &\\
    q_{n+1}^T =&~ t\cdot \overline{q_n}\ +\overline{t}\cdot q_n &\\
\end{align*}-->

   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | Sampled and stored |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 | Sampled and stored |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | Sampled and stored |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 | Sampled and stored |

   | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 | 0 | Reset |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 | 0 | Reset |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 0 | 1 | Set |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | 1 | Set |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 | 1 | Toggle (=invert) |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 | 0 | Toggle (=invert) |

   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | Toggle (=invert) |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 | Toggle (=invert) |




### 2. D latch

#### VHDL code listing of the process
```vhdl
 p_d_latch : process (d, arst, en)
    begin
        if (arst = '1') then
            q     <= '0';
            q_bar <= '1';
        elsif (en = '1') then
            q <= d;
            q_bar <= not d;
        end if;
    end process p_d_latch;
```

#### Listing of VHDL reset and stimulus processes from the testbench 
```vhdl
 p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 53ns;
        
        --reset activated
        s_arst <= '1';
        wait for 50ns;
        
        --reset deactivated
        s_arst <= '0';
        
        wait for 80ns;
        s_arst <= '1';
        
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin 
        report "Stimulus process started" severity note;
        s_en <= '0';
        s_d  <= '0';
        
        --d sequence 
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        
        assert ((s_arst = '1') and (s_en = '0') and (s_q = '0') and (s_q_bar = '1'))
        report "Test failed for reset high, en low when s_d = '0'" severity error;
        
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        --d sequence 
        
        s_en <= '1';
        
          --d sequence 
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_en <= '0';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        --d sequence
    
      
    
        --d sequence 
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        --d sequence
        
          s_en <= '1';
    
        --d sequence 
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        --d sequence
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

#### Screenshot with simulated time waveforms

![Screenshot](/Labs/07-ffs/Images/d_latch.jpg)

### 3. Flip-flops
#### VHDL code listing of the processes 
#### p_d_ff_arst
```vhdl
p_d_ff_arst : process (clk, arst)   --process se spustí při každé změně clk(vzestupné a sestupné hraně) a při změně arst
    begin
        if (arst = '1') then        --sestupná hrana a arst v 1
            q     <= '0';
            q_bar <= '1';
            
        elsif rising_edge(clk) then     --když bude arst v 0, a když je vzestupná hrana 
            q <= d;
            q_bar <= not d;
        end if;
    end process p_d_ff_arst;
```
#### p_d_ff_rst
```vhdl
p_d_ff_rst : process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                q <= '0';
                q_bar <= '1';
            else
                q <= d;
                q_bar <= not d;
            end if;
        end if;
    end process p_d_ff_rst;
```
#### p_jk_ff_rst
```vhdl
p_jk_ff_rst : process (clk)   --process se spustí při každé změně clk(vzestupné a sestupné hraně) a při změně arst
    begin
        if rising_edge(clk) then     --když bude arst v 0, a když je vzestupná hrana 
            if(rst = '1') then
                s_q <= '0';
            else
                if (j = '0' and k = '0') then
                    s_q <= s_q;
                    
                elsif (j = '0' and k = '1') then
                    s_q <= '0';
                    
                elsif (j = '1' and k = '0') then
                    s_q <= '1';
                    
                elsif (j = '1' and k = '1') then
                    s_q <= not s_q;
                    
                end if;
            
            end if;         
        end if;
    end process p_jk_ff_rst;
```

#### p_t_ff_rst
```vhdl
p_t_ff_rst : process (clk)
begin
    if rising_edge(clk) then
        if (rst = '1') then
            s_q <= '0';
        elsif (t = '1') then
            s_q <= not s_q;
        end if;
    end if;

end process p_t_ff_rst;
```

#### Listing of VHDL clock, reset and stimulus processes from the testbench files with syntax highlighting and asserts
#### p_d_ff_arst
```vhdl
--clock generation process-------------------------
     p_clk_gen : process
     begin
        while now < 750 ns loop
            s_clk_100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
       end loop;
       wait; 
    end process p_clk_gen;

--------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------

     p_reset_gen : process
        begin
            s_arst <= '0';
            wait for 58 ns;
            
            -- Reset activated
            s_arst <= '1';
            wait for 15 ns;
    
            --Reset deactivated
            s_arst <= '0';
            
            --wait for 17 ns;
               
            wait;
     end process p_reset_gen;

--------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
          --d sequence 
        wait for 13ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        --d sequence
        
        assert ((s_arst = '0') and (s_q = '1') and (s_q_bar = '0'))
        report "Test failed for reset low, after clk rising when s_d = '1'" severity error;
        
       
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

```
#### p_d_ff_rst
```vhdl
--clock generation process-------------------------
     p_clk_gen : process
     begin
        while now < 750 ns loop
            s_clk_100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
       end loop;
       wait; 
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------

     p_reset_gen : process
        begin
            s_rst <= '0';
            wait for 58 ns;
            
            -- Reset activated
            s_rst <= '1';
            wait for 15 ns;
    
            --Reset deactivated
            s_rst <= '0';
            
            --wait for 17 ns;
               
            wait;
     end process p_reset_gen;

--------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
          --d sequence 
        wait for 13ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        --d sequence
        assert ((s_rst = '1') and (s_q = '1') and (s_q_bar = '0'))
	    report "Test failed for reset high, before clk rising when s_d = '1'" severity error;
	
        
       
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```
#### p_jk_ff_rst
```vhdl
p_clk_gen : process
     begin
        while now < 750 ns loop
            s_clk_100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
       end loop;
       wait; 
    end process p_clk_gen;

 p_reset_gen : process
        begin
            s_rst <= '0';
            wait for 58 ns;
            
            -- Reset activated
            s_rst <= '1';
            wait for 15 ns;
    
            --Reset deactivated
            s_rst <= '0';
            
            --wait for 17 ns;
               
            wait;
     end process p_reset_gen;
     
 
 p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
          --d sequence 
        wait for 13ns;
        s_j  <= '0';
        s_k  <= '0';
        wait for 20ns;
        s_j  <= '0';
        s_k  <= '1';
        wait for 20ns;
        s_j  <= '1';
        s_k  <= '0';
        wait for 20ns;
        s_j  <= '1';
        s_k  <= '1';
        assert ((s_rst = '0') and (s_j = '0') and (s_k = '0') and (s_q = '0') and (s_q_bar = '1'))
	    report "Test 'no change' failed for reset low, after clk rising when s_j = '0' and s_k = '0'" severity error;
        
    
        wait for 10ns;
        s_j  <= '1';
        s_k  <= '1';
        wait for 10ns;
        s_j  <= '1';
        s_k  <= '1';
        wait for 10ns;
        --d sequence
               
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

#### p_t_ff_rst
```vhdl
  p_clk_gen : process
     begin
        while now < 750 ns loop
            s_clk_100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
       end loop;
       wait; 
    end process p_clk_gen;

--------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------

     p_reset_gen : process
        begin
            s_rst <= '0';
            wait for 58 ns;
            
            -- Reset activated
            s_rst <= '1';
            wait for 15 ns;
    
            --Reset deactivated
            s_rst <= '0';
            
            --wait for 17 ns;
               
            wait;
     end process p_reset_gen;

p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        assert ((s_rst = '0') and (s_t = '0') and (s_q = '0') and (s_q_bar = '1'))
	    report "Test 'no change' failed for reset low, after clk rising when s_t = '0'" severity error;
          --d sequence 
        wait for 13ns;
        s_t  <= '0';
        s_q  <= '0';
        wait for 20ns;
        s_t  <= '0';
        s_q  <= '1';
        wait for 20ns;
        s_t  <= '1';
        s_q  <= '0';
        wait for 20ns;
        s_t  <= '1';
        s_q  <= '1';
        
        wait for 10ns;
        s_t  <= '1';
        s_q  <= '1';
        wait for 10ns;
        s_t  <= '1';
        s_q  <= '1';
        wait for 10ns;
        --d sequence
               
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

#### Screenshot with simulated time waveforms
#### p_d_ff_arst
![Screenshot](/Labs/07-ffs/Images/d_ff_arst.jpg)
#### p_d_ff_rst
![Screenshot](/Labs/07-ffs/Images/d_ff_rst.jpg)
#### p_jk_ff_rst
![Screenshot](/Labs/07-ffs/Images/jk_ff_rst.jpg)
#### p_t_ff_rst
![Screenshot](/Labs/07-ffs/Images/t_ff_rst.jpg)

### 4. Shift register
![Screenshot](/Labs/07-ffs/Images/schema2.jpg)


