
module OneThousandCount(clk, countOut);
input clk;
output countOut;

reg [11:0] rCount = 12'd0;
reg countOut;


// Sequential logic
always @(posedge clk)
begin
	if(rCount == 999) begin
		countOut <= 1;
		rCount <= 12'd0;
	end
	else begin
		countOut <= 0;
		rCount <= rCount + 12'd1;
	end
end
endmodule

