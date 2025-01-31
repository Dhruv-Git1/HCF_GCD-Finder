`include "PIPO.v"
`include "MUX.v"
`include "COMPARATOR.v"
`include "SUBSTRACTOR.v"
module Datapath(lt,gt,eq,ldA,ldB,sel1,sel2,data_in,sel_in,clk);
  input ldA,ldB,sel1,sel2,sel_in,clk;
  input [15:0] data_in;
  output lt,gt,eq;
  wire [15:0] BUS,Aout,Bout,sub_out,X,Y;
  
  MUX M1 (BUS,sub_out,data_in,sel_in);
  PIPO P1(Aout,BUS,ldA,clk);
  PIPO P2(Bout,BUS,ldB,clk);
  COMPARATOR COMP (lt,gt,eq,Aout,Bout);
  MUX A (X,Aout,Bout,sel1);
  MUX B (Y,Aout,Bout,sel2);
  SUB S (sub_out,X,Y);
  
endmodule
