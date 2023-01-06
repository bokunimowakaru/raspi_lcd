#!/bin/bash

################################################################################
# カタカナで表示。「シャンゼリゼ大通り」
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ｶﾀｶﾅ ﾃﾞ ﾋｮｳｼﾞ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ｼｬﾝｾﾞﾘｾﾞ ｵｵ ﾄﾞｵﾘ" > /dev/null
sleep 3

################################################################################
# カタカナで表示。「エトワール凱旋門」
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ﾓｯﾄﾓ ﾕｳﾒｲ @ ﾊﾟﾘ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ｴﾄﾜｰﾙ ｶﾞｲｾﾝﾓﾝ" > /dev/null
sleep 3

################################################################################
# LCD内蔵のカタカナ表示
################################################################################
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎ" > /dev/null
sleep 3
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ﾏﾐﾑﾒﾓ ﾔﾕﾖ ﾗﾘﾙﾚﾛ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ﾜｦﾝ｡｢｣､･ﾟﾞ" > /dev/null
sleep 3
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ｧｨｩｪｫｬｭｮｯ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ｶﾞｷﾞｸﾞｹﾞｺﾞﾊﾟﾋﾟﾌﾟ" > /dev/null
sleep 3
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y1 "ﾎﾞｸﾆﾓﾜｶﾙ" > /dev/null
/home/pi/raspi_lcd/raspi_lcd -i -w16 -y2 "ﾗｽﾞﾍﾞﾘｰ･ﾊﾟｲ" > /dev/null
sleep 3
