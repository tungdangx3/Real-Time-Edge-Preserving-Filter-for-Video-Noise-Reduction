module top_system (clk,rst_n,en,done);
localparam N=8;
localparam K=9;
// input/output
input clk , rst_n , en;
output done ;

// internal signal 
wire act;
wire done_mem;
wire  [N-1:0] cl_pixel ;   // data is filted
wire wr;      // signal write into mem2
wire rd ;     // signal read from mem1
wire [N-1:0] sw_pixel_1,sw_pixel_2,sw_pixel_3,sw_pixel_4,sw_pixel_5,sw_pixel_6,sw_pixel_7,sw_pixel_8,sw_pixel_9;  
wire [N-1:0] sw_pixels [0:K-1];
// assign input 
assign sw_pixels[0]=sw_pixel_1;
assign sw_pixels[1]=sw_pixel_2;
assign sw_pixels[2]=sw_pixel_3;
assign sw_pixels[3]=sw_pixel_4;
assign sw_pixels[4]=sw_pixel_5;
assign sw_pixels[5]=sw_pixel_6;
assign sw_pixels[6]=sw_pixel_7;
assign sw_pixels[7]=sw_pixel_8;
assign sw_pixels[8]=sw_pixel_9;
// Instance Module 
// Controller Module
controller control (clk,en,rst_n,act,rd); 
// Filter Module 
top_filter fil (clk,rst_n,cl_pixel,act,wr,sw_pixels[0],sw_pixels[1],sw_pixels[2],sw_pixels[3],sw_pixels[4],sw_pixels[5],sw_pixels[6],sw_pixels[7],sw_pixels[8]);
// Memory Module 
memory mem (clk,rst_n,rd,wr,done_mem,cl_pixel,sw_pixel_1,sw_pixel_2,sw_pixel_3,sw_pixel_4,sw_pixel_5,sw_pixel_6,sw_pixel_7,sw_pixel_8,sw_pixel_9);
// done work 
assign done = done_mem;    // signal annouces image filtering process is finished

endmodule








