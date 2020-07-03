module top_filter (clk,rst_n,cl_pixel,act,wr,sw_pixel_1,sw_pixel_2,sw_pixel_3,sw_pixel_4,sw_pixel_5,sw_pixel_6,sw_pixel_7,sw_pixel_8,sw_pixel_9);
localparam N=8;
localparam K=9;
input  [N-1:0] sw_pixel_1,sw_pixel_2,sw_pixel_3,sw_pixel_4,sw_pixel_5,sw_pixel_6,sw_pixel_7,sw_pixel_8,sw_pixel_9;
input clk , rst_n , act;
output  [N-1:0] cl_pixel ;
output wr;  
//internal signal 
wire wr;

reg r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;       
wire [7:0] sw_pixels [0:8];
wire [7:0] sub_abs0,sub_abs1,sub_abs2,sub_abs3,sub_abs4,sub_abs5,sub_abs6,sub_abs7,sub_abs8;


reg [15:0] reg_sub0,reg_sub1,reg_sub2,reg_sub3,reg_sub4,reg_sub5,reg_sub6,reg_sub7,reg_sub8;
wire [8:0] result_sub0,result_sub1,result_sub2,result_sub3,result_sub4,result_sub5,result_sub6,result_sub7,result_sub8;
reg [15:0] reg_mul1_0,reg_mul1_1,reg_mul1_2,reg_mul1_3,reg_mul1_4,reg_mul1_5,reg_mul1_6,reg_mul1_7,reg_mul1_8;
wire [15:0] result_mul1_0,result_mul1_1,result_mul1_2,result_mul1_3,result_mul1_4,result_mul1_5,result_mul1_6,result_mul1_7,result_mul1_8;

reg [15:0] reg_mul2_0,reg_mul2_1,reg_mul2_2,reg_mul2_3,reg_mul2_4,reg_mul2_5,reg_mul2_6,reg_mul2_7,reg_mul2_8;
wire [15:0] result_mul2_0,result_mul2_1,result_mul2_2,result_mul2_3,result_mul2_4,result_mul2_5,result_mul2_6,result_mul2_7,result_mul2_8;

reg [15:0] reg_mul3_0,reg_mul3_1,reg_mul3_2,reg_mul3_3,reg_mul3_4,reg_mul3_5,reg_mul3_6,reg_mul3_7,reg_mul3_8;
wire [15:0] result_mul3_0,result_mul3_1,result_mul3_2,result_mul3_3,result_mul3_4,result_mul3_5,result_mul3_6,result_mul3_7,result_mul3_8;

wire [15:0] result_mul16_0,result_mul16_1,result_mul16_2,result_mul16_3,result_mul16_4,result_mul16_5,result_mul16_6,result_mul16_7,result_mul16_8;
reg [71:0] reg_ci;    // store c_i
reg [143:0] reg_mul4;  // store cc
// result two adder circuit
wire [11:0] result_adder_8;
wire [19:0] result_adder_16;  

reg [7:0] reg_divisor;   // so chia
reg [15:0] reg_dividend;   // so bi chia

wire [15:0] result_div;
reg [7:0] out_div;

//output 
assign sw_pixels[0]=sw_pixel_1;
assign sw_pixels[1]=sw_pixel_2;
assign sw_pixels[2]=sw_pixel_3;
assign sw_pixels[3]=sw_pixel_4;
assign sw_pixels[4]=sw_pixel_5;
assign sw_pixels[5]=sw_pixel_6;
assign sw_pixels[6]=sw_pixel_7;
assign sw_pixels[7]=sw_pixel_8;
assign sw_pixels[8]=sw_pixel_9;

// generate filter 
// sub_abs
sub_8bit_abs sub0 (sw_pixels[0], sw_pixels[4],sub_abs0); 
sub_8bit_abs sub1 (sw_pixels[1], sw_pixels[4],sub_abs1);
sub_8bit_abs sub2 (sw_pixels[2], sw_pixels[4],sub_abs2);
sub_8bit_abs sub3 (sw_pixels[3], sw_pixels[4],sub_abs3);
sub_8bit_abs sub4 (sw_pixels[4], sw_pixels[4],sub_abs4);
sub_8bit_abs sub5 (sw_pixels[5], sw_pixels[4],sub_abs5);
sub_8bit_abs sub6 (sw_pixels[6], sw_pixels[4],sub_abs6);
sub_8bit_abs sub7 (sw_pixels[7], sw_pixels[4],sub_abs7);
sub_8bit_abs sub8 (sw_pixels[8], sw_pixels[4],sub_abs8);
// sub_255
sub_8bit sub_0 (8'd255, sub_abs0 ,result_sub0);
sub_8bit sub_1 (8'd255, sub_abs1 ,result_sub1);
sub_8bit sub_2 (8'd255, sub_abs2 ,result_sub2);
sub_8bit sub_3 (8'd255, sub_abs3 ,result_sub3);
sub_8bit sub_4 (8'd255, sub_abs4 ,result_sub4);
sub_8bit sub_5 (8'd255, sub_abs5 ,result_sub5);
sub_8bit sub_6 (8'd255, sub_abs6 ,result_sub6);
sub_8bit sub_7 (8'd255, sub_abs7 ,result_sub7);
sub_8bit sub_8 (8'd255, sub_abs8 ,result_sub8);
// 8 thanh ghi 16, 1 thanh ghi 8 bit
always @(posedge clk ,negedge rst_n)
	begin 
		if(!rst_n)  
			begin 
				reg_sub0 <= 16'd0;
				reg_sub1 <= 16'd0;		
				reg_sub2 <= 16'd0;	
				reg_sub3 <= 16'd0;	
				reg_sub4 <= 16'd0;	
				reg_sub5 <= 16'd0;	
				reg_sub6 <= 16'd0;	
				reg_sub7 <= 16'd0;	
				reg_sub8 <= 16'd0;
			end	
		else 
			begin 
		 		if(act) 
			 	begin
					reg_sub0 <= {sw_pixels[0],result_sub0[7:0]}; 
					reg_sub1 <= {sw_pixels[1],result_sub1[7:0]};
					reg_sub2 <= {sw_pixels[2],result_sub2[7:0]};
					reg_sub3 <= {sw_pixels[3],result_sub3[7:0]};
					reg_sub4 <= {sw_pixels[4],result_sub4[7:0]};
					reg_sub5 <= {sw_pixels[5],result_sub5[7:0]};
					reg_sub6 <= {sw_pixels[6],result_sub6[7:0]};
					reg_sub7 <= {sw_pixels[7],result_sub7[7:0]};
					reg_sub8 <= {sw_pixels[8],result_sub8[7:0]};
				end
			end
	end
				

// binh phuong
arr_mul mulx2_0 (reg_sub0[7:0],reg_sub0[7:0],result_mul1_0);  
arr_mul mulx2_1 (reg_sub1[7:0],reg_sub1[7:0],result_mul1_1);  
arr_mul mulx2_2 (reg_sub2[7:0],reg_sub2[7:0],result_mul1_2);  
arr_mul mulx2_3 (reg_sub3[7:0],reg_sub3[7:0],result_mul1_3);  
arr_mul mulx2_4 (reg_sub4[7:0],reg_sub4[7:0],result_mul1_4);  
arr_mul mulx2_5 (reg_sub5[7:0],reg_sub5[7:0],result_mul1_5);
arr_mul mulx2_6 (reg_sub6[7:0],reg_sub6[7:0],result_mul1_6);  
arr_mul mulx2_7 (reg_sub7[7:0],reg_sub7[7:0],result_mul1_7); 
arr_mul mulx2_8 (reg_sub8[7:0],reg_sub8[7:0],result_mul1_8); 

// 8 thanh ghi 16, 1 thanh ghi 8 bit
always @(posedge clk ,negedge rst_n)
	begin 
		if(!rst_n)  
			begin 
				reg_mul1_0 <= 16'd0;
				reg_mul1_1 <= 16'd0;		
				reg_mul1_2 <= 16'd0;	
				reg_mul1_3 <= 16'd0;	
				reg_mul1_4 <= 16'd0;	
				reg_mul1_5 <= 16'd0;	
				reg_mul1_6 <= 16'd0;	
				reg_mul1_7 <= 16'd0;	
				reg_mul1_8 <= 16'd0;
			end	
		else begin 
				reg_mul1_0 <= {reg_sub0[15:8],result_mul1_0[15:8]};
				reg_mul1_1 <= {reg_sub1[15:8],result_mul1_1[15:8]};		
				reg_mul1_2 <= {reg_sub2[15:8],result_mul1_2[15:8]};	
				reg_mul1_3 <= {reg_sub3[15:8],result_mul1_3[15:8]};	
				reg_mul1_4 <= {reg_sub4[15:8],result_mul1_4[15:8]};	
				reg_mul1_5 <= {reg_sub5[15:8],result_mul1_5[15:8]};	
				reg_mul1_6 <= {reg_sub6[15:8],result_mul1_6[15:8]};	
				reg_mul1_7 <= {reg_sub7[15:8],result_mul1_7[15:8]};	
				reg_mul1_8 <= {reg_sub8[15:8],result_mul1_8[15:8]};
			end
	end
// binh phuong
arr_mul mulx4_0 (reg_mul1_0[7:0],reg_mul1_0[7:0],result_mul2_0);  
arr_mul mulx4_1 (reg_mul1_1[7:0],reg_mul1_1[7:0],result_mul2_1);  
arr_mul mulx4_2 (reg_mul1_2[7:0],reg_mul1_2[7:0],result_mul2_2);  
arr_mul mulx4_3 (reg_mul1_3[7:0],reg_mul1_3[7:0],result_mul2_3);  
arr_mul mulx4_4 (reg_mul1_4[7:0],reg_mul1_4[7:0],result_mul2_4);  
arr_mul mulx4_5 (reg_mul1_5[7:0],reg_mul1_5[7:0],result_mul2_5);
arr_mul mulx4_6 (reg_mul1_6[7:0],reg_mul1_6[7:0],result_mul2_6);  
arr_mul mulx4_7 (reg_mul1_7[7:0],reg_mul1_7[7:0],result_mul2_7); 
arr_mul mulx4_8 (reg_mul1_8[7:0],reg_mul1_8[7:0],result_mul2_8); 
// 8 thanh ghi 16, 1 thanh ghi 8 bit
always @(posedge clk ,negedge rst_n)
	begin 
		if(!rst_n)  
			begin 
				reg_mul2_0 <= 16'd0;
				reg_mul2_1 <= 16'd0;		
				reg_mul2_2 <= 16'd0;	
				reg_mul2_3 <= 16'd0;	
				reg_mul2_4 <= 16'd0;	
				reg_mul2_5 <= 16'd0;	
				reg_mul2_6 <= 16'd0;	
				reg_mul2_7 <= 16'd0;	
				reg_mul2_8 <= 16'd0;
			end	
		else begin 
				reg_mul2_0 <= {reg_mul1_0[15:8],result_mul2_0[15:8]};
				reg_mul2_1 <= {reg_mul1_1[15:8],result_mul2_1[15:8]};		
				reg_mul2_2 <= {reg_mul1_2[15:8],result_mul2_2[15:8]};	
				reg_mul2_3 <= {reg_mul1_3[15:8],result_mul2_3[15:8]};	
				reg_mul2_4 <= {reg_mul1_4[15:8],result_mul2_4[15:8]};	
				reg_mul2_5 <= {reg_mul1_5[15:8],result_mul2_5[15:8]};	
				reg_mul2_6 <= {reg_mul1_6[15:8],result_mul2_6[15:8]};	
				reg_mul2_7 <= {reg_mul1_7[15:8],result_mul2_7[15:8]};	
				reg_mul2_8 <= {reg_mul1_8[15:8],result_mul2_8[15:8]};
			end
	end
// binh phuong
arr_mul mulx8_0 (reg_mul2_0[7:0],reg_mul2_0[7:0],result_mul3_0);  
arr_mul mulx8_1 (reg_mul2_1[7:0],reg_mul2_1[7:0],result_mul3_1);  
arr_mul mulx8_2 (reg_mul2_2[7:0],reg_mul2_2[7:0],result_mul3_2);  
arr_mul mulx8_3 (reg_mul2_3[7:0],reg_mul2_3[7:0],result_mul3_3);  
arr_mul mulx8_4 (reg_mul2_4[7:0],reg_mul2_4[7:0],result_mul3_4);  
arr_mul mulx8_5 (reg_mul2_5[7:0],reg_mul2_5[7:0],result_mul3_5);
arr_mul mulx8_6 (reg_mul2_6[7:0],reg_mul2_6[7:0],result_mul3_6);  
arr_mul mulx8_7 (reg_mul2_7[7:0],reg_mul2_7[7:0],result_mul3_7); 
arr_mul mulx8_8 (reg_mul2_8[7:0],reg_mul2_8[7:0],result_mul3_8); 
// 2 thanh ghi
always @(posedge clk ,negedge rst_n)
	begin 
		if(!rst_n)  
			begin 
				reg_mul3_0 <= 16'd0;
				reg_mul3_1 <= 16'd0;		
				reg_mul3_2 <= 16'd0;	
				reg_mul3_3 <= 16'd0;	
				reg_mul3_4 <= 16'd0;	
				reg_mul3_5 <= 16'd0;	
				reg_mul3_6 <= 16'd0;	
				reg_mul3_7 <= 16'd0;	
				reg_mul3_8 <= 16'd0;
			end	
		else begin 
				reg_mul3_0 <= {reg_mul2_0[15:8],result_mul3_0[15:8]};
				reg_mul3_1 <= {reg_mul2_1[15:8],result_mul3_1[15:8]};		
				reg_mul3_2 <= {reg_mul2_2[15:8],result_mul3_2[15:8]};	
				reg_mul3_3 <= {reg_mul2_3[15:8],result_mul3_3[15:8]};	
				reg_mul3_4 <= {reg_mul2_4[15:8],result_mul3_4[15:8]};	
				reg_mul3_5 <= {reg_mul2_5[15:8],result_mul3_5[15:8]};	
				reg_mul3_6 <= {reg_mul2_6[15:8],result_mul3_6[15:8]};	
				reg_mul3_7 <= {reg_mul2_7[15:8],result_mul3_7[15:8]};	
				reg_mul3_8 <= {reg_mul2_8[15:8],result_mul3_8[15:8]};
			end
	end

// Mul 16bit
arr_mul mulx16_0 (reg_mul3_0[15:8],reg_mul3_0[7:0],result_mul16_0);
arr_mul mulx16_1 (reg_mul3_1[15:8],reg_mul3_1[7:0],result_mul16_1);
arr_mul mulx16_2 (reg_mul3_2[15:8],reg_mul3_2[7:0],result_mul16_2);
arr_mul mulx16_3 (reg_mul3_3[15:8],reg_mul3_3[7:0],result_mul16_3);
arr_mul mulx16_4 (reg_mul3_4[15:8],reg_mul3_4[7:0],result_mul16_4);
arr_mul mulx16_5 (reg_mul3_5[15:8],reg_mul3_5[7:0],result_mul16_5);
arr_mul mulx16_6 (reg_mul3_6[15:8],reg_mul3_6[7:0],result_mul16_6);
arr_mul mulx16_7 (reg_mul3_7[15:8],reg_mul3_7[7:0],result_mul16_7);
arr_mul mulx16_8 (reg_mul3_8[15:8],reg_mul3_8[7:0],result_mul16_8);

// thanh ghi pipeline truoc bo adder
always @(posedge clk ,negedge rst_n)
	begin 
		if(!rst_n)  
				reg_ci <= 72'd0;
		else reg_ci <= {reg_mul3_0[7:0],reg_mul3_1[7:0],reg_mul3_2[7:0],reg_mul3_3[7:0],reg_mul3_4[7:0],reg_mul3_5[7:0],reg_mul3_6[7:0],reg_mul3_7[7:0],reg_mul3_8[7:0]};
	end
// thanh ghi pipeline sau bo mul4
always @(posedge clk ,negedge rst_n)
	begin 
		if(!rst_n)  
				reg_mul4 <= 144'd0;
		else reg_mul4 <= {result_mul16_0,result_mul16_1,result_mul16_2,result_mul16_3,result_mul16_4,result_mul16_5,result_mul16_6,result_mul16_7,result_mul16_8};
	end

// module adder_pipeline
add_pipeline_8bit sum_1(reg_ci[71:64],reg_ci[63:56],reg_ci[55:48],reg_ci[47:40],reg_ci[39:32],reg_ci[31:24],reg_ci[23:16],reg_ci[15:8],reg_ci[7:0],clk,rst_n,result_adder_8);
add_pipeline_16bit sum_2 (reg_mul4[143:128],reg_mul4[127:112],reg_mul4[111:96],reg_mul4[95:80],reg_mul4[79:64],reg_mul4[63:48],reg_mul4[47:32],reg_mul4[31:16],reg_mul4[15:0],clk,rst_n,result_adder_16);

// pipeline division circuit
always @(posedge clk ,negedge rst_n)
	begin 
		if(!rst_n) 
			begin 
 			 reg_divisor <= 8'd0 ;  
 			 reg_dividend <= 16'd0;   
			end 
		else begin 
			 reg_divisor <= result_adder_8[11:4];  
 			 reg_dividend <= result_adder_16[19:4];
		     end 
	end 
// result division
div_16bit_8bit div ({1'b0,result_adder_16[19:5]},{1'b0,result_adder_8[11:5]},clk,rst_n,result_div);
// output 
always @(posedge clk ,negedge rst_n)
begin
if(!rst_n)
begin
r1 <= 1'b0;
r2 <= 1'b0;
r3 <= 1'b0;
r4 <= 1'b0;
r5 <= 1'b0;
r6 <= 1'b0;
r7 <= 1'b0;
r8 <= 1'b0;
r9 <= 1'b0;
r10 <= 1'b0;
end
else
begin
r1 <= act;
r2 <= r1;
r3 <= r2;
r4 <= r3;
r5 <= r4;
r6 <= r5;
r7 <= r6;
r8 <= r7;
r9 <= r8;
r10 <= r9;
end
end

assign wr = r10;

always @(posedge clk ,negedge rst_n)
	begin 
		if(!rst_n) 
			out_div <= 8'd0;
		else 
			out_div <= result_div[7:0];
	end 

assign cl_pixel = out_div;
endmodule






