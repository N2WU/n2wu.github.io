---
title: "SOSH Spud Math"
date: "2020-04-16"
categories:
  - "technical"
tags:
  - "diy"
  - "physics"
  - "potato-cannon"
  - "usma"
coverImage: "soshcannon.png"
---
# SOSH Spud Math
This Thursday was the biannual Department of Social Sciences (SOSH) Run for the completion of the SS307 International Relations Final Paper. With school in an online format, I decided to take delivering my paper into my own hands.

Potato cannons aren't rocket science, but Neoliberal Institutions certainly are.

![](https://n2wu.files.wordpress.com/2020/04/image-2.png?w=254)

Engineering and Liberal Arts should never mix.

## Assumptions

You'd be surprised with the amount of assumptions on creating an ICBM potato gun. First, for the projectile I neglected air resistance; I didn't want to do integrals for a 1,000 km distance. I imagined my projectile as an average large potato - .250kg - with 10 pages wrapped around it, bringing the total mass to .255kg.

Next, I assumed I would not be affected by the coriolis affect or wind on my journey from Ohio to West Point, bringing my crows flies distance to 1050km.

I assumed an ideal reaction, where all energy in my system is conserved from the propellant explosion to the kinetic energy of my potato.

As mentioned in the video, the [Air Force Academy](https://www.technologyreview.com/2013/05/08/178524/us-air-force-measures-potato-cannon-muzzle-velocities/) found the average velocity for a potato to be 28-48 m/s; I chose 38 right in the middle for my hairspray propellant.

## Math

First I found the energy for my system. If the muzzle velocity is 38 m/s at a height of 0, my energy is simply:

![Kinetic energy review (article) | Khan Academy](https://n2wu.files.wordpress.com/2020/04/image.jpeg?w=300)

or 184.11 J. I modified 2d kinematics equations to find velocity as a function of X-distance:

![](https://n2wu.files.wordpress.com/2020/04/image.png?w=200)

My angle is the ideal 45 degrees, and R = 1050000m. However, I made a mistake in the video calculation - I divided the range by 10 rather than multiplying it. This _probably_ throws my results way off, but every science involves finding and correcting mistakes. So, using the correct math, I find my velocity must be 3,207.8 m/s. Using the below equation, change in y of 0, and the quadratic equation, I found the flight time:

![](https://n2wu.files.wordpress.com/2020/04/image-1.png?w=225)

t = 462.92 seconds, or about 7.72 minutes. So I can start the paper comfortable at 1500 with a deadline of 1600. Putting my muzzle velocity back into the energy equation yields E = 578,812.5 J, or divided by a single explosion's 184.11 J, I need the force of about 3,144 cannons.

## Auxiliary Information

With a missile range of 1050km, I violate the Intermediate-Range Nuclear Forces treaty signed by President Ronald Reagan found [here](https://en.wikipedia.org/wiki/Intermediate-Range_Nuclear_Forces_Treaty).

While making the video, I attempted to get my paper to launch like a harpoon gun; I tied a string to my paper (folded like post-it notes) and the potato and expected a launch like [this](https://youtu.be/FRtEWR3qG4Q). However, the string was moving too fast for the paper and immediately broke free.

I'm sure an HF transmission would be more reliable, but it would take me several days to pound out the morse!

## Video

https://www.youtube.com/watch?v=zyhswyqWhBY
