#!/usr/bin/env python3
# coding: utf-8

import sys
import os
import subprocess
import datetime
from time import sleep									# スリープ実行モジュールの取得

class RaspiLcd:

	def __init__(self,adr=0x3e,ignoreError=False,x=16,reset=0):	# コンストラクタ作成
		self.restoreUsedGpio = False					# 使用したGPIOを終了時に開放しない
		self.title = "ﾎﾞｸﾆﾓﾜｶﾙ Rasp.Pi by bokunimo.net"
		self.dir = os.path.dirname(__file__)
		self.ignoreError = ignoreError
		self.adress  = adr								# I2Cアドレス
		self.width = x									# LCD Digits
		self.reset_port  = reset						# GPIO ポート番号
		self.bar = None									# 棒グラフの初期化状態
		print(datetime.datetime.today().strftime('%Y/%m/%d %H:%M:%S'), end=' ') # 日時
		print('LCD initialized')
		self.print()

	def help(self):
		path = self.dir + '/raspi_lcd'					# raspi_lcd モジュールのパス
		app = [path, '-h']								# 起動オプション
		res = subprocess.run(app, stdout=subprocess.PIPE) # サブプロセスとして起動
		data = res.stdout.decode().strip()				# 結果をdataへ代入
		ret = res.returncode							# 終了コードをdataへ代入
		if ret != 0:									# エラー時
			print(datetime.datetime.today().strftime('%Y/%m/%d %H:%M:%S'), end=' ') # 日時
			print('LCD ERROR in def help')
			print('app =', app) 						# サブ起動する設定内容を表示
			print('ret=', ret)							# 結果データを表示
			print('data=', data)						# 結果データを表示
			raise Exception('ERROR: raspi_lcd, return data='+ret)
		return data

	def print(self, data=None, y=1):
		if self.width != 8 and self.width != 16:
			raise Exception('ERROR: LCD width')
		if data is None:
			data = self.title
		path = self.dir + '/raspi_lcd'					# raspi_lcd モジュールのパス
		app = [path]	# 起動設定
		if self.adress >= 8 and self.adress <= 119:
			app.append('-a' + format(self.adress, 'X'))
		if self.ignoreError == True:
			app.append('-i')
		if self.width > 8:
			app.append('-w'+str(self.width))
		if y == 2:
			app.append('-y'+str(y))
		elif self.reset_port > 0:
			app.append('-r'+str(self.reset_port))
		app.append(data)
		# print('DEBUG:',app)							# DEBUG app引数確認用
		res = subprocess.run(app,input=None,stdout=subprocess.PIPE)# サブプロセスとして起動
		ret = res.returncode							# 終了コードをretへ代入
		print(datetime.datetime.today().strftime('%Y/%m/%d %H:%M:%S'), end=' ') # 日時
		if ret != 0:
			data = res.stdout.decode().strip()			# 結果をdataへ代入
			print('LCD ERROR in def print') 			# サブ起動する設定内容を表示
			print('app =', app) 						# サブ起動する設定内容を表示
			print('ret =', data)						# 結果データを表示
			print('data=', data)						# 結果データを表示
			raise Exception('ERROR: print')
		else:
			if len(data) > self.width:
				print('LCD', data[0:self.width], '/', data[self.width:2*self.width])
			else:
				print('LCD', data[0:self.width])
		return ret

	def printBar(self, data=[0], y=1):
		if self.width != 8 and self.width != 16:
			raise Exception('ERROR: LCD width')
		path = self.dir + '/raspi_lcd'					# raspi_lcd モジュールのパス
		app = [path]	# 起動設定
		if self.adress >= 8 and self.adress <= 119:
			app.append('-a' + format(self.adress, 'X'))
		if self.ignoreError == True:
			app.append('-i')
		if self.bar is None:
			if self.reset_port > 0:
				app.append('-r'+str(self.reset_port))
		else:
			app.append('-n')
		self.bar = 'inited'
		app.append('-b')
		if self.width > 8:
			app.append('-w'+str(self.width))
		if y == 2:
			app.append('-y'+str(y))
		app.append(str(data[0]))
		if len(data) >= 2:
			app.append(str(data[1]))
		# print(app)									# DEBUG app引数確認用
		res = subprocess.run(app,input=None,stdout=subprocess.PIPE)# サブプロセスとして起動
		ret = res.returncode							# 終了コードをretへ代入
		if ret != 0:
			raise Exception('ERROR: bar')
		print(datetime.datetime.today().strftime('%Y/%m/%d %H:%M:%S'), end=' ') # 日時
		print('LCD printBar', data)
		return ret

	def __del__(self):									# インスタンスの削除
		if self.restoreUsedGpio and self.reset_port > 0:
			if sys.meta_path is not None:
				print(datetime.datetime.today().strftime('%Y/%m/%d %H:%M:%S'), end=' ')
				print('LCD restore GPIO'+str(self.reset_port), 'to free')
			sleep(5)
			path = self.dir + '/raspi_lcd'				# IR 受信ソフトモジュールのパス
			app = [path, '-q'+str(self.reset_port)]		# ポートの開放
			# print(app)								# DEBUG app引数確認用
			res = subprocess.run(app,stdout=subprocess.PIPE)  # サブプロセスとして起動
			if res.returncode != 0 and sys.meta_path is not None: # 終了コードを確認
				print(res.stdout.decode().strip())		# 結果を表示
				print('WARN: Failed to Disable Port',self.reset_port)
		if sys.meta_path is not None:
			print(datetime.datetime.today().strftime('%Y/%m/%d %H:%M:%S'), 'LCD Done')

def main():
	s = ''
	raspiLcd = RaspiLcd(ignoreError=True,x=16,reset=16) # raspiLcdの生成
	if len(sys.argv) >= 2 and sys.argv[1].isnumeric():
		s = [int(sys.argv[1])]
		if len(sys.argv) >= 3 and sys.argv[2].isnumeric():
			s.append(int(sys.argv[2]))
		raspiLcd.printBar(s)
		return
	for word in sys.argv[1:]:                       	# 引数を変数 word へ代入
		s += word + ' '
	if len(s) > 0:
		raspiLcd.print(s)
	else:
		print(raspiLcd.help())							# ヘルプメッセージを表示
		raspiLcd.print(raspiLcd.title)					# タイトル表示

if __name__ == "__main__":
	main()

'''
実行結果例

pi@raspberrypi:~/raspi_lcd $ ./raspi_lcd.py
2023/01/26 21:17:50 LCD initialized
Usage: /home/pi/raspi_lcd/./raspi_lcd (Version 1.04)
  /home/pi/raspi_lcd/./raspi_lcd [-i] [-a address] [-f] [-r port] [-w lcd_width] [-y row] text...
  /home/pi/raspi_lcd/./raspi_lcd [-i] [-a address] [-f] [-r port] [-w lcd_width] [-y row] [-b|-d] value...
  echo text... | /home/pi/raspi_lcd/./raspi_lcd [-i] [-f] [-r port] [-w lcd_width] [-y row]
  /home/pi/raspi_lcd/./raspi_lcd -h # shows this help
  /home/pi/raspi_lcd/./raspi_lcd -q # releases I2C ports

    options:
      -i      ignore I2C communication errors
      -aADR   set i2c address in hex (defalut=3E)
      -s      slowdown I2C communication mode
      -rPORT  set GPIO port number of reset LCD pin; number for PORT
      -wWIDTH set display digits; 8 or 16 for WITDH
      -yROW   set display row; 1 or 2 for ROW
      -b      display bar graph
      -d      display dot graph
      text... display text string on the LCD
      -n      skip initializing LCD
      -f      use standard input, continuously
      -qPORT  restore GPIO port and I2C ports
      -h      display this help on the terminal
      -v      show version (for 1.01 and greater)

    オプション(in Japanese):
      -i      I2C通信のエラーを無視する
      -aADR   I2Cアドレスを設定する
      -rPORT  液晶のリセット信号用GPIOポート番号
      -wWIDTH 液晶の表示桁数8または16
      -yROW   表示行1または2
      -b      レベルメータ表示
      -d      ドットメータ表示
      text... 表示したい文字列
      -n      液晶の初期化を実行しない
      -f      標準入力から待ち受けを行う（終了しない）
      -qPORT  使用していたGPIOポートの開放
      -h      本ヘルプの表示
      -v      バージョン表示(1.01～)
2023/01/26 21:17:51 LCD ﾎﾞｸﾆﾓﾜｶﾙ Rasp.Pi /  by bokunimo.net
2023/01/26 21:17:51 LCD Done

'''
