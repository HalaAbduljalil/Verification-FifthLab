`include "PLLsim.inc"

module ToplvlModule(input ClockIn, Reset, Sample, output ClockOut);
	wire [1:0] clockcomparator_out;
  wire VFO_out, multicounter_out;
  
 
  assign ClockOut = VFO_out;
  
  // instantiation
  Comparator clk_comp(.ClockIn(ClockIn), .Reset(Reset), .PLLClock(multicounter_out), .AdjustFreq(clockcomparator_out));
  VFO vfo_comp(.AdjustFreq(clockcomparator_out), .SampleCmd(Sample), .Reset(Reset), .ClockOut(VFO_out));
  MultiCounter multicounter_comp(.Clock(VFO_out), .Reset(Reset), .CarryOut(multicounter_out));
  
  
endmodule
