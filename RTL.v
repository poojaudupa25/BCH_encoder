//(15, 7) BCH encoder
module encoder(i_clk, i_rst_n, i_m, i_dv, o_parity, o_done);
//assign input and output to port variables             
    input i_clk,i_rst_n;
    input i_m,i_dv;
    output [7:0] o_parity;
    output o_done;
 //registers to hold data based on generator polynomial  
    reg [7:0] x; 
    reg [7:0] xp;
    //register to hold count
    reg [7:0] i;
    //register to indicate end of encoding
    reg isEnd1;
   always@(posedge i_clk or negedge i_rst_n)
    begin
        if(~i_rst_n) 
        begin
            //reset registers
            x <= 8'b0; 
            xp <= 8'b0;
            i <= 8'd6;
            isEnd1 <= 1'b0;
	    end
	else
	    begin
		  if(isEnd1==1'b0 && i_dv)
		  begin
		      if (i>8'd0) 
		      begin
		          //repeat until i>0
		                x[0]<=xp[7]^i_m;
		                x[1]<=xp[0];
		                x[2]<=xp[1];
	                    x[3]<=xp[2];
		                x[4]<=xp[3]^x[0];
		                x[5]<=xp[4];
	                    x[6]<=xp[5]^x[0];
	                    x[7]<=xp[6]^x[0];
                  xp<=x;
                  i <= i-1'd1;
              end
              else if(i==8'd0)
              begin
                isEnd1 <= 1'b1;
              end
		  end
        end
    end
    assign o_parity=xp;
    assign o_done=isEnd1;
endmodule

