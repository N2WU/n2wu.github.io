---
title: "VHF Frequency Selection Through Propagation Mediums"
date: "2020-09-29"
categories:
  - "technical"
tags:
  - "amateur-radio"
  - "antenna"
  - "diy"
  - "mathematical-modeling"
  - "matlab"
  - "propagation"
  - "space"
coverImage: "space.png"
---
# VHF Frequency Selection Through Propagation Mediums

Recently I started analysis of space weather phenomena, to include Meteor Scatter, Earth-Moon-Earth, and Auroral propagation. I attempted to show relationships between path loss and frequency through some simple MATLAB plots.

![](https://n2wu.files.wordpress.com/2020/09/space.png?w=706)

## Introduction

Just as the atmosphere has weather in precipitation, cloud cover, and temperature, other layers on the earth's surface (to include the ionosphere, magnetosphere, and troposphere) have weather affects that severely change radio propagation.

The largest factor found to change radio performance is electron density. Electrons are scattered in the upper layers, and certain weather events (meteor scatter / aurora) change the concentration or density of these electrons. Electromagnetic waves can then move more freely through their transmission medium and travel much further than their intended range.

This project is a stepping stone for a larger project. Eventually, after characterizing these loss equations in more interesting ways, I plan on testing my theory with our new satellite rig!

[Link to code!](https://github.com/KE8JCT/Space_Modeling/blob/master/Space_Sim_24_SEP.m)

## EME

Earth-Moon-Earth Communication occurs when radio waves are reflected off of the moon, nearly 383,400km away. This communication requires perfect reflection, high power, and an incredibly durable signal to travel this distance. Typically _JT65_ modulation is used for this operation, but morse code (CW) is also used for their low bandwidths.

Most of my data on EME comes from [this princeton source](http://physics.princeton.edu/pulsar/K1JT/Hbk_2010_Ch30_EME.pdf).

I made two plots for communication: for perigee (closest position) and apogee (furthest position) of the moon from the earth. The loss equation can be coded as:

```
eme_loss = (ada.*r_moon.^2.*lambda.^2) ./ (64.*pi.^2.*d.^4)
```

Where ada is the reflection coefficient of the moon, r\_moon is the radius of the moon, lambda is the wavelength, and d is the distance. I varied lambda from VHF up to GHz and got this result:

![](https://n2wu.files.wordpress.com/2020/09/eme_pathloss.png?w=1024)

_EME Path Loss_

As you can see, there is less loss at perigee than apogee.

## Meteor Scatter

Meteor Scatter occurs when a meteor shower occurs: the ionized trails of meteor create excellent conductive pathways for electromagnetic waves.

Most often, the electron density of the shower fades quickly. This results in the greatest degradation of communication as shown below in the graph.

I am using an incredibly dated book titled _Ionospheric Radio Propagation_ by the department of commerce. It still refers to Hz as "cycles" or "/s"! However, the equations it gives are still valid for my basic application.

The equation I used changes the Diffusion Coefficient D. It is the result of each pair of lines. Similarly, I made two equations for both over-electron dense and underdense trails - both likely to occur during meteor showers.

![](https://n2wu.files.wordpress.com/2020/09/gain.png?w=1024)

Judging by the graph, longer wavelengths with lower diffusion coefficients result in the highest relative gain.

## Auroral Propagation

Lastly, Aurora occurs in the D and E layer. This is similar to meteor scatter where ionized trails allow for fast travel of electromagnetic waves but are subject to limited time and fast diffusion of particles.

For these equations, I used Robert Hunsucker's paper "Auroral and Polar-cap Ionospheric Effects on Radio Propagation" in conjunction with "Excitation Processes in the Night Sky and Aurora" by Ta-You Wu.

The equation for auroral propagation (its specific loss coefficient K) can be modeled as:

```
K = 1.15e-3 .* N .* nu ./ f.^2 ;
```

Where N = electron density, and nu = collision frequency between electrons and neutral particles. I varied the frequency f through the VHF band (30-300MHz). Additionally, N changes through D and E layer, and from day and night. Below is the graph of my relationship.

![](https://n2wu.files.wordpress.com/2020/09/aurora_loss.png?w=1024)

Judging from the graph, the least amount of loss occurs in the F layer during the day at 30 MHz.

## Conclusions

Through all the relationships found in this study, overall a longer wavelength results in less path loss. This relationship is odd since the VHF spectrum begins at 30MHz where the highest results can be found. HF has a much more complicated relationship with space weather propagation so it was not modeled in this study, but it would be interesting to know the overall loss of an upper HF wave compared to a lower VHF wave.

I plan on generating propagation heat maps with this information to get an accurate depiction of free-space path loss over several kilometers. This will enable me to get predictive data. I also plan on modeling my equations with different antennas and will include bit error rate (BER) detection for validity of radio transmission

Further, I plan on physically testing my results. I will use ham radio equipment and try out these different modes with varying degrees of success. Based on modeling I want to see if I can predict these seemingly "random" events.
