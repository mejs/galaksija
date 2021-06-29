Galaksija: 1983 Yugoslav 8-bit DIY microcomputer
=====================================
![logo](/imgs/logo.png)

Galaksija is a Z80A based microcomputer designed in 1983 in Belgrade (Yugoslavia, now Serbia) by Voja Antonić. This repo includes roms, programs and tools for working with this computer. 

![Galaksija](/imgs/galaksija.JPG)

For more about my Galaksija build project, check my ongoing [Twitter thread](https://twitter.com/mejs/status/1310633747461668869).

### [Roms](https://github.com/mejs/galaksija/tree/master/roms)
There were 3 roms for the original Galaksija
- 2 x 2732 4KB EPROMs: ROM A (main functins and BASIC) and ROM B (advanced math functions, released in 1984)
- 1 x 2716 2KB EPROM: character generator rom

Later on at least two additional roms were released, mainly for use with Galaksija Plus, but still compatible with the original Galaksija: ROM C and ROM D. I haven't been able to find copies of these two roms yet, but I did obtain some documentation, which is included in this repo.

#### ROM A
Includes:
- a copy of the first two pages of the original ROM listing (published as GALA005052). I'm still looking for a complete scan.
- the original Galaksija guide published in Računari u vašoj kući Issue 1, covering ROM A functions. An extra copy is available for printing.
- ROM A version 28 - original ROM A before ROM B was available
- ROM A version 29 - updated ROM A with automatic loading of ROM B

#### ROM B
Includes:
- a copy of the original ROM B listing (complete)
- the original ROM B guide published in Računari u vašoj kući Issue 3. An exra copy is available for printing.
- original ROM B
- ROM B with reverted screen position fix. Original ROM B moved the image position to the right. This worked well with TVs, but doesn't fit well on my monitor.

#### ROM C
Includes:
- a scan of the article about ROM C in Svet kompjutera

#### ROM D
Includes
- a scan of the article about ROM D in Svet kompjutera

#### Character generator ROM
While the character ROM hasn't changed after release, different computer versions came with different logos. A number of companies were involved in production and distribution of Galaksija parts, but three companies actively participated in Galaksija branding:
- Elektronika inženjering
- Mipro
- Zavod za udžbenike i nastavna sredstva

Elektronika inženjering and Mipro featured their respective logos at the Galaksija READY prompt. I haven't been able to confirm what determined which character ROMs got which logo. Most character ROMs available online feature the recognizable Elektronika inženjering logo, but I generated one with Mipro's logo as well for historical reasons.

![Mipro](/imgs/mipro.png)

Mipro logo

![EI](/imgs/ei.png)

Elektronika inženjering logo

* [Mipro character rom](https://github.com/mejs/galaksija/blob/master/roms/CHRGENMIPRO.BIN)
* [Elektronika inženjering character rom](https://github.com/mejs/galaksija/blob/master/roms/CHRGENELEKTRONIKAINZENJERING.BIN)

### Programs

### Tools
##### [dump2gtp](https://github.com/mejs/galaksija/tree/master/tools/dump2gtp)

There are multiple Galaksija emulators, but in 2020 Galaksija is most easily emulated in MAME. MAME includes Galaksija specific virtual tape format gtp. A number of historical programs are available in this format, and Tomaž Šolc ([@avian2](https://github.com/avian2)) developed a [series of development tools](https://www.tablix.org/~avian/blog/articles/galaksija-tools/) to work with the format, including gtp2wav to export gtp files to wav for use with real Galaksijas, and bin2gtp to convert Z80 assembly bins to gtp. However, I've been unable to find a tool to export Galaksija recordings to gtp, either historical or newly written programs. dump2gtp is an improvised tool that works in conjuction with MAME to get around this limitation. This tool is in a very early stage. I would like to replace it with a proper wav2gtp tool that wouldn't require dumping the program through MAME before converting.

The tool is written in bash. Along with regular UNIX tools, it requires xxd to convert hex into a bin, and python to generate 2s complement, needed to generate cheksum. It currently consists of 3 files:

* [dump2gtp.sh](https://github.com/mejs/galaksija/blob/master/tools/dump2gtp/dump2gtp.sh) - main script, run against a MAME generated dump in text file
* decimal.sh - needed to convert HEX into decimal in the script. Will be merged into main script
* 2s.py - for generating 2s complement

###### Steps

* Galaksija program is recorded onto a computer using Audacity or another audio program
 * It is exported as an unsigned PCM wav file (this is important as MAME has issues with signed PCM wavs)
 * I have had success recording very low audio with my mic set to 19%. This is what the soundwave looked like compared to gtp2wav generated wav. Anything louder than this wouldn't load into MAME. It's also important to export as mono since Galaksija uses one channel for loading and the other for saving.

![wav1](/imgs/wav1.png)

wav recorded from my Galaksija in Audacity

![wav2](/imgs/wav2.png)

wav generated with gtp2wav tool

* WAV is loaded into emulated Galaksija running  in MAME. 
 * Mame is started with -debug option
 * F5 is pressed to run the machine 
 * Scroll Lock is pressed to enable Partial Emulation which allows bringing up MAME menu by pressing tab
 * Program wav file is selected in File Manager
 * OLD command is issued in Galaksija to load the tape
 * Tape Control is selected in MAME menu and program is played
 * When the program loads successfuly, READY prompt will apear. If it doesn't, there may be an issue with the wav file. Try looking at it in Audacity or similar program

* Program is dumped out of MAME into a txt file
 * First we need to calculate the size of program to dump. Original Galaksija came with 2KB, 4KB or 6KB of memory. MAME emulator runs with 6KB, 5062 of which is available after start
 * Run PRINT MEM. This will give us the amount of available memory after loading the program
 * Subtract remaining memory from 5062. E.g. 5062-3766=1296
 * Add 4 bytes to 1296. Galaksija tapes include some extra memory spaces, so we want to dump 4 bytes ahead of the program start (BASIC start pointer and BASIC end pointer). E.g. 1296+4=1301
 * Convert program size + 4 bytes to HEX. E.g. 1301=515
 * Use the following command to dump: dump `<filename>,<address>,<length>,<size>,<ascii>` (e.g. `dump gtp_test.txt,2C36,515,1,0`). ASCII=0 turns of ASCII translation in the file, which we don't need

* Running dump2gtp and verifying the gtp
 * dump should be in MAME's root folder. 
 * Run dump2gtp.sh against the dumped txt file
 * A gtp file will be created in the folder where the script is located. 
 * Load the gtp file into MAME
 * Run OLD? command (the questionmark will check it against the program loaded in RAM)
 * If gtp file is good you'll get a READY prompt

###### GTP format

I haven't been able to find gtp's documentation. dump2gtp tool is based on reverse engineering gtp files available online and generated with gtp2wav tool. Below is my preliminary analysis of the format. There may be errors in here:

![gtp format](/imgs/gtp_format.png)


### Case

![case photo](/case/case_photo1.jpg)

The original Galaksija instructions in Računari u vašoj kući suggests using plain PCB material (fiberglass) to make the case. I designed a case in SketchUp that follows this design closely, but which is ready to be 3D printed. A few notes

![case 2](/case/case2.png)

* the design assumes a plexiglass base with standoff screws (4)
* 2 LED holes
* 2 reset button holes (1 NMI, 1 full reset)
* 1 power jack
* 1 power switch
* 1 3.5mm jack
* 1 HDMI port for use with integrated RCA to HDMI adapter

I strongly suggest you measure your Galaksija, especially the keyboard, and make adjustments for I/O ports. Overall dimensions should be compatible with all original PCB designs.

* [SketchUp file](https://github.com/mejs/galaksija/blob/master/case/Galaksija%20case.stl)
* [Additional photos](https://github.com/mejs/galaksija/tree/master/case)
