# SharkDumps

![Dump truck icon](/assets/icons/dump-truck-256.png)

This repository aims to preserve all known information about retro video game enhancers from the 1990s-2000s:
GameShark, Action Replay, Xplorer 64, Code Breaker, Game Genie, DexDrive, TV Tuners, etc.

_(Note: "GameShark", "Action Replay", "Game Buster", and "Equalizer" are all just country-specific brand names for the exact same hardware.)_

Specifically, we document:

1. Firmware dumps
2. PCB schematics
3. Software utilities
4. Instruction manuals
5. Cartridge designs
6. Box art

We welcome contributions! If you have firmware, schematics, photos, etc. that are not yet documented here, please create a pull request! 😀

## Legend

- __#G__ = Number of **G**ames pre-loaded
- __#C__ = Number of **C**heats pre-loaded
- __Clean?__
    - ⭐️ = Confirmed **Pristine**. <br>
        Firmware was dumped from a brand new, unused cartridge, and is byte-for-byte identical to the original factory image.
    - ✅ = Confirmed **Clean**. <br>
        All cheats and settings match the OEM defaults, but we don't know for sure if the dump is byte-for-byte identical to the original factory image.
    - ❌ = Confirmed **Dirty**. <br>
        The owner of the cartridge modified some of the games, cheats, or preferences on the cart, so they do not match the factory defaults, but the actual firmware code should still be 100% original.
    - ⚠️ = Provenance **Unknown**. <br>
        We have not yet confirmed whether the games, cheats, and preferences are original or user-modified, so the dump is assumed to be dirty until proven otherwise.
    - `?` = We have not yet acquired a cart to dump the firmware.

---

## N64 GameShark (NA)

<a href="/assets/photos/n64-gs-2.x-front-2400x2000.png"><img src="/assets/photos/n64-gs-2.x-front-200.png" alt="Front side of a typical GameShark v2.x"></a>
<a href="/assets/photos/n64-gs-2.00-black-front-2600x2000.png"><img src="/assets/photos/n64-gs-2.00-black-front-200.png" alt="Front side of a black GameShark v2.0"></a>
<a href="/assets/photos/n64-gs-3.30-full-front-2600x2000.png"><img src="/assets/photos/n64-gs-3.30-full-front-200.png" alt="Front side of a full GameShark v3.3"></a>
<a href="/assets/photos/n64-gs-3.30-neutered-front-2600x2000.png"><img src="/assets/photos/n64-gs-3.30-neutered-front-200.png" alt="Front side of a neutered GameShark v3.3"></a>
<a href="/assets/photos/n64-gs-2.x-rear-1400x1000.png"><img src="/assets/photos/n64-gs-2.x-rear-200.png" alt="Back side of a typical GameShark v2.x"></a>
<a href="/assets/photos/n64-gs-2.00-black-rear-3000x2200.png"><img src="/assets/photos/n64-gs-2.00-black-rear-200.png" alt="Back side of a black GameShark v2.0"></a>
<a href="/assets/photos/n64-gs-3.30-full-rear-3000x2200.png"><img src="/assets/photos/n64-gs-3.30-full-rear-200.png" alt="Back side of a full GameShark v3.3"></a>
<a href="/assets/photos/n64-gs-3.30-neutered-rear-3000x2200.png"><img src="/assets/photos/n64-gs-3.30-neutered-rear-200.png" alt="Back side of a neutered GameShark v3.3"></a>

### N64 GameShark PCBs

_Expertly traced, optimized, and reverse engineered by @RWeick_

<img alt="GameShark REF1329 open source PCB CAD diagram"
     src="/assets/photos/n64-gs-ref1329-open-source-pcb-1620x1121.png"
     width="200">
<img alt="GameShark REF1329 replacement PCB CAD diagram"
     src="/assets/photos/n64-gs-ref1329-replacement-pcb-1080x752.png"
     width="200">

#### Datel REF1329 PCB

Most versions of the N64 GameShark used the same proprietary ASIC chip: the LZ9FC17 Datel GAL.

Because these chips are no longer manufactured and the internal design was never made public, the only way to make _more_ of them (short of [decapping the chip](https://www.youtube.com/watch?v=HwEdqAb2l50), which is beyond our skill set) is to observe their inputs and outputs and intuit the logic needed to produce the same result. @RWeick has done this, and graciously provided schematics for two different boards to solve two different problems:

1. **[Fully open source clone with modern hardware](https://github.com/RWeick/REF1329-N64-Gameshark-Clone)**
    - **This is almost certainly the one you want!**
    - Designed with easily-sourced components
    - No donor parts required
    - 100% compatible with Datel's firmware images
    - The [Sanni Cart Reader](https://github.com/sanni/cartreader/wiki/Reflashing-a-Gameshark) is not yet compatible with the Altera EPM240 chip used in this design, but @RWeick is working on a software update for the Sanni that will add full read/write support
2. [Replacement board for original Datel LZ9FC17 GALs](https://github.com/RWeick/N64-Gameshark-Pro-REF1329)
    - This is a "rescue" board for good (working) LZ9FC17 chips
    - It will ***only*** work with an authentic Datel LZ9FC17 chip (which is no longer being manufactured and can only be found in old GameSharks)
    - If you accidentally fry the main board in a GameShark/AR, but the GAL still works, this PCB can be used as a fully compatible, optimized replacement for the fried OEM board (think of it like transplanting a shark's brain into a robot body)

### N64 GameShark screenshots

_Captured by @CheatoBaggins_

<img alt="Screenshot of the splash screen from an N64 GameShark v1.05 (1997-09-04)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.05-19970904-screenshot-01-splash-screen.png"
     width="200">
<img alt="Screenshot of the splash screen from an N64 GameShark v1.07 (1997-11-07)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.07-19971107-screenshot-01-splash-screen.png"
     width="200">
<img alt="Screenshot of the splash screen from an N64 GameShark v2.50 (xxxx-05-04)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-2.50-xxxx0504-screenshot-01-splash-screen.png"
     width="200">
<img alt="Screenshot of the splash screen from an N64 GameShark Pro v3.00 (1999-04-01)"
     src="/n64/firmware/screenshots/gameshark/n64-gspro-3.00-19990401-screenshot-01-splash-screen.png"
     width="200">

<img alt="Screenshot of the main menu from an N64 GameShark v1.02 (1997-08-01)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.02-19970801-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v1.04 (1997-08-19)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.04-19970819-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v1.05 (1997-09-04)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.05-19970904-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v1.05 (1997-09-05)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.05-19970905-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v1.06 (1997-09-19)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.06-19970919-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v1.07 (1997-11-07)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.07-19971107-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v1.08 (1997-11-24)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.08-19971124-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v1.08 (1997-12-08)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.08-19971208-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v1.09 (1998-01-05)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-1.09-19980105-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v2.00 (1998-03-05)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-2.00-19980305-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v2.00 (1998-04-06)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-2.00-19980406-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v2.10 (1998-08-25)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-2.10-19980825-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v2.21 (1998-12-18)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-2.21-19981218-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark v2.50 (xxxx-05-04)"
     src="/n64/firmware/screenshots/gameshark/n64-gs-2.50-xxxx0504-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark Pro v3.00 (1999-04-01)"
     src="/n64/firmware/screenshots/gameshark/n64-gspro-3.00-19990401-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 GameShark Pro v3.10 (1999-06-09)"
     src="/n64/firmware/screenshots/gameshark/n64-gspro-3.10-19990609-screenshot-02-main-menu.png"
     width="200">

### N64 GameShark firmware

_Dumped by @Parasyte, @RWeick, @CheatoBaggins, and SharkByte_

N64 GameShark "ROMs" contain not just the firmware, but also the user's cheat list and settings, so dumping or reflashing a GameShark will also dump or overwrite the user's codes and preferences.

N64 GameSharks can be dumped (read) and reflashed (written) with a [Sanni Cart Reader](https://github.com/sanni/cartreader/wiki/Reflashing-a-Gameshark). **NOTE:** As of 2023-05-02, the Sanni does _not_ yet support GameShark v1.08 and earlier hardware, which use different EEPROM chips. @RWeick is working on a patch that will fix this problem and allow _all_ GameShark hardware to be read/written.

To view the contents of the ROM dumps, use our [N64 GameShark ROM hexpattern](/hexpats/patterns/imhex-n64-gsrom-pattern.hexpat) for the [ImHex editor](https://imhex.werwolv.net/).

<img src="/n64/firmware/screenshots/gameshark/n64-gs-imhex-pattern-2672x1527.png" width="400" alt="Screenshot of ImHex viewing an N64 GameShark ROM file">

| Filename                                     | Version       | Build timestamp    | #G      | #C       | Clean? |
|:-------------------------------------------- |:------------- |:------------------ | -------:| --------:|:------:|
|    `gs-1.01-xxxxxxxx.bin`[^v1.0x]            | `v1.01`       | _Unknown_          |     ?   |      ?   | ?      |
|   [`gs-1.02-19970801-dirty.bin`]             | `v1.02`       | `1997-08-01T12:50` |    20   |    117   | ❌      |
|    `gs-1.03-xxxxxxxx.bin`[^v1.0x]            | `v1.03`       | _Unknown_          |     ?   |      ?   | ?      |
| ~~[`gs-1.04-19970819-corrupt-codes.bin`][]~~ | `v1.04`       | `1997-08-19T10:35` |   ~~2~~ |    ~~3~~ | ❌      |
|   [`gs-1.04-19970819-valid-codes.bin`][]     | `v1.04`       | `1997-08-19T10:35` |    22   |    142   | ❌      |
|   [`gs-1.05-19970904-dirty.bin`][]           | `v1.05 (Thu)` | `1997-09-04T16:25` |    23   |    133   | ❌      |
|   [`gs-1.05-19970905-dirty.bin`][]           | `v1.05 (Fri)` | `1997-09-05T13:51` |    24   |    146   | ❌      |
|   [`gs-1.06-19970919-dirty.bin`][]           | `v1.06`       | `1997-09-19T14:25` |    21   |     76   | ❌      |
|   [`gs-1.07-19971027-dirty.bin`][]           | `v1.07 (Oct)` | `1997-10-27T17:21` |    28   |    175   | ❌      |
|   [`gs-1.07-19971107-dirty.bin`][]           | `v1.07 (Nov)` | `1997-11-07T10:24` |    27   |    169   | ❌      |
|   [`gs-1.08-19971124-dirty.bin`][]           | `v1.08 (Nov)` | `1997-11-24T11:58` |     7   |     69   | ❌      |
|   [`gs-1.08-19971208-dirty.bin`][]           | `v1.08 (Dec)` | `1997-12-08T11:10` |    20   |    109   | ❌      |
|   [`gs-1.09-19980105-clean.bin`][]           | `v1.09`       | `1998-01-05T17:40` |    36   |    165   | ✅      |
|   [`gs-2.00-19980305-clean.bin`][]           | `v2.00 (Mar)` | `1998-03-05T08:06` |    36   |    165   | ✅      |
|   [`gs-2.00-19980406-clean.bin`][]           | `v2.00 (Apr)` | `1998-04-06T10:05` |    36   |    165   | ✅      |
|   [`gs-2.10-19980825-clean.bin`][]           | `v2.10`       | `1998-08-25T13:57` |    61   |    338   | ✅      |
|    `gs-2.20-xxxxxxxx.bin`[^v2.20]            | `v2.20`       | _Unknown_          |     ?   |      ?   | ?      |
|   [`gs-2.21-19981218-clean.bin`][]           | `v2.21`       | `1998-12-18T12:47` |   106   |    618   | ✅      |
|    `gs-2.40-xxxxxxxx.bin`[^v2.40]            | `v2.40`       | _Unknown_          |     ?   |      ?   | ?      |
|   [`gs-2.50-xxxx0504-v3.3-codes.bin`][]      | `v2.50`       | `????-05-04T12:58` |   188   |   2093   | ⚠️      |
|   [`gspro-3.00-19990401-clean.bin`][]        | `v3.00`       | `1999-04-01T15:05` |   120   |   1124   | ✅      |
|   [`gspro-3.10-19990609-clean.bin`][]        | `v3.10`       | `1999-06-09T16:50` |   120   |   1124   | ✅      |
|   [`gspro-3.20-19990622-clean.bin`][]        | `v3.20`       | `1999-06-22T18:45` |   122   |   1143   | ✅      |
|   [`gspro-3.21-20000104-pristine.bin`][]     | `v3.21`       | `2000-01-04T14:26` |   122   |   1143   | ⭐️      |
|   [`gspro-3.30-20000327-pristine.bin`][]     | `v3.30 (Mar)` | `2000-03-27T09:54` |   188   |   2093   | ⭐️      |
|   [`gspro-3.30-20000404-pristine.bin`][]     | `v3.30 (Apr)` | `2000-04-04T15:56` |   188   |   2093   | ⭐️      |
|   [`perfect_trainer-1.0b-20030618.bin`][]    | `v1.0b`       | `2003-06-18T00:00` |  _N/A_  |   _N/A_  | _N/A_  |

[^v1.0x]: `v1.01` and `v1.03` supposedly exist according to a [Krikzz forum post](https://krikzz.com/forum/index.php?topic=6585.0), [Reddit post](https://www.reddit.com/r/Roms/comments/dui43a/n64_gameshark_v32/), and [vspolaris article](https://vspolaris.tistory.com/24), but we have not yet found any conclusive evidence of a `v1.01` or `v1.03` cart.
[^v2.20]: `v2.20` is [**confirmed** to exist](https://imgur.com/2Sa2NaR), but we have not yet acquired a cart to dump its firmware.
[^v2.40]: `v2.40` supposedly exists according to the official [N64 GameShark Version Compatibility table](https://web.archive.org/web/20010720115238/http://www.gameshark.com/static/about_faq_version_n64.html), but we have not yet found any conclusive evidence of a `v2.40` cart.

[`gs-1.02-19970801-dirty.bin`]:         /n64/firmware/gs-1.02-19970801-dirty.bin
[`gs-1.04-19970819-corrupt-codes.bin`]: /n64/firmware/gs-1.04-19970819-corrupt-codes.bin
[`gs-1.04-19970819-valid-codes.bin`]:   /n64/firmware/gs-1.04-19970819-valid-codes.bin
[`gs-1.05-19970904-dirty.bin`]:         /n64/firmware/gs-1.05-19970904-dirty.bin
[`gs-1.05-19970905-dirty.bin`]:         /n64/firmware/gs-1.05-19970905-dirty.bin
[`gs-1.06-19970919-dirty.bin`]:         /n64/firmware/gs-1.06-19970919-dirty.bin
[`gs-1.07-19971027-dirty.bin`]:         /n64/firmware/gs-1.07-19971027-dirty.bin
[`gs-1.07-19971107-dirty.bin`]:         /n64/firmware/gs-1.07-19971107-dirty.bin
[`gs-1.08-19971124-dirty.bin`]:         /n64/firmware/gs-1.08-19971124-dirty.bin
[`gs-1.08-19971208-dirty.bin`]:         /n64/firmware/gs-1.08-19971208-dirty.bin
[`gs-1.09-19980105-clean.bin`]:         /n64/firmware/gs-1.09-19980105-clean.bin
[`gs-2.00-19980305-clean.bin`]:         /n64/firmware/gs-2.00-19980305-clean.bin
[`gs-2.00-19980406-clean.bin`]:         /n64/firmware/gs-2.00-19980406-clean.bin
[`gs-2.10-19980825-clean.bin`]:         /n64/firmware/gs-2.10-19980825-clean.bin
[`gs-2.21-19981218-clean.bin`]:         /n64/firmware/gs-2.21-19981218-clean.bin
[`gs-2.50-xxxx0504-v3.3-codes.bin`]:    /n64/firmware/gs-2.50-xxxx0504-v3.3-codes.bin
[`gspro-3.00-19990401-clean.bin`]:      /n64/firmware/gspro-3.00-19990401-clean.bin
[`gspro-3.10-19990609-clean.bin`]:      /n64/firmware/gspro-3.10-19990609-clean.bin
[`gspro-3.20-19990622-clean.bin`]:      /n64/firmware/gspro-3.20-19990622-clean.bin
[`gspro-3.21-20000104-pristine.bin`]:   /n64/firmware/gspro-3.21-20000104-pristine.bin
[`gspro-3.30-20000327-pristine.bin`]:   /n64/firmware/gspro-3.30-20000327-pristine.bin
[`gspro-3.30-20000404-pristine.bin`]:   /n64/firmware/gspro-3.30-20000404-pristine.bin
[`perfect_trainer-1.0b-20030618.bin`]:  /n64/firmware/perfect_trainer-1.0b-20030618.bin

### N64 GameShark software

Running in a [Windows 98 SE virtual machine](https://gameshark.fandom.com/wiki/Nintendo_64#Connecting_the_parallel_port_of_an_N64_GameShark_Pro_to_a_modern_PC).

***We recommend using Windows Me if possible. It has the same great software compatibility as Windows 98, but with a much better quality-of-life (e.g., Me has USB support).***

Official Datel N64 Utils `v1.01` (`1999-04-06`), patched by @Parasyte and "Deku Omega" (`2007-04-22`):

<img src="/n64/firmware/screenshots/gameshark/n64-utils-screenshot-03-689x467.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-utils-screenshot-04-689x467.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-utils-screenshot-05-689x467.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-utils-screenshot-06-689x467.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-utils-screenshot-08-689x467.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-utils-screenshot-10-689x467.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-utils-screenshot-11-689x467.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-utils-screenshot-12-689x467.png"
     width="200" alt="">

Game Software Code Creator `v1.10.102` (`2002-01-05`) by Code Master (aka CMX):

<img src="/n64/firmware/screenshots/gameshark/n64-gscc-screenshot-1.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-gscc-screenshot-2.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-gscc-screenshot-3.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-gscc-screenshot-4.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-gscc-screenshot-5.png"
     width="200" alt="">
<img src="/n64/firmware/screenshots/gameshark/n64-gscc-screenshot-6.png"
     width="200" alt="">

GameShark PC link cable tools:

| Tool                                    | Build date   | OSes       | Prereqs               | Authors             |
|:--------------------------------------- |:------------ |:---------- |:--------------------- |:------------------- |
| [Official Datel N64 Utils (original)][] | `2000-03-27` | 98, Me, XP | [`UserPort`][] for XP | Datel               |
| [Official Datel N64 Utils (patched)][]  | `2007-04-22` | 98, Me, XP | [`UserPort`][] for XP | Datel, @Parasyte    |
| [GSCC v1.10.101 (98)][]                 | `2002-01-05` | 98/Me only | -                     | [CMX][]             |
| [GSCC v1.10.101 (XP)][]                 | `2006-04-14` | 98, Me, XP | [`UserPort`][] for XP | [CMX][]             |
| [GSCC v1.10.102 (XP)][]                 | `2007-04-17` | 98, Me, XP | [`UserPort`][] for XP | [CMX][]             |
| [UserPort parallel driver for XP][]     | `2001-05-29` | 2000, XP   | -                     | [Tomas Franzon][]   |
| [N64 Remote Debugger C source code][]   | `2014-08-10` | Linux only | Python, [SCons][]     | [@Parasyte/n64rd][] |

Offline GS ROM and cheat code management tools:

| Tool                                 | Build date   | OSes      | Prereqs        | Authors          |
|:------------------------------------ |:------------ |:--------- |:-------------- |:---------------- |
| [GS ROM decrypter/encrypter][]       | `2001-05-06` | _Any?_    | -              | [CMX][], Hanimar |
| [Skaman's GS ROM tool][]             | `2015-04-11` | _Any?_    | -              | Skaman           |
| [GSCentral Cheat Manager][]          | `2007-02-01` | XP and up | [`.NET 3.5`][] | SK Genius        |

Quality-of-life utilities for Windows 98:

| Tool                              | Build date   | OSes      | Authors                |
|:--------------------------------- |:------------ |:--------- |:---------------------- |
| [HxD hex editor v1.7.7.0 setup][] | `2009-04-03` | 95 and up | [Maël Hörz][]          |
| [MetaPad v3.6 portable][]         | `2011-05-23` | 95 and up | [Alexander Davidson][] |
| [WinRAR v3.71 setup (trial)][]    | `2007-09-21` | 95 and up | RARLAB                 |

[GS ROM decrypter/encrypter]:          /n64/tools/gameshark/n64-gspro-crypt-20010506.zip
[GSCC v1.10.101 (98)]:                 /n64/tools/gameshark/n64-gscc-win98-v1.10.101-20020105.zip
[GSCC v1.10.101 (XP)]:                 /n64/tools/gameshark/n64-gscc-winxp-v1.10.101-20060414.zip
[GSCC v1.10.102 (XP)]:                 /n64/tools/gameshark/n64-gscc-winxp-v1.10.102-20070417.zip
[GSCentral Cheat Manager]:             /n64/tools/gameshark/n64-gscentral-manager-winxp-20070201.zip
[HxD hex editor v1.7.7.0 setup]:       /n64/tools/hxd-v1.7.7.0-setup-win95-20090403.zip
[MetaPad v3.6 portable]:               /n64/tools/metapad-v3.6-portable-win95-20110523.zip
[N64 Remote Debugger C source code]:   /n64/tools/gameshark/n64rd-v0.2.0-src-20140810.zip
[Official Datel N64 Utils (original)]: /n64/tools/gameshark/n64-gspro-datel-utils-original-win98-20000327.zip
[Official Datel N64 Utils (patched)]:  /n64/tools/gameshark/n64-gspro-datel-utils-patched-win98-20070422.zip
[Skaman's GS ROM tool]:                /n64/tools/gameshark/n64-skaman-gsrom-20150411.zip
[UserPort parallel driver for XP]:     /n64/tools/gameshark/n64-parallel-userport-driver-winxp-20010529.zip
[WinRAR v3.71 setup (trial)]:          /n64/tools/winrar-v3.71-setup-win95-20070921.exe

[@Parasyte/n64rd]:    https://github.com/parasyte/n64rd
[`.NET 3.5`]:         https://www.microsoft.com/en-us/download/details.aspx?id=25150
[`UserPort`]:         /n64/tools/gameshark/n64-parallel-userport-driver-winxp-20010529.zip
[Alexander Davidson]: https://liquidninja.com/metapad/download.html
[CMX]:                mailto:cmx@cmgsccc.com
[Maël Hörz]:          https://mh-nexus.de/en/about.php
[Scons]:              https://www.scons.org/
[Tomas Franzon]:      mailto:tomas_franzon@hotmail.com


### N64 GameShark manuals

_Scanned, OCR'd, and transcribed by @CheatoBaggins_

[![N64 GameShark v1.09 manual thumbnail](/n64/manuals/thumbs/gs-v1.09-manual-p1.png)](/n64/manuals/n64_gameshark_v1.09_manual_ocr.pdf)
[![N64 GameShark v2.10 manual thumbnail](/n64/manuals/thumbs/gs-v2.10-manual-p1.png)](/n64/manuals/n64_gameshark_v2.10_manual_ocr.pdf)
[![N64 GameShark v3.20 manual thumbnail](/n64/manuals/thumbs/gs-v3.20-manual-p1.png)](/n64/manuals/n64_gameshark_pro_v3.20_manual_ocr.pdf)
[![N64 GameShark PC Utils manual thumbnail](/n64/manuals/thumbs/gs-utils-manual-p1.png)](/n64/manuals/n64_gameshark_pro_utils_manual_digital.pdf)

The Markdown versions have been transcribed as faithfully to the original printed materials as possible. All typos, misspellings, and odd/inconsistent style choices are intentionally left as-is.

| Plain text transcription                                                        | Searchable flatbed scan                                                   |
|:------------------------------------------------------------------------------- |:------------------------------------------------------------------------- |
| [GameShark v1.09 manual](/n64/manuals/n64_gameshark_v1.09_manual.md)            | [PDF (OCR)](/n64/manuals/n64_gameshark_v1.09_manual_ocr.pdf)              |
| [GameShark v2.0 manual](/n64/manuals/n64_gameshark_v2.00_manual.md)             | [PDF (OCR)](/n64/manuals/n64_gameshark_v2.00_manual_ocr.pdf)              |
| [GameShark v2.1 manual](/n64/manuals/n64_gameshark_v2.10_manual.md)             | [PDF (OCR)](/n64/manuals/n64_gameshark_v2.10_manual_ocr.pdf)              |
| [GameShark v2.2 manual](/n64/manuals/n64_gameshark_v2.20_manual.md)             | [PDF (OCR)](/n64/manuals/n64_gameshark_v2.20_manual_ocr.pdf)              |
| [GameShark Pro v3.0 manual](/n64/manuals/n64_gameshark_pro_v3.00_manual.md)     | [PDF (OCR)](/n64/manuals/n64_gameshark_pro_v3.00_manual_ocr.pdf)          |
| [GameShark Pro v3.1 manual](/n64/manuals/n64_gameshark_pro_v3.10_manual.md)     | [PDF (OCR)](/n64/manuals/n64_gameshark_pro_v3.10_manual_ocr.pdf)          |
| [GameShark Pro v3.2 manual](/n64/manuals/n64_gameshark_pro_v3.20_manual.md)     | [PDF (OCR)](/n64/manuals/n64_gameshark_pro_v3.20_manual_ocr.pdf)          |
|  GameShark Pro v3.3 manual                                                      | [PDF (OCR)](/n64/manuals/n64_gameshark_pro_v3.30_manual_ocr.pdf) - TODO   |
| [GameShark Pro PC Utils manual](/n64/manuals/n64_gameshark_pro_utils_manual.md) | [PDF (original)](/n64/manuals/n64_gameshark_pro_utils_manual_digital.pdf) |

### N64 _How To Hack Like A Pro_ VHS tapes

_Captured and encoded by @CheatoBaggins_

<img alt="Photo of VHS tape"
     src="n64/vhs/n64_gspro_vhs_tape.jpg"
     width="400">

Most versions of the GameShark Pro came with a VHS tape entitled "How To Hack Like A Pro". (To save costs, the final production run of the GameShark Pro v3.3 did _not_ come with a VHS tape.)

The video demonstrates typical usage of the GameShark Pro, as well as the Code Generator feature, which lets you find your own GameShark codes.

There are two known versions of the N64 VHS tape. The informational content is nearly identical, but they contain different advertisements for different InterAct products.

All VHS tapes were captured with the following hardware and software:

- [Sony SLV-N750 VCR](https://www.crutchfield.com/S-ra1VCH8THBI/p_158SLV750S/Sony-SLV-N750.html) with composite A/V output
- [Blackmagic Intensity Pro 4K capture card](https://www.blackmagicdesign.com/products/intensitypro4k) with composite A/V input
- [Blackmagic Media Express (aka Desktop Video)](https://www.blackmagicdesign.com/support/family/capture-and-playback) with NTSC input

#### N64 VHS screenshots

<img alt="How To Hack Like A Pro"
     src="n64/vhs/snapshots/n64_gs_vhs_tape1_snapshot_02-how_to_hack_like_a_pro.png"
     width="200">
<img alt="GameShark guy"
     src="n64/vhs/snapshots/n64_gs_vhs_tape1_snapshot_21-guy.png"
     width="200">
<img alt="Creating Your Own Codes"
     src="n64/vhs/snapshots/n64_gs_vhs_tape1_snapshot_37-creating_your_own_codes.png"
     width="200">
<img alt="Equal To Search"
     src="n64/vhs/snapshots/n64_gs_vhs_tape1_snapshot_45-equal_to_search.png"
     width="200">
<img alt="Active Codes"
     src="n64/vhs/snapshots/n64_gs_vhs_tape1_snapshot_48-active_codes.png"
     width="200">
<img alt="Shark Link"
     src="n64/vhs/snapshots/n64_gs_vhs_tape1_snapshot_73-shark_link.png"
     width="200">
<img alt="Parallel Port"
     src="n64/vhs/snapshots/n64_gs_vhs_tape1_snapshot_74-parallel_port_1.png"
     width="200">
<img alt="Phone Hotline"
     src="n64/vhs/snapshots/n64_gs_vhs_tape1_snapshot_78-phone_hotline.png"
     width="200">

#### N64 VHS tape — version 1

[Watch on YouTube](https://youtu.be/JDmp0huzQvU) • [Audio transcription](/n64/vhs/n64_gspro_vhs_tape1.md)

Runtime: 15 minutes, 2 seconds.

Contains ads for the DexDrive, SuperPad 64, and V3FX Racing Wheel, and has a "Legal Notice" section at the end.

| Size     | Video file         | Compression | Codec            | Resolution/scan    |
| --------:|:------------------ |:----------- |:---------------- |:------------------ |
|  0.92 GB | [Download][dl-1.1] | Lossy       | H.265 (CQ = 75)  | 480p (progressive) |
|  5.47 GB | [Download][dl-1.2] | Lossless    | H.265 (CQ = 100) | 480p (progressive) |
| 19.19 GB | [Download][dl-1.3] | None (raw)  | Raw YUV          | 480i (interlaced)  |

[dl-1.1]: https://storage.googleapis.com/libreshark-dumps-bucket/n64/vhs/n64_gspro_vhs_tape1_480p_h265_cq75.mkv
[dl-1.2]: https://storage.googleapis.com/libreshark-dumps-bucket/n64/vhs/n64_gspro_vhs_tape1_480p_h265_cq100.mkv
[dl-1.3]: https://storage.googleapis.com/libreshark-dumps-bucket/n64/vhs/n64_gspro_vhs_tape1_480i_raw.mov

#### N64 VHS tape — version 2

[Watch on YouTube](https://youtu.be/mOGWxb8kuig) • [Audio transcription](/n64/vhs/n64_gspro_vhs_tape2.md)

Runtime: 14 minutes, 27 seconds.

Contains an ad for TurboRAM, and has a short section about the "Shark Link" (DB-25 parallel printer cable).

| Size     | Video file         | Compression | Codec            | Resolution/scan    |
| --------:|:------------------ |:----------- |:---------------- |:------------------ |
|  0.76 GB | [Download][dl-2.1] | Lossy       | H.265 (CQ = 75)  | 480p (progressive) |
|  4.95 GB | [Download][dl-2.2] | Lossless    | H.265 (CQ = 100) | 480p (progressive) |
| 18.44 GB | [Download][dl-2.3] | None (raw)  | Raw YUV          | 480i (interlaced)  |

[dl-2.1]: https://storage.googleapis.com/libreshark-dumps-bucket/n64/vhs/n64_gspro_vhs_tape2_480p_h265_cq75.mkv
[dl-2.2]: https://storage.googleapis.com/libreshark-dumps-bucket/n64/vhs/n64_gspro_vhs_tape2_480p_h265_cq100.mkv
[dl-2.3]: https://storage.googleapis.com/libreshark-dumps-bucket/n64/vhs/n64_gspro_vhs_tape2_480i_raw.mov

### N64 GameShark repro box art

<a href="/n64/boxes/n64-gameshark-pro-box-front-repro-2356x3465.png"><img src="/n64/boxes/n64-gameshark-pro-box-front-repro-200x294.png" width="200" alt=""></a>
<a href="/n64/boxes/n64-libreshark-box-front-2356x3465.png"><img src="/n64/boxes/n64-libreshark-box-front-200x294.png" width="200" alt=""></a>

The Cover Project has a [simplified, incomplete scan of the v3.3 (neutered) box art](https://www.thecoverproject.net/view.php?game_id=6788).

---

## N64 Action Replay (EU)

<img alt="Screenshot of the splash screen from an N64 Action Replay v1.11"
     src="/n64/firmware/screenshots/action-replay/ar-1.11-screenshot-01-splash-screen.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 Action Replay v1.11"
     src="/n64/firmware/screenshots/action-replay/ar-1.11-screenshot-02-main-menu.png"
     width="200">
<img alt="Screenshot of the splash screen from an N64 Action Replay v3.00"
     src="/n64/firmware/screenshots/action-replay/arpro-3.00-screenshot-01-splash-screen.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 Action Replay v3.00"
     src="/n64/firmware/screenshots/action-replay/arpro-3.00-screenshot-02-main-menu.png"
     width="200">

| Filename                           | Version | Build timestamp    | #G   | #C   | Clean? |
|:---------------------------------- |:------- |:------------------ | ----:| ----:|:------:|
| [`ar-1.11-19980415-dirty.bin`][]   | `v1.11` | `1998-04-15T14:56` |   26 |  258 | ❌      |
| [`arpro-3.0-19990324-dirty.bin`][] | `v3.00` | `1999-03-24T15:50` |   49 |  506 | ❌      |
| [`arpro-3.3-20000418-dirty.bin`][] | `v3.30` | `2000-04-18T16:08` |  181 | 2043 | ❌      |

[`ar-1.11-19980415-dirty.bin`]:   /n64/firmware/ar-1.11-19980415-dirty.bin
[`arpro-3.0-19990324-dirty.bin`]: /n64/firmware/arpro-3.0-19990324-dirty.bin
[`arpro-3.3-20000418-dirty.bin`]: /n64/firmware/arpro-3.3-20000418-dirty.bin

---

## N64 Equalizer (EU)

<img alt="Screenshot of the splash screen from an N64 Equalizer v3.00"
     src="/n64/firmware/screenshots/equalizer/n64-eq-3.00-screenshot-01-splash-screen.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 Equalizer v3.00"
     src="/n64/firmware/screenshots/equalizer/n64-eq-3.00-screenshot-02-main-menu.png"
     width="200">

| Filename                               | Version | Build timestamp    | #G   | #C   | Clean? |
|:-------------------------------------- |:------- |:------------------ | ----:| ----:|:------:|
| [`eq-3.00-19990720-dirty-dump1.bin`][] | `v3.00` | `1999-07-20T09:44` |   59 |  542 | ⚠️      |
| [`eq-3.00-19990720-dirty-dump2.bin`][] | `v3.00` | `1999-07-20T09:44` |   60 |  590 | ❌      |

[`eq-3.00-19990720-dirty-dump1.bin`]: /n64/firmware/eq-3.00-19990720-dirty-dump1.bin
[`eq-3.00-19990720-dirty-dump2.bin`]: /n64/firmware/eq-3.00-19990720-dirty-dump2.bin

---

## N64 Game Buster (DE)

<img alt="Screenshot of the splash screen from an N64 Game Buster v3.21 (1999-08-05"
     src="/n64/firmware/screenshots/game-buster/n64-game-buster-screenshot-01-splash.png"
     width="200">
<img alt="Screenshot of the main menu from an N64 Game Buster v3.21 (1999-08-05)"
     src="/n64/firmware/screenshots/game-buster/n64-game-buster-screenshot-02-main-menu.png"
     width="200">

| Filename                         | Version | Build timestamp    | #G   | #C   | Clean? |
|:-------------------------------- |:------- |:------------------ | ----:| ----:|:------:|
| [`gb-3.21-19990805-dirty.bin`][] | `v3.21` | `1999-08-05T11:09` |   53 |  534 | ❌      |

[`gb-3.21-19990805-dirty.bin`]: /n64/firmware/gb-3.21-19990805-dirty.bin

---

## N64 Xplorer 64 (EU)

<a href="/assets/photos/n64-xplorer64-green-front-3328.png"><img src="/assets/photos/n64-xplorer64-green-front-200.png" alt="Front side of an Xplorer 64 (green label)"></a>
<a href="/assets/photos/n64-xplorer64-orange-front-3328.png"><img src="/assets/photos/n64-xplorer64-orange-front-200.png" alt="Front side of an Xplorer 64 (orange label)"></a>
<a href="/assets/photos/n64-xplorer64-rear-3400x2200.png"><img src="/assets/photos/n64-xplorer64-rear-200.png" alt="Back side of an Xplorer 64"></a>
<a href="/assets/photos/n64-xplorer64-top-3400x1400.png"><img src="/assets/photos/n64-xplorer64-top-200.png" alt="Top side of an Xplorer 64"></a>

### Xplorer 64 PCBs

_Expertly traced in CAD by @RWeick_

<img src="/assets/photos/n64-xplorer64-pcb-clone-1280.png" alt="Xplorer 64 PCB clone" width="200">

- [Xplorer 64 PCB clone](https://github.com/RWeick/FCD-0003.1S-Xplorer64)

### Xplorer 64 screenshots

_Captured by @CheatoBaggins_

#### v1.000E build 1772

Taken from an Xplorer 64 cart with a **green** label:

<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b1834-screenshot-01-main-menu.png"
     alt="Screenshot of the main menu from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b1834-screenshot-02-version-screen.png"
     alt="Screenshot of the Cartridge Info screen from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b1834-screenshot-03-game-list.png"
     alt="Screenshot of the top of the game list from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b1834-screenshot-04-sote-cheats.png"
     alt="Screenshot of cheats for Shadows of the Empire from an N64 Xplorer 64"
     width="200">

#### v1.067E build 2515

Taken from an Xplorer 64 cart with an **orange** label:

<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-screenshot-02-fcd-logo-normal.png"
     alt="Screenshot of the Future Console Design logo from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-screenshot-03-blaze-logo.png"
     alt="Screenshot of the Blaze logo from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-screenshot-04-main-menu.png"
     alt="Screenshot of the main menu from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-screenshot-05-customise.png"
     alt="Screenshot of the 'Customise' screen from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-screenshot-10-version-screen.png"
     alt="Screenshot of the cartridge information screen on an N64 Xplorer 64 v1.067E build 2515"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-screenshot-07-game-list.png"
     alt="Screenshot of the game list from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-screenshot-08-zelda-cheats.png"
     alt="Screenshot of the Zelda OoT cheats from an N64 Xplorer 64"
     width="200">
<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-screenshot-09-mario64-cheats.png"
     alt="Screenshot of the Super Mario 64 from an N64 Xplorer 64"
     width="200">

### Xplorer 64 firmware

_Dumped by @RWeick and @danhans42_

To view the contents of the ROM dumps, use our [Xplorer 64 ROM hexpattern](/hexpats/patterns/imhex-xplorer64-rom-pattern.hexpat) for the [ImHex editor](https://imhex.werwolv.net/).

<img src="/n64/firmware/screenshots/xplorer-64/n64-xplorer64-b2515-imhex-pattern-2672x1527.png" width="400" alt="Screenshot of ImHex viewing an Xplorer 64 ROM file">

| Filename                                             | Version   | Build  | Timestamp                  | Language | #G | #C | Clean? | Unencrypted? |
|:---------------------------------------------------- |:--------- | ------:|:-------------------------- |:-------- | --:| --:|:------:|:------------:|
| [`xp64-v1.000e-b1834-19990816-green.enc`][][^b1834]  | `v1.000E` | `1834` | `1999-08-16T12:10:59+0100` | English  |  ? |  ? | ⚠️      | ❌            |
| [`xp64-v1.067e-b2510-19991123.bin`][][^b2510]        | `v1.067E` | `2510` | `1999-11-23T18:13:18Z`     | English  |  ? |  ? | ⚠️      | ✅            |
| [`xp64-v1.067g-b1930-19991124.bin`][][^b1930]        | `v1.067G` | `1930` | `1999-11-24T14:25:52Z`     | German   |  ? |  ? | ⚠️      | ✅            |
| [`xp64-v1.067e-b2515-20000505-orange.enc`][][^b2515] | `v1.067E` | `2515` | `2000-05-05T23:42:59+0100` | English  |  ? |  ? | ⚠️      | ❌            |

[`xp64-v1.000e-b1834-19990816-green.enc`]:  /n64/firmware/xp64-v1.000e-b1834-19990816-green.enc
[`xp64-v1.067e-b2510-19991123.bin`]:        /n64/firmware/xp64-v1.067e-b2510-19991123.bin
[`xp64-v1.067g-b1930-19991124.bin`]:        /n64/firmware/xp64-v1.067g-b1930-19991124.bin
[`xp64-v1.067e-b2515-20000505-orange.enc`]: /n64/firmware/xp64-v1.067e-b2515-20000505-orange.enc

[^b1834]: Raw **encrypted** firmware dump from a green Xplorer 64 cart.
[^b2510]: Plain **unencrypted** firmware update file from Blaze.
[^b1930]: Plain **unencrypted** firmware update file from Blaze.
[^b2515]: Raw **encrypted** firmware dump from an orange Xplorer 64 cart.

### Xplorer 64 software

- [Official upgrade utility v1.067G (German)](/n64/tools/xplorer64/xp64_1067g.zip)
    - Build date: `2000-05-29`
    - Author: Blaze/FCD
    - Features _(unconfirmed)_:
        - Upgrade Xplorer 64 cartridge firmware
        - Cheat manager
- [Unofficial X-Killer utility v0.60 (English)](/n64/tools/xplorer64/x-killer_v060.zip)
    - Build date: `2000-12-01`
    - Author: Tim Schuerewegen from Belgium
    - Features _(unconfirmed)_:
        - No territory check when upgrading the ROM
        - Ability to encrypt and decrypt ROM files
        - Backup the ROM without having to upgrade it
        - View information about ROM files in ROM Manager (version/date/...)
        - Extract codes from ROM files
        - No restrictions on viewing and downloading memory

#### X-Killer screenshots

<img src="/n64/tools/xplorer64/screenshots/x-killer-01-detected.png"
     width="200" alt="">
<img src="/n64/tools/xplorer64/screenshots/x-killer-02-timeout.png"
     width="200" alt="">
<img src="/n64/tools/xplorer64/screenshots/x-killer-03-locked.png"
     width="200" alt="">
<img src="/n64/tools/xplorer64/screenshots/x-killer-04-n64-menu.png"
     width="200" alt="">
<img src="/n64/tools/xplorer64/screenshots/x-killer-05-warning.png"
     width="200" alt="">
<img src="/n64/tools/xplorer64/screenshots/x-killer-06-encrypted.png"
     width="200" alt="">

### Xplorer 64 manuals

_Scanned, OCR'd, and transcribed by @CheatoBaggins_

- [Xplorer 64 printed manual (`1999-06-21`)](/n64/manuals/xplorer64_19990621_manual.md) • [PDF (OCR)](/n64/manuals/xplorer64_19990621_manual_ocr.pdf)
- [Xplorer 64 online manual](https://web.archive.org/web/20100828090705/http://www.kai666.com/x-plorer_64_manual_index.htm)
    - [Boot modes](https://web.archive.org/web/20170702014101/http://www.kai666.com/important.htm)

---

## N64 GB Hunter (NA)

<a href="/assets/photos/n64-gb-hunter-front-2800x2400.png"><img src="/assets/photos/n64-gb-hunter-front-200.png" width="200" alt=""></a>
<a href="/assets/photos/n64-gb-hunter-rear-3200x2200.png"><img src="/assets/photos/n64-gb-hunter-rear-200.png" width="200" alt=""></a>
<a href="/assets/photos/n64-gb-hunter-top-3400x1200.png"><img src="/assets/photos/n64-gb-hunter-top-200.png" width="200" alt=""></a>

### GB Hunter screenshots

_Captured by @CheatoBaggins_

<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-01-splash-copyright.png"
     alt="Screenshot of the splash screen from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-03-loading.png"
     alt="Screenshot of the loading screen from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-04-warioland2-splash.png"
     alt="Screenshot of the Wario Land II splash screen from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-07-pause-screen.png"
     alt="Screenshot of the pause screen from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-09-main-menu.png"
     alt="Screenshot of the main menu from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-06-warioland2-2coins.png"
     alt="Screenshot of Wario with 2 coins in Wario Land II from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-44-border1.png"
     alt="Screenshot of Wario Land II with a blue gradient border from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-46-border3.png"
     alt="Screenshot of Wario Land II with a rainbow border from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-22-custom-palette.png"
     alt="Screenshot of Wario Land II with a custom palette from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-29-game-list-p01.png"
     alt="Screenshot of the first page of the game list from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-39-game-list-p11.png"
     alt="Screenshot of the 11th page of the game list from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-41-cheat-list-warioland1.png"
     alt="Screenshot of the Wario Land cheat list from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-25-trainer-gt-184.png"
     alt="Screenshot of the trainer with 184 results from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-27-trainer-gt-9.png"
     alt="Screenshot of the trainer with 9 results from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-28-trainer-1-result.png"
     alt="Screenshot of the trainer with 1 result from an N64 GB Hunter"
     width="200">
<img src="/n64/firmware/screenshots/gb-hunter/n64-gbh-screenshot-42-active-cheats.png"
     alt="Screenshot of the active cheat list from an N64 GB Hunter"
     width="200">

### GB Hunter firmware

_Dumped by @RWeick_

| Filename                    | Version   | Build timestamp            | #G | #C | Clean? |
|:--------------------------- |:--------- |:-------------------------- | --:| --:|:------:|
| [`gbh-1998-pristine.bin`][] | _Unknown_ | _Unknown_                  |  ? |  ? | ⭐️      |

[`gbh-1998-pristine.bin`]: /n64/firmware/gbh-1998-pristine.bin

### GB Hunter manual

_Scanned, OCR'd, and transcribed by @CheatoBaggins_

[![N64 GB Hunter manual thumbnail](/n64/manuals/thumbs/gb-hunter-manual-p1.png)](/n64/manuals/n64_gb_hunter_manual_ocr.pdf)

- [GB Hunter manual](/n64/manuals/n64_gb_hunter_manual.md) • [PDF (OCR)](/n64/manuals/n64_gb_hunter_manual_ocr.pdf)

## N64 Game Booster (EU)

Game Booster is the European version of GB Hunter
(or rather, GB Hunter is the American version of the Game Booster.)

Like the GB Hunter, Game Booster supports:

- Super Game Boy-enhanced games
    - Special border graphics
    - Basic color palettes
- Custom color palettes
- Four Datel-designed borders that can be selected by the user
- Preloaded list of GameShark / Action Replay cheats
- Manual cheat code entry
- Trainer for finding new cheat codes

Game Booster ***does not support*** Game Boy Color games.

### Game Booster screenshots

_Captured by @CheatoBaggins_

<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-01-booting.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-02-splash-1.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-04-loading.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-05-sml-border0.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-06-sml-border1.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-07-sml-border2.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-08-sml-border3.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-09-sml-border4.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-10-tetrisdx-splash.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-11-warioland2-splash.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-13-kirby2-splash.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-19-kss-splash.png"
     alt=""
     width="200">

### Hidden game: "Rebound Mission"

The Game Booster contains a built-in Game Boy game, "Rebound Mission", that can be played by starting it up without a Game Boy cartridge plugged in. This game is not present in the GB Hunter.

<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-20-rebound-01-splash.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-21-rebound-02-new-game.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-22-rebound-03-level1-starting.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-23-rebound-04-level1-playing.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-24-rebound-05-level2-starting.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-25-rebound-06-game-over.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-26-rebound-07-continue.png"
     alt=""
     width="200">
<img src="/n64/firmware/screenshots/game-booster/n64-gamebooster-screenshot-27-rebound-08-password.png"
     alt=""
     width="200">

"Continue" passwords (from [GameFAQs](https://gamefaqs.gamespot.com/boards/916387-nintendo-64/80384269)):

```
Level 01: STARTING
Level 02: NEWBIE
Level 03: WARMUP
Level 04: WIDEBOY
Level 05: COFFECUP
Level 06: TEASPOON
Level 07: GLASSJAR
Level 08: GUITARR
Level 09: CAPSLOCK
Level 10: CLOUDS
Level 11: HELPME
Level 12: BIRDNEST
Level 13: PENCIL
Level 14: IMMORTAL
Level 15: GOODLUCK
Level 16: DOORWAY
Level 17: MONITOR
Level 18: PAPER
Level 19: JOYSTICK
Level 20: FEBRUARY
Level 21: CHEMIST
Level 22: ZOOM
Level 23: SNOWBALL
Level 24: NECKLACE
Level 25: CURTAIN
Level 26: PENNY
Level 27: BOOKMARK
Level 28: MACHINES
Level 29: BASEMENT
Level 30: ELEVATOR
Level 31: RADIATOR
Level 32: ICECREAM
Level 33: AIRPLANE
Level 34: WINDOW
Level 35: RECORD
Level 36: PIANO
Level 37: POSTCARD
Level 38: SQUIRREL
Level 39: ELEPHANT
Level 40: DENTIST
Level 41: FERARRI
Level 42: CONTRACT
Level 43: FIREPOST
Level 44: FLAMES
Level 45: SANDWICH
Level 46: POETRY
Level 47: AUTHOR
Level 48: SPEAKERS
Level 49: PIZZAMAN
Level 50: ENDLEVEL
```

More information:

- https://nerdbacon.com/gamebooster/
- https://mamedev.emulab.it/haze/2018/01/28/things-youre-probably-not-going-to-want-to-do-348693/
- https://wiki.gamehacking.org/GB_Hunter

---

## N64 DexDrive

The DexDrive is an N64 memory card reader/writer/backup device that connects to a Windows 98-XP PC with an RS-232 serial cable.

<img src="/assets/photos/n64-dexdrive-hardware-480.png" width="200" alt="DexDrive memory card reader for N64">

### N64 DexDrive software

<a href="/assets/photos/n64-dexdrive-floppy-disk-1of2-2048.png"><img src="/assets/photos/n64-dexdrive-floppy-disk-1of2-256.png" width="200" alt="DexDrive 3.5in floppy disk 1 of 2"></a>
<a href="/assets/photos/n64-dexdrive-floppy-disk-2of2-2048.png"><img src="/assets/photos/n64-dexdrive-floppy-disk-2of2-256.png" width="200" alt="DexDrive 3.5in floppy disk 2 of 2"></a>

DexPlorer v1.10.950:

<img src="n64/firmware/screenshots/dexdrive/v1/dexplorer-v1-screenshot-01-installer.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v1/dexplorer-v1-screenshot-02-main-window.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v1/dexplorer-v1-screenshot-03-about-box.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v1/dexplorer-v1-screenshot-04-backup-file.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v1/dexplorer-v1-screenshot-05-backup-progress.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v1/dexplorer-v1-screenshot-06-backup-view.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v1/dexplorer-v1-screenshot-07-edit-notes.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v1/dexplorer-v1-screenshot-08-restore-prompt.png"
     width="200" alt="">

DexPlorer v2.00.902:

<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-01-installer.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-03-about-box.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-04-config-loading.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-05-config-options.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-06-utilities-menu.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-07-manipulator.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-08-backup-file.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-09-backup-progress.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-10-backup-complete.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-11-edit-note.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-14-internet-list-a.png"
     width="200" alt="">
<img src="n64/firmware/screenshots/dexdrive/v2/dexplorer-v2-screenshot-15-internet-list-s.png"
     width="200" alt="">

DexDrive PC utilities:

| Program                       | Build date   | Author                                   |
|:----------------------------- |:------------ |:---------------------------------------- |
| **[DexPlorer v1.10.950][]**   | `1999-01-05` | Datel/InterAct                           |
|   [DexPlorer v2.00.902][]     | `2000-01-24` | Datel/InterAct                           |
|   [Dex2Save][]                | `1998-02-20` | "Ximeter" <ximeter@usa.net>              |
|   [MemPack Save Converter][]  | `1999-03-28` | "Sound of Silence" <silence@poboxes.com> |
|   [MemPack to N64 Uploader][] | `1999-10-13` | "Destop of Crazy Nation"                 |
|   [64Scener Tools][]          | -            | [64Scener mirror][]                      |

[DexPlorer v1.10.950]:     /n64/tools/dexdrive/n64-dexdrive-sv-388_200.902_at-2000-01-24.zip
[DexPlorer v2.00.902]:     /n64/tools/dexdrive/n64-dexdrive-sv-388_110.950_at-1999-01-05.zip
[Dex2Save]:                /n64/tools/dexdrive/dex2save
[MemPack Save Converter]:  /n64/tools/dexdrive/mempack_save_converter
[MemPack to N64 Uploader]: /n64/tools/dexdrive/mempack_to_n64_uploader
[64Scener Tools]:          /n64/tools/dexdrive/misc
[64Scener mirror]:         http://n64.icequake.net/mirror/64scener.parodius.com

### N64 DexDrive manuals

_Scanned, OCR'd, and transcribed by @CheatoBaggins_

[![N64 DexDrive manual thumbnail](/n64/manuals/thumbs/dexdrive-manual-p2.png)](/n64/manuals/n64_dexdrive_manual_printed_ocr.pdf)

- [DexDrive manual (digital)](/n64/manuals/n64_dexdrive_manual_digital.md) • [PDF (original)](/n64/manuals/n64_dexdrive_manual_digital.pdf)
- [DexDrive manual (printed)](/n64/manuals/n64_dexdrive_manual_printed.md) • [PDF (OCR)](/n64/manuals/n64_dexdrive_manual_printed_ocr.pdf)

### N64 DexDrive box art

_Photographed by @CheatoBaggins_

<a href="/assets/photos/n64-dexdrive-box-8000x4710.png"><img src="/assets/photos/n64-dexdrive-box-600x353.png" width="600" alt=""></a>

---

["Game Boy Cheat Devices - History & Use" on YouTube](https://www.youtube.com/watch?v=NJZ3keMXKH4)

---

## GB GameShark (NA)

For Game Boy (DMG), Game Boy Pocket (GBP), Game Boy Color (GBC), and Game Boy Advance (GBA).

- GameShark for Game Boy Pocket & Color • [PDF (original)](/gb/manuals/gb_gameshark.pdf)

---

## GB Pro Action Replay (EU)

<img alt="Photo of Pro Action Replay"
     src="/gb/photos/52233905-item-big-GB-PROACTIO-A-1.jpg"
     height="200">

[Source](https://www.fullyretro.com/product/game-boy-original-pro-action-replay-cheat-cartridge,52233905) ([Archive](https://web.archive.org/web/20211105072549/https://www.fullyretro.com/product/game-boy-original-pro-action-replay-cheat-cartridge,52233905))

---

## GB Action Replay Professional (EU)

<img alt="Photo of Action Replay Professional"
     src="/gb/photos/45859158-item-big-GB-ACTIONRP-A-1.jpg"
     height="200">

[Source](https://www.fullyretro.com/product/game-boy-original-action-replay-professional-cheat-cartridge,45859158) ([Archive](https://web.archive.org/web/20211121003658/https://www.fullyretro.com/product/game-boy-original-action-replay-professional-cheat-cartridge,45859158))

---

## GBC Action Replay Pro (EU)

<img alt="Photo of Action Replay Pro"
     src="/gb/photos/89319444-item-big-GB-PROACTRY-A-1.jpg"
     height="200">

[Source](https://www.fullyretro.com/product/game-boy-color-action-replay-pro-cheat-cartridge,89319444) ([Archive](https://web.archive.org/web/20211114003955/https://www.fullyretro.com/product/game-boy-color-action-replay-pro-cheat-cartridge,89319444))

---

## GBC Blaze Xploder (EU)

<img alt="Photo of Blaze Xploder"
     src="/gb/photos/79882270-item-big-GB-XPLODERC-A-1.jpg"
     height="200">

[Source](https://www.fullyretro.com/product/game-boy-blaze-xploder-cheat-cartridge,79882270) ([Archive](https://web.archive.org/web/20211119155537/https://www.fullyretro.com/product/game-boy-blaze-xploder-cheat-cartridge,79882270))

Compatible with Game Boy Color and regular Game Boy (DMG) games.

The Xploder GB (aka Xplorer GB) has an in-game trainer (cheat code finder) as well as the ability to transfer cheats and upgrade the firmware over an EXT link cable or infrared (IR).

### GBC Blaze Xploder firmware

_Dumped by @RWeick_

To view the contents of the ROM dumps, use our [Xploder GB ROM hexpattern](/hexpats/patterns/imhex-gbc-xploder-rom-pattern.hexpat) for the [ImHex editor](https://imhex.werwolv.net/).

<img src="/gb/firmware/screenshots/gbc-xploder-imhex-pattern-2672x1527.png" width="400" alt="Screenshot of ImHex viewing an Xploder GB ROM file">

| Filename                                   | Version   | Build timestamp            |  #G |  #C | Clean? |
|:------------------------------------------ |:--------- |:-------------------------- | ---:| ---:|:------:|
| [`gbc-xploder-vX.XX-xxxxxxxx-dirty.bin`][] | _Unknown_ | _Unknown_                  | 210 | 447 | ⚠️      |

[`gbc-xploder-vX.XX-xxxxxxxx-dirty.bin`]: /gb/firmware/gbc-xploder-vX.XX-xxxxxxxx-dirty.bin

EEPROM: `SST29EE020` `PLCC32`

---

## GB Blaze Xploder Lite (EU)

<img alt="Photo of Blaze Xploder Lite"
     src="/gb/photos/15306699-item-big-GB-XPLOLITE-A-1.jpg"
     height="200">

[Source](https://www.fullyretro.com/product/game-boy-blaze-xploder-lite-cheat-cartridge,15306699) ([Archive](https://web.archive.org/web/20211124124624/https://www.fullyretro.com/product/game-boy-blaze-xploder-lite-cheat-cartridge,15306699))

---

## GB Action Replay Xtreme (EU)

<img alt="Photo of Action Replay Xtreme"
     src="/gb/photos/97887158-item-big-GB-ACTRXPOK-A-1.jpg"
     height="200">

> Game Boy Action Replay Xtreme Cheat Cartridge Special Edition - Game Boy
>
> Cheat Cartridge for Game Boy. Includes codes for Pokemon Red, Blue, Yelow, Gold, Silver, Crystal, Pinball and the Trading Card game. In total, the Action Replay Extreme Special Edition has codes for 317 games, with more codes able to be added for other games.

[Source](https://www.fullyretro.com/product/game-boy-action-replay-xtreme-cheat-cartridge-special-edition,97887158) ([Archive](https://web.archive.org/web/20211113065947/https://www.fullyretro.com/product/game-boy-action-replay-xtreme-cheat-cartridge-special-edition,97887158))

---

## GBA Blaze Xploder Advance

<img alt="Photo of Blaze Xploder Advance"
     src="/gb/photos/74818826-item-big-GBA-GBABLAZX-A-1.jpg"
     height="200">

[Source](https://www.fullyretro.com/product/game-boy-advance-blaze-xploder-advance-cheat-cartridge,74818826) ([Archive](https://web.archive.org/web/20170610195644/https://www.fullyretro.com/product/game-boy-advance-blaze-xploder-advance-cheat-cartridge,74818826))

---

## GB Shark MX

_Dumped by @RWeick_

<a href="/assets/photos/gbc-shark-mx-cart-1200x2000.png"><img src="/assets/photos/gbc-shark-mx-cart-200.png" width="200" alt=""></a>
<a href="/assets/photos/gbc-shark-mx-box-front-2574x2944.png"><img src="/assets/photos/gbc-shark-mx-box-front-200.png" width="200" alt=""></a>
<a href="/assets/photos/gbc-shark-mx-box-rear-2574x2944.png"><img src="/assets/photos/gbc-shark-mx-box-rear-200.png" width="200" alt=""></a>

To view the contents of the ROM dumps, use our [GB Shark MX ROM hexpattern](/hexpats/patterns/imhex-gb-shark-mx-rom-pattern.hexpat) for the [ImHex editor](https://imhex.werwolv.net/).

<img src="/gb/firmware/screenshots/gb-shark-mx-imhex-pattern-2672x1527.png" width="400" alt="Screenshot of ImHex viewing a GB Shark MX ROM file">

| Filename                                  | Version | Build date | Flash chip         | Clean? |
|:----------------------------------------- |:------- |:---------- |:------------------ |:------:|
| [`gb-shark-mx-v1.02-2000-pristine.bin`][] | `v1.02` | `2000`     | `SST39SF020PLCC32` | ⭐️ |

[`gb-shark-mx-v1.02-2000-pristine.bin`]: /gb/firmware/gb-shark-mx-v1.02-2000-pristine.bin

From https://gameshark-mx.blogspot.com/:

> **Working Registration Codes:**
>
> - `SHGGGGGGGGGGGGGQ`
> - `WTU69SSN6INIEFNP`
> - `EPR6NNC4XB5YIDND`
> - `ZIQD79DTJG58W875`
> - `S5V5KI686BHFH5HJ`
> - `7K5TBICAGSZSN4U9`

More information:

- [IGN product review (2000-09-14)](https://www.ign.com/articles/2000/09/15/shark-mx)
- [NesDev forum post (2012-11-25)](https://forums.nesdev.org/viewtopic.php?t=9520)
- [Shark MX overview](https://web.archive.org/web/20140416175758/www.bennvenn.com/mx.html)
- [Datel MBC1 chip documentation](https://web.archive.org/web/20140416180028/http://www.bennvenn.com/Datel_MBC1.htm)
- [Re-Programming the Shark MX](https://web.archive.org/web/20140416180029/http://bennvenn.com/Reprogramming_the_Shark_MX.htm)
- [Technical details, chip datasheets, and software](https://web.archive.org/web/20140416175937/http://www.oocities.org/grinara/)

---

## GB Mega Memory Card

For Game Boy and Game Boy Color.

- Mega Memory Card manual • [PDF (original)](/gb/manuals/gb_mega_memory.pdf)

---

## GBA TV Tuners

_Dumped by @RWeick and @felixjones_

<img src="/assets/photos/gba-pelican-tv-tuner-rev1-400.png"
     width="200" alt="">
<img src="/assets/photos/gba-blaze-tv-tuner-bare-533.png"
     width="200" alt="">
<img src="/assets/photos/gba-blaze-tv-tuner-ns-720.png"
     width="200" alt="">

| Filename                                          | Version | Build date | Region      | Flash chip           | Clean? |
|:------------------------------------------------- |:------- |:---------- |:----------- |:-------------------- |:------:|
| [`gba-pelican-tv-tuner-MBM29LV400TCTSOP48.bin`][] | ?       | ?          | NTSC-M (US) | `MBM29LV400TCTSOP48` | ? |
| [`gba-blaze-tv-tuner-tvap-0.7z`]                  | ?       | ?          | PAL-? (EU)  | ?                    | ? |

[`gba-pelican-tv-tuner-MBM29LV400TCTSOP48.bin`]: /gb/firmware/gba-pelican-tv-tuner-MBM29LV400TCTSOP48.bin
[`gba-blaze-tv-tuner-tvap-0.7z`]:                /gb/firmware/gba-blaze-tv-tuner-tvap-0.7z

More information:

- [Pelican TV Tuner article from the Nintendo Fandom wiki](https://nintendo.fandom.com/wiki/Pelican_TV_Tuner)
- [Blaze TV Tuner dump: tweet from @felixjones on Twitter](https://twitter.com/Xilefian/status/1626322091141218306)
- [Blaze TV Tuner dump: file from @felixjones on GitHub](https://gist.github.com/felixjones/ed8fab59b0d3bb08d6f07fa75bcfab47)
- [IGN product review (2002-10-24)](https://www.ign.com/articles/2002/10/24/tv-tuner)
- [YouTube: Playing Nintendo Switch on a Game Boy Advance](https://www.youtube.com/watch?v=IhZrvBU-q9s)

---

## GameCube

### GC device manuals

- Action Replay Max  • [PDF (original)](/gc/manuals/gc_action_replay_max.pdf)
- Action Replay v1.2 • [PDF (original)](/gc/manuals/gc_action_replay_v1.2.pdf)

---

## PlayStation

### PSX device manuals

- Cheats 'N Codes    • [PDF (original)](/psx/manuals/psx_cheats_n_codes.pdf)
- GameShark Pro v3.2 • [PDF (original)](/psx/manuals/psx_gamesharkpro_v3.2.pdf)
- GameShark CDX v3.4 • [PDF (original)](/psx/manuals/psx_gscdx_v3.4.pdf)
- GameShark Lite     • [PDF (original)](/psx/manuals/psx_gslite.pdf)
- SharkLink          • [PDF (original)](/psx/manuals/psx_sharklink.pdf)

---

## Dreamcast

### DC device manuals

- Cheats 'N Codes    • [PDF (original)](/dc/manuals/dc_cheats_n_codes.pdf)
- GameShark CDX v3.3 • [PDF (original)](/dc/manuals/dc_gameshark_cdx_v3.3_oem.pdf) • [PDF (OCR)](/dc/manuals/dc_gameshark_cdx_v3.3_ocr.pdf)

### DC box art

The Cover Project has a [simplified, incomplete scan of the GameShark Lite box art](https://www.thecoverproject.net/view.php?game_id=5609).

---

## PC GameShark (NA)

[GameShark for Windows 95: The PC Game Enhancer - Lazy Game Reviews on YouTube](https://www.youtube.com/watch?v=pQnCdDpU1to)

| Filename                                            | Version | Build date            | Size      |
|:--------------------------------------------------- |:------- |:--------------------- | ---------:|
| [`gameshark-for-windows-v1.10-19981118-full.iso`][] | `v1.10` | `1998-11-18T08:12:18` | 126.2 MiB |
| [`gameshark-for-windows-v3.00-20001023-full.iso`][] | `v3.00` | `2000-10-23T11:41:58` | 108.7 MiB |

[`gameshark-for-windows-v1.10-19981118-full.iso`]: https://storage.googleapis.com/libreshark-dumps-bucket/pc/gameshark/cds/gameshark-for-windows-v1.10-19981118-full.iso
[`gameshark-for-windows-v3.00-20001023-full.iso`]: https://storage.googleapis.com/libreshark-dumps-bucket/pc/gameshark/cds/gameshark-for-windows-v3.00-20001023-full.iso

### GameShark v1.10 for Windows

**Embedded animations:**

![](/pc/gs-win-v1.10/assets/datel_sml.gif)
![](/pc/gs-win-v1.10/assets/Interact_sml.gif)

![](/pc/gs-win-v1.10/assets/Interact.gif)
![](/pc/gs-win-v1.10/assets/shark.gif)

<img src="/pc/gs-win-v1.10/assets/page1.BMP"
     width="200" alt="">
<img src="/pc/gs-win-v1.10/assets/page2.BMP"
     width="200" alt="">
<img src="/pc/gs-win-v1.10/assets/page3.BMP"
     width="200" alt="">
<img src="/pc/gs-win-v1.10/assets/page4-256.bmp"
     width="200" alt="">

**Short videos:**

-   `intro.mpg` <br>
    <a href="https://youtu.be/ZR4WcQL76xs"><img src="/pc/gs-win-v1.10/intro-950x272.png" width="522"></a>
-   `credits.mpg` <br>
    <a href="https://youtu.be/iQGXP2VCm2s"><img src="/pc/gs-win-v1.10/credits-522x212.png" width="522"></a>
-   `about.mpg` <br>
    <a href="https://youtu.be/_yN7M0Fl3pQ"><img src="/pc/gs-win-v1.10/about-522x212.png" width="522"></a>

### GameShark v3.00 for Windows

[Download GameShark v3.00 for Windows setup (slim)](/pc/gs-win-v3.00/gameshark-for-windows-v3.00-20001023-slim.zip) - includes everything from the CD _except_ the 100 MB IE5 installer.

Build date: `2000-10-23T11:41:58`

This version does ***NOT*** require a parallel port dongle.

**Splash screen:**

![Splash screen from GameShark v3.00 for Windows](/pc/gs-win-v3.00/setup.bmp)

**Splash video:**

![Splash video from GameShark v3.00 for Windows](/pc/gs-win-v3.00/gs-win-v3.00-jaws.gif)

[Original MPEG-1 video](/pc/gs-win-v3.00/gs-win-v3.00-jaws.m1v):

- Duration: 11.600 sec
- Video standard: PAL, 25.0 FPS, 4:3, 352x288 (progressive)
- Original filename: `C:\Program Files\Interact\GameShark for Windows\Web\jaws.mpg`
- File size: 1801014 bytes

**Documentation:**

- [QuickStart.doc](/pc/gs-win-v3.00/QuickStart.doc)
- [QuickStart.txt](/pc/gs-win-v3.00/QuickStart.txt)
- [ReadMe.txt](/pc/gs-win-v3.00/ReadMe.txt)

**Screenshots:**

_Captured by @CheatoBaggins_

Setup:

<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-01-setup-01-splash-screen.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-01-setup-04-start-menu.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-01-setup-06-copying-progress.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-01-setup-07-ie5-prompt.png"
     width="200" alt="">

Main UI:

<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-02-ui-01-splash-screen.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-02-ui-02-splash-screen.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-02-ui-03-activex-warning.png"
     width="200" alt="">

<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-02-ui-04-version.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-02-ui-05-games.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-02-ui-06-add-cheat.png"
     width="200" alt="">

Help viewer:

<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-03-help-01-welcome.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-03-help-02-the-games-page.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-03-help-03-the-codes-page.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-03-help-04-the-code-selector.png"
     width="200" alt="">

MP3Shark:

A GameShark-branded fork of the FreeAmp[^freeamp] audio player:

[^freeamp]: FreeAmp was later renamed to [Zinf](https://zinf.org/) due to a [trademark dispute](https://en.wikipedia.org/wiki/Zinf#Naming).

<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-04-mp3shark-00-ui.png"
     width="200" alt="">

<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-04-mp3shark-01-preferences-general.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-04-mp3shark-02-preferences-themes.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-04-mp3shark-03-about.png"
     width="200" alt="">

<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-04-mp3shark-04-download-manager.png"
     width="200" alt="">
<img src="/pc/gs-win-v3.00/screenshots/gs-win-v3.00-04-mp3shark-05-import-wizard.png"
     width="200" alt="">

---

## Logos

_Traced by @CheatoBaggins_

<img src="/assets/logos/interact-logo-rect-3000x843.png" width="300" alt="InterAct logo rectangular">

<img src="/assets/logos/n64-gameshark-pro-logo-blue-2200x1400.png"
     width="300" alt="N64 GameShark logo (blue text)">
<img src="/assets/logos/n64-gameshark-pro-logo-red-2200x1400.png"
     width="300" alt="N64 GameShark logo (red text)">
<a href="/assets/logos/gameshark-logo-gba-4000x3000.png">
    <img src="/assets/logos/gameshark-logo-gba-600x450.png"
         width="300" alt="GameShark logo circa 2003"></a>

---

## Related projects

- [N64brew community](https://n64brew.dev/)
- @Parasyte's [picard - PIC Action Replay Decoder](https://github.com/parasyte/picard)
- @Parasyte's [n64rd - N64 Remote Debugger](https://github.com/parasyte/n64rd)
- @danhans42's [Xplorer 64 resources](https://github.com/danhans42/xplorer64)
- @danhans42's [Xplorer/Xploder control utility](https://github.com/danhans42/xpp_psx)
- Retroactive's [64Drive flash cart](https://64drive.retroactive.be/)
- Krikzz's [EverDrive-64 X7](https://krikzz.com/our-products/cartridges/ed64x7.html)
- [The Cover Project](https://www.thecoverproject.net/view.php?game_id=6788)

## Credits

This project is the result of many years of hard work and brilliant insight from some _amazing_ hackers.
It would not be possible without them!

Most notably, we wish to thank:

- @Parasyte - Legendary GameShark hacker and OG N64 reverse engineer
- @RWeick - Crazy-talented Kaminoan cloner of PCBs

_If you feel that someone is missing from this list, please submit a PR to add them!_ 😀
