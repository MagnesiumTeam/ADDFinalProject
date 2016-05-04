/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: May 4, 2016
Project: Pill Taken Recorder
Purpose: Evaluates the amount of time pills were missed by evaluating if the pills were taken or not 
*/

module PillTakenRecorder(state, resetSetLoadStart, romContent, pill12And3Duration, clk, dataToStoreInRAM, signalFromPTRToNextPillMonitor);

input clk;
input [3:0] resetSetLoadStart, state;
input [11:0] pill12And3Duration;
input [27:0] romContent;
 
output reg [2:0] signalFromPTRToNextPillMonitor;
output [27:0] dataToStoreInRAM;

reg [11:0] pill12And3Misses; 
reg [2:0] ignoreTheStartState, incrementOnce, tookPill;  

always @(posedge clk)
begin 
	if(resetSetLoadStart[3] == 1)begin										// If The reset button is pushed 
		signalFromPTRToNextPillMonitor <= 3'd0;								// tell next pill monitor not to load the preset duration to take pill
		tookPill <= 3'd0;													// reset the tookPill array
		ignoreTheStartState <= 3'd0;										// reset the ignoreTheStartState array
 	end
 	else if(resetSetLoadStart[1] == 1)begin									// if the load from rom push button was pressed
 		if(state == 4'd0)begin												// and we transition from the reset state
 			pill12And3Misses <= 12'd0;										// reset the miss counts to zero
 		end
 	end
	else begin																// if the reset or load from rom buttons were not pushed

		if(pill12And3Duration[11:8] == 4'd0)begin							// and the pill 1 duration is 0
			
			if(resetSetLoadStart[0] == 1)begin								// if the start button is pushed
				signalFromPTRToNextPillMonitor[0] <= 1;						// patient took pill 1 so switch off the LED and reset the pill duration to max  
				tookPill[0] <= 1;											// patient took pill 1 so don't increment miss for pill 1
			end 
			
			if(state == 4'd3)begin											// permit the system to increment only when we have started the time
				ignoreTheStartState[0] <= 1;								
			end

		end 
		else if(pill12And3Duration[11:8] == 4'd1)begin						// if pill 1 duration is 1
			tookPill[0] <= 0;												// reset the tookPill for pill 1
			incrementOnce[0] <= 0; 											// reset the incrementOnce variable
		end 																 
		else begin 															// if pill 1 duration is not 0 or 1
			if(signalFromPTRToNextPillMonitor[0] == 1)begin					// and if the LED was switched off
				signalFromPTRToNextPillMonitor[0] <= 0; 					// reset the signal to NextPillMonitor so it can be used again
			end
			if(ignoreTheStartState[0] == 1)begin							// prevents any decrement at the reset or start state (set to 0 by the reset only)
			 	if(pill12And3Duration[11:8] == romContent[19:16])begin		// evaluates only if it is at the maximum interval
			 		if(tookPill[0] == 0)begin								// If the start button was not pushed to turn off the alarm
			 			if(incrementOnce[0] == 0)begin
			 				pill12And3Misses[11:8] <= pill12And3Misses[11:8] + 4'd1;	// then the patient missed his pill so increment by 1
			 				incrementOnce[0] <= 1;  
			 			end 
			 		end  
			 	end  														
			 end
		end

		if(pill12And3Duration[7:4] == 4'd0)begin							// and the pill 2 duration is 0
			
			if(resetSetLoadStart[0] == 1)begin								// if the start button is pushed
				signalFromPTRToNextPillMonitor[1] <= 1;  					// patient took pill 2 so switch off the LED and reset the pill duration to max 
				tookPill[1] <= 1;											// patient took pill 2 so don't increment miss for pill 2
			end 
			
			if(state == 4'd3)begin											// permit the system to increment only when we have started the time
				ignoreTheStartState[1] <= 1;
			end

		end
		else if(pill12And3Duration[7:4] == 4'd1)begin						// if pill 2 duration is 1
			tookPill[1] <= 0;												// reset the tookPill for pill 2
			incrementOnce[1] <= 0; 											// reset the incrementOnce variable
		end 																 
		else begin 															// if pill 2 duration is not 0 or 1
			if(signalFromPTRToNextPillMonitor[1] == 1)begin					// and if the LED was switched off
				signalFromPTRToNextPillMonitor[1] <= 0; 					// reset the signal to NextPillMonitor so it can be used again
			end
			if(ignoreTheStartState[1] == 1)begin							// prevents any decrement at the reset or start state (set to 0 by the reset only)
			 	if(pill12And3Duration[7:4] == romContent[11:8])begin		// evaluates only if it is at the maximum interval
			 		if(tookPill[1] == 0)begin								// If the start button was not pushed to turn off the alarm
			 			if(incrementOnce[1] == 0)begin
			 				pill12And3Misses[7:4] <= pill12And3Misses[7:4] + 4'd1;	// then the patient missed his pill so increment by 1
			 				incrementOnce[1] <= 1;  
			 			end 
			 		end  
			 	end  														
			 end
		end

		if(pill12And3Duration[3:0] == 4'd0)begin							// and the pill 3 duration is 0
			
			if(resetSetLoadStart[0] == 1)begin								// if the start button is pushed
				signalFromPTRToNextPillMonitor[2] <= 1;  					// patient took pill 3 so switch off the LED and reset the pill duration to max
				tookPill[2] <= 1;											// patient took pill 3 so don't increment miss for pill 3
			end 
			
			if(state == 4'd3)begin											// permit the system to increment only when we have started the time
				ignoreTheStartState[2] <= 1;
			end

		end
		else if(pill12And3Duration[3:0] == 4'd1)begin						// if pill 3 duration is 1
			tookPill[2] <= 0;												// reset the tookPill for pill 3
			incrementOnce[2] <= 0; 											// reset the incrementOnce variable
		end 																
		else begin
			if(signalFromPTRToNextPillMonitor[2] == 1)begin
				signalFromPTRToNextPillMonitor[2] <= 0; 
			end
			if(ignoreTheStartState[2] == 1)begin							// prevents any decrement at the reset or start state (set to 0 by the reset only)
			 	if(pill12And3Duration[3:0] == romContent[3:0])begin			// evaluates only if it is at the maximum interval
			 		if(tookPill[2] == 0)begin								// If the start button was not pushed to turn off the alarm
			 			if(incrementOnce[2] == 0)begin
			 				pill12And3Misses[3:0] <= pill12And3Misses[3:0] + 4'd1;	// then the patient missed his pill so increment by 1
			 				incrementOnce[2] <= 1;  
			 			end 
			 		end  
			 	end  														
			 end
		end
	end
end

assign dataToStoreInRAM[27:24] = romContent[27:24];
assign dataToStoreInRAM[23:20] = romContent[23:20];
assign dataToStoreInRAM[19:16] = pill12And3Misses[11:8];
assign dataToStoreInRAM[15:12] = romContent[15:12];
assign dataToStoreInRAM[11:8]  = pill12And3Misses[7:4];
assign dataToStoreInRAM[7:4]   = romContent[7:4];
assign dataToStoreInRAM[3:0]   = pill12And3Misses[3:0];
endmodule