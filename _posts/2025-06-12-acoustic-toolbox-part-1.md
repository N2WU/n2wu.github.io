---
title: "Acoustic Toolbox, Part 1"
date: "2025-06-12"
categories:
  - "technical"
tags:
  - "C Plus Plus"
  - "programming"
  - "radio"
  - "beamforming"
coverImage:
use_math: false
---

First post of many for the implementation of an acoustic digital signal processing toolbox.

# Introduction

I've been playing with acoustic signals for quite some time. They're like playing on "hard mode" for learning fundamentals of signal processing - the data rates are terrible (maxxing out at one mighty bit per second), the channel effects are horrendous (don't get me started on doppler), and the range is abysmal (feet). 

However, I can avoid interfacing with software-defined radios saving me time (so I thought) and money. It's fun to be able to hear a digitally-modulated acoustic signal and to be universally implementable with any computer hardware. They serve as great learning tools.

I've previously worked with Acoustic DSP in [python](https://github.com/N2WU/sc-adaptive-beamforming). Unfortunately, the value added by complex matrix operations seemed to be diminished by the immense compute power in the python environment. I'm hoping that using C++ will allow me to perform efficient calculations and even compile them onto microcontrollers for future projects.

So I've decided to make a sort of [standard toolbox](https://github.com/N2WU/c_acoustic_dsp/tree/main.) for learning about digital signal operations. Whether it's data encoding, modulation, or multichannel processing, I think it will be a fruitful and fun environment with an easily implementable framework.

Really, that's the scope - to create functions in a drag-and-drop fashion so I can compare methods pretty standard. If I wanted to see the BER of a QPSK signal with turbo coding versus a BPSK signal with Reed-Solomon, it should be fast, elegant, and presentable.

# RTAudio

I had originally planned this project to be in C, but ran into issues immediately concerning transmission. I want to be able to _hear_ this signal in case there's a live demo. C has limited support for audio playback. The only [example](https://batchloaf.wordpress.com/2017/02/10/a-simple-way-to-read-and-write-audio-and-video-files-in-c-using-ffmpeg/) I could really find used [FFMPEG](https://ffmpeg.org/) (however mighty) to convert the buffer into a wav file. This instantly won't work with multichannel processing and anything live like voice encoding. 

Enter the switch to C++. I settled on [RTAudio](https://www.music.mcgill.ca/~gary/rtaudio/) for purposes of playback and integration. I tried to find a wrapper/library that was non-hardware specific, capable of live/canned playback and record, and easy enough to implement. Unfortunately there were some growing pains with the program, but I think I've got it mostly figured out.

Many other online solutions seem to be geared more towards sound effects (SFX) and DAC programming. RTAudio seems integrable enough with the purposes I seek.

To install, I am using my Ubuntu machine and just followed the online instructions. I did have to install [alsa options](https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture) including _alsa-tools_ and _alsa-utils_. I tried this on Windows and I'm sure it might work, but I stuck with Linux just to make it easier.

RTAudio got revamped in 2023 and seemed to introduce a new, easier to use version. Avoid any code examples mentioning "RTError.h", as that uses the past version.

# Generation Method

Here I'll outline a general example for the code - playing a sine wave over my speakers. I borrowed most of this implementation from the "playback" [example](https://www.music.mcgill.ca/~gary/rtaudio/playback.html) on the release website.

First, the digital signal generation function is declared. The waveform is created and stored in a buffer, and we declare a pointer to that waveform buffer. The guide online calls this a ***callback function*** - useful for live transmitting when it needs to generate things quickly.

Next, we start RTAudio. There are lots of error handling and exceptions for this program, but generally we just declare:

1. Which audio device to use
2. Number of audio channels
3. The audio sampling rate
4. The number of buffer frames (I set this to match the sampling rate)

We start RTAudio with "RtAudio dac;". Then, we start the stream. We pass the address of the transmit function and an example of the formatted audio for our specifed output. So, for single channel we want "data[1] = {0}" etc.

From this point, RTAudio will continuously transmit until we tell it to stop. Of course, we can limit the buffer to however short we wish. I added a stop() command to halt the stream after 1 second.

Then, after stopping the stream, the transmission is complete!

# Example 1

I made a quick example [here](https://github.com/N2WU/c_acoustic_dsp/tree/main/cpp_files) for a sine wave, under "rt_sine.cpp". I need to iron out the directory structures as it's my first time working with build/src folders, but the code still applies.

I set up a single-channel audio stream with RTAudio, and used a simple buffer to modulate a sine wave. 

This is made recursively and can probably be better acheived using vectors. I'll soon add actual data modulation for a BPSK signal to include decoding. 

# Conclusion

I have high hopes for the toolbox. I've been trying forever to implement vocoders for a voice-over-audio system that is both ineffecient and unnecessary. It may also help in a few ideas I have with image compression.

Please let me know what you think of toolbox and how it can be improved. This is my first time with compiled code but I think it will really make a difference in processing speed and straightfoward computations.
