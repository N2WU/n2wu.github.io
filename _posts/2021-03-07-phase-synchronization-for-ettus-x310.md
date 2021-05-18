---
title: "Phase Synchronization for Ettus X310"
date: "2021-03-07"
categories:
  - "technical"
tags:
  - "beamforming"
  - "diy"
  - "ettus"
  - "gnuradio"
  - "mathematical-modeling"
  - "mimo"
  - "radio"
  - "radio-direction-finding"
coverImage: "splash-1.png"
---
# Phase Synchronization for Ettus X310

I recently have been experimenting with the time-synched Ettus X310 for beamsteering and MIMO research. However, the device receives both signals with an intrinsic phase offset that requires syncing and calibration - something I fixed with a GNURadio script. I share my theory and code below.

![](https://n2wu.files.wordpress.com/2021/03/splash-1.png?w=421)

#### Finished Flowgraph

![](https://n2wu.files.wordpress.com/2021/03/full_flowgraph.png?w=1024)

_Full Flowgraph_

The function below takes in two USRP signals (from a SBX board in this case) and calibrates both the magnitude and phase of the 2nd signal. It uses a "Function Probe" block to find the approximate frequency (get\_freq) and phase delay (get\_phase) of the signals. It then uses a time delay and an amplitude amplification algorithm to "calibrate" the second signal. Because of the delay block, the algorithim can calibrate accurate phases +/- 180 degrees resulting in the output below:

![](https://n2wu.files.wordpress.com/2021/03/screenshot-from-2021-03-05-17-29-00.png?w=1024)

#### Amplitude Calibration

I created a half-wavelength uniform linear array with two elements from the X310 but received the following initial output from an ordinary oblique angle:

![](https://n2wu.files.wordpress.com/2021/03/screenshot-from-2021-03-05-10-33-57.png?w=1024)

_Attenuation on 2nd Signal_

The amplitude of the signal here, though calibrated, is much more attenuated than the first blue signal. Even with uniform gain, this output still occurs. Rather than fix it, I corrected the output to match amplitudes through amplification:

![](https://n2wu.files.wordpress.com/2021/03/amplitude.png?w=627)

Amplitude Magnification

This section measures the two magnitudes of the exponential form of the signal, then finds the ratio between them. This constant is then multiplied by the original magnitude of the signal to make it equal to the magnitude of the 1st signal. Matching these amplitudes results in a calibrated setup:

![](https://n2wu.files.wordpress.com/2021/03/screenshot-from-2021-03-05-12-15-29.png?w=1024)

_Synced Signals_

#### Phase Calibration

The ettus, according to [this link](https://kb.ettus.com/Direction_Finding_with_the_USRP%E2%84%A2_X-Series_and_TwinRX%E2%84%A2), often has a random phase offset due to timing differences. Any time or phase-delay signal manipulation (like MUSIC, psuedo doppler, or beamsteering) requires a time- and phase-synced signal. My code needed to identify this phase shift and implement it via a time delay. Although I was using GNURadio 3.9.0, my "phase shift" block failed to load.

My first step was to calculate a phase difference between the signal. For this, I took the phase of the complex exponential form of the signal using these blocks:

![](https://n2wu.files.wordpress.com/2021/03/phase_divide.png?w=892)

_Phasor Division_

From _Signals and Systems_, a complex signal has the following form:

![](https://n2wu.files.wordpress.com/2021/03/complex_form.png?w=823)

If the two signals are divided, the following phase shift occurs:

```
x1(t) = Ce^at
x2(t) = Ce^at
x3(t) = x1(t)/x2(t)
x3(t) = (C1/C2)e^t(a1-a2)
```

The (a1-a2) term is my phase shift relative to a noncomplex signal - a sine wave. I take this phase shift and multiply it by a constant to turn it into an amount of samples to delay my signal. I found this value to be 1000/3 through qualitative analysis; I have little reason for this inference.

#### Experimental Setup

I used a signal vector generator and my Ettus X310 to receive two signals. I created a 400 Hz tone modulated via AM modulation on 466 MHz transmitted to the Ettus via dipole antennas on all elements; this result in a highly attenuated and unstable signal. Instead, I used a BNC splitter and connected the generator directly to the source.

#### Conclusion

The most time-consuming step in phased array applications is phase sync. I hope with this script I will be able to calibrate slightly more effectively than before, and be able to implement **time-delay** **beamforming** in some of my next experiments.

I plan on implementing this to Coherent RTL-SDR receivers when possible for an economic solution. Also, I experience limitations from my test from using a basic AM signal as the calibration source - I have to figure out a robust way to calibrate using either a more complex signal or a better process for calibration and switching.

Code available [here](https://github.com/KE8JCT/grc_x310_ps).
