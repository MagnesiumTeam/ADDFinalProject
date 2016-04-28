/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Output Wrapper
*/
module OutputWrapper(LCD_ONIn, LCD_RSIn, LCD_ENIn, LCD_RWIn, LCD_DATAIn, bitsIn, idAndDurationIn, bitsOut, idAndDurationOut, LCD_ONOut, LCD_RSOut, LCD_ENOut, LCD_RWOut, LCD_DATAOut);
input [41:0] bitsIn;
input [13:0] idAndDurationIn;
input LCD_ONIn, LCD_RSIn, LCD_ENIn, LCD_RWIn;
input [7:0] LCD_DATAIn;

output [41:0] bitsOut;
output [13:0] idAndDurationOut;
output LCD_ONOut, LCD_RSOut, LCD_ENOut, LCD_RWOut;
output [7:0] LCD_DATAOut;

assign bitsOut = bitsIn;
assign idAndDurationOut = idAndDurationIn;
assign LCD_ONOut = LCD_ONIn;
assign LCD_RSOut = LCD_RSIn;
assign LCD_ENOut = LCD_ENIn;
assign LCD_RWOut = LCD_RWIn;
assign LCD_DATAOut = LCD_DATAIn;
endmodule 