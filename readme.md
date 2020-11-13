Commands to execute the program:

iverilog -o smou sequential_multiplier.v tb_seq_mult.v

vvp smou

gtkwave seq_mult_tb.vcd
