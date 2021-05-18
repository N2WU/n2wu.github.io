---
title: "W2KGY Satellite Rig"
date: "2020-11-18"
categories:
  - "nontechnical"
tags:
  - "diy"
  - "ham-radio"
  - "how-to"
  - "radio"
  - "rig"
  - "satellites"
  - "space"
coverImage: "rigctld.png"
---
# W2KGY Satellite Rig
It's been three years in the making. We finally got the rotator and the satellite array operational with a linux machine running gpredict. I hope to outline all of our installation steps so no one has to go through what we did.

![](https://n2wu.files.wordpress.com/2020/11/rigctld.png?w=225)

_So many headaches..._

## Hardware

Back in our station overhaul of 2019, we chose an [M2 Antenna Array](https://www.m2inc.com/FGLEOPACK) for VHF/UHF operation. Our rotator is also M2, and can be found [here](https://www.m2inc.com/FGAE1000SCB). We have a [preamp](https://www.m2inc.com/FG2MPA) and a [sequencer](https://www.m2inc.com/FGS3) for weak mode operation as well.

Unfortunately, most of this equipment is professional grade. It caused quite a few headaches as two amateurs approaching the problem. In the future, I wouldn't spring for the professional equipment - I would stick with tried-and-tested amateur gear with an online community.

Our rig is the [ICOM IC-9700](https://www.icomamerica.com/en/products/amateur/hf/9700/default.aspx) . It has a lot of features and 3 different ways to operate it externally. It created a sort of discontinuity in our software, however, since most software hasn't caught up with the technology in the radio. The rig control software uses serial ports and treats every radio like an analog device; I sometimes think programs operate better with a SignalLink and our Icom-756 Pro III than our Flexradio. We originally had an IC-910 but chose to upgrade.

All of our gear is mounted in a server rack right next to our PC for easy troubleshooting/visual indicators. We ran CATV coax up about 30 meters to the roof. This coax offers the best insulation (especially important in weak-signal modes) but is incredibly inflexible. We used type-N connectors, as SO-239 degrades with higher frequencies (more information on setup [here](http://www.qrz.com.hr/wp-content/uploads/2011/03/k6pf.pdf)).

![](https://n2wu.files.wordpress.com/2020/11/selfpic.jpg?w=1024)

_Satellite Rig! Pardon the mess_

## Software

We chose to use Ubuntu on our controller computer. With the functionality and interfacing we required, we believed windows would get too cumbersome. Originally, we used a windows system with Ham Radio Deluxe, but ran into many errors on satellite rotation. Linux allowed full user control and no strange access privileges.

To interface with the radio, we used [H](http://hamlib.sourceforge.net/manuals/hamlib.html)[amlib](http://www.qrz.com.hr/wp-content/uploads/2011/03/k6pf.pdf) and **[rigctl](http://manpages.ubuntu.com/manpages/xenial/man8/rigctld.8.html)**. There is a lot of support online and constant updating. When we first started the project, our radio was not available on rigctl. After a few months, they provided support for the IC-9700! As explained later, it required intense knowledge of how the radio communicates; just a lot of research if you aren't familiar with it.

Our antenna rotator did not come with rotator software. We used its manuals and wrote our [custom script](https://github.com/KE8JCT/m2rotate) to interface with the rotator. It took several attempts, some burned switches, and torn coax, but now the array can track just about anything. Calibration is key for this setup, and it can be done with just two people with handhelds and a compass. Find your actual zero degree elevation/zero degree (north) azimuth, then zero out the settings in the rotator to do so.

## Antenna Rotator Instructions

Setting up the rig only takes one instruction after downloading the python script:

```
python3 m2rotctl.py
```

The python file is pretty responsive, so it should be kept open in a terminal while you execute the rest of the rig programs. However, radio control is a much different issue.

https://ukamsat.files.wordpress.com/2015/05/camsat-cas3e.jpg

_XW-2F Satellite_

## Rigctl Instructions

This took a lot of trial and error. To set up the rig, we followed instructions directly from [this link](http://www.dk1tb.de/IC9700_settings.htm), namely:

```
2. CAT control via the USB port of the IC-9700

On page 2/3 set
CI-V USB Port Unlink from [Remote]
CI-V USB Baud Rate 57600, set same Baud Rate in SatPC32.
CI-V-USB Echo Back ON
CI-V DATA Baud Rate 9600
```

After a successful installation of hamlib, we used the command below to run the rig:

```
rigctld -m 3081 -c 148 -r /dev/icom9700 -s 57600 -P RTS -vvv
```

Note the 57600 baud rate, which we set on page two in CI-V control.

## Demonstration

Below are the steps I take every time I try to use the rig. I will use gpredict or WSJT-X for communication.

1. Turn everything off
2. Turn on radio and rotator - ensure satellite mode is off
3. Turn on PC
4. Load preferred rigctld command
5. Load rotator script
6. Open gpredict
7. Find satellite, open antenna control / radio control panels
8. Click "engage" then "tune" or "track"
9. Enjoy!

Now, this process is still a work in progress. Currently, we experience radio failure whenever the antenna rotates, so we end up relaunching the script several times. When rigctl fails, use CTRL+C to exit the program, up arrow to load the last command, and enter to rerun it. It will work again. We expect to fix this issue soon.

## Conclusion

So far, I've made two satellite contacts using FUNCUBE and XW-2F. I was able to talk to Kentucky and New York (actually just the grid square over from mine, we didn't even need a satellite!). I have made one SSB contact and one CW contact, and hope to start my grid square quest soon!

![](images/funcube-1-flight-model-image-credit-wouter-weggelaar-pa3weg.jpg)

_FUNcube_

Amateur Satellites are the cutting edge of ham radio, but require much infrastructure to get set up. I recommend using equipment you know has community support, since you can never trust the manual.
