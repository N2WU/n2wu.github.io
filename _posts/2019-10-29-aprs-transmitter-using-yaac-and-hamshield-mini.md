---
title: "APRS using YAAC and Hamshield"
date: "2019-10-29"
categories:
  - "technical"
tags:
  - "aprs"
  - "arduino"
  - "gps"
  - "ham-radio"
  - "hamshield"
  - "raspberry-pi"
  - "yaac"
coverImage: "work.png"
---

# APRS using YAAC and Hamshield

Finally, I finished the GPS transmitter. It's sort of roundabout but it accomplishes the following:

1. Relatively Cheap
2. Open-Sourced, customizable
3. Portable
4. _Relatively_ Effective, as you'll soon see

It isn't terrible to finally set up, and if you're looking for a cheap, modular option this may stand a fighting chance.

![](https://n2wu.files.wordpress.com/2019/10/work.png?w=800)

Elmer agrees!

## Components

For this project you will need:

- [Raspberry Pi Zero](https://www.adafruit.com/product/2885?gclid=CjwKCAjwo9rtBRAdEiwA_WXcFmtz_-6Uvw0bs7Ihk4un0nWHBOV7P1vwVUf8gUQX58PAhOQ7HWwu2BoCYMUQAvD_BwE) (and desk station to test everything)
- [Arduino Pro Mini](https://www.adafruit.com/product/2377?gclid=CjwKCAjwo9rtBRAdEiwA_WXcFl-Xu3d8n37yzKyzoa5UHUtdJV6MxPTyp4oE-xZbyBYBUR5Jdsb-zBoCT-4QAvD_BwE) (I used 3.3 Volt, 8MHz version)
- [Arduino FTDI Connection](https://www.robotshop.com/en/ftdi-basic-breakout-3-3v-6-pin-header.html?gclid=CjwKCAjwo9rtBRAdEiwA_WXcFohTRelv5vW5DfvrigX6cMzohAv816PSpz5uujDEELlfOgrEe2wiThoCO50QAvD_BwE) and USB-USB Mini Cable
- [Hamshield Mini](https://inductivetwig.com/products/hamshield-mini)
- Antenna (something like [this](https://www.gigaparts.com/diamond-antenna-srh789.html?gclid=CjwKCAjwo9rtBRAdEiwA_WXcFuoFWcKMdZaT3rB_sXvwBC0Ff9wMIOeNcr19OUro4ARoi9LNjt6sbRoCSz0QAvD_BwE))
- [Phone Charger](https://www.amazon.com/Anker-PowerCore-Ultra-Compact-High-Speed-Technology/dp/B0194WDVHI/ref=asc_df_B0194WDVHI/?tag=hyprod-20&linkCode=df0&hvadid=198138936631&hvpos=1o1&hvnetw=g&hvrand=11855882216367774373&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9004201&hvtargid=aud-798931705416:pla-366540057336&psc=1), or get creative with your own power
- [GPS Module](https://www.amazon.com/Receiver-Antenna-Gmouse-Laptop-Navigation/dp/B073P3Y48Q/ref=asc_df_B073P3Y48Q/?tag=hyprod-20&linkCode=df0&hvadid=312195667633&hvpos=1o2&hvnetw=g&hvrand=3739433251211294964&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9004201&hvtargid=aud-798931705416:pla-570983584545&psc=1) (USB used for less headaches but you can use serial)
- USB Hub, USB-USB Micro cable, USB Female-USB Micro Cable

It sounds like a lot, but for most experimenters this project is simply scattered around in other projects. Other than the Hamshield Mini, which should be a household name by the amount I've talked about it, all of these are very common robotics items. Below is a block diagram used to connect all the devices together.

![](https://n2wu.files.wordpress.com/2019/10/aprsblockdiagram.png?w=508)

The Pi is the hub of this system, and gets its inputs via serial.

In the prototype model I made, you can use USB connections for the battery, GPS, and arduino FTDI. While this guarantees reliable, modular connections, they tend to be bulky.

## Setup

### 1\. Hamshield Setup

First, connect the Hamshield Mini, Arduino Mini, and Arduino FTDI. Below is a schematic to connect the hamshield to the arduino:

![](https://n2wu.files.wordpress.com/2019/10/hamshieldled12.png?w=720)

The LED is not used but can be configured for testing. As usual, I am not messing with the Hamshield Code. I used the KISS example.ino configured for aprs. My code is available on [github](https://github.com/KE8JCT/APRS_KISS) as always, but it is the same as the Hamshield example with the APRS frequency changed (144.390 MHz) set up specifically for the Hamshield Mini. Below is the important code piece for initializing the Mini:

```
HamShield radio(A0, A1, A3); // nCS, CLK, DAT
```

You can hard solder the arduino to the Hamshield, or leave it connected to a breadboard for added bulk. Again you have a tradeoff between modular ability and space.

### 2\. Raspberry Pi Setup

This one took a while to master. You need to install [YAAC](https://www.ka2ddo.org/ka2ddo/YAAC.html) on the raspberry pi. The easiest way to do this is set up a test machine with pi, keyboard, monitor, and mouse, connect your radio and gps, then use the wizard to set up your options. USB connections are usually a breeze through the wizard, however your GPS may take a while to set up if it is not connected. I recommend working outside or setting up close to a window for adequate connection; my location of lead and granite required I be outside.

If your station works at this point, congratulations! Ensure it transmits packets and GPS data from the desktop state. Next, you will need to configure YAAC to run headless on startup. I used [this article](https://www.dexterindustries.com/howto/run-a-program-on-your-raspberry-pi-at-startup/) and found what works for me. Enter this for bashrc:

```
sudo nano /home/pi/.bashrc
```

Then add this to the bottom:

```
java -jar YAAC.jar
```

If at first you don't succeed, try again and ask me for any help.

### 3\. Final Setup

Connect your antenna and all USB devices, then battery last. Ensure the proper LEDs are illuminated (blinking GPS, constant RX LED on Hamshield, and PWR LED on Pi), then stick it in a case. Take it for a stroll and see if you transmit. It is very much a "trial by error" project. It does not consume much power.

## Testing

Due to my location, I do not always transmit my packets. I often take the device on bike rides and can get a semi-accurate reading. We recently created an I-gate for our QTH, so when the weather improves I will have more results.

![](https://n2wu.files.wordpress.com/2019/10/aprstoroom.png?w=1024)

APRS at W2KGY (via aprs.fi)

The power output is only 300mW, but I have sent packets almost 7 miles away. The device gets somewhat warm but not an unhealthy amount. Below is a picture of me on the bike:

![](https://n2wu.files.wordpress.com/2019/10/aprsbike.jpg?w=768)

A very nice bike with a less-nice radio...

## Expansions

The modular capabilities of YAAC and the microcontrollers prove especially useful to customizing the project. In particular, telemetry will be a convenient way to measure and report statistics in the device. A weather balloon, that already has a raspberry pi, only needs two USB ports and can then run its own APRS transmitter.

3D-printing a custom case with more solidified connections will also decrease size and increase durability. The case right now is marginally bulky, but can lose size in shorter cords and a more robust packing system.

## Conclusion

While slightly larger than the expected size, you can make a cheap APRS transmitter using robotics parts every ham has. The device remains true to my open-source, modular, cheap (and marginally effective) mission statement. What do you think?
