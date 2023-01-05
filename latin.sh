#!/bin/bash

/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "LCD 0x80~0x8F" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ÇüéâäàåçêëèïîìÄÅ" > /dev/null
# C3 87 C3 BC C3 A9 C3 A2 C3 A4 C3 A0 C3 A5 C3 A7 C3 AA C3 AB C3 A8 C3 AF C3 AE C3 AC C3 84 C3 85 len=33
# C3 87 C3 BC C3 A9 C3 A2 C3 A4 C3 A0 C3 A5 C3 A7 C3 AA C3 AB C3 A8 C3 AF C3 AE C3 AC C3 84 C3 85 len=33

/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "LCD 0x90~0x9F" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ÉæÆôöòûùÿÖÜñÑ//¿" > /dev/null
# C3 89 C3 A6 C3 86 C3 B4 C3 B6 C3 B2 C3 BB C3 B9 C3 BF C3 96 C3 9C C3 B1 C3 91 2F 2F C2 BF len=31
# 0     1     2     3     4     5     6     7     8     9     A     B     C     D  E  F~~~~
sleep 5

/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "LCD 0xE0~0xEF" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "áíóú¢£\\/§ıÃãÕõØø" > /dev/null
# C3 A1 C3 AD C3 B3 C3 BA C2 A2 C2 A3 5C 2F C2 A7 C4 B1 C3 83 C3 A3 C3 95 C3 B5 C3 98 C3 B8 len=31
# 0     1     2     3     4~~~~ 5~~~~ 6  7  8~~~~ 9~~~~ A     B     C     D     E     F
sleep 5

/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "French Lower" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "àâæçéèêëïîôœúûüÿ" > /dev/null
sleep 5

/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "French Upper" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ÀÂÆÇÉÈÊËÏÎÔŒÚÛÜŸ" > /dev/null
sleep 5

/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞß" > /dev/null
sleep 5

/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "àáâãäåæçèéêëìíîï" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ðñòóôõö÷øùúûüýþÿ" > /dev/null
