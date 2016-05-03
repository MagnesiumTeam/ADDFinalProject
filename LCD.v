module LCD(monitorOrMissedScene, romContent, pill12And3Duration, clk, resetn, LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA);
input clk, resetn, monitorOrMissedScene; 
input [27:0] romContent;
input [11:0] pill12And3Duration; 
output LCD_ON, LCD_RS, LCD_EN, LCD_RW;
output [7:0] LCD_DATA;
wire CLK_400Hz; 
Clk400 Clk400LCD(clk, CLK_400Hz);
LCDController LCDControllerLCD(monitorOrMissedScene, romContent, pill12And3Duration, CLK_400Hz, resetn, LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA);

endmodule