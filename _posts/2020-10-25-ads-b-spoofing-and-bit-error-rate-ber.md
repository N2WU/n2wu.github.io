---
title: "ADS-B: Spoofing and Bit Error Rate (BER)"
date: "2020-10-25"
categories:
  - "technical"
tags:
  - "adsb"
  - "digital-signals"
  - "diy"
  - "ham-radio"
  - "mathematical-modeling"
  - "matlab"
coverImage: "adsb_3.png"
---
# ADS-B: Spoofing and Bit Error Rate (BER)

I tested out my decoding algorithm for ADS-B by conducting a spoofing attack and a Bit Error Rate (BER) analysis. I learned a little bit more about the packet composition and construction of these 1090 MHz signals, and I hope to share that with you!

![](https://n2wu.files.wordpress.com/2020/10/adsb_3.png?w=1024)

As usual, I am referencing [this](https://web.stanford.edu/class/ee179/labs/LabFP_ADSB.html) Stanford resource and [this other web resource](https://mode-s.org/decode/adsb/introduction.html) for packet information.

## Packet Construction

ADS-B packets are surprisingly (alarmingly) simple to make. They are only constructed through pulse-position modulation, meaning a "1" means the signal is on. and a "0" means the signal is off. This made it pretty easy to design. I have a cosine wave multiplied by some amplitude - my amplitude can only be 1 or 0.

```
Amplitudes = [0 0 1 1 1 0 0 1 0 1 0]signal = Amplitudes * cos (2*pi*omega * t)
```

The only challenge in this part was choosing _omega_, the angular frequency. I used the equation for the Nyquist limit; meaning, I have to sample my signal and two times the highest frequency I encounter to preserve my data. I decided to transmit at 4 MHz, downsample, and eventually decode my signal at 2 MHz.

## Spoofing

To spoof my signal, I just had to create data fields to make a binary bitstream for the above cosine signal. Since ADS-B is decoded into a hexadecimal format, I simply converted the individual parts from hex to binary, then combined them (with preamble) as shown below.

![](https://n2wu.files.wordpress.com/2020/10/data.png?w=537)

_Spoofed packet_

Once again, I had to take the sample rate into consideration. I actually had to upsample my data to get it to 4 MHz. I used this clever algorithm to do it:

```
for k=1:length(tt)     if mod(tt(k), 2) == 0 %even number          signal(k) = bit(k/2)* cos(2pif * tt(k));     else          signal(k) = bit(k/2 + .5)* cos(2pif * tt(k));     endend
```

So if either the time is _odd_ or _even_, it still transmits the same bit. I looked up the hex code I was "transmitting" and found it in the middle of the atlantic:

![](https://n2wu.files.wordpress.com/2020/10/spoofed_flight.png?w=399)

_Spoofed Signal_

## BER Analysis

I borrowed my decoding algorithm from a previous post to see how well my spoofed signal could be decoded. Obviously, without any atmospheric noise, it could be decoded quite well. I decided to test the limits of this. The MATLAB function awgn() generates a noise-added signal based on Signal-to-noise ratio, SNR. A decreased SNR means the signal is harder to receive.

Here is my first run at an SNR of 20. I had no problems receiving the signal.

![](https://n2wu.files.wordpress.com/2020/10/output_1.png?w=1024)

To do this BER, I used an **xor()** gate. Basically, I overlapped the two signals. If there were any difference, the xor would return a "1" at some point. If I had only zeros, I was good to go.

![](https://n2wu.files.wordpress.com/2020/10/ber.png?w=188)

_First Run with BER_

I made a **while()** loop that slightly decreased SNR of my signal until I found an error between the transmitted and received, decoded signal. This would result in an error for an actual ADS-B decoding machine. However, the actual device is much more complex and employs parity bits at the end of the packet transmission. My algorithm became unstable at 13 SNR.

![](https://n2wu.files.wordpress.com/2020/10/output_2_13snr.png?w=1024)

_Unstable SNR @ 13_

## Conclusion

This exercise taught me more about transmission and reception of ADS-B signals. I was able to generate a spoofed packet from some prior data, modulate it through a sinusoid, and decode it through previous algorithms. Further, I was able to conduct a bit error rate analysis on the signal.

In the future, I want to see what this looks like graphically. I can split further into the "data" section of the signal and change some of the parameters instead of using pre-set ones; I wonder what a swarm of GPS-edited signals would look like on a heads-up display. Also, my BER could probably be improved with more research on ADS-B decoding, as the FCC rulebook states the signal must stay within 2dB of "on" and "off."

These signals are fascinating and a great way to take an in-depth look into digital signal processing.
