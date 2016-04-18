
module OneMilliSecondTimer(state, clk, oneMilliSecond);
input clk;
input [3:0] state;
output oneMilliSecond;

reg [15:0] rCount = 16'd0;
reg oneMilliSecond;

// Sequential logic
always @(posedge clk)
begin
	if(state == 4'd3)begin
		if(rCount == 49999) begin
			oneMilliSecond <= 1;
			rCount <= 16'd0;
		end
		else begin
			oneMilliSecond <= 0;
			rCount <= rCount + 16'd1;
		end
	end
	else begin
		oneMilliSecond <= 0;
		rCount <= 16'd0;
	end
end
endmodule

// Log April 15 2016 9:03pm
// The Reset and stop should set the enable to 0, the start should set the enable to 1
// 
// Log April 17 2016 8:51pm
// state as 4'd3 represents the start state when the clock ought to start count up