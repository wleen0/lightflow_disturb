# lightflow_disturb
Here is the example for interrupting the LEDs to brighten or dim. Pushing buttons seems like the most appropriate way to generate intterrupts, yet dealing with the bouncing problem is the first task that needs to be addressed. In addition to pausing and tracking which LED is blinking, the implementation of unfreezing the light flowing from interrupt controller is also included in this subject.

# How it works
**_`top_LEDctrl`_ module**\n
A top module to instantiate all the button debouncing, LEDs pausing, and the state of light flowing module.

