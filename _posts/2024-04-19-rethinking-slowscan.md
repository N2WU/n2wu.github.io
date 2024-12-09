---
title: "Rethinking SSTV"
date: "2024-04-19"
categories:
  - "technical"
tags:
  - "amateur-radio"
  - "electrical-engineering"
  - "high-altitude-balloon"
---

It's been a while. 

# Rethinking SSTV

I have a stubborn tendency to question things. I also hold grudges, specifically towards engineering projects where I don't feel quite finished.

In a few [balloon launches](https://www.n2wu.com/2022-01-26-pi-sstv-board/), we toyed around with the idea of a payload containing a slow-scan television (SSTV) transmitter. This failed, spectatularly, for a number of reasons:

1. The image quality was terrible
2. The transmission time was too long
3. The range was only VHF line-of-sight 
4. Analog decoding introduced unnecessary errors from receive-side audio processing

In this airing of greivances/self-proclaimed RFQ, I'm taking a short look into what can be improved about this ancient format.

# Current Approaches

I considered calling this "contemporary" approaches, but therein lies the problem. [SSTV](https://en.wikipedia.org/wiki/Slow-scan_television) has been largely the same since the 1960s. Modern sources cite _QST_ articles from... 2005. Generally the format operates in the same way:

1. Transmit a calibration header
2. Transmit Audio FSK-modulated RBG values for a predetermined line length
3. Transmit a calibration header
4. Repeat until end of transmission

This is incredibly easy and offers the following abstracted benefits:

1. Audio FSK is neat! You can hear it, save the audio file, and use any other modulation scheme to transmit on your frequency (e.g., VHF uses FM SSTV while HF largely uses USB)
2. Decoding software is independent of receiving equipment. Decoding can take place on a computer or a cell phone
3. It follows the same general idea as NOAA or the ISS - less reinvention
4. It's widely accepted, easy to use, and easy to program

However, just in the data format alone, my problems arise:

1. Bit rate is horrendous - a 256x256 image is useless for any telemetrious* purpose
2. Transmission time, at this bit rate, is too long
3. Audio-FSK is fun, but bridging that to an analog mode introduces so much unecessary noise
4. No opportunities for error correction or robustness
5. No backend synchronization, what you hear is what you get (slants, etc)
6. The processing chain is too long. You have to choose an image, format it to audio, then transmit it via radio.

*ie, for using as telemetry or information. Putting in a weather balloon shows unusable pictures - NOAA satellites are much higher quality, and cameras in general can take much better pictures.

Switching this over to a digital coding scheme, or a digital mode, would allow for less errors at the cost of accesibillity. 


# Data Compression
JPEG compression is (really) good and widely used. If SSTV is an immovable standard, we can at least better compress images before transmission. I present two cases below; first, a case where JPEG compression is added to the widely accepted SSTV format, and second, where I can reinvent the transmission mode.

## Sticking with SSTV

This is straightforward. Take an image and JPEG compress it to 256x256 without a noticeable loss in quality. The image is still transmitted over Robot36, Scottie, or whatever mode desirable. 

I did a code simulation in python. First, I have my orignal image transmitted at baseband (meaning, no FM or USB/LSB, just audio to audio). The image is 256x256 and transmitted via Martin 1. Code is here.

## Adopting New modes

# Data Transmission

## Networking: APRS

## Modes