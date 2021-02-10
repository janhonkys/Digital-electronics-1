## Labs
https://www.edaplayground.com/x/EqRu
#### De Morgan laws sim

```vhdl
architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    --fand_o <= a_i and b_i;
    --fxor_o <= a_i xor b_i;

end architecture dataflow;

```

```LaTeX
\begin{align*}
    f(c,b,a) =&~ \overline{b}\,a + \overline{c}\,\overline{b}\\
    f(c,b,a)_{\textup{NAND}} =&\\
    f(c,b,a)_{\textup{NOR}} =&\\
\end{align*}
```
>

Run any text editor, such as *Visual Studio Code* or *Atom*, open/create your `Digital-electronics-1/Labs/01-gates/README.md` local file (not on GitHub), complete tables with logical values, add link to your Playground and a screenshot with time waveforms from the simulator.

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 |  |
| 0 | 0 | 1 |  |
| 0 | 1 | 0 |  |
| 0 | 1 | 1 |  |
| 1 | 0 | 0 |  |
| 1 | 0 | 1 |  |
| 1 | 1 | 0 |  |
| 1 | 1 | 1 |  |

