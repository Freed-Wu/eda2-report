module divider (
	input clk, output d48k, d96k, d24M, d48M
);
reg d48k = 0, d96k = 0, d24M = 0, d48M = 0;
reg [25:0] c48k = 0, c96k = 0, c24M = 0, c48M = 0;
always @(posedge clk) begin
	if (c48M == 48e6) begin
		c48M <= 0;
		d48M <= ~d48M;
	end
	else begin
		c48M <= c48M + 1;
	end
	if (c24M == 24e6) begin
		c24M <= 0;
		d24M <= ~d24M;
	end
	else begin
		c24M <= c24M + 1;
	end
	if (c96k == 96e3) begin
		c96k <= 0;
		d96k <= ~d96k;
	end
	else begin
		c96k <= c96k + 1;
	end
	if (c48k == 48e3) begin
		c48k <= 0;
		d48k <= ~d48k;
	end
	else begin
		c48k <= c48k + 1;
	end
end

endmodule

