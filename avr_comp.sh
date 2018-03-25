#!/bin/bash
# ===========================================================================#
#   REQUIREMENTS:  -                                                         #
#          NOTES:  Let the information always be free!                       #
#         AUTHOR:  Mei Mustaqim                                              #
#        COMPANY:  Feel free                                                 #
#        VERSION:  1.0                                                       #
#        CREATED:  05.11.2017 - 00:43                                        #
#       REVISION:  Every time                                                #
#      COPYRIGHT:  2017 Mei Mustaqim                                         #
#        LICENSE:  WTFPL v2                                                  #
# ===========================================================================#
# Copy program to /usr/bin to make easy run

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

## ___________________________ AVR STUDIO ___________________

compile_avr(){

        avr-gcc -g -Os -mmcu=$3 -c $2.c
        avr-gcc -g -Os -mmcu=$3 -o $2.elf $2.o
        avr-objcopy -j .text -j .data -O ihex $2.elf $2.hex

        sleep 1
        echo ""
        echo -n -e $BGreen "----- [!] DONE [!] -----"
        echo " "
        echo " "
}

remove_avr(){
        echo -n -e $Red "      [?] Are you sure want to remove compiling file ? (Y/N) [?] "; tput sgr0
        read input
        if [ $input == 'Y' ] || [ $input == 'y' ]
            then
            echo -n -e $BWhite "      [*]-- Enter main program --[*] "; tput sgr0
            read f_name
            rm $f_name*.hex $f_name*.elf $f_name*.o
            sleep 1
            echo ""
            echo -n -e $BGreen "----- [!] DONE [!] -----"
            echo " "
            echo " "
        else
            echo -n -e $BGreen "[!] Abort task !! [!]"
            exit 1
        fi
}

upload_avr(){

    sudo avrdude -c $4 -P $6 -b $5 -p $3 -D -U flash:w:$2.hex
    
    echo "    - avr_comp.sh -u main atmega32 wiring 115200 /dev/ttyACM0"

    echo ""
    echo -n -e $BGreen "----- [!] DONE [!] -----"
    echo " "
    echo " "
}

avr_install(){
	echo -e $BWhite "      [!]-- Instlall AVR Toolchain... --[!] "; tput sgr0
	echo ""
	sudo apt-get update -qq && sudo apt-get upgrade all -qq
	sudo apt-get install gcc-avr binutils-avr avr-libc gdb-avr avrdude -yqq
	echo ""
	echo -e $BGreen "----- [!] DONE [!] -----"
	echo ""
}

valid_prog(){
    printf "\t[!] Valid Programmers : [!]\n"

    printf "\t%s\t\t%s\t\t%s\t\t%s\n" "01) 2232HIO" "31) dapa;" "61) jtagkey" "91) usbasp-clone"
    printf "\t%s\t\t%s\t\t%s\t\t%s\n" "02) 4232h" "32) dasa" "62) jtagmkI" "92) usbtiny"
    printf "\t%s\t\t%s\t\t%s\t\t%s\n" "03) 89isp" "33) dasa3" "63) jtagmkII" "93) wiring"
    printf "\t%s\t\t%s\t\t%s\t%s\n" "04) abcmini" "34) diecimila" "64) jtagmkII_avr32" "94) xil"
    printf "\t%s\t\t\t%s\t\t%s\t\t%s\n" "05) alf" "35) dragon_dw" "65) lm3s811" "95) xplainedpro"
    printf "\t%s\t\t%s\t\t%s\n" "06) arduino" "36) dragon_hvsp" "66) mib510"
    printf "\t%s\t%s\t\t%s\n" "07) arduino-ft232r" "37) dragon_isp" "67) mkbutterfly"
    printf "\t%s\t\t%s\t\t%s\n" "08) atisp" "38) dragon_jtag" "68) nibobee" 
    printf "\t%s\t\t%s\t\t%s\n" "09) atmelice" "39) dragon_pdi" "69) o-link" 
    printf "\t%s\t\t%s\t\t%s\n" "10) atmelice_dw" "40) dragon_pp" "70) openmoko" 
    printf "\t%s\t%s\t\t%s\n" "11) atmelice_isp" "41) dt006" "71) pavr" 
    printf "\t%s\t%s\t\t%s\n" "12) atmelice_pdi" "42) flip1" "72) pickit2" 
    printf "\t%s\t\t%s\t\t%s\n" "13) avr109" "43) flip2" "73) picoweb" 
    printf "\t%s\t\t%s\t%s\n" "14) avr910" "44) frank-stk200" "74) ponyser"
    printf "\t%s\t\t%s\t\t%s\n" "15) avr911" "45) ft232r" "75) siprog"
    printf "\t%s\t\t%s\t\t%s\n" "16) avrftdi" "46) ft245r" "76) sp12"
    printf "\t%s\t\t%s\t\t%s\n" "17) avrisp" "47) futurlec" "77) stk200"
    printf "\t%s\t\t%s\t\t%s\n" "18) avrisp2" "48) jtag1" "78) stk500"
    printf "\t%s\t\t%s\t\t%s\n" "19)avrispmkII" "49) jtag1slow" "79) stk500hvsp"
    printf "\t%s\t\t%s\t\t%s\n" "20) avrispv2" "50) jtag2" "80) stk500pp"
    printf "\t%s\t\t%s\t\t%s\n" "21) bascom" "51) jtag2avr32" "81) stk500v1"
    printf "\t%s\t\t%s\t\t%s\n" "22) blaster" "52) jtag2dw" "82) stk500v2"
    printf "\t%s\t\t\t%s\t\t%s\n" "23) bsd" "53) jtag2fast" "83) stk600"
    printf "\t%s\t\t%s\t\t%s\n" "24) buspirate" "54) jtag2isp" "84) stk600hvsp"
    printf "\t%s\t%s\t\t%s\n" "25) buspirate_bb" "55) jtag2pdi" "85) stk600pp"
    printf "\t%s\t\t%s\t\t%s\n" "26) butterfly" "56) jtag2slow" "86) ttl232r"
    printf "\t%s\t%s\t\t%s\n" "27) butterfly_mk" "57) jtag3" "87) tumpa"
    printf "\t%s\t\t%s\t\t%s\n" "28) bwmega" "58) jtag3dw" "88) UM232H"
    printf "\t%s\t\t%s\t\t%s\n" "29) C232HM" "59) jtag3isp" "89) uncompatino"
    printf "\t%s\t\t%s\t\t%s\n" "30) c2n232i" "60) jtag3pdi" "90) usbasp"
}

main(){
	echo ""
	echo -e $BRed"++++++++++++++++++++++++++++++++++++++++++++++++++" ; tput sgr0
    echo ""
    echo -n -e $BYellow"        [ ____ Free AVR Compiling ____ ]"; tput sgr0;
    echo ""
    echo -e $BRed"++++++++++++++++++++++++++++++++++++++++++++++++++"; tput sgr0
    echo ""
    echo "[!] Select your option : [!]"
    echo -e $BWhite "   -c, --compile       : Compile main program"
    echo -e $BWhite "   -r, --remove        : Delete .o, .elf, and .hex files"
    echo -e $BWhite "   -u, --upload        : Upload .hex file "
	echo -e $BWhite "   -i, --install       : Install AVR Toolchain "
    echo -e $BWhite "   -p, --programmer    : Print valid programmers "
    echo ""
    echo "   Example : "
    echo "    - avr_comp.sh -c *main_file* *proccessor* -> compile main program"
    echo "    - avr_comp.sh -r -> remove main compiled program"
    echo "    - avr_comp.sh -u *main_file* *proccessor* *prog_uploader* *baud_rate* *port* -> upload program"
    echo "    - avr_comp.sh -i -> install depend"
    echo "    - avr_comp.sh -p -> print valid programmers"
}

if [ $1 == -c ] || [ $1 == --compile ] && [ $# = 3 ] ; then
    #compile_avr
    avr-gcc -g -Os -mmcu=$3 -c $2.c
    avr-gcc -g -Os -mmcu=$3 -o $2.elf $2.o
    avr-objcopy -j .text -j .data -O ihex $2.elf $2.hex

    sleep 1
    echo ""
    echo -n -e $BGreen "----- [!] DONE [!] -----"
    echo " "
    echo " "
elif [[ $1 == -r ]] || [[ $1 == --remove ]] ; then
    remove_avr
elif [[ $1 == -u ]] || [[ $1 == --upload ]] && [[ $# > 4 ]]; then
    upload_avr
elif [[ $1 == -i ]] || [[ $1 == --install ]] ; then
    avr_install
elif [[ $1 == -p ]] || [[ $1 == --programmers ]] ; then
    valid_prog
else
    main

fi