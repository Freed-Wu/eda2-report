module count(
    input clk,
    input rst_n,
    input fm_in,
    output reg [31:0] fm_out
    );

    //1Hz分频，产生clk_1s，1s内计数值即为频率
    reg [31:0]cnt;
    reg clk_1s;

    always @ (posedge clk or negedge rst_n)
        if (!rst_n) 
        begin 
            cnt <= 32'h0;
            clk_1s <= 1'b0;
        end
        else if (cnt == 32'd49_999_999)
        begin
            cnt <= 32'h0;
            clk_1s <= ~clk_1s;
        end
        else  cnt <= cnt + 1'b1;

    //1S内计数
    reg [31:0]fm_cnt;

    always @ (posedge fm_in or negedge rst_n)
        if (!rst_n) fm_cnt <= 32'd0;
        else if (!clk_1s) fm_cnt <= 32'd0;
        else fm_cnt <= fm_cnt + 1'b1;

    //获取计数结果
    always @ (negedge clk_1s or negedge rst_n)
        if (!rst_n) fm_out <= 32'd0;
        else fm_out <= fm_cnt;

endmodule
