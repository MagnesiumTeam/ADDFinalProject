/*
Name: Olanrewaju Gabriel Ibironke
Date: February 20, 2016
Project: Button Shaper
*/
module ButtonShaper(buttonInput, buttonOutput, Clk);
input buttonInput, Clk;
output buttonOutput;
reg buttonOutput;

parameter sOff = 0, sOn = 1, sWait = 2;

reg [1:0] State = sOff, StateNext;

// Combinational Logic
always @(State, buttonInput) 
begin
	case(State)
	sOff:begin
		buttonOutput = 0;
		if(buttonInput == 1)
		begin
			StateNext = sOn;
		end
		else
		begin
			StateNext = sOff;
		end
	end
	sOn:begin
		buttonOutput = 1;
		StateNext = sWait;
	end
	sWait:begin
		buttonOutput = 0;
		if(buttonInput == 1)
		begin
			StateNext = sWait;
		end
		else
		begin
			StateNext = sOff;
		end
	end
	default: begin
		StateNext = sOff;
	end
	endcase
end

// State Register
always @(posedge Clk)
begin
	State <= StateNext;
end
endmodule
