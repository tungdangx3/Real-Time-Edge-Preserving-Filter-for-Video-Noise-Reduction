module cas_1bit(a,b,t,c_in,r,q);
input a,b;
input c_in;
input t;
output q;
output r;

wire b1;

assign b1 = b ^ t;
assign r  = a ^ b1 ^ c_in;
assign q = (a & b1) | (b1 & c_in) | (a & c_in);

endmodule