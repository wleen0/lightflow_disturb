`timescale 1ns/1ns

module top_LEDctrl_tb();
reg clk, reset;
reg touch;
wire [3:0] led;
parameter count_max = 20'd10; // set time 200ns
top_LEDctrl #( .count_max(count_max))
    control( .clk(clk), .reset(reset), .touch(touch), .led(led));

initial begin
    clk = 0;
    reset = 1;
    touch = 0;
    #60
    reset = 0;
    #100
    touch = 1'b1;
    #40       // assume oscillate
    touch = 1'b0;
    #30
    touch = 1'b1;
    #300
    touch = 1'b0; // release button
    #50         // oscillate
    touch = 1'b1; 
    #30
    touch = 1'b0; // stop oscillate
 
    #1000
    touch = 1'b1; // re-push button
    #40       // assume oscillate
    touch = 1'b0;
    #30
    touch = 1'b1;
    #300
    touch = 1'b0; // release button
    #50         // oscillate
    touch = 1'b1; 
    #30
    touch = 1'b0; // stop oscillate

    #109200000
    touch = 1'b1;
    #40       // assume oscillate
    touch = 1'b0;
    #30
    touch = 1'b1;
    #300
    touch = 1'b0; // release button
    #50         // oscillate
    touch = 1'b1; 
    #30
    touch = 1'b0; // stop oscillate
 
    #1000
    touch = 1'b1; // re-push button
    #40       // assume oscillate
    touch = 1'b0;
    #30
    touch = 1'b1;
    #300
    touch = 1'b0; // release button
    #50         // oscillate
    touch = 1'b1; 
    #30
    touch = 1'b0; // stop oscillate
    
end

always #10 clk = ~clk;
endmodule