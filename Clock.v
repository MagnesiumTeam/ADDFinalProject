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

//wire oneSecondClk;
wire otherBitsMove;
wire [5:0] fromLSB, fromHSB, fromLMB, fromHMB, fromLHB, fromHHB;
wire [25:0] rCountFromLSB;
wire [23:0] currentBits;

//OneSecondTimer OneSecondTimerClock(4'd3, clk, oneSecondClk);

DigitModule DigitModuleHHB(currentBits, otherBitsMove, rCountFromLSB, fromLHB, 4'd6, clockBitsIn[23:20], 4'd1, clk, state, clockBitsOut[23:20], fromHHB);
DigitModule DigitModuleLHB(currentBits, otherBitsMove, rCountFromLSB, fromHMB, 4'd5, clockBitsIn[19:16], 4'd2, clk, state, clockBitsOut[19:16], fromLHB);
DigitModule DigitModuleHMB(currentBits, otherBitsMove, rCountFromLSB, fromLMB, 4'd4, clockBitsIn[15:12], 4'd5, clk, state, clockBitsOut[15:12], fromHMB);
DigitModule DigitModuleLMB(currentBits, otherBitsMove, rCountFromLSB, fromHSB, 4'd3, clockBitsIn[11:8], 4'd9, clk, state, clockBitsOut[11:8], fromLMB);
DigitModule DigitModuleHSB(currentBits, otherBitsMove, rCountFromLSB, fromLSB, 4'd2, clockBitsIn[7:4], 4'd5, clk, state, clockBitsOut[7:4], fromHSB);
DigitModuleLSB DigitModuleLSB(6'b000001, 4'd1, clockBitsIn[3:0], 4'd9, clk, state, clockBitsOut[3:0], fromLSB, rCountFromLSB, otherBitsMove);

assign currentBits = clockBitsOut;
endmodule
