/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: May 4, 2016
Project: One Millisecond Timer
*/
module OneMilliSecondTimer(demoOrRealMode, clk, oneMilliSecond);
input clk, demoOrRealMode;
output oneMilliSecond;

reg [15:0] rCount = 16'd0;
reg oneMilliSecond;
reg [15:0] realOrDemo;

// Sequential logic
always @(posedge clk)
begin
	if(demoOrRealMode == 0)begin
		realOrDemo <= 49;
	end
	else begin
		realOrDemo <= 49999;
	end
	if(rCount == realOrDemo) begin
		oneMilliSecond <= 1;
		rCount <= 16'd0;
	end
	else begin
		oneMilliSecond <= 0;
		rCount <= rCount + 16'd1;
	end
end
endmodule