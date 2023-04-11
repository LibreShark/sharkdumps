/*************************************************************************
*Renegade / Renegade 64 (VB6+C Combo App)
*
*Copyright notice for this file:
*Copyright (C) 2006 Viper187 / Psycho Snake Creations
*
*This program is free software: you can redistribute it and/or modify
*it under the terms of the GNU General Public License as published by
*the Free Software Foundation, either version 2 of the License, or
*(at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program.  If not, see <http://www.gnu.org/licenses/>.
**************************************************************************/
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "types.h"
#include "globals.h"

s32 __declspec(dllexport) CALLBACK WriteDis(BSTR disfile, BSTR disout, char fileformat, char outformat, char addyopt, 
char alignment, u32 dStart, u32 dEnd)
{
    FILE *dFile;
    u32 addy=0;
    int errnum=0;
    char distext[128];
    NewFile = (LPSTR)disfile;
    OldFile = (LPSTR)disout;
    filefmt = fileformat;
    stype = outformat;
    iotype = addyopt;
    iosize = alignment;
    if (DisData) { free(DisData); DisData = 0; }
    errnum = loadfile(&DisData,NewFile,header);
    if (errnum != 0) {
        if (DisData) { free(DisData); DisData = 0; }
        return errnum;
    }    
    dFile = fopen(OldFile,"wt");
    if (!(dFile)) {
        if (DisData) { free(DisData); DisData = 0; }
        return 2;
    }
    dStart = dStart & 0xFFFFFFFC;
    dEnd = dEnd & 0xFFFFFFFC;
    if (dStart < 0) { dStart = 0; }
    if ((dEnd <= 0) || (dEnd > filesize)) { dEnd = filesize; }
    for (addy = dStart; addy < dEnd; addy += 4) {
        distext[0] = 0;
        if (!(DisN64(getdataxt(DisData,addy,4),distext,addy))) {
            if (iotype == 1) fprintf(dFile,"%08X: %s\n",addy,distext);
            else if (iotype == 2) fprintf(dFile,"%08X: %08X %s\n",addy,getdataxt(DisData,addy,4),distext);
            else if (iotype == 3) fprintf(dFile,"%08X %s\n",getdataxt(DisData,addy,4),distext);
            else fprintf(dFile,"%s\n",distext);
        }        
        else {
            if (iotype == 1) fprintf(dFile,"%08X: ? (%08X)\n",addy,getdataxt(DisData,addy,4));
            else if (iotype == 2) fprintf(dFile,"%08X: %08X\n",addy,getdataxt(DisData,addy,4));
            else if (iotype == 3) fprintf(dFile,"%08X ?\n",getdataxt(DisData,addy,4));
            else fprintf(dFile,"? (%08X)\n",getdataxt(DisData,addy,4));
        }    
    }
    fclose(dFile);
    if (DisData) { free(DisData); DisData = 0; }
    return 0;
}
s32 __declspec(dllexport) CALLBACK SearchROM(BSTR romfile, BSTR resout, char fileformat, char rstype, u32 Value1, u32 Value2)
{
    FILE *resFile;
    u32 addy;
    u32 tmpaddy;
    u32 val1;
    u32 val2;
    int errnum=0;
    int i;
    u32 OParray[30];
//    char distext[128];
//    LPSTR opcode = (LPSTR)searchop;
//    LPSTR tmpop;
    rescount = 0;
    filefmt = fileformat;
    if (DisData) { free(DisData); DisData = 0; }
    errnum = loadfile(&DisData,(LPSTR)romfile,0);
    if (errnum != 0) {
        if (DisData) { free(DisData); DisData = 0; }
        return errnum;
    }
//    if (!(Results = (unsigned char*)malloc(filesize / 4 / 8))) { FreeShit(); return 1; }
//    memset(Results,255,(filesize / ioinc / 8));
    resFile = fopen((LPSTR)resout,"wb");
    if (!(resFile)) {
        if (DisData) { free(DisData); DisData = 0; }
        return 2;
    }
    fseek(resFile,4,SEEK_SET);
    switch (rstype) {
        case 0:
//            if ((Value1 & 0xFFFF) > 0x7FFF) { Value1 += 0x1000; }
            break;
        case 1: case 2: //addiu/ori
            OParray[0] = 8;
            OParray[1] = 9;
            OParray[2] = 13;
            OParray[3] = 24;
            OParray[4] = 25;
            OParray[5] = 10;
            OParray[6] = 11;
            if (rstype == 1) OParray[5] = 256;    
//            memcpy(OParray,"\x8\x9\xD\x18\x19\xFF",6);
            break;
        case 3:
            OParray[0] = 546;
            OParray[1] = 560;
            OParray[2] = 545;
            OParray[3] = 549;
            OParray[4] = 544;
            OParray[5] = 548;
            break;
        case 5: //mtc0 enabler
            Value1 = (16<<26)|(4<<21);
            Value2 = (BITS(11)<<21)|BITS(11);
            break;
        case 6:
            OParray[0] = 0x80;
            OParray[1] = 0x100;
            OParray[2] = 0x180;
            OParray[3] = 0x190;
            break;
    }
    for (addy = 0; addy < filesize; addy += 4) {
        val1 = getdataxt(DisData,addy,4);
        switch (rstype) {
            case 0: //lui+addiu/ori/lb
                if ( ((val1 & 0xFFFF) == (Value1>>16)) || ( (((val1 & 0xFFFF) - 0x0001) == (Value1>>16)) && ((Value1 & 0xFFFF) > 0x7FFF)) ) {
//                if ( ((val1 & 0xFFFF) == (Value1>>16)) || ( (((val1>>16) + 0x1000) == (Value1>>16)) && ((val1 & 0xFFFF) > 0x7FFF)) ) {
//                if ((val1 & 0xFFFF) == (Value1>>16)) {
                    for (tmpaddy = addy + 4; tmpaddy < (addy + 0x20); tmpaddy += 4) {
                        val2 = getdataxt(DisData,tmpaddy,4);
//                        return (Value1 & 0xFFFF);
                        if ((val2 & 0xFFFF) == (Value1 & 0xFFFF)) {
                            putw(addy,resFile);
                            putw(tmpaddy,resFile);
                            rescount++;
                            break;
                        }
                    }
                }            
                break;
            case 1: case 2: //ADDIU/ORI/etc *,*,value
                for (i = 0; i <= 7; i++) {
                    if (OParray[i] == 256) break;
                    if ( (( ((val1>>21) & 0x1F) == 0) || (rstype == 2)) && ((val1>>26) == OParray[i]) && ((val1 & 0xFFFF) == Value1)) {
                        putw(addy,resFile);
                        rescount++;
                        break;
                    }
                }                            
                break;
            case 3: //lui/mtc0
                if ( ((val1>>26) == 15) && (Value1 == (val1 & 0xFFFF))) {
                    for (tmpaddy = addy + 4; tmpaddy <= (addy + 0x20); tmpaddy += 4) {
                        val2 = getdataxt(DisData,tmpaddy,4);
                        for (i = 0; i <= 5; i++) {
                            if (OParray[i] == 0) break;
                            if (((val2>>21) == OParray[i]) && ((val2 & BITS(11)) == 0) && (((val1>>16) & 0x1F) == ((val2>>16) & 0x1F))) {
                                putw(addy,resFile);
                                putw(tmpaddy,resFile);
                                rescount++;
                                break;
                            }
                        }    
                    }    
                }                            
                break;
            case 4: //opcode
                if ((val1 & Value1) == Value2) {
                    putw(addy,resFile);
                    rescount++;
                }    
                break;
            case 5: //mtc0 enabler
                if ((val1 & Value2) == Value1) {
                    if ( ((val1 & (BITS(5)<<11)) == (0x12<<11)) || ((val1 & (BITS(5)<<11)) == (0x13<<11)) ) {
                        putw(addy,resFile);
                        rescount++;
                    }    
                }    
                break;
            case 6: //80000180 enabler
                for (i = 0; i <= 3; i++) {
                    if ((val1 & 0xFFFF) == OParray[i]) {
                        for (tmpaddy = addy - 4; tmpaddy >= 0; tmpaddy -= 4) {
                            if (tmpaddy < (addy - 0x20)) break;
                            val2 = getdataxt(DisData,tmpaddy,4);
                            if ( ((val2>>26) == 15) && ((val2 & 0xFFFF) == 0x8000)  ) {
                                putw(addy,resFile);
                                putw(tmpaddy,resFile);
                                rescount++;
                                break;
                            } 
                        }        
                    }    
                }    
                break;
        }    
    }
    fseek(resFile,0,SEEK_SET);
    putw(rescount|rstype<<24,resFile);
    fclose(resFile);
    if (DisData) { free(DisData); DisData = 0; }
    return 0;
}    
