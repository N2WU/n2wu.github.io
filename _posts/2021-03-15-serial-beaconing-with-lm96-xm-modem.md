---
title: "Phase Synchronization for Ettus X310""
date: "2021-03-15"
categories:
  - "technical"
tags:
  - "arduino"
  - "coding"
  - "diy"
  - "how-to"
  - "mathematical-modeling"
  - "modem"
  - "radio"
---
# Phase Synchronization for Ettus X310"
I just got a hold of some surplus parts in our robotics lab, so I made one into a quick FSK serial transmitter out of the [LM96 /XM modem for 915 MHz](https://www.sparkfun.com/products/retired/559). Take a look!

#### Setup

I used an Arduino Uno microcontroller with the [following code](https://github.com/KE8JCT/lm96). I had the device in TTL Serial mode (no extra jumpers or configuration necessary and had the following pinout. I had to be more than forceful with some of the wires because they came stranded.

<table><tbody><tr><td>Radio Pin</td><td>Arduino Pin</td></tr><tr><td>1. GND</td><td>GND</td></tr><tr><td>2. VCC</td><td>5V</td></tr><tr><td>3. TXD</td><td>Pin D6</td></tr><tr><td>4. RXD</td><td>Pin D5</td></tr><tr><td>5. SignalGround</td><td>GND</td></tr><tr><td>6. AXTD</td><td>Unconnected</td></tr><tr><td>7. BTXD</td><td>Unconnected</td></tr><tr><td>8. SLEEP</td><td>GND</td></tr><tr><td>9. RESET</td><td>Unconnected</td></tr></tbody></table>

_Pinouts for Serial Transmitter_

#### Code

The code uses a Software Serial example modified to transmit continuously. First, you have to modify the TX and RX fields accordingly. The TX of the radio is the RX of the arduino, and vice versa.

```
SoftwareSerial mySerial(6, 5); // RX, TX
```

Next, you can change the loop() script to continuously transmit without a serial input message:

```
void loop() { // run over and over

    Serial.write("This is a test!");

    mySerial.write("This is a test!");
```

#### Reception

This module transmits clearly when received by a nearby RTL-SDR:

![](https://n2wu.files.wordpress.com/2021/03/capture.png?w=1024)

_Spectrum of Module_

The signal clearly has a frequency shift of about 800 kHz, which is not unnoticeable.

I created a flowgraph to analyze and decode the information, but both packet modulation and demodulation will need some work in that regard. Here is a quick flowgraph and visual display:

![](https://n2wu.files.wordpress.com/2021/03/screenshot-from-2021-03-14-23-33-08.png?w=1024)

_Flowgraph with simple FFT and GFSK demod_

![](https://n2wu.files.wordpress.com/2021/03/screenshot-from-2021-03-14-21-04-24.png?w=1024)

_Spectrum on HackRF and Time Sink_

More work has to be done on the FSK decoding, which will be its own entire blog post. Thanks for stopping by!
