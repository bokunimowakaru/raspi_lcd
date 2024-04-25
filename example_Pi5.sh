#!/bin/bash
# I2C LCD

################################################################################
# raspi_lcd_i2c.sh サンプル・ソフトウェア for Raspberry Pi 5
#
#                                       Copyright (c) 2022 - 2024 Wataru KUNINO
################################################################################
# 元ソース：
# https://github.com/bokunimowakaru/raspi_lcd/blob/master/example.sh
################################################################################
# 解説：
#   実行するとLCDに文字列を表示します。

LCD_WIDTH=8                     # LCDの桁数 AQM0802は8桁、AQM1602は16桁
LCD_IO=4                        # LCD用電源用IOポート番号を指定する
LOG="/dev/stdout"               # ログファイル名(/dev/stdoutでコンソール表示)

gpio_app="pinctrl"              # GPIO制御にpinctrlを使用する for Raspberry Pi 5
# gpio_app="raspi-gpio"         # GPIO制御に従来のraspi-gpioを使用する

d=("dl" "dh")                   # GPIOの論理値の定義
${gpio_app} set ${LCD_IO} op    # ポート番号portのGPIOを出力に設定

# 日時表示用 8桁/16桁LCD用
date (){
    if [ ${LCD_WIDTH} -ge 16 ]; then
        /usr/bin/date +"%Y/%m/%d %H:%M:%S"
    else
        /usr/bin/date +"%H:%M:%S"
    fi
}

# LCD初期化用
lcd_reset (){
    echo -n `date` "LCD reset GPIO"${LCD_IO} >> $LOG 2>&1
    echo >> $LOG 2>&1
    ${gpio_app} "set" ${LCD_IO} ${d[0]}  # GPIOにLレベルを出力
    sleep 0.1
    ${gpio_app} "set" ${LCD_IO} ${d[1]}  # GPIOにHレベルを出力
    sleep 0.1
    #         Ch I2C       IS=1 OSC=4 Cnt=3 Pow  FC   IS=0 ON
    i2cset -y  1 0x3e 0x00 0x39  0x14  0x73 0x56 0x6c 0x38 0x0C i
    sleep 0.1
}

# LCD表示用
lcd (){
    s1="I2C LCD Driver"
    s2="by ﾎﾞｸﾆﾓﾜｶﾙRasPi"
    #   0123456789012345
    if [ "$#" -ge 1 ] && [ -n "$1" ]; then
        s1=`echo $1| tr '_' ' '`
        if [ "$#" -ge 2 ]; then
            s2=`echo $2| tr '_' ' '`
        else 
            s2=""
        fi
    fi
    if [ "${#s1}" -gt "${LCD_WIDTH}" ]; then
        s1=${s1:0:${LCD_WIDTH}}
    fi
    if [ "${#s2}" -gt "${LCD_WIDTH}" ]; then
        s2=${s2:0:${LCD_WIDTH}}
    fi
    hex1=`echo -n ${s1}| iconv -f utf8 -t sjis | od -An -tx1 | sed 's/ / 0x/g'`
    hex2=`echo -n ${s2}| iconv -f utf8 -t sjis | od -An -tx1 | sed 's/ / 0x/g'`
    hex1_0x20n=$(( ( ${LCD_WIDTH} * 5 - ${#hex1} ) / 5 ))
    hex2_0x20n=$(( ( ${LCD_WIDTH} * 5 - ${#hex2} ) / 5 ))
    hex1=${hex1}`printf %${hex1_0x20n}s | sed "s/ / 0x20/g"`
    hex2=${hex2}`printf %${hex2_0x20n}s | sed "s/ / 0x20/g"`
    echo "hex1="${hex1} >> $LOG 2>&1
    echo "hex2="${hex2} >> $LOG 2>&1
    if [ -n "${s2}" ]; then
        #         Ch I2C  S/W  Reg
        i2cset -y  1 0x3e 0x00 0x80 i
        i2cset -y  1 0x3e 0x40 ${hex1} i
        i2cset -y  1 0x3e 0x00 0xc0 i
        i2cset -y  1 0x3e 0x40 ${hex2} i
    else
        #         Ch I2C  S/W  Reg
        i2cset -y  1 0x3e 0x00 0x80 i
        i2cset -y  1 0x3e 0x40 ${hex1} i
    fi
    echo `date` "LCD" ${s1} "/" ${s2} >> $LOG 2>&1
}

echo "Usage: "${0}" [string1] [string2]"    # プログラム名と使い方を表示する

# LCDの初期設定
echo `date` "STARTED -------------------------------" >> $LOG 2>&1
lcd_reset >> $LOG 2>&1
sleep 1

# LCDへの文字列表示
if [ "$#" -ge 1 ]; then
    lcd ${1} ${2}
else
    echo `date` "Example for AQM1602A/Y/Grove ----------" >> $LOG 2>&1
    lcd "`date|cut -c1-16`" "AQM1602A/Y/Grove" >> $LOG 2>&1
    sleep 5
    lcd "0123456789ABCDEF" "16 ｹﾀ ﾏﾃﾞ ﾋｮｳｼﾞ!" >> $LOG 2>&1
    sleep 5
    echo `date` "Example for AQM0802A ------------------" >> $LOG 2>&1
    lcd "`date|cut -c1-16`" "AQM1602A/Y/Grove" >> $LOG 2>&1
    sleep 5
    lcd "01234567" "8ｹﾀﾋｮｳｼﾞ" >> $LOG 2>&1
fi
