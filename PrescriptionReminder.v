/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Prescription Reminder
*/

module PrescriptionReminder(resetSetLoadStart, toggleSwitches17To14, toggleSwitches13To6, clk, outputBits, idAndDuration);
input clk;
input [3:0] toggleSwitches17To14, resetSetLoadStart;
input [7:0] toggleSwitches13To6;
output [41:0] outputBits;
output [13:0] idAndDuration;

wire bitFromOneSecondClock, clkFromInputWrapper, enableTimerFromInputWrapper;
wire [41:0] bitsFromSevenSegDisp;
//wire [3:0] bitsFromOneToFourBits;
wire [3:0] toggleSwitches17To14FromInputWrapper, resetSetLoadStartFromInputWrapper, resetSetLoadStartFromButtonShaper;
wire [7:0] toggleSwitches13To6FromInputWrapper, romAddressFromControl, romContent;
wire [23:0] controlledToggleSwitchBits;
wire [13:0] idAndDurationFromSevenSeg;

InputWrapper InputWrapperPR(resetSetLoadStart, toggleSwitches17To14, toggleSwitches13To6, clk, resetSetLoadStartFromInputWrapper, toggleSwitches17To14FromInputWrapper, toggleSwitches13To6FromInputWrapper,  clkFromInputWrapper);

ButtonShaper ButtonShaperReset(resetSetLoadStartFromInputWrapper[3], resetSetLoadStartFromButtonShaper[3], clkFromInputWrapper);
ButtonShaper ButtonShaperSet(resetSetLoadStartFromInputWrapper[2], resetSetLoadStartFromButtonShaper[2], clkFromInputWrapper);
ButtonShaper ButtonShaperStart(resetSetLoadStartFromInputWrapper[1], resetSetLoadStartFromButtonShaper[1], clkFromInputWrapper);
ButtonShaper ButtonShaperPause(resetSetLoadStartFromInputWrapper[0], resetSetLoadStartFromButtonShaper[0], clkFromInputWrapper);

Control ControlPR(toggleSwitches17To14FromInputWrapper, toggleSwitches13To6FromInputWrapper, resetSetLoadStartFromButtonShaper, clkFromInputWrapper, controlledToggleSwitchBits, romAddressFromControl);

//OneSecondTimer OneSecondTimerPR(enableTimerFromInputWrapper, clkFromInputWrapper, bitFromOneSecondClock);

//OneBitToFourBits OneBitToFourBitsPR(bitFromOneSecondClock, bitsFromOneToFourBits);

//SevenSegDisp SevenSegDispPR(bitsFromOneToFourBits, bitsFromSevenSegDisp);

ROM ROMPR(romAddressFromControl, clkFromInputWrapper, romContent);

SevenSegDisp SevenSegDispHHB(controlledToggleSwitchBits[23:20], bitsFromSevenSegDisp[41:35]);
SevenSegDisp SevenSegDispLHB(controlledToggleSwitchBits[19:16], bitsFromSevenSegDisp[34:28]);
SevenSegDisp SevenSegDispHMB(controlledToggleSwitchBits[15:12], bitsFromSevenSegDisp[27:21]);
SevenSegDisp SevenSegDispLMB(controlledToggleSwitchBits[11:8], bitsFromSevenSegDisp[20:14]);
SevenSegDisp SevenSegDispHSB(controlledToggleSwitchBits[7:4], bitsFromSevenSegDisp[13:7]);
SevenSegDisp SevenSegDispLSB(controlledToggleSwitchBits[3:0], bitsFromSevenSegDisp[6:0]);


SevenSegDisp SevenSegDispID(romContent[7:4], idAndDurationFromSevenSeg[13:7]);
SevenSegDisp SevenSegDispDuration(romContent[3:0], idAndDurationFromSevenSeg[6:0]);

OutputWrapper OutputWrapperPR(bitsFromSevenSegDisp, idAndDurationFromSevenSeg, outputBits, idAndDuration);

endmodule
