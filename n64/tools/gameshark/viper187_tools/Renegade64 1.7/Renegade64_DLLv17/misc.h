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
#ifndef _MISC_H_
#define _MISC_H_
#include "types.h"

//main
void DoSearch();
int loadfile(u8 **buffer, LPSTR filename, int headerlen);
int xsearch(int idx,u64 tmpNew,u64 tmpOld);
void FilterResults();
int readheader();
int setheader();
void getfmtstring(char *tmpstring,char outfmt);
void getfmtstring2(char *tmpstring,char outfmt);
int PrintResults(char outfmt);
/*
void PrintLog();
*/
//misc
//int getu64(u64 *out, char *num);
int str_ucase(char *str);
void set_bitflag(u8 *flags, int num, int val);
int get_bitflag(u8 *flags, int num);
u64 getdata(u8 *data,int index);
void signxt(u64 *signval);
void signxt2(u64 *signval,int sbytes);
u64 getdataxt(u8 *data, int index, int xtbytes);
u64 getbyte(u64 dword, int valpart);
u64 getshort(u64 dword, int valpart);
u64 getword(u64 dword, int valpart);
char chr_ucase(char lvalue);
int chr2val(int lvalue);
int BitCount(u64 countval);
u64 getdataES(u8 *data,u32 index);
//misc 2
void SetByteInfo();
u64 ucase64(u64 value);
//n64dis
int DisN64(u32 dval, char *txtop, int addy);
char* N64GPR(u32 disvalue, int regpos);
char* SPC(int spcval);
u32 BITS(int numbits);
int btarget(int addy, int disvalue);
char* N64COP0(u32 disvalue, int regpos);
char* N64COP1(u32 disvalue, int regpos);
char N64FPFMT(u32 disvalue, int regpos);
int d64type0(u32 dval, char *txtop);
int d64type1(u32 dval, char *txtop, int addy);
int d64type2(u32 dval, char *txtop, int addy);
int isFMT(u32 disvalue, int regpos);
#endif //_MISC_H_
