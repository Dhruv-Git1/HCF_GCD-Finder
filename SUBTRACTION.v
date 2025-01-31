module SUB(out,data1,data2);
  input [15:0] data1,data2;
  output [15:0] out;
  
  assign out = data1 - data2;
  
endmodule
