/*
Name: Olanrewaju Gabriel Ibironke
Date: March 22, 2016
Project: CustomTimer
*/

module OneSecondTimer(enableTimer, clk, oneSecondClk);
input enableTimer, clk;
output oneSecondClk;

wire bitFromOneMilliSecond;

OneMilliSecondTimer OneMilliSecondTimerOST(enableTimer, clk, bitFromOneMilliSecond);
OneThousandCount OneThousandCountOST(bitFromOneMilliSecond, oneSecondClk);

endmodule