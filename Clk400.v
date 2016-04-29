
module Clk400(clkIn, clkOut);

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