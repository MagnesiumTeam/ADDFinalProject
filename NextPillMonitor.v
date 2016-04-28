/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Control Module
*/
module NextPillMonitor(romContent, bitsFromClock, clk, state, nextPill, toBeTakenInTheNextXHour, pill12And3Duration);
input clk;
input [3:0] state;
input [27:0] romContent;
input [7:0] bitsFromClock;
output reg [3:0] nextPill;
output reg [3:0] toBeTakenInTheNextXHour;
output [11:0] pill12And3Duration;

reg [3:0] pill1Duration, pill2Duration, pill3Duration;
reg [7:0] temporaryBitsFromClock;

//assign nextPill = romContent[7:4];
//assign toBeTakenInTheNextXHour = romContent[3:0];

always @(posedge clk)
begin
	if(state == 4'd0)begin
		pill1Duration <= romContent[19:16];
		pill2Duration <= romContent[11:8];
		pill3Duration <= romContent[3:0];
		temporaryBitsFromClock <= bitsFromClock; 


		if(pill1Duration < pill2Duration)begin

			if(pill1Duration < pill3Duration)begin
				toBeTakenInTheNextXHour <= pill1Duration;
				nextPill <= romContent[23:20];
			end
			else begin
				toBeTakenInTheNextXHour <= pill3Duration;
				nextPill <= romContent[7:4];
			end

		end
		else begin
			if(pill2Duration < pill3Duration)begin
				toBeTakenInTheNextXHour <= pill2Duration;
				nextPill <= romContent[15:12];
			end
			else begin
				toBeTakenInTheNextXHour <= pill3Duration;
				nextPill <= romContent[7:4];
			end
		end

	end
	else if(state == 4'd2)begin
		pill1Duration <= romContent[19:16];
		pill2Duration <= romContent[11:8];
		pill3Duration <= romContent[3:0];
		temporaryBitsFromClock <= bitsFromClock; 


		if(pill1Duration < pill2Duration)begin

			if(pill1Duration < pill3Duration)begin
				toBeTakenInTheNextXHour <= pill1Duration;
				nextPill <= romContent[23:20];
			end
			else begin
				toBeTakenInTheNextXHour <= pill3Duration;
				nextPill <= romContent[7:4];
			end

		end
		else begin
			if(pill2Duration < pill3Duration)begin
				toBeTakenInTheNextXHour <= pill2Duration;
				nextPill <= romContent[15:12];
			end
			else begin
				toBeTakenInTheNextXHour <= pill3Duration;
				nextPill <= romContent[7:4];
			end
		end
	end
	else if(state == 4'd3)begin 

		//nextPill <= bitsFromClock[3:0]; 

		if(temporaryBitsFromClock != bitsFromClock)begin										// If the time has increased by one hour	 

			temporaryBitsFromClock <= bitsFromClock;									// set the previous hour time to the current hour time

			if(pill1Duration == 4'd0)begin
				pill1Duration <= romContent[19:16];
			end
			else begin
				pill1Duration <= pill1Duration - 4'd1;									// decrement the duration by 1
			end

			if(pill2Duration == 4'd0)begin
				pill2Duration <= romContent[11:8];
			end
			else begin
				pill2Duration <= pill2Duration - 4'd1;									// decrement the duration by 1
			end

			if(pill3Duration == 4'd0)begin
				pill3Duration <= romContent[3:0];
			end
			else begin
				pill3Duration <= pill3Duration - 4'd1;									// decrement the duration by 1
			end 

			if(pill1Duration < pill2Duration)begin

				if(pill1Duration < pill3Duration)begin
					toBeTakenInTheNextXHour <= pill1Duration;
					nextPill <= romContent[23:20];
				end
				else begin
					toBeTakenInTheNextXHour <= pill3Duration;
					nextPill <= romContent[7:4];
				end

			end
			else begin
				if(pill2Duration < pill3Duration)begin
					toBeTakenInTheNextXHour <= pill2Duration;
					nextPill <= romContent[15:12];
				end
				else begin
					toBeTakenInTheNextXHour <= pill3Duration;
					nextPill <= romContent[7:4];
				end
			end
 
		end 

	end
end
assign pill12And3Duration[11:8] = pill1Duration;
assign pill12And3Duration[7:4] = pill2Duration;
assign pill12And3Duration[3:0] = pill3Duration;
endmodule