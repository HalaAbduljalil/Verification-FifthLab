`timescale 1ns/100ps
`include "PLLsim.inc"

module VFO(input [1:0] AdjustFreq, input SampleCmd, Reset, output ClockOut);

  integer BaseDelay, VFO_Delta, VFO_MaxDelta, VFO_Delay;
  logic VFO_ClockOut=1'b0;
  
  assign ClockOut = VFO_ClockOut;
  
  always@(Reset, SampleCmd, VFO_ClockOut)
    if(Reset == 1'b1)
      begin
        BaseDelay = `VFOBaseDelay;
        VFO_Delta = `VFO_DelayDelta;
        VFO_MaxDelta = `VFO_MaxDelta;
        VFO_Delay = `VFOBaseDelay;
        VFO_ClockOut = 1'b0;
      end
    else if(SampleCmd == 1'b1)
      begin
        if((AdjustFreq > 2'b01) && (BaseDelay - VFO_MaxDelta < VFO_Delay))
          VFO_Delay = VFO_Delay - VFO_Delta;     // dec time inc freq
        
        else if((AdjustFreq < 2'b01) && (BaseDelay + VFO_MaxDelta > VFO_Delay))
          VFO_Delay = VFO_Delay + VFO_Delta;
      
      #VFO_Delay VFO_ClockOut <= ~VFO_ClockOut;
      end
    
endmodule
