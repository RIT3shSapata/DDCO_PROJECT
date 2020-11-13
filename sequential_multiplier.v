module and2 (input wire i0, i1, output wire o);
  assign o = i0 & i1;
endmodule

module or2 (input wire i0, i1, output wire o);
  assign o = i0 | i1;
endmodule

module xor2 (input wire i0, i1, output wire o);
  assign o = i0 ^ i1;
endmodule

module full_adder(input wire a, b, cin, output wire sum, cout);
	wire [4:0] t;
    xor2 x0(a, b, t[0]);
    xor2 x1(t[0], cin, sum);

    and2 a0(a, b, t[1]);
    and2 a1(a, cin, t[2]);
    and2 a2(b, cin, t[3]);

    or2 o0(t[1], t[2], t[4]);
    or2 o1(t[3], t[4], cout);

endmodule

module partial_product_0(input wire[3:0] m, input wire q, output wire[3:0] out);
    and2 a0(m[0],q,out[0]);
    and2 a1(m[1],q,out[1]);
    and2 a2(m[2],q,out[2]);
    and2 a3(m[3],q,out[3]);
endmodule

module product_block(input wire m,q,pp,c_in,output wire c_out, out);
    wire t;
    and2 a0(m,q,t);
    full_adder fa(t,pp,cin,out,cout);
endmodule

module partial_product(input wire[3:0] m,pp, input wire q,c_in, output wire[3:0] out, output wire c_out);
    wire[2:0] c;
    product_block pb_1(m[0],q,pp[0],c_in,c[0],out[0]);
    product_block pb_2(m[1],q,pp[1],c[0],c[1],out[1]);
    product_block pb_3(m[2],q,pp[2],c[1],c[2],out[2]);
    product_block pb_4(m[3],q,pp[3],c[2],c_out,out[3]);
endmodule

module sequential_multiplier(input[3:0] m, q, output wire[7:0] out);
    wire[3:0] p0,p1,p2,p3;
    wire[3:0] pp0_res,pp1_res,pp2_res;
    wire c1,c2,c3;

    partial_product_0 pp0(m,q[0],p0);
    assign out[0] = p0[0];

    assign pp0_res[0] = p0[1];
    assign pp0_res[1] = p0[2];
    assign pp0_res[2] = p0[3];
    assign pp0_res[3] = 0;

    partial_product pp1(m,pp0_res,q[1],1'b0,p1,c1);
    assign out[1] = p1[0];

    assign pp1_res[0] = p1[1];
    assign pp1_res[1] = p1[2];
    assign pp1_res[2] = p1[3];
    assign pp1_res[3] = c1;

    partial_product pp2(m,pp1_res,q[2],c1,p2,c2);
    assign out[2] = p2[0];
    
    assign pp2_res[0] = p2[1];
    assign pp2_res[1] = p2[2];
    assign pp2_res[2] = p2[3];
    assign pp2_res[3] = c2;

    partial_product pp3(m,pp2_res,q[3],c2,p3,c3);
    assign out[3]= p3[0];
    assign out[4]= p3[1];
    assign out[5]= p3[2];
    assign out[6]= p3[3];
    assign out[7]= c3;
endmodule