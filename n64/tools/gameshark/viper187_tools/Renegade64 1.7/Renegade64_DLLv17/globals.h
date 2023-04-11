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
#ifndef _GLOBALS_H_
#define _GLOBALS_H_
#include "types.h"

//#if 0 // Change to #if 0 to disable SP Logging

//#define SPLOG unsigned long sp; \
//asm volatile ("movl %%esp,%0" : "=g"(sp) : : "memory"); \
//fprintf(spLog, "%08X\n", sp)

//#else

//#define SPLOG

//#endif
#define isprint(n) (((n) >= 0x20) && ((n) <= 0x7E))
//#define RAM_CHUNK_SIZE 0x800000
extern FILE *spLog;
//extern int searchnum;
extern u32 rescount;
    extern int iotype;
    extern int iosize;
    extern int stype;
    extern int ioinc;
    extern int iobytes;
    extern int header;
    extern int filefmt;
    extern int filesize;
extern u8 *Results;
extern u8 *OldData;
extern u8 *NewData;
extern u8 *DisData;
    extern u64 iValue1;
    extern u64 iValueLow;
    extern u64 iValueHigh;
extern u8 *hData;
extern int nfoheader;
//extern char *iotypetxt[5];
extern u32 xOpt;
extern u64 xValue1;
extern u64 xValueLow1;
extern u64 xValueHigh1;
extern u64 xValueLow2;
extern u64 xValueHigh2;
extern u64 xByte;
extern u64 xByteLow;
extern u64 xByteHigh;
extern u64 xShort;
extern u64 xShortLow;
extern u64 xShortHigh;
extern u64 xWord;
extern u64 xWordLow;
extern u64 xWordHigh;
extern u64 xDword;
extern u64 xDwordLow;
extern u64 xDwordHigh;
extern u64 pnt64low;
extern u64 pnt64high;
extern u32 sRangeLo;
extern u32 sRangeHi;
//extern char iString[128];
extern int ConsecRes;
extern LPSTR NewFile;
extern LPSTR OldFile;
extern LPSTR NewResFile;
extern LPSTR OldResFile;
extern LPSTR iString;
//extern u8 restype;
//char *blank;
extern u32 iValueList[100];

#endif //_GLOBALS_H_

