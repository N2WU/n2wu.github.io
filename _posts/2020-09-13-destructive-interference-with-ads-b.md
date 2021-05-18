---
title: "Destructive Interference with ADS-B"
date: "2020-09-13"
categories:
  - "technical"
tags:
  - "diy"
  - "dsp"
  - "mathematical-modeling"
  - "matlab"
  - "radio"
coverImage: "destructive.png"
---
# Destructive Interference with ADS-B

I did a quick destructive interference extension to my ADS-B ongoing project. Take a look!

![](https://n2wu.files.wordpress.com/2020/09/destructive.png?w=431)

## Background

Interference is what happens when two signals with different amplitudes combine. Due to the theory of superposition, the wave's amplitudes can be added on top of each other. _Destructive_ Interference specifically happens when one signal has a negative amplitude compared to the other; when the amplitudes add, they subtract off of the total amplitude.

## Code

My code is a simple extension of last week's matlab solution. I found my approximate packet, and reversed the amplitude of each signal. It can be identified below:

```
reverse_packet = -packet1;    
reverse_array{i} = reverse_packet;
new_signal = packet1+reverse_packet;
signal_array{i} = new_signal;
```

This code also takes both the inverse signal and the summed signal (should be a string of 0's) and saves it into an array.

## Results

In a finite-time script like I have (reading from a data file not in real time), I am able to create inverse values for all of my packets. To visualize them I pick random strings and present their inverse values. The wave output should be 0 here:

```
for i=1:4
nexttile
r = randi(length(packet_starts1));
plot(packets{1,r})
hold on
plot(reverse_array{1,r})
ylim = ([-1.1, 1.1]);
legend('Incoming ADS-B Packet','Destructive Signal')
title('Destructive Interference ADS-B Packet')
ylabel('Relative Amplitude')
hold off
end
```

![](https://n2wu.files.wordpress.com/2020/09/destructive_interference.png?w=1024)

_Visualized Random Results_

## Extension and Application

In matlab this code works well, but I eventually want to port this over to python or GNUradio for real-time use. I plan on using a **peak detector** block for rapid destructive interference.

Hope you enjoyed the relatively short write-up! Expect more on much diverse topics (like propagation modeling) in the future.
