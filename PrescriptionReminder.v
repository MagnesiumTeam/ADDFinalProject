/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Prescription Reminder
*/
module PrescriptionReminder(clk, reset, enableMedicine, alarm, selectMedicine);

input clk, reset, enableMedicine, alarm, selectMedicine;

wire buttonShapedReset, buttonShapedEnableMedicine, buttonShapedAlarm, buttonShapedSelectMedicine;

ButtonShaper ButtonShaperReset(reset, buttonShapedReset, clk);
ButtonShaper ButtonShaperEnableMedicine(enableMedicine, buttonShapedEnableMedicine, clk);
ButtonShaper ButtonShaperAlarm(alarm, buttonShapedAlarm, clk);
ButtonShaper ButtonShaperSelectMedicine(selectMedicine, buttonShapedSelectMedicine, clk);

endmodule

// Log April 14 2016
// Created the ButtonShaper instances