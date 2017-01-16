`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:36 01/15/2017 
// Design Name: 
// Module Name:    servo 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module servo(
    input CLK,
    input [15:0] pulse_len,
    output reg CONTROL_PIN
    );

parameter CLK_F = 50;

reg [15:0] prescaler;
reg [15:0] count = 0;

always @ (posedge CLK)
begin
	prescaler <= prescaler + 1;
	if (prescaler == CLK_F - 1)
	begin
		prescaler <= 0;
		count <= count + 1;
		CONTROL_PIN <= (count < pulse_len);
		if (count == 19999)
		begin
			count <= 0;
		end
	end
end

endmodule
