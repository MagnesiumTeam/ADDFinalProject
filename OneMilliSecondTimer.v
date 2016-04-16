
module OneMilliSecondTimer(enableTimer, clk, oneMilliSecond);
input enableTimer, clk;
output oneMilliSecond;

reg [15:0] rCount = 16'd0;
reg oneMilliSecond;

// Sequential logic
always @(posedge clk)
begin
	if(enableTimer == 0)begin
		oneMilliSecond <= 0;
		rCount <= 16'd0;
	end
	else begin
		if(rCount == 49999) begin
			oneMilliSecond <= 1;
			rCount <= 16'd0;
		end
		else begin
			oneMilliSecond <= 0;
			rCount <= rCount + 16'd1;
		end
	end
end
endmodule

// Log April 15 2016 9:03pm
// The Reset and stop should set the enable to 0, the start should set the enable to 1
// 