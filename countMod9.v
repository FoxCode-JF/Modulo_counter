module countMod9 (
	input clk,    				// Clock
	input sync_reset, 		// Synchronous reset
	input async_reset, 		// Asynchronous reset
	input [3:0] load_val, // Value written to output when LOAD mode is active
	input [1:0] mode, 		// STOP = 00 increment (+1) = 01, decrement (-2) = 11, LOAD value = 10
	output [3:0] result,
	output reg led_out 		// Signals when counter value is >4 and <8
);

// reg [25:0] div_cnt_reg;
// wire [25:0] div_cnt_next;
// wire slow_clk;


// Optional code: hardware avilable clock is 50 Mhz. 
// To observe how counter works clock frequency is reduced to 1Hz
// always @(posedge clk, posedge async_reset) begin
// 	if (async_reset) begin
// 		div_cnt_reg <= 0;
// 	end else if (sync_reset) begin
// 		div_cnt_reg <= 0;
// 	end else begin
// 		div_cnt_reg <= div_cnt_next;
// 	end
// end

// assign div_cnt_next = div_cnt_reg + 1;
// assign slow_clk = div_cnt_reg[25];

reg [3:0] cnt_reg, cnt_next;

// always @(posedge slow_clk, posedge async_reset) begin
always @(posedge clk, posedge async_reset) begin
	if (async_reset) begin
		cnt_reg <= 0;
	end else if (sync_reset) begin
		cnt_reg <= 0;
	end else begin
		
		cnt_reg <= cnt_next;
		
		if ((cnt_reg > 3) && (cnt_reg < 7)) begin
			led_out <= 1;
		end else begin
			led_out <= 0;
		end
	end
end

// Combinational block for counter function 
localparam STOP = 2'b00, INC_ONE = 2'b01, DEC_TWO = 2'b11, LOAD = 2'b10;

always @*
	case (mode)
		STOP: 
			cnt_next = cnt_reg; 
		INC_ONE: 
			if (cnt_reg == 8) begin
			 	cnt_next = 0;
			end else begin
				cnt_next = cnt_reg + 1;
			end
		DEC_TWO: begin 
			cnt_next = cnt_reg - 2;
			if (cnt_next > 8) begin
	 			cnt_next = 9 - 2 + cnt_reg; // case when cnt_reg = 1 or cnt_reg = 0
			end
		end
		LOAD: 
		if (load_val > 8) begin
			cnt_next = (load_val - 9);
		end else begin
			cnt_next = load_val;
		end
		default : 
			cnt_next = cnt_reg;
	endcase

assign result = cnt_reg;

endmodule // countMod9