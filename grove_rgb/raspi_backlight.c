/*******************************************************************************
Raspberry Pi用 I2C RGB バックライト制御 grove_rgb/raspi_backlight.c

本ソースリストおよびソフトウェアは、ライセンスフリーです。(詳細は別記)
利用、編集、再配布等が自由に行えますが、著作権表示の改変は禁止します。

                                        Copyright (c) 2023 Wataru KUNINO
                                        https://bokunimo.net/raspi/
********************************************************************************
参考文献
https://wiki.seeedstudio.com/Grove-LCD_RGB_Backlight/
grove_rgb_lcd.py code
*******************************************************************************/

// #include <Wire.h> 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../raspi_i2c.h"
typedef unsigned char byte; 
byte i2c_address=0x62;              // Grove-LCD RGB Backlight の I2C アドレス 

// #define DEBUG

void _setReg(byte reg, byte in){
    uint8_t tx[2]={reg,in};
    i2c_write(i2c_address,tx,2);     // 書込みの実行
    #ifdef DEBUG
        printf("Wrote Register %02X to %02X\n",reg,in);
    #endif
}

byte _getReg1(byte data){
    byte rx[2];
    i2c_write(i2c_address,&data,1); // 書込みの実行
    delay(10);                      // 6.5ms以上
    i2c_read(i2c_address,rx,1);     // 読み出し
    return rx[0];
}

uint16_t _getReg2(byte data){
    byte rx[2];
    i2c_write(i2c_address,&data,1); // 書込みの実行
    delay(10);                      // 6.5ms以上
    i2c_read(i2c_address,rx,2);     // 読み出し
    return (((uint16_t)rx[0])<<8)|((uint16_t)rx[1]);
}

int main(int argc,char **argv){
    byte r=0x20, g=0x40, b=0x10;

    if(i2c_address>=0x80) i2c_address>>=1;
    if( argc <= 1 || argc > 4 ){
        fprintf(stderr,"usage: %s [red] [green] [blue]\n",argv[0]);
        if(argc < 1 || argc > 4) return -1;
    }
    if(argc > 1) r=(byte)atoi(argv[1]);
    if(argc > 2) g=(byte)atoi(argv[2]);
    if(argc > 3) b=(byte)atoi(argv[3]);

    i2c_init();
    delay(18);
    _setReg(0,0);
    _setReg(1,0);
    _setReg(0x08,0xAA);
    _setReg(4,r);
    _setReg(3,g);
    _setReg(2,b);
    delay(10);
    
    i2c_close();
    printf("red=%d(0x%02X), green=%d(0x%02X), blue=%d(0x%02X)\n",r,r,g,g,b,b);
    return 0;
}

/*******************************************************************************
参考文献
https://wiki.seeedstudio.com/Grove-LCD_RGB_Backlight/
grove_rgb_lcd.py code
********************************************************************************

import time,sys
 
if sys.platform == 'uwp':
    import winrt_smbus as smbus
    bus = smbus.SMBus(1)
else:
    import smbus
    import RPi.GPIO as GPIO
    rev = GPIO.RPI_REVISION
    if rev == 2 or rev == 3:
        bus = smbus.SMBus(1)
    else:
        bus = smbus.SMBus(0)
 
# this device has two I2C addresses
DISPLAY_RGB_ADDR = 0x62
DISPLAY_TEXT_ADDR = 0x3e
 
# set backlight to (R,G,B) (values from 0..255 for each)
def setRGB(r,g,b):
    bus.write_byte_data(DISPLAY_RGB_ADDR,0,0)
    bus.write_byte_data(DISPLAY_RGB_ADDR,1,0)
    bus.write_byte_data(DISPLAY_RGB_ADDR,0x08,0xaa)
    bus.write_byte_data(DISPLAY_RGB_ADDR,4,r)
    bus.write_byte_data(DISPLAY_RGB_ADDR,3,g)
    bus.write_byte_data(DISPLAY_RGB_ADDR,2,b)
 
# send command to display (no need for external use)    
def textCommand(cmd):
    bus.write_byte_data(DISPLAY_TEXT_ADDR,0x80,cmd)
 
# set display text \n for second line(or auto wrap)     
def setText(text):
    textCommand(0x01) # clear display
    time.sleep(.05)
    textCommand(0x08 | 0x04) # display on, no cursor
    textCommand(0x28) # 2 lines
    time.sleep(.05)
    count = 0
    row = 0
    for c in text:
        if c == '\n' or count == 16:
            count = 0
            row += 1
            if row == 2:
                break
            textCommand(0xc0)
            if c == '\n':
                continue
        count += 1
        bus.write_byte_data(DISPLAY_TEXT_ADDR,0x40,ord(c))
 
#Update the display without erasing the display
def setText_norefresh(text):
    textCommand(0x02) # return home
    time.sleep(.05)
    textCommand(0x08 | 0x04) # display on, no cursor
    textCommand(0x28) # 2 lines
    time.sleep(.05)
    count = 0
    row = 0
    while len(text) < 32: #clears the rest of the screen
        text += ' '
    for c in text:
        if c == '\n' or count == 16:
            count = 0
            row += 1
            if row == 2:
                break
            textCommand(0xc0)
            if c == '\n':
                continue
        count += 1
        bus.write_byte_data(DISPLAY_TEXT_ADDR,0x40,ord(c))
 
# example code
if __name__=="__main__":
    setText("Hello world\nThis is an LCD test")
    setRGB(0,128,64)
    time.sleep(2)
    for c in range(0,255):
        setText_norefresh("Going to sleep in {}...".format(str(c)))
        setRGB(c,255-c,0)
        time.sleep(0.1)
    setRGB(0,255,0)
    setText("Bye bye, this should wrap onto next line")

*/