#!/bin/bash
################################################################################
# raspi_lcd サンプル・ソフトウェア
#
#                                       Copyright (c) 2022 - 2023 Wataru KUNINO
################################################################################
# 解説：
#   実行するとLCDに文字列を表示します。
#
# 要件：
#   本ソフトのインストール($よりも後ろのコマンドを入力)：
#   $ cd ⏎
#   $ sudo apt install raspi-gpio ⏎ (古いOS使用時)
#   $ sudo apt install git ⏎ (LITE版OS使用時)
#   $ git clone https://bokunimo.net/git/raspi_lcd ⏎
#   $ cd raspi_lcd ⏎
#   $ make clean ⏎
#   $ make ⏎
#
# (参考情報)LCD表示用プログラム raspi_lcd の使い方：
#   $ cd ~/raspi_lcd ⏎
#   $ ./raspi_lcd -h ⏎
#
# (参考文献)GPIO用コマンド
#   $ raspi-gpio help ⏎
#

LCD_WIDTH="16"              # LCDの桁数 AQM0802は8桁、AQM1602は16桁
LCD_IO="16"                 # LCD用電源用IOポート番号を指定する
LCD_APP="./raspi_lcd"       # LCD表示用。※要makeの実行
I2D_APP="./raspi_i2cdetect" # I2C検出アプリ ※要makeの実行
LOG="/dev/stdout"           # ログファイル名(/dev/stdoutでコンソール表示)

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
    # if [ ${LCD_IO} -ge 0 ]; then
    #     # raspi-gpio set 3 ip pu                # PORT_SCL
    #     # raspi-gpio set 2 ip pu                # PORT_SDA
    #     while [ "`raspi-gpio get ${LCD_IO}|awk '{print $5}'|sed 's/func=//g'`" = "INPUT" ]; do
    #         # GPIOの出力設定が効かないことがあるので whileで出力に切り替わるまで繰り返す
    #         raspi-gpio set ${LCD_IO} op pn dl   # ouput
    #         sleep 1
    #         echo -n "." >> $LOG 2>&1
    #     done
    #     raspi-gpio set ${LCD_IO} dl # RESET and VDD OFF
    #     sleep 0.2                   # 電源を落ち切らせるために延長(本来はsleep 0.04 )
    #     raspi-gpio set ${LCD_IO} dh # 電源ON
    # fi
    echo >> $LOG 2>&1
    sleep 0.1
    $LCD_APP -i -a${I2ADR} -w${LCD_WIDTH} -r${LCD_IO} "LCD reset GPIO"${LCD_IO} > /dev/null 2>&1
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
    if [ -x "$LCD_APP" ]; then
        if [ -n "${s2}" ]; then
            $LCD_APP -i -a${I2ADR} -n -w${LCD_WIDTH} ${s1} > /dev/null 2>&1
            $LCD_APP -i -a${I2ADR} -n -w${LCD_WIDTH} -y2 ${s2} > /dev/null 2>&1
        else
            $LCD_APP -i -a${I2ADR} -n -w${LCD_WIDTH} -y1 ${s1} > /dev/null 2>&1
        fi
    fi
    echo `date` "LCD" ${s1} "/" ${s2} >> $LOG 2>&1
}

# アプリ検索
echo `date` "SETTING UP ----------------------------" >> $LOG 2>&1

if [ ! -x $LCD_APP ]; then
    LCD_APP=`which raspi_lcd`
    if [ ! -x $LCD_APP ]; then
        LCD_APP="/home/pi/raspi_lcd/raspi_lcd"
        if [ ! -x $LCD_APP ]; then
            LCD_APP="/home/pi/RaspberryPi/gpio/raspi_lcd"
fi fi fi
echo `date` "LCD path" $LCD_APP >> $LOG 2>&1

if [ ! -x $I2D_APP ]; then
    I2D_APP=`which raspi_i2cdetect`
    if [ ! -x $I2D_APP ]; then
        I2D_APP="/home/pi/raspi_lcd/raspi_i2cdetect"
        if [ ! -x $I2D_APP ]; then
            I2D_APP="/home/pi/RaspberryPi/gpio/raspi_i2cdetect"
fi fi fi
echo `date` "I2C Detector path" $I2D_APP >> $LOG 2>&1

# LCD用のI2Cアドレス 3E 3F 27 38 20 が見つかるまで確認
I2ADR=`$I2D_APP -n 3E 3F 27 38 20`
while [ -z $I2ADR ]; do
    echo `date` "LCD no I2C devices found" >> $LOG 2>&1
    echo `date` "LCD GPIO port" `$LCD_APP -q${LCD_IO}` >> $LOG 2>&1
    sleep 5
    I2ADR=`$I2D_APP -n 3E 3F 38`
done

echo `date` "I2C LCD Address" $I2ADR >> $LOG 2>&1

# LCDの初期設定
echo `date` "STARTED -------------------------------" >> $LOG 2>&1
lcd_reset >> $LOG 2>&1
lcd >> $LOG 2>&1
sleep 5

# LCDへの文字列表示例

echo `date` "Example for AQM1602A/Y/Grove ----------" >> $LOG 2>&1
lcd "`date|cut -c1-16`" "AQM1602A/Y/Grove" >> $LOG 2>&1
sleep 5
lcd "0123456789ABCDEF" "16 ｹﾀ ﾏﾃﾞ ﾋｮｳｼﾞ!" >> $LOG 2>&1
sleep 5

echo `date` "Example for AQM0802A ------------------" >> $LOG 2>&1
lcd "`date|cut -c1-16`" "AQM1602A/Y/Grove" >> $LOG 2>&1
sleep 5
lcd "01234567" "8ｹﾀﾋｮｳｼﾞ" >> $LOG 2>&1
sleep 5

echo `date` "LCD Remove I2C on GPIO port" `$LCD_APP -q${LCD_IO}` >> $LOG 2>&1
exit
