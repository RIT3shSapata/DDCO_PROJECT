`timescale 1 ns / 100 ps
`define TESTVECS 2

module tb;
    reg clk,reset;
    reg [3:0] m,q;
    wire [7:0] out;
    reg [7:0] test_vecs [0:(`TESTVECS-1)];
    integer i;
    initial begin $dumpfile("seq_mult_tb.vcd");
    $dumpvars(0,tb); 
    end
    initial begin reset = 1'b1; #12.5 reset = 1'b0; end
    initial clk = 1'b0; always #5 clk =~ clk;
    initial begin
        test_vecs[0][7:4]=4'b1011; test_vecs[0][3:0]=4'b1101;
        test_vecs[1][7:4]=4'b0011; test_vecs[1][3:0]=4'b1000;
    end
    initial {q,m} =0;
    sequential_multiplier sm(m,q,out);
    initial begin
    #6 for(i=0;i<`TESTVECS;i=i+1)
      begin #10 {q,m}=test_vecs[i]; end
    #100 $finish;
    end
endmodule