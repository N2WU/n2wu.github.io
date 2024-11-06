---
title: "Networked Sound with Twin AIO"
date: "2024-11-06"
categories:
  - "nontechnical"
tags:
  - "networking"
  - "streaming"
  - "windows"
coverImage: "/assets/img/speaker_net/windows_media_connect.PNG"
use_math: false
---

This is a quick setup guide to use the Twin AIO speakers on a home network to stream music. I haven't seen much information online, so I figured I'd post it here in case it helps anyone else.

# Concept

I enjoy [FLAC](https://www.whathifi.com/advice/mp3-aac-wav-flac-all-the-audio-file-formats-explained) filetypes for their better listening quality. I wanted to graduate from playing off my phone speaker in my kitchen, so I purchased the [TWIN AIO](https://trianglehifi.us/products/aio-twin?_pos=1&_psq=tw&_ss=e&_v=1.0) speaker by Triangle Audio. It's the cheapest powered (meaning, all-in-one, not requiring an amplifier) speaker I could find with decent reviews, and at first the audio seemed... fine when playing from spotify. It had attractive streaming qualities but I couldn't seem to get anything to work except spotify from my phone or the basic bluetooth features. 

I wanted to play my FLAC files from a home network (eventually a NAS, but for now my home desktop drive) across my LAN to the speakers. The network diagram in the user manual makes this seem easy:

![Network Setup](/assets/img/speaker_net/network.PNG)

So here's what's required for a working setup in Windows 11:

1. A router with a LAN
2. A computer connected to the LAN (wireless or ethernet)
3. Twin AIO speakers connected to the LAN (wireless or ethernet)

The mobile app is helpful if you want to setup and control the device from your phone instead of the computer.

# Setup Steps

## Speakers

Follow along with the [setup guide](https://www.manua.ls/triangle/aio-twin/manual?p=36) to get the twin AIO speakers on your local network. None of the names or parameters seem to matter when you stream it using windows. 

The app is helpful for this stage, as previously mentioned.

## Windows

Go into the **Network and Sharing Center** accessible from the control panel. Go to "Advanced Sharing Center" on the left.

From here, you should enable all features for your network. Your home network should be configured as a private network:

![Advanced Sharing Center](/assets/img/speaker_net/network_sharing.PNG)

With discovery turned on, you should be able to see your speaker. If you navigate to "Media Streaming Options," the speaker should have popped up:

![Media Streaming Options](/assets/img/speaker_net/windows2.PNG)

Next, double-check by going to the "Network" folder in the File Explorer. The speakers should be visible here too:

![Network Folder](/assets/img/speaker_net/windows_sc.PNG)

# Streaming Music

I wanted to use a sleeker, web-based utility like [Jellyfin](https://jellyfin.org/) to stream my music, but turns out I don't have to. I opened my music file with Windows Media Player, went to the bottom-right elipsis (or pressed CTRL+K), then clicked "Cast to Device" and selected my speaker. This is the general screen (it's disconnecting because I turned off the speaker):

![Cast To Device](/assets/img/speaker_net/windows_media_connect.PNG)

And, somehow, it's that easy. You can cycle through songs using the Triangle App on your phone as well.

## Improvements

Eventually I want to make this accessible using a NAS so I don't have to keep my desktop on all the time.

I also want to make the switch out of windows - this may leverage a web-based solution and require a complete overhaul. I'm optimistic Linux would be easier to use.

Hope this helps! Expect more from me in the future after a long long haitus.