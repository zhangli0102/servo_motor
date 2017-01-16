`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:30:17 01/10/2017 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
    input CLK,
    input switch_input,
    output reg state,
    output trans_up,
    output trans_dn
    );

reg sync_0, sync_1;
always @ (posedge CLK)
begin
	sync_0 = switch_input;
end

always @ (posedge CLK)
begin
	sync_1 = sync_0;
end

reg [16:0] count;
wire idle = (state == sync_1);
wire finished = &count;

always @ (posedge CLK)
begin
	if(idle)
	begin
		count <= 0;
	end
	else
	begin
		count <= count + 16'd1;
		if(finished)
		begin
			state <= ~state;
		end
	end
end

assign trans_dn = ~idle & finished & ~state;
assign trans_up = ~idle & finished & state;

endmodule
