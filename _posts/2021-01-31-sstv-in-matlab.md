---
title: "SSTV in MATLAB"
date: "2021-01-31"
categories:
  - "technical"
tags:
  - "amateur-radio"
  - "code-golf"
  - "diy"
  - "dsp"
  - "ham-radio"
  - "image-processing"
  - "iss"
  - "mathematical-modeling"
  - "matlab"
  - "sstv"
coverImage: "splash_2.jpg"
---

# SSTV in MATLAB

This weekend I had some extra time to work on signal generation. I decided to use MATLAB to encode Slow Scan Television, a fax machine-like way of encoding images for radio processes. I was not wholly successful, but produced meaningful results! Take a look.

![](https://n2wu.files.wordpress.com/2021/01/splash-2.png?w=320)

My code, as always, is uploaded on Github [here](https://github.com/KE8JCT/matlab_sstv). There are a couple of important documents and tests in there as well.

### Theory

SSTV uses essentially frequency modulation to create messages. Each frequency, from about 1000-2500 Hz, has a unique identity corresponding in the SSTV language. For images, color images use an RGB matrix with their **luminance** 0-255 that is translated to a frequency 1500-2300 Hz in 3 separate scans of Red, Green, and Blue. This will follow later.

I used a paper from Hamvention 2000 as a "recipe" for creating signals. First, I had to select a sampling frequency. Since all SSTV signals are in the range of about 1000-2500Hz, I used the Nyquist Theorem to select a sampling frequency of 8 kHz; it is comfortably over the 5 kHz minimum. I then used the typical EM wave equation to create my sinusoids of varying length and frequency:

```
fs = 8000; %Sampling rate = 8000 Hz
dur = duration in seconds
t = 0:1/fs:dur; %create a timestep 1 second in length using the sampling rate
f = message frequency %range of 1000-2500 Hz for sstv
Signal = cos(2*pi*f*t) %generates a vector for the sinusoid
```

Since the frequency changes constantly for the entire signal, I appended the individual tones of sstv (explained further) to my endproduct "Message Signal." There are several ways to do this, but I found created an array, then converting the array to a row vector turned out to be the most efficient:

```
for k=1:7 %do this 7 times
    Repeated_signal(k,:) = cos(2*pi*f*k*t); %create a sinusoid with f*k frequency
end %store it in the kth row (and however many columns) of Repeated_signal array

Repeated_signal = reshape(Repeated_Signal.',1,[]); %concentate each signal to the end
```

I used this function about 4 times. I encountered difficulties in trying to reuse the array as a matrix, since I reshaped it into a vector. Before I used these arrays, I would **clear** to ensure I was working with an array and not a vector.

#### Header / VIS Code

SSTV transmissions begin with a calibration header and a VIS code. Below is the setup for the code:

![](https://n2wu.files.wordpress.com/2021/01/capture.png?w=884)

_Calibration Header_

This performed pretty linearly. The only difficulty occurred on the VIS Code: using the **de2bi()** function creates a vector in **LSB**. I used the following code to convert my binary string to a string of frequencies:

```
VIS_decimal = 55; %55 for SC2-180
VIS_binary = de2bi(VIS_decimal,7);

%Start the iterative process
VIS_code = zeros(7,length(t));

for k=1:7
    VIS_code(k,:) = cos(2*pi*(1300-(VIS_binary(k)*200)*t)); %use 1100 for 1, 1300 for 0
end

VIS_code = reshape(VIS_code.',1,[]);
```

Finally, the calibration concluded with mass addition:

```

%Combine the signal

Calibration_Header = [Leader_tone, break_tone, Leader_tone, VIS_start, VIS_code, parity_bit, VIS_stop];

%end of sequence
```

### SC2-180

I chose SC2-180 for its simplicity. It uses the following modulation scheme:

![](https://n2wu.files.wordpress.com/2021/01/wrasse.png?w=904)

The sync and porch pulses, like the headers, were very linear to implement. To create luminance frequencies for the image, I scaled each value (0-255 in 3 arrays) to match the frequency range of 1500-2300 Hz. The array is stored as a uint8, meaning it won't go high enough for the frequency range of interest.

```
Image_array = imread('image.png');
%First, restructure image to display correct luminance range
%Range = 2300-1500 Hz = 800 Hz
Img_luminance = double(Image_array) ./ 255 * 800 + 1500;
```

Next, I sequentially made scans of each line in Red, Green, and Blue iterations. I used the same **reshape()** function from before:

for n=1:256 %256 lines
    RGB\_line = zeros(3,len\*320);
    for k=1:3 %3 colors
        R\_array = zeros(320,len); %convert the vector back into an array
        for m=1:320  %320 rows

         R\_array(m,:) = cos(2\*pi\*Img\_luminance(n,m,k)\*t\_rgb); %1 color for the whole line

        end
     R\_array = reshape(R\_array.', 1, \[\]);
     RGB\_line(k,1:len\*320) = R\_array; %red, green, blue for the whole line
    end
    RGB\_line = reshape(RGB\_line.',1,\[\]);
    RGB\_array(n,1:len\*320\*3) = RGB\_line;
end

Finally, I took the array with scan data and combined it sequentially with the sync and porch information:

```
%Build scan line

Scan_line_ex = [Sync_pulse, Porch, RGB_array(1,:)]; %get the length of a typical scan line
Image_scan = zeros(256,length(Scan_line_ex));

for n=1:256
    Scan_line = [Sync_pulse, Porch, RGB_array(n,:)];
    Image_scan(n,:) = Scan_line;
end
Image_scan = reshape(Image_scan.',1,[]);
```

All I had to do now was combine it with the calibration header, and play it using **sound()**.

```
WRASSE = [Calibration_Header, Image_scan];

sound(WRASSE,fs)
```

### Scottie-1

Scottie has a different signal "recipe" shown here:

![](https://n2wu.files.wordpress.com/2021/01/image-2.png?w=857)

This took a slightly different approach. Pulses occur in the middle of color scans, so I had to introduce them while I was scanning lines. Additionally, the color scans occur Green,Blue,Red, which is out of order from RGB. I used this process to accomplish it:

```
for n=1:256
    RGB_line = zeros(3,len*320);
    for k=1:3 %in red, green, blue order.
       R_array = zeros(320,len);
       for m=1:320  

        R_array(m,:) = cos(2*pi*Img_luminance(n,m,k)*t_rgb); %1 color for the whole line

       end
       R_array = reshape(R_array.', 1, []);
       RGB_line(k,:) = R_array; %red, green, blue for the whole line
    end
%Build this packet
    Scottie_line = [Separator, RGB_line(2,:), Separator, RGB_line(3,:), Sync_pulse, Porch,     RGB_line(1,:)];
	Scottie_image(n,:) = Scottie_line;
end
```

I made a (3,:) matrix that has my entire line, then I inserted pieces of that matrix into the entire Scottie\_line. Combining the signal with the calibration header resulted in about the same final result. But how does it work in testing?

#### Results

Considering it was Mozart's 265th birthday on the 27th, I used the following 320x256 image for my tests. If I had done this last year, I would have used Beethoven!

![](https://n2wu.files.wordpress.com/2021/01/mozart.png?w=320)

_Image Used for SSTV Tests_

I loaded the image in using **imread()**. I then used [MMSSTV](https://hamsoft.ca/pages/mmsstv.php) and a [virtual cable program](https://vb-audio.com/Cable/) to simulate my soundcard as a radio receiver to decode the SSTV Signal.

#### SC2-180 Signal

I started with SC2-180 first. I received the following result when I forced the mode to "SC2-180" on the program using fs = 8000:

![](https://n2wu.files.wordpress.com/2021/01/sc2_incorrect.jpg?w=320)

_First SSTV Test_

Unfortunately, it looked like my encoding scheme is incorrect. My signal was the correct length, but I have to take a further look at how SC2 is encoded. I noticed large differences in my signal based on the sampling frequency value, so I will have to take a look there.

However, I tried it again with the "Auto" feature selected. It interpreted the sc2-180 signal as **"ML 180"** and produced the following result. I am not sure what modulation scheme ML 180 follows, and cannot even find it online.

![](https://n2wu.files.wordpress.com/2021/01/mozart_rx.png?w=640)

_Reception using ML 180_

It has a slant and incredible color discrepancy. However, it hit the target. The signal's audio recording can be found [here](https://github.com/KE8JCT/matlab_sstv/blob/main/sc2_180_wav.wav). On my research, I found that the ML modes have increased resolution - this image is much higher than any other received ones.

#### Scottie-1 Signal

I tried the same method and still received poor, but readable, results. First, forcing selection of "Scottie-1" on MMSTV created the following output:

![](https://n2wu.files.wordpress.com/2021/01/scottie_1_decode.jpg?w=320)

_Incorrect Scottie-1 Decode_

And letting MMSTV pick "Auto" resulted in selection of the **ML-240** mode. Still, I have little information on these signals except that they have better resolution capability.

![](https://n2wu.files.wordpress.com/2021/01/scottie_1_ml240_decode.jpg?w=320)

_ML-240 Mode_

Once again, just barely readable. The image came out distorted - Mozart looks like he is watching himself on the right side. Additionally, the calibration header sounds widely different from standard headers shown on the [recording](https://github.com/KE8JCT/matlab_sstv/blob/main/scottie_1_wav.wav). My only guess is that I am not modulation/demodulating this signal via SSB.

### Conclusion

This was an enjoyable weekend exercise to understand modulation practices at work. I plan on using part of this code/theory with a [Hamshield Mini](https://inductivetwig.com/products/hamshield-mini) to create a SSTV beacon for our annual weather balloon.

If you have any advice on scottie/sc2 modes or my calibration header, please let me know. I'd like to get this fully operational!
