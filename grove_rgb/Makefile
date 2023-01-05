CC = gcc

all: $(PROGS)
		gcc -W -O1 -c ../raspi_i2c.c -o raspi_i2c.o
		gcc -W -O1 raspi_backlight.c raspi_i2c.o -o raspi_backlight
		# ========================================
		# Examples for Raspberry Pi (Raspbian)
		#                         by Wataru KUNINO
		# ========================================

clean:
	rm -f $(PROGS) raspi_i2c raspi_i2c.o
	rm -f raspi_backlight
