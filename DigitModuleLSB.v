/*
Name: Olanrewaju Gabriel Ibironke
Date: March 21, 2016
Project: Digit Module
*/

module DigitModuleLSB(toDigit, identity, setBits, maximumBits, clk, state, outputBits, fromDigit, rCountFromLSB, otherBitsMove);
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
input [5:0] toDigit;		
input [3:0] maximumBits, setBits; 
output [3:0] outputBits;
output reg [5:0] fromDigit;
output [25:0] rCountFromLSB;
output reg otherBitsMove;

reg [3:0] count;
reg [25:0] rCount = 26'd0;

parameter sReset = 4'd0, sSet = 4'd1, sStart = 4'd3;

reg [3:0] nextState;

always @(posedge clk)										
begin
// if the state is reset 
	if(state == 4'd0) begin
		nextState <= sReset;
	end
	else begin
		case(nextState)
			sReset:begin
				count <= maximumBits;
				rCount <= 26'd0;
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
				rCount <= 26'd0;
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

					if(toDigit[0] == 1)begin

						if(rCount == 49999999) begin 				// One second timer: if the count has reached 1 short of the 50Hz mark
							if(count == maximumBits)begin			// if the current value of the LSB is equal to the maximum bit
								count <= 4'd0;						// wrap the current value to 0
								fromDigit <= 6'b000000;				// and tell the HSB to maintain its value
								otherBitsMove <= 0;					// tell the others not to move
							end
							else if(count == (maximumBits - 4'd1))begin // if the current value of the LSB is equal to 1 short of the maximum bit
								count <= count + 4'd1;					// increment the current value
								fromDigit <= 6'b000010;					// and tell the HSB to increment its value as well
								otherBitsMove <= 1;						// give permission for the others to move
							end
							else begin									// if the current value is not equal to the penultimate or the last maximum
								count <= count + 4'd1;					// increment the current value
								fromDigit <= 6'b000000;					// tell the HSB to maintain its value
								otherBitsMove <= 0;						// tell the others not to move
							end
							rCount <= 26'd0;							// reset the one second timer count variable to 0
						end

						rCount <= rCount + 26'd1;						// increment the one second timer variable by 1

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
assign rCountFromLSB = rCount;
endmodule
 
