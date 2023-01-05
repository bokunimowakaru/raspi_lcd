# raspi_lcd  

I2C LCD Device  Driver for Raspberry Pi, AQM0802A, AQM1602A, AQM1602Y, GROVE-LCD  

## Description  

I2C interface signals SCL and SDA can be directly connected to Raspberry Pi.  
It does not require an I2C repeater and pull-up resistors.  

## Schematic  

![Schematic](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/schematic.png?raw=true)

## Handmade Examples  

![AQM1602](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/aqm1602.jpg?raw=true)

![Radio](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/radio.jpg?raw=true)

## Install raspi_lcd to your Raspberry Pi  

	$ cd ⏎
	$ sudo apt install raspi-gpio ⏎ (for legacy OS)
	$ sudo apt install git ⏎ (for LITE Version OS)
	$ git clone https://bokunimo.net/git/raspi_lcd ⏎
	$ cd ~/raspi_lcd ⏎
	$ make clean ⏎
	$ make ⏎

## Testing  

	$ cd ~/raspi_lcd ⏎
	$ ./raspi_lcd -i -w16 "Raspberry Pi LCD by bokunimo.net" ⏎

## Usage  

"-h" option shows usage:  

	$ ./raspi_lcd -h
	Usage:
	  ./raspi_lcd [-i] [-f] [-r port] [-w lcd_width] [-y row] [text...]
	  echo text... | ./raspi_lcd [-i] [-f] [-r port] [-w lcd_width] [-y row]
	  ./raspi_lcd -h
	    options:
	      -i      ignore I2C communication errors
	      -f      use standard input
	      -rPORT  set GPIO port number of reset LCD pin; number for PORT
	      -wWIDTH set display digits; 8 or 16 for WITDH
	      -yROW   set display row; 1 or 2 for ROW
	      text... display text string
	      -h      display this help

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

## Blog Pages  

* [https://bokunimo.net/blog/raspberry-pi/3179/](https://bokunimo-net.translate.goog/blog/raspberry-pi/3179/?_x_tr_sl=ja&_x_tr_tl=en)

* [https://bokunimo.net/blog/raspberry-pi/83/](https://bokunimo-net.translate.goog/blog/raspberry-pi/83/?_x_tr_sl=ja&_x_tr_tl=en)

## GitPages (This Document)  

* [https://git.bokunimo.com/raspi_lcd/](https://git.bokunimo.com/raspi_lcd/)

by <https://bokunimo.net>