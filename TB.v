module encoder_tb();
 reg i_clk,i_rst_n;
  reg i_m,i_dv;
  wire o_done;
  wire [7:0] o_parity;
  reg [6:0]data;
  integer i=0;
encoder DUT(.i_clk(i_clk), .i_rst_n(i_rst_n), .i_m(i_m), .i_dv(i_dv), .o_parity(o_parity), .o_done(o_done));
  always #10 i_clk=~i_clk;
  always @(posedge i_clk)
  begin
    if(~i_rst_n)
    i=0;
    else if(i_dv)
    begin
        i_m = data[6-i];
        i = i + 1;
        if(i>=7)
        i<=0;
    end
  end
   initial begin
  data=7'h0101010;
  i_clk=1'b0;
  i_rst_n=1'b0;
  i_dv = 1'b0;
  #20
  i_rst_n=1'b1;
  #20
  i_dv = 1'b1;
  // Wait 100 ns for global reset to finish
  #1500;
  $finish;
  end
endmodule

