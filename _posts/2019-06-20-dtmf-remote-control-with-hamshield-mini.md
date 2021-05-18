---
title: "DTMF Remote Control with Hamshield Mini"
date: "2019-06-20"
categories:
  - "technical"
tags:
  - "amateur-radio"
  - "dtmf"
  - "ham-radio"
  - "hamshield"
  - "phone"
  - "robotics"
coverImage: "touchtone.jpg"
---
# DTMF Remote Control with Hamshield Mini

![](https://n2wu.files.wordpress.com/2019/06/touchtone.jpg?w=1024)

_Please press 1 for more options_

### Introduction

Here again with a great use of the Hamshield Mini. Touch Tone or [DTMF](https://en.wikipedia.org/wiki/Dual-tone_multi-frequency_signaling) are those little beeps you hear when you press the keypad during a phone call. Also, on HTs when you hold transmit, you can create these tones using your keypad. This is primarily used for offsite repeater configuration, or using a **phone patch** to order a pizza on a repeater. The Hamshield (mini) can send **and receive** these DTMF codes, so I rigged up a little robotics-like receiver with the arduino.

### Setup

As usual, setup your hamshield/hamshield mini as you normally would. Because the hamshield mini doesn't act as a true daughter board to anything, I used an arduino pro mini and customized my pins. As a baseline test, I only had my receiver control an LED, but you can go nuts on this process. So I also connected a resistor and LED from digital pin 12 to ground. I should note I'm using the 3V3, 8Hz version.

![](images/hamshieldled12-1.png)

_Hamshield Mini Schematic_

Now for the code. Once again, it's very basic. I took the Hamshield Github example and stuck a for loop, waiting to hear the tone "1." You can find it [here](https://github.com/KE8JCT/DTMFTest/blob/master/DTMFTest.ino) on my github, but I put the important code below.

```
#define OUTPUT_PIN 12

#define MIC_PIN 3
#define RESET_PIN A3
//#define SWITCH_PIN 2

HamShield radio(A0, A3, A1); // nCS, CLK, DAT
```

```
uint16_t code = radio.getDTMFCode();
    if (code == 1) {
      digitalWrite(OUTPUT_PIN, HIGH);
      Serial.print("It works!");
      delay(1000);
      digitalWrite(OUTPUT_PIN, LOW);
    }
```

The result is a flashing LED.

### In action (sorry for poor quality)

https://www.youtube.com/watch?v=EavahRFl3rs

Watch the LED at the center.

### Applications, Significance, and Further Research

Robots with ham radio. Need I say more? Probably.

The most visible application I can see is on a weather balloon. The HAB crew would have HTs with them, so they could easily make commands while the balloon is mid-flight or or mid-tree. I imagine a servo could replace the LED, and it could drop the load from the chute if its going into the ocean or stuck much too high in a tree.

Because the hamshield is arduino-controlled, you can do almost anything with its pins. The largest problem we encountered was memory - on some scripts (like KISS, more to follow), we easily hit the 75% random memory allocation, causing some setbacks and worry. But clearly the benefits outweigh the cost.

There can be some security concerns with dropping your HAB load on a 2m frequency with just 1 button. I will probably nest the "for" loops and make it a password with 4-5 keypresses.

What applications do you think would work? Have you seen other applications of the Hamshield? Let me know!
