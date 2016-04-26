/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Prescription Reminder
*/

module PrescriptionReminder(resetSetLoadStart, toggleSwitches17To14, toggleSwitches13To10, clk, outputBits, idAndDuration, demoOrRealMode);
input clk, demoOrRealMode;
input [3:0] toggleSwitches17To14, resetSetLoadStart;
input [3:0] toggleSwitches13To10;
output [41:0] outputBits;
output [13:0] idAndDuration;

wire bitFromOneSecondClock, clkFromInputWrapper, enableTimerFromInputWrapper, demoOrRealModeFromInputWrapper;
wire [41:0] bitsFromSevenSegDisp; 
wire [3:0] toggleSwitches17To14FromInputWrapper, toggleSwitches13To10FromInputWrapper, resetSetLoadStartFromInputWrapper, resetSetLoadStartFromButtonShaper, state, nextPill, toBeTakenInTheNextXHour;
wire [7:0] romAddressFromControl;
wire [27:0] romContent;
wire [23:0] controlledToggleSwitchBits, bitsFromClock;
wire [13:0] idAndDurationFromSevenSeg;

InputWrapper InputWrapperPR(demoOrRealMode, resetSetLoadStart, toggleSwitches17To14, toggleSwitches13To10, clk, demoOrRealModeFromInputWrapper, resetSetLoadStartFromInputWrapper, toggleSwitches17To14FromInputWrapper, toggleSwitches13To10FromInputWrapper,  clkFromInputWrapper);

ButtonShaper ButtonShaperReset(resetSetLoadStartFromInputWrapper[3], resetSetLoadStartFromButtonShaper[3], clkFromInputWrapper);
ButtonShaper ButtonShaperSet(resetSetLoadStartFromInputWrapper[2], resetSetLoadStartFromButtonShaper[2], clkFromInputWrapper);
ButtonShaper ButtonShaperStart(resetSetLoadStartFromInputWrapper[1], resetSetLoadStartFromButtonShaper[1], clkFromInputWrapper);
ButtonShaper ButtonShaperPause(resetSetLoadStartFromInputWrapper[0], resetSetLoadStartFromButtonShaper[0], clkFromInputWrapper);

Control ControlPR(bitsFromClock, toggleSwitches17To14FromInputWrapper, toggleSwitches13To10FromInputWrapper, resetSetLoadStartFromButtonShaper, clkFromInputWrapper, controlledToggleSwitchBits, romAddressFromControl, state);

ROM ROMPR(romAddressFromControl, clkFromInputWrapper, romContent);

Clock ClockPR(demoOrRealModeFromInputWrapper, state, controlledToggleSwitchBits, clkFromInputWrapper, bitsFromClock);

NextPillMonitor NextPillMonitorPR(romContent, bitsFromClock[23:16], clkFromInputWrapper, state, nextPill, toBeTakenInTheNextXHour);

SevenSegDisp SevenSegDispHHB(bitsFromClock[23:20], bitsFromSevenSegDisp[41:35]);
SevenSegDisp SevenSegDispLHB(bitsFromClock[19:16], bitsFromSevenSegDisp[34:28]);
SevenSegDisp SevenSegDispHMB(bitsFromClock[15:12], bitsFromSevenSegDisp[27:21]);
SevenSegDisp SevenSegDispLMB(bitsFromClock[11:8], bitsFromSevenSegDisp[20:14]);
SevenSegDisp SevenSegDispHSB(bitsFromClock[7:4], bitsFromSevenSegDisp[13:7]);
SevenSegDisp SevenSegDispLSB(bitsFromClock[3:0], bitsFromSevenSegDisp[6:0]);


SevenSegDisp SevenSegDispID(nextPill, idAndDurationFromSevenSeg[13:7]);
SevenSegDisp SevenSegDispDuration(toBeTakenInTheNextXHour, idAndDurationFromSevenSeg[6:0]);

OutputWrapper OutputWrapperPR(bitsFromSevenSegDisp, idAndDurationFromSevenSeg, outputBits, idAndDuration);

endmodule
