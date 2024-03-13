# lightflow_disturb
Here is the example for interrupting the LEDs to brighten or dim. Pushing buttons seems like the most appropriate way to generate intterrupts, yet dealing with the bouncing problem is the first task that needs to be addressed. In addition to pausing and tracking which LED is blinking, the implementation of unfreezing the light flowing from interrupt controller is also included in this subject.

# How it works
**_`top_LEDctrl`_ module**  
A top-level module to instantiate all the button debouncing, LEDs pausing, and the state of light flowing module.  

**_`de_bounce`_ module**  
Once the button is pushed, the metal parts inside the button begin to connect and disconnect several times. This causes the signal to bounce and transits multiple inputs as shown in the following figure.  
By generating the signal for debouncing, with the extra delay time set to avoid the bouncing periods.
![GITHUB](https://github.com/wleen0/lightflow_disturb/blob/main/imgs/debounce_btn.png)

**_`led_pause`_ module**  
Calculate and find the rising edge of the debounce signal, which signifies the moment when the interrupt is triggered.
![GITHUB](https://github.com/wleen0/lightflow_disturb/blob/main/imgs/signal_detect.png)

**_`blink_time`_ module**  
LEDs are brightening and dimming in sequence. When the interrupt signal occurs, the switch_flag signal will indicate which LED is paused.
Refer to the example below, the brightness of the flowing light is controlled by comparing the numbers between counter1 and counter2.
![GITHUB](https://github.com/wleen0/lightflow_disturb/blob/main/imgs/light_brightness.png?raw=true)

# Testing
Debugging the source code and the testbench can be implemented with Vivado and ModelSim. If the testbench is executed in Visual Studio Code, it also requires Icarus Verilog and GTKWave.

# Reference
* https://zipcpu.com/blog/2017/08/05/bounce-metric.html
* https://www.cnblogs.com/WenGalois123/p/16360216.html
* https://www.allaboutcircuits.com/technical-articles/introduction-to-microcontroller-timers-pwm-timers/
