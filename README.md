# raspi_lcd

I2C LCD Device Driver for Raspberry Pi. It supports LCD controller IC ST7032i in AQM0802A, AQM1602A, AQM1602Y, and GROVE-LCD, and HD44780 and it's compatible IC with PCF8574T or PCF8574A in General 1602 LCDs.  

Supported Raspberry Pi: 1, 2, 3, 4, Zero, Zero W, Zero W2.  

And only one code "example_Pi5.sh" is for Rapberry Pi 5.  

## Features

I2C interface signals SCL and SDA can be directly connected to Raspberry Pi.  
(It does not require an I2C repeater and pull-up resistors.)  
Supports to display some Latin characters for French, and all of Japanese Katakana.  
Python code examples are available. <span style="color: red; ">NEW!</span>  

## Language

Select language to transrate this page:

* [Japanese(japonaise)](https://translate.google.com/website?sl=en&tl=ja&hl&u=https://git.bokunimo.com/raspi_lcd/)
* [English(Anglais)](https://git.bokunimo.com/raspi_lcd/)
* [French(Français)](https://translate.google.com/website?sl=en&tl=fr&hl&u=https://git.bokunimo.com/raspi_lcd/)

## Schematics

![Schematic1](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/schematic.png?raw=true)

On the above Schematics, the power supply for the LCD is from GPIO16, to control the power and hardware reset function from Raspberry Pi. 

![Schematic2](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/schematic2.png?raw=true)

This is for CPU Load Monitor [example_cpu.sh](https://github.com/bokunimowakaru/raspi_lcd/blob/master/example_cpu.sh) on GitHub.  

![Schematic3](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/schematic3.png?raw=true)

## Handmade Examples

The picture below shows Xiamen Zettler Electronics AQM1602 LCD connected to the Raspberry Pi Zero. Other Raspberry Pis (1/2/3/4 etc.) can be connected in the same way.  

![AQM1602](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/aqm1602.jpg?raw=true)

Also supports General 1602 LCDs (HD44780 + PCF8574T / PCF8574A):  

![General1602](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/general1602.jpg?raw=true)

It works on the 1st generation Raspbeery Pi:  

![RaspPi1](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/raspi1.jpg?raw=true)

It can display French Latin letters, if your LCD hardware supports (Grove LCD cannot).  

![Latin](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/latin.jpg?raw=true)

The following pictures show an example of CPU Load Monitor which displays a time, load and temperature of CPU, temperature, and percentage of used SD card and used memory. Enter the command "./example_cpu.sh" to execute this source code [example_cpu.sh](https://github.com/bokunimowakaru/raspi_lcd/blob/master/example_cpu.sh).  

![CPU_Load](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/example_cpu_cased.jpg?raw=true)

![CPU_Load](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/example_cpu.jpg?raw=true)

I made it to display the radio channel name of the Internet radio, the artist and the song names of the jukebox. You can use it in another repository [bokunimowakaru/audio/radio/pi](https://github.com/bokunimowakaru/audio/tree/master/radio/pi).  

![Radio](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/radio.jpg?raw=true)

![Music](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/music.jpg?raw=true)

## Install "raspi_lcd" to your Raspberry Pi

	$ cd ⏎
	$ sudo apt install raspi-gpio ⏎ (for legacy OS)
	$ sudo apt install git ⏎ (for LITE Version OS)
	$ git clone https://bokunimo.net/git/raspi_lcd ⏎
	$ cd ~/raspi_lcd ⏎
	$ make clean ⏎
	$ make ⏎

## Testing

The first, run example.py for testing the driver works:  

	$ cd ~/raspi_lcd ⏎
	$ ./example.py ⏎

After that, use "raspi_lcd" command which can be set full optional functions:  

	$ cd ~/raspi_lcd ⏎
	$ ./raspi_lcd -a3E -i -w16 "Raspberry Pi LCD by bokunimo.net" ⏎
	(The arg "-a3e" sets I2C address to 3E, arg "-w16" sets the display digit width.)

## Usage

"-h" option shows usage:  

	$ ./raspi_lcd -h
	Usage: ./raspi_lcd (Version 1.04)
	  ./raspi_lcd [-i] [-a address] [-f] [-r port] [-w lcd_width] [-y row] text...
	  ./raspi_lcd [-i] [-a address] [-f] [-r port] [-w lcd_width] [-y row] [-b|-d] value...
	  echo text... | ./raspi_lcd [-i] [-f] [-r port] [-w lcd_width] [-y row]
	  ./raspi_lcd -h # shows this help
	  ./raspi_lcd -q # releases I2C ports

	    options:
	      -i      ignore I2C communication errors
	      -aADR   set i2c address in hex (defalut=3E)
	      -s      slowdown I2C communication mode
	      -rPORT  set GPIO port number of reset LCD pin; number for PORT
	      -wWIDTH set display digits; 8 or 16 for WITDH
	      -yROW   set display row; 1 or 2 for ROW
	      -b      display bar graph
	      -d      display dot graph
	      text... display text string on the LCD
	      -n      skip initializing LCD
	      -f      use standard input, continuously
	      -qPORT  restore GPIO port and I2C ports
	      -h      display this help on the terminal
	      -v      show version (for 1.01 and greater)

## Example Code (Python Script)

See [example.py](https://github.com/bokunimowakaru/raspi_lcd/blob/master/example.py) on GitHub.  

	pi@raspberrypi:~/raspi_lcd $ ./example.py
	2023/01/13 23:22:34 LCD initialized
	2023/01/13 23:22:34 Example for AQM1602A/Y/Grove ----------
	2023/01/13 23:22:35 LCD 2023/01/13 23:22 / AQM1602A/Y/Grove
	2023/01/13 23:22:41 LCD 0123456789ABCDEF
	2023/01/13 23:22:41 LCD 16 ｹﾀ ﾏﾃﾞ ﾋｮｳｼﾞ!
	2023/01/13 23:22:46 LCD Done
	2023/01/13 23:22:46 LCD initialized
	2023/01/13 23:22:46 Example for AQM0802A ------------------
	2023/01/13 23:22:47 LCD 23:22:46 / AQM0802A
	2023/01/13 23:22:53 LCD 01234567
	2023/01/13 23:22:53 LCD 8ｹﾀﾋｮｳｼﾞ
	2023/01/13 23:22:58 LCD restore GPIO16 to free
	2023/01/13 23:23:03 LCD Done

## Example Code (Bash Script)

See [example.sh](https://github.com/bokunimowakaru/raspi_lcd/blob/master/example.sh) on GitHub.  

	pi@raspberrypi:~/raspi_lcd $ ./example.sh
	2023/01/05 12:27:40 STARTED -------------------------------
	2023/01/05 12:27:40 LCD reset GPIO16
	2023/01/05 12:27:43 LCD I2C LCD Driver / by ﾎﾞｸﾆﾓﾜｶﾙRasPi
	2023/01/05 12:27:48 Example for AQM1602A/Y/Grove ----------
	2023/01/05 12:27:51 LCD 2023/01/05 12:27:48 / AQM1602A/Y/Grove
	2023/01/05 12:27:59 LCD 0123456789ABCDEF / 16 ｹﾀ ﾏﾃﾞ ﾋｮｳｼﾞ
	2023/01/05 12:28:04 Example for AQM0802A ------------------
	2023/01/05 12:28:07 LCD 2023/01/05 12:28:04 / AQM1602A/Y/Grove
	2023/01/05 12:28:15 LCD 01234567 / 8ｹﾀﾋｮｳｼﾞ

## Example Code for Grove-LCD RGB Backlight

Grove-LCD RGB Backlight needs Backlight Controller "raspi_backlight" in "/raspi_lcd/grove_rgb/".  
Please additionally install "raspi_backlight":  

	$ cd ~/raspi_lcd/grove_rgb ⏎
	$ make clean ⏎
	$ make ⏎

The example code for Grove-LCD is in here: [raspi_lcd/grove_rgb/example.sh](https://github.com/bokunimowakaru/raspi_lcd/blob/master/grove_rgb/example.sh):  

	pi@raspberrypi:~/raspi_lcd/grove_rgb $ ./example.sh ⏎
	2023/01/05 13:58:03 STARTED -------------------------------
	2023/01/05 13:58:03 RGB Backlight reset
	2023/01/05 13:58:03 usage: /home/pi/raspi_lcd/grove_rgb/raspi_backlight [red] [green] [blue]
	red=32(0x20), green=64(0x40), blue=16(0x10)
	2023/01/05 13:58:07 LCD I2C LCD Driver / by ﾎﾞｸﾆﾓﾜｶﾙRasPi
	2023/01/05 13:58:12 Example for Grove-LCD RGB Backlight ---
	2023/01/05 13:58:12 RGB Backlight reset
	2023/01/05 13:58:12 red=16(0x10), green=32(0x20), blue=16(0x10)
	2023/01/05 13:58:15 LCD 2023/01/05 13:58:12 / Grove-LCD BLight
	2023/01/05 13:58:20 RGB Backlight reset
	2023/01/05 13:58:20 red=48(0x30), green=32(0x20), blue=16(0x10)
	2023/01/05 13:58:23 LCD 0123456789ABCDEF / 16 ｹﾀ ﾏﾃﾞ ﾋｮｳｼﾞ
	2023/01/05 13:58:28 RGB Backlight reset
	2023/01/05 13:58:28 red=32(0x20), green=32(0x20), blue=16(0x10)
	2023/01/05 13:58:32 LCD 2023/01/05 13:58:29 / RGB=(32,32,32)
	2023/01/05 13:58:37 RGB Backlight reset
	2023/01/05 13:58:37 red=16(0x10), green=48(0x30), blue=16(0x10)
	2023/01/05 13:58:40 LCD 2023/01/05 13:58:37 / RGB=(16,48,32)

![Grove-LCD RGB Backlight](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/grove.jpg?raw=true)

Tips:  
Grove-LCD has I2C signal repeater, so the above script is enabled ACK checking function; no "-i" required for raspi_lcd options.  

## Blog Pages

I2C LCD AQM1602 0802 directly connect to Raspberry Pi
* [https://bokunimo.net/blog/raspberry-pi/3253/](https://translate.google.com/website?sl=ja&tl=en&hl&u=https://bokunimo.net/blog/raspberry-pi/3253/)

Internet Radio and Jukebox on Raspberry Pi + DAC
* [https://bokunimo.net/blog/raspberry-pi/3179/](https://translate.google.com/website?sl=ja&tl=en&hl&u=https://bokunimo.net/blog/raspberry-pi/3179/)

Example scripts for Apple Pi (produced by [BitTradeOne](https://bit-trade-one.co.jp/adcq1905/))
* [https://bokunimo.net/blog/raspberry-pi/83/](https://translate.google.com/website?sl=ja&tl=en&hl&u=https://bokunimo.net/blog/raspberry-pi/83/)

## Misc

I also developed a driver which can display French fonts, for M5Atom and ESP32 based boards. You can download from below link:  

for M5Atom and ESP32 Boards
* [https://github.com/bokunimowakaru/m5/tree/master/atom/ex04_lcd](https://github.com/bokunimowakaru/m5/tree/master/atom/ex04_lcd)

Following pictures are taken, when I tested it to copy text from French Wikipedia and paste to LCD controller on the web browser.  

![M5Atom with I2C LCD](https://github.com/bokunimowakaru/m5/blob/master/pictures/ex04_lcd_site_atom_thumb.jpg?raw=true)

## GitHub Pages (This Document)

* [https://git.bokunimo.com/raspi_lcd/](https://git.bokunimo.com/raspi_lcd/)

by <https://bokunimo.net>
