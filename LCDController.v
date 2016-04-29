module LCDController(romContent, pill12And3Duration, CLK_400Hz, resetn, LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA);

input CLK_400Hz, resetn; 
input [27:0] romContent;
input [11:0] pill12And3Duration;
output LCD_ON, LCD_RS, LCD_EN, LCD_RW;
output [7:0] LCD_DATA;

reg [6:0] p_state, n_state;
reg LCD_EN, LCD_RS;
reg [7:0] LCD_DATA_VALUE;

parameter [6:0] reset1=1, reset2=2, reset3=3, FUNC_SET=4,
display_off=5, display_clear=6,
display_on=7, mode_set=8, write_char1=9,
write_char2=10, write_char3=11, write_char4=12,
write_char5=13, write_char6=14, write_char7=15,
write_char8=16, write_char9=17, write_char10=18,
return_home=19, write_char12=46, write_char13=47, 
write_char14=48, write_char15=49, write_char16=59, 
write_char18=61, write_char19=62, write_char20=63, 
write_char21=64, write_char22=69, write_char23=70,
write_char25=72, write_char26=73,

toggle_e1=20,toggle_e2=21, toggle_e3=22, toggle_e4=23,
toggle_e5=24,toggle_e6=25, toggle_e7=26, toggle_e8=27,
toggle_e9=28,toggle_e10=29, toggle_e11=30, toggle_e12=31,
toggle_e13=32,toggle_e14=33, toggle_e15=34, toggle_e16=35,
toggle_e17=36,toggle_e18=37, toggle_e19=38, w_address = 39, write_w=40,

toggle_e20=41, toggle_e21=42, char1_address=43, write_e=44,
toggle_e22 = 50, toggle_e23 = 51, toggle_e24 = 52, toggle_e25 = 53, toggle_e26 = 54,
toggle_e27 = 55, toggle_e28 = 56, toggle_e29 = 57, toggle_e30 = 58,
toggle_e31 = 65, toggle_e32 = 66, toggle_e33 = 67, toggle_e34 = 68,
toggle_e35 = 75, toggle_e36 = 76, toggle_e37 = 77;

assign LCD_ON=1;
assign LCD_RW=0;
assign LCD_DATA = LCD_DATA_VALUE;

always @ (p_state, pill12And3Duration, romContent)
begin
	case (p_state)
		reset1: begin
			n_state = toggle_e1;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE = 8'h38;
		end
		toggle_e1: begin
			n_state = reset2;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE = 8'h38;
		end
		reset2: begin
			n_state = toggle_e2;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE = 8'h38;
		end
		toggle_e2: begin
			n_state = reset3;
			{LCD_EN, LCD_RS}=2'b00;
		 	LCD_DATA_VALUE = 8'h38;
		end
		reset3: begin
			n_state = toggle_e3;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE = 8'h38;
		end
		toggle_e3: begin
			n_state = FUNC_SET;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE = 8'h38;
		end
		FUNC_SET: begin
			n_state = toggle_e4;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE = 8'h38;
		end
		toggle_e4: begin
			n_state = display_off;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE = 8'h38;
		end
		display_off: begin
			n_state = toggle_e5;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE = 8'h08;
		end
		toggle_e5: begin
			n_state = display_clear;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE = 8'h08;
		end
		display_clear: begin
			n_state = toggle_e6;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE = 8'h01;
		end
		toggle_e6: begin
			n_state = display_on;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE = 8'h01;
		end
		display_on: begin
			n_state = toggle_e7;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE = 8'h0c;
		end
		toggle_e7: begin
			n_state = mode_set;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE = 8'h0c;
		end
		mode_set: begin
			n_state = toggle_e8;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE = 8'h06;
		end
		toggle_e8: begin
			n_state = write_char1;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE = 8'h06;
		end
		write_char1: begin
			n_state = toggle_e9;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h50;	// P
		end
		toggle_e9: begin
			n_state = write_char2;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h50;
		end
		write_char2: begin
			n_state = toggle_e10;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h61; // a
		end
		toggle_e10: begin
			n_state = write_char3;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h61;
		end
		write_char3: begin
			n_state = toggle_e11;	// t
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h74;
		end
		toggle_e11: begin
			n_state = write_char4;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h74;
		end
		write_char4: begin
			n_state = toggle_e12;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h69;	// i
		end
		toggle_e12: begin
			n_state = write_char5;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h69;
		end
		write_char5: begin
			n_state = toggle_e13;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h65;	// e
		end
		toggle_e13: begin
			n_state = write_char6;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h65;
		end
		write_char6: begin
			n_state = toggle_e14;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h6e; // n
		end
		toggle_e14: begin
			n_state = write_char7;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h6e;
		end
		write_char7: begin
			n_state = toggle_e15;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h74; // t
		end
		toggle_e15: begin
			n_state = write_char8;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h74;
		end
		write_char8: begin
			n_state = toggle_e16;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h3a; // :
		end
		toggle_e16: begin
			n_state = write_char9;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h3a;
		end
		write_char9: begin
			n_state = toggle_e17;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE ={4'b0011, romContent[27:24]}; 
		end
		toggle_e17: begin
			n_state = w_address;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE ={4'b0011, romContent[27:24]};
		end
		// set DDRAM address for the second line
		w_address: begin
			n_state = toggle_e18;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE =8'hc0;	// second line
		end
		toggle_e18: begin
			n_state = write_char10;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE =8'hc0;	// second line
		end
		write_char10: begin
			n_state = toggle_e19;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE =8'h50;	// P
		end
		toggle_e19: begin
			n_state = write_char12;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE =8'h50;
		end 
		write_char12: begin
			n_state = toggle_e21;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE ={4'b0011, romContent[23:20]}; // #
		end 
		toggle_e21: begin
			n_state = write_char13;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE ={4'b0011, romContent[23:20]}; // #
		end
		write_char13: begin
			n_state = toggle_e22;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h3a; // :
		end
		toggle_e22: begin
			n_state = write_char14;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h3a;
		end
		write_char14: begin
			n_state = toggle_e23;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = {4'b0011, pill12And3Duration[11:8]}; 
		end
		toggle_e23: begin
			n_state = write_char15;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = {4'b0011, pill12And3Duration[11:8]}; 
		end
		write_char15: begin
			n_state = toggle_e24;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h20; // whitespace
		end
		toggle_e24: begin
			n_state = write_char16;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h20;
		end
		write_char16: begin
			n_state = toggle_e25;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE =8'h50;	// P
		end
		toggle_e25: begin
			n_state = write_char18;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE =8'h50;
		end 
		write_char18: begin
			n_state = toggle_e27;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE ={4'b0011, romContent[15:12]}; // #
		end 
		toggle_e27: begin
			n_state = write_char19;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE ={4'b0011, romContent[15:12]}; // #
		end
		write_char19: begin
			n_state = toggle_e28;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h3a; // :
		end
		toggle_e28: begin
			n_state = write_char20;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h3a;
		end
		write_char20: begin
			n_state = toggle_e29;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = {4'b0011, pill12And3Duration[7:4]}; 
		end
		toggle_e29: begin
			n_state = write_char21;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = {4'b0011, pill12And3Duration[7:4]}; 
		end
		write_char21: begin
			n_state = toggle_e30;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h20; // whitespace
		end
		toggle_e30: begin
			n_state = write_char22;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h20;
		end
		write_char22: begin
			n_state = toggle_e31;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE =8'h50;	// P
		end
		toggle_e31: begin
			n_state = write_char23;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE =8'h50;
		end 
		write_char23: begin
			n_state = toggle_e33;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE ={4'b0011, romContent[7:4]}; // #
		end 
		toggle_e33: begin
			n_state = write_char25;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE ={4'b0011, romContent[7:4]}; // #
		end
		write_char25: begin
			n_state = toggle_e34;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = 8'h3a; // :
		end
		toggle_e34: begin
			n_state = write_char26;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = 8'h3a;
		end
		write_char26: begin
			n_state = toggle_e35;
			{LCD_EN, LCD_RS}=2'b11;
			LCD_DATA_VALUE = {4'b0011, pill12And3Duration[3:0]}; 
		end
		toggle_e35: begin
			n_state = toggle_e36;
			{LCD_EN, LCD_RS}=2'b01;
			LCD_DATA_VALUE = {4'b0011, pill12And3Duration[3:0]};
		end
		toggle_e36: begin
			n_state = return_home;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE =8'h65;
		end
		return_home: begin
			n_state = toggle_e37;
			{LCD_EN, LCD_RS}=2'b10;
			LCD_DATA_VALUE =8'h80; //8'h80;
		end
		toggle_e37: begin
			n_state = write_char1;
			{LCD_EN, LCD_RS}=2'b00;
			LCD_DATA_VALUE =8'h80;//8'h80;
		end
	endcase
end

always @ (posedge CLK_400Hz, negedge resetn)
begin
	if (resetn == 0) begin
		p_state <= reset1;
	end
	else
		p_state <= n_state;
end
endmodule