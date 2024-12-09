---
title: "Improving the Fax Machine"
date: "2024-12-08"
categories:
  - "technical"
tags:
  - "python"
  - "serial"
  - "programming"
coverImage: "/assets/img/printer/image.jpg"
use_math: false
---

In my previous [P25](/_posts/2024-11-20-fax-machine-with-the-p25.md) post, I made a simple web-based python script for controlling a serial bluetooth printer. I've made some more improvements to it to optimize security and message passing. Take a look!

# Security Improvements

First, the original code relied on hardwired MAC addresses to control the printer. I used a YAML file, included in the .gitignore, to specify the address. The connection function refers to this address through the following code:

```python
def connect():
    with open('config.yml', 'r') as f:
       yaml_data = yaml.load(f, Loader=yaml.SafeLoader)
    serverMACAddress = yaml_data['mac']
    port = 1
    s = socket.socket(socket.AF_BLUETOOTH, socket.SOCK_STREAM, socket.BTPROTO_RFCOMM)
    s.connect((serverMACAddress,port))
    return s
```

So long as I called s = connect(), I could try a successful connection to the printer.

# Serial Connection Attempt and Startup execution

Sometimes the printer was turned off. Before I tried to send serial commands to change the timeout time of the device, I realized I could just use the python try() feature to see if the device is on. This will let users "catch up" on their faxes by turning on the device at certain points in the day.

Similarly, I wanted this to run on a raspberry pi and run automatically on startup. I used ***crontab*** and the ***@reboot*** timing feature with the following jobs:

```
@reboot /usr/bin/python app.py &
@reboot /usr/bin/local/ngrok http http://localhost:5000 &
@reboot /usr/bin/python print.py &
```

Here, the first line runs the web code, the second line publishes it to the internet, and the third line runs the print functions.

It's important to note that I had to install ngrok authentications in root mode using ***sudo su***. I also had to explicitly list the path for python and ngrok. Additionally, I had to pair the printer with the pi using bluetoothctl, specifcally ***bluetoothctl show*** and ***bluetoothctl pair***.

# Buffers

Lastly, I wanted to skirt the issue of the printer timeout using a buffer. When a message is received, the script checks if the printer is connected. If not, it gets written to a csv. Every five minutes, the print.py code checks to see if the printer is online, then prints the messages from oldest to newest. The .csv writing took just a second to figure out:

```python
def store(name,message):
    message_data = [[name, message]]
    dir_path = os.path.dirname(os.path.realpath(__file__))
    csv_filename = dir_path + '/temp_data.csv'
    print(csv_filename)
    with open(csv_filename, 'a', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(message_data)
```

The _open(csv_filename, ***'a'***, newline='')_ allows appending messages as opposed to overwriting them.

```python
def print_records(s):
    dir_path = os.path.dirname(os.path.realpath(__file__))
    csv_filename = dir_path + '/temp_data.csv'
    if os.path.exists(csv_filename):
        with open(csv_filename)as file:
            message_csv = csv.reader(file)
            for row in message_csv:
                    name = row[0]
                    message = row[1]
                    faxprint(s,name,message)
        os.remove(csv_filename)
    else:
        print('No data to print')
```

Since I have always had issues with reading from non-existent csv files, I put another attempt to see if the file exists.

# Conclusion

Hope this helps! I will be working on the C implementation in the future. As well as revamping the SSTV project I've been working on, and some acoustic projects...

-N2WU