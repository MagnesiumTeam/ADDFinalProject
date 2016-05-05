/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Prescription Reminder
*/

module PrescriptionReminder(resetSetLoadStart, toggleSwitches17To14, toggleSwitches13To10, clk, outputBits, demoOrRealMode,
							LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA, monitorOrMissedScene, pill12And3LEDs);
input clk, demoOrRealMode, monitorOrMissedScene; 
input [3:0] toggleSwitches17To14, resetSetLoadStart;
input [3:0] toggleSwitches13To10;
output [41:0] outputBits; 
output [7:0] LCD_DATA;
output [2:0] pill12And3LEDs; 
output LCD_ON, LCD_RS, LCD_EN, LCD_RW; 

wire bitFromOneSecondClock, clkFromInputWrapper, enableTimerFromInputWrapper, demoOrRealModeFromInputWrapper, monitorOrMissedSceneFromInputWrapper;
wire LCD_ONToWrapper, LCD_RSToWrapper, LCD_ENToWrapper, LCD_RWToWrapper; 
wire [41:0] bitsFromSevenSegDisp; 
wire [2:0] pill12And3LEDsToOutputWrapper, signalFromPillTakenRecorder;
wire [3:0] toggleSwitches17To14FromInputWrapper, toggleSwitches13To10FromInputWrapper, resetSetLoadStartFromInputWrapper, resetSetLoadStartFromButtonShaper, state;
wire [7:0] memoryAddressFromControl, LCD_DATAToWrapper;
wire [27:0] romContent, dataToStoreInRAM, ramContent, dataFromRAM;
wire [23:0] controlledToggleSwitchBits, bitsFromClock;
wire [13:0] idAndDurationFromSevenSeg;
wire [11:0] durationsFromNextPillMonitor;  

InputWrapper InputWrapperPR(monitorOrMissedScene, demoOrRealMode, resetSetLoadStart, toggleSwitches17To14, toggleSwitches13To10, clk, monitorOrMissedSceneFromInputWrapper, demoOrRealModeFromInputWrapper, resetSetLoadStartFromInputWrapper, toggleSwitches17To14FromInputWrapper, toggleSwitches13To10FromInputWrapper,  clkFromInputWrapper);

ButtonShaper ButtonShaperReset(resetSetLoadStartFromInputWrapper[3], resetSetLoadStartFromButtonShaper[3], clkFromInputWrapper);
ButtonShaper ButtonShaperSet(resetSetLoadStartFromInputWrapper[2], resetSetLoadStartFromButtonShaper[2], clkFromInputWrapper);
ButtonShaper ButtonShaperStart(resetSetLoadStartFromInputWrapper[1], resetSetLoadStartFromButtonShaper[1], clkFromInputWrapper);
ButtonShaper ButtonShaperPause(resetSetLoadStartFromInputWrapper[0], resetSetLoadStartFromButtonShaper[0], clkFromInputWrapper);

Control ControlPR(bitsFromClock, toggleSwitches17To14FromInputWrapper, toggleSwitches13To10FromInputWrapper, resetSetLoadStartFromButtonShaper, clkFromInputWrapper, controlledToggleSwitchBits, memoryAddressFromControl, state);

ROM ROMPR(memoryAddressFromControl, clkFromInputWrapper, romContent);

Clock ClockPR(demoOrRealModeFromInputWrapper, state, controlledToggleSwitchBits, clkFromInputWrapper, bitsFromClock);

NextPillMonitor NextPillMonitorPR(signalFromPillTakenRecorder, romContent, bitsFromClock, clkFromInputWrapper, state, durationsFromNextPillMonitor);

PillTakenRecorder PillTakenRecorderPR(state, resetSetLoadStartFromButtonShaper, romContent, durationsFromNextPillMonitor, clkFromInputWrapper, dataToStoreInRAM, signalFromPillTakenRecorder);

// monitorOrMissedSceneFromInputWrapper stands in for the wren bit. When it is 1 we're writing to the RAM but when it is 0 we are reading from the RAM
// so that when set the monitorOrMissedSceneFromInputWrapper toggle switch to 0 we should see the patient x misses on the LCD and when we set it to 1
// we should see patient: x on the LCD 28'd4567
 
RAM RAMPR(memoryAddressFromControl, clkFromInputWrapper, dataToStoreInRAM, 1, dataFromRAM);	

LCD LCDPR(dataFromRAM, monitorOrMissedSceneFromInputWrapper,romContent, durationsFromNextPillMonitor, clkFromInputWrapper, resetSetLoadStartFromInputWrapper[3], LCD_ONToWrapper, LCD_RSToWrapper, LCD_ENToWrapper, LCD_RWToWrapper, LCD_DATAToWrapper);

LEDControl LEDControlPR(clkFromInputWrapper, durationsFromNextPillMonitor, pill12And3LEDsToOutputWrapper);

SevenSegDisp SevenSegDispHHB(bitsFromClock[23:20], bitsFromSevenSegDisp[41:35]);
SevenSegDisp SevenSegDispLHB(bitsFromClock[19:16], bitsFromSevenSegDisp[34:28]);
SevenSegDisp SevenSegDispHMB(bitsFromClock[15:12], bitsFromSevenSegDisp[27:21]);
SevenSegDisp SevenSegDispLMB(bitsFromClock[11:8], bitsFromSevenSegDisp[20:14]);
SevenSegDisp SevenSegDispHSB(bitsFromClock[7:4], bitsFromSevenSegDisp[13:7]);
SevenSegDisp SevenSegDispLSB(bitsFromClock[3:0], bitsFromSevenSegDisp[6:0]);
 
OutputWrapper OutputWrapperPR(pill12And3LEDsToOutputWrapper, LCD_ONToWrapper, LCD_RSToWrapper, LCD_ENToWrapper, LCD_RWToWrapper, LCD_DATAToWrapper, bitsFromSevenSegDisp, pill12And3LEDs, LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA, outputBits);

endmodule
