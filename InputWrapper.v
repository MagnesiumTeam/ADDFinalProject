/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Input Wrapper
*/
module InputWrapper(demoOrRealModeIn, resetSetLoadStartIn, toggleSwitches17To14In, toggleSwitches13To10In, clkIn, demoOrRealModeOut, resetSetLoadStartOut, toggleSwitches17To14Out, toggleSwitches13To10Out, clkOut);

input clkIn, demoOrRealModeIn;
input [3:0] toggleSwitches17To14In, resetSetLoadStartIn; 
input [3:0] toggleSwitches13To10In;
output clkOut, demoOrRealModeOut;
output [3:0] toggleSwitches17To14Out, resetSetLoadStartOut; 
output [3:0] toggleSwitches13To10Out;

assign clkOut = clkIn;
assign demoOrRealModeOut = demoOrRealModeIn;
assign toggleSwitches17To14Out = toggleSwitches17To14In; 
assign resetSetLoadStartOut = resetSetLoadStartIn;
assign toggleSwitches13To10Out = toggleSwitches13To10In;

endmodule
