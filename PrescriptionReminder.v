/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Prescription Reminder
*/

module PrescriptionReminder(resetSetLoadStart, toggleSwitches17To14, toggleSwitches13To6, clk, outputBits, idAndDuration, demoOrRealMode);
input clk, demoOrRealMode;
input [3:0] toggleSwitches17To14, resetSetLoadStart;
input [7:0] toggleSwitches13To6;
output [41:0] outputBits;
output [13:0] idAndDuration;

wire bitFromOneSecondClock, clkFromInputWrapper, enableTimerFromInputWrapper, demoOrRealModeFromInputWrapper;
wire [41:0] bitsFromSevenSegDisp;
//wire [3:0] bitsFromOneToFourBits;
wire [3:0] toggleSwitches17To14FromInputWrapper, resetSetLoadStartFromInputWrapper, resetSetLoadStartFromButtonShaper, state;
wire [7:0] toggleSwitches13To6FromInputWrapper, romAddressFromControl, romContent;
wire [23:0] controlledToggleSwitchBits, bitsFromClock;
wire [13:0] idAndDurationFromSevenSeg;

InputWrapper InputWrapperPR(demoOrRealMode, resetSetLoadStart, toggleSwitches17To14, toggleSwitches13To6, clk, demoOrRealModeFromInputWrapper, resetSetLoadStartFromInputWrapper, toggleSwitches17To14FromInputWrapper, toggleSwitches13To6FromInputWrapper,  clkFromInputWrapper);

ButtonShaper ButtonShaperReset(resetSetLoadStartFromInputWrapper[3], resetSetLoadStartFromButtonShaper[3], clkFromInputWrapper);
ButtonShaper ButtonShaperSet(resetSetLoadStartFromInputWrapper[2], resetSetLoadStartFromButtonShaper[2], clkFromInputWrapper);
ButtonShaper ButtonShaperStart(resetSetLoadStartFromInputWrapper[1], resetSetLoadStartFromButtonShaper[1], clkFromInputWrapper);
ButtonShaper ButtonShaperPause(resetSetLoadStartFromInputWrapper[0], resetSetLoadStartFromButtonShaper[0], clkFromInputWrapper);

Control ControlPR(bitsFromClock, toggleSwitches17To14FromInputWrapper, toggleSwitches13To6FromInputWrapper, resetSetLoadStartFromButtonShaper, clkFromInputWrapper, controlledToggleSwitchBits, romAddressFromControl, state);

//OneSecondTimer OneSecondTimerPR(state, clkFromInputWrapper, bitFromOneSecondClock);

//OneBitToFourBits OneBitToFourBitsPR(bitFromOneSecondClock, bitsFromOneToFourBits);

//SevenSegDisp SevenSegDispPR(bitsFromOneToFourBits, bitsFromSevenSegDisp);

ROM ROMPR(romAddressFromControl, clkFromInputWrapper, romContent);

Clock ClockPR(demoOrRealModeFromInputWrapper, state, controlledToggleSwitchBits, clkFromInputWrapper, bitsFromClock);

SevenSegDisp SevenSegDispHHB(bitsFromClock[23:20], bitsFromSevenSegDisp[41:35]);
SevenSegDisp SevenSegDispLHB(bitsFromClock[19:16], bitsFromSevenSegDisp[34:28]);
SevenSegDisp SevenSegDispHMB(bitsFromClock[15:12], bitsFromSevenSegDisp[27:21]);
SevenSegDisp SevenSegDispLMB(bitsFromClock[11:8], bitsFromSevenSegDisp[20:14]);
SevenSegDisp SevenSegDispHSB(bitsFromClock[7:4], bitsFromSevenSegDisp[13:7]);
SevenSegDisp SevenSegDispLSB(bitsFromClock[3:0], bitsFromSevenSegDisp[6:0]);


SevenSegDisp SevenSegDispID(romContent[7:4], idAndDurationFromSevenSeg[13:7]);
SevenSegDisp SevenSegDispDuration(romContent[3:0], idAndDurationFromSevenSeg[6:0]);

OutputWrapper OutputWrapperPR(bitsFromSevenSegDisp, idAndDurationFromSevenSeg, outputBits, idAndDuration);

endmodule
