---
title: "ADS-B  Decoding in MATLAB"
date: "2020-03-30"
categories:
  - "technical"
tags:
  - "aircraft"
  - "decoding"
  - "digital-signals"
  - "dsp"
  - "matlab"
  - "radio"
  - "technology"
coverImage: "websitepic-1.png"
---
# ADS-B Decoding in MATLAB

![](https://n2wu.files.wordpress.com/2020/03/websitepic-1.png?w=1024)

Ham radio seems to go hand-in-hand with the current quarantine. Over the past week I've been studying some [online stanford labs](https://web.stanford.edu/class/ee179/Homework.html) to do more digital signal processing. The final project for this class involves decoding [ADS-B](https://en.wikipedia.org/wiki/Automatic_dependent_surveillance_%E2%80%93_broadcast) signals, which are transmitted out in the open by any aircraft. MATLAB already has an [example](https://www.mathworks.com/help/supportpkg/rtlsdrradio/examples/airplane-tracking-using-ads-b-signals.html) for doing this, but I wanted to learn a little more.

This lab, in abstract, dealt with signal discrimination and logic. It involved finding a signal, then decoding it into ones and zeros.

## 1\. The Data

The Stanford lab gives a 10-second IQ data file on a single frequency, 1090 MHz. There is no frequency domain, only time domain. You can do this too using [lab 2](https://web.stanford.edu/class/ee179/labs/Lab2.html) 's steps. I used the file "adsb\_3.2\_3.dat." Below is a snapshot of what the signals look like from 0-2 seconds:

### Understanding Sample Rates / Bits

The biggest hurdle to this project was understanding the incoming data stream. The data from the rtl-sdr is taken in at 3.2 Megahertz, or 3.2e6 samples/second. In the lab, the data is resampled to 4 MHz. That way the signal rate is **2 times what we need to decode it**. There really isn't much to "desampling" the waveform; I only took the odd-numbered bits and got a signal. However, sampling immediately at 2MHz results in hard-to-decode signals.

### The ADS-B Packet

The Packet first starts with a preamble 8 microseconds (32 samples at 4MHz) long. The preamble has 4 sharp spikes as shown below. The packets can be 56 or 112 microseconds long following the preamble, however I only looked for packets 112 us long. Here is an example packet from the dataset, note the clear peaks and troughs of the signal.

![](https://n2wu.files.wordpress.com/2020/03/4mhz_packet.png?w=810)

These peaks and troughs vary for each signal in the sample; the amplitude could peak at 8 for one signal, or 20 for another. You will **threshold** the signal to discern it above a noise floor. In matlab it is super simple:

```
x = x > 10 %Keep only signals above 10
```

Here's a breakdown of the packet. I am concerned with the ICAO, but the lab I used is concerned with the DATA section, led by a Type Code packet.

![](images/ADSB_Bit_Allocation.png)

## 2\. The Code

I uploaded everything I've played with on github [here](https://github.com/KE8JCT/ADSB). I'll go step-by-step with my methodology for how I decoded the signals.

### A. Process the Data

Data is processed straightforward with the lab's guidance:

```
da = abs(loadFile('adsb_3.2M_3.dat'));
d = resample(da,5,4);
```

### B. Filter the Data

From here, I used MATLAB's **conv()** function to make a matched filter between the data and my preamble.

```
PreambleVector = [1 1 0 0 1 1 0 0 0 0 0 0 0 0 1 1 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0];
w = conv(d, PreambleAdj);

for n = 1:length(w)
    if w(n) > 200 %if the current bit is ~definitely~ a preamble
```

A matched filter takes both a sample signal and a message signal (in this case it is the PreambleVector backwards). It returns the area overlap between the two signals.

![](https://lh3.googleusercontent.com/proxy/rRMiayeZTjS1nU8-mG0niwsswXv-3V8nQF7Km1l42qZjoi00UAbg5G0ZGS3QM6ZTQpNq6ru6FXsVORrVoCete3T7LamxkJTKuSalRYJNdzSwlqIGnP5QcxHcjrrthJ8yi94_F2cg)

So here is the signal d, with the output of the filter, w. W's peaks occur where there is a large amount of overlap between the preamble and the signal.

![](https://n2wu.files.wordpress.com/2020/03/conv.png?w=1024)

### C. Sample the data

Pretty straightforward, now after I know where my packet is, I downsample it and convert it to logic. First I take a small chunk of data, starting where my filter returns a peak, and sample every other bit. Remember 4MHz gives 4x the needed length:

```
RawDataPacket = d(n:end); %get a chunk of the data
        RawDataPacket = RawDataPacket > 20; %Threshold
        DataPacket = RawDataPacket((find(RawDataPacket, 1)+8*4):(find(RawDataPacket,1)+120*4)); %Packet that is 4x the needed length
        DataPacket = DataPacket(1:2:end); %take every other bit
```

From here I run it through a logic table. The logic is very straightforward:

![](https://n2wu.files.wordpress.com/2020/03/logictable.png?w=289)

So it can be rewritten as

```
DataPacketAdj = DataPacket(1:2:end);
```

Now I have a 112-bit long vector with my binary values, ready for decoding.

### D. Decode the Data

This is very easy: let someone else do it. I ran it through MATLAB's **binaryVectorToHex** function (my DataPacketAdj is a column vector).

```
NewID = binaryVectorToHex(DataPacketAdj(9:32).');
if NewID ~= [0 0 0 0 0 0] %ignore empty values
   ICAO = [ICAO ; NewID]; %save ICAO addresses into an array
end
```

So overall, my code generates usable packets as shown below. It takes a chunk, downsamples it, then converts it to logic.

![](https://n2wu.files.wordpress.com/2020/03/sampledchunk.png?w=1024)

## Results

In the end, I get quite a few ICAO addresses. I auto-stored all of my results in a .csv file, though most of them are junk results. The script takes quite a while to compile but does give usable data. Here's one I found:

![](https://n2wu.files.wordpress.com/2020/03/a0e220.png?w=486)

from AirNav RadarBox

In the future, I would like to look at other ways to filter for my preambles. The conv() function works but other methods could give better results. Also, I can take this algorithm and apply it to other single-frequency data channels, such as APRS (which is actually Lab 7 in the Stanford class).

I could also apply this to a range of frequencies, by taking snapshots at a certain time. However, a problem I am struggling with is procedurally decoding different types of modulation: if I am in the 20m ham band, I can encounter all sorts of different signals.

I would also like to see what ADS-B looks like currently given the coronavirus situation. I may get many fewer flights than usual.
