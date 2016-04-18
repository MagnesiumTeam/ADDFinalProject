/*
Name: Olanrewaju Gabriel Ibironke
Date: March 21, 2016
Project: Digit Module
*/

module DigitModule(setBits, maximumBits, clk, state, outputBits);
input clk;
input [3:0] state;					
input [3:0] maximumBits, setBits; 
output [3:0] outputBits;

reg [3:0] count;
reg [25:0] rCount = 26'd0;

parameter sReset = 4'd0, sSet = 4'd1, sStart = 4'd3;

reg [3:0] nextState;

always @(posedge clk)
begin
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
				if(rCount == 49999999) begin 				// One second timer
					if(count == maximumBits)begin
						count <= 4'd0;
					end
					else begin
						count <= count + 4'd1;
					end
					rCount <= 26'd0;
				end
				rCount <= rCount + 26'd1;
				
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
 
