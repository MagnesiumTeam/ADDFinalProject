/*
Name: Olanrewaju Gabriel Ibironke
Date: March 21, 2016
Project: Digit Module
*/

module DigitModule(currentBits, canIMove, rCount, toDigit, identity, setBits, maximumBits, clk, state, outputBits, fromDigit);
input clk, canIMove;
input [3:0] state, identity; 
/*
for identity
LSB = 4'd1;
HSB = 4'd2;
LMB = 4'd3;
HMB = 4'd4;
LHB = 4'd5;
HHB = 4'd6;
*/		
input [5:0] toDigit;	
input [23:0] currentBits;	
input [3:0] maximumBits, setBits; 
input [25:0] rCount;
output [3:0] outputBits;
output reg [5:0] fromDigit;

reg [3:0] count;

parameter sReset = 4'd0, sSet = 4'd1, sStart = 4'd3;

reg [3:0] nextState;

always @(posedge clk)							// at the positive edge of the clock									
begin
	if(state == 4'd0) begin  					// if the button pushed represents reset (note as soon as the hand is released from the pb the state goes to 4'd4) 
		nextState <= sReset; 					// go to the sReset case evaluation
	end
	else begin 									// if the reset button has been released
		case(nextState)							// what is the next state?
			sReset:begin						// if the next state is reset
				count <= 4'd0;					// set the digits minus the LSB to 0
				if(state == 4'd0)begin			// if the last button pushed was the reset button
					nextState <= sReset;		// go to the sReset case evaluation
				end
				else if(state == 4'd1)begin		// if the last button pushed was the set button
					nextState <= sSet;			// go to the sSet case evaluation
				end
				else if(state == 4'd3)begin 	// if the last button pushed was the start button
					nextState <= sStart;		// go to the sStart case evaluation
				end
			end
			sSet:begin 							// if the next state is set
				count <= setBits; 				// set the digits minus the LSB to the value on the setBits variable as passed by the Control module
				if(state == 4'd0)begin 			// if the last button pushed was the reset button
					nextState <= sReset; 		// go to the sReset case evaluation
				end
				else if(state == 4'd1)begin 	// if the last button pushed was the set button
					nextState <= sSet; 			// go to the sSet case evaluation
				end 						
				else if(state == 4'd3)begin		// if the last button pushed was the start button
					nextState <= sStart; 		// go to the sStart case evaluation
				end
			end
			sStart:begin
				if(identity == 4'd2)begin										// If I am HSB

					if(toDigit[1] == 1)begin									// and LSB has reached its penultimate number
						if(canIMove == 1)begin									// If I have the permission to change as triggered by the LSB
							if(rCount == 49999999) begin 						// and I am at the 49999999th clock 
								if(count == maximumBits)begin					// then if my current value is the maximum number I can take,
									count <= 4'd0;								// set my current value back to zero
									fromDigit <= 6'b000000;						// and tell LMB to maintain its value
								end
								else if(count == (maximumBits - 4'd1))begin 	// if my current value is the penultimate number I can take
									count <= count + 4'd1;						// increment my current value by 1 
									fromDigit <= 6'b000100;						// and tell LMB to increment its value as well
								end
								else begin										// if my current value is neither the penultimate or maximum number
									count <= count + 4'd1;						// increment my current value by 1
									fromDigit <= 6'b000000;						// and tell LMB to maintain its value
								end
							end
						end
					end
				end
				else if(identity == 4'd3)begin 									// If I am LMB

					if(toDigit[2] == 1)begin 									// and HSB has reached its penultimate number
						if(canIMove == 1)begin 									// If I have the permission to change as triggered by the LSB
							if(rCount == 49999999) begin 						// and I am at the 49999999th clock
								if(count == maximumBits)begin 					// then if my current value is the maximum number I can take,
									count <= 4'd0;								// set my current value back to zero
									fromDigit <= 6'b000000; 					// and tell HMB to maintain its value;
								end
								else if(count == (maximumBits - 4'd1))begin 	// if my current value is the penultimate number I can take
									count <= count + 4'd1; 						// increment my current value by 1
									fromDigit <= 6'b001000;						// and tell HMB to increment its value as well
								end
								else begin										// if my current value is neither the penultimate or maximum number
									count <= count + 4'd1; 						// increment my current value by 1
									fromDigit <= 6'b000000;						// and tell HMB to maintain its value
								end
							end
						end
					end
					else begin													// if by chance I as LMB missed the timing that requires a current value change
						if(currentBits[7:4] == 4'd5)begin 						// if HSB is at its maximum value
							if(canIMove == 1)begin								// and I have the permission from LSB to move
								if(rCount == 49999999)begin						// If the current count of the LSB clock is at its 1 second mark
									if(currentBits[11:8] == 4'd9)begin			// and I am at my maximum number
										count <= 4'd0;							// then I should go back to zero because I can't be greater than my maximum number
									end
									else begin									// if I am not at my maximum
										count <= count + 4'd1;					// then this is the perfect time to increment by 1
									end
								end
							end
						end
					end
				end
				else if(identity == 4'd4)begin									// If I am HMB

					if(toDigit[3] == 1)begin									// and LMB has reached its penultimate number
						if(canIMove == 1)begin 									// If I have the permission to change as triggered by the LSB
							if(rCount == 49999999) begin 						// and I am at the 49999999th clock
								if(count == maximumBits)begin 					// then if my current value is the maximum number I can take
									count <= 4'd0; 								// set my current value back to zero
									fromDigit <= 6'b000000; 					// and tell LHB to maintain its value
								end
								else if(count == (maximumBits - 4'd1))begin  	// if my current value is the penultimate number I can take
									count <= count + 4'd1; 						// increment my current value by 1
									fromDigit <= 6'b010000;						// and tell LHB to increment its value as well
								end
								else begin										// if my current value is neither the penultimate or maximum number
									count <= count + 4'd1;						// increment my current value by 1
									fromDigit <= 6'b000000;						// and tell LHB to maintain its value
								end
							end
						end
					end
					else begin													// if by chance I as HMB missed the timing that requires a current value change
						if(currentBits[11:8] == 4'd9)begin 						// if LMB is at its maximum value
							if(canIMove == 1)begin 								// and I have the permission from LSB to move
								if(rCount == 49999999)begin 					// If the current count of the LSB clock is at its 1 second mark
									if(currentBits[15:12] == 4'd5)begin 		// and I am at my maximum number
										count <= 4'd0;	 						// then I should go back to zero because I can't be greater than my maximum number
									end
									else begin 									// if I am not at my maximum
										count <= count + 4'd1;					// then this is the perfect time to increment by 1
									end
								end
							end
						end
					end
				end 
				else if(identity == 4'd5)begin  								// If I am LHB

					if(toDigit[4] == 1)begin 									// and HMB has reached its penultimate number
						if(canIMove == 1)begin 									// If I have the permission to change as triggered by the LSB
							if(rCount == 49999999) begin 						// and I am at the 49999999th clock
								if(count == maximumBits)begin					// then if my current value is the maximum number I can take
									count <= 4'd0; 								// set my current value back to zero
									fromDigit <= 6'b000000; 					// and tell HHB to maintain its value
								end
								else if(count == (maximumBits - 4'd1))begin		// if my current value is the penultimate number I can take
									count <= count + 4'd1; 						// increment my current value by 1
									fromDigit <= 6'b100000; 					// and tell HHB to increment its value as well
								end
								else begin										// if my current value is neither the penultimate or maximum number
									count <= count + 4'd1; 						// increment my current value by 1
									fromDigit <= 6'b000000; 					// and tell HHB to maintain its value
								end
							end
						end
					end
					else begin													// if by chance I as LHB missed the timing that requires a current value change
						if(canIMove == 1)begin  								// and I have the permission from LSB to move
							if(rCount == 49999999)begin 						// If the current count of the LSB clock is at its 1 second mark
								if(currentBits[23:20] == 4'd1 && currentBits[19:16] == 4'd2 && currentBits[15:12] == 4'd5 && currentBits[11:8] == 4'd9 && currentBits[7:4] == 4'd5 && currentBits[3:0] == 9)begin // addresses 12:59:59
									count <= 4'd1;	
								end
								else if(currentBits[23:20] == 4'd0 && currentBits[19:16] == 4'd9 && currentBits[15:12] == 4'd5 && currentBits[11:8] == 4'd9 && currentBits[7:4] == 4'd5 && currentBits[3:0] == 9)begin // addresses 09:59:59
									count <= 4'd0;	
								end
								else begin
									count <= count + 4'd1;	
								end
							end
						end
					end
				end
				else if(identity == 4'd6)begin

					if(toDigit[5] == 1)begin
						if(canIMove == 1)begin
							if(rCount == 49999999) begin 				// One second timer
								if(count == maximumBits)begin
									count <= 4'd0;
									fromDigit <= 6'b000000;
								end
								else if(count == (maximumBits - 4'd1))begin
									count <= count + 4'd1;
									fromDigit <= 6'b111111;
								end
								else begin
									count <= count + 4'd1;
									fromDigit <= 6'b000000;
								end
							end
						end
					end
					else begin		// This else is added just in case the HSB forgot to set toDigit[2] to 1 at the appropriate time
						if(canIMove == 1)begin
							if(rCount == 49999999)begin
								if(currentBits[23:20] == 4'd1 && currentBits[19:16] == 4'd2 && currentBits[15:12] == 4'd5 && currentBits[11:8] == 4'd9 && currentBits[7:4] == 4'd5 && currentBits[3:0] == 9)begin // addresses 12:59:59
									count <= 4'd0;	
								end
								else if(currentBits[23:20] == 4'd0 && currentBits[19:16] == 4'd9 && currentBits[15:12] == 4'd5 && currentBits[11:8] == 4'd9 && currentBits[7:4] == 4'd5 && currentBits[3:0] == 9)begin // addresses 09:59:59
									count <= 4'd1;	
								end
							end
						end
					end
				end

				//=========================================//
				if(state == 4'd0)begin
					nextState <= sReset;
				end 									// You don't go from Start to Set that's why the condition for set is removed here
				else if(state == 4'd3)begin
					nextState <= sStart;
				end
			end
			default:begin
				nextState <= sReset;
			end
		endcase
	end
end

assign outputBits = count;
endmodule
 
