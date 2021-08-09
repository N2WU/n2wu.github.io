---
title: "GNURadio and DEFCON 29 RFHS CTF"
date: "2021-08-08"
categories:
  - "Technical"
tags:
  - "amateur-radio"
  - "gnuradio"
  - "dsp"
  - "mathematical-modeling"
  - "hacking"
  - "defcon"
  - "programming"

coverImage: "/assets/img/defcon/cover.png"
---
# Introduction

I recently had the awesome opportunity to attend DEFCON29 in person. However, a lot of the fun happened virtually. The [Radio Frequency Hacker Sanctuary](https://rfhackers.com/) launched a virtual [capture-the-flag](https://forum.defcon.org/node/236762) event involving digital signal processing, quick thinking, and gnuradio. Continue reading for my nearly complete solution to one of the tests with my .grc found [here](https://github.com/N2WU/RF_CTF).

![Title Image](/assets/img/defcon/cover.png)

# Problem

Essentially for each stage of the [SDR ctf](https://github.com/rfhs/rfhs-wiki/wiki/RF-CTF-SoftwareDefinedRadio-Challenges) you are given a ZMQ port to listen on in gnuradio via [these blocks](https://github.com/rfhs/rfctf-sdr-tools). You poke around on the ports for the correct signal, and get decoding.

I tried the morse challenge first since it seemed the most straightforward. The WiFi and World Wide Wardrive also seem promising. Below is the raw spectrum for my signal:

![CW_Spectrum](/assets/img/defcon/spectrum.PNG)

And each transmission starts with this cool design in the waterfall:

![Waterfall](/assets/img/defcon/waterfall_1.PNG)

# USB Reception

Using the [custom flowgraph](https://github.com/rfhs/rfctf-sdr-tools) as mentioned earlier, you already get a headstart with receiving. Remember to save your project as something different, since you may need to start back at square one (as I have done several times). The basic flowgraph for USB looks like this:

![CW_Spectrum](/assets/img/defcon/grc.PNG)

So now you have a basic filtered USB signal.

# Morse Filtering

Looking at the time domain, I saw several spikes in amplitude at the presence of a CW tone:

![CW_Time](/assets/img/defcon/cw_time_1.PNG)

So all I needed to do from this point was _threshold_ at this amplitude change to find my 1s and 0s. My flowgraph now looked like this:

![CW_Flow](/assets/img/defcon/cw_flow.PNG)

From this point, I was dead-set on decoding using bit containers and fancy logic statements. I even had a frequency comparator and found the frequency for the dits to be about 3600 Hz:

![CW_Comp](/assets/img/defcon/cw_comp.PNG)

I wasted quite a bit of time on this. Don't be like me. I was about to use MATLAB and fill matricies for 10e5 bits.

# Audio Reception

Essentially to actually hear the morse code, I keyed a sine wave on and off. It's the same way it's generated! My flowgraph looks like this:

![CW_Key_flow](/assets/img/defcon/cw_key_flow.PNG)

My resulting time-domain wave looks like this with the binary bits (On/Off) overlayed to a sine wave (red

![CW_Key_flow](/assets/img/defcon/cw_key_wave.PNG)



# Challenges and Conclusions

Simple enough right? Here's where things get tricky.

I can't actually get an audible signal out of this. I chose 10 kHz as the tone frequency which fits nicely in all my Nyquist theorems (overall sampling rate is 96kHz, audio sampling rate is 24 KHz), but the software seems to just be running too slow. Every GUI takes forever to update (around 0.2ms no matter the refresh rate), so I think I am not processing the audio fast enough. If I increase my base sampling rate from 96kHz to 256 kHz, I just get a constant pitch and the code fails _but_ I get **"OaOaOaOaOa"** like GNURadio is chanting for me.

![Error Message?](/assets/img/defcon/Oa.PNG)

Looking online, this seems to be a sound issue. Saving it to a .wav file without any GUIs running still gives the same error. I sound like [this](https://github.com/N2WU/RF_CTF/blob/main/sound.wav).

So... that's where it lies currently. I plan on playing with the CTFs more as I get my Ubuntu machine back and hopefully I'll be able to hear better. Hope you enjoyed!
