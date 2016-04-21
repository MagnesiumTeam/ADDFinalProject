/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Clock
*/
module Clock(demoOrRealMode, state, clockBitsIn, clk, clockBitsOut);
input [23:0] clockBitsIn;
input clk, demoOrRealMode;
input [3:0] state;
output [23:0] clockBitsOut;
  
wire [23:0] currentBits;  
wire oneSecondClk, oneSecondClkExtended;

OneSecondTimer OneSecondTimerClock(demoOrRealMode, clk, oneSecondClk);
 
ButtonShaperLSB ButtonShaperLSBClock(oneSecondClk, oneSecondClkExtended, clk);

DigitModule DigitModuleHHB(currentBits, oneSecondClkExtended, 4'd6, clockBitsIn[23:20], 4'd1, clk, state, clockBitsOut[23:20]);
DigitModule DigitModuleLHB(currentBits, oneSecondClkExtended, 4'd5, clockBitsIn[19:16], 4'd2, clk, state, clockBitsOut[19:16]);
DigitModule DigitModuleHMB(currentBits, oneSecondClkExtended, 4'd4, clockBitsIn[15:12], 4'd5, clk, state, clockBitsOut[15:12]);
DigitModule DigitModuleLMB(currentBits, oneSecondClkExtended, 4'd3, clockBitsIn[11:8], 4'd9, clk, state, clockBitsOut[11:8]);
DigitModule DigitModuleHSB(currentBits, oneSecondClkExtended, 4'd2, clockBitsIn[7:4], 4'd5, clk, state, clockBitsOut[7:4]); 
DigitModuleLSB DigitModuleLSB(oneSecondClkExtended, 4'd1, clockBitsIn[3:0], 4'd9, clk, state, clockBitsOut[3:0]);

assign currentBits = clockBitsOut;
endmodule
