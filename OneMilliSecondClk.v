/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: May 4, 2016
Project: One Millisecond Clock
*/
module OneMilliSecondClk(clkIn, clkOut);

input clkIn;
output reg clkOut;

reg [15:0] count;

always @(posedge clkIn)
begin
	
	if(count == 17'd49999)begin
		clkOut <= 1;
		count <= 16'd0;
	end
	else begin
		clkOut <= 0;
		count <= count + 16'd1;
	end
end
endmodule