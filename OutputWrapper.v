/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Output Wrapper
*/
module OutputWrapper(pill12And3LEDsIn, LCD_ONIn, LCD_RSIn, LCD_ENIn, LCD_RWIn, LCD_DATAIn, bitsIn, pill12And3LEDsOut, LCD_ONOut, LCD_RSOut, LCD_ENOut, LCD_RWOut, LCD_DATAOut, bitsOut); 

input LCD_ONIn, LCD_RSIn, LCD_ENIn, LCD_RWIn;
input [2:0] pill12And3LEDsIn;
input [7:0] LCD_DATAIn;
input [41:0] bitsIn; 

output LCD_ONOut, LCD_RSOut, LCD_ENOut, LCD_RWOut;
output [2:0] pill12And3LEDsOut;
output [7:0] LCD_DATAOut;
output [41:0] bitsOut; 

assign bitsOut = bitsIn; 
assign LCD_ONOut = LCD_ONIn;
assign LCD_RSOut = LCD_RSIn;
assign LCD_ENOut = LCD_ENIn;
assign LCD_RWOut = LCD_RWIn;
assign LCD_DATAOut = LCD_DATAIn;
assign pill12And3LEDsOut = pill12And3LEDsIn;
endmodule 