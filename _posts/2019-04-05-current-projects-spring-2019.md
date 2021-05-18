---
title: "Current Projects Spring 2019"
date: "2019-04-05"
categories:
  - "technical"
tags:
  - "aprs"
  - "arduino"
  - "club"
  - "hamshield"
  - "projects"
coverImage: "bartlett.jpg"
---
# Current Projects Spring 2019
As a first post, I am writing about my current projects. Expect to see a fleshed-out post for each finished project. Two deal with APRS.

## 1\. Billy's Arduino-Controlled APRS/Handheld Transmitter

This project is taken directly from [http://www.billy.gr/arduino-aprs-tracker/](http://www.billy.gr/arduino-aprs-tracker/)

I'm looking just to follow through with it as close as possible and see if I can make my own APRS transmitter using these common materials. This project is almost complete, I am only waiting on the radio cable to come in.

What I've learned:

- PCB Design with Ultiboard and Multisim
- Circuit Design, math with voltage regulators
- Engineering/practicality of a mobile transmitter
- 3D Printing/waterproofing

Problems I've had:

1. Soldering
2. Soldering
3. Sourcing materials - an LM317 is overkill as a voltage regulator
4. Probably arduino code, haven't touched it yet
5. Using Multisim to print the board
6. General circuit design: space/efficiency etc

## 2\. HamShield Mini APRS Beacon

The Hamshield is a wonderful SDR option for those who like to tinker with radio. The HamShield Mini is its younger brother that the family forgot about.

![](images/hamshieldmini1_300x300.jpg)

Often Overlooked

In reality, I'm very excited to get this to work. It has the opportunity of a tiny form factor (not that it actually "daughter-boards" anything; it's much bigger than an arduino mini) and the usefulness of being connected to microprocessors. It is probably 1/10th the size of Billy's circuit, and I won't have to worry about bad solder joints.

Of course, the catch is that this is an uphill battle. While [some](https://www.enhancedradio.com/pages/hamshield-mini-pinouts) documentation exists for it, it's not a shield, so you are often left scratching your head for what pins connect where. The code is updated weekly, so things will only improve.

However, I'm incredibly thankful for Casey Halverson and Morgan Redfield; the two have decided to fully support the development of my transmitter and usually respond several times a week to get me up and running. I plan to fully document how I completed my project in a future post when I myself figure it out.

Project-wise, it's the exact same. I am making an APRS transmitter to use when I bike. Some considerations I have:

- How will I power the device?
- Will it need to be waterproof?
- What form factor am I looking at?
- Do I need a special antenna?
- Will the small power output (250 mW) impede on my ability to reach stations?

It will prove to be a great learning experience, and the HamShield seems incredibly versatile if I know how to play its game.

## 3\. Club Projects

I am looking to improve our club activities, so I gathered some things that seem fun and engaging. I'm curious to know what other clubs do.

### 1\. Transmitter Hunting

This seems engaging partly because you don't need a license. It may be a large activity, and it could have the ability to attract several potential members. I would hook up the hamshield mini with a continuous morse output and hide it in the woods.

### 2\. ISS SSTV

This is our best option as a small club. I check [this site](http://ariss-sstv.blogspot.com/), then check flyovers [here](https://spotthestation.nasa.gov/). The meeting time is already set, all I have to do is give location, install Robot36 on my phone, and provide antennas. You don't need a license and can learn about so many facets of amateur radio - plus, the paper certificate you get is pretty nifty.

### 3\. College Contests

With college roundup and NAQP / NACC , I can show our members what serious amateur radio is like. Not only do we have a chance for rare DX's, we can compete against other clubs to earn name recognition. Plus, if we score well our school would love to hear about it and advertise our club. We just need more than a 100w dipole to do well.

73's to all, please comment with anything you found interesting/your club meetings/any questions you may have.
