module top_LEDctrl(
    input clk,
    input reset,
    input touch,
    output [3:0] led
    );
wire btn_debounce;
wire interrupt_flag;

parameter count_max = 20'd500000;
parameter us_max = 9'd500, ms_max = 8'd100, s_max = 8'd100;

de_bounce #( .count_max(count_max)) de_vibrate(
    .clk_out(clk),
    .rst(reset),
    .touch(touch),
    .btn_debounce(btn_debounce)
);

led_pause disturbLED(
    .clk_out(clk),
    .rst(reset),
    .btn_debounce(btn_debounce),
    .interrupt_flag(interrupt_flag)
);

blink_time #( .us_max(us_max), .ms_max(ms_max), .s_max(s_max)) gradualLight(
    .clk_out(clk),
    .rst(reset),
    .interrupt_flag(interrupt_flag),
    .led(led)
);
endmodule