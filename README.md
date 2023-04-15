# SharkDumps

Collection of all known firmware/ROM/software dumps for retro video game enhancers (GameShark, Action Replay, Code Breaker, etc.).

![Dump truck icon](/assets/icons/dump-truck-256.png)

## Legend

"Pristine" dumps are bit-for-bit identical to the original OEM factory firmware images, without any user modifications.

"Dirty" dumps may contain different games, cheats, and/or user preferences than the devices originally shipped with, but the actual firmware code should still be 100% original.

- __#G__ = Number of **G**ames pre-loaded
- __#C__ = Number of **C**heats pre-loaded
- __Pris?__ = Pristine OEM game/cheat list and settings
    - ✅ = Confirmed **Pristine**. All cheats and settings are identical to their original factory defaults.
    - ❌ = Confirmed **Dirty**. The owner of the cartridge modified some of the games, cheats, or preferences on the cart, so they no longer match the factory defaults.
    - ⚠️ = Provenance **Unknown**. We have not yet confirmed whether the games, cheats, and preferences are original or user-modified.

## N64

![GameShark v2.x front photo](/assets/photos/gs2x-front-512.png) ![GameShark v2.x rear photo](/assets/photos/gs2x-rear-512.png)

### N64 device firmware

N64 GameShark "ROMs" contain the firmware, cheat list, _and_ user preferences, so dumping or reflashing a GameShark will also dump/overwrite the user's cheat list and settings as well.

#### N64 GameShark (US)

| Filename                                 | Version       | Build timestamp    | #G      | #C       | Pris? |
|:---------------------------------------- |:------------- |:------------------ | -------:| --------:|:-----:|
|    `gs-1.02-xxxxxxxx.bin`                | `v1.02`       | _Unknown_          |     ?   |      ?   | ⚠️     |
|   [`gs-1.04-19970819.bin`][]             | `v1.04`       | `1997-08-19T10:35` |    22   |    142   | ⚠️     |
|   [`gs-1.05-19970904.bin`][]             | `v1.05`       | `1997-09-04T16:25` |    23   |    133   | ⚠️     |
|   [`gs-1.06-19970919.bin`][]             | `v1.06`       | `1997-09-19T14:25` |    21   |     76   | ⚠️     |
|   [`gs-1.07-19971107.bin`][]             | `v1.07`       | `1997-11-07T10:24` |    27   |    169   | ⚠️     |
|   [`gs-1.08-19971124.bin`][]             | `v1.08 (Nov)` | `1997-11-24T11:58` |     7   |     69   | ⚠️     |
|   [`gs-1.08-19971208.bin`][]             | `v1.08 (Dec)` | `1997-12-08T11:10` |    20   |    109   | ⚠️     |
|   [`gs-1.09-19980105-dump1.bin`][]       | `v1.09`       | `1998-01-05T17:40` |    37   |    166   | ⚠️     |
|   [`gs-1.09-19980105-dump2.bin`][]       | `v1.09`       | `1998-01-05T17:40` |    39   |    189   | ⚠️     |
|   [`gs-1.09-19980105-dump3.bin`][]       | `v1.09`       | `1998-01-05T17:40` |    36   |    171   | ⚠️     |
|   [`gs-2.00-19980305-dump1.bin`][]       | `v2.00 (Mar)` | `1998-03-05T08:06` |    36   |    165   | ⚠️     |
|   [`gs-2.00-19980305-dump2.bin`][]       | `v2.00 (Mar)` | `1998-03-05T08:06` |    38   |    165   | ⚠️     |
|   [`gs-2.00-19980305-dump3.bin`][]       | `v2.00 (Mar)` | `1998-03-05T08:06` |    36   |    168   | ⚠️     |
|   [`gs-2.00-19980406.bin`][]             | `v2.00 (Apr)` | `1998-04-06T10:05` |    36   |    165   | ⚠️     |
|   [`gs-2.10-19980825-dump1.bin`][]       | `v2.10`       | `1998-08-25T13:57` |    61   |    338   | ⚠️     |
|   [`gs-2.10-19980825-dump2.bin`][]       | `v2.10`       | `1998-08-25T13:57` |    61   |    348   | ⚠️     |
|    `gs-2.20-xxxxxxxx.bin`                | `v2.20`       | _Unknown_          |     ?   |      ?   | ?     |
|   [`gs-2.21-19981218-dump1.bin`][]       | `v2.21`       | `1998-12-18T12:47` |   106   |    618   | ⚠️     |
|   [`gs-2.21-19981218-dump2.bin`][]       | `v2.21`       | `1998-12-18T12:47` |   112   |    675   | ⚠️     |
|   [`gs-2.21-19981218-dump3.bin`][]       | `v2.21`       | `1998-12-18T12:47` |   106   |    621   | ⚠️     |
|    `gs-2.40-xxxxxxxx.bin`                | `v2.40`       | _Unknown_          |     ?   |      ?   | ?     |
|   [`gs-2.50-xxxx0504-bricked.bin`][]     | `v2.50`       | `????-05-04T12:58` |     ?   |      ?   | ❌     |
|   [`gs-2.50-xxxx0504-patched.bin`][]     | `v2.50`       | `????-05-04T12:58` |     ?   |      ?   | ❌     |
|   [`gspro-3.00-19990401.bin`][]          | `v3.00`       | `1999-04-01T15:05` |   120   |   1125   | ⚠️     |
|   [`gspro-3.10-19990609-dump1.bin`][]    | `v3.10`       | `1999-06-09T16:50` |   120   |   1124   | ⚠️     |
|   [`gspro-3.10-19990609-dump2.bin`][]    | `v3.10`       | `1999-06-09T16:50` |   120   |   1124   | ⚠️     |
| ~~[`gspro-3.20-19990622-dirty1.bin`][]~~ | `v3.20`       | `1999-06-22T18:45` | ~~123~~ | ~~1146~~ | ❌     |
| ~~[`gspro-3.20-19990622-dirty2.bin`][]~~ | `v3.20`       | `1999-06-22T18:45` | ~~126~~ | ~~1163~~ | ❌     |
|   [`gspro-3.20-19990622-pristine.bin`][] | `v3.20`       | `1999-06-22T18:45` |   125   |   1192   | ✅     |
|   [`gspro-3.21-20000104-pristine.bin`][] | `v3.21`       | `2000-01-04T14:26` |   122   |   1143   | ✅     |
|   [`gspro-3.30-20000327-pristine.bin`][] | `v3.30 (Mar)` | `2000-03-27T09:54` |   188   |   2093   | ✅     |
|   [`gspro-3.30-20000404-pristine.bin`][] | `v3.30 (Apr)` | `2000-04-04T15:56` |   188   |   2093   | ✅     |

#### N64 Action Replay (EU)

| Filename                     | Version | Build timestamp    | #G   | #C   | Pris? |
|:---------------------------- |:------- |:------------------ | ----:| ----:|:-----:|
| [`ar-1.11-19980415.bin`][]   | `v1.11` | `1998-04-15T14:56` |   26 |  258 | ⚠️     |
| [`arpro-3.0-19990324.bin`][] | `v3.00` | `1999-03-24T15:50` |   49 |  506 | ⚠️     |
| [`arpro-3.3-20000418.bin`][] | `v3.30` | `2000-04-18T16:08` |  181 | 2043 | ⚠️     |

#### N64 trainers

| Filename                                | Version | Build timestamp    |
|:--------------------------------------- |:------- |:------------------ |
| [`perfect_trainer-1.0b-20030618.bin`][] | `v1.0b` | `2003-06-18T00:00` |

[`ar-1.11-19980415.bin`]:              /n64/firmware/ar-1.11-19980415.bin
[`arpro-3.0-19990324.bin`]:            /n64/firmware/arpro-3.0-19990324.bin
[`arpro-3.3-20000418.bin`]:            /n64/firmware/arpro-3.3-20000418.bin
[`gs-1.04-19970819.bin`]:              /n64/firmware/gs-1.04-19970819.bin
[`gs-1.05-19970904.bin`]:              /n64/firmware/gs-1.05-19970904.bin
[`gs-1.06-19970919.bin`]:              /n64/firmware/gs-1.06-19970919.bin
[`gs-1.07-19971107.bin`]:              /n64/firmware/gs-1.07-19971107.bin
[`gs-1.08-19971124.bin`]:              /n64/firmware/gs-1.08-19971124.bin
[`gs-1.08-19971208.bin`]:              /n64/firmware/gs-1.08-19971208.bin
[`gs-1.09-19980105-dump1.bin`]:        /n64/firmware/gs-1.09-19980105-dump1.bin
[`gs-1.09-19980105-dump2.bin`]:        /n64/firmware/gs-1.09-19980105-dump2.bin
[`gs-1.09-19980105-dump3.bin`]:        /n64/firmware/gs-1.09-19980105-dump3.bin
[`gs-2.00-19980305-dump1.bin`]:        /n64/firmware/gs-2.00-19980305-dump1.bin
[`gs-2.00-19980305-dump2.bin`]:        /n64/firmware/gs-2.00-19980305-dump2.bin
[`gs-2.00-19980305-dump3.bin`]:        /n64/firmware/gs-2.00-19980305-dump3.bin
[`gs-2.00-19980406.bin`]:              /n64/firmware/gs-2.00-19980406.bin
[`gs-2.10-19980825-dump1.bin`]:        /n64/firmware/gs-2.10-19980825-dump1.bin
[`gs-2.10-19980825-dump2.bin`]:        /n64/firmware/gs-2.10-19980825-dump2.bin
[`gs-2.21-19981218-dump1.bin`]:        /n64/firmware/gs-2.21-19981218-dump1.bin
[`gs-2.21-19981218-dump2.bin`]:        /n64/firmware/gs-2.21-19981218-dump2.bin
[`gs-2.21-19981218-dump3.bin`]:        /n64/firmware/gs-2.21-19981218-dump3.bin
[`gs-2.50-xxxx0504-bricked.bin`]:      /n64/firmware/gs-2.50-xxxx0504-bricked.bin
[`gs-2.50-xxxx0504-patched.bin`]:      /n64/firmware/gs-2.50-xxxx0504-patched.bin
[`gspro-3.00-19990401.bin`]:           /n64/firmware/gspro-3.00-19990401.bin
[`gspro-3.10-19990609-dump1.bin`]:     /n64/firmware/gspro-3.10-19990609-dump1.bin
[`gspro-3.10-19990609-dump2.bin`]:     /n64/firmware/gspro-3.10-19990609-dump2.bin
[`gspro-3.20-19990622-dirty1.bin`]:    /n64/firmware/gspro-3.20-19990622-dirty1.bin
[`gspro-3.20-19990622-dirty2.bin`]:    /n64/firmware/gspro-3.20-19990622-dirty2.bin
[`gspro-3.20-19990622-pristine.bin`]:  /n64/firmware/gspro-3.20-19990622-pristine.bin
[`gspro-3.21-20000104-pristine.bin`]:  /n64/firmware/gspro-3.21-20000104-pristine.bin
[`gspro-3.30-20000327-pristine.bin`]:  /n64/firmware/gspro-3.30-20000327-pristine.bin
[`gspro-3.30-20000404-pristine.bin`]:  /n64/firmware/gspro-3.30-20000404-pristine.bin
[`perfect_trainer-1.0b-20030618.bin`]: /n64/firmware/perfect_trainer-1.0b-20030618.bin

### N64 device manuals

The Markdown versions have been transcribed as faithfully to the original printed materials as possible. All typos, misspellings, and odd/inconsistent style choices are intentionally left as-is.

- [DexDrive manual (digital)](/n64/manuals/n64_dexdrive_manual_digital.md)        • [PDF (original)](/n64/manuals/n64_dexdrive_manual_digital.pdf)
- [DexDrive manual (printed)](/n64/manuals/n64_dexdrive_manual_printed.md)        • [PDF (OCR)](/n64/manuals/n64_dexdrive_manual_printed_ocr.pdf)
- [GB Hunter manual](/n64/manuals/n64_gb_hunter_manual.md)                        • [PDF (OCR)](/n64/manuals/n64_gb_hunter_manual_ocr.pdf)
- [GameShark v1.09 manual](/n64/manuals/n64_gameshark_v1.09_manual.md)            • [PDF (OCR)](/n64/manuals/n64_gameshark_v1.09_manual_ocr.pdf)
- [GameShark v2.0 manual](/n64/manuals/n64_gameshark_v2.00_manual.md)             • [PDF (OCR)](/n64/manuals/n64_gameshark_v2.00_manual_ocr.pdf)
- [GameShark v2.1 manual](/n64/manuals/n64_gameshark_v2.10_manual.md)             • [PDF (OCR)](/n64/manuals/n64_gameshark_v2.10_manual_ocr.pdf)
- [GameShark v2.2 manual](/n64/manuals/n64_gameshark_v2.20_manual.md)             • [PDF (OCR)](/n64/manuals/n64_gameshark_v2.20_manual_ocr.pdf)
- [GameShark Pro v3.0 manual](/n64/manuals/n64_gameshark_pro_v3.00_manual.md)     • [PDF (OCR)](/n64/manuals/n64_gameshark_pro_v3.00_manual_ocr.pdf)
-  GameShark Pro v3.1 manual                                                      •  PDF (OCR) - TODO
-  GameShark Pro v3.2 manual                                                      • [PDF (OCR)](/n64/manuals/n64_gameshark_pro_v3.20_manual_ocr.pdf) - TODO
-  GameShark Pro v3.3 manual                                                      • [PDF (OCR)](/n64/manuals/n64_gameshark_pro_v3.30_manual_ocr.pdf) - TODO
- [GameShark Pro PC Utils manual](/n64/manuals/n64_gameshark_pro_utils_manual.md) • [PDF (original)](/n64/manuals/n64_gameshark_pro_utils_manual_digital.pdf)
- [Xplorer64 manual 1999-06-21](/n64/manuals/xplorer64_19990621_manual.md)        • [PDF (OCR)](/n64/manuals/xplorer64_19990621_manual_ocr.pdf)
