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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "globals.h"
#include "misc.h"

//extern int filesize;
//extern u8 *hData;
//extern int filefmt;

int loadfile(u8 **buffer, LPSTR filename, int headerlen){
//    SPLOG;
    FILE *f;
    int i;
    if (hData) { free(hData); hData = 0; }
    if (!(hData = (unsigned char*)malloc(headerlen))) { return 1; }
	f = fopen(filename,"rb");
//	if (!(f = fopen(filename,"rb"))) { return 2; }
	if (!(f)) { return 2; }
	fseek(f,0,SEEK_END);
	filesize = ftell(f);
    if (headerlen > filesize) {
	    fclose(f);
	    return 3;
	}    
	filesize -= headerlen;
    if (*buffer) { free(*buffer); *buffer = 0; }
	if (!(*buffer = (unsigned char*)malloc(filesize))) { 
        fclose(f);
        return 1;
	}
    fseek(f,0,SEEK_SET);
 //match up endian with VB app
    if (headerlen) { fread(hData,1,headerlen,f); }
    if (filefmt == 2) { //big endian
        fread(*buffer,1,filesize,f);
    }
    else if (filefmt == 0) { //32bit little endian
        for (i = 0; i < filesize; i += 4) {
            (*buffer)[i+3] = fgetc(f);
            (*buffer)[i+2] = fgetc(f);
            (*buffer)[i+1] = fgetc(f);
            (*buffer)[i] = fgetc(f);
        }
    }                           
    //add 16 bit swapping?
    else if (filefmt == 1) { //16bit little endian
        for (i = 0; i < filesize; i += 4) {
            (*buffer)[i+1] = fgetc(f);
            (*buffer)[i+0] = fgetc(f);
            (*buffer)[i+3] = fgetc(f);
            (*buffer)[i+2] = fgetc(f);
        }
    }
    else if (filefmt == 3) { //little endian system
        for (i = 0; i < filesize; i += 4) {
            if (iobytes == 1) {
                fread(*buffer,1,filesize,f);
                break;
            }
            else if (iobytes == 2) {    
                (*buffer)[i+1] = fgetc(f);
                (*buffer)[i+0] = fgetc(f);
                (*buffer)[i+3] = fgetc(f);
                (*buffer)[i+2] = fgetc(f);
            }
            else {    
                (*buffer)[i+3] = fgetc(f);
                (*buffer)[i+2] = fgetc(f);
                (*buffer)[i+1] = fgetc(f);
                (*buffer)[i] = fgetc(f);
            }   
        }        
    }    
	fclose(f);
	return 0;
}
int readheader() {
    if (OldFile) { free(OldFile); OldFile = 0; }
    if (!(OldFile = (LPSTR)malloc(256))) { FreeShit(); return 1; }
    memcpy(OldFile,hData,256);
    iotype = hData[260];
    iosize = hData[261];
    header = (hData[262] << 24) | (hData[263] << 16) | (hData[264] << 8) | hData[265]; 
    filefmt = hData[266];
    sRangeLo = (hData[267] << 24) | (hData[268] << 16) | (hData[269] << 8) | hData[270];
    sRangeHi = (hData[271] << 24) | (hData[272] << 16) | (hData[273] << 8) | hData[274];
    SetByteInfo();
    return 0;
}    
int setheader() {
    if (hData) { free(hData); hData = 0; }
    if (!(hData = (unsigned char*)malloc(nfoheader))) { printf("Unable to allocate %d bytes of memory for header data.\n",nfoheader); return 0; }
    memset(hData,0,nfoheader);
    memcpy(hData,NewFile,strlen(NewFile));
    hData[256] = (rescount >> 24) & 0xFF;
    hData[257] = (rescount >> 16) & 0xFF;
    hData[258] = (rescount >> 8) & 0xFF;
    hData[259] = rescount & 0xFF;
    hData[260] = iotype;
    hData[261] = iosize;
    //header is probably wrong - might be fixed
    hData[262] = (header >> 24) & 0xFF;
    hData[263] = (header >> 16) & 0xFF;
    hData[264] = (header >> 8) & 0xFF;
    hData[265] = header & 0xFF;
    hData[266] = filefmt;
    hData[267] = (sRangeLo >> 24) & 0xFF;
    hData[268] = (sRangeLo >> 16) & 0xFF;
    hData[269] = (sRangeLo >> 8) & 0xFF;
    hData[270] = sRangeLo & 0xFF;
    hData[271] = (sRangeHi >> 24) & 0xFF;
    hData[272] = (sRangeHi >> 16) & 0xFF;
    hData[273] = (sRangeHi >> 8) & 0xFF;
    hData[274] = sRangeHi & 0xFF;
    return 0;
//    memcpy(NewFile,hData,64);
//    printf("\n %02x %02x %02x %02x\n",hData[66],hData[67],hData[68],hData[69]);        
}                    

