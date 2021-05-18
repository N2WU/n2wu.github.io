---
title: "Binary Signal Modulation in MATLAB"
date: "2020-08-24"
categories:
  - "technical"
tags:
  - "coding"
  - "digital-signals"
  - "dsp"
  - "matlab"
  - "radio"
coverImage: "matlab_signals.png"
---
# Binary Signal Modulation in MATLAB

This weekend I wanted to visualize some forms of digital modulation I am using in upcoming projects. I chose to manipulate Binary Frequency-Shift Keying and Binary Phase-Shift Keying. A nice start to the school year!

![](https://n2wu.files.wordpress.com/2020/08/matlab_signals.png?w=720)

## Background

All of my signals underwent a transformation to one part of their waveform. My original wave was modeled as a Sine wave with an arbitrary frequency. Usually it had a period of about 1 second for readability. Below are the parts to my carrier wave:

![](https://n2wu.files.wordpress.com/2020/08/wave_equation.jpg?w=393)

Wave Equation from National Instruments

So Frequency Shift-Keying (FSK), more or less, involves changing the frequency. Likewise Phase-shift keying (PSK) changes the phase of the carrier signal.

Binary FSK and BPSK both rely on binary signals to modulate. This binary data is the actual text of a message; my message was 'test' converted to binary ascii. I will explain further in the code how I encoded my signal.

## Code

As usual, my code is available on [github](https://github.com/KE8JCT/MATLAB_Binary) for matlab. The first thing I did was convert my text string to binary:

```
string = 'test';
unicodeValues = double(string);
b = de2bi(unicodeValues);

b = reshape(b,1, []);
```

All this does is convert the string into a matrix, then compile them into a single vector. Decoding will be a slightly harder process since the bits are directly on each other; there are no spaces in binary. I will have to remember to look for the word portion (2 bytes) for each character.

Next, I had to sort of "upsample" my data to get it to affect multiple parts of my discrete data. This means I went from 28 bits to 280 ; I arbitrarily multiplied by 10. Here's the code:

```

c = ones(1, length(b)*10);


for d = 0:(length(b)-1)
    for e = 1:10
        c(e+(d*10)) = b((d+1));
    end
end
```

So it takes a "magnifying glass" into the first bit of **b** and copies it 10 times into **c**. So now **c** is 280 bits, or **b**\*10. This was a very binary way of doing things and could probably be improved.

Next I actually generated the signal. I used t**t** as my discrete sample variable as a way to cheat the definition of discrete. For Binary FSK, I split my C vector into either a mark or space (400 or 300 Hz). For BPSK, I left it as 1/0. Note that BFSK affects the _frequency_, while BPSK affects the _phase angle_.

```
tt = 0:.0358:10 %Just so I have the correct amount of samples (280)
xx = sin(2*pi*C.*tt); %Binary FSK
zz = sin(2*pi*.789*tt+180*c) %BPSK
```

## Results

I made two plots for each modulation scheme, mostly just for effects. BFSK has the regular signal shown two different ways (the more -colorful- one is just a complex function), while BPSK shows the modulated signal and the binary signal.

![](https://n2wu.files.wordpress.com/2020/08/binary_fsk.png?w=1024)

Note the mark and space!

![](https://n2wu.files.wordpress.com/2020/08/bpsk.png?w=1024)

Note the phase delay!

## Conclusions/Extensions

As I usually say in amateur radio, transmitting is only half the fun! Soon I will try to demodulate these and decode them back to the original 'test' stage.

This exercise was only a short divulge from my original project: an H-field transmitter. BPSK is preferred for its low bandwidth and power requirement. This signal is first step I need to complete; I still have to simulate two antennas in free space transmitting and receiving this signal, keeping in mind path loss and propagation delay. All fun!

## References

I am a big fan of _Electronic Communications Systems: Fundamentals through Advanced_ by Wayne Tomasi. Specfically, the signal modulation I used came from chapter 13, pages 490-501.

Additionally, the GA Tech bible _DSP First: A Multimedia Approach_ helps immensely with getting back into discrete sampling in MATLAB. I used page 420 for a re-introduction into time sampling and plots.
