module tb_top_filter ();
parameter N=8;
parameter K=9;
parameter T=20;
reg [N-1:0] sw_pixel_1,sw_pixel_2,sw_pixel_3,sw_pixel_4,sw_pixel_5,sw_pixel_6,sw_pixel_7,sw_pixel_8,sw_pixel_9;
//integer j;
reg clk,rst_n,act;
wire [N-1:0] cl_pixel;
wire wr;

top_filter fil(clk,rst_n,cl_pixel,act,wr,sw_pixel_1,sw_pixel_2,sw_pixel_3,sw_pixel_4,sw_pixel_5,sw_pixel_6,sw_pixel_7,sw_pixel_8,sw_pixel_9);
initial
begin
clk=0;
forever #(T/2) clk=~clk;
end
initial
begin
rst_n=0;
#5
rst_n=1;
end

initial begin 
  act = 0;
  #7;
  act = 1;
  
  end 
  
initial
begin
#10;
sw_pixel_1=8'h8c;
sw_pixel_2=8'h92;
sw_pixel_3=8'h84;
sw_pixel_4=8'h8c;
sw_pixel_5=8'h92;
sw_pixel_6=8'h84;
sw_pixel_7=8'h81;
sw_pixel_8=8'h93;
sw_pixel_9=8'h86;
#20;
sw_pixel_1=8'h92;
sw_pixel_2=8'h84;
sw_pixel_3=8'h87;
sw_pixel_4=8'h92;
sw_pixel_5=8'h84;
sw_pixel_6=8'h87;
sw_pixel_7=8'h93;
sw_pixel_8=8'h86;
sw_pixel_9=8'h85;
#20;
sw_pixel_1=8'h84;
sw_pixel_2=8'h87;
sw_pixel_3=8'h81;
sw_pixel_4=8'h84;
sw_pixel_5=8'h87;
sw_pixel_6=8'h81;
sw_pixel_7=8'h86;
sw_pixel_8=8'h85;
sw_pixel_9=8'h8a;


end

endmodule
