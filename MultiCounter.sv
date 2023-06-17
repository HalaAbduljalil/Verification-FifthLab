module MultiCounter(input Clock, Reset, output CarryOut);
  localparam HiBit = 5 ;
  logic [HiBit:0] CountReg;
  
  assign CarryOut = CountReg[HiBit];
  
  always@(posedge Clock, posedge Reset)
    begin
      if(Reset == 1'b1)
        CountReg <= 'b0;
      else
        CountReg <= CountReg + 1'b1;
    end
endmodule