
/*
Name: Olanrewaju Gabriel Ibironke
Date: March 22, 2016
Project: CustomTimer
*/

module OneSecondTimer(demoOrRealMode, clk, oneSecondClk);
output oneSecondClk;
input clk, demoOrRealMode;

wire bitFromOneMilliSecond;

OneMilliSecondTimer OneMilliSecondTimerOST(demoOrRealMode, clk, bitFromOneMilliSecond);
OneThousandCount OneThousandCountOST(bitFromOneMilliSecond, oneSecondClk);

endmodule
