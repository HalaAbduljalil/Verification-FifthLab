module Comparator (output[1:0] AdjustFreq, input ClockIn, PLLClock, Reset );
logic[1:0] Adjr;
assign AdjustFreq = Adjr;
//
reg[2:0] HiCount;  // Counts PLL highs per ClockIn.
reg[1:0] EdgeCode; // Locally encodes edge decision.
reg[3:0] AvgEdge;  // Decision variable.
reg[2:0] Done;   // Decision trigger variable.
//First Part
always@(ClockIn, Reset)
  begin : CheckEdges
  if (Reset==1'b1)
       begin
       EdgeCode = 2'b01;
       HiCount  =  'b0;
       end
 else if (PLLClock==1'b1) // Should be 1 of these per ClockIn cycle.
            HiCount = HiCount + 3'b1;
       else 
    begin
     case (HiCount)
             3'b000: EdgeCode = 2'b00; // PLL too slow.
             3'b001: EdgeCode = 2'b01; // Seems matched.
            default: EdgeCode = 2'b11; // PLL too fast.
            endcase
            HiCount = 'b0; // Initialize for next ClockIn edge.
            end
  end // CheckEdges.

always@(ClockIn, Reset)
  begin : MakeDecision
  if (Reset==1'b1)
       begin
       Adjr    = 2'b1; // No change code.
       Done    =  'b0;
       AvgEdge =  4'h8;
       end
  else begin // Update the AvgEdge & check for decision:
       case (EdgeCode)
       2'b11: AvgEdge = AvgEdge + 1; // Add to PLL edge count.
       2'b00: AvgEdge = AvgEdge - 1; // Sub from PLL edge count.
       // default: do nothing.
       endcase
       Done = Done + 1;
       if (Done=='b0) // Wrap-around.
         begin
              if ( AvgEdge<7 )
                  Adjr = 2'b11; // Better speed it up.
              else if ( AvgEdge>9 )
                   Adjr = 2'b00; // Must be too fast.
              else Adjr = 2'b01; // No change.
              AvgEdge = 4'h8;// Initialize for next Done.
              end
       end
  end // MakeDecision.
//
endmodule // Comparator.
