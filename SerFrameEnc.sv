`timescale 1ns/100ps

module Frame
#(parameter WIDTH = 32)
(input [WIDTH -1:0]InBus, output [WIDTH*2-1:0] OutBus);
  
  genvar i;
  generate
    for(i = 0; i < $clog2(WIDTH); i = i + 1)
      begin
        assign OutBus[16*i+7:16*i] = {3'b000, i, 3'b000};
        assign OutBus[15+16*i : 8+16*i] = InBus[8*i+7:8*i];
      end
  endgenerate

endmodule