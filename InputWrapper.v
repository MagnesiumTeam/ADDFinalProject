/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Input Wrapper
*/
module InputWrapper(resetSetLoadStartIn, toggleSwitches17To14In, toggleSwitches13To6In, clkIn, resetSetLoadStartOut, toggleSwitches17To14Out, toggleSwitches13To6Out, clkOut);

input clkIn;
input [3:0] toggleSwitches17To14In, resetSetLoadStartIn; 
input [7:0] toggleSwitches13To6In;
output clkOut;
output [3:0] toggleSwitches17To14Out, resetSetLoadStartOut; 
output [7:0] toggleSwitches13To6Out;

assign clkOut = clkIn;
assign toggleSwitches17To14Out = toggleSwitches17To14In; 
assign resetSetLoadStartOut = resetSetLoadStartIn;
assign toggleSwitches13To6Out = toggleSwitches13To6In;

endmodule
