
module testbench;

logic ClockIn, Reset, Sample;
wire ClockOut;
reg i;

ToplvlModule PLL (.ClockIn(ClockIn), .Reset(Reset), .Sample(Sample), .ClockOut(ClockOut));
	
initial
     begin
       $monitor($time, "ClockOut=%b,ClockIn=%b,Reset=%b,Sample=%b", ClockOut,ClockIn,Reset,Sample);
 
       Reset=1'b1;
       ClockIn=1'b0; 
       Sample=1'b0;
        
       for(int i=0;i<50;i++)
         begin
           #15 ClockIn = ~ClockIn;
         end
       Reset=1'b0;
       for(int i=0;i<50;i++)
         begin
           #20 ClockIn = ~ClockIn;
       end
       
       for(int i=0;i<50;i++)
         begin
           #25 ClockIn = ~ClockIn;
       end
       
       Sample = 1;
      $display("-----------------------------sample on-------------------------------------");
        for(int i=0;i<50;i++)
         begin
           #15 ClockIn = ~ClockIn;
         end
       
       for(int i=0;i<50;i++)
         begin
           #20 ClockIn = ~ClockIn;
       end
       
       for(int i=0;i<50;i++)
         begin
           #25 ClockIn = ~ClockIn;
       end
       $finish;
     end
  
    
   
endmodule