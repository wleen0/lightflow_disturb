module led_pause(
    input clk_out,
    input rst,
    input btn_debounce,
    output reg interrupt_flag);

reg btn_shift;
wire detect;

// Define detect time
always @(posedge clk_out or posedge rst) begin
    if(rst) begin
        btn_shift <= 0;
    end
    else begin
        btn_shift <= btn_debounce;
    end
end

// Detect rise up signal
assign detect = ~btn_shift & btn_debounce;  

// LED signal
always @(posedge clk_out or posedge rst) begin
    if(rst) begin
        interrupt_flag <= 1'b0;
    end
    else begin
        interrupt_flag <= detect ? ~interrupt_flag : interrupt_flag;
    end
end
endmodule