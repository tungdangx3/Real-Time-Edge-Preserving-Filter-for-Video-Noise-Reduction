module memory (clk,rst_n,rd,wr,done,cl_pixel,sw_pixel_1,sw_pixel_2,sw_pixel_3,sw_pixel_4,sw_pixel_5,sw_pixel_6,sw_pixel_7,sw_pixel_8,sw_pixel_9);
// declaration in/output

   input clk ,rd , rst_n,wr ;
   input [7:0] cl_pixel;
   output reg [7:0] sw_pixel_1,sw_pixel_2,sw_pixel_3,sw_pixel_4,sw_pixel_5,sw_pixel_6,sw_pixel_7,sw_pixel_8,sw_pixel_9;
   output reg done ;

// signal choose col , row
reg [6:0] x_rd,y_rd,x_wr,y_wr;
wire tick_rd,tick_wr;
reg delay0;      // dong bo du lieu dau ra cua Memory
wire delay;
// Memory read
reg [7:0] Mem_img0 [0:129][0:129];      // Mem_img storage noise image 
// Memory Write
reg [7:0] Mem_fil_img0 [0:127][0:127];  // Mem_fil_img storage image is filter
 
always@(posedge clk,negedge rst_n)
  begin 
    if(!rst_n)
	    x_rd <= 7'h0;
    else if(rd && delay)
	    begin
        if(x_rd == 7'h7f) 
	        x_rd <= 7'h0;
	      else 
	        x_rd <= x_rd+1;
      end
	 else
	   x_rd <= 7'h0;
  end 

assign tick_rd = (x_rd == 7'h7f) ? 1'b1 : 1'b0;

always@(posedge clk,negedge rst_n)
  begin 
    if(!rst_n)
	   y_rd <= 7'h0;
    else if(rd && delay)
	  begin
	    if(tick_rd)
          begin 
            if (y_rd == 7'h7f)	
              y_rd <= 7'h0;
          else			
	          y_rd <= y_rd +1;
          end 
	  end
	 else
	    y_rd <= 7'h0;
  end	   
always @(posedge clk, negedge rst_n)
  begin 
    if(!rst_n)  
        delay0 <= 1'd0;
    else 
        delay0 <= rd;
  end
  
assign delay = delay0;

always @* 
  begin 
    if(rd && delay) 
	  begin
       sw_pixel_1 <= Mem_img0[y_rd][x_rd]; 
       sw_pixel_2 <= Mem_img0[y_rd][x_rd+1];
       sw_pixel_3 <= Mem_img0[y_rd][x_rd+2];
       sw_pixel_4 <= Mem_img0[y_rd+1][x_rd];
       sw_pixel_5 <= Mem_img0[y_rd+1][x_rd+1];
       sw_pixel_6 <= Mem_img0[y_rd+1][x_rd+2];
       sw_pixel_7 <= Mem_img0[y_rd+2][x_rd];
       sw_pixel_8 <= Mem_img0[y_rd+2][x_rd+1];
       sw_pixel_9 <= Mem_img0[y_rd+2][x_rd+2];
    end
	else begin 
       sw_pixel_1 <= 8'd0; 
       sw_pixel_2 <= 8'd0; 
       sw_pixel_3 <= 8'd0; 
       sw_pixel_4 <= 8'd0; 
       sw_pixel_5 <= 8'd0; 
       sw_pixel_6 <= 8'd0; 
       sw_pixel_7 <= 8'd0; 
       sw_pixel_8 <= 8'd0; 
       sw_pixel_9 <= 8'd0; 
     end
  end 
//----------write to memory------------
// select signal control write

always@(posedge clk,negedge rst_n)
  begin 
    if(!rst_n)
	   x_wr <= 7'h0;
    else if(wr)
	    begin
        if(x_wr == 7'h7d) 
	      x_wr <= 7'h0;
	      else 
	      x_wr <= x_wr+1;
      end
	  else
	    x_wr <= 7'h0;
  end 

assign tick_wr = (x_wr == 7'h7d) ? 1'b1:1'b0;


always@(posedge clk,negedge rst_n)
  begin 
    if(!rst_n)
	   y_wr <= 7'h0;
    else if(wr)
      begin
	      if(tick_wr)
          begin 
            if (y_wr == 7'h7d)	
              y_wr <= 7'h0;
            else			
	          y_wr <= y_wr +1;
          end 
      end
  	else
	    y_wr <= 7'h0;
  end

// luu pixel vao thanh ghi

always @*
 begin
   if(wr)
        Mem_fil_img0[y_wr][x_wr] <= cl_pixel;
   else
        Mem_fil_img0[y_wr][x_wr] <= 8'd0;
  end

//  done 
always @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	  done <= 1'b0;
	 else if (x_wr== 7'h7d && y_wr== 7'h7d)
	  done <= 1'b1;
	 else
	  done <= 1'b0;
  end
endmodule




