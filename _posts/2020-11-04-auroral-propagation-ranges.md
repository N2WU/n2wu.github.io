---
title: "Auroral Propagation Ranges"
date: "2020-11-04"
categories:
  - "technical"
tags:
  - "diy"
  - "ham-radio"
  - "mathematical-modeling"
  - "matlab"
  - "propagation"
  - "simulation"
  - "space-weather"
coverImage: "steamed_hams.png"
---
# Auroral Propagation Ranges

I decided to look a little more into range estimation behind auroral propagation. It's a very neat magic trick; radio amateurs on the <6m bands point antennas up and north, and can reflect their waves off of aurora, creating large reflection distances.

![](https://n2wu.files.wordpress.com/2020/11/steamed_hams.png?w=639)

_Beamed (and scattered) hams_

Even though auroral reflection is incredibly far-reaching, its distances are seemingly random. I went through some papers (\[1\] at the end of the article) and tried to estimate distance.

## Theory

To get a start on what exactly happens with auroral propagation, I watched [this video](https://hamsci.org/publications/operating-auroral-mode-ham-radio-invited-tutorial) from a past HamSci conference. I learned quite a few important design parameters for transmitting auroral mode:

1. A high-power, CW-capable, VHF rig with directional antennas must be used.
2. Auroral Propagation can only be achieved when the Kp index is high (>4 according to the author).
3. Optimal propagation times are late afternoon / evening.
4. A higher "Auroral height" correlates with a larger transmission distance.

(4) can be explained by the provided graphic. The simulation shown later relies heavily on height of the aurora.

![](https://n2wu.files.wordpress.com/2020/11/geometry_1.png?w=916)

_Geometry of Auroral Reflection_, credit D. Hallidy

My primary source \[1\] details the inner geometry behind propagation. They have several models taking into account the curvature of the earth and a different longitude between transmitter and receiver. They show a more complex model to the one above:

![](https://n2wu.files.wordpress.com/2020/11/geometry_3.png?w=524)

_More Complex Model. Note changing Y\_T_

The math involved with the calculations in this simulation are all angle-based. Our parameter of interest is X\_r, or the receiver's latitudinal position relative to the auroral column. I tried to stay in a cartesian model, but followed the paper through calculations with a round earth.

## Assumptions

Many assumptions and constants had to be taken about the data. First, I assumed our transmitter location to be a constant at west point. I ran my geographic latitude through [NASA modeling software](https://omniweb.gsfc.nasa.gov/vitmo/cgm.html) to create geomagnetic coordinates - West Point had a latitude of 45 geographic and 55 geomagnetic.

Next, I assumed the location of the Aurora to be within the Auroral Zone. This turned to be an incorrect generalization. As stated in the HamSci video, auroral propagation is only possible with a K-index of >4. Therefore, aurora would extend further than the auroral zone (70 deg N) and would be much closer. Below is a model of **visible** aurora at different K-indexes.

![](https://n2wu.files.wordpress.com/2020/11/kp-map.png?w=1024)

_Likely Visible Auroral Zones for different K-indexes_

To make calculations easier, I also said my transmitter and receiver were on the same longitude. This way, reflection can be the primary factor in communication and not signal loss or doppler fading.

Lastly, I only took my final data from the simple geometric model. I encountered a few (addressable) errors regarding calculations with the great circle, so I found it best to leave it out for now.

## Model

My model is as close of a replica to \[1\] as I could get it. Below are the steps used for calculation:

```
 Specify G, D, alpha, h
     - G is difference in Longitude, D is difference in latitude, alpha is coangle in transmitter latitude (north-seeking), h is auroral height
 Compute tau1*r
     - great-circle distance from transmitter to aurora
 Compute G/r
     - r = radius of earth
 Compute gamma_1
     - angle between transmitter plane and auroral column
 Compute theta
     - dip angle (see first figure)
 Compute xt and yt
     - simplified cartesian coordinates of transmitter
 Compute xr
     - simplified cartesian coordinates of receiver (assumed yr = 0)
 Compute tau2*r
     - great-circle distance for xr
 Add 100km to tau2*r and compute gamma_2
     - gamma_2 is angle between receiver and auroral column
 Repeat 9 until tau2*r exceeds great-circle distance, corresponding to a ray tangent to the earth's surface and intersecting the column at a height h.
```

Below is the final equation used to model gamma\_2 to show you how intensive and intricate the calculations were.

![](https://n2wu.files.wordpress.com/2020/11/calc.png?w=956)

_Calculation for angle between receiver and auroral column_

Similarly, the parameter of interest Xr is calculated using a quadratic formula:

![](https://n2wu.files.wordpress.com/2020/11/x_r.png?w=254)

_Calculations for receiver distance from aurora_

Overall, the intensive geometry used for calculation of auroral propagation relies heavily on transmitter latitude, auroral latitude, and auroral height. It produces angles between the aurora and both transmitter/receiver, as well as the cartesian and great-circle distance for each location relative to the aurora.

## Results

With an aurora in the auroral zone and a height of 100km (as described in \[1\]), a signal transmitted from West Point would be received at an angle of 58.87 degrees at a cartesian distance of 547.86 km. I attempted to recreate this using an image editor:

![](https://n2wu.files.wordpress.com/2020/11/untitled.png?w=749)

_1st Auroral Model_

However, there are several glaring issues. First, my gamma angle is in 2D. In a correct diagram, gamma would not be shown: it is the z-angle between aurora and receiver. Next, my signal must travel incredibly far to the auroral zone. With VHF and even a weak-signal mode, I still have a hard chance of hitting this range.

I adjusted the model accordingly with a K-index of 5, meaning usable aurora starting only to the bottom location of Canada:

![](https://n2wu.files.wordpress.com/2020/11/untitled_2.png?w=749)

_Estimated Model for 55 deg latitude aurora_

Overall the model still needs work. The distance between latitudes, G, was so small that it did not play a factor and gave me the same propagation distance. However, auroral column height is a strong indicator of transmission distance. A higher angle means a higher X\_r.

![](https://n2wu.files.wordpress.com/2020/11/plot_x_gamma.png?w=1024)

_Changing Auroral Heights means a larger propagation distance_

## Conclusion

My model is still a work in progress but quite promising with its results. I will be able to forecast the propagation range of my transmissions based on given band conditions. Eventually I hope to be able to transmit auroral mode myself; stay tuned for a non-technical blog post later on my our club's new rig setup.

Once again, space weather continues to amaze me. Based on magnetic storms from the sun, our communication ability in the VHF band can be greatly improved. I hope with my simulation I can take the randomness out of the equation.

It's the ability to transmit. At this time of year, at this time of day, in this part of the country, _localized entirely within our (steamed) ham shacks!_

## References

\[1\] R. Leadabrand and I. Yabroff, "The geometry of auroral communications," in IRE Transactions on Antennas and Propagation, vol. 6, no. 1, pp. 80-87, January 1958, doi: 10.1109/TAP.1958.1144546.

\[2\] Josiah Renfree (2020). Distance calculation using Haversine formula ([https://www.mathworks.com/matlabcentral/fileexchange/27785-distance-calculation-using-haversine-formula)](https://www.mathworks.com/matlabcentral/fileexchange/27785-distance-calculation-using-haversine-formula)), MATLAB Central File Exchange. Retrieved November 3, 2020.
