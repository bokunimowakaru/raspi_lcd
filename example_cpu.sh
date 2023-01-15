#!/bin/bash
################################################################################
# raspi_lcd サンプル・ソフトウェア
#
#                                       Copyright (c) 2022 - 2023 Wataru KUNINO
################################################################################

BUTTON_IO="27"  # ボタンでシャットダウン(使用しないときは0)
CPU_CORES=1
SECONDS=0
MEMS=(100 100 100 100 100 100 100 100)

# ボタン状態を取得 (取得できないときは0,BUTTON_IO未設定時は1)
button (){
    if [ $(($BUTTON_IO)) -le 0 ]; then
        return 1
    else
        return $((`raspi-gpio get ${BUTTON_IO}|awk '{print $3}'|sed 's/level=//g'`))
    fi
}
button_shutdown (){
    ret=-1
    if [ $(($BUTTON_IO)) -gt 0 ]; then
        sleep 0.3
        button
        ret=$?
    fi
    if [ $ret -eq 0 ]; then
        /home/pi/RaspberryPi/gpio/raspi_lcd -i "ﾎﾞﾀﾝ_ｦ_ｵｼﾂﾂﾞｹﾙﾄ" "ｼｬｯﾄﾀﾞｳﾝ_ｼﾏｽ"
        sleep 2
        if [ $(($BUTTON_IO)) -gt 0 ]; then
            button
            ret=$?
        fi
        if [ $ret -eq 0 ]; then
            /home/pi/RaspberryPi/gpio/raspi_lcd -i "Shuting down..." "Please wait"
            date >> $LOG 2>&1
            echo "shutdown -h now" >> $LOG 2>&1
            sudo shutdown -h now
            exit 0
        fi
    fi
}

echo "ボタン状態を確認中"
button
while [ $? -eq 0 ]; do
    echo `date` "configuring GPIO" >> $LOG 2>&1
    raspi-gpio set ${BUTTON_IO} ip pu
    sleep 1
    button
done

echo "LCD起動中"
/home/pi/RaspberryPi/gpio/raspi_lcd -i -b 0 >/dev/null
i=4
while [ $i -le 100 ]; do
	/home/pi/RaspberryPi/gpio/raspi_lcd -i -n -b $i >/dev/null
	i=$(( i + 6 ))
done
i=96
while [ $i -ge 0 ]; do
	/home/pi/RaspberryPi/gpio/raspi_lcd -i -n -b $i >/dev/null
	i=$(( i - 6 ))
done

echo "メイン処理を開始"
while true; do
	# 時計
	echo "時計表示"
	hour=$((`date "+%_I"`))
	hour_pt=$(( ( ( $hour + 6 ) % 12 ) * 100 / 12 ))
	/home/pi/RaspberryPi/gpio/raspi_lcd -i -n -b $hour_pt >/dev/null
	/home/pi/RaspberryPi/gpio/raspi_lcd -y2 `date "+%R:%S"` >/dev/null
	sleep 2

	# UPTIME CPU負荷
	echo "CPU負荷表示"
	cpu_f=`uptime|cut -d',' -f3|tr -d ' '|cut -d':' -f2`
	cpu100=`echo "${cpu_f} * 100 / ${CPU_CORES}"|bc`
	cpu_i=`printf "%.0f" $cpu100`
	if [ $cpu_i -ge 80 ]; then
		echo "CPU負荷が高くなっています。現在、"${cpu_i}"％です。"
	fi
	if [ $cpu_i -lt 0 ]; then # 負にならないがraspi_lcdが負値に非対応
		cpu_i=0
	fi
	/home/pi/RaspberryPi/gpio/raspi_lcd -i -n -b $cpu_i >/dev/null
	/home/pi/RaspberryPi/gpio/raspi_lcd -y2 "CPU" $cpu_f >/dev/null
	sleep 2

	# FREE メモリ容量
	echo "メモリ容量表示"
	mem=`free|grep "Mem:"`
	mem_total=$((`echo $mem|awk '{print $2}'`))
	mem_avail=$((`echo $mem|awk '{print $7}'`))
	mem_i=$(( $mem_avail * 100 / $mem_total * -1 + 100 ))
	if [ $mem_i -lt 0 ]; then # 負にならないがraspi_lcdが負値に非対応
		mem_i=0
	fi
	if [ $SECONDS -ge 10800 ]; then #3時間経過
		SECONDS=0
		MEMS=(${MEMS[1]} ${MEMS[2]} ${MEMS[3]} ${MEMS[4]} ${MEMS[5]} ${MEMS[6]} ${MEMS[7]} $mem_i)
	fi
	if [ $mem_i -ge 90 ]; then
		if [ $mem_i -gt ${MEMS[1]} ]; then
			echo "メモリ使用量の異常事態です。現在、"${mem_i}"％です。"
		else
			echo "メモリ使用量が高くなっています。現在、"${mem_i}"％です"
		fi
	fi
	/home/pi/RaspberryPi/gpio/raspi_lcd -i -n -b $mem_i >/dev/null
	/home/pi/RaspberryPi/gpio/raspi_lcd -y2 "MEM" $mem_i "%" >/dev/null
	sleep 2

	# DF SDカード容量
	echo "SDカード容量表示"
	sdcap=`df | grep "/dev/root"|awk '{print $5}'|cut -d"%" -f1`
	sdcap_i=$(($sdcap))
	if [ $sdcap_i -lt 0 ]; then
		sdcap_i=0
	fi
	if [ $sdcap_i -ge 60 ]; then
		if [ $sdcap_i -ge 90 ]; then
			echo "SDカード使用率の異常事態です。現在、"${sdcap_i}"です"
		else
			echo "SDカード使用率が"${sdcap_i}"％です"
		fi
	fi
	/home/pi/RaspberryPi/gpio/raspi_lcd -i -n -b $sdcap_i >/dev/null
	/home/pi/RaspberryPi/gpio/raspi_lcd -i -y2 "SSD" $sdcap_i "%" >/dev/null
	sleep 2

	# シャットダウンボタン
	button_shutdown
done
