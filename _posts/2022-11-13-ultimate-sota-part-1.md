---
title: "The Ultimate SOTA Antenna, Part 1: Coax Cable"
date: "2022-11-13"
categories:
  - "technical"
tags:
  - "amateur-radio"
  - "summits-on-the-air"
  - "hiking"
  - "outdoors"
  - "morse-code"
  - "ham-radio"
  - "SOTA"
  - "antenna"
  - "electrical-engineering"

coverImage: "/assets/img/sota_ant/cover.png"
use_math: true
---

After a few more summits, I've decided my SOTA getup needs serious work. The amateur radio community largely acts on instinct and legend, so I'd figure I actually do the math in creating an ultimate SOTA antenna.

Part 1 will cover everything pertinent to coaxial cable - the weight, losses, wavelength dependence, and network parameters.

# Introduction

I want you to close your eyes. Peek a little at a time to read if you have to or have someone read this part aloud.
Eyes closed? Ok.
Picture what comes to mind when I say "Ultimate SOTA Antenna." What shape is it? Frequency? Transmit power? Really focus on the little things and especially what makes it better than your current QRP setup.

Open your eyes. Let's compare the big picture:

## Requirements for "The Ultimate SOTA Antenna"

### Construction 

* Lightweight without complicated guy lines or solid tubes (save a fiberglass mast)
* Sets up quickly and stays up - no fuss
* No snagging on trees or getting stuck between rocks

### Performance

* Has ideal SWR without a tuner
* Continuous DX the moment it's online
* Maximum radiation efficiency - current concentrated at the highest point

In all, you want a **simple** antenna that does its **limited job very well**.
What does this antenna actually look like? I'm going to say a **single-band, half-wavelength dipole**. 

## Defense

I know operators with multi-band-hopper-balun-h-network-end-fed-traps are arming themselves with pitchforks at this very moment. I would too, considering I built my own [end-fed](https://www.n2wu.com/2022-01-08-2021-odds-and-ends/) not too long ago, and have a [1.2 SWR dipole](https://www.n2wu.com/2021-08-01-the-end-all-sota-dipole/) in the backup gear bag. I've tried quite a few approaches, but the single-band dipole is **the** way to go. 

I cannot explain how often I've waited for contacts on summits in thunderstorms, high wind, and miserable conditions while I read around of 100s of contacts other operators' experiences. I've had to schedule or spot nearly every contact pushing 10W with the KX2 on CW. It's pitiful, really. I need to trust my equipment on long hauls and need to enjoy setting it up each time - there is nothing simpler than a fine-tuned resonant single-element dipole.

I know mechanical linkages are a thing on [multi-band dipoles](https://www.sotabeams.co.uk/two-band-portable-dipole-antenna-system-band-hopper-ii/). But they get snagged. I almost exlusively operate on 20M unless I've had a long day and am operating closer to sunset, and find that I want something to **work every time.** If that means one frequency, so be it. The efficency of a single resonant contact will net me more contacts than a poorly designed double-band system. 

With the way the solar cycle looks and the normal schedule of a mountaineer (off the summit by 12pm) 20M is my frequency of choice.

## Approach

I want to break down every piece of a SOTA setup. More importantly, I want to actually do the math and test behind every piece of equipment. Much of the hobby is based on superstition - a balun must be used here, a choke here, orient the antenna in this direction, measure this with an extra 6 inches. This guide should tell you exactly what to do and the math to prove it.

With the ideal antenna being a 20M resonant half-wavelength dipole, there are several pieces to consider:

1. The coax running to the masthead
2. The masthead - its weight, construction, connectors
3. The balun - often a 1:1 balun is preached as necessity, but I'd like to do the math to see if it really is.
4. The antenna wire itself - what material, diameter, length , and angle?
5. The insulator and guy lines - much supersition around this topic with skin effect and velocity factor of nylon

So, without further ado, the humble coax cable.

# Coax: Weight

The biggest reason _not_ to use coax is weight. It gets tangled if not coiled properly, and requires that a mast setup have both a **masthead** and **cable** weighing on the fiberglass mast to pull it down. 

Remember our coax length will be a maximum of 40 feet. I've never seen hikeable masts longer than 30ft, and mine comes in [20 ft](https://www.n2wu.com/2022-01-08-2021-odds-and-ends/).

## Types of Coaxial Cable

### RG-58

The standard for any radio, lab, or short-distance setup is 50-ohm **RG-58**. This [specification document](https://www.idc-online.com/technical_references/pdfs/data_communications/RG_58.pdf) gives these parameters:

1. Impedance: 53.5 Ohms 
3. DB/100ft: 1.17 ([source](http://www.w1npp.org/events/2010/2010-F~1/ANTENNAS/WIRE/020203~1.PDF) says 1.5)
4. Propagation Velocity:  65.9 % of lightspeed
5. Weight: 37g/m

RG-58 is so widely used _because_ it's so widely used. The link distance for a SOTA setup is shorter than most, so we can theoretically use a cable with a fair amount more loss without more repercussions. Allow me to introduce:

### RG-174

RG-174 is the standard for short-distance SMA connections because of its thin, flexible nature. [Here](https://www.fairviewmicrowave.com/images/productPDF/RG174.pdf) are the specifications:

1. Impedance: 50 Ohms
2. Db/100ft: < 8.4 (this [source](http://www.w1npp.org/events/2010/2010-F~1/ANTENNAS/WIRE/020203~1.PDF) gives 4.54 dB)
4. Propagation Velocity: 66%
5: Weight: **13.38 g/m**

Careful to consider that RG174 drastically increases in Db loss/ft as frequency is increased; hence why it's not often available. RG-174 is rare to find in long lengths with BNC connectors, so most hams never bother.

### Twin-lead

Twin-lead has the benefit of minimal loss. Here are it's specs by comparison:

1. Impedance: 300 Ohms (requiring a tuner or matching network)
2. Db/100ft: 0.55
4. Propagation Velocity: 0.82

However, it should be avoided. Twin-lead is stiff and difficult to work, so transporting anything except twin lead will get your gear tangled and waste time. It also still requires a transformer at either end which we are trying to avoid. Laslty, twin-lead's impedance depends on its length; in installations where center height will change often (mobile setup), twin lead should be avoided. There's also more surface area to get caught in the wind.

## RG-316

RG-316 is often used for short-haul distances as well. Here's its [specs](https://www.fairviewmicrowave.com/images/productPDF/RG316.pdf):

1. Impedance: 50 Ohms
2. Db/100ft: 7.5 dB
4. Propagation Velocity: 69%
5: Weight: **10 g/m**

It is lighter with less loss. However, RG-316 is more rigid than RG-174 and doesn't coil well, from my experiences. Cost seems to be about the same.

[Here's](https://practicalantennas.com/feeding/cables/) a good table with more information.

# Coax: Losses

As we said before, coax has quite a bit of loss due to its length. This section examines the actual length and associated losses with the cable. I've settled on RG-174 for my cale, but I will reitnroduce the other competitors here aswell.

## Length

I'll go ahead and assume this is for operation on the 20m band. A dipole should be at [least 1/4 wavelength above the ground](https://practicalantennas.com/applications/portable/backpack/loss-vs-height/) - my mast extends to about 20 ft, so my length can comfortably be 25 feet. If I am operating in non-backpacking environment (like Field Day) I'd just bring along heavier 50ft sections.

## Return Loss

Return loss is the loss in signal reflected back to the source. This may sound confusing due to double-negatives and reference frames, and it is. Here's a picture to explain it:

![Return Loss](/assets/img/sota_guide/return_loss.png)

_Image on Return Loss taken from [This Video](https://www.youtube.com/watch?v=BijMGKbT0Wk)_

Having return loss is **good**. You want very little of your signal reflected back to the source, so you want **high** reflected loss.

Return loss is caused by impedance mismatch. Your radio is designed for 50 ohms. The coax _should_ be exactly 50 ohms, but design effects and other frequency-dependent effects may change that impedance. Lastly, your antenna may not necessarily be 50 ohms. At any of these points, you may experience loss due to impedance mismatch.

The ideal return loss is infinite. It can be neatly described as the ratio of [incident power to reflected power](https://en.wikipedia.org/wiki/Return_loss), meaning how much power is delivered to the system versus how much is returned. Often return loss will appear as negative - this is just a convention.

$$
 \text{Return Loss} = (-) 10 \log{\frac{\text{P_i}}{P_r}}
  $$

## Insertion Loss

Return loss describes errors with reflected waves. But some losses are unpreventable. _Insertion Loss_ refers to power dissapated in the circuit itself. This is due to ohmic losses, heat, and the actual design. This is the length loss for coaxial cable and antenna wire - something we can't work around.

It is described as the ratio between transmitted and received power. It should be as low as possible.

$$
 \text{Insertion Loss} = (-) 10 \log{\frac{\text{P_t}}{P_r}} 
 $$

These two losses don't describe two halves of a whole, but feature the major points in microwave theory.

## S-parameters

[S-parameters](https://www.microwaves101.com/encyclopedias/s-parameters) describe how signals behave in a "black-box" environment. Factually we identify an input signal (the radio) and observe an output signal (power at the antenna in this case, but generally radiated power). The s-parameters describe what happens in between. These parameters appear in a matrix (called the S-matrix).

![S-matrix](/assets/img/sota_guide/two_port_s.png)

_Visual tool from [wikipedia](https://en.wikipedia.org/wiki/Scattering_parameters)_

There's a lot of behind the scenes math, but the important points are:

* $S_{11}$ is the input Return Loss
* $S_{11}$ is the output Return Loss
* $S_{21}$ is the Insertion Loss
* $S_{12}$ is the reverse isolation, not often used

Remember the black-box diagram. There are inputs on either side of the system.

## Measuring S-Parameters

I just crimped two BNC connectors onto about 40 feet of RG-174. To look at the parameters, I used the [nanoVNA](https://nanovna.com/) as a small but powerful tool in measuring S-parameters. It's more than just VSWR!

Remember I said input/output Return Loss is S11/S22. I chose an arbitary end of my coax as the input and the other as the output. S21 is the insertion loss, which does not require a side. The coax is plugged into both ports. 

Since I usd BC, I had to use a BNC-SMA adapter. The return loss for both of these performed well (terminated in 50 Ohm load, got -43 dB). I got the following table for the cable at 14 MHz:

| S-parameter| Value (dB) | Ideal (dB) |
| --- | ---| --- |
| S11 | -34.5 | -50 |
| S22 | -34.7 | -50 |
| S12 | -0.92 | 0 |

To measure, I perfomed the following steps:

1. Connect both BNC-SMA connectors to the VNA
2. Connect the cable to both connectors
3. Measure "LogMag" on CH0. I'm assuming here that the unused CH1 port terminates at 50 Ohms. This gives S11.
4. Switch sides of the cable and remeasure for S22.
5. Switch "channel" to CH1, and measure S21.

So I get about 1 dB of loss for my entire cable. Not terrible.

![Measuring S21](/assets/img/sota_guide/s21.jpg)

_Measuring S21 with the NanoVNA_

Overall, this is a good gut-check that my cable will work. It isn't a physical test, but a validation that I crimped it correctly.

# Coax: Wavelength Dependence

[This resource](https://practicalantennas.com/applications/portable/backpack/loss-vs-height/) gives great advice on the practical side of coax.

Essentially, the HF signal traveling through the coax has properties, namely its _wavelength_. This wavelength must coincide with the length of the transmission line to ensure maximum current is delivered at the terminus of the cable.

![Helpful picture](/assets/img/sota_guide/standing_wave.png)

_[Standing waves in transmission line](https://www.allaboutcircuits.com/textbook/alternating-current/chpt-14/standing-waves-and-resonance/). Replace 75 Ohms with 50 Ohms, and the power with about 5W._

If there's reflection from S11 or S21, waves will reflect back to the source causing destructive interference. If the coax length is not _resonant_, meaning it is a precise fraction of the wavelength, then standing waves will also be produced. Therefore the coax must be a certain length coincident with frequency.

## Input Impedance

A better explanation uses input impedance. The impedance of the system will change depending on the coax length [source](https://electronics.stackexchange.com/questions/318058/what-is-the-difference-between-characteristic-impedance-and-input-impedance-in-t)

![Input Impedance](/assets/img/sota_guide/input_impedance.png)

Even though the effect may be miniscule, it is important to match the length carefully with the load. This means at 14.05 MHz, my impedance is still 50 Ohms, but if the load impedance was changed (considering how a dipole has characeristic impedance of 70 ohms), then my input impedance is 67.2629 + 9.2925i Ohms.

## Transmission-Line Loss and Velocity Factor

As I said before, S21 is the insertion loss due to natural effects in the cable. The length can actually be measured from the S-parameters using the nanoVNA and open software. 

**[Velocity Factor](https://www.microwaves101.com/encyclopedias/light-phase-and-group-velocities)** refers to the actual speed at which EM waves travel through the cable. We saw on the datasheet that RG-174 is close to 0.66%. Using this speed and measuring delay, the length can be estimated.

[This guide](https://nuclearrambo.com/wordpress/accurately-measuring-cable-length-with-nanovna/) has a step-by-step tutorial, as does [this video](https://www.youtube.com/watch?v=R5iYuGLvlas) I've measured and attached my results here.

![TDR Length](/assets/img/sota_guide/tdr.PNG)

_Estimated Length (9.662m) and Associated Graph_

![Smith Chart](/assets/img/sota_guide/S11.PNG)

_Smith Chart from the software_

# Recommendation / Conclusion

To sum it up, we learned:

* A dipole is a must, but a center conductor requires coaxial cable.
* Coax has different intrinsic losses based on its type
* Coax has S11 (return loss) due to reflections or poor construction
* Coax has S21 (insertion loss) due to length
* The length of a cable must depend on the signal transmitted, or else standing waves will be produced

So what to do with this information?

1. I picked RG-174 as the "ultimate" cable for this antenna
2. Measure the S11 and S21 to verify the coax is within acceptable values
3. Use shorter sections of coax to limit loss
4. Try to make the coax length resonant with the wavelength, but most important make the antenna height resonant

Combined with the [characteristic impedance of a dipole](https://www.antenna-theory.com/antennas/halfwave.php) the transmission line will have an interesting effect on impedance. More to follow on a final methodology for creating this system.

Hope you enjoyed this in-depth look at coxial cable. Note I referenced largely theory and academic resources, not amateur radio. You want to go with the math, not the superstition.

_-N2WU_
