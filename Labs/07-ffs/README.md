## Labs 7

https://github.com/janhonkys/Digital-electronics-1

### 1. Preparation tasks

<!--
\begin{align*}
    q_{n+1}^D = &~ d &\\
    q_{n+1}^{JK} = &~ j\cdot \overline{q_n}\ +\overline{k}\cdot q_n &\\
    q_{n+1}^T =&~ t\cdot \overline{q_n}\ +\overline{t}\cdot q_n &\\
\end{align*}-->

   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](images/eq_uparrow.png) | 0 | 0 | 0 | Sampled and stored |
   | ![rising](images/eq_uparrow.png) | 0 | 1 | 0 | Sampled and stored |
   | ![rising](images/eq_uparrow.png) | 1 | 0 | 1 | Sampled and stored |
   | ![rising](images/eq_uparrow.png) | 1 | 1 | 1 | Sampled and stored |

   | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](images/eq_uparrow.png) | 0 | 0 | 0 | 0 | No change |
   | ![rising](images/eq_uparrow.png) | 0 | 0 | 1 | 1 | No change |
   | ![rising](images/eq_uparrow.png) | 0 | 1 | 0 | 0 | Reset |
   | ![rising](images/eq_uparrow.png) | 0 | 1 | 1 | 0 | Reset |
   | ![rising](images/eq_uparrow.png) | 1 | 0 | 0 | 1 | Set |
   | ![rising](images/eq_uparrow.png) | 1 | 0 | 1 | 1 | Set |
   | ![rising](images/eq_uparrow.png) | 1 | 1 | 0 | 1 | Toggle (=invert) |
   | ![rising](images/eq_uparrow.png) | 1 | 1 | 1 | 0 | Toggle (=invert) |

   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](images/eq_uparrow.png) | 0 | 0 | 0 | No change |
   | ![rising](images/eq_uparrow.png) | 0 | 1 | 1 | No change |
   | ![rising](images/eq_uparrow.png) | 1 | 0 | 1 | Toggle (=invert) |
   | ![rising](images/eq_uparrow.png) | 1 | 1 | 0 | Toggle (=invert) |


![Screenshot](/Labs/06-display_driver/Images/timing.png)

### 2. 

#### Listing of VHDL code of the process p_mux with syntax highlighting.
```vhdl



```

#### Screenshot with simulated time waveforms

![Screenshot](/Labs/06-display_driver/Images/signals.png)

#### Screenshot with simulated time waveforms 2

![Screenshot](/Labs/06-display_driver/Images/signals_changedata.png)



``` 

### 3. Eight-digit driver
![Screenshot](/Labs/06-display_driver/Images/8bit.jpg)

