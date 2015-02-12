## Van start geraken met AVR-ontwikkeling (gebaseerd op arduino)

### Installatie

#### Linux
Ubuntu en Debian:   
```sudo apt-get install avrdude avrdude-doc binutils-avr avr-libc gcc-avr gdb-avr```

Fedora en Red Hat:  
```sudo yum install avrdude avr-gcc avr-binutils avr-libc avr-gdb```

#### Mac
Crosspack voor mac zou moeten volstaan, er zijn geen dependencies op xcode (dus je moet niet specifiek een account maken)  
http://www.obdev.at/downloads/crosspack/CrossPack-AVR-20131216.dmg

#### FreeBSD:
Installeer via ports  
avr-gcc, avr-binutils, avr-libc, avr-gdb, avrdude 

#### Windows 7  

Installeer WinAVR of de arduino-omgeving, deze bevat ook de nodige gcc-software.  
Andere mogelijkheid is de software te gebruiken meegeleverd bij de cursus (start de command-line comandline_bash_with_toolchain.bat)

> Windows 8 is not niet uitgeprobeerd maar zou in principe moeten werken (op eigen risico)

### Eerste programma

Bedoeling van deze getting started is de toolchain te leren kennen dus dit programma wordt later verduidelijkt.  
Als dit programma correct wordt geplaatst op de arduino zou het on-board led moeten beginnen te togglen.

``` {.c}
#include <stdio.h>
#include <avr/io.h>
#include <util/delay.h>


#define LED PB5 // PB5 komt overeen met pin 13 op Arduino

void initIO(void)
{
	DDRB |= (1<<LED);
}


int main(void)
{
  initIO();

  while (1)
  {
   PORTB |= (1<<LED); // set
   _delay_ms(500);
   PORTB &= ~(1<<LED); // clear
   _delay_ms(500);
  }
  return 0; // never reached
}

```

### Compileren van de code 

![](../../pictures/toolchain_for_avr_s.png)

* Bewaar het onderstaande programma op je harde schijf (lokaal niet op het netwerk)
* Navigeer via command line naar de directory waar


```
$ avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o led.o led.c
$ ls
led.c  led.o
$ avr-gcc -mmcu=atmega328p led.o -o led
$ ls
led  led.c  led.o
$ avr-objcopy -O ihex -R .eeprom led led.hex
$ ls
led  led.c  led.hex  led.o
$ avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:led.hex

avrdude: AVR device initialized and ready to accept instructions

Reading | ################################################## | 100% 0.00s

avrdude: Device signature = 0x1e950f
avrdude: NOTE: "flash" memory has been specified, an erase cycle will be performed
         To disable this feature, specify the -D option.
avrdude: erasing chip
avrdude: reading input file "led.hex"
avrdude: input file led.hex auto detected as Intel Hex
avrdude: writing flash (176 bytes):

Writing | ################################################## | 100% 0.04s

avrdude: 176 bytes of flash written

avrdude: safemode: Fuses OK (E:00, H:00, L:00)

avrdude done.  Thank you.

```