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

int xsearch(int idx,u64 tmpNew,u64 tmpOld) {
    if (xOpt == 0) { return 0; }
//    SPLOG;
//?    tmpNew &= (0xFFFFFFFFFFFFFFFFLL >> 8*(8-iobytes));
//    if (!(xOpt & ~1)) { return 0;)
//    u64 tmpNew = getdata(NewData,idx);
//    u64 tmpOld = 0;
//    u64 tmpDword = getdataxt(NewData,(idx & ~7),8);
//    u64 tmpDword2 = getdataxt(NewData,((idx & ~7) + 8),4);
    int X;
    u64 tmpByte;
    u64 tmpShort;
    u64 tmpShort2;
    u64 tmpWord;
    u64 tmpWord2;
    u64 tmpDword;
    u64 tmpDword2;
//    if ( (xOpt & 0x80) || (xOpt & 0x200) ) {
    tmpByte = getdataxt(NewData,idx,8);
    if (xOpt & 0x2200) {
        tmpShort = getdataxt(NewData,(idx & ~1),8);
        tmpShort2 = getdataxt(NewData,(idx & ~1)+8,2);
        if (xOpt & 1) signxt2(&tmpShort2,2);
    }    
    if (xOpt & 0x4480) {
        tmpWord = getdataxt(NewData,(idx & ~3),8);
        tmpWord2 = getdataxt(NewData,(idx & ~3)+8,4);
        if (xOpt & 1) signxt2(&tmpWord2,4);
    }   
    if (xOpt & 0x8800) {
        tmpDword = getdataxt(NewData,(idx & ~7),8);
        tmpDword2 = getdataxt(NewData,(idx & ~7)+8,8);
    }    
    //ignore 0
    if ((xOpt & 4) && (!(tmpNew))) { set_bitflag(Results,idx / ioinc,0); }
    //ignore FF
    if ((xOpt & 8) && ( (tmpNew == (0xFFFFFFFFFFFFFFFFLL >> 8*(8-ioinc))) || (tmpNew == 0xFFFFFFFFFFFFFFFFLL) ) ) { set_bitflag(Results,idx / ioinc,0); }
    //ignore value
    if ((xOpt & 0x10) && (tmpNew == xValue1)) { set_bitflag(Results,idx / ioinc,0); }
    //ignore in range
    if (xOpt & 0x20) {
        if ((xOpt & 1) && ((s64)tmpNew >= (s64)xValueLow1) && ((s64)tmpNew <= (s64)xValueHigh1)) { set_bitflag(Results,idx / ioinc,0); }
        if ((!(xOpt & 1)) && (tmpNew >= xValueLow1) && (tmpNew <= xValueHigh1)) { set_bitflag(Results,idx / ioinc,0); }
    }    
    //ignore not in range
    if (xOpt & 0x40) {
        if ((xOpt & 1) && ((s64)tmpNew <= (s64)xValueLow2) && ((s64)tmpNew >= (s64)xValueHigh2)) { set_bitflag(Results,idx / ioinc,0); }
        if ((!(xOpt & 1)) && (tmpNew <= xValueLow2) && (tmpNew >= xValueHigh2)) { set_bitflag(Results,idx / ioinc,0); }
    }
    //ignore N64 pointers
    if (xOpt & 0x80) { 
        if ((idx + iobytes) <= ((idx & ~3) + 4)) {
            if ((getword(tmpWord,0) >= pnt64low) && (getword(tmpWord,0) <= pnt64high)) { set_bitflag(Results,idx / ioinc,0); }
        }
        else if ((idx + iobytes) <= ((idx & ~3) + 8)) {
            if (((getword(tmpWord,0) >= pnt64low) && (getword(tmpWord,0) <= pnt64high)) ||
                ((getword(tmpWord,1) >= pnt64low) && (getword(tmpWord,1) <= pnt64high))) { set_bitflag(Results,idx / ioinc,0); }
        }
        else {                
            if (((getword(tmpWord,0) >= pnt64low) && (getword(tmpWord,0) <= pnt64high)) ||
                ((getword(tmpWord,1) >= pnt64low) && (getword(tmpWord,1) <= pnt64high)) ||
                ((tmpWord2 >= pnt64low) && (tmpWord2 <= pnt64high))) { set_bitflag(Results,idx / ioinc,0); }
        }
    }        
    //exclude results that are part of a byte (8bit)
    if (xOpt & 0x100) {
        for (X = 0; X < iobytes; X++) {
            if (getbyte(tmpByte,X) == xByte) set_bitflag(Results,idx / ioinc,0);
        }
    }        
    //exclude results that are part of a short (16bit)
    if (xOpt & 0x200) {
       if ((idx + iobytes) <= ((idx & ~1) + 2)) {
           if (getshort(tmpShort,0) == xShort) { set_bitflag(Results,idx / ioinc,0); }
       }
       else if ((idx + iobytes) <= ((idx & ~1) + 4)) {
           if ((getshort(tmpShort,0) == xShort) || (getshort(tmpShort,1) == xShort)) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else if ((idx + iobytes) <= ((idx & ~1) + 6)) {
           if ((getshort(tmpShort,0) == xShort) || (getshort(tmpShort,1) == xShort) ||
               (getshort(tmpShort,2) == xShort)) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else if ((idx + iobytes) <= ((idx & ~1) + 8)) {
           if ((getshort(tmpShort,0) == xShort) || (getshort(tmpShort,1) == xShort) ||
               (getshort(tmpShort,2) == xShort) || (getshort(tmpShort,3) == xShort)) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else {                
           if ((getshort(tmpShort,0) == xShort) || (getshort(tmpShort,1) == xShort) ||
               (getshort(tmpShort,2) == xShort) || (getshort(tmpShort,3) == xShort) ||
               (tmpShort2 == xShort)) { set_bitflag(Results,idx / ioinc,0); }
       }    
   }                                         
   //exclude results that are part of a word (32bit)
    if (xOpt & 0x400) {
        if ((idx + iobytes) <= ((idx & ~3) + 4)) {
            if (getword(tmpWord,0) == xWord) { set_bitflag(Results,idx / ioinc,0); }
        }
        else if ((idx + iobytes) <= ((idx & ~3) + 8)) {
            if ((getword(tmpWord,0) == xWord) || (getword(tmpWord,1) == xWord)) { set_bitflag(Results,idx / ioinc,0); }
        }
        else {                
            if ((getword(tmpWord,0) == xWord) || (getword(tmpWord,1) == xWord) ||
                (tmpWord2 == xWord)) { set_bitflag(Results,idx / ioinc,0); }
        }    
    }                                         
   //exclude results that are part of a doulbeword (64bit)
    if (xOpt & 0x800) {
        if ((idx + iobytes) <= ((idx & ~7) + 8)) {
            if (tmpDword == xDword) { set_bitflag(Results,idx / ioinc,0); }
        }
        else {                
            if ((tmpDword == xDword) || (tmpDword2 == xDword)) { set_bitflag(Results,idx / ioinc,0); }
        }    
    }
   //exclude results that are part of a byte range (8bit)                                         
    if ((xOpt & 0x1000) && (xOpt & 1)) {
        for (X = 0; X < iobytes; X++) {
            if (((s64)getbyte(tmpByte,X) >= (s64)xByteLow) && ((s64)getbyte(tmpByte,X) <= (s64)xByteHigh)) set_bitflag(Results,idx / ioinc,0);
        }
    }
    else if (xOpt & 0x1000) {
        for (X = 0; X < iobytes; X++) {
            if ((getbyte(tmpByte,X) >= xByteLow) && (getbyte(tmpByte,X) <= xByteHigh)) set_bitflag(Results,idx / ioinc,0);
        }
    }
    //exclude results that are part of a short range (16bit)        
    if ((xOpt & 0x2000) && (xOpt & 1)) {
       if ((idx + iobytes) <= ((idx & ~1) + 2)) {
           if (((s64)getshort(tmpShort,0) >= (s64)xShortLow) && ((s64)getshort(tmpShort,0) <= (s64)xShortHigh)) { set_bitflag(Results,idx / ioinc,0); }
       }
       else if ((idx + iobytes) <= ((idx & ~1) + 4)) {
           if ((((s64)getshort(tmpShort,0) >= (s64)xShortLow) && ((s64)getshort(tmpShort,0) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,1) >= (s64)xShortLow) && ((s64)getshort(tmpShort,1) <= (s64)xShortHigh))) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else if ((idx + iobytes) <= ((idx & ~1) + 6)) {
           if ((((s64)getshort(tmpShort,0) >= (s64)xShortLow) && ((s64)getshort(tmpShort,0) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,1) >= (s64)xShortLow) && ((s64)getshort(tmpShort,1) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,2) >= (s64)xShortLow) && ((s64)getshort(tmpShort,2) <= (s64)xShortHigh))) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else if ((idx + iobytes) <= ((idx & ~1) + 8)) {
           if ((((s64)getshort(tmpShort,0) >= (s64)xShortLow) && ((s64)getshort(tmpShort,0) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,1) >= (s64)xShortLow) && ((s64)getshort(tmpShort,1) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,2) >= (s64)xShortLow) && ((s64)getshort(tmpShort,2) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,3) >= (s64)xShortLow) && ((s64)getshort(tmpShort,3) <= (s64)xShortHigh))) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else {                
           if ((((s64)getshort(tmpShort,0) >= (s64)xShortLow) && ((s64)getshort(tmpShort,0) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,1) >= (s64)xShortLow) && ((s64)getshort(tmpShort,1) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,2) >= (s64)xShortLow) && ((s64)getshort(tmpShort,2) <= (s64)xShortHigh)) ||
               (((s64)getshort(tmpShort,3) >= (s64)xShortLow) && ((s64)getshort(tmpShort,3) <= (s64)xShortHigh)) ||
               (((s64)tmpShort2 >= (s64)xShortLow) && ((s64)tmpShort2 <= (s64)xShortHigh))) { set_bitflag(Results,idx / ioinc,0); }
       }    
    }
    else if (xOpt & 0x2000) {
       if ((idx + iobytes) <= ((idx & ~1) + 2)) {
           if ((getshort(tmpShort,0) >= xShortLow) && (getshort(tmpShort,0) <= xShortHigh)) { set_bitflag(Results,idx / ioinc,0); }
       }
       else if ((idx + iobytes) <= ((idx & ~1) + 4)) {
           if (((getshort(tmpShort,0) >= xShortLow) && (getshort(tmpShort,0) <= xShortHigh)) ||
               ((getshort(tmpShort,1) >= xShortLow) && (getshort(tmpShort,1) <= xShortHigh))) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else if ((idx + iobytes) <= ((idx & ~1) + 6)) {
           if (((getshort(tmpShort,0) >= xShortLow) && (getshort(tmpShort,0) <= xShortHigh)) ||
               ((getshort(tmpShort,1) >= xShortLow) && (getshort(tmpShort,1) <= xShortHigh)) ||
               ((getshort(tmpShort,2) >= xShortLow) && (getshort(tmpShort,2) <= xShortHigh))) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else if ((idx + iobytes) <= ((idx & ~1) + 8)) {
           if (((getshort(tmpShort,0) >= xShortLow) && (getshort(tmpShort,0) <= xShortHigh)) ||
               ((getshort(tmpShort,1) >= xShortLow) && (getshort(tmpShort,1) <= xShortHigh)) ||
               ((getshort(tmpShort,2) >= xShortLow) && (getshort(tmpShort,2) <= xShortHigh)) ||
               ((getshort(tmpShort,3) >= xShortLow) && (getshort(tmpShort,3) <= xShortHigh))) { set_bitflag(Results,idx / ioinc,0); }
       }            
       else {                
           if (((getshort(tmpShort,0) >= xShortLow) && (getshort(tmpShort,0) <= xShortHigh)) ||
               ((getshort(tmpShort,1) >= xShortLow) && (getshort(tmpShort,1) <= xShortHigh)) ||
               ((getshort(tmpShort,2) >= xShortLow) && (getshort(tmpShort,2) <= xShortHigh)) ||
               ((getshort(tmpShort,3) >= xShortLow) && (getshort(tmpShort,3) <= xShortHigh)) ||
               ((tmpShort2 >= xShortLow) && (tmpShort2 <= xShortHigh))) { set_bitflag(Results,idx / ioinc,0); }
       }    
    }
   //exclude results in a word (32bit) range                                         
    if ((xOpt & 0x4000) && (xOpt & 1)) { 
        if ((idx + iobytes) <= ((idx & ~3) + 4)) {
            if (((s64)getword(tmpWord,0) >= (s64)xWordLow) && ((s64)getword(tmpWord,0) <= (s64)xWordHigh)) { set_bitflag(Results,idx / ioinc,0); }
        }
        else if ((idx + iobytes) <= ((idx & ~3) + 8)) {
            if ((((s64)getword(tmpWord,0) >= (s64)xWordLow) && ((s64)getword(tmpWord,0) <= (s64)xWordHigh)) ||
                (((s64)getword(tmpWord,1) >= (s64)xWordLow) && ((s64)getword(tmpWord,1) <= (s64)xWordHigh))) { set_bitflag(Results,idx / ioinc,0); }
        }
        else {                
            if ((((s64)getword(tmpWord,0) >= (s64)xWordLow) && ((s64)getword(tmpWord,0) <= (s64)xWordHigh)) ||
                (((s64)getword(tmpWord,1) >= (s64)xWordLow) && ((s64)getword(tmpWord,1) <= (s64)xWordHigh)) ||
                (((s64)tmpWord2 >= (s64)xWordLow) && ((s64)tmpWord2 <= (s64)xWordHigh))) { set_bitflag(Results,idx / ioinc,0); }
        }
    }        
    else if (xOpt & 0x4000) { 
        if ((idx + iobytes) <= ((idx & ~3) + 4)) {
            if ((getword(tmpWord,0) >= xWordLow) && (getword(tmpWord,0) <= xWordHigh)) { set_bitflag(Results,idx / ioinc,0); }
        }
        else if ((idx + iobytes) <= ((idx & ~3) + 8)) {
            if (((getword(tmpWord,0) >= xWordLow) && (getword(tmpWord,0) <= xWordHigh)) ||
                ((getword(tmpWord,1) >= xWordLow) && (getword(tmpWord,1) <= xWordHigh))) { set_bitflag(Results,idx / ioinc,0); }
        }
        else {                
            if (((getword(tmpWord,0) >= xWordLow) && (getword(tmpWord,0) <= xWordHigh)) ||
                ((getword(tmpWord,1) >= xWordLow) && (getword(tmpWord,1) <= xWordHigh)) ||
                ((tmpWord2 >= xWordLow) && (tmpWord2 <= xWordHigh))) { set_bitflag(Results,idx / ioinc,0); }
        }
    }        
   //exclude results in a dword (64bit) range                                         
    if ((xOpt & 0x8000) && (xOpt & 1)) {
        if ((idx + iobytes) <= ((idx & ~7) + 8)) {
            if (((s64)tmpDword >= (s64)xDwordLow) && ((s64)tmpDword <= (s64)xDwordHigh)) { set_bitflag(Results,idx / ioinc,0); }
        }
        else {                
            if ((((s64)tmpDword >= (s64)xDwordLow) && ((s64)tmpDword <= (s64)xDwordHigh)) ||
                (((s64)tmpDword2 >= (s64)xDwordLow) && ((s64)tmpDword2 <= (s64)xDwordHigh))) { set_bitflag(Results,idx / ioinc,0); }
        }    
    }
    else if (xOpt & 0x8000) {
        if ((idx + iobytes) <= ((idx & ~7) + 8)) {
            if ((tmpDword >= xDwordLow) && (tmpDword <= xDwordHigh)) { set_bitflag(Results,idx / ioinc,0); }
        }
        else {                
            if (((tmpDword >= xDwordLow) && (tmpDword <= xDwordHigh)) ||
                ((tmpDword2 >= xDwordLow) && (tmpDword2 <= xDwordHigh))) { set_bitflag(Results,idx / ioinc,0); }
        }    
    }
    //or equal
    if ((xOpt & 2) && (OldData) && (tmpNew == tmpOld)) { rescount++; return 1; }
    
//    if (idx < 0x20) { printf("%d",get_bitflag(Results, idx / ioinc)); }
//    if ((idx > 0xBC) && (idx < 0xC4)) { printf("\n%d",get_bitflag(Results, idx / ioinc)); }
    return 0;  
}    

