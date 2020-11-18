module seq_mul (input wire clk,reset,test, input wire [7:0] mul,b,output wire [15:0] prod);
    wire [15:0]sum;
    wire carry,cout;
    alu_slice alu_slice0(test,prod,mul,sum,cout);
    reg_file reg_file0(clk,reset,test,cout,sum,prod);
    
    
endmodule

module alu_slice(input wire test,input wire[15:0] a,input wire[7:0] b1,output wire [15:0] out,output wire carry);
wire [7:0]b;
wire [6:0]c; 
    assign out[0] = a[0];
    assign out[1] = a[1];
    assign out[2] = a[2];
    assign out[3] = a[3];
    assign out[4] = a[4];
    assign out[5] = a[5];
    assign out[6] = a[6];
    assign out[7] = a[7];

    and2 and2_0(test,b1[0],b[0]);
    and2 and2_1(test,b1[1],b[1]);
    and2 and2_2(test,b1[2],b[2]);
    and2 and2_3(test,b1[3],b[3]);
    and2 and2_4(test,b1[4],b[4]);
    and2 and2_5(test,b1[5],b[5]);
    and2 and2_6(test,b1[6],b[6]);
    and2 and2_7(test,b1[7],b[7]);

    fa fa_0(a[8],b[0],1'b0,out[8],c[0]);
    fa fa_1(a[9],b[1],c[0],out[9],c[1]);
    fa fa_2(a[10],b[2],c[1],out[10],c[2]);
    fa fa_3(a[11],b[3],c[2],out[11],c[3]);
    fa fa_4(a[12],b[4],c[3],out[12],c[4]);
    fa fa_5(a[13],b[5],c[4],out[13],c[5]);
    fa fa_6(a[14],b[6],c[5],out[14],c[6]);
    fa fa_7(a[15],b[7],c[6],out[15],carry);
endmodule

module reg_file(input wire clk,reset,test,cout,input wire [15:0]sum,output wire [15:0] prod);
    wire [15:0] r0;
    read read_0(clk,r0,prod);
    shift shift_0(clk,reset,cout,sum,r0);
endmodule

module read (input wire clk, input wire [15:0] x, output wire [15:0] y);
    assign y[0] = x[0];
    assign y[1] = x[1];
    assign y[2] = x[2];
    assign y[3] = x[3];
    assign y[4] = x[4];
    assign y[5] = x[5];
    assign y[6] = x[6];
    assign y[7] = x[7];
    assign y[8] = x[8];
    assign y[9] = x[9];
    assign y[10] = x[10];
    assign y[11] = x[11];
    assign y[12] = x[12];
    assign y[13] = x[13];
    assign y[14] = x[14];
    assign y[15] = x[15];
endmodule

module shift(input wire clk,reset,cout, input wire [15:0] sum,output [15:0] out);
    wire test = 1'b1;
    dfrl dfrl_0(clk,reset,test,sum[1],out[0]);
    dfrl dfrl_1(clk,reset,test,sum[2],out[1]);
    dfrl dfrl_2(clk,reset,test,sum[3],out[2]);
    dfrl dfrl_3(clk,reset,test,sum[4],out[3]);
    dfrl dfrl_4(clk,reset,test,sum[5],out[4]);
    dfrl dfrl_5(clk,reset,test,sum[6],out[5]);
    dfrl dfrl_6(clk,reset,test,sum[7],out[6]);
    dfrl dfrl_7(clk,reset,test,sum[8],out[7]);
    dfrl dfrl_8(clk,reset,test,sum[9],out[8]);
    dfrl dfrl_9(clk,reset,test,sum[10],out[9]);
    dfrl dfrl_10(clk,reset,test,sum[11],out[10]);
    dfrl dfrl_11(clk,reset,test,sum[12],out[11]);
    dfrl dfrl_12(clk,reset,test,sum[13],out[12]);
    dfrl dfrl_13(clk,reset,test,sum[14],out[13]);
    dfrl dfrl_14(clk,reset,test,sum[15],out[14]);
    dfrl dfrl_15(clk,reset,test,cout,out[15]);
endmodule

module fa (input wire i0, i1, cin, output wire sum, cout);
   wire t0, t1, t2;
   xor3 xor3_0 (i0, i1, cin, sum);
   and2 and2_01 (i0, i1, t0);
   and2 and2_02 (i1, cin, t1);
   and2 and2_03 (cin, i0, t2);
   or3 or3_01 (t0, t1, t2, cout);
endmodule
    