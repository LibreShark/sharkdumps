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

//extern int filefmt;
//extern int iobytes;
//extern int ioinc;
//extern int iosize;

int str_ucase(char *str) {
	int i=0,j=0;
	while (i < strlen(str)) {
		if ((str[i] >= 'a') && (str[i] <= 'z')) {
			str[i] &= ~0x20;
			j++;
		}
		i++;
	}
	return j;
}
char chr_ucase(char lvalue) {
    if ((lvalue >= 'a') && (lvalue <= 'z')) lvalue &= ~0x20;
    return lvalue;
}
u64 ucase64(u64 value) {
    u64 outval=0;
    unsigned char letter=0;
    int l;
    for (l = 0; l < 8; l++) {
        letter = value >> (l * 8) & 0xFF;
        if ((letter >= 'a') && (letter <= 'z')) letter &= ~0x20;
        outval |= (u64)letter << (l * 8);
    }
    return outval;
}   
int chr2val(int lvalue) {
    int lvalue2 = 255;
    if ((lvalue >= '0') && (lvalue <= '9')) lvalue2 = lvalue - 48;
    else if ((lvalue >= 'A') && (lvalue <= 'F')) lvalue2 = lvalue - 55;
    return lvalue2;
}
void set_bitflag(u8 *flags, int num, int val) {
	int index,bit;
 
	index = (num >> 3); //divide by 8... because there are 8 bits in a byte!
	bit = (num & 7); //choose the correct bit, based on lower three bits in 'num'
 
	if (val) flags[index] |= (1 << bit); //set the flag
	else flags[index] &= ~(1 << bit); //unset the flag
}
 
int get_bitflag(u8 *flags, int num) {
	int index,bit,result;
 
	index = (num >> 3); //divide by 8... because there are 8 bits in a byte!
	bit = (num & 7); //choose the correct bit, based on lower three bits in 'num'
 
	return (!!(flags[index] & (1 << bit))); //return the NOT-NOT of the tested flag
	//(NOT-NOT reduces any value to either a 0 or a 1, depending on if the value is 0 or not! :D)
}
u64 getdata(u8 *data, int index) {
    int i;
    u64 dvalue = 0;
    for (i = 0; i < iobytes; i++) {
             dvalue |= (((u64)data[index + i]) << (8 * (iobytes - i - 1)));
    }
    if (xOpt & 1) signxt(&dvalue);
    return dvalue;                
}
u64 getdataxt(u8 *data, int index, int xtbytes) {
    int i;
    u64 dvalue = 0;
    for (i = 0; i < xtbytes; i++) {
             dvalue |= (((u64)data[index + i]) << (8 * (xtbytes - i - 1)));
    }
    return dvalue;                
}
u64 getdataES(u8 *data, u32 index) {
    int i;
    u64 dvalue = 0;
    index &= 7;
    switch (filefmt) {
        case 0: //32-bit Little Endian
            for (i = 0; i < iobytes; i++) {
                dvalue |= (((u64)data[(index + i)^3]) << (8 * (iobytes - i - 1)));
            }
            break;
        case 1: //16-bit Little Endian
            for (i = 0; i < iobytes; i++) {
                dvalue |= (((u64)data[(index + i)^1]) << (8 * (iobytes - i - 1)));
            }
            break;
        case 2: //Big Endian
            for (i = 0; i < iobytes; i++) {
                dvalue |= (((u64)data[index + i]) << (8 * (iobytes - i - 1)));
            }
            break;
        case 3: // Littlte Endian System
            if (iobytes == 1) {
                for (i = 0; i < iobytes; i++) {
                    dvalue |= (((u64)data[index + i]) << (8 * (iobytes - i - 1)));
                }
            }
            else if (iobytes == 2) {
                dvalue = (((u64)data[index+1]) << 8);
                dvalue |= ((u64)data[index]);
            }
            else {        
                for (i = 0; i < iobytes; i++) {
                    dvalue |= (((u64)data[(index + i)^3]) << (8 * (iobytes - i - 1)));
                }
            }
            break;    
    }    
    if (xOpt & 1) signxt(&dvalue);
    return dvalue;                
}
void signxt(u64 *signval) {
    if (*signval & (0x80LL << ((iobytes - 1) * 8))) { *signval |= (0xFFFFFFFFFFFFFF00LL << ((iobytes - 1) * 8)); }
}
void signxt2(u64 *signval,int sbytes) {
    if (*signval & (0x80LL << ((sbytes - 1) * 8))) { *signval |= (0xFFFFFFFFFFFFFF00LL << ((sbytes - 1) * 8)); }
}
u64 getbyte(u64 dword, int valpart) {
    dword = (dword >> ((7 - valpart) * 8)) & 0xFF;
    if (xOpt & 1) signxt2(&dword,1);
    return dword;
}                
u64 getshort(u64 dword, int valpart) {
    dword = (dword >> (48 - (valpart * 16))) & 0xFFFF;
    if (xOpt & 1) signxt2(&dword,2);
    return dword;
}                
u64 getword(u64 dword, int valpart) {
    if (valpart) dword &= 0xFFFFFFFF;
    else dword >>= 32;
    if (xOpt & 1) signxt2(&dword,4);    
    return dword;
}                
int BitCount(u64 countval) {
    int bitcnt = 0;
    int bit;
    for (bit = 0; bit < (iobytes * 8); bit++) {
        if (countval & 1) bitcnt++;
        countval >>= 1;
    }
    return bitcnt;
}
void SetByteInfo() {
    switch (iosize) {
        case 1: //8-bit
            iobytes = 1;
            ioinc = 1;
            break;    
        case 2: //16-bit
            iobytes = 2;
            ioinc = 2;    
            break;    
        case 3: //16-bit unaligned
            iobytes = 2;
            ioinc = 1;
            break;

        case 4: case 5: //16-bit upper/lower
            iobytes = 2;
//            ioinc = 4;
            ioinc = 2;
            break;

        case 6: //24-bit
            iobytes = 3;
            ioinc = 1;
            break;    
        case 7: //32-bit
            iobytes = 4;
            ioinc = 4;
            break;    
        case 8: //32-bit unligned
            iobytes = 4;
            ioinc = 1;
            break;    
        case 9: //40-bit
            iobytes = 5;
            ioinc = 1;
            break;    
        case 10: //48-bit
            iobytes = 6;
            ioinc = 1;
            break;    
        case 11: //56-bit
            iobytes = 7;
            ioinc = 1;
            break;    
        case 12: //64-bit
            iobytes = 8;
            ioinc = 8;
            break;    
        case 13: //64-bit unaligned
            iobytes = 8;
            ioinc = 1;
            break;    
    }        
}    

