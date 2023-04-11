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
#include "misc.h"
#include "globals.h"

int PrintResults(char outfmt) {
    FILE *rFile;
    u64 NewValue;
    int addy=0;
    int pj64 = 0;
    int gba = 0;
    int CT[2] = { 0, 1 };
    int fmt;
//    char restxt[64];
    char txtfmt[128];
    char chr;
    float tmpfloat=0;
    u32 *castfloat=(u32*)(&tmpfloat);
    double tmpdouble=0;
    u64 *castdouble=(u64*)&tmpdouble;
//    sprintf(restxt,"search%d.txt",searchnum);
    rFile = fopen(NewResFile,"wt");
    if (!(rFile)) {
//    if (!(rFile = fopen(NewResFile,"wt"))) {
        return 2;        
    }
//    if ((outfmt == 3) && (iobytes > 4)) outfmt = 2;
    if ((outfmt == 4) && (iobytes != 4) && (iobytes != 8)) outfmt = 1; //floats
    if (outfmt == 3) xOpt = 1;
    else xOpt = 0;
    getfmtstring(txtfmt,outfmt);
    if ((outfmt == 5) || (outfmt == 6)) { //N64
        CT[0] = 0x80;
        CT[1] = 0x81;
    } else { //PSX
        CT[0] = 0x30;
        CT[1] = 0x80;
    }
    if (iosize == 5) { addy = 2; }
//    return stype;
    for (addy = addy; addy < filesize ; addy += ioinc) {
        if (!(get_bitflag(Results, addy / ioinc))) { continue; }
        NewValue = getdata(NewData,addy);
        *castdouble = NewValue;
        *castfloat = (u32)(NewValue & 0xFFFFFFFF);
        switch(outfmt) {
            case 1: //hex
                if (iobytes > 4) fprintf(rFile,txtfmt,addy,(NewValue<<32)|(NewValue>>32));
                else fprintf(rFile,txtfmt,addy,NewValue);
                break;
            case 2: //dec
                fprintf(rFile,txtfmt,addy,NewValue);
                break;
            case 3: //signed dec
                fprintf(rFile,txtfmt,addy,NewValue);
                break;
            case 4: //float,double
                if (iobytes == 4) {
                    fprintf(rFile,txtfmt,addy,tmpfloat);
                }
                else if (iobytes == 8) {
                    fprintf(rFile,txtfmt,addy,tmpdouble);
                }    
                break;
            case 5: case 7: //pj64,PSX
                if (outfmt == 5) fprintf(rFile,"\nCheat%d=\"80%06X\"",pj64,addy);
                else fprintf(rFile,"\"%X%06X\"\n",CT[0],addy);
            case 6: case 8: //N64,PSX output - line break every 100
                pj64++;
                if ((!(pj64 % 96)) && ((outfmt == 6) || (outfmt == 8))) fprintf(rFile,"\n");
                if ((iobytes == 1) ||  ((iobytes == 2) && (!(addy & 1)))) {
                    fprintf(rFile,txtfmt, CT[(!!(iobytes & 2))] ,addy,
                    (NewValue & 0xFFFF ));
                }
                else if (iobytes == 2) {    
                    fprintf(rFile,txtfmt,CT[0],addy,((NewValue >>  8) & 0x00FF ));
                    fprintf(rFile,txtfmt,CT[0],addy + 1,(NewValue & 0x00FF ));
                }
                else if (iobytes == 3) {
                    if (addy & 1) {
                        fprintf(rFile,txtfmt,CT[0],addy,((NewValue >>  16) & 0x00FF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 1,(NewValue & 0xFFFF ));
                    }
                    else {    
                        fprintf(rFile,txtfmt,CT[1],addy,((NewValue >>  8) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[0],addy + 1, (NewValue & 0x00FF ));
                    }
                }    
                else if (iobytes == 4) {
                    if (addy & 1) {
                        fprintf(rFile,txtfmt,CT[0],addy,((NewValue >>  24) & 0x00FF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 1,((NewValue >> 8) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[0],addy + 2,(NewValue & 0x00FF ));
                    }
                    else {    
                        fprintf(rFile,txtfmt,CT[1],addy,((NewValue >> 16) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 2, (NewValue & 0xFFFF ));
                    }
                }    
                else if (iobytes == 5) {
                    if (addy & 1) {
                        fprintf(rFile,txtfmt,CT[0],addy,((NewValue >>  32) & 0x00FF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 1,((NewValue >> 16) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 3,(NewValue & 0xFFFF ));
                    }
                    else {    
                        fprintf(rFile,txtfmt,CT[1],addy,((NewValue >> 24) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 2, ((NewValue >> 8) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[0],addy + 4, (NewValue & 0x00FF ));
                    }
                }    
                else if (iobytes == 6) {
                    if (addy & 1) {
                        fprintf(rFile,txtfmt,CT[0],addy,((NewValue >>  40) & 0x00FF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 1,((NewValue >> 24) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 3,((NewValue >> 8) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[0],addy + 5,(NewValue & 0x00FF ));
                    }
                    else {    
                        fprintf(rFile,txtfmt,CT[1],addy,((NewValue >> 32) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 2, ((NewValue >> 16) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 4, (NewValue & 0xFFFF ));
                    }
                }    
                else if (iobytes == 7) {
                    if (addy & 1) {
                        fprintf(rFile,txtfmt,CT[0],addy,((NewValue >>  48) & 0x00FF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 1,((NewValue >> 32) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 3,((NewValue >> 16) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 5,(NewValue & 0xFFFF ));
                    }
                    else {    
                        fprintf(rFile,txtfmt,CT[1],addy,((NewValue >> 40) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 2, ((NewValue >> 24) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 4, ((NewValue >> 8) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[0],addy + 6,(NewValue & 0x00FF ));
                    }
                }    
                else if (iobytes == 8) {
                    if (addy & 1) {
                        fprintf(rFile,txtfmt,CT[0],addy,((NewValue >>  56) & 0x00FF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 1,((NewValue >> 40) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 3,((NewValue >> 24) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 5,((NewValue >> 8) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[0],addy + 7,(NewValue & 0x00FF ));
                    }
                    else {    
                        fprintf(rFile,txtfmt,CT[1],addy,((NewValue >> 48) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 2, ((NewValue >> 32) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 4, ((NewValue >> 16) & 0xFFFF ));
                        fprintf(rFile,txtfmt,CT[1],addy + 6,(NewValue & 0xFFFF ));
                    }
                }    
                break;
            case 13: //ASCII
                fprintf(rFile,"%08X: ",addy);
                for (gba = 0; gba < iobytes ; gba++) {
                    chr = NewData[addy + gba];
                    if (!(isprint(chr))) chr = 46;
                    fprintf(rFile,"%c",chr);
                }
                fprintf(rFile,"\n");
                break;
        }
    }
    fclose(rFile);
    return 0;
}
void getfmtstring(char *tmpstring,char outfmt) {
    switch (outfmt) {
        case 1: //hex
            if (iobytes < 5) sprintf(tmpstring,"%%08X: %%0%dX\n",(iobytes * 2));
            else sprintf(tmpstring,"%%08X: %%08X%%08X\n");    
            break;
        case 2: //decimal
//            if (xOpt & 1) sprintf(tmpstring,"%%08X: %%d\n");
//            else sprintf(tmpstring,"%%08X: %%u\n");    
            sprintf(tmpstring,"%%08X: %%I64u\n");    
            break;
        case 3: //signed decimal
            sprintf(tmpstring,"%%08X: %%I64d\n");
            break;
        case 4: //float, double
            if (iobytes == 4) sprintf(tmpstring,"%%08X: %%f\n");
            else sprintf(tmpstring,"%%08X: %%Lf\n");
            break;
        case 5: //PJ64
            sprintf(tmpstring,",%%X%%06X %%04X");
            break;
        case 6: case 7: case 8: //N64,PSX
            sprintf(tmpstring,"%%X%%06X %%04X\n");
            break;
        case 9: //GBA
            sprintf(tmpstring,"0%%d%%06X %%08X\n");
            break;
        case 10: case 11: //GENS,Gen PAR
            sprintf(tmpstring,"FF%%04X:%%04X\n");
            break;
        case 12: //SNES PAR
            sprintf(tmpstring,"7E%%04X%%02X\n");
            break;
    }
}

