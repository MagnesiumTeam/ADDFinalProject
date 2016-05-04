/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: May 4, 2016
Project: Lowest Seconds Bit Digit Module
*/

module DigitModuleLSB(oneSecondClkExtended, identity, setBits, maximumBits, clk, state, outputBits);
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

Demo mode:
reg [19:0] rCount = 20'd0;
rCount == 20'd499999;
*/		 		
input [3:0] maximumBits, setBits;  
input oneSecondClkExtended;
output [3:0] outputBits;    

reg [3:0] count;  

parameter sReset = 4'd0, sSet = 4'd1, sStart = 4'd3;

reg [3:0] nextState;

always @(posedge clk)										
begin
// 	if the state is reset 
	if(state == 4'd0) begin
		nextState <= sReset;
		count <= maximumBits;
	end
	else begin
		case(nextState)
			sReset:begin  
				if(state == 4'd0)begin
					nextState <= sReset;
				end
				else if(state == 4'd1)begin
					nextState <= sSet;
				end
				else if(state == 4'd3)begin
					nextState <= sStart;
				end 
			end
			sSet:begin
				count <= setBits; 
				if(state == 4'd0)begin
					nextState <= sReset;
				end
				else if(state == 4'd1)begin
					nextState <= sSet;
				end
				else if(state == 4'd3)begin
					nextState <= sStart;
				end
			end
			sStart:begin
				if(identity == 4'd1)begin  
						if(oneSecondClkExtended == 1) begin 				// One second timer: if the count has reached 1 short of the 50Hz mark
							if(count == maximumBits)begin				// if the current value of the LSB is equal to the maximum bit
								count <= 4'd0;							// wrap the current value to 0  
							end
							else if(count == (maximumBits - 4'd1))begin // if the current value of the LSB is equal to 1 short of the maximum bit
								count <= count + 4'd1;					// increment the current value 
							end
							else begin									// if the current value is not equal to the penultimate or the last maximum
								count <= count + 4'd1;					// increment the current value 
							end 
						end  
				end

				//=========================================//
				if(state == 4'd0)begin
					nextState <= sReset;
				end 													// You don't go from Start to Set that's why the condition for set is removed here
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
 
