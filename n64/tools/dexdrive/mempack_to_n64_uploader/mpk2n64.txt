                        MEMPACK to N64 uploader DOX

                                     by
                                   Destop
                                     of
                                Crazy Nation


        This is a utility for v64/v64jr owners who want to be able to
use mempack files (*.mpk/*.bin) on their backup unit.

Here is how to use it:

        Included is a batch file that 'MERGES' the mempack file onto the
rom image(mpk2n64.bat), all it does is place the file onto the correct offset
in the file. Be sure its an actual mempack file (32768 bytes!!), if its not
then the the rom image will be corrupted and will need to be deleted.
Look at the batch file to suit your needs as far as what utility you want to
send the rom (and CRC fix) to your N64.

                On screen you will see:
                      Note
[file number] [note description]  [game/co codes] [note size in HEX]
.
.
.
                 MEMpack File
[file number] [note description]  [game/co codes] [note size in HEX]


1. Select what file you want to upload by moving the up/down C buttons

2. Press START to upload the file

3. If you get an error message like 'PFS_FULL' and you want to make 'room'
   on your mempack use the directional PAD to move the green cursor
   to what file you want to delete and press Z


Some mempack files contain eeprom saves (aka SRAM) and if you want to upload
it directly to the cartridge then press A.
Note that these save files are 512 bytes in size (200 in hex).

-------------------------------------------------------------------------------
version 1.0

Theres still a lot i want to do with this utility like:
full mempack manager (copy files between 2 mempacks)
hex file editor
save 'sram' to mempack
AND
dexdrive file uploader - the beta versions of this utility actually was
only designed to upload dexdrive files but I noticed that there are some
dexdrive saves that are different from others so when I totally understand
that format then i will make a util to convert them to raw mempack saves.

DATE:
OCT 13-99

