module tb_top_system ();
parameter T=20;
reg clk ,rst_n ,en;
wire done;
// mem read
reg [7:0] data_in0 [0:129][0:129];
reg [7:0] filted_img0 [0:127][0:127];

integer m,n;
top_system fil (clk,rst_n,en ,done );
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
initial
begin
en=1;
#16;
en = 0;
end
initial begin 
 $readmemh("E:/data_filter/noisy_im_padding1.mem",data_in0); 
 $readmemh("E:/data_filter/fil_im1.mem",filted_img0); 
   for (m=0;m<130;m=m+1) begin 
     for (n=0;n<130;n=n+1) begin 
	      fil.mem.Mem_img0[m][n] = data_in0[m][n];
	   end 
	   end 
  end 
 /* 
initial
 begin 
 #(16900*20);     // time delay use to compare result from MEMORY 
     for (m=0;m<128;m=m+1) begin 
       for (n=0;n<128;n=n+1) begin 
	     if(fil.mem.Mem_fil_img0[m][n]!= filted_img0[m][n])
	 begin
	 $display("sai o vi tri hang :%d, cot : %d",m,n);
	 end
	 end
   end
  end
  */
endmodule