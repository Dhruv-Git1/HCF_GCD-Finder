module MUX(out,data1,data2,sel);
  input [15:0] data1,data2;
  input sel;
  output [15:0] out;
  
  assign out = sel?data2:data1;
  
endmodule
