---
title: "Digitally Synthesizing Music in MATLAB"
date: "2020-02-15"
categories:
  - "technical"
tags:
  - "diy"
  - "dsp"
  - "matlab"
  - "music"
  - "synthesis"
coverImage: "rachmaninoff_matlab.png"
---
# Digitally Synthesizing Music in MATLAB

I've been following along in the textbook [_DSP First_](https://www.amazon.com/DSP-First-James-H-McClellan-ebook/dp/B014QHZG0Q) and saw a cool example of making digital music through MATLAB. It's a nice bridge for me into DSP and eventually RF modulation. Here's what I came up with.

![](https://n2wu.files.wordpress.com/2020/02/rachmaninoff_matlab.png?w=640)

_Making Matlab Music!_

## Background

MATLAB has many different toolboxes available for Digital Signal Processing. I recommend installing _Communications, Signal Processing, and DSP Systems_. For this example, you only need the **sound()** function.

Also, I used a standard numerical keyboard to create my sounds in reference to the A4=440 Hz key. So a piano goes from 1-89, with middle C being key "40." Here's a picture of all the frequencies on a keyboard.

![](images/Phys_img024.jpg)

Middle C = key 40

## Code Setup

The basic unit of this program is the sinusoid. The sine wave produces what we hear as music - it just uses an audible frequency (20-20,000 Hz). The basic wave equation is a function of just time with normalized inputs for our uses.

```
sinusoid = sin(2pi*frequency*t)
```

From here, you can mix, combine, and synthesize these signals. MATLAB treats them as a vector, meaning they can be added with vector dimensions. The function can also accept phase shifts or wave numbers if you want.

## Code

As usual, you can find the code on [github](https://github.com/KE8JCT/MATLAB_Music). It follows pretty directly from _DSP First_, first edition, page 436. The **Synthesis\_Signals** is the main code, and **Tone\_Function** is the function used to generate a code. There's also a .mp3 file of just the melody to an example song. Here's some important highlights:

First, here's the ToneFunction. It takes the key name from a standardized list (**keynum)**, and finds the frequency using this formula:

```
freq = 440 * 2^((keynum-49)/12);
```

Where 49 is the default tuning A=440Hz. That way each note is a magnitude of 2 above or below 440 Hz. The rest of ToneFunction is below.

```
function [tone] = ToneFunction(keynum,dur)
%NOTE Produce a sinusoidal waveform corresponding to a given piano key
%number
%   usage: tone = note (keynum, dur)
%   tone = the output sinusoidal waveform
%   keynum = the piano keyboard number of the desired note
%   dur = the duration (in seconds) of the output note
fs = 11025;
tt = 0:(1/fs):dur;
freq = 440 * 2^((keynum-49)/12);
tone = 1*sin(2*pi*freq*tt);
end
```

On the main file, I used a really cumbersome way to read music. I start out with two arrays: **note** and **duration**. I input all my notes in one, and all my duration (I used 60 bpm, so one quarter note is 1 second) in the other. This requires a huge array and attention to detail.

```
notes = [E5, Ds5, E5, Cs5, Ds5, E5, Ds5, Cs5, Ds5...
durrh = [.25, .25, 1.5, .25, .25, .5, .25, .25...
```

For the actual synthesis, the code uses a loop to add each tone into a sequential array.

```
for kk = 1:length(notes)
        keynum = notes(kk);
        dur = durrh(kk);
        tone = ToneFunction(keynum,dur);
        n2 = n1 + length(tone)-1;
        xx(n1:n2) = xx(n1:n2) + tone;
        n1=n2;
end
```

The code repeats itself for the amount of notes present in the array. It stacks all of this information into **xx**. For two simultaneous notes, I just added another **note** and **duration** array, and made the two end vectors have the same amount of items. **Sound()** produces this result with a default windows frequency of 11025 Hz.

```
for kk = 1:length(noteslh)
        keynum = noteslh(kk);
        dur = durlh(kk);
        tone = ToneFunction(keynum,dur);
        n2 = n1 + length(tone)-1;
        yy(n1:n2) = yy(n1:n2) + tone;
        n1=n2;
end
newy = zeros(size(xx)); %this creates a new matrix for RH and LH to make equal length (fills in extra zeros)
newy(1:size(yy,1),1:size(yy,2)) = yy;
newx = zeros(size(newy));
newx(1:size(xx,1),1:size(xx,2)) = xx;
sound (newx+newy, fs);
```

So it works with two notes. If you severed 8 of your fingers this program could be very applicable.

## Conclusion and Application

Sergei Rachmaninoff is one of my favorite composers, so I gave him a tribute by synthesizing two lines to his ["Vocalise."](https://www.youtube.com/watch?v=1yTyYpWqsZU) His work is in the public domain so I'm not breaking any laws by posing my version [here](https://drive.google.com/file/d/1Wr-1sPoJavLM7-gcPQdPSP5Y1hjZ7bZZ/view?usp=sharing).

Obviously the code sounds a little generated. There are further expansions also listed in _DSP First_, like selective fading on each tone. I will try them out soon.

Overall I'd like to improve the synthesis and construction of 2+ notes. It seems pretty cumbersome, but I need more knowledge of vectors and DSP sinusoids to make that happen. If you have any suggestions, let me know!
