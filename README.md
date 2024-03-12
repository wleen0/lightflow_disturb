# lightflow_disturb
Here is the example for interrupting the LEDs to brighten or dim. Pushing buttons seems like the most appropriate way to generate intterrupts, yet dealing with the bouncing problem is the first task that needs to be addressed. In addition to pausing and tracking which LED is blinking, the implementation of unfreezing the light flowing from interrupt controller is also included in this subject.

# How it works
**_`top_LEDctrl`_ module**  
A top module to instantiate all the button debouncing, LEDs pausing, and the state of light flowing module.  

**_`de_bounce`_ module**  
Once the button is pushed, the metal parts inside the button begin to connect and disconnect several times. This causes the signal to bounce and transits multiple inputs as shown in the following figure.
The way to fix the problem is to skip the bouning parts.
[!image]https://github.com/wleen0/lightflow_disturb/blob/main/imgs/debounce_btn.png


123
