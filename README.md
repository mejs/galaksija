Galaksija: 1983 Yugoslav 8-bit DIY microcomputer
=====================================
![Galaksija](/imgs/galaksija.JPG)

Galaksija is a Z80A based microcomputer designed in 1983 in Belgrade (Yugoslavia, now Serbia) by Voja Antonić. This repo includes roms, programs and tools for working with this computer. 

For more about my Galaksija build project, check my ongoing [Twitter thread](https://twitter.com/mejs/status/1310633747461668869)

### Roms
There were 3 roms for the original Galaksija
- 2 2732 4KB EPROMs: ROM A (main functins and BASIC) and ROM B (advanced math functions, released in 1984)
- 1 2716 2KB EPROM: character generator rom

While the character ROM hasn't changed after release, different computer versions came with different logos. A number of companies were involved in production and distribution of Galaksija parts, but three companies actively participated in Galaksija branding:
- Elektronika inženjering
- Mipro
- Zavod za udžbenike i nastavna sredstva

Elektronika inženjering and Mipro featured their respective logos at the Galaksija READY prompt. I haven't been able to confirm what determined which character ROMs had which logo. Most character ROMs available online feature the recognizable Elektronika inženjering logo, but I generated one with Mipro's logo as well for historical reasons.

![Mipro](/imgs/mipro.png)
Mipro logo
![EI](/imgs/ei.png)
Elektronika inženjering logo

* [Mipro character rom](https://github.com/mejs/galaksija/blob/master/roms/CHRGENMIPRO.BIN)
* [Elektronika inženjering character rom](https://github.com/mejs/galaksija/blob/master/roms/CHRGENELEKTRONIKAINZENJERING.BIN)

### Programs

### Tools
**dump2gtp**
