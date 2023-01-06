Galaksija: 1983 Yugoslav 8-bit DIY microcomputer
=====================================
![logo](/imgs/logo.png)

Galaksija is a Z80A-based microcomputer designed in 1983 in Belgrade (Yugoslavia, now Serbia) by Voja Antonić. This repo includes ROMs, programs and tools for working with this computer. 

![Galaksija](/imgs/galaksija.JPG)

For more about my Galaksija build project, check my ongoing [Twitter thread](https://twitter.com/mejs/status/1310633747461668869).

### Gerbers
- Gerbers file of the original single layer board was available at spetsialist-mx.ru. Unfortunately, this website is no longer active, but you can download a rar of the gerbers files from the [Internet Archive](https://web.archive.org/web/20201020014318/http://www.spetsialist-mx.ru/Galaksija/Soft/GalaksijaGerbers.rar). Note that since this is a single layer board, you will have to solder over 100 jumpers, and the connector and drill hole locations are not compatible with modern key switches, so you will either have to source older switches or [improvise like I did](https://twitter.com/mejs/status/1311480797669527553)
- Voja Antonić, Galaksija's designer, released an updated 2 layer PCB. It also includes updated key switch connectors and drill holes, and a new 5nF ceramic capacitor added between `-RFSH` and `GND` on Z80A. This solves the problem of modified timings on the CMOS version of Z80A. You can download the [double-layer PCB from Hackaday](https://cdn.hackaday.io/files/6059259228256/Galaksija%20Outputs.zip)

### Parts
I created a [spreadsheet with all the parts](https://docs.google.com/spreadsheets/d/1QJcyFRXi8k8qUmd-SudMwjSTcvY0Hddc_G902Sn-lK0/edit?usp=sharing) necessary to build a Galaksija, with links and prices. Note: this file is not actively maintained and you should check availability before ordering.

### [ROMs](https://github.com/mejs/galaksija/tree/master/roms)
There were 3 ROMs for the original Galaksija
- 2x 2732 4KB EPROMs: ROM A (main functions and BASIC) and ROM B (advanced math functions, released in 1984)
- 1x 2716 2KB EPROM: character generator ROM

Later on at least two additional ROMs were released, mainly for use with Galaksija Plus, but still compatible with the original Galaksija: ROM C and ROM D. I haven't been able to find copies of these two ROMs yet, but I did obtain some documentation, included in this repo.

#### ROM A
Includes:
- the listing of the original ROM A version 28 with Voja Antonić's comments, published as GALA005052. Kindly provided by Paolo Gigli.
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
- MIPRO
- Zavod za udžbenike i nastavna sredstva

Elektronika inženjering and MIPRO featured their respective logos at the Galaksija READY prompt. I haven't been able to confirm what determined which character ROMs got which logo. Most character ROMs available online feature the recognizable Elektronika inženjering logo, but I generated one with MIPRO's logo as well for historical reasons.

| Prompt with logo                       | Source                  | ROM                                                                         | Preview                                                                                               |
| :------------------------------------: | :---------------------: | :-------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------: |
| ![Mipro](/imgs/mipro.png)              | MIPRO                   | [ROM](/roms/Character%20Generator%20ROM/CHRGEN_MIPRO.BIN)                   | [Preview](/roms/Character%20Generator%20ROM/CHRGEN_MIPRO_SIMULATED_CRT_PREVIEW.PNG)                   |
| ![EI](/imgs/ei.png)                    | Elektronika inženjering | [ROM](/roms/Character%20Generator%20ROM/CHRGEN_ELEKTRONIKA_INZENJERING.BIN) | [Preview](/roms/Character%20Generator%20ROM/CHRGEN_ELEKTRONIKA_INZENJERING_SIMULATED_CRT_PREVIEW.PNG) |
| ![Fan](/imgs/fan-galaxy.png)           | Fan                     | [ROM](/roms/Character%20Generator%20ROM/CHRGEN_GALAXY.BIN)                  | [Preview](/roms/Character%20Generator%20ROM/CHRGEN_GALAXY_SIMULATED_CRT_PREVIEW.PNG)                  |
| ![Fan](/imgs/fan-galaxy-lowercase.png) | Fan                     | [ROM](/roms/Character%20Generator%20ROM/chrgen_lowercase.bin)               | [Preview](/roms/Character%20Generator%20ROM/chrgen_lowercase_simulated_crt_preview.png)               |

### Video

Galaksija outputs 320 horizontal black-and-white lines 50 times a second: 16000 kHz horizontal / 50 Hz vertical sync rate. This is close to PAL timings but not quite (312.5 lines at 15,625 kHz, 50 interleaved fields per second). This discrepancy generally does not bother analogue TV sets (even NTSC) but not be supported by various adapters from analogue/composite to modern digital standards. Note that the basic non-RF output is analogue black and white video, not "composite" as there is no colour information, colour burst or colour subcarrier.

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
