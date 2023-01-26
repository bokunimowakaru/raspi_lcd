#!/usr/bin/env python3
# coding: utf-8

import sys
import os
import subprocess
from datetime import datetime
from time import sleep									# スリープ実行モジュールの取得

class RaspiI2cDetect:

	def help(self):
		dir = os.path.dirname(__file__)
		path = dir + '/raspi_i2cdetect'					# raspi_i2cdetect モジュールのパス
		app = [path, '-h']								# 起動オプション
		res = subprocess.run(app, stdout=subprocess.PIPE) # サブプロセスとして起動
		data = res.stdout.decode().strip()				# 結果をdataへ代入
		ret = res.returncode							# 終了コードをdataへ代入
		if ret != 0:									# エラー時
			print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), end=' ') # 日時
			print('LCD ERROR in def help')
			print('app =', app) 						# サブ起動する設定内容を表示
			print('ret=', ret)							# 結果データを表示
			print('data=', data)						# 結果データを表示
			raise Exception('ERROR: raspi_i2cdetect, return data='+ret)
		return str(data)

	def list(self, address=[], table_en=True):
		dir = os.path.dirname(__file__)
		path = dir + '/raspi_i2cdetect'					# raspi_i2cdetect モジュールのパス
		app = [path]	# 起動設定
		if table_en == False:
			app.append('-n')							# app.extend(address)
		for adr in address:
			if type(adr) is int:
				app.append(format(adr, 'X'))			# hex(adr)
			elif type(adr) is str:
				app.append(adr)
		# print('DEBUG:',app)							# DEBUG app引数確認用
		res = subprocess.run(app,stdout=subprocess.PIPE)# サブプロセスとして起動
		data = res.stdout.decode().strip()				# 結果をdataへ代入
		ret = res.returncode							# 終了コードをretへ代入
		if ret != 0:
			print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), end=' ') # 日時
			print('LCD ERROR in def print') 			# サブ起動する設定内容を表示
			print('app =', app) 						# サブ起動する設定内容を表示
			print('ret =', data)						# 結果データを表示
			print('data=', data)						# 結果データを表示
			raise Exception('ERROR: list')
		if table_en:
			return str(data)
		else:
			try:
				return int('0x'+data, base=16)
			except ValueError:
				return 0 

def main():
	print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), "Example for RaspiI2cDetect ------------")
	i2det = RaspiI2cDetect() # i2detの生成
	print("-----------------------------------------------------------")

	print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), "RaspiI2cDetect help() -----------------")
	print(i2det.help())
	print("-----------------------------------------------------------")

	print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), "RaspiI2cDetect list() -----------------")
	print(i2det.list())
	print("-----------------------------------------------------------")

	print(datetime.today().strftime('%Y/%m/%d %H:%M:%S'), "RaspiI2cDetect list([3E,3F,38])--------")
	address = i2det.list([0x3E,0x3F,0x38],False)
	print('address =',hex(address))

if __name__ == "__main__":
	main()

'''
実行結果例

pi@raspberrypi:~/raspi_lcd $ ./raspi_i2cdetect.py
2023/01/26 19:53:02 Example for RaspiI2cDetect ------------
-----------------------------------------------------------
2023/01/26 19:53:02 RaspiI2cDetect help() -----------------
Usage: /home/pi/raspi_lcd/./raspi_i2cdetect (Version 1.04)
  /home/pi/raspi_lcd/./raspi_i2cdetect
  /home/pi/raspi_lcd/./raspi_i2cdetect [-n] i2c_address...
-----------------------------------------------------------
2023/01/26 19:53:02 RaspiI2cDetect list() -----------------
I2C Detector (c) 2014-2023 Wataru KUNINO
https://bokunimo.net/raspi/i2c.html

-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- 3F
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-----------------------------------------------------------
2023/01/26 19:53:04 RaspiI2cDetect list([3E,3F,38])--------
3F

'''
