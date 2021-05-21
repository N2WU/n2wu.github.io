---
title: "Digital Logic CW Beacon"
date: "2021-05-21"
categories:
  - "technical"
tags:
  - "amateur-radio"
  - "digital-logic"
  - "shift-register"
  - "microcontroller"
  - "morse-code"
  - "ham-radio"
  - "pcb-design"
coverImage: "/assets/img/pcb.png"
---
# Introduction

Hello again, now on the new website! As a parting gift for some friends, I made an overly complicated CW beacon capable of reading morse code bits and flashing out through an LED. I will show the logic process, the schematic, and the PCB design.

Of course, this whole thing can be accomplished through a single Arduino. But this is _way_ more fun.

![Finished Board](/assets/img/pcb.png)
_Finished Board_

# Problem Statement

What I needed was a board capable of CW output through an LED. I needed _upwards of 33 bits_ to encode CW data (all series of clock pulses) out to an LED. I ended up going with 4 characters, which fits nicely with my simplified and "shortcutted" timing requirements.

How I decided to solve this was through shift registers, counters, timers, and flip flops. I used a decade counter (10) to iterate through the following steps:


| Clock Pulse | Event |
| ----------- | ----------- |
| 1   | Load Shift Registers       |
| 2   | Bit 0 (LSB)       |
| 3   | Bit 1       |
| 4   | Bit 2       |
| 5   | Bit 3       |
| 6   | Bit 4       |
| 7   | Bit 5       |
| 8   | Bit 6       |
| 9   | Bit 7 (MSB)      |
| 10  | Flip-flop       |



## Integrated Circuits Used

### 555 Timer
  A simple LM555CN Timer fed the clock pulses for this circuit, with a 47 k Ohm, 2.2k Ohm resistor, and a 0.1 and 1 uF capacitor.

### 74LS165

I used the 74LS165, or the 8-bit shift register, to load all my data. I used the following formula to hard-code all my CW output with bits:

---
  CW Dit = 1 bit  
  CW Dah = 3 bits  
  CW Space = 1 bit  
  CW Character Space = 5 bits  
  CW Word Space = 7 bits  

---

In my code, I cut off the character spaces since I only had 8 spaces. This is imperfect binary since characters like "O" are much longer than "i" or "e". My bits for the word are simply wired +5V or GND, LSB from pin 1 on the 74LS165.

### 74LS153

This chip is the "train station" of the whole operation. As serial input flows from all 74LS165 chips, this is responsible for controlling what pin comes through and outputs directly to the LED.

### 74LS186

### CD4027

### CD4017



## Schematic

## PCB Design

## Conclusion
