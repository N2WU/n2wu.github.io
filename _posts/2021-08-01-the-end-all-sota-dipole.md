---
title: "The End All SOTA Dipole"
date: "2021-08-01"
categories:
  - "Technical"
tags:
  - "amateur-radio"
  - "sota"
  - "boulder"
  - "usiap"
  - "diy"
  - "antenna"
  - "nanovna"

coverImage: "/assets/img/sota_dipole/cover.jpg"
---
# Introduction

As you've read from my several (4 1/2) SOTA outings, I very much enjoy the challenge of remote field-expedient NVIS antennas. Although I've been at elevations reaching 11,000 feet, I have never had much success on the bands - I tune to an SWR of about 1.6:1 and struggle to reach California with 10 watts CW. I sought something better - _The End-All SOTA Dipole_. In this post I will detail my literature review, materials needed, construction, and tuning to build your very own (patent-pending) N2WU SOTA dipole!

![Title Image](/assets/img/sota_dipole/dipole_full.jpg)

# Past Antennas

## The "Linked Doublet"

My former antennas as you remember are the [QRPGuys Half-wave Endfed (linked)](https://qrpguys.com/qrpguys-end-fed-wire-antenna) and my own personal attempt at a dipole - the **"linked doublet"**. Words do not do her justice - see for yourself:

![Linked Doublet](/assets/img/sota_dipole/linked_doublet.jpg)
_My trusty steed. May she rest in peace._

In the simplest terms possible (and please don't laugh), the linked doublet is about 30ft of 450 Ohm ladderline connected to roughly-estimated resonant 10,20, and 40m linked dipole lengths in a vee configuration fed to the balanced input on my tuner.

Let me explain why this is a bad idea - theory curteousy of the brilliant[Rex KE6MT](https://www.ke6mt.us/)
Doublets rely on a _velocity factor_ - while ground travels on one ladderline, the signal travels on the other. Doublets's velocity factor is influenced by frequency - LL lengths like 30ft are [terrible](https://kv5r.com/ham-radio/ladder-line/) for doublet antennas.

Not only would my ladderline have to be linked in itself, but I chose the worst length for a single length of ladderline. No wonder I barely got Nevada...

So the doublet sucked. But a centerfed dipole places the highest amount of current near the center which would theoretically get your signal out the most.

## QRPGuys Half-Wave Linked End-Fed

My other antenna, and my workhorse once I found the glaring issue with my doublet, was the [QRPGuys end-fed](https://qrpguys.com/qrpguys-end-fed-wire-antenna). It said no-tune, but I was the one who cut the lengths. Therefore I had to tune it. I cut the 40m half-wave in half again to make a 20m element that linked to 40m. It performed pretty well _at the top of a mountain_ getting me as far as San Francisco and Texas.

[Tim N6CC](https://www.n6cc.com/field-antenna-kit/) had great choice words for the end-fed antenna:
> End-fed wires? They must be great; everyone is selling them!  Meh.

>The generic End Fed Wire and the End Fed Half Wave (EFHW) is a special case of those.  They are all the rage these days, and as with any conductor up in the air, they will produce contacts.  

I knew I could do better than burying my highest concentration of current in the ground. At last, the N2WU SOTA Dipole!

# Preparation

I spent a lot of time researching how to craft a simple dipole. They all agreed (erroneously) on one point:

![Misconceptions](/assets/img/sota_dipole/joke_1.png)

Make no mistake, this is a challenging beginner project. But the learning curve is inverse - if you do it once, the second time is much easier.

## Literature Review

Much of my design comes from [this video](https://youtu.be/o8RoYrmr8o8). I googled "Center-fed dipole insulator" for construction ideas on the center elements and insulators. Of course, the best resources for linked dipoles can be found on [SOTABeams](https://www.sotabeams.co.uk/linked-dipoles/), [VK5LA](https://vk5la.wordpress.com/2013/10/07/putting-together-a-link-dipole-for-sota/), and [CQHQ](https://cqhq.wordpress.com/2011/03/19/linked-dipole-for-portable-operations-such-as-sota/). They all give the same advice - keep it light, use a 1:1 choke, and get creative with the linked insulators. Armed with this approximate knowledge, I took to the garage to scrounge for materials.

## Materials needed

I needed the following materials. I am not associated with any amazon links.

1. 75ft Insulated Wire. I used 24gauge teflon-coated copper stranded wire.
2. 4 sets of [2mm Bullet Connectors](https://www.amazon.com/Plated-Female-Bullet-Connector-Battery/dp/B00T5SW7FE)
3. 3 inches of 1.5" diam. PVC pipe
4. Zip ties (20 to be safe) - the smaller, the better
5. [BNC Chassis Mounts](https://www.amazon.com/dp/B07FB39S1L?psc=1&ref=ppx_yo2_dt_b_product_details)
6. 1' x 1/2' Polycarbonate Sheet - $2 at a hardware storage
7.  [FT 140-43 Toroid](https://www.amazon.com/Fair-Rite-Toroid-Core-FT140-43-Ferrite/dp/B0178IABXW/ref=pd_nav_hcs_rp_1/133-4007837-8913737?pd_rd_w=PP1tM&pf_rd_p=3eebbeb9-8158-4a79-b42b-433ba10b6d1c&pf_rd_r=330VQ5NA9SYYNWEGG9G2&pd_rd_r=626fe3af-9521-4bb6-87d3-45f5413646c9&pd_rd_wg=FsSZJ&pd_rd_i=B0178IABXW&psc=1#descriptionAndDetails)
8. 4ft of 18-22 gauge speaker wire (two separate conductors) OR RG-58
9. Shrink Tubing
10. 20-30ft of RG-58 with BNC connectors
11. Female BNC - Male SMA adapter for the NanoVNA


## Tools Needed

1. Drill with 1cm-2cm drill diameter bits
2. Hacksaw/Table Saw for cutting PVC and polycarbonate
3. Wire Strippers / Cutters
4. Soldering Iron / Solder
5. Electrical Tape
6. Your favorite Antenna Analyzer - mine is the [NanoVNA](https://www.amazon.com/dp/B07T6LXNTV?psc=1&ref=ppx_yo2_dt_b_product_details).

## Cherries on top

1. Hot glue gun
2. Nylon rope
3. A [kite winder](https://www.prokitesusa.com/20lb-x-200ft-nylon-kite-line-w/-quickretrieve-kite-winder/) This is now in my SOTA kit.

# Construction

This was a long process. Measure twice, cut once. Or, measure once and get on with it already.

## Center Element

![Center Element](/assets/img/sota_dipole/center_balun.jpg)
_Closeup of my Center Element_

I have seen a lot of designs that use [3D printing](https://www.thingiverse.com/thing:2804993) or some sort of mount for the BNC chassis. Had I a 3D printer, I would have gone with this method. However, I was armed with only my wits and the trash in the garage. Googling "Center Dipole Element" came up with several PVC designs so that's exactly what I used. Here's a breakdown of the steps used to make the center element:

1. Wind 1:1 choke
2. Cut and Drill PVC Pipe
3. Install BNC Mount
4. Install Balun / Solder
5. Install wire lengths

For the 1:1 choke, reference  [this video](https://youtu.be/o8RoYrmr8o8). You won't need a lot of extra speaker wire lengths since everything is jam=packed inside the pipe.

The PVC pipe has the following holes drilled:

![Center Element Construction](/assets/img/sota_dipole/pvc_drill.png)
_Drilling Chart_

Additionally, you can secure all elements within the center insulator with hot glue and zip ties. PVC endcaps could even help waterproof the design.

## Linked Insulators

The linked insulators are literally just scrap. Tim N6CC has an awesome design on some of his portable military operations:

![Insulator](/assets/img/sota_dipole/n6cc_spoon.jpg)

All I use are 1" x 2" polycarbonate sections with 2x 2mm holes drilled in:

![N2WU Insulator](/assets/img/sota_dipole/insulator_2.jpg)


My linked connectors are very useful bullet connectors designed for motors and batteries. Stress is alleviated (in the antenna, not in me) with zip ties. Shrink tubing minimizes RF exposure and waterproofs. When I install the antenna elements, I have to follow a certain procedure to make sure I don't forget anything.

![N2WU Insulator Soldering](/assets/img/sota_dipole/soldering.jpg)

1. Thread the wire through the fiberglass
2. Slide heat shrink onto wire and move about 2' down the wire
3. Strip and solder bullet connector
4. Wait, then apply heat shrink
5. Add zip tie

![N2WU Insulator Finished!](/assets/img/sota_dipole/insulator.jpg)


My job lends itself to being really good at following directions, so this is the most helpful way I could communicate.

## Wire

I used the SOTA Extras [Dipole Calculator](https://www.sotamaps.org/extras) for all my lengths. I chose 10,20, and 40m CW. When I measured, I marked at the exact measurement and gave myself an extra foot when cutting. On tuning I still started at the exact length with the extra folded over.

![N2WU Dipole](/assets/img/sota_dipole/sota_schem.PNG)

# Testing

Here's where you test your mettle _(and metal!)_. This can be an incredibly painful or a pain-free process depending on the HF gods.

## Field Deployment

First, I was digging around for some rope and found 20lb-rated Kite String with a [winder]((https://www.prokitesusa.com/20lb-x-200ft-nylon-kite-line-w/-quickretrieve-kite-winder/). This little guy made my day. Here's how I deployed the antenna each time:

1. Affix tossable weight (fishing lead, rock) to nylon string
2. Chuck into tree, preferably 30ft tall
3. Eyeball center element location on string when weight touches ground
4. Tie slipknot in kite string
5. Affix center insulator to string via carabiner
6. Plug in feedline
7. Hoist
8. Secure radiating elements

The smaller weight, the less likely you are to get snagged irretrievably on branches. Tim N6CC uses lead fishing weights, and I agree - the smaller and denser, the better.

![Field Rigging](/assets/img/sota_dipole/rigging.jpg)
_Picture of Kite Winder, rock, and extra brick_

![Center Element](/assets/img/sota_dipole/dipole_tree.jpg)
_Center Element hoisted_

## Tuning

Tuning is a careful art, of sorts.

![Tuning Advice](/assets/img/sota_dipole/joke_2.png)
_Expert Elmer Bob Ross gives some advice_

Some general tips for tuning:
- Keep both elements identical in length
- Fold instead of cutting
- Never do anything permanent while the antenna is in the air

I folded my lengths instead of cutting. Here's how I tuned:

1. Begin at the calculated length with 12" of fold-over taped to the antenna itself
2. Using the NanoVNA, measure SWR for (center - 1 MHz) to (center + 1 MHz). For example, 13 to 16 MHz. You should be pretty close already
3. Make calculated adjustments to both antenna elements at the same time _without cutting_
4. Find your final measurement and add 2" for the linked insulator portion

That's it! It is a lot of back-and-forth, but your center element doesn't move, just the guy ropes and your end radiators. Also to save time, store your [calibration settings for the NanoVNA](https://groups.io/g/nanovna-users/topic/70101294).

![Display Output](/assets/img/sota_dipole/nanovna.jpg)
_NanoVNA Display for 20M_

# Final Thoughts

After all required tuning, I stuck a last pair of insulators on the end to tie down with guy wires. To coil the rope, I make figure-8s with my index and thumb similar to [this method](https://jollytrails.com/2017/10/07/rope-cord-coil/).

Overall I am glad to finally have a working solution for the summits. Watch out, 1-pointers of the Greater Catskills Range!

_I had a great time making this antenna. Stay tuned for W2KGY's first annual SOTA activation this fall!_
