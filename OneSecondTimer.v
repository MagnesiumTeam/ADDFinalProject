
/*
Name: Olanrewaju Gabriel Ibironke
Date: March 22, 2016
Project: CustomTimer
*/

module OneSecondTimer(clk, oneSecondClk);
output oneSecondClk;
input clk;

wire bitFromOneMilliSecond;

OneMilliSecondTimer OneMilliSecondTimerOST(clk, bitFromOneMilliSecond);
OneThousandCount OneThousandCountOST(bitFromOneMilliSecond, oneSecondClk);

endmodule
