module pulse(
    input clk,
    input rst_n,
    output reg pulse);

    reg [7:0] cnt;

    reg pulse_reg1;

    always @ (posedge clk or negedge rst_n)
        if (!rst_n) begin 
            cnt <= 'd0; 
            pulse_reg1 <= 1'b1; 
        end
        else if (cnt == 'd18) begin
            pulse_reg1 <= 1'b0;
            cnt <= cnt + 1'b1;
        end 
        else if (cnt == 'd199) begin
            cnt <= 'd0;
            pulse_reg1 <= 1'b1;
        end 
        else begin
            cnt <= cnt + 1'b1;
            pulse_reg1 <= pulse_reg1;
        end 

    always @ (posedge clk)
    begin
        pulse      <= pulse_reg1;
    end

endmodule
