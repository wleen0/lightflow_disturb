module de_bounce(
    input clk_out,
    input rst,
    input touch,
    output reg btn_debounce
    );
    reg touch_cap;
    reg touch_shift;
    reg [19:0] count;
    parameter count_max = 20'd500000;

// btn signal with two state
    always @(posedge clk_out or posedge rst) begin
        if(rst) begin
            touch_cap <= 1'b0;
            touch_shift <= 1'b0;
        end
        else begin
            touch_cap <= touch;
            touch_shift <= touch_cap;
        end
    end

// counter set 10ms
    always @(posedge clk_out or posedge rst) begin
        if(rst)
            count <= 0;
        else if(touch_shift == ~touch_cap)
            count <= count_max;
        else if(count > 20'd0)
            count <= count - 20'd1;
        else
            count <= 20'd0;
    end

// de_bounce
    always @(posedge clk_out or posedge rst) begin
        if(rst)
            btn_debounce <= 20'd0;
        else
            btn_debounce <= (count == 20'd1) ? ~btn_debounce : btn_debounce;
    end
endmodule
