module LEDControl(clk, pill12And3Durations, pill12And3LEDs);

input clk;
input [11:0] pill12And3Durations;
output [2:0] pill12And3LEDs;

reg [2:0] pill12And3LEDs;

always @(posedge clk)
begin
	if(pill12And3Durations[11:8] == 4'd0)begin
		pill12And3LEDs[2] <= 1;
	end
	else begin
		pill12And3LEDs[2] <= 0;
	end

	if(pill12And3Durations[7:4] == 4'd0)begin
		pill12And3LEDs[1] <= 1;
	end
	else begin
		pill12And3LEDs[1] <= 0;
	end

	if(pill12And3Durations[3:0] == 4'd0)begin
		pill12And3LEDs[0] <= 1;
	end
	else begin
		pill12And3LEDs[0] <= 0;
	end
end
endmodule