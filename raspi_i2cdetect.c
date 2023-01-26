/*******************************************************************************
Raspberry Pi用 I2C i2cdetect

デバイスのI2Cアドレスの検索ツールです。
I2Cアドレス8～119（0x00～0x77）の応答を確認し、表示します。

本ソースリストおよびソフトウェアは、ライセンスフリーです。(詳細は別記)
利用、編集、再配布等が自由に行えますが、著作権表示の改変は禁止します。

-nオプションで最初に発見したI2Cアドレスのみを応答します

                                        Copyright (c) 2014-2023 Wataru KUNINO
                                        https://bokunimo.net/raspi/
*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
//#include <stdint.h>
//#include <unistd.h>
#include <string.h>
// #include "../libs/soft_i2c.h"    // リポジトリ RaspberryPi用
#include "raspi_i2c.h"              // リポジトリ raspi_lcd用
typedef unsigned char byte; 

#define VER "1.04"

int main(int argc,char **argv){
    int i, num=1, n=0, adr;
    byte ret;
    while(argc >=num+1 && argv[num][0]=='-'){
        if(argv[num][1]=='n')n=1;
        if(argv[num][1]=='h'){
            printf("Usage: %s (Version %s)\n",argv[0],VER);
            printf("  %s\n",argv[0]);
            printf("  %s -n i2c_address...\n",argv[0]);
            return 0;
        }
        num++;
    }
    if(!n){
        printf("I2C Detector (c) 2014-2023 Wataru KUNINO\n");
        printf("https://bokunimo.net/raspi/i2c.html\n\n");
    }

    ret=0;
    while(!ret){
        ret=i2c_init();
        if( ret==0 ){
            delay(100);
            i2c_close();
            printf("ERROR %d\n",ret);
            return ret;
        }
    }
    if(argc >= 2){
        for(i=num;i<argc;i++){
            ret=0;
            adr=strtol(argv[i],NULL,16);
            if(adr<8 || adr>119){
                if(!n) printf("\nWARN i2c address %02X\n",adr);
            }else{
                ret=i2c_check(adr);
            }
            if(n){
                if(ret){
                    i2c_close();
                    printf("%02X\n",adr);
                    return 0;
                }
            }else{
                if(ret) printf("%02X ",adr); else printf("-- ");
            }
        }
        if(!n) printf("\n");
    }else for(i=8;i<120;i++){
        ret=i2c_check(i);
        if(n){
            if(ret){
                i2c_close();
                printf("%02X\n",i);
                return 0;
            }
        }else{
            if(ret) printf("%02X ",i); else printf("-- ");
            if(i%8==7) printf("\n");
        }
    }
    i2c_close();
    return 0;
}
