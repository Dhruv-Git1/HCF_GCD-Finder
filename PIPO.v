module PIPO(data_out,data_in,load,clk);
  input [15:0] data_in;
  input load , clk;
  output reg [15:0] data_out;
  
  always@(posedge clk)
    begin
      if (load)
        data_out <= data_in ;
    end
  
endmodule
