/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 13, 2016
Project: seven segment display with 4-bit input
*/
module SevenSegDisp(Din,Dout);
output [6:0] Dout;
input [3:0] Din;
reg [6:0] Dout;

always @(Din)
begin
	case(Din)
	4'b0000:begin
	Dout = 7'b0000001;
	end
	4'b0001:begin
	Dout = 7'b1001111;
	end
	4'b0010:begin
	Dout = 7'b0010010;
	end
	4'b0011:begin
	Dout = 7'b0000110;
	end
	4'b0100:begin
	Dout = 7'b1001100;
	end
	4'b0101:begin
	Dout = 7'b0100100;
	end
	4'b0110:begin
	Dout = 7'b0100000;
	end
	4'b0111:begin
	Dout = 7'b0001111;
	end
	4'b1000:begin
	Dout = 7'b0000000;
	end
	4'b1001:begin
	Dout = 7'b0001100;
	end
	4'b1010:begin
	Dout = 7'b0001000;
	end
	4'b1011:begin
	Dout = 7'b1100000;
	end
	4'b1100:begin
	Dout = 7'b0110001;
	end
	4'b1101:begin
	Dout = 7'b1000010;
	end
	4'b1110:begin
	Dout = 7'b0110000;
	end
	4'b1111:begin
	Dout = 7'b0111000;
	end
	default:begin
	Dout = 7'b1111110;
	end
	endcase
end
endmodule 
