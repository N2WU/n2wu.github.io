---
title: "10m HF WSPR Beacon for HAB"
date: "2021-05-07"
categories:
  - "technical"
tags:
  - "amateur-radio"
  - "antenna"
  - "balloonsat"
  - "diy"
  - "ham-radio"
  - "hf"
  - "mathematical-modeling"
  - "qrp"
  - "weather-balloon"
  - "wspr"
coverImage: "vswr.jpg"
---
# 10m HF WSPR Beacon for HAB
One of my more aspirational payloads for the weather balloon used a WSPR beacon to characterize the change in the ionosphere's height over the course of several hours. Here I describe my methods for installation and the antenna used for the design. Enjoy!

![](https://n2wu.files.wordpress.com/2021/05/splash.png?w=846)

## Beacon

![](https://n2wu.files.wordpress.com/2021/05/wspr_beacon.jpg?w=800)

_WPSR Beacon_

I used the [Ultimate 3S kit](http://www.qrp-labs.com/ultimate3/u3s.html) for the beacon. It was relatively straightforward to build and assemble, but you have to be pretty experienced to do this. Some of the leads are millimeters apart and winding bifilar toroids are never fun. If you have prior soldering experience this is a chance to learn something new.

I used the basic everything, no power amplifiers, and no GPS.

## Setup

In setup, I set my location as static FN31. I don't imagine this is the right way to do things.

The device's main form of calibration comes in the form of frequency correction. The oscillator for the unit is on average 4kHz above predicted. If you attempt to tune to an incredibly specific frequency channel, you will be 4 kHz above and ineffective. I used a frequency counter (from the 90s in our lab) to find this frequency.

![](https://n2wu.files.wordpress.com/2021/05/freq_counter.jpg?w=622)

_WSPR Beacon connected to frequency counter_

I set my frequency to 28 MHz and used the following math:

```
Set Frequency: 28.1289 MHz
Observed Frequency: 28.1246 MHz
Frequency Difference: 4.3 kHz
Ratio: 4.3/28129 = x/27400
x = shift of 4.1281 kHz
```

## Antenna: J-Pole

For the antenna, I needed a low-weight element with relatively short lengths suited for 10m. Looking online I found a [patent in 1909](https://www.aktuellum.com/mobile/circuits/antenna-patent/patents/225204.pdf) for a J-pole off of a vehicle balloon. I used 22gauge stranded wire build using this [online calculator](https://www.hamuniverse.com/jpole.html) to measure the lengths for my antenna.

I also simulated this device on EZNEC. I actually got about 1dB of gain suited well for my WSPR Frequency!

![](https://n2wu.files.wordpress.com/2021/05/j_pole_1.png?w=665)

_EZNEC simulation_

Azimuth and Elevation plots:

![](images/azimuth_jpole.png)

![](images/el_jpole.png)

The SWR graph:

![](https://n2wu.files.wordpress.com/2021/05/swr.png?w=954)

My SWR and smith chart for the antenna looks less than favorable. I measured it within a classroom (actually hanging out the window of a building), so I imagine most of my error came from this.

![](https://n2wu.files.wordpress.com/2021/05/vswr.jpg?w=1024)

_Chart using NanoVNA. SWR lowest at 24.3 MHz with <3:1._

## Other Antenna Thoughts

I did actually simulate some other designs but abandoned them due to infeasibility. I tried an upside-down vertical but that had no place to put 2.5m of verticals. Similarly, a center-fed dipole with its top element tied to the balloon string would not survive jet-stream thrashing /and/ required a matching scheme (weight) to get the 75-ohm match down to 50 ohms.

## Failure

We had the long wires of the j pole stuck through the bottom of our high-altitude balloon - they actually give somewhat of a bearing for the whole flight.

![](https://n2wu.files.wordpress.com/2021/05/j_pole_hab-1.png?w=722)

_HAB Camera with visible J-pole elements!_

However, we did not get any readings over the course of the flight. I imagine our error came from power issues. We connected every device to a central parallel power unit I made which experienced some issues at the launch site. The rest of our modules worked, but the beacon requires strict timing. A lack of internet on the site made my source of time unreliable, so when I tried to sync the device I may have been off. If we had an intermittent power-off, the beacon would be useless.

![](https://n2wu.files.wordpress.com/2021/05/10m_wspr.png?w=558)

_The Goal: 10m WSPR propagation in Europe_

## Conclusion

This device was promising. It potentially would allow for great characterization of the ionosphere, but failed due to unreliable power on the payload.

In future prospects, I want to fix the antenna. Right now I am working on a [W3EDP End-fed wire antenna](https://www.qsl.net/dk7zb/Wire-Antennas/w3edp.htm) that could possibly dangle off the side - apparently end-feds were designed for Zeppelins and Aircraft! My ends to the J-pole became extremely twisted and unreliable, so ladder line or a single vertical would be more beneficial. I have also seen designs that use a center-fed dipole tied to the string!

I also want to improve the timing and power system. If I connect a high-altitude GPS to the beacon, I eliminate all problems with tracking.

![](https://n2wu.files.wordpress.com/2021/05/zepp.png?w=740)

_Next payload?_

Thanks for reading, and stay tuned for the next HF beacon!
