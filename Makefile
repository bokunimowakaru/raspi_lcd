CC = gcc

all: $(PROGS)
		gcc -Wall -Wno-format-truncation -O1 -c raspi_i2c.c -o raspi_i2c.o
		gcc -Wall -O1 raspi_lcd.c raspi_i2c.o -o raspi_lcd
		gcc -Wall -O1 raspi_i2cdetect.c raspi_i2c.o -o raspi_i2cdetect
		# ========================================
		# Examples for Raspberry Pi (Raspbian)
		#                         by Wataru KUNINO
		# ========================================

clean:
	rm -f $(PROGS) raspi_i2c raspi_i2c.o
	rm -f raspi_lcd raspi_i2cdetect
