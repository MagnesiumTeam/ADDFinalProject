module PillTakenRecorder(toggleSwitches4To2, romContent, pill12And3Duration, clk, dataToStoreInRAM);

input clk;
input [2:0] toggleSwitches4To2;
input [11:0] pill12And3Duration;
input [27:0] romContent;

reg [11:0] pill12And3Misses;
reg [11:0] tempPill12And3Misses;
reg [11:0] pill12And3ZeroCount;

output reg [27:0] dataToStoreInRAM;

always @(posedge clk)
begin 
end

endmodule