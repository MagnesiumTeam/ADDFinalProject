
module Clk400(clkIn, clkOut);

input clkIn;
output reg clkOut;

reg [16:0] count;

always @(posedge clkIn)
begin
	
	if(count == 17'd124999)begin
		clkOut <= 1;
		count <= 17'd0;
	end
	else begin
		clkOut <= 0;
		count <= count + 17'd1;
	end
end
endmodule