---
title: "More Twin AIO streaming"
date: "2024-11-06"
categories:
  - "nontechnical"
tags:
  - "networking"
  - "streaming"
  - "windows"
coverImage: "/assets/img/speaker2/ums1.PNG"
use_math: false
---

Another quick update. Following my [previous post](/_posts/2024-11-06-networked-sound-with-twin-aio.md), I improved the ability to stream music with albums and other audio sources.

# Setup

Remember to follow the previous outlined steps. I had to enable network sharing on my PC. I'm not sure if this makes a huge difference, but if the software is Peer to Peer the speakers will definitely need to be allowed to communicate with your desktop. I am still using Windows, though this solution is OS-agnostic. It doesn't yet use a NAS as the optimal solution should.

# Universal Media Service

Because the Twin AIO speakers are Universal Plug and Play (UPnP), I figured there would be software using this feature. [Universal Media Service](https://www.universalmediaserver.com/) seems to fit this bill - it is a poorly documented but effective streaming service. On its website, it claims to have to have the same functionality as Windows Media Player. Follow along with [this setup guide](https://support.universalmediaserver.com/guides/how-to-play-media).

In any case, download and run the software. You should immediately see the speakers in the "networked devices" page.

Do **not** use the "new" UMS GUI. right click on your Windows tray and open the "old" settings menu.

![UMS](/assets/img/speaker2/ums3.PNG)

Here you can see the speakers:

![UMS2](/assets/img/speaker2/ums2.PNG)

Clicking on the speaker brings up this menu:

![UMS1](/assets/img/speaker2/ums1.PNG)

Where you can navigate to the bottom and select your locally hosted music. It seems to play with short latency and allows me to view the album art and runtime on my the AIO app:

![SC](/assets/img/speaker2/sc.PNG)

This should loop through songs as an album would. If you select the "Cue" file, it should also transcode and play the whole playlist. 

Hope this works for you! Glad to finally have a system better than spotify streams off my phone.