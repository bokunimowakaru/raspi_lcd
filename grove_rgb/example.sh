#!/bin/bash
################################################################################
# raspi_lcd サンプル・ソフトウェア for Grove-LCD RGB Backlight
#
#                                       Copyright (c) 2022 - 2023 Wataru KUNINO
################################################################################
# 解説：
#   実行すると Grove-LCD RGB Backlight に文字列を表示します。
#
# 要件：
#   本ソフトのインストール($よりも後ろのコマンドを入力)：
#   $ cd ⏎
#   $ sudo apt install git ⏎ (LITE版OS使用時)
#   $ git clone https://bokunimo.net/git/raspi_lcd ⏎
#   $ cd raspi_lcd ⏎
#   $ make clean ⏎
#   $ make ⏎
#   $ cd grove_rgb ⏎
#   $ make clean ⏎
#   $ make ⏎
#
# (参考情報)LCD表示用プログラム raspi_lcd の使い方：
#   $ cd ~/raspi_lcd ⏎
#   $ ./raspi_lcd -h ⏎
#
# (参考情報)RGBバックライト用プログラム raspi_backlight の使い方：
#   $ cd ~/raspi_lcd/grove_rgb ⏎
#   $ ./raspi_backlight -h ⏎
#

LCD_WIDTH="16"              # LCDの桁数 AQM0802は8桁、AQM1602は16桁
LCD_APP="/home/pi/raspi_lcd/raspi_lcd" # LCD表示用。※要makeの実行
RGB_APP="/home/pi/raspi_lcd/grove_rgb/raspi_backlight" # RGB制御用。
LOG="/dev/stdout"           # ログファイル名(/dev/stdoutでコンソール表示)

# 日時表示用 8桁/16桁LCD用
date (){
    if [ ${LCD_WIDTH} -ge 16 ]; then
        /usr/bin/date +"%Y/%m/%d %H:%M:%S"
    else
        /usr/bin/date +"%H:%M:%S"
    fi
}

# RGB Backlight 初期化用
rgb_reset (){
    echo `date` "RGB Backlight reset " >> $LOG 2>&1
    if [ -x "$RGB_APP" ]; then
        echo -n `date`" " >> $LOG 2>&1
        if [ "$#" -gt 3 ]; then
            $RGB_APP $1 $2 $3 >> $LOG 2>&1
        elif [ "$#" -gt 2 ]; then
            $RGB_APP $1 $2 >> $LOG 2>&1
        elif [ "$#" -gt 1 ]; then
            $RGB_APP $1 >> $LOG 2>&1
        else
            $RGB_APP >> $LOG 2>&1
        fi
    else
        echo `date` "no app" ${RGB_APP} >> $LOG 2>&1
    fi
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
    if [ -x "$LCD_APP" ]; then
        if [ -n "${s2}" ]; then
            $LCD_APP -w${LCD_WIDTH} ${s1} > /dev/null 2>&1
            $LCD_APP -w${LCD_WIDTH} -y2 ${s2} > /dev/null 2>&1
        else
            $LCD_APP -w${LCD_WIDTH} -y1 ${s1} > /dev/null 2>&1
        fi
    fi
    echo `date` "LCD" ${s1} "/" ${s2} >> $LOG 2>&1
}

# 初期設定
echo `date` "STARTED -------------------------------" >> $LOG 2>&1
rgb_reset >> $LOG 2>&1
lcd >> $LOG 2>&1
sleep 5

# LCDへの文字列表示例

echo `date` "Example for Grove-LCD RGB Backlight ---" >> $LOG 2>&1
rgb_reset 16 32 48 >> $LOG 2>&1
lcd "`date`" "Grove-LCD BLight" >> $LOG 2>&1
sleep 5
rgb_reset 48 32 16 >> $LOG 2>&1
lcd "0123456789ABCDEF" "16 ｹﾀ ﾏﾃﾞ ﾋｮｳｼﾞ" >> $LOG 2>&1
sleep 5

rgb_reset 32 32 32 >> $LOG 2>&1
lcd "`date`" "RGB=(32,32,32)" >> $LOG 2>&1
sleep 5
rgb_reset 16 48 32 >> $LOG 2>&1
lcd "`date`" "RGB=(16,48,32)" >> $LOG 2>&1
sleep 5

exit
