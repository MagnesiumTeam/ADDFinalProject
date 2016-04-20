/*
Name: Olanrewaju Gabriel Ibironke
Date: March 21, 2016
Project: Digit Module
*/

module DigitModule(currentBits, rCount, identity, setBits, maximumBits, clk, state, outputBits);
input clk;
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
input [23:0] currentBits;	
input [3:0] maximumBits, setBits; 
input rCount;  
output [3:0] outputBits; 

reg [3:0] count;

parameter sReset = 4'd0, sSet = 4'd1, sStart = 4'd3;

reg [3:0] nextState;

always @(posedge clk)							// at the positive edge of the clock									
begin
	if(state == 4'd0) begin  					// if the button pushed represents reset (note as soon as the hand is released from the pb the state goes to 4'd4) 
		nextState <= sReset; 					// go to the sReset case evaluation
		count <= maximumBits;
	end
	else begin 									// if the reset button has been released
		case(nextState)							// what is the next state?
			sReset:begin						// if the next state is reset 
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
				count <= setBits; 			// set the digits minus the LSB to the value on the setBits variable as passed by the Control module
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
				if(identity == 4'd2)begin												// If I am HSB
					if(rCount == 1) begin 											// and I am at the 1th clock  
						if(currentBits[3:0] == 4'd9)begin								// if LSB is 9
							if(currentBits[7:4] < 4'd5)begin							// and I am less than 5 (handling the xx:xx:x9)
								count <= count + 4'd1;									// increment my current value by 1
							end
							else begin													// if I am 5 (handling the xx:xx:59 case)
								count <= 4'd0;											// set me to 0 (making the time resolve to xx:xx:00)
							end
						end
					end  
				end
				else if(identity == 4'd3)begin 											// If I am LMB
  					if(rCount == 1) begin 											// and I am at the 1th clock  
						if(currentBits[3:0] == 4'd9)begin								// if LSB is 9
							if(currentBits[7:4] == 4'd5)begin							// and HSB is 5
								if(currentBits[11:8] < 4'd9)begin						// if I am less than 9 (handling the xx:xx:59 case)
									count <= count + 4'd1;								// increment my current value by 1
								end
								else begin												// if I am 9 (handling the xx:x9:59 case)
									count <= 4'd0;										// set me to 0 (making the time resolve to xx:x0:00)
								end
							end 
						end
					end
				end
				else if(identity == 4'd4)begin											// If I am HMB
  					if(rCount == 1) begin 											// and I am at the 1th clock  
						if(currentBits[3:0] == 4'd9)begin								// if LSB is 9
							if(currentBits[7:4] == 4'd5)begin							// and HSB is 5
								if(currentBits[11:8] == 4'd9)begin						// if LMB is 9
									if(currentBits[15:12] < 4'd5)begin					// and I am less than 5 (handling the xx:x9:59 case)
										count <= count + 4'd1;							// increment my current value by 1
									end
									else begin											// if I am 5 (handling the xx:59:59 case)
										count <= 4'd0;									// set me to 0 (making the time resolve to xx:00:00)
									end
								end
							end 
						end
					end
				end 
				else if(identity == 4'd5)begin  										// If I am LHB
  					if(rCount == 1) begin 											// and I am at the 1th clock  
						if(currentBits[3:0] == 4'd9)begin								// if LSB is 9
							if(currentBits[7:4] == 4'd5)begin							// and HSB is 5
								if(currentBits[11:8] == 4'd9)begin						// if LMB is 9
									if(currentBits[15:12] == 4'd5)begin 				// and HMB is 5
										if(currentBits[23:20] == 4'd0)begin				// if HHB is 0
											if(currentBits[19:16] < 4'd9)begin			// and I am less than 9 (handling the 0x:59:59 case)
												count <= count + 4'd1;					// increment my current value by 1
											end
											else begin									// if I am 9 (handling the 09:59:59 case)
												count <= 4'd0;							// set me to 0 (making the time resolve to 10:00:00)
											end
										end
										else if(currentBits[23:20] == 4'd1)begin		// if HHB is 1
											if(currentBits[19:16] < 4'd2)begin			// and I am less than 2 (handling the 1x:59:59 case)
												count <= count + 4'd1;					// increment my current value by 1
											end
											else begin									// if I am 2 (handling the 12:59:59 case)
												count <= 4'd1;							// set me to 1 (making the time resolve to 01:00:00)
											end
										end
									end
								end
							end 
						end
					end
				end
				else if(identity == 4'd6)begin 											// If I am HHB
   					if(rCount == 1) begin 											// and I am at the 1th clock  
						if(currentBits[3:0] == 4'd9)begin								// if LSB is 9
							if(currentBits[7:4] == 4'd5)begin							// and HSB is 5
								if(currentBits[11:8] == 4'd9)begin						// if LMB is 9
									if(currentBits[15:12] == 4'd5)begin 				// and HMB is 5
										 if(currentBits[23:20] == 4'd0)begin			// If I am 0 (Handling the 0x:59:59 case)
										 	if(currentBits[19:16] == 4'd9)begin			// if LHB is 9(Handling the 09:59:59 case)
										 		count <= 4'd1;							// set me to 1 (making the time resolve to 10:00:00)
										 	end
										 	else begin									// if LHB is not 9(as in 07:59:59 etc)
										 		count <= 4'd0;							// retain my value
										 	end
										 end
										 else if (currentBits[23:20] == 4'd1)begin		// if I am currently 1 (handling the 12:59:59 case)
										 	if(currentBits[19:16] == 4'd2)begin			// and LHB is 2 
										 		count <= 4'd0;							// then set my current value to 0 (making the time resolve to 01:00:00)
										 	end
										 	else begin									// if LHB is not 2 may be 10:59:59 or 11:59:59
										 		count <= 4'd1;							// retain my value of 1
										 	end
										 end
									end
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
 
