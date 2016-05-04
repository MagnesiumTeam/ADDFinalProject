module LCDController(dataFromRAM, monitorOrMissedScene, romContent, pill12And3Duration, CLK_400Hz, resetn, LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA);

input CLK_400Hz, resetn, monitorOrMissedScene; 
input [27:0] romContent, dataFromRAM;
input [11:0] pill12And3Duration;
output LCD_ON, LCD_RS, LCD_EN, LCD_RW;
output [7:0] LCD_DATA;

reg [6:0] p_state;
reg LCD_EN, LCD_RS;
reg [7:0] LCD_DATA_VALUE;

parameter [6:0] reset1=1, reset2=2, reset3=3, FUNC_SET=4,
display_off=5, display_clear=6,
display_on=7, mode_set=8, writeChar1=9,
writeChar2=10, writeChar3=11, writeChar4=12,
writeChar5=13, writeChar6=14, writeChar7=15,
writeChar8=16, writeChar9=17, writeChar10=18,
return_home=19, writeChar11=20, writeChar12=21, 
writeChar13=22, writeChar14=23, writeChar15=24, 
writeChar16=25, writeChar17=26, writeChar18=27, 
writeChar19=28, writeChar20=29, writeChar21=30,
writeChar22=31, writeChar23=32, writeChar24=33, 
writeChar25=34, writeChar26=35, writeChar27=36,
writeChar28=37, writeChar29=38, writeChar30=39,      

toggle_e1=40, toggle_e2=41,  toggle_e3=42,  toggle_e4=43,
toggle_e5=44, toggle_e6=45,  toggle_e7=46,  toggle_e8=47,
toggle_e9=48, toggle_e10=49, toggle_e11=50, toggle_e12=51,
toggle_e13=52,toggle_e14=53, toggle_e15=54, toggle_e16=55,
toggle_e17=56,toggle_e18=57, toggle_e19=58, w_address=59, 
write_w=60,

toggle_e20=61, toggle_e21=62, char1_address=63, write_e=64,
toggle_e22=65, toggle_e23=66, toggle_e24=67, toggle_e25=68, 
toggle_e26=69, toggle_e27=70, toggle_e28=71, toggle_e29=72, 
toggle_e30=73, toggle_e31=74, toggle_e32=75, toggle_e33=76, 
toggle_e34=77, toggle_e35=78, toggle_e36=79, toggle_e37=80, 
toggle_e38=81, toggle_e39=82, toggle_e40=83, toggle_e41=84;

assign LCD_ON=1;
assign LCD_RW=0;
assign LCD_DATA = LCD_DATA_VALUE; 

always @ (posedge CLK_400Hz)
begin
	if(resetn == 0)begin
		p_state <= reset1;
	end
	else begin 
		case (p_state)
			reset1: begin
				p_state <= toggle_e1;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE = 8'h38;
			end
			toggle_e1: begin
				p_state <= reset2;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE = 8'h38;
			end
			reset2: begin
				p_state <= toggle_e2;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE = 8'h38;
			end
			toggle_e2: begin
				p_state <= reset3;
				{LCD_EN, LCD_RS}=2'b00;
			 	LCD_DATA_VALUE = 8'h38;
			end
			reset3: begin
				p_state <= toggle_e3;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE = 8'h38;
			end
			toggle_e3: begin
				p_state <= FUNC_SET;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE = 8'h38;
			end
			FUNC_SET: begin
				p_state <= toggle_e4;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE = 8'h38;
			end
			toggle_e4: begin
				p_state <= display_off;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE = 8'h38;
			end
			display_off: begin
				p_state <= toggle_e5;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE = 8'h08;
			end
			toggle_e5: begin
				p_state <= display_clear;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE = 8'h08;
			end
			display_clear: begin
				p_state <= toggle_e6;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE = 8'h01;
			end
			toggle_e6: begin
				p_state <= display_on;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE = 8'h01;
			end
			display_on: begin
				p_state <= toggle_e7;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE = 8'h0c;
			end
			toggle_e7: begin
				p_state <= mode_set;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE = 8'h0c;
			end
			mode_set: begin
				p_state <= toggle_e8;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE = 8'h06;
			end
			toggle_e8: begin
				p_state <= writeChar1;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE = 8'h06;
			end
			writeChar1: begin
				p_state <= toggle_e9;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h50;	// P
			end
			toggle_e9: begin
				p_state <= writeChar2;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h50;
			end
			writeChar2: begin
				p_state <= toggle_e10;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h61; // a
			end
			toggle_e10: begin
				p_state <= writeChar3;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h61;
			end
			writeChar3: begin
				p_state <= toggle_e11;	// t
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h74;
			end
			toggle_e11: begin
				p_state <= writeChar4;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h74;
			end
			writeChar4: begin
				p_state <= toggle_e12;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h69;	// i
			end
			toggle_e12: begin
				p_state <= writeChar5;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h69;
			end
			writeChar5: begin
				p_state <= toggle_e13;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h65;	// e
			end
			toggle_e13: begin
				p_state <= writeChar6;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h65;
			end
			writeChar6: begin
				p_state <= toggle_e14;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h6e; // n
			end
			toggle_e14: begin
				p_state <= writeChar7;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h6e;
			end
			writeChar7: begin
				p_state <= toggle_e15;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h74; // t
			end
			toggle_e15: begin
				p_state <= writeChar8;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h74;
			end
			writeChar8: begin
				p_state <= toggle_e16;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h3a; // :
			end
			toggle_e16: begin
				p_state <= writeChar9;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h3a;
			end
			writeChar9: begin
				p_state <= toggle_e17;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE ={4'b0011, romContent[27:24]}; 
			end
			toggle_e17: begin
				p_state <= writeChar10;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE ={4'b0011, romContent[27:24]};
			end
			writeChar10: begin
				p_state <= toggle_e18;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h20; // whitespace
			end
			toggle_e18: begin
				p_state <= writeChar11;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h20;
			end
			writeChar11: begin
				p_state <= toggle_e19;
				{LCD_EN, LCD_RS}=2'b11;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h52; // R
				end
				else begin
					LCD_DATA_VALUE = 8'h4d; // M
				end
			end
			toggle_e19: begin
				p_state <= writeChar12;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h52; 
				end
				else begin
					LCD_DATA_VALUE = 8'h4d;
				end
			end
			writeChar12: begin
				p_state <= toggle_e20;
				{LCD_EN, LCD_RS}=2'b11;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h54; // T
				end
				else begin
					LCD_DATA_VALUE = 8'h69; // i
				end
			end
			toggle_e20: begin
				p_state <= writeChar13;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h54; 
				end
				else begin
					LCD_DATA_VALUE = 8'h69; 
				end
			end
			writeChar13: begin
				p_state <= toggle_e21;
				{LCD_EN, LCD_RS}=2'b11;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h28; // (
				end
				else begin
					LCD_DATA_VALUE = 8'h73; // s
				end
			end
			toggle_e21: begin
				p_state <= writeChar14;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h28; 
				end
				else begin
					LCD_DATA_VALUE = 8'h73; 
				end
			end
			writeChar14: begin
				p_state <= toggle_e22;
				{LCD_EN, LCD_RS}=2'b11;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h68; // h
				end
				else begin
					LCD_DATA_VALUE = 8'h73; // s
				end
			end
			toggle_e22: begin
				p_state <= writeChar15;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h68;
				end
				else begin
					LCD_DATA_VALUE = 8'h73; 
				end
			end
			writeChar15: begin
				p_state <= toggle_e23;
				{LCD_EN, LCD_RS}=2'b11;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h72; // r
				end
				else begin
					LCD_DATA_VALUE = 8'h65; // e
				end
			end
			toggle_e23: begin
				p_state <= writeChar16;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h72; 
				end
				else begin
					LCD_DATA_VALUE = 8'h65;
				end
			end
			writeChar16: begin
				p_state <= toggle_e24;
				{LCD_EN, LCD_RS}=2'b11;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h29; // )
				end
				else begin
					LCD_DATA_VALUE = 8'h73; // s
				end
			end
			toggle_e24: begin
				p_state <= w_address;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin
					LCD_DATA_VALUE = 8'h29;
				end
				else begin
					LCD_DATA_VALUE = 8'h73; 
				end
			end
			// set DDRAM address for the second line
			w_address: begin
				p_state <= toggle_e25;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE =8'hc0;	// second line
			end
			toggle_e25: begin
				p_state <= writeChar17;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE =8'hc0;	// second line
			end
			writeChar17: begin
				p_state <= toggle_e26;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE =8'h50;	// P
			end
			toggle_e26: begin
				p_state <= writeChar18;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE =8'h50;
			end 
			writeChar18: begin
				p_state <= toggle_e27;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE ={4'b0011, romContent[23:20]}; // Represents Pill 1
			end 
			toggle_e27: begin
				p_state <= writeChar19;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE ={4'b0011, romContent[23:20]}; // Represents Pill 1
			end
			writeChar19: begin
				p_state <= toggle_e28;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h3a; // :
			end
			toggle_e28: begin
				p_state <= writeChar20;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h3a;
			end
			writeChar20: begin
				p_state <= toggle_e29;
				{LCD_EN, LCD_RS}=2'b11;
				if(monitorOrMissedScene == 1)begin								// 1 represents monitor or remaining time
					LCD_DATA_VALUE = {4'b0011, pill12And3Duration[11:8]}; 
				end
				else begin														// 0 represents misses 
					LCD_DATA_VALUE = {4'b0011, dataFromRAM[19:16]}; 
				end
			end
			toggle_e29: begin
				p_state <= writeChar21;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin								// 1 represents monitor or remaining time
					LCD_DATA_VALUE = {4'b0011, pill12And3Duration[11:8]}; 
				end
				else begin														// 0 represents misses 
					LCD_DATA_VALUE = {4'b0011, dataFromRAM[19:16]}; 
				end
			end
			writeChar21: begin
				p_state <= toggle_e30;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h20; // whitespace
			end
			toggle_e30: begin
				p_state <= writeChar22;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h20;
			end
			writeChar22: begin
				p_state <= toggle_e31;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE =8'h50;	// P
			end
			toggle_e31: begin
				p_state <= writeChar23;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE =8'h50;
			end 
			writeChar23: begin
				p_state <= toggle_e32;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE ={4'b0011, romContent[15:12]}; // Represents Pill 2
			end 
			toggle_e32: begin
				p_state <= writeChar24;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE ={4'b0011, romContent[15:12]}; // Represents Pill 2
			end
			writeChar24: begin
				p_state <= toggle_e33;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h3a; // :
			end
			toggle_e33: begin
				p_state <= writeChar25;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h3a;
			end
			writeChar25: begin
				p_state <= toggle_e34;
				{LCD_EN, LCD_RS}=2'b11; 
				if(monitorOrMissedScene == 1)begin								// 1 represents monitor or remaining time
					LCD_DATA_VALUE = {4'b0011, pill12And3Duration[7:4]}; 
				end
				else begin														// 0 represents misses 
					LCD_DATA_VALUE = {4'b0011, dataFromRAM[11:8]}; 
				end
			end
			toggle_e34: begin
				p_state <= writeChar26;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin								// 1 represents monitor or remaining time
					LCD_DATA_VALUE = {4'b0011, pill12And3Duration[7:4]}; 
				end
				else begin														// 0 represents misses 
					LCD_DATA_VALUE = {4'b0011, dataFromRAM[11:8]}; 
				end
			end
			writeChar26: begin
				p_state <= toggle_e35;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h20; // whitespace
			end
			toggle_e35: begin
				p_state <= writeChar27;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h20;
			end
			writeChar27: begin
				p_state <= toggle_e36;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE =8'h50;	// P
			end
			toggle_e36: begin
				p_state <= writeChar28;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE =8'h50;
			end 
			writeChar28: begin
				p_state <= toggle_e37;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE ={4'b0011, romContent[7:4]}; // Represents Pill 3
			end 
			toggle_e37: begin
				p_state <= writeChar29;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE ={4'b0011, romContent[7:4]}; // Represents Pill 3
			end
			writeChar29: begin
				p_state <= toggle_e38;
				{LCD_EN, LCD_RS}=2'b11;
				LCD_DATA_VALUE = 8'h3a; // :
			end
			toggle_e38: begin
				p_state <= writeChar30;
				{LCD_EN, LCD_RS}=2'b01;
				LCD_DATA_VALUE = 8'h3a;
			end
			writeChar30: begin
				p_state <= toggle_e39;
				{LCD_EN, LCD_RS}=2'b11; 
				if(monitorOrMissedScene == 1)begin								// 1 represents monitor or remaining time
					LCD_DATA_VALUE = {4'b0011, pill12And3Duration[3:0]}; 
				end
				else begin														// 0 represents misses 
					LCD_DATA_VALUE = {4'b0011, dataFromRAM[3:0]}; 
				end
			end
			toggle_e39: begin
				p_state <= toggle_e40;
				{LCD_EN, LCD_RS}=2'b01;
				if(monitorOrMissedScene == 1)begin								// 1 represents monitor or remaining time
					LCD_DATA_VALUE = {4'b0011, pill12And3Duration[3:0]}; 
				end
				else begin														// 0 represents misses 
					LCD_DATA_VALUE = {4'b0011, dataFromRAM[3:0]}; 
				end
			end
			toggle_e40: begin
				p_state <= return_home;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE =8'h65;
			end
			return_home: begin
				p_state <= toggle_e41;
				{LCD_EN, LCD_RS}=2'b10;
				LCD_DATA_VALUE =8'h80; //8'h80;
			end
			toggle_e41: begin
				p_state <= writeChar1;
				{LCD_EN, LCD_RS}=2'b00;
				LCD_DATA_VALUE =8'h80;//8'h80;
			end
		endcase 
	end
end
endmodule