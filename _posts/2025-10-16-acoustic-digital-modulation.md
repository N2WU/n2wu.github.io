---
title: "Acoustic Digital Modulation"
date: "2025-10-16"
categories:
  - "technical"
tags:
  - "Python"
  - "programming"
  - "radio"
coverImage:
use_math: true
---
A quick demonstration of digital acoustic modulation schemes in Python.

# Background

I am teaching digital modulation, and wanted to show the differences in transmit time, bandwidth, and effective range using different types of digital modulation. Since I'm a little experienced with [acoustic audio](/_posts/2025-06-14-acoustic-toolbox-part-1.md), I wrote something quick in python.

# Steps

There's lots of shaping, sampling, and filtering necessary to transmit bits over audio.

## Data string formatting

This is pretty trivial, but the input text string needs to convert to ones and zeros:

```python
input_string = np.array(list("Dear Mr. Secretary: I hereby resign the Office of the President of the United States. Sincerely, Richard M. Nixon."))
input_stream = []
for i in range(len(input_string)):
    input_char = ord(input_string[i])
    input_stream  = np.append(input_stream,np.unpackbits(np.array([input_char],dtype=np.uint8)))
```

And convert the ones and zeros to symbols (here, for bpsk):

```python
complex_data_vec = input_stream*2 - 1
```

I also make a preamble using a PN code.

## Define Acoustic Constants

Below I define my constants for the transmit calculations:

```python
fc = 6.5e3          # carrier frequency
Fs = 44100          # audio frequency
fs = Fs/4           # intermediate audio frequency
Ts = 1/fs           # audio period
alpha = 0.25        # filter alpha value
trunc = 4           # truncate level for bits
Ns = 7              # number of symbols
T = Ns*Ts           # symbol period
R = 1/T             # filter constant R
B = R*(1+alpha)/2   # filter bandwidth
Nso = Ns            # number of symbols
uf = int(fs / R)    # upsampling factor
```

## Create Filters

I made a root-raised cosine filter using the following function:

```python
def rcos(alpha, Ns, trunc):
    tn = np.arange(-trunc * Ns, trunc * Ns+1) / Ns
    p = np.sin(np.pi* tn)/(np.pi*tn) * np.cos(np.pi * alpha * tn) / (1 - 4 * (alpha**2) * (tn**2))
    p[np.isnan(p)] = 0  # Replace NaN with 0
    p[np.isinf(p)] = 0
    p[-1] = 0
    p[int(Ns*trunc)] = 1
    return p
```

And another filter using bits d and pulse-shaped RRC p:

```python
def fil(d, p, Ns):
    d = d.astype(complex)
    N = len(d)
    Lp = len(p)
    Ld = Ns * N
    u = np.zeros(Lp + Ld - Ns,dtype=complex)
    for n in range(N-1):
        window = np.arange(int(n*Ns), int(n*Ns + Lp))
        u[window] =  u[window] + d[n] * p
    return u
```

## Generate Message

The signal is created with preamble + message, then generated using the following steps:

```python
ud = fil(d,g,Ns)
u = np.concatenate((up, np.zeros(Nz*Ns), ud))
us = signal.resample_poly(u,Fs,fs) # upsample
# upshift
s = np.real(us * np.exp(2j * np.pi * fc * np.arange(len(us)) / Fs))
```
And played using sounddevice:

```python
r = sd.playrec(s,Fs,channels=1,blocking=True).squeeze()
```
# Conclusion

The results, saved in .wav files, are shown in the [github here](https://github.com/N2WU/audio_mod/tree/main). Overall, each M-ary increase leads to about a 50% reduction in transmit time. More work is required for the decoding and actual transmission analysis.