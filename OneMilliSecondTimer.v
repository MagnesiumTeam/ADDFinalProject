
module OneMilliSecondTimer(clk, oneMilliSecond);
input clk;
output oneMilliSecond;

reg [15:0] rCount = 16'd0;
reg oneMilliSecond;

// Sequential logic
always @(posedge clk)
begin
	if(rCount == 49999) begin
		oneMilliSecond <= 1;
		rCount <= 16'd0;
	end
	else begin
		oneMilliSecond <= 0;
		rCount <= rCount + 16'd1;
	end
end
endmodule