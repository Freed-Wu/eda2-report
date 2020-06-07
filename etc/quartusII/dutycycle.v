module dutycycle(
    input clk,
    input rst_n,
    input wave_in,
    output reg [31:0] pos_out,  //输出高电平计数结果
    output reg [31:0] neg_out  //输出低电平计数结果
    );


// ************************************************
//                      输入脉冲上升沿检测
// ************************************************

reg syn1;
reg syn2;

always @ (posedge clk)
begin
    syn1 <= wave_in;
    syn2 <= syn1;
end

wire wave_pos = syn2 & (~syn1);
//wire wave_neg = (~syn2) & syn1;


// ************************************************
//                      高电平低电平计数
// ************************************************

reg [31:0]cnt_pos;      //高电平计数器
reg [31:0]cnt_neg;      //低电平计数器

always @ (posedge clk or negedge rst_n)
    if (!rst_n) begin
        cnt_pos <= 32'd0;
        cnt_neg <= 32'd0;
        pos_out <= 32'd0;
        neg_out <= 32'd0;
    end                          
    else if (wave_pos) begin
        cnt_pos <= 32'd0;
        cnt_neg <= 32'd0;
        pos_out <= cnt_pos;
        neg_out <= cnt_neg;
    end
    else if (syn1)  cnt_pos <= cnt_pos + 1'b1;
    else    cnt_neg <= cnt_neg + 1'b1;  

endmodule
