module controller (clk,en,rst_n,act,rd); 
   input clk ,rst_n ;
   input en  ; 
   output  rd ;
   output act ;

reg rd_r;
reg act_r;
wire en1;
reg [14:0] cnt;  
wire tick; 
 always @(posedge clk , negedge rst_n)
  begin 
    if(!rst_n)
	  rd_r <= 'h0;
	else if (en1) 
	  rd_r <= en;
  end 

assign tick = (cnt == 15'h4203) ? 1'b1 : 1'b0;
assign en1 = en | tick; 

 always @(posedge clk , negedge rst_n)
  begin 
     if(!rst_n)  
	    cnt <= 15'd0;
	 else if(rd)
      begin 
        if(cnt == 15'h4203)
          cnt <= 15'd0;
        else
	        cnt <= cnt + 1'b1;
      end
  end 
always @(posedge clk , negedge rst_n)
  begin 
     if(!rst_n)  act_r <= 1'b0;
     else act_r = rd_r;
  end

assign rd = rd_r;
assign act = act_r;
endmodule 


