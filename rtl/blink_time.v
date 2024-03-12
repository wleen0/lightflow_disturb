module blink_time(
    input clk_out,
    input rst,
    input interrupt_flag,
    output reg [3:0] led
    );
    reg brightness;
    reg [3:0] switch_flag;
    reg [8:0] count_us;
    reg [9:0] count_ms;
    reg [9:0] count_s;
    parameter us_max = 8'd50, ms_max = 10'd1000, s_max = 10'd1000;
    
    // Count in microseconds
    always @(posedge clk_out or posedge rst) begin
        if(rst)
            count_us <= 8'd0;
        else if(interrupt_flag)
            count_us <= count_us;
        else
            count_us <= (count_us < us_max-8'd1) ? count_us + 8'd1 : 8'd0;
    end
    
    // Count in miliseconds
    always @(posedge clk_out or posedge rst) begin
        if(rst)
            count_ms <= 10'd0;
        else if(interrupt_flag)
            count_ms <= count_ms;
        else if(count_us == us_max-8'd1 && count_ms == ms_max-10'd1)
            count_ms <= 10'd0;
        else
            count_ms <= (count_us == us_max-8'd1) ? count_ms + 10'd1 : count_ms;
    end
    
    // Count in seconds
    always @(posedge clk_out or posedge rst) begin
        if(rst)
            count_s <= 10'd0;
        else if(interrupt_flag)
            count_s <= count_s;
        else if(count_us == us_max-8'd1 && count_ms == ms_max-10'd1 && count_s == s_max-10'd1)
            count_s <= 10'd0;
        else
            count_s <= (count_us == us_max-8'd1 && count_ms == ms_max-10'd1) ? count_s + 10'd1 : count_s;
    end
    
    //  Light turn on or off
    always@(posedge clk_out or posedge rst) begin
        if(rst)
            brightness <= 1'b1;
        else if(interrupt_flag)
            brightness <= brightness;
        else
            brightness <= (count_us == us_max-8'd1 && count_ms == ms_max-10'd1 && count_s == s_max-10'd1) ? ~brightness : brightness;
    end
    
    //  Light sequence
    always @(posedge clk_out or posedge rst) begin
        if(rst)
            switch_flag <= 4'b0001;
        else if(interrupt_flag)
            switch_flag <= switch_flag;
        else
            switch_flag <= (~brightness && count_us == us_max-8'd1 && count_ms == ms_max-10'd1 && count_s == s_max-10'd1) ? {switch_flag[2:0], switch_flag[3]} : switch_flag;
    end
    
    // Light turn on time
    always @(posedge clk_out or posedge rst) begin
        if(rst)
            led <= 4'd0;
        else if(interrupt_flag)
            led <= switch_flag;
        else begin
            case(switch_flag)
                4'b0001: begin
                    case(brightness)
                        1'b1: led[0] <= (count_ms <= count_s) ? 1'b1 : 1'b0;
                        1'b0: led[0] <= (count_ms > count_s) ? 1'b1 : 1'b0;
                    endcase
                end
                4'b0010: begin
                    case(brightness)
                        1'b1: led[1] <= (count_ms <= count_s) ? 1'b1 : 1'b0;
                        1'b0: led[1] <= (count_ms > count_s) ? 1'b1 : 1'b0;
                    endcase
                end
                4'b0100: begin
                    case(brightness)
                        1'b1: led[2] <= (count_ms <= count_s) ? 1'b1 : 1'b0;
                        1'b0: led[2] <= (count_ms > count_s) ? 1'b1 : 1'b0;
                    endcase
                end
                4'b1000: begin
                    case(brightness)
                        1'b1: led[3] <= (count_ms <= count_s) ? 1'b1 : 1'b0;
                        1'b0: led[3] <= (count_ms > count_s) ? 1'b1 : 1'b0;
                    endcase
                end
                default:;
            endcase
        end
    end
endmodule
