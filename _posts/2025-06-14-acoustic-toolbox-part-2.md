---
title: "Acoustic Toolbox, Part 4"
date: "2025-06-14"
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

Second post for the Acoustic Toolbox, featuring a BPSK transmitter.

# Background

A few days ago I launched my [acoustic digital signal processing toolbox](/_posts/2025-06-12-acoustic-toolbox-part-1.md) using C++ and the [RTAudio](https://www.music.mcgill.ca/~gary/rtaudio/) Plugin. In that post I made a quick, loopable sine wave to demonstrate the flows and pipelines for generating waveforms. I'll reiterate below:

1. All generation occurs before RTAudio is launched, in a [callback function](https://www.geeksforgeeks.org/cpp/function-pointers-and-callbacks-in-cpp/).
2. The RTAudio function launches with a pointer to the function.
3. When the code is executed, the signal will continuously play (as initially written) until the program stops.

So armed with this approximate knowledge, I went for the "Hello World" of digital signal processing: a random-bit BPSK transmitter.

# BPSK Implementation

C++ is efficient but a little stalwart in its implementation. Whereas python (numpy) [array operations](https://www.geeksforgeeks.org/python/python-operations-on-numpy-arrays/) may make code more efficient and reduce headache in long element-wise nested loops, you are as fast as you're going to get in C++. 

It took a little bit of practice for me to unstick myself from mathematical formulas and re-write in elementwise nested C++ loops. Take a look at the basic [BPSK transmitter](https://github.com/N2WU/c_acoustic_dsp/tree/main/cpp_files). It's under bpsk.cpp - I won't link the actual code yet because I am due to reorganize the folders to match popular build/src/include convention.

## Vectors

[Vectors](https://en.cppreference.com/w/cpp/container/vector.html) are a little more convienent than arrays and were recommended to me by a friend who knows much more about C++ signal processing. They are declared with:

```cpp
std::vector<type> vectorName;
```
I just used them like arrays and didn't encounter much of a hiccup. Speaking of complex,

## Complex Data Type(s)

[Complex Data Types](https://en.cppreference.com/w/cpp/numeric/complex.html) are declared with:

```cpp
std::complex<type> complexName
```

So a complex vector of doubles could look like:

```cpp
std::vector<std::complex<double> complexName> vectorName;
```

I encountered some pushback here - complex types do not interact with ints. I had to recast my ints as doubles to work with complex operations, even for something as simple as multiplying by a scalar. Maybe I'm slowing down my code by the occasional recast, but I am more concerned with compiling at this point.

## Mathematical Implementation

First, our bits are generated as an array **rand_bits** with length **data_len**. Because this is BPSK and 1 symbol per bit, I didn't need to do any resizing operations. For QPSK, the symbols must be repacked to fit 2 bits/symbol - hence the constellation diagrams. My BPSK symbols are going to be [+1+0j] or [-1+0j].

From here, I upsample my **data_len** bits to match the **Number of Samples per Symbol**. So if **data_len** is 100 and my **NSPS** is 2, my new **up_len** should be 200. This takes a little attention to detail:

```cpp
  int n_bits = NsPs * data_len;
  std::vector<double> up_bits(n_bits);
  for (int i = 0; i < data_len; i++){
    for (unsigned int ns = 0; ns < NsPs; ns++){
      up_bits[i*NsPs+ns] = rand_bits[i];
    }
  }
```

Next, we have to look at the actual equation for a passband acoustic signal to see how to implement it in code. Our data symbols can be shown as:

$$ u(t) = \Sum d(n)g(t-nT) $$

Where $$g(t)$$ is a pulse between $$t \set [0,T]$$

The transmitted signal $$s(t)$$ is shown as:

$$s(t) = \Real\{u(t)e^{j2\pi f_c t}\}$$

So in python/numpy, we can show this operation as:

```python
s2 = up_bits * np.exp(2j*np.pi*fc*np.arange(n_bits)/Fs)
```

But in C++, we have to use the following nested loop:

```cpp
    for (int nn=0; nn<n_bits; nn++){ 
      double nnd = nn;
      std::complex<double> comp_bit;
      std::complex<double> comp_exp = (2i * fc * M_PI * nnd/ Fs);
      comp_bit = up_bits[nn] * std::exp(comp_exp);
      buffer[nn] = real(comp_bit);
    }
```

When you compile and run the code, you can hear a clear BPSK signal. 

# Next Steps

Obviously I'll have to make a receiver that does the above steps in reverse and calculates some BER from the initial code.

I will just work on maximum-likelihood estimation for now, but other estimators (MVUB, MMSE, and more complicated systems like a [DFE](https://cioffi-group.stanford.edu/ee379a/Lectures/L15.pdf) should get a notice.

Going from the simulated to the real environment (playback and record) will also require a preamble and cross-correlation to determine the start of the signal. I can also imagine some headaches with the buffers in the pipelines with RTAudio. 

In the distant future I'd like to add support for a vocoder or keyboard that can real-time generate and transmit data with packet handling. Of course, this may mean adding higher data rates and othe forms of error correction.

And I need to fix the toolbox layout! I'm not an expert on includes yet, but my code should generally be entirely reformatted to match the typical C++ layouts (main.cpp, etc).
