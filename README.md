# raspi_lcd  

I2C LCD Device  Driver for Raspberry Pi, AQM0802A, AQM1602A, AQM1602Y, GROVE-LCD  

## Description  

I2C interface signals SCL and SDA can be directly connected to Raspberry Pi.  
It does not require an I2C repeater and pull-up resistors.  

## Schematic  

![Schematic](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/schematic.png)

## Handmade Examples  

![AQM1602](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/aqm1602.jpg)

![Radio](https://github.com/bokunimowakaru/raspi_lcd/blob/master/images/radio.jpg)

## Usage  

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
	$ ./raspi_lcd "Raspberry Pi LCD by bokunimo.net" ⏎

## Blog Pages  

* [https://bokunimo.net/blog/raspberry-pi/3179/](https://bokunimo-net.translate.goog/blog/raspberry-pi/3179/?_x_tr_sl=ja&_x_tr_tl=en)

* [https://bokunimo.net/blog/raspberry-pi/83/](https://bokunimo-net.translate.goog/blog/raspberry-pi/83/?_x_tr_sl=ja&_x_tr_tl=en)

## GitPages (This Document)  

* [https://git.bokunimo.com/raspi_lcd/](https://git.bokunimo.com/raspi_lcd/)

by <https://bokunimo.net>