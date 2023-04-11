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

s32 __declspec(dllexport) CALLBACK CopyFileBytes(BSTR FileIn, BSTR FileOut, char eType, u32 fStart, u32 fEnd)
{
    FILE *tmp;
    u8 *buffer;
    u32 fsize;
    u32 i;
    LPSTR ReadFile=(LPSTR)FileIn;
    LPSTR WriteFile=(LPSTR)FileOut;
    if (buffer) { free(buffer); buffer = 0; }
	tmp = fopen(ReadFile,"rb");
	if (!(tmp)) { return 2; }
//	if (!(tmp = fopen(ReadFile,"rb"))) { return 2; }
	fseek(tmp,0,SEEK_END);
	fsize = ftell(tmp);
    fseek(tmp,fStart,SEEK_SET);
    if (fEnd == 0) { fEnd = fsize; }
    else { fEnd++; }
    fEnd -= fStart;
    if (!(buffer = (unsigned char*)malloc(fsize))) { return 1; }
    if (eType == 0) { fread(buffer,(fStart + 1),fEnd,tmp); }
    else { 
        for (i = 0; i < fEnd; i += 4) {
        switch(eType) {
            case 1: //16-bit little endian <> big endian
                (buffer)[i+1] = fgetc(tmp);
                (buffer)[i] = fgetc(tmp);
                (buffer)[i+3] = fgetc(tmp);
                (buffer)[i+2] = fgetc(tmp);
                break;
            case 2: //32-bit little endian <> big endian
                (buffer)[i+3] = fgetc(tmp);
                (buffer)[i+2] = fgetc(tmp);
                (buffer)[i+1] = fgetc(tmp);
                (buffer)[i] = fgetc(tmp);
                break;
            case 3: //16-bit little endian <> 32-bit little endian
                (buffer)[i+2] = fgetc(tmp);
                (buffer)[i+3] = fgetc(tmp);
                (buffer)[i] = fgetc(tmp);
                (buffer)[i+1] = fgetc(tmp);
                break;
       }
       }
    }                   

 	fclose(tmp);
	tmp = fopen(WriteFile,"wb");
//	if (!(tmp = fopen(WriteFile,"wb"))) { return 2; }
	if (!(tmp)) { return 2; }
	fwrite (buffer , 1 , fsize , tmp);
 	fclose(tmp);
 	return 0;
}
s32 __declspec(dllexport) CALLBACK InitResults(BSTR ramFile, BSTR searchFile, u8 searchsize, u32 memStart, u32 memEnd, u32 headersize, u8 fileformat)
{
    FILE *tmpFile;
    u32 rsize;
    u32 i;
    NewFile = (LPSTR)ramFile;
    iosize = searchsize;
    SetByteInfo();
    filefmt = fileformat;
    header = headersize;
    sRangeLo = memStart;
    sRangeHi = memEnd;
    tmpFile = fopen(NewFile,"rb");
	if (!(tmpFile)) { return 2; }
//	if (!(tmpFile = fopen(NewFile,"rb"))) { return 2; }
	fseek(tmpFile,0,SEEK_END);
	filesize = ftell(tmpFile);
	fclose(tmpFile);
	rsize = (filesize / ioinc / 8);
    if (!(Results = (unsigned char*)malloc(rsize))) { return 1; }
    if (sRangeHi == 0) { sRangeHi = filesize; }
    if ((sRangeLo == 0) && (sRangeHi == filesize)) {
     memset(Results,255,rsize);
    } else {
     memset(Results,0,rsize);
     for (i = sRangeLo; i < sRangeHi; i += ioinc) { set_bitflag(Results,i / ioinc,1); }
    }
    if ((iosize == 4) || (iosize == 5)) {
        if (iosize == 4) { i = 2; }
        else i = 0;
        for (i = i; i < filesize; i += 4) { set_bitflag(Results,i / ioinc,0); }
    }
    rsize += nfoheader;
    if (!(OldData = (unsigned char*)malloc(rsize))) { FreeShit(); return 1; }
    memset (OldData,0,rsize);
    setheader();
    tmpFile = fopen((LPSTR)searchFile,"wb");
	if (!(tmpFile)) { return 2; }
    fwrite (OldData, 1, rsize , tmpFile);
    fseek(tmpFile,0,SEEK_SET);
    fwrite (hData , 1 , nfoheader , tmpFile);
    fwrite (Results , 1 , (filesize / ioinc / 8) , tmpFile);
	fclose(tmpFile);
    FreeShit();
    return 0;
}

