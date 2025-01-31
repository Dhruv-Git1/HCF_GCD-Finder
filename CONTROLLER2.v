module CONTROLLER(
    output reg done, ldA, ldB, sel1, sel2, sel_in,
    input start, lt, gt, eq, clk              
);
    reg [2:0] state, next_state;

    
    localparam S0 = 3'b000,   
               S1 = 3'b001, 
               S2 = 3'b010,
               S3 = 3'b011, 
               S4 = 3'b100,  
               S5 = 3'b101;   

    
    always @(posedge clk) begin
        state <= next_state;
    end

    
    always @(*) begin
        case (state)
          S0: next_state <= (start) ? S1 : S0;
            S1: next_state <= S2;
            S2: next_state <= S3;
          S3: next_state <= (eq) ? S5 : S4;
            S4: next_state <= S3;
            S5: next_state <= S5;
            default: next_state <= S0;
        endcase
    end

    
    always @(*) begin
        
        ldA = 0; ldB = 0; sel1 = 0; sel2 = 0; sel_in = 0; done = 0;

        case (state)
            S0: begin
                
                done = 0;
            end
            S1: begin
                
                ldA = 1;
                sel_in = 1; 
            end
            S2: begin
            
                ldB = 1;
                sel_in = 1; 
            end
            S3: begin
              
                if (lt) begin
                    sel1 = 1; sel2 = 0; ldB = 1; 
                end else if (gt) begin
                    sel1 = 0; sel2 = 1; ldA = 1; 
                end
            end
            S4: begin
                
                sel_in = 0; 
            end
            S5: begin
               
                done = 1;
            end
        endcase
    end
endmodule
