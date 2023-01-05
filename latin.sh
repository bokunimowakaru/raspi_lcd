#!/bin/bash

################################################################################
# フランス語で表示。「シャンゼリゼ大通り」
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ﾌﾗﾝｽ ｺﾞ ﾃﾞ ﾋｮｳｼﾞ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ｼｬﾝｾﾞﾘｾﾞ ｵｵ ﾄﾞｵﾘ" > /dev/null
sleep 3
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "L'avenue des" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "Champs-Élysées" > /dev/null
sleep 10


################################################################################
# フランス語で表示。「エトワール凱旋門」
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ﾓｯﾄﾓ ﾕｳﾒｲ@ﾊﾟﾘ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ｴﾄﾜｰﾙ ｶﾞｲｾﾝﾓﾝ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 "Arc de triomphe de l'Étoile" > /dev/null
sleep 3
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "Angèle Joséphine" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "Aimée Van Laeken" > /dev/null
sleep 10

################################################################################
# フランス語で表示。「œ」は「oe」で代用します。
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ﾌﾗﾝｽ ｺﾞ ﾃﾞ ﾋｮｳｼﾞ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ｺﾓｼﾞ ﾊ ﾎﾎﾞ OK" > /dev/null
sleep 3
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "Français (Lower)" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "àâæçéèêëïîôœúûü" > /dev/null
# C3 A0 C3 A2 C3 A6 C3 A7 C3 A9 C3 A8 C3 AA C3 AB C3 AF C3 AE C3 B4 C5 93 C3 BA C3 BB C3 BC len=31
# 0     1     2     3     4     5     6     7     8     9     A     B^^^^ C     D     E
sleep 10

################################################################################
# フランス語で表示。大文字は3文字しか表示できない。小文字で代用します。
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ﾌﾗﾝｽ ｺﾞ ﾉ ｵｵﾓｼﾞ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ｺﾓｼﾞ ﾃﾞ ﾀﾞｲﾖｳ" > /dev/null
sleep 3
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "Français (Upper)" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ÀÂÆÇÉÈÊËÏÎÔŒÚÛÜ" > /dev/null
# C3 80 C3 82 C3 86 C3 87 C3 89 C3 88 C3 8A C3 8B C3 8F C3 8E C3 94 C5 92 C3 9A C3 9B C3 9C len=31
# 0~~~~ 1~~~~ 2     3     4     5~~~~ 6~~~~ 7~~~~ 8~~~~ 9~~~~ A~~~~ B^^^^ C~~~~ D~~~~ E
sleep 10

################################################################################
# LCD内蔵のラテン文字フォント表示 全部で45文字に対応
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ｴｷｼｮｳ ﾌｫﾝﾄ ﾋｮｳｼﾞ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ﾌｫﾝﾄ ｽｳ = 45" > /dev/null
sleep 3
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "LCD 0x80~0x8F" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ÇüéâäàåçêëèïîìÄÅ" > /dev/null
# C3 87 C3 BC C3 A9 C3 A2 C3 A4 C3 A0 C3 A5 C3 A7 C3 AA C3 AB C3 A8 C3 AF C3 AE C3 AC C3 84 C3 85 len=33
sleep 5

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

################################################################################
# UTF8の2バイトコードの一部(64文字)→表示できない文字もある。テスト用
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞß" > /dev/null
sleep 5

/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "àáâãäåæçèéêëìíîï" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ðñòóôõö÷øùúûüýþÿ" > /dev/null
