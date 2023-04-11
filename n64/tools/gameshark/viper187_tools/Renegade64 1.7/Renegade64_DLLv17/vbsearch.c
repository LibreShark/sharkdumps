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

s32 __declspec(dllexport) CALLBACK FileSearch(BSTR newname,BSTR oldname,BSTR resultsout,BSTR resultsin, u32 headersize, u8 fileformat, 
u8 searchtype, u8 searchsize, u32 xoptions, LPSAFEARRAY FAR *values, BSTR searchstring, LPSAFEARRAY FAR *ivalues, u32 memStart, u32 memEnd)
{
//    SPLOG;
    int errnum=0;
    int i;
    FreeShit();
    NewFile = (LPSTR)newname;
    OldFile = (LPSTR)oldname;
    NewResFile = (LPSTR)resultsout;
    OldResFile = (LPSTR)resultsin;
    header = headersize;
    filefmt = fileformat;
    stype = searchtype;
    iosize = searchsize;
    SetByteInfo();
    xOpt = xoptions;
    iValue1 = ((u64)GetVBElement(*values,0)<<32)|(u32)GetVBElement(*values,1);
    iValueLow = ((u64)GetVBElement(*values,2)<<32)|(u32)GetVBElement(*values,3);
    iValueHigh = ((u64)GetVBElement(*values,4)<<32)|(u32)GetVBElement(*values,5);
    xValue1 = ((u64)GetVBElement(*values,6)<<32)|(u32)GetVBElement(*values,7);
    xValueLow1 = ((u64)GetVBElement(*values,8)<<32)|(u32)GetVBElement(*values,9);
    xValueHigh1 = ((u64)GetVBElement(*values,10)<<32)|(u32)GetVBElement(*values,11);
    xValueLow2 = ((u64)GetVBElement(*values,12)<<32)|(u32)GetVBElement(*values,13);
    xValueHigh2 = ((u64)GetVBElement(*values,14)<<32)|(u32)GetVBElement(*values,15);
    xByte = GetVBElement(*values,16);
    xByteLow = GetVBElement(*values,17);
    xByteHigh = GetVBElement(*values,18);
    xShort = GetVBElement(*values,19);
    xShortLow = GetVBElement(*values,20);
    xShortHigh = GetVBElement(*values,21);
    xWord = GetVBElement(*values,22);
    xWordLow = GetVBElement(*values,23);
    xWordHigh = GetVBElement(*values,24);
    xDword = ((u64)GetVBElement(*values,25)<<32)|(u32)GetVBElement(*values,26);
    xDwordLow = ((u64)GetVBElement(*values,27)<<32)|(u32)GetVBElement(*values,28);
    xDwordHigh = ((u64)GetVBElement(*values,29)<<32)|(u32)GetVBElement(*values,30);
    ConsecRes = GetVBElement(*values,31);
    iString = (LPSTR)searchstring;
    sRangeLo = memStart;
    sRangeHi = memEnd;
    for (i = 0; i <= 100; i++) {
        iValueList[i] = GetVBElement(*ivalues,i);
    }
    if (xOpt & 1) {
//        signxt(&iValue1);         
        signxt(&iValueLow);         
        signxt(&iValueHigh);         
//        signxt(&xValue1);         
        signxt(&xValueLow1);         
        signxt(&xValueHigh1);         
        signxt(&xValueLow2);         
        signxt(&xValueHigh2);
//        signxt2(&xByte,1);
        signxt2(&xByteLow,1);
        signxt2(&xByteHigh,1);
//        signxt2(&xShort,2);
        signxt2(&xShortLow,2);
        signxt2(&xShortHigh,2);
//        signxt2(&xWord,4);
        signxt2(&xWordLow,4);
        signxt2(&xWordHigh,4);
    }
    errnum = loadfile(&NewData,NewFile,header);
    if (errnum != 0) { FreeShit(); return errnum; }
///    if (loadfile(&NewData,NewFile,header) != 0) { return 1; }
//    MessageBox(NULL,NewFile,"in C++",0);
    filefmt = 2;
//    if (loadfile(&Results,OldResFile,nfoheader) == 0) {
    if (strlen(OldResFile)) {
        errnum = loadfile(&Results,OldResFile,nfoheader);
        if (readheader() !=0) { FreeShit(); return 1; }
//        if (loadfile(&OldData,OldFile,header) !=0) { FreeShit(); return 1; }
//        errnum = loadfile(&OldData,OldFile,header);
        if (strlen((LPSTR)oldname)) sprintf(OldFile,"%s",(LPSTR)oldname);
        if (errnum !=0) { FreeShit(); return errnum; } 
    }
    else {
        if (!(Results = (unsigned char*)malloc(filesize / ioinc / 8))) { FreeShit(); return 1; }
//        memset(Results,255,(filesize / ioinc / 8));
        memset(Results,0,(filesize / ioinc / 8));
        filefmt = fileformat;
        if (sRangeHi == 0) { sRangeHi = filesize; }
//        char tmp[50];
//        sprintf(tmp,"%X : %X",sRangeLo,sRangeHi);
//        MessageBox(NULL,tmp,"Debug",0);
        for (i = sRangeLo; i < sRangeHi; i += ioinc) { set_bitflag(Results,i / ioinc,1); }
        if ((iosize == 4) || (iosize == 5)) {
            if (iosize == 4) { i = 2; }
            else i = 0;
            for (i = i; i < filesize; i += 4) { set_bitflag(Results,i / ioinc,0); }
        }
    }
//    if ((stype >= 2) && (stype <= 18)) {
    if (strlen(OldFile)) {
        errnum = loadfile(&OldData,OldFile,header);
        if (errnum !=0) { FreeShit(); return errnum; } 
    }
//    if ((stype <= 20) || (stype >= 26)) {
    if (memStart > sRangeLo) { sRangeLo = memStart; }
    if (memEnd < sRangeHi) { sRangeHi = memEnd; }
     DoSearch();
//    }
    FILE *rFile;
    rFile = fopen(NewResFile,"wb");
    if (!(rFile)) { FreeShit(); return 4; }
    else {
        setheader();
        int rsize = (filesize / ioinc / 8) + nfoheader;
        u8 *tmpbuff;
        if (!(tmpbuff = (unsigned char*)malloc(rsize))) { FreeShit(); return 1; }
        
        memset (tmpbuff,0,rsize);
        fwrite (tmpbuff, 1, rsize , rFile);
        free(tmpbuff); tmpbuff=0;
        fseek(rFile,0,SEEK_SET);
        fwrite (hData , 1 , nfoheader , rFile);
        fwrite (Results , 1 , (filesize / ioinc / 8) , rFile);
        fclose(rFile);
    }

    FreeShit();
    return 0;
}
s32 __declspec(dllexport) CALLBACK WriteResults(BSTR resultsin,BSTR resultsout, BSTR oldresults, char resformat, char printold)
{
    int errnum=0;
    OldResFile = (LPSTR)resultsin;
    NewResFile = (LPSTR)resultsout;
    NewFile = (LPSTR)oldresults;
    FreeShit();
    filefmt = 2;
    FILE *tmp;
//    MessageBox(NULL,NewFile,"in C++",0);
    errnum = loadfile(&Results,OldResFile,nfoheader);
    if (errnum != 0) { FreeShit(); return 4; }
    if (readheader() !=0) { FreeShit(); return 1; }
    SetByteInfo();
    errnum = loadfile(&NewData,OldFile,header);
    if (errnum != 0) { FreeShit(); return errnum; }
    if (printold) {
     free(NewData); NewData = 0;
     errnum = loadfile(&NewData,NewFile,header);
     if (errnum != 0) { FreeShit(); return errnum; }
    }
    errnum = PrintResults(resformat,printold);
    if (errnum != 0) { FreeShit(); return errnum; }
    FreeShit();
    return 0;
}
s32 GetVBElement(LPSAFEARRAY FAR vbarray, long element)
{
    s32 tmpval=0;
    SafeArrayGetElement(vbarray,&element,&tmpval);
    return tmpval;
}
int FreeShit()
{
    if (OldData) { free(OldData); OldData = 0; }	
    if (NewData) { free(NewData); NewData = 0; }	
    if (Results) { free(Results); Results = 0; }
    if (hData) { free(hData); hData = 0; }
    if (OldFile) { free(OldFile); OldFile = 0; }
}

