---
title: "Fax Machine with the P25"
date: "2024-11-20"
categories:
  - "technical"
tags:
  - "python"
  - "serial"
  - "programming"
coverImage: "/assets/img/printer/image.jpg"
use_math: false
---

I recently acquired a neat bluetooth thermal printer. With some python and web services, I was able to translate it into an online feature! Read further for my explanation and steps.

# The Bluebamboo Printer

## Background

The [Bluebamboo](https://www.manualslib.com/manual/1357742/Blue-Bamboo-P25m.html) P25 printer is a defunct bluetooth serial-controlled batter-powered thermal printer. This is pretty handy - no wires, cables, or plugs needed. There are two documentation manuals online - a [quick start](https://www.manualslib.com/manual/1357742/Blue-Bamboo-P25m.html) and a [development manual](https://www.manualslib.com/manual/790801/Blue-Bamboo-P25.html#product-P25-M), both of which will be necessary to write your own code.

You should be able to find these on ebay, when they pop up, for about $25-30. I wouldn't try to get a model that doesn't look exactly like this one, lest you have to find a more defunct manual. You should just install the battery and charge before turning it on to see a solid green light.

## Setup

These printers are more secure than originally thought. I used Windows to connect via Bluetooth - try the following steps:

1. Turn on the printer and open the paper roll tray
2. Turn on bluetooth on your computer.
3. Go to your bluetooth settings, scroll down to "More Bluetooth Settings"
4. Click on "COM Ports", then "Add"
5. You should see the P25 here, connect to it. You will get a request to connect to the printer. Type the PIN visible on the paper tray.

You should see a flash of blue then more solid green. You are all set to go!

This should work as long as you are using that device. You may get timeout errors using Serial to be explained later.

# Serial Printing

Most of this device's genius is its simplicity. It just takes serial commands. From the development manual, the device is in a "plain text protocol" mode:

![Print Mode](/assets/img/printer/print_mode.PNG)

So if you have a running serial console, it will just print whatever commands you send it. Using pySerial I made a pretty quick version [here](https://github.com/N2WU/pythonP25/blob/main/print_text.py):

```python
  ser = serial.Serial(
      port='COM4',
      baudrate=115200,
      parity=serial.PARITY_NONE,
      stopbits=serial.STOPBITS_TWO,
      bytesize=serial.EIGHTBITS
  )
```
Then, to write:

```python
  term_bytes = bytes((term_input + '\n'), 'utf-8')
  ser.write(term_bytes)
```

I looked around in the development manual and found a few technical hex commands. I would like to print images later so I will need to understand these. As of right now, I can't get the printer past the plain-text protocol and it just prints my literal commands as text.

![Print Image](/assets/img/printer/image.jpg)

# Fax-As-A-Service (FaaS)

Now that I can send strings to the serial console and have them print, I could pretty easily make a webservice do this feature. In the past I've used [heroku](https://www.heroku.com/) for a javascript bot in a groupchat, but the deployment always broke and I needed something more user-input-friendly, especially with python. Flask seems to be all the rage, so I gave it a test.

## Flask

[Flask](https://flask.palletsprojects.com/en/stable/) is actually exactly what I was looking for. A simple synthesis between html and python allowed me to collect variables and use them in my python script. I wrote a quick [webapp](https://github.com/N2WU/pythonP25/tree/main/webapp) collecting the name and message from a user on a webpage. Testing this out on localhost allowed me to find bugs without deploying. 

It was a little janky, but the user form collects the **name** and **message** data and converts it to a message variable. I used a quick function taken from my previous example to print, and I was up and running. The below snippet shows the flask process. The function faxprint() sets up the serial each time.

```python
@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        name = request.form["name"]
        message = request.form["message"]
        faxprint(name,message)
        return f"Thank you {name}! Your message: '{message}' has been received."
    return render_template("form.html")
```

## ngrok

[ngrok](https://ngrok.com/) is also an incredibly easy deployment. I installed the program and used the service to run my localhost on an actual website link. 

```
ngrok http 5000
```

Now I had a link to send to my friends, where they just had to input the form.

![Web Screen](/assets/img/printer/webscreen.PNG)

# Conclusion

This was a great project and still has tons of room for improvement. Numerous [other projects](https://github.com/lorensiuswlt/P25Demo) have experimented with the P25 using iOS or Android and have printed barcodes or images. I struggled too much for the images, but will try to iron it out. Right now my ESC commands are printing literally, and the hex codes for the images turn into pages and pages of 1s and 0s. 

Also, I get a timeout command pretty frequently. Stackoverflow seems to think the 'Semaphore Timeout' command I receive is due to the firmware of the device itself, so maybe I need to adjust the timeout settings on the printer. As of right now I just turn on and off the printer to reset it. Maybe plugging it in indefinitely would also change it.

Lastly, this is pretty bulky on a windows machine. I have a few [Raspberry Pi Zero Ws](https://www.raspberrypi.com/products/raspberry-pi-zero-w/) laying around that offer the needed wireless internet and bluetooth functionality in an incredibly small form factor. I've already gotten a few requests from friends, so I need to streamline the production process to produce these things.

Stay tuned! -N2WU