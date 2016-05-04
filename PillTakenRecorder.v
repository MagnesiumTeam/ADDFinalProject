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
		//pill12And3Misses <= 12'd0;
		signalFromPTRToNextPillMonitor <= 3'd0;
		tookPill <= 3'd0;
		ignoreTheStartState <= 3'd0;
 	end
	else begin																// if the reset button was not pushed

		if(pill12And3Duration[11:8] == 4'd0)begin							// and the pill 1 duration is 0
			
			if(resetSetLoadStart[0] == 1)begin								// if the start button is not pushed it implies patirnt missed the pill to be taken
				signalFromPTRToNextPillMonitor[0] <= 1;  
				tookPill[0] <= 1;
			end 
			
			if(state == 4'd3)begin
				ignoreTheStartState[0] <= 1;
			end

		end 
		else if(pill12And3Duration[11:8] == 4'd1)begin						// Even if the interval is one it still corresponds with the values set in reset
			tookPill[0] <= 0;												// if the values of tookPill and incrementOnce are not reset to 0, if a patient
			incrementOnce[0] <= 0; 											// takes pill once and skips the second time the system will think they took the
		end 																// pill when actually they missed.
		else begin 															// if pill 1 duration is not 0 or 1
			if(signalFromPTRToNextPillMonitor[0] == 1)begin
				signalFromPTRToNextPillMonitor[0] <= 0; 
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

		if(pill12And3Duration[7:4] == 4'd0)begin
			
			if(resetSetLoadStart[0] == 1)begin								// if the start button is not pushed it implies patirnt missed the pill to be taken
				signalFromPTRToNextPillMonitor[1] <= 1;  
				tookPill[1] <= 1;
			end 
			
			if(state == 4'd3)begin
				ignoreTheStartState[1] <= 1;
			end

		end
		else if(pill12And3Duration[7:4] == 4'd1)begin						// Even if the interval is one it still corresponds with the values set in reset
			tookPill[1] <= 0;												// if the values of tookPill and incrementOnce are not reset to 0, if a patient
			incrementOnce[1] <= 0; 											// takes pill once and skips the second time the system will think they took the
		end 																// pill when actually they missed.
		else begin 															// if pill 1 duration is not 0 or 1
			if(signalFromPTRToNextPillMonitor[1] == 1)begin
				signalFromPTRToNextPillMonitor[1] <= 0; 
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

		if(pill12And3Duration[3:0] == 4'd0)begin
			
			if(resetSetLoadStart[0] == 1)begin								// if the start button is not pushed it implies patirnt missed the pill to be taken
				signalFromPTRToNextPillMonitor[2] <= 1;  
				tookPill[2] <= 1;
			end 
			
			if(state == 4'd3)begin
				ignoreTheStartState[2] <= 1;
			end

		end
		else if(pill12And3Duration[3:0] == 4'd1)begin						// Even if the interval is one it still corresponds with the values set in reset
			tookPill[2] <= 0;												// if the values of tookPill and incrementOnce are not reset to 0, if a patient
			incrementOnce[2] <= 0; 											// takes pill once and skips the second time the system will think they took the
		end 																// pill when actually they missed.
		else begin
			if(signalFromPTRToNextPillMonitor[2] == 1)begin
				signalFromPTRToNextPillMonitor[2] <= 0; 
			end
			if(ignoreTheStartState[2] == 1)begin							// prevents any decrement at the reset or start state (set to 0 by the reset only)
			 	if(pill12And3Duration[3:0] == romContent[3:0])begin		// evaluates only if it is at the maximum interval
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