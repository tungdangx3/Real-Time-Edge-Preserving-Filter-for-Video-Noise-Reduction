module sub_8bit(a, b,result_sub1);  // test bench
  // signals used in test bench (the interconnections)
  
  input   [7:0] a; // so bi tru
  input   [7:0] b;  // so tru
  output [8:0] result_sub1; 
  
  wire [8:0] cout;
  // tang 1: khoi tru
  //        
// a,b,t,c_in,r,q
  cas_1bit bit03(a[0],b[0],1'b1,1'b1,result_sub1[0], cout[0]);
  cas_1bit bit04(a[1],b[1],1'b1,cout[0],result_sub1[1], cout[1]);
  cas_1bit bit05(a[2],b[2],1'b1,cout[1],result_sub1[2], cout[2]);
  cas_1bit bit06(a[3],b[3],1'b1,cout[2],result_sub1[3], cout[3]);
  cas_1bit bit07(a[4],b[4],1'b1,cout[3],result_sub1[4], cout[4]);
  cas_1bit bit08(a[5],b[5],1'b1,cout[4],result_sub1[5], cout[5]);
  cas_1bit bit09(a[6],b[6],1'b1,cout[5],result_sub1[6], cout[6]);
  cas_1bit bit00(a[7],b[7],1'b1,cout[6],result_sub1[7], cout[7]);
  cas_1bit bit01(1'b0,1'b0,1'b1,cout[7],result_sub1[8], cout[8]);
  
  
endmodule // b4


