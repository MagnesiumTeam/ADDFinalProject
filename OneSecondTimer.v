/*
Name: Olanrewaju Gabriel Ibironke
Date: March 22, 2016
Project: CustomTimer
*/

module OneSecondTimer(state, clk, oneSecondClk);
input clk;
input [3:0] state;
output oneSecondClk;

wire bitFromOneMilliSecond;

OneMilliSecondTimer OneMilliSecondTimerOST(state, clk, bitFromOneMilliSecond);
OneThousandCount OneThousandCountOST(bitFromOneMilliSecond, oneSecondClk);

endmodule