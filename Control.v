/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Control Module

- Receives the reset, set, stop & start bits as well as the bits from toggle switches 17 through 6
- If the reset bit is 1 it sets all the clock digits to zero as in: 00 00 00 and sends out a enableTimer of 3'd0 to the receiving module as well as resets
the timeDigitSetCount to 4'd0
- If the reset bit is 0 it checks the remaining bits starting with the set bit
- If the set bit is 1 it evaluates the digit to set starting from the most significant hour bit i.e. 1 in the time 12 59 59
- In the evaluation it checks if the toggle switch bits is greater than the maximum a clock can allow if it is it sets it to the maximum, if not it passes the toggle switch bits to the output.
- Note that in each of the evaluation it increments the timeDigitSetCount variable which helps us use 4 toggle switches 6 times to set the 6 bits of a real clock.
- the enableTimer is set to 4'd1
- The Load Patient ID sets the enableTimer to 4'd2 which uses the bits in the toggle switches to pull the ID of the patient in question
- The Start sets the enableTimer to 4'd3 which corresponds to the start state
- Finally the Stop sets the enableTimer to 3'd3 which corresponds to the stop state. A enableTimer of 3'd4 is an exception state
*/


module Control(toggleSwitches17To14, toggleSwitches13To6, resetSetLoadStart, clk, controlledToggleSwitchBits, outputToROM, state);
input clk;
input [3:0] resetSetLoadStart;
input [3:0] toggleSwitches17To14;
input [7:0] toggleSwitches13To6;
output reg [23:0] controlledToggleSwitchBits;
output reg [3:0] state;
output reg [7:0] outputToROM;

reg [3:0] timeDigitSetCount;		// determines which bit to set in the hh mm ss bits of the clock
reg disableSetLoadStart;

always @(posedge clk)
begin
	if(resetSetLoadStart[3] == 1'b1)begin
		controlledToggleSwitchBits[23:20] <= 4'd0;
		controlledToggleSwitchBits[19:16] <= 4'd0;
		controlledToggleSwitchBits[15:12] <= 4'd0;
		controlledToggleSwitchBits[11:8] <= 4'd0;
		controlledToggleSwitchBits[7:4] <= 4'd0;
		controlledToggleSwitchBits[3:0] <= 4'd0;
		state <= 4'd0;								// 4'd0 stands for the reset state
		timeDigitSetCount <= 4'd0;
		disableSetLoadStart <= 0;
	end
	else begin
		if(resetSetLoadStart[2] == 1'b1)begin				// Check which of the set Load and start push buttons was depressed
			if(disableSetLoadStart <= 0)begin
				if(timeDigitSetCount == 4'd0)begin				// Evaluate the digit to set

					if(toggleSwitches17To14[3:0] > 4'd1)begin // Essence: the maximum time is 12:59:59
						controlledToggleSwitchBits[23:20] <= 4'd1;
					end
					else begin
						controlledToggleSwitchBits[23:20] <= toggleSwitches17To14[3:0];
					end

					timeDigitSetCount <= timeDigitSetCount + 4'd1;
				end
				else if(timeDigitSetCount == 4'd1) begin

					if(toggleSwitches17To14[3:0] > 4'd2)begin // Essence: the maximum time is 12:59:59
						controlledToggleSwitchBits[19:16] <= 4'd2;
					end
					else begin
						controlledToggleSwitchBits[19:16] <= toggleSwitches17To14[3:0];
					end

					timeDigitSetCount <= timeDigitSetCount + 4'd1;
				end
				else if(timeDigitSetCount == 4'd2) begin

					if(toggleSwitches17To14[3:0] > 4'd5)begin // Essence: the maximum time is 12:59:59
						controlledToggleSwitchBits[15:12] <= 4'd5;
					end
					else begin
						controlledToggleSwitchBits[15:12] <= toggleSwitches17To14[3:0];
					end

					timeDigitSetCount <= timeDigitSetCount + 4'd1;
				end
				else if (timeDigitSetCount == 4'd3) begin

					if(toggleSwitches17To14[3:0] > 4'd9)begin // Essence: the maximum time is 12:59:59
						controlledToggleSwitchBits[11:8] <= 4'd9;
					end
					else begin
						controlledToggleSwitchBits[11:8] <= toggleSwitches17To14[3:0];
					end

					timeDigitSetCount <= timeDigitSetCount + 4'd1;
				end
				else if(timeDigitSetCount == 4'd4) begin

					if(toggleSwitches17To14[3:0] > 4'd5)begin // Essence: the maximum time is 12:59:59
						controlledToggleSwitchBits[7:4] <= 4'd5;
					end
					else begin
						controlledToggleSwitchBits[7:4] <= toggleSwitches17To14[3:0];
					end

					timeDigitSetCount <= timeDigitSetCount + 4'd1;
				end
				else if(timeDigitSetCount == 4'd5) begin

					if(toggleSwitches17To14[3:0] > 4'd9)begin // Essence: the maximum time is 12:59:59
						controlledToggleSwitchBits[3:0] <= 4'd9;
					end
					else begin
						controlledToggleSwitchBits[3:0] <= toggleSwitches17To14[3:0];
					end

					timeDigitSetCount <= 4'd0;
				end
				else begin
					timeDigitSetCount <= 4'd0;
				end

				state <= 4'd1;							// 4'd1 stands for the state that sets the clock
			end
		end
		else if(resetSetLoadStart[1] == 1'b1)begin
			if(disableSetLoadStart <= 0)begin
				outputToROM <= toggleSwitches13To6;
				state <= 4'd2;							// 4'd2 stands for the state that loads the Patient address from the ROM
			end
		end
		else if(resetSetLoadStart[0] == 1'b1)begin
			if(disableSetLoadStart <= 0)begin
				state <= 4'd3;							// 4'd3 stands for the state that starts the clock
				disableSetLoadStart <= 1;
			end
		end
		else begin
			state <= 4'd4;								// 4'd4 stands for the default state;
		end
	end
end

endmodule

// Log April 15 2016 9:10pm
// The start disables the set and load toggle switches
// The reset enables the set and load toggle switches