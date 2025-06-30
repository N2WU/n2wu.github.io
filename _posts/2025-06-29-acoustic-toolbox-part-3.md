---
title: "Acoustic Toolbox, Part 3"
date: "2025-06-29"
categories:
  - "technical"
tags:
  - "C Plus Plus"
  - "programming"
  - "radio"
  - "beamforming"
coverImage:
use_math: true
---

Third post for the Acoustic Toolbox, featuring functions for processing separate waveforms.

# Background

A few days ago I launched my [acoustic digital signal processing toolbox](/_posts/2025-06-12-acoustic-toolbox-part-1.md) using C++ and the [RTAudio](https://www.music.mcgill.ca/~gary/rtaudio/) Plugin. In that post I made a quick, loopable sine wave to demonstrate the flows and pipelines for generating waveforms. I'll reiterate below:

1. All generation occurs before RTAudio is launched, in a [callback function](https://www.geeksforgeeks.org/cpp/function-pointers-and-callbacks-in-cpp/).
2. The RTAudio function launches with a pointer to the function.
3. When the code is executed, the signal will continuously play (as initially written) until the program stops.

I then made a [BPSK transmitter](/_posts/2025-06-14-acoustic-toolbox-part-2.md). In the previous code, the BPSK code generation occured completely independent of any user data and occured whenever the buffer needed input to play sound. If I want to generate user data, I needed a better way to take input and generate data into BPSK bits. In part 3, I was able to explore more of the function and pointer references to generate bits correctly.

# New BPSK Implementation

As I mentioned before, the audio generate function from RTAudio is called in the following line:

```cpp
dac.openStream( &parameters, NULL, RTAUDIO_FLOAT64, sampleRate, &bufferFrames, &genInput, &userData)
```
genInput is the function responsible for placing correctly interleaved data in a buffer, and userData is a user-generated data field accessible in the genInput function. So from these constraints, I decided:

1. I needed a function to take userInput and generate a waveform to transmit
2. I needed a second function to simply copy this waveform into the audio buffer.

## Generate BPSK TX Signal

I didn't want my entire code to hinge on RTAudio's unique genInput function format, which looks like this:

```cpp
int genInput( void *outputBuffer, void *inputBuffer, unsigned int nBufferFrames, double streamTime, RtAudioStreamStatus status, void *userData )
```

So instead I had secondary functions take care of the code generation. Following from part two, I first rewrote my transmit function as its own customizable function. It copies a lot from the RTAudio examples:

```cpp
int bpsk(int data_len, double Fs, unsigned int R, double fc, void *inputData, void *s)
```

Important here are the **void *inputData** and **void *s** statements. They are pointers to vectors that hold userData. I initialize **s** with:

```cpp
double s[16000] = {0};
```

Where I will soon rewrite it in **bpsk()** using this declaration:

```cpp
double *gen_s = (double *) s;
```

When I write a value to gen_s, it is the same location as s.

```cpp
  for (int nn=0; nn<n_bits; nn++){
    *gen_s++ = gen_bit(nn); //generate the correct bit at nn for s
  }
```

## Move TX Signal from Interal Buffer to RTAudio Buffer

I just took from the example here. The callback function has the **outputbuffer** and **userData** frames. I use a for loop and just copy the items over:

```cpp
  double *buffer = (double *) outputBuffer;
  double *bytes = (double *) userData;
  for (int nn=0; nn<nBufferFrames; nn++){ 
    if (nn < nBufferFrames){
    buffer[nn] = bytes[nn];
    }
  }
```

# Next Steps

I have been looking at the [duplex example](https://www.music.mcgill.ca/~gary/rtaudio/duplex.html) for record as well - it operates similar to the callback TX function, so I imagine a receiver won't be impossible to implement.

I will just work on maximum-likelihood estimation for now, but other estimators (MVUB, MMSE, and more complicated systems like a [DFE](https://cioffi-group.stanford.edu/ee379a/Lectures/L15.pdf) should get a notice.

Going from the simulated to the real environment (playback and record) will also require a preamble and cross-correlation to determine the start of the signal. I can also imagine some headaches with the buffers in the pipelines with RTAudio. 

In the distant future I'd like to add support for a vocoder or keyboard that can real-time generate and transmit data with packet handling. Of course, this may mean adding higher data rates and othe forms of error correction.

And I need to fix the toolbox layout! I'm not an expert on includes yet, but my code should generally be entirely reformatted to match the typical C++ layouts (main.cpp, etc).
