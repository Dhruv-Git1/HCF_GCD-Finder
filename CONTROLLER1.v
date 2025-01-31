 module CONTROLLER(done,ldA,ldB,sel1,sel2,sel_in,     start,lt,gt,eq,clk);
  input start,clk,lt,gt,eq;
  output reg done,ldA,ldB,sel1,sel2,sel_in;
  
  reg [2:0] state,next_state;
  localparam S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101;
  
  always@(posedge clk)
    state<=next_state;
  
  always@(*) begin
    case (state)
      S0: next_state <= (start)?S1:S0 ;
      S1: next_state <= S2;
      
      //S2: #2 next_state <= lt?S3:(gt?S4:(eq?S5:S2)) ;
      S2: #2 if (eq) next_state<=S5;
      else if (lt) next_state<=S3;
      else if (gt) next_state <= S4;
      else next_state<=S2;
      S3: #2 next_state <= lt?S3:(gt?S4:(eq?S5:S3)) ;
      S4: #2 next_state <= lt?S3:(gt?S4:(eq?S5:S4)) ;
      S5: next_state <= S5;
      default: next_state <= S0;
    endcase
  end
  
  always@(*) begin
    case (state)
      S0: begin 
       ldA=0; ldB=0;done=0;
      end
      S1: begin
        ldA=1;sel_in=1;ldB=0 ;
      end
      S2: begin
        ldA= 0; ldB=1;sel_in=1 ;
      end
      S3: begin
         if(eq) done =1;
         else if (lt)begin
          sel1=1;sel2=0;sel_in=0; ldB=1; ldA=0 ;
         end
         else if (gt)begin
           sel1=0;sel2=1;sel_in=0;ldA=1;ldB=0;
         end
      end
      S4: begin
         if(eq) done =1;
         else if (lt)begin
           sel1=1;sel2=0;sel_in=0; ldB=1; ldA=0 ;
         end
         else if (gt)begin
          sel1=0;sel2=1;sel_in=0;ldA=1;ldB=0;
         end
      end
      S5: begin
        done = 1 ; ldA=0;ldB=0;
      end
      default: begin done = 1 ; ldA=0;ldB=0; end
    endcase
  end
  
endmodule
