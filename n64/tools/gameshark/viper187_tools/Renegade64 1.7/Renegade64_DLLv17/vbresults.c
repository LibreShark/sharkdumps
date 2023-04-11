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
#include "misc.h"
#include "globals.h"

s32 __declspec(dllexport) CALLBACK WriteAllResults(BSTR rPath, BSTR resultsout, char resnum, char resformat)
{
    int errnum=0;
    FILE *ramFiles[75];
    FILE *trFile;
    FILE *tmpFile;
    u64 rValue;
    u32 addy=0;
    int fnum;
    float tmpfloat=0;
    u32 *castfloat=(u32*)(&tmpfloat);
    double tmpdouble=0;
    u64 *castdouble=(u64*)&tmpdouble;
    char txtfmt[128];
    char fName[256];
    char tmpData[7];
    u32 i;
    char chr;
    SetByteInfo();
    getfmtstring2(txtfmt,resformat);
    trFile = fopen((LPSTR)resultsout,"wt");
    if (!(trFile)) { return 2; }
    for (fnum = 0; fnum < resnum; fnum++) {
        filefmt = 2;
        sprintf(fName,"%ssearch%d.bin",(LPSTR)rPath, (resnum - fnum));
        if (hData) { free(hData); hData = 0; }
        if (!(hData = (unsigned char*)malloc(nfoheader))) { return 1; }
        tmpFile = fopen(fName,"rb");
	    if (!(tmpFile)) { return 2; }
	    fread(hData,1,nfoheader,tmpFile);
	    if (readheader() !=0) { FreeShit(); return 1; }
	    fclose(tmpFile);
        ramFiles[fnum] = fopen(OldFile,"rb");
	    if (!(ramFiles[fnum])) { return 2; }
    }
    sprintf(fName,"%ssearch%d.bin",(LPSTR)rPath, resnum);
    filefmt = 2;
    errnum = loadfile(&Results,fName,nfoheader);
    if (errnum != 0) { FreeShit(); return 4; }
    if (readheader() !=0) { FreeShit(); return 1; }

    if ((resformat == 4) && (iobytes != 4) && (iobytes != 8)) resformat = 1; //floats
    if (resformat == 3) xOpt = 1;
    else xOpt = 0;
    if (iosize == 5) { addy = 2; }
	fseek(ramFiles[0],0,SEEK_END);
	filesize = ftell(ramFiles[0]);
	filesize -= header;
	fseek(ramFiles[0],0,SEEK_SET);
    for (addy = addy; addy < filesize ; addy += ioinc) {
        if (!(get_bitflag(Results, addy / ioinc))) { continue; }
        fprintf(trFile,"%08X:",addy);
        for (fnum = 0; fnum < resnum; fnum++) {
        	fseek(ramFiles[fnum],((addy & 0xFFFFFFF8)+header),SEEK_SET);
            fread(tmpData,1,8,ramFiles[fnum]);
            rValue = getdataES(tmpData,addy);
            *castdouble = rValue;
            *castfloat = (u32)(rValue & 0xFFFFFFFF);
            switch(resformat) {
                case 1: //hex
                    if (iobytes > 4) fprintf(trFile,txtfmt,(rValue<<32)|(rValue>>32));
                    else fprintf(trFile,txtfmt,rValue);
                    break;
                case 2: //dec
                    fprintf(trFile,txtfmt,rValue);
                    break;
                case 3: //signed dec
                    fprintf(trFile,txtfmt,rValue);
                    break;
                case 4: //float,double
                    if (iobytes == 4) fprintf(trFile,txtfmt,tmpfloat);
                    else if (iobytes == 8) fprintf(trFile,txtfmt,tmpdouble);
                    break;
                case 13: //ASCII
                    fprintf(trFile,"  ");
                    for (i = 0; i < iobytes ; i++) {
                        chr = (rValue >> (8 * (iobytes - i - 1))) & 0xFF;
                        if (!(isprint(chr))) chr = 46;
                        fprintf(trFile,"%c",chr);
                    }
                    break;
            }    
        }    
        fprintf(trFile,"\n");
    }                
    fclose(trFile);
    for (fnum = 0; fnum < resnum; fnum++) { fclose(ramFiles[fnum]); }
    FreeShit();
    return 0;
}
void getfmtstring2(char *tmpstring,char outfmt) {
    switch (outfmt) {
        case 1: //hex
            if (iobytes < 5) sprintf(tmpstring,"  %%0%dX",(iobytes * 2));
            else sprintf(tmpstring,"  %%08X%%08X");    
            break;
        case 2: //decimal
            sprintf(tmpstring,"  %%I64u");    
            break;
        case 3: //signed decimal
            sprintf(tmpstring,"  %%I64d");
            break;
        case 4: //float, double
            if (iobytes == 4) sprintf(tmpstring,"  %%f");
            else sprintf(tmpstring,"  %%Lf");
            break;
    }    
}

