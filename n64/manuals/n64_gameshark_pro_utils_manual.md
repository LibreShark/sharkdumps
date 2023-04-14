Nintendo 64 Code Hacking Utilities <br>
-PC Windows 95/98 software for GameShark Pro
============================================

**Document version 1.35 (1st of March 2001)**

This is a free software support package for N64 GameShark Pro owners. This version has the following features:

-	Powerful code finding "Code Generator". This is similar to the GameShark Pro built in "Code Generator" except more powerful as it can utilize the PC’s vast memory when finding codes.
-	Grab screenshots from games. Download the screen from your favorite game and put it on your Windows desktop!
-	New V1.01 - Download your code list to a text file
-	New V1.01 - Upload a text code list to your cartridge.

Please also note that technical support for this product is not available. If you require help in any way please try to contact other enthusiasts in areas like Nintendo 64 GameShark news groups and related web pages.

This software is not compatible with "Equalizer" or other cheat device cartridges.

This software should not be used with illegal copies of the Action Replay or GameShark Pro. These cheap import copies are usually supplied in small boxes, which do not state the name “Datel”，or “InterAct” anywhere. If you attempt to upgrade these with this software they will probably no longer function. To be sure you puchase a genuine Action Replay/GameShark/GameBuster please only buy from official distributors and high street stores.

---

N64 GS Pro Software Set-up
--------------------------

***\*\* This software will NOT work on Windows NT \*\****

If you have a version 3 cartridge (the one with the built in trainer) then follow these instructions for setting up your connection to your PC.

To install the software do the following:

1. Run the “N64_v3_HackingUtils.exe” included on this disc.
2. You will be prompted to specify a folder to extract the files to. (Proceed to step 3.)
3. Be sure that the files are being unzipped to “**C:\\**” and click the **“Unzip”** button.
4. 9 files have been unzipped successfully; now click the “**Close**” button.

If these steps were followed correctly, you should see a shortcut to “N64 Utils.exe” on your desktop.

N64 GS Pro Hardware Set-up
--------------------------

1. Connect the PC to the N64 GameShark using the supplied parallel cable. The cable connects to the back of the **GameShark** and to the **PRINTER PORT** of the PC.
2. Make sure the GameShark is installed in a Nintendo 64.
3. Switch on the Nintendo 64.

---

Using the N64 Utilities Software
--------------------------------

Run the file “N64 Utils.exe” by double clicking the shortcut on your desktop. (The N64 Utils.exe program can also be found in the directory “c:\N64_Utils”)

The software is in the form of a standard Windows dialog box with different features of the product on separate "pages" of the dialog. Each page is explained in this manual.

Connection Problems?
--------------------

When you first switch on the Nintendo 64 and/or PC you may find the software keeps saying "Error: Console did not respond".

Ensure the cable is securely connected to the rear of the N64 GameShark Pro and to the Printer Port of you PC.

---

System Information Tab
----------------------

This is the first page that will be displayed when you run the software. It simply displays information about your PC and the version information of your Nintendo 64 GameShark when you click the "Detect" button.

You do not need to know anything about the information displayed here; it is simply here for anyone who is curious.

---

Code Generator
--------------

This is the PC version of the code generator. It is used in the same way as the built in code generator. Using the PC version has a couple of advantages. Finding "unknown values" like energy bars is much easier as the PC version does this in one pass - it doesn’t have to research each time.

It also has more powerful features like being able to change the size of the data you are searching for. By default you will search for 16 bit numbers, which range from 0 to 65535. However, you will find values like money are usually 32 bit numbers. To search for 32-bit number simply click the "32 bit" radio button and start a search.

The "Hex" tick button allows you to see and enter values in hexadecimal. This feature is for advanced users only; you do not need to know how to use this, but it helps to understand the numerical values used by the GameShark.

The "search history" window lists what you did during the search.

To start a search you can use the "Start", "Equal to" or "In Range" buttons. If you know the value you are searching for (like 6 lives) then use the "Equal to" option. If you don’t know the value (say an energy bar) then use the "Start Search" button.

The "resume last" button is for resuming a search you were doing before. If you quit a search half way through or quit the N64 Utilities program by mistake, you can use this button to resume the search where you left off.

The process of finding codes is the same as in the built in code generator. To remind yourself how to find codes, have a look at the GameShark Pro’s manual.

---

Results (Code Tester)
---------------------

This is the equivalent to the "View results" menu in the built in code generator.

This version is of course much more powerful. Multiple codes can be in the active codes list and these can also be turned on and off.

The "resume" feature also works with this section. When you click the resume button, any codes you had on when you last used the results features will be restored to the active codes list.

To copy a possibility to the active codes list simply highlight the address part of the code in the possibilities list (click it with the mouse). Then you can either click "Copy to active (on)" or "Copy to active (off)", these buttons will copy all highlighted codes to the active codes list. If you clicked the "(on)" version of the button then the codes will be on straight away, otherwise they will be off.

The buttons inside the "Active Codes" area of the dialog can be used to turn on, turn off, delete and select the codes in the active codes list.

---

Code List
---------

This page contains code list related utilities. There utilities allow you to maintain your code list on your PC and upload it to your cartridge when you like. This means you can type in codes on your PC or even download your code list and send it to a friend on the Internet.

The page is split into three separate sections "Code List Compile", "Upload Codes to Cartridge" and "Download Codes from Cartridge".

The first thing you should do is to download your code list from your cartridge.

### _Download Codes from Cartridge_

Use the "Download Codes from Cartridge" section to download your code list to a file on your PC. Firstly you will need to specify a filename in the edit box titled "Destination file for code list", type in a filename like "mycodes.txt". Then make sure the GameShark is in the main menu and click the "Download codes" button. The codes are downloaded and saved to the file you specified. Open your codes file with Wordpad or a similar text editor and you will see the code list as text.

You can edit the code list and add or remove codes as you wish. The process of editing this list is explained on the next page.

### _Code List Compiler_

This utility will check your code list for errors before sending it to the GameShark. You must "compile" your code list before you can send it back to the GameShark. To see this work, simply click the "browse" button and select the codes file you downloaded with the "Download Codes" button. Now click the "Compile Codes" button and you should find the list compiles with no errors.

**A sample code list created on 1/25/01 has been supplied. “N64.txt”**

### _Upload Codes to Cartridge_

Once you have compiled your code list with the "Compile Codes" button, you can upload them back to the GameShark and replace its code list. To do this, simply click the "Upload Codes" button.

**A sample upload code list created on 1/25/01 has been supplied. “N64.bin”**

---

Editing a Code List Text File
-----------------------------

Download your current code list with the "Download Codes from Cartridge" utility and have a look at the file with a normal text editor like "Wordpad.exe". The file may look a bit strange but you will clearly see the basic format of a code list file. It consists of lines, which start with the character ‘;’, line which are titles for games, followed by titles for the codes and number for the codes themselves. At the end of each game you will see a ".end" - this marks the end of the codes for that game and a new game title will follow.

It is quite easy to add new game titles and codes. Here I will explain how to do this by means of an example. In this example we will add a new game title and a couple of codes to your code list.

We will add our game at the very bottom of the file, after the last line which reads ".end".

Type the games name in quotation marks like so:

```
"my game"
```

Following the name you need it’s codes. Codes are made up of the code name (again in quotes). E.g:

```
"code name 1"
```

After the codes name you can have any number of code parameters (code parameters are made up of an 8 digit hexadecimal number, then a space ‘ ‘ character, then a 4 digit hexadecimal number).

```
8001a630 0163
```

You must now end the game entry with the text ".end".

```
.end
```

---

The finished game entry with it’s single code should now look like this :-

```
"my game"

"code name 1"
8001a630 0163

.end
```

If you have more than one code parameter to follow a code’s name simply put it after the first code parameter. E.g.

```
"my game"

"code name 1"
8001a630 0163
8001a632 0163

.end
```

If you have more than one code for the game then simply put it after the first code. E.g.

```
"my game"

"code name 1"
8001a630 0163
8001a632 0163

"code name 2"
8001a928 0009

. end
```

---

### _Comments_

You can also put comments in the file. Comments are lines, which are ignored by the compiler. They are useful for adding ‘line breaks’ between games or simply putting comments in with your game lists.

A comment line must start with a ‘;’ or ‘#’ character.

Example :-

```
;--------------------------------------
; I added this on 27/8/96

"my 1st game"

"code name 1"
8001a630 0163
8001a632 0163

"code name 2"
8001a928 0009

.end
;--------------------------------------
```

### _Codes Which Default to ON or OFF_

As in the cartridge "edit code" function you can make codes default to being ON or OFF in the list when you first look at them. By default the codes in the list are ON. You can make individual codes default to off by putting the text ".off" after the codes name. e.g. The code named "code name 2" in the example below will default to OFF :-

```
"my 1st game"

"code name 1"
8001a630 0163
8001a632 0163

"code name 2" .off
8001a928 0009

. end
```

---

### _Stopping at a Point in the File_


You can end the code file generation process at any point in your list as long as it is after the end of a game entry (not in the middle of an entry). To do this simply insert the text ".stop". For example, the file below would result in the game "my 1st game" being in the list but not the game "my 2nd game" as there is a ".stop" command before this game:-

```
#--------------------------------------
# I added this on 27/8/96

"my 1st game"
"code name 1"
8001a630 0163

.end

. stop

#--------------------------------------
# I added this on 27/8/96

"my 2nd game"

"code name 1"
8004a500 0172

.end
#--------------------------------------
```

***And that’s it!***

You now know all there is to know about editing your code list, simple isn’t it?

All you need to do now is compile the code list file and then upload it to the GameShark.

---

Other Utilities
---------------

### Grab Video Image

You can take a copy of the Nintendo 64 screen and save it as a BMP image file on your PC.

The image grabbed will be the image that was last on screen when you pressed the N64’s reset button. So, to grab a screen shot of you favorite game simply load the game and when you see the screen you want, press the reset button.

When the GameShark main menu appears you can use the "Grab Video Image" button to download the image and save it to a "BMP" file on your PC.

Note that the option "16 bit image" is selected as default. If you are grabbing an image from in a game then this is the correct option to use when grabbing the image. If you pressed reset when an FMV movie sequence (intro) was displayed then you will need to click the "24 bit colour" option before grabbing the image.

### Cartridge Upgrade

This option will upgrade your cartridge to the latest version of the software. If you use the "Detect" option from the "System Information" page and it tells you to upgrade, then you will need to use this option.

If the "detect" option didn’t tell you to upgrade, then there is no need to upgrade your cartridge.

Before you upgrade, it is a good idea to download your existing codes list to a text file on your PC. You can do this using the tools in the "code list" tab.

**NOTE**: When you upgrade make sure the "Overwrite Code List and Settings" option is not ticked. This will make sure that the code list and settings are not overwritten. The option "Overwrite Code List and Settings" will be untagged by default. If you tag this option and then upgrade you will lose all your settings (like which background you had selected) and the code list will be overwritten with the default code list. There is no need to tag this option unless for some reason you have deleted codes and want to replace them. This will however delete any codes you inputted into the cartridge yourself.

---

Grab Ram
--------

This feature allows you to take a snapshot of the N64's memory and save it to a file on your PC's hard disk. You can also put this file back into the Nintendo 64s memory.

This feature is intended for advanced hackers who wish to modify memory themselves. Various tools are available from the Internet like hex editors and R3000 dissasemblers to help you look at these memory dumps.

If used unwisely downloading and then uploading the memory will probably halt the Nintendo 64. You will then have to reset the Nintendo 64 to continue.

Tip: For best results, pause the game, then download the memory and edit it all you like. Then upload the memory back and un-pause.

**Remember**: This feature is for advanced hackers only, and any damage that may result from the use of this feature is solely the responsibility of the user. NEITHER InterAct nor Datel support these utilities.

For more information about hacking your own codes, visit www.gameshark.com and check out the “Hacking Tips”!

URL to hacking tips as of 1/20/01:
http://www.gameshark.com/search/searchresults_art.jsp?Author=220&column=1
