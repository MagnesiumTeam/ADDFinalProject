/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Clock
*/
module Clock(state, clockBitsIn, clk, clockBitsOut);
input [23:0] clockBitsIn;
input clk;
input [3:0] state;
output [23:0] clockBitsOut;

/*always @(posedge clk)
begin
	clockBitsOut <= clockBitsIn;
end*/

wire oneSecondClk;

//OneSecondTimer OneSecondTimerClock(4'd3, clk, oneSecondClk);

DigitModule DigitModuleHHB(clockBitsIn[23:20], 4'd1, clk, state, clockBitsOut[23:20]);
DigitModule DigitModuleLHB(clockBitsIn[19:16], 4'd2, clk, state, clockBitsOut[19:16]);
DigitModule DigitModuleHMB(clockBitsIn[15:12], 4'd5, clk, state, clockBitsOut[15:12]);
DigitModule DigitModuleLMB(clockBitsIn[11:8], 4'd9, clk, state, clockBitsOut[11:8]);
DigitModule DigitModuleHSB(clockBitsIn[7:4], 4'd5, clk, state, clockBitsOut[7:4]);
DigitModule DigitModuleLSB(clockBitsIn[3:0], 4'd9, clk, state, clockBitsOut[3:0]);

endmodule
