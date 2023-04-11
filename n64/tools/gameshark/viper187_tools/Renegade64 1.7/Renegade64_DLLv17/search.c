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

void DoSearch() {
//    SPLOG;
    //do signed searching
    int addy=0;
    int i;
    u64 NewVal;
    u64 OldVal;
    rescount = 0;
    pnt64low = 0x80000000 | (0xFFFFFFFF00000000LL * (xOpt & 1));  
    pnt64high = 0x807FFFFF | (0xFFFFFFFF00000000LL * (xOpt & 1));  
    if (sRangeHi == 0) { sRangeHi = filesize; }
//    if (iosize == 5) { addy = 2; }
//asm
    int tmpaddy;
    u32 OParray[10];
    switch (stype) {
        case 32: case 33: case 38: //addiu/ori
            OParray[0] = 8;
            OParray[1] = 9;
            OParray[2] = 13;
            OParray[3] = 24;
            OParray[4] = 25;
            OParray[5] = 10;
            OParray[6] = 11;
            if (stype == 1) OParray[5] = 256;    
            break;
        case 34: //LUI-*TC1
            OParray[0] = 546;
            OParray[1] = 560;
            OParray[2] = 545;
            OParray[3] = 549;
            OParray[4] = 544;
            OParray[5] = 548;
            break;
        case 36: //mtc0 enabler
            iValueLow = (16<<26)|(4<<21);
            iValueHigh = (BITS(11)<<21)|BITS(11);
            break;
        case 37: //80000180 enabler
            OParray[0] = 0x80;
            OParray[1] = 0x100;
            OParray[2] = 0x180;
            OParray[3] = 0x190;
            break;
    }
//asm
    for (addy = sRangeLo; addy < sRangeHi; addy += ioinc) {
//        SPLOG;
        //extended options here
        //impliment or equal here - remember checking if both data are loaded        
        //change to if true turn off...
//        if (xsearch(addy,NewVal,OldVal)) { continue; }
        if (!(get_bitflag(Results, addy / ioinc))) { continue; }
        NewVal = getdata(NewData,addy);
        if (OldData) OldVal = getdata(OldData,addy);
        if (xsearch(addy,NewVal,OldVal)) { continue; }
        switch (stype) {
            case 1: //known value
                if (NewVal != iValue1) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 2: //greater than
                if (xOpt & 1) {
                    if ((s64)NewVal <= (s64)OldVal) { set_bitflag(Results,addy / ioinc,0); }                     
                } else if (NewVal <= OldVal) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 3: //greater than by
                if (xOpt & 1) {
                    if (((s64)NewVal != ((s64)OldVal + iValue1)) || ((s64)NewVal <= (s64)OldVal)) { set_bitflag(Results,addy / ioinc,0); }                     
                } else if ((NewVal != (OldVal + iValue1)) || (NewVal <= OldVal)) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 4: //greater than by at least
                if (xOpt & 1) {
                    if (((s64)NewVal < ((s64)OldVal + iValue1)) || ((s64)NewVal <= (s64)OldVal)) { set_bitflag(Results,addy / ioinc,0); }                     
                } else if ((NewVal < (OldVal + iValue1)) || (NewVal <= OldVal)) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 5: //greater than by at most
                if (xOpt & 1) {
                    if (((s64)NewVal > ((s64)OldVal + iValue1)) || ((s64)NewVal <= (s64)OldVal)) { set_bitflag(Results,addy / ioinc,0); }                     
                } else if ((NewVal > (OldVal + iValue1)) || (NewVal <= OldVal)) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 6: //less than
                if (xOpt & 1) {
                    if ((s64)NewVal >= (s64)OldVal) { set_bitflag(Results,addy / ioinc,0); }                     
                } else if (NewVal >= OldVal) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 7: //less than by
                if (xOpt & 1) {
                    if (((s64)NewVal != ((s64)OldVal - iValue1)) || ((s64)NewVal >= (s64)OldVal)) { set_bitflag(Results,addy / ioinc,0); }                     
                } else if ((NewVal != (OldVal - iValue1)) || (NewVal >= OldVal)) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 8: //less than by at least
                if (xOpt & 1) {
                    if (((s64)NewVal > ((s64)OldVal - iValue1)) || ((s64)NewVal >= (s64)OldVal)) { set_bitflag(Results,addy / ioinc,0); }                     
                } else if ((NewVal > (OldVal - iValue1)) || (NewVal >= OldVal)) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 9: //less than by at most
                if (xOpt & 1) {
                    if (((s64)NewVal < ((s64)OldVal - iValue1)) || ((s64)NewVal >= (s64)OldVal)) { set_bitflag(Results,addy / ioinc,0); }                     
                } else if ((NewVal < (OldVal - iValue1)) || (NewVal >= OldVal)) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 10: //equal to
                if (NewVal != OldVal) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 11: //equal to # of bits
                if (BitCount(NewVal) != iValue1) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 12: //not equal to
                if (NewVal == OldVal) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 13: //not equal to value
                if (NewVal == iValue1) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 14: //not equal by
                if (xOpt & 1) {
                    if ((((s64)NewVal != ((s64)OldVal + iValue1)) || ((s64)NewVal <= (s64)OldVal)) &&
                        (((s64)NewVal != ((s64)OldVal - iValue1)) || ((s64)NewVal >= (s64)OldVal))){ set_bitflag(Results,addy / ioinc,0); }                     
                } else if (((NewVal != (OldVal + iValue1)) || (NewVal <= OldVal)) &&
                           ((NewVal != (OldVal - iValue1)) || (NewVal >= OldVal))) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 15: //not equal by at least
                if (xOpt & 1) {
                    if ((((s64)NewVal < ((s64)OldVal + iValue1)) || ((s64)NewVal <= (s64)OldVal)) &&
                        (((s64)NewVal > ((s64)OldVal - iValue1)) || ((s64)NewVal >= (s64)OldVal))){ set_bitflag(Results,addy / ioinc,0); }                     
                } else if (((NewVal < (OldVal + iValue1)) || (NewVal <= OldVal)) &&
                           ((NewVal > (OldVal - iValue1)) || (NewVal >= OldVal))) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 16: //not equal by at most
                if (xOpt & 1) {
                    if ((((s64)NewVal > ((s64)OldVal + iValue1)) || ((s64)NewVal <= (s64)OldVal)) &&
                        (((s64)NewVal < ((s64)OldVal - iValue1)) || ((s64)NewVal >= (s64)OldVal))){ set_bitflag(Results,addy / ioinc,0); }                     
                } else if (((NewVal > (OldVal + iValue1)) || (NewVal <= OldVal)) &&
                           ((NewVal < (OldVal - iValue1)) || (NewVal >= OldVal))) { set_bitflag(Results,addy / ioinc,0); }  
                break;
            case 17: //not equal to # bits
                if (BitCount(NewVal) == iValue1) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 18: //not equal to by number of bits
                if (BitCount(NewVal ^ OldVal) != iValue1) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 19: //in-range
                if (xOpt & 1) {
                    if (((s64)NewVal < (s64)iValueLow) || ((s64)NewVal > (s64)iValueHigh)) { set_bitflag(Results,addy / ioinc,0); }
                } else if ((NewVal < iValueLow) || (NewVal > iValueHigh)) { set_bitflag(Results,addy / ioinc,0); }    
                break;
            case 20: //not in-range
                if (xOpt & 1) {
                    if (((s64)NewVal > (s64)iValueLow) || ((s64)NewVal < (s64)iValueHigh)) { set_bitflag(Results,addy / ioinc,0); }
                } else if ((NewVal > iValueLow) || (NewVal < iValueHigh)) { set_bitflag(Results,addy / ioinc,0); }    
                break;
            case 21: case 22: //text
                if (stype == 22) NewVal = ucase64(NewVal);
                if (NewVal != iValue1) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 23: case 24: case 26: //Wild Value
                if (stype == 24) NewVal = ucase64(NewVal);
                if ((NewVal & iValueHigh) != iValueLow) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 27: case 28: //known-not list
                if (stype == 27) { set_bitflag(Results,addy / ioinc,0); }
                for (i = 1; i <= iValueList[0]; i++) {
                    if (NewVal == iValueList[i]) {
                        if (stype == 27) { set_bitflag(Results,addy / ioinc,1); }
                        else set_bitflag(Results,addy / ioinc,0);
                    }    
                }
                break;    
            case 29: //Bits On Any
                if ((NewVal & iValue1) == 0) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 30: //Bits On All
                if ((NewVal & iValue1) != iValue1) { set_bitflag(Results,addy / ioinc,0); }
                break;
            case 31: //lui+addiu/ori/lb
                set_bitflag(Results,addy / ioinc,0);
                if ( ((NewVal & 0xFFFF) == (iValue1>>16)) || ( (((NewVal & 0xFFFF) - 0x0001) == (iValue1>>16)) && ((iValue1 & 0xFFFF) > 0x7FFF)) ) {
                    for (tmpaddy = addy + 4; tmpaddy < (addy + 0x20); tmpaddy += 4) {
                        OldVal = getdata(NewData,tmpaddy);
                        if ((OldVal & 0xFFFF) == (iValue1 & 0xFFFF)) {
                            set_bitflag(Results,addy / ioinc,1);
                            break;
                        }
                    }
                }            
                break;
            case 32: case 33: case 38: //ADDIU/ORI/etc *,*,value
                set_bitflag(Results,addy / ioinc,0);
                if (stype == 38) { i = 5; }
                else { i = 0; }
                for (i = i; i <= 7; i++) {
                    if (OParray[i] == 256) break;
                    if ( (( ((NewVal>>21) & 0x1F) == 0) || (stype >= 33)) && ((NewVal>>26) == OParray[i]) && ((NewVal & 0xFFFF) == iValue1)) {
                        set_bitflag(Results,addy / ioinc,1);
                        break;
                    }
                }                            
                break;
            case 34: //lui/mtc1
                set_bitflag(Results,addy / ioinc,0);
                if ( ((NewVal>>26) == 15) && (iValue1 == (NewVal & 0xFFFF))) {
                    for (tmpaddy = addy + 4; tmpaddy <= (addy + 0x20); tmpaddy += 4) {
                        OldVal = getdata(NewData,tmpaddy);
                        for (i = 0; i <= 5; i++) {
                            if (OParray[i] == 0) break;
                            if (((OldVal>>21) == OParray[i]) && ((OldVal & BITS(11)) == 0) && (((NewVal>>16) & 0x1F) == ((OldVal>>16) & 0x1F))) {
                                set_bitflag(Results,addy / ioinc,1);
                                break;
                            }
                        }    
                    }    
                }                            
                break;
            case 35: //opcode
                if ((NewVal & iValueHigh) != iValueLow) {
                    set_bitflag(Results,addy / ioinc,0);
                }    
                break;
            case 36: //mtc0 enabler
                set_bitflag(Results,addy / ioinc,0);
                if ((NewVal & iValueHigh) == iValueLow) {
                    if ( ((NewVal & (BITS(5)<<11)) == (0x12<<11)) || ((NewVal & (BITS(5)<<11)) == (0x13<<11)) ) {
                        set_bitflag(Results,addy / ioinc,1);
                    }    
                }    
                break;
            case 37: //80000180 enabler
                set_bitflag(Results,addy / ioinc,0);
                for (i = 0; i <= 3; i++) {
                    if ((NewVal & 0xFFFF) == OParray[i]) {
                        for (tmpaddy = addy - 4; tmpaddy >= 0; tmpaddy -= 4) {
                            if (tmpaddy < (addy - 0x20)) break;
                            OldVal = getdata(NewData,tmpaddy);
                            if ( ((OldVal>>26) == 15) && ((OldVal & 0xFFFF) == 0x8000)  ) {
                                set_bitflag(Results,addy / ioinc,1);
                                break;
                            } 
                        }        
                    }    
                }    
                break;
        }
        if (get_bitflag(Results, addy / ioinc)) { rescount++; }
    }
    if (xOpt & 0xF0000) FilterResults();
}        
void FilterResults() {
    int addy;
    int i;
    int matches;
    u64 Val1;
    u64 Val2;
    for (addy = 0; addy < filesize; addy += ioinc) {
        if (!(get_bitflag(Results, addy / ioinc))) { continue; }
        matches = 1;
        Val1 = getdata(NewData,addy);
        for (i = (addy + ioinc); i < filesize; i += ioinc) {
            Val2 = getdata(NewData,i);
            if (xOpt & 0x10000) {
                if (!(get_bitflag(Results, i / ioinc))) break;
            }
            else if (xOpt & 0x20000) {
                if ((!(get_bitflag(Results, i / ioinc))) || (Val1 != Val2)) break;
            }
            else if (xOpt & 0x40000) {
                if (!(get_bitflag(Results, i / ioinc))) break;                    
            }
            else if (xOpt & 0x80000) {
                if ((!(get_bitflag(Results, i / ioinc))) || (Val1 != Val2)) break;
            }
            matches++;
        }
        if (((matches >= ConsecRes) && (xOpt & 0x30000)) ||
            ((matches < ConsecRes) && (xOpt & 0xC0000))) {
            for (addy=addy; addy < i; addy += ioinc) {
                set_bitflag(Results, addy / ioinc,0);
                rescount--;
            }
            addy -= ioinc;    
        } else {
            addy = i - ioinc; 
        }   
    }    
}                   
        

