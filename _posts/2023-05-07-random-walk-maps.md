---
title: "Random Walk Maps"
date: "2023-05-07"
categories:
  - "technical"
tags:
  - "amateur-radio"
  - "electrical-engineering"
  - "math"
  - "mathematical modeling"
coverImage: "/assets/img/"
use_math: true
---

As a fun weekend project, I took a spin on the classic Windows screensaver and made a map using random-walk theory with maximum-likelihood estimation. Continue reading for math, statistics, and inefficient python code.

![Pipes](https://www.august.com.au/wp-content/uploads/2016/06/Pipes.gif)

_Beloved Pipes background_

# General Idea

I got the general idea for this project from a (subjectively) bad date idea - the [Penny Date](https://www.thepennyhoarder.com/save-money/penny-date-idea/). The "penny date" asks you to walk down the street and flip a coin at every intersection. If it's heads, turn right. If tails, turn left. These random-chance sequences reminded me strongly of [Random-walk models](https://en.wikipedia.org/wiki/Random_walk) and Wiener processes, a statistical idea often found in natural processes like particles in solutions, stock prices, animal routes, and even astrophysics.

Combined with the aforementioned windows screensaver, I thought it would be a nice display to show a vague street-determined outline of a city. Plus it'd help me brush up on my theory.

# Theory

## Random-Walk and Wiener Processes

Random-Walk is a statistical idea based on random probability and probabilistic sequences. The central idea holds (in non-statistical terms):

1. You start at a point and have an equal probability to go in any direction (can be 1D, 2D, N-Dimensional)
2. You move in the randomly determined direction
3. Repeat from step 1

Very basic. I like random walk processes so much because they're fun to visualize. The [wikipedia page](https://en.wikipedia.org/wiki/Random_walk#) has plenty of entries in 1, 2, and 3 dimensions. My approximation more or less yields several 1 dimensional random walks.

Of course, the random walk is often used to describe a process in a higher statistical context. It's a useful tool - modeling processes as random walks allows for better estimations of expected values, variances, and correlations. 

## Maximum-Likelihood Estimation

I wanted to start out with a map of Boston, known for everything-other-than-right angle roads. Take a look at this intersection not too far from where I live! 

![Brookline](/assets/img/brookline_int.png)

_Plum and square for sure. They're actually all Boylston Ave._

So I needed some iterative way to find intersections. To tackle this, I used a bit of image processing and maximum-likelihood estimation.

The general idea of [Maximum Likelihood estimation](https://en.wikipedia.org/wiki/Maximum_likelihood_estimation) is incredibly intuitive. Choose the input that maximizes the likelihood of the input being the true value. In math terms: $\hat{theta} = \text{argmin}_{\theta} f(y \vert \theta)$

This is most often done by trying $f$ with _every possible value of $\theta$_, then choosing the maximum.

In the context of this project, I used the following function to determine if I was at an intersection:

1. Iterate for each of the 8 cardinal directions (N,NE,E,SE,S,SW,W,NW)
2. In each direction, take 20 "fake steps"
3. For each fake step, determine if a road is present by a **threshold** of the RGB values from the map
4. Find a "density" of road present "successes" for each direction
5. Choose the direction with the highest density of road successes
6. Form a 1D random walk in this direction (and the one behind it)

It's important to note that the **threshold** is its own form of maximum-likelihood hypothesis testing. I will revisit this idea, but for now I used the RGB values $\pm$ 5 bits with a cap at the highest and lowest numbers (0 and 255).

Of course there's plenty of problems with this code. A keen reader might see that I use MLE to find a direction avoiding a deterministic 1D scenario, but then _use the 1D direction directly behind the value I just chose_.

Reviewer #2 may also say that this algorithim is highly inefficient and that intersections only need to be calculated _at_ intersections, since most roadways are 1D. Maybe I can leverage those 20 calculations I made to give myself some breathing room in 1D random walks - if I get a "road density" of 100%, I can just keep the direction and do just the random walk.

Personally I think I'm fundamentally correct. I don't quite like that I'm limited to 8 directions when the roads do nothing but curve. Maybe edge detection could come in handy. In any case, I'm not displaying the map underneath my random walk so I'm hiding evidence.

# Code Structure

The overall algorithim follows on this pseudo code:

    Given initial position and road "conditions"
    Repeat N times:
      Repeat for each 8 directions:
        Jump 50 steps
        Determine if there's a road ("hit")
      Pick Maximum Likelihood for direction of road
      1D Random walk on road
        New position = old positon plus/minus 1 pixel

I used numpy and PIL to do the array calculations. Nothing groundbreaking here except mapping the directions to coordinates. My position is stored as an Nx2 vector, where N is the number of iterations and 2 is x and y, respectively.

# Results

This code is _slow_. Probably because I initialized with N=1e6, and each N is doing 20*8 calculations. So only a short 160 _million_ calculations. With several if statements.

I didn't say I was a computer scientist. The endstate is pretty enough, however:

