#!/bin/bash

/home/pi/raspi_lcd/raspi_lcd -w16 -y1 "0x80-0x8F"
/home/pi/raspi_lcd/raspi_lcd -w16 -y2 "ÇüéâäàåçêëèïîìÄÅ"
# C3 87 C3 BC C3 A9 C3 A2 C3 A4 C3 A0 C3 A5 C3 A7 C3 AA C3 AB C3 A8 C3 AF C3 AE C3 AC C3 84 C3 85 len=33

/home/pi/raspi_lcd/raspi_lcd -w16 -y1 "0x90-0x9F"
/home/pi/raspi_lcd/raspi_lcd -w16 -y2 "ÉæÆôòûùÿÖÜñÑ...."
# C3 89 C3 A6 C3 86 C3 B4 C3 B2 C3 BB C3 B9 C3 BF C3 96 C3 9C C3 B1 C3 91 2E 2E 2E 2E len=29
sleep 5

/home/pi/raspi_lcd/raspi_lcd -w16 -y1 "0xE0-0xEF"
/home/pi/raspi_lcd/raspi_lcd -w16 -y2 "áíóú......ÃãÕõØø"
# C3 A1 C3 AD C3 B3 C3 BA 2E 2E 2E 2E 2E 2E C3 83 C3 A3 C3 95 C3 B5 C3 98 C3 B8 len=27
sleep 5

# 0x87, 0xBC, 0xA9, 0xA2, 0xA4, 0xA0, 0xA5, 0xA7, 0xAA, 0xAB, 0xA8, 0xAF, 0xAE, 0xAC, 0x84, 0x85
# 0x89, 0xA6, 0x86, 0xB4, 0xB2, 0xBB, 0xB9, 0xBF, 0x96, 0x9C, 0xB1, 0x91, 0x2E, 0x2E, 0x2E, 0x2E
# 0xA1, 0xAD, 0xB3, 0xBA, 0x2E, 0x2E, 0x2E, 0x2E, 0x2E, 0x2E, 0x83, 0xA3, 0x95, 0xB5, 0x98, 0xB8


/home/pi/raspi_lcd/raspi_lcd -w16 -y1 "French Lower"
/home/pi/raspi_lcd/raspi_lcd -w16 -y2 "àâæçéèêëïîôœúûüÿ"
/home/pi/raspi_lcd/raspi_lcd -w16 -y1 "French Upper"
/home/pi/raspi_lcd/raspi_lcd -w16 -y2 "ÀÂÆÇÉÈÊËÏÎÔŒÚÛÜŸ"
sleep 5

/home/pi/raspi_lcd/raspi_lcd -w16 -y1 "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏ"
/home/pi/raspi_lcd/raspi_lcd -w16 -y2 "ÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞß"
sleep 5

/home/pi/raspi_lcd/raspi_lcd -w16 -y1 "àáâãäåæçèéêëìíîï"
/home/pi/raspi_lcd/raspi_lcd -w16 -y2 "ðñòóôõö÷øùúûüýþÿ"
