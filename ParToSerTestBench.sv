module tb;

  localparam WIDTH = 32;
  
  logic SerOut, SerValidFlag, SerClock=1'b1, ParValid;
  logic [WIDTH-1:0] BusIn;
  
  ParToSerial #(WIDTH) myModule( .SerOut(SerOut), .SerValidFlag(SerValidFlag), .SerClock(SerClock), .ParValid(ParValid), .BusIn(BusIn));
  
  
   integer i, j;
   initial
     begin
       for(i=0;i<1000;i++)
         begin
           #50 SerClock = ~SerClock;
         end
     end

  initial
    begin
      $display("-----------------------------------------------------------------------------------------------------\n");
      
      BusIn = 'h1111_6666;
      ParValid = 1'b0;
      
      $display($time, " Clk=%b, ParValid=%b, BusIn=%b, SerValidFlag=%b, SerOut=%b", SerClock, ParValid, BusIn, SerValidFlag, SerOut);
      @(posedge SerClock);
      
      ParValid = 1'b1;
      @(posedge SerClock);
      $display($time, " Clk=%b, ParValid=%b, BusIn=%b, SerValidFlag=%b, SerOut=%b     STARTED", SerClock, ParValid, BusIn, SerValidFlag, SerOut);
      
      
      for(j=0;j<WIDTH;j=j+1)
        begin
          @(posedge SerClock);
          $display($time, " Clk=%b, ParValid=%b, BusIn=%b, SerValidFlag=%b, SerOut=%b", SerClock, ParValid, BusIn, SerValidFlag, SerOut);
        end

      
      @(posedge SerClock);
      $display($time, " Clk=%b, ParValid=%b, BusIn=%b, SerValidFlag=%b, SerOut=%b     FINISHED", SerClock, ParValid, BusIn, SerValidFlag, SerOut);
      
      
      $display("\n-----------------------------------------------------------------------------------------------------");
      
      $finish;
    end

endmodule
