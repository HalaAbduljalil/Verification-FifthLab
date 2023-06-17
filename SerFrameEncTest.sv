`timescale 1ns/100ps

module tb;
localparam WIDTH = 32;
  
 logic [WIDTH-1:0] InBus;
 logic [2*WIDTH-1:0] OutBus;

  Frame myFrame(.InBus(InBus), .OutBus(OutBus));
  
  initial
    begin
      InBus = 'hffff_ffff;
      #10 $display("InBus=%b, OutBus=%b", InBus, OutBus);
     
      #100 $finish;
    
    end
endmodule