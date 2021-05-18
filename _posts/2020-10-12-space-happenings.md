---
title: "Space Happenings"
date: "2020-10-12"
categories:
  - "nontechnical"
  - "technical"
tags:
  - "antenna"
  - "diy"
  - "eme"
  - "ham-radio"
  - "mathematical-modeling"
  - "meteor"
  - "radio"
  - "space"
  - "space-weather"
coverImage: "cloud.png"
---
# Space Happenings

Over the past weekend and throughout all of October there are a lot of space weather-related amateur radio events. I will be describing my experience and setup with Meteor Shower Communication (MBC) and Earth-Moon-Earth Communication.

![](https://n2wu.files.wordpress.com/2020/10/cloud.png?w=220)

_Blame it on the weather_

## Theory

MBC and EME are both space weather anomalies resulting in long-distance VHF propagation. Propagation via these distances results in transmission distances outside typical line-of-sight range.

Meteor Burst occurs when meteor trails leave short, fast-dissolving ionized trails in the sky. Electromagnetic waves can actually bounce off these trails and travel far distances. However, the trails are hard to identify and impossible to detect; because they are up for such a short time, usually only short transmission modes can make contact. **MSK144** is the mode because of its short transmission time.

EME occurs in a similar manner. Rather than reflect off of meteor trails in the E and F layers, electromagnetic waves travel to the moon and reflect off of it like a mirror. This results in cross-continent radio contacts on a line-of-sight radio. The biggest difficulty in overcoming propagation loss in EME does not depend on reflection time, but rather the impossible DX distance - nearly 210 km one way!

For this journal, I chose to model propagation and path loss for these two communication modes. I then hoped to see how our MBC/EME results compare with others.

## Rig

Our rig is a 2m/70cm ICOM-9700 with an [M2 Satellite Rotor](https://www.m2inc.com/FGAE1000CB). We have a computer running Ubuntu with GPredict and hamlib to control it. We often encountered several problems identifying serial ports of communication with the radio. We fixed this by having dedicated serial ports (instead of tty/USB0, the port for the icom is always tty/icom-9700). We also got WSJT-X to work on ubuntu _through_ hamlib. This was the easiest way to set up a TX/RX link.

We suffered greatly in output power for the radio. We still have _selectors_ that must be installed on the antenna system to maximize power - doing so would greatly increase our transmit ability.

Here's a self-timed photo of me operating! The club has a "lived-in" feel.

![](https://n2wu.files.wordpress.com/2020/10/selfpic.jpg?w=881)

Operating JT65!

## Meteor Shower Communication

The Draconids meteor shower reached its peak on 07 October this year. It is a variable shower, with non-characteristic visibility and intensities. Our weather looked clear until right before the shower; Draconids is best seen just after sunset. Of course with our luck clouds rolled in and resulted in a thick blanket unsuitable for meteor viewing. My attempts at MBC were futile as well; aiming our yagis at an arbitrary azimuth and transmitting MSK144 proved ineffective with 0 contacts made.

Below is the estimated path loss (in DB) I had for 2meters using MBC as a function of distance in km. Please excuse the lack of labels:

![](https://n2wu.files.wordpress.com/2020/10/microsoftteams-image-3.png?w=772)

Further, here is a snapshot of [pskreporter](https://pskreporter.info/pskmap.html) during my communication window. I am assuming only meteor scatter contacts are made using MSK144 on 2m. You can see that the whole eastern seaboard is dark, while Europe had a nice QSO party with MBC, taken just after sunset relative to the two locations.

![](images/screenshot-from-2020-10-07-19-29-16.png)

![](images/capture.png)

## ARRL EME Contest

It is hard to believe that the ARRL can actually sponsor an EME contest, when formerly it took tens of thousands of dollars to secure a successful EME contact. To try EME from our station, I waited for the contest (when many stations would be listening) and for when the moon would be overhead based on [heavens above.](https://www.heavens-above.com/moon.aspx?lat=0&lng=0&loc=M&alt=0&tz=CET) Unfortunately (but expectedly), New York had a thick amount of cloud cover that day. Supposedly VHF is unaffected by clouds, but I have to blame my lack of contacts on something.

Below is a graph of path loss as a function of frequency, and separately gain as a function of frequency. Even though path loss is increased for higher frequencies, their lower wavelength allows for higher-gain dish antennas.

![](images/pathloss_eme.png)

![](images/gain_eme.png)

As expected, everyone had fun but my station. Below is a snapshot of PSKreporter using MSK144 on the time I tried to transmit:

![](https://n2wu.files.wordpress.com/2020/10/cloudcover_12oct.png?w=907)

_Cloud Cover for my area during the weekend._

![](https://n2wu.files.wordpress.com/2020/10/jt65_12oct.png?w=1024)

_MSK144 - EME!_

## Conclusion

Although there was cloud cover and space weather rain on my parade, I still enjoyed the events. Space weather is such an oddity - just because something thousands of kilometers away is acting strange, your radios will work infinitely better. In a sense, it's almost magic.

In further work I'd actually like to make some contacts. That must come down to installing the selectors on the antenna, but may require some cable runs up 4 stories. I would like to believe my propagation math is sound and that 144MHz is a suitable frequency for space weather.

Eventually I want to push the limits further and try auroral scatter or sporadic E. Those are much harder to characterize and transmit through, however.
