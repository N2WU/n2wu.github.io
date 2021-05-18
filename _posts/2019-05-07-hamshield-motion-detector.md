---
title: "Hamshield Motion Detector"
date: "2019-05-07"
categories:
  - "technical"
tags:
  - "aprs"
  - "arduino"
  - "ham-radio"
  - "hamshield"
  - "ke8jct"
  - "w2kgy"
coverImage: "metaphor.png"
---
# Hamshield Motion Detector

I took a slight detour off of the APRS project I previously mentioned to show off the immediate capabilities of the Hamshield Mini. While I preached its battlefield capabilities, the goal of APRS is much more impressive. In this post I plan to dissect how I made it.

![](images/metaphor.png)

One day you'll grow...

### BLUF: PIR + Hamshield Mini

I cobbled arduino code with some open source PIR sensor code and made it auto-report. That simple. My code is on [github](https://github.com/KE8JCT/MotionDetector), you need the hamshield and dds libraries. Here are some pictures:

- ![](images/img_20190502_195850513.jpg)

- ![](images/img_20190502_195859053.jpg)


### The Setup

The entire setup runs off of an Anker phone charger and a recently-deceased mouse cable. The hamshield is awfully soldered on top of the 3V3 Arduino Pro Mini, and the PIR sensor joins in on the hackneyed fun. Getting the Hamshield Mini to connect was probably my biggest obstacle, so here's a general schematic I used to connect it:

![](images/hamshieldmini-1.png)

This will work for most Hamshield examples.

It _works_. Don't know exactly why, and don't really ask questions.

### The Code

I used [this example](https://github.com/EnhancedRadioDevices/HamShield/blob/master/examples/AFSK_SerialMessenger/AFSK_SerialMessenger.ino) for AFSK and modded it to auto-report without a serial input. I then mashed it with a [PIR tutorial](https://learn.adafruit.com/pir-passive-infrared-proximity-motion-sensor/using-a-pir-w-arduino), cut off anything unnecessary, and compiled it. The github is posted above, but really it checks for a "high" read from the PIR, then sends the code if motion is detected.

### The Future

In theory, for APRS I'll just have to disconnect the PIR sensor, add a GPS, and auto-report position. _Wrong._ Hamshield has a weird way of forming packets that will take me quite a while to figure out. Eventually I can add telemetry - altitude, pressure, all to a data format. I hope this article helped you get to the fledgling stages of the Hamshield Mini; truly I may never fully realize this thing's potential.
