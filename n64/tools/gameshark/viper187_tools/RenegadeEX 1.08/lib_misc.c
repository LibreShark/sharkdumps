/*************************************************************************
*RenegadeEx
*
*Copyright notice for this file:
*Copyright (C) 2008 Viper187 / Psycho Snake Creations
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
#include "main.h"

/**********************************************
Filter Hex chars
***********************************************/
int FilterHexChar(int lvalue) {
    return isxdigit(lvalue) ? lvalue : 0;
    /*
    if ((lvalue >= '0') && (lvalue <= '9')) return lvalue;
    else if ((lvalue >= 'a') && (lvalue <= 'f')) return lvalue - 32;
    else if ((lvalue >= 'A') && (lvalue <= 'F')) return lvalue;
    return 0;
    */
}

/**********************************************
IsHex
***********************************************/
int isHex(char* text) {
    int i;
    if (strlen(text) <= 0) { return 0; }
    for (i = 0; i < strlen(text); i++) {
        if (!isxdigit(text[i])) { return 0; }
    }
    return 1;
}

/**********************************************
IsDec
***********************************************/
int isDec(char* text) {
    int i;
    if (strlen(text) <= 0) { return 0; }
    for (i = 0; i < strlen(text); i++) {
        if (!isdigit(text[i])) { return 0; }
    }
    return 1;
}

/**********************************************
IsFloat
***********************************************/
int isFloat(char* text) {
    int i;
    if (strlen(text) <= 0) { return 0; }
    for (i = 0; i < strlen(text); i++) {
        if ((!isdigit(text[i])) && (text[i] != '.') && (text[i] != '-')) { return 0; }
    }
    return 1;
}

/**********************************************
Float 2 Hex
***********************************************/
u64 Float2Hex(float floatval)
{
    u64 hvalue=0;
    u64 *castfloat=(u64*)&floatval;
    hvalue = *castfloat;
    return (hvalue & 0xFFFFFFFF);
}

/**********************************************
Double 2 Hex
***********************************************/
u64 Double2Hex(double dblval)
{
    u64 hvalue=0;
    u64 *castdouble=(u64*)&dblval;
    hvalue = *castdouble;
    return hvalue;
}


/**********************************************
LCase String
***********************************************/
int str_lcase(char *str) {
	int i=0,j=0;
	while (i < strlen(str)) {
		if ((str[i] >= 'A') && (str[i] <= 'Z')) {
			str[i] |= 0x20;
			j++;
		}
		i++;
	}
	return j;
}

/**********************************************
StringCompareCI
***********************************************/
int StringCompareCI(char* string1, char* string2) {
    int i;
    if (strlen(string1) != strlen(string2)) { return 1; }
    for (i = 0; i < strlen(string1); i++) {
        if (toupper(string1[i]) != toupper(string2[i])) { return 1; }
    }
    return 0;
}

/**********************************************************************
Set/Get Bit Flag:
Set a bit flag for an address. Usually for search result purposes.
1 bit for every possible result based on file size and number of
bytes being searched at a time. - Parasyte came up with this years ago.
***********************************************************************/
int SetBitFlag(u8 *flags, int num, int val) {
	int index,bit;

	index = (num >> 3); //divide by 8... because there are 8 bits in a byte!
	bit = (num & 7); //choose the correct bit, based on lower three bits in 'num'

	if (val) flags[index] |= (1 << bit); //set the flag
	else flags[index] &= ~(1 << bit); //unset the flag
	return 0;
}
int GetBitFlag(u8 *flags, int num) {
	int index,bit;

	index = (num >> 3); //divide by 8... because there are 8 bits in a byte!
	bit = (num & 7); //choose the correct bit, based on lower three bits in 'num'

	return (!!(flags[index] & (1 << bit))); //return the NOT-NOT of the tested flag
	//(NOT-NOT reduces any value to either a 0 or a 1, depending on if the value is 0 or not! :D)
}

/**********************************************
Bit Count - count number of active bits in a u64
***********************************************/
int BitCount(u64 countval)
{
    int bitcnt = 0;
    int bit;
    for (bit = 0; bit < 64; bit++) {
        if (countval & 1) bitcnt++;
        countval >>= 1;
    }
    return bitcnt;
}

/**********************************************
Sign Extend
***********************************************/
u64 SignExtend64(u64 signval, int sbytes)
{
    if (signval & (0x80LL << ((sbytes - 1) * 8))) { return signval | (u64)(0xFFFFFFFFFFFFFF00LL << ((sbytes - 1) * 8)); }
    return signval;
}

/**********************************************
Byte/Short/Word from u64 - counted from left to right
***********************************************/
u64 ByteFromU64(u64 dword, int valpart) {
    return (dword >> ((7 - valpart) * 8)) & 0xFF;
}

u64 ShortFromU64(u64 dword, int valpart) {
    return (dword >> (48 - (valpart * 16))) & 0xFFFF;
}

u64 WordFromU64(u64 dword, int valpart) {
    return (dword >> (32 - (valpart * 32))) & 0xFFFFFFFF;
}

/**********************************************
Hex 2 ASCII
***********************************************/
int Hex2ASCII(u64 value, int bytes, char *string)
{
    int i;
    for(i = 0; i < bytes; i++) {
        string[i] = ByteFromU64(value, (8 - bytes) + i);
        if (!isprint(string[i])) { string[i] = 46; }
    }
    string[bytes] = '\0';
    return 0;
}
/**********************************************
FlipBytes - reverse endian
***********************************************/
u64 FlipBytes(u64 value, int size)
{
    int i;
    u64 newvalue = 0;
    switch(size)
    {
        case 2:
        {
            newvalue = (value >> 8)|((value & 0xFF) << 8);
        } break;
        case 4: case 8:
        {
            for (i = 0; i < 4; i++) { newvalue |= ByteFromU64(value, i) << (8*(4+i)); }
            for (i = 0; i < 4; i++) { newvalue |= ByteFromU64(value, i + 4) << (8*i); }
        } break;
        default: newvalue = value;
    }
    return newvalue;
}
