
module OneBitToFourBits(clk, outputBits);
input clk;
output [3:0] outputBits;

reg [3:0] outputBitsReg;

always @(posedge clk)
begin
	outputBitsReg <= outputBitsReg + 4'd1;
end

assign outputBits = outputBitsReg;
endmodule

// the reason I can't use the 50MHz clock here is that 