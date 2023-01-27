#!/usr/bin/env python3
# coding: utf-8

import raspi_lcd
import raspi_i2cdetect
from datetime import datetime
from time import sleep                                  # スリープ実行モジュールの取得

print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), "Started Example for LCD ---------------")

i2det = raspi_i2cdetect.RaspiI2cDetect()                # i2detの生成
address = i2det.list([0x3E,0x3F,0x27,0x38,0x20],False)
raspiLcd = raspi_lcd.RaspiLcd(address,True,x=16,reset=16)   # raspiLcdの生成
print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), "I2C Address =", hex(address))
while address == 0:
    print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), "I2C ERROR")
    sleep(5)
    del raspiLcd
    address = i2det.list([0x3E,0x3F,0x27,0x38,0x20],False)
    raspiLcd = raspi_lcd.RaspiLcd(address,True,x=16,reset=16)   # raspiLcdの生成
sleep(1)


date=datetime.today()                                  # 日付を取得
print(date.strftime('%Y/%m/%d %H:%M:%S'), "Example for AQM1602A/Y/Grove ----------")
raspiLcd.print(date.strftime('%Y/%m/%d %H:%M') + "AQM1602A/Y/Grove")
sleep(5)

raspiLcd.print("0123456789ABCDEF",1)
raspiLcd.print("16 ｹﾀ ﾏﾃﾞ ﾋｮｳｼﾞ!",2)
sleep(5)

del raspiLcd

raspiLcd = raspi_lcd.RaspiLcd(ignoreError=True,x=8,reset=16)    # raspiLcdの生成

date=datetime.today()                                  # 日付を取得
print(date.strftime('%Y/%m/%d %H:%M:%S'), "Example for AQM0802A ------------------")
raspiLcd.print(date.strftime('%H:%M:%S') + "AQM0802A")
sleep(5)
raspiLcd.print("01234567",1)
raspiLcd.print("8ｹﾀﾋｮｳｼﾞ",2)
sleep(5)

raspiLcd.restoreUsedGpio=True                   # 使用したGPIOを終了時に開放する
