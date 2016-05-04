
/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: May 4, 2016
Project: LCD Module
*/

module LCD(dataFromRAM, monitorOrMissedScene, romContent, pill12And3Duration, clk, resetn, LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA);
input clk, resetn, monitorOrMissedScene; 
input [27:0] romContent, dataFromRAM;
input [11:0] pill12And3Duration; 
output LCD_ON, LCD_RS, LCD_EN, LCD_RW;
output [7:0] LCD_DATA;
wire clkOneMilliSecond; 
OneMilliSecondClk OneMilliSecondClkLCD(clk, clkOneMilliSecond);
LCDController LCDControllerLCD(dataFromRAM, monitorOrMissedScene, romContent, pill12And3Duration, clkOneMilliSecond, resetn, LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA);

endmodule