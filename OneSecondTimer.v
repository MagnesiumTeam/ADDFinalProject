/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: May 4, 2016
Project: One Second Timer
*/

module OneSecondTimer(demoOrRealMode, clk, oneSecondClk);
output oneSecondClk;
input clk, demoOrRealMode;

wire bitFromOneMilliSecond;

OneMilliSecondTimer OneMilliSecondTimerOST(demoOrRealMode, clk, bitFromOneMilliSecond);
OneThousandCount OneThousandCountOST(bitFromOneMilliSecond, oneSecondClk);

endmodule
