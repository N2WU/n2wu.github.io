---
title: "OBS / Microsoft Teams Webcam Streaming"
date: "2021-04-06"
categories:
  - "nontechnical"
tags:
  - "covid"
  - "diy"
  - "microsoft-teams"
  - "obs"
  - "streaming"
  - "work-smarter"
coverImage: "bart.png"
---
# OBS / Microsoft Teams Webcam Streaming
Recently I've been a little tired of some of the rules in place at the Academy. Literally - I keep falling asleep during class. Rather than fix this problem internally (officer development and all that), I've decided to outsmart it. I have been using **[Open Broadcaster Software](https://obsproject.com/)** through Microsoft Teams (and some ancillary programs) to stream looped video.

![](https://n2wu.files.wordpress.com/2021/04/kevin.png?w=1024)

_If only OBS did home defense too!_

## Program Installation

You will need the following hardware and software for my specific setup. You can probably achieve this through different programs if you have a flavor.

- Open Broadcaster Software
- [VB Audio VoiceMeeter Banana](https://vb-audio.com/Voicemeeter/banana.htm)
- Microsoft Teams **(Disable GPU Acceleration in Settings)**
- A webcam, microphone, and headphones. Integrated is fine.

## OBS Configuration

Here is the tricky part.

1. Open OBS and navigate to the "Sources" tab.
2. Add (plus) Video Capture Device. Choose your webcam.
3. Add audio capture device. We will come back to this.

Now, dress how you want to loop video. I wore a uniform so I can sub it most of the days. I chose a public area, meaning I had to wear a mask - facial expressions are easier to feign when most of your face is covered. Make the boring details count - you want to be dressed nicely when you slack off! Now for the looping procedures:

1. Record as many clips of yourself that you want, using the "start" and "stop recording" buttons on the right.
2. Add VLC Video Source. Choose your video - it is in your video folder
3. Decide whether you want it to loop, shuffle, or any order. View the **"movie magic"** part for more help.
4. Click "Start Virtual Camera!"

## VBAudio Settings

This is a little confusing. You need the VoiceMeeter Banana and potentially another VBAudio program (my favorite [here](https://vac.muzychenko.net/en/)), but it may have a trial version that is incessantly annoying. Open the banana program and set the following settings. The hardware input is most important.

![](https://n2wu.files.wordpress.com/2021/04/banana.png?w=1024)

_Banana Settings. Banana not included._

Now navigate your Virtual Audio Program. Ensure it works.

Now go back to OBS on the audio setting. Set it to "Line 1", "VoiceMeeter VAIO" or whatever works.

## Teams Settings

For teams, use the following. Remember I usually am muted but link directly to my microphone and headphones. If I get called on, I can immediately unmute and speak like normal.

![](https://n2wu.files.wordpress.com/2021/04/teams1.png?w=673)

_Teams Settings for Audio_

Set your video to "OBS Virtual Webcam" and you are good to go!

## Movie Magic

Doing this correctly takes poise. Here are my tips for the initial looping video:

- Record away from reflective surfaces that might show the time of day, season, or any background movement
- Record somewhere austere but public. Be as unassuming as possible
- Wear a mask if possible to minimize face movements. If you wear one, you will be able to talk during meetings with the different video stream since it is hard to tell speaking from the mask.
- When recording, keep it to about 5-10 seconds. You do not want to drastically change positions since it will be very obvious.
- When pressing start and stop, look directly at the camera. Looped eye movements are easy to detect
- Wear something boring and potentially reworn. You will be using this multiple times.
- Start and stop the video with your body in the exact same position. Even further, film a single period of your breath. Start the video at the top of your breath, and end at the same position.
- Use .mkv to record since .mp4s create odd compression stuttering.

After these steps, we are ready for the magic. I created a series of loopable NPC actions like writing down something, drinking water, or nodding. I uploaded them all in the scene:

![](https://n2wu.files.wordpress.com/2021/04/sources.png?w=343)

_OBS Sources_

If you noticed, NPC is at the top. This changes. Also, I have "Image," which is a still screenshot, taken from the default video clip and set underneath the other displays. Important here is the visibility and the order for each of the sources.

Next, I made four different scenes. These have one-off clips **that do not loop** and allow for the NPC actions. Here is the "nod" scene:

![](https://n2wu.files.wordpress.com/2021/04/scene_nod.png?w=674)

_Scene for nodding_

So when I queue the "Nod" scene, the nod video plays once. Normally it would fade to black (the background), but it fades to the looping video I have underneath it - the default video. As a precaution it can fade to the image as well. I configure all of these with hotkeys in the settings:

![](https://n2wu.files.wordpress.com/2021/04/hotkey.png?w=624)

_Hotkeys! We're having a fire sale!_

Approximately after the scene plays I switch back to default, but it isn't required. While I won't share the images, it blends together well with the transitions.

## Conclusion

I think Ron Swanson put it best:

![](https://n2wu.files.wordpress.com/2021/04/ron_nothing.jpg?w=540)

With just a little bit of know-how, you can outsmart people at a game they didn't even know you were playing. I'm Alton Brown and thanks for watching Good Eats.
