`timescale 1 ps/ 1 ps
module tb_filter();
localparam T=20;
parameter N=8;
	reg clk,rst_n,act;
	reg [N-1:0] a,b;
	wire [2*N-1:0] result;
	wire [N-1:0] c_i;
        integer i;  
    filter result_1 (clk,rst_n,act,a,b,result,c_i);
	always                                                 
	begin                                                  
		clk = 1'b1;
		#(T/2);
		clk = 1'b0;
		#(T/2);
	end
	initial
	begin 
         
	  rst_n = 1'b0;
		@(posedge clk);
		rst_n = 1'b1;
		//@(posedge clk);
		for(i= 0; i < N; i=i+1) begin
			a[i] = $random();
			b[i] = $random();
		end
                @(negedge clk )
                      a=255;
                      b=50;
@(negedge clk )
                      a=30;
                      b=70;
              //  @(posedge clk)
                    //  a=

	end
endmodule