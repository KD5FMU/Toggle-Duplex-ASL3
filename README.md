# Toggle-Duplex-ASL3
This script file will toggle your Half Duplex AllStarLink Node from 1 to 0

First we need to download the script file to /etc/asterisk/local so lets change the directory
```
cd /etc/asterisk/local
```

Then we can download the script file
```
https://raw.githubusercontent.com/KD5FMU/Toggle-Duplex-ASL3/refs/heads/main/duplex_toggle.sh
```
Then we need to make the script file executable.
```
sudo chmod +x duplex_toggle.sh
```
Then you can run the file to toggle the duplex setting from half-duplex with courtesy tones to half-duplex without courtesy tones. So whatever state your rpt.conf file is in this script file will make it the opposite.
```
sudo ./duplex_toggle.sh
```
You can even set it up in the crontab if you want to.

So Have fun with it!!

73 and "Ham On Y'all!!"

