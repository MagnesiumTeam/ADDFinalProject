/*
Name: The Magnesium Team (Olanrewaju Ibironke, Su Hui Tan, Anitha Ramesh Puranik, Meghna Chittajallu)
Date: April 14, 2016
Project: Output Wrapper
*/
module OutputWrapper(bitsIn, idAndDurationIn, bitsOut, idAndDurationOut);
input [41:0] bitsIn;
input [13:0] idAndDurationIn;
output [41:0] bitsOut;
output [13:0] idAndDurationOut;

assign bitsOut = bitsIn;
assign idAndDurationOut = idAndDurationIn;
endmodule
