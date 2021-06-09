// countMod9.
//'timescale 1ns/1ps

module countMod9_tb;

	reg clk, sync_reset, async_reset;
	reg [3:0] load_val;
	reg [1:0] mode;

	wire [3:0] result;
	wire led_out;

	localparam period = 20; // period = 20ns
	localparam STOP = 2'b00, INC_ONE = 2'b01, DEC_TWO = 2'b11, LOAD = 2'b10;

	countMod9 cntMod9_0 (.clk(clk), .sync_reset(sync_reset), .async_reset(async_reset),.load_val(load_val), .mode(mode), .result(result), .led_out(led_out));

	// Generate clock time period = 20ns, freq = 50MHz
	always #10 clk = ~clk;

	initial begin
		clk <= 0;
		sync_reset <= 0;
		async_reset <= 0;
		load_val <= 0;
		mode = STOP;
	end

	initial begin

		#(5);
		async_reset = 1;
		#(period);
		async_reset = 0;
		mode = INC_ONE;
		#(period * 15);

		mode = LOAD;
		load_val = 4'b0101;
		#(period * 2);
		load_val = 4'b1101;
		#(period *2);
		load_val = 4'b1111;
		#(period);

		mode = DEC_TWO;
		#(period * 15);

		mode = STOP;
		#(period * 3)

		mode = INC_ONE;

		sync_reset = 1;
		#(period * 2);
		sync_reset = 0;

		#period
		async_reset = 1;
		#(period / 2)
		async_reset = 0;

		#(period * 4);

		$finish;
	end
endmodule 