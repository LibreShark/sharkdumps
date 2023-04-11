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

FILE *spLog;
//search globals
//int searchnum;
u32 rescount = 0;
    int iotype;
    int iosize;
    int stype;
    int ioinc;
    int iobytes;
    int header = 0;
    int filefmt;
    int filesize;
u8 *Results;
u8 *OldData;
u8 *NewData;
u8 *DisData;
    u64 iValue1;
    u64 iValueLow;
    u64 iValueHigh;
u8 *hData;
int nfoheader = 0x12C;
//char *iotypetxt[5] = { "WTF!?", "Hex", "Decimal", "Float", "Double" };
u32 xOpt = 0;
u64 xValue1;
u64 xValueLow1;
u64 xValueHigh1;
u64 xValueLow2;
u64 xValueHigh2;
u64 xByte;
u64 xByteLow;
u64 xByteHigh;
u64 xShort;
u64 xShortLow;
u64 xShortHigh;
u64 xWord;
u64 xWordLow;
u64 xWordHigh;
u64 xDword;
u64 xDwordLow;
u64 xDwordHigh;
u64 pnt64low;
u64 pnt64high;
//char iString[128];
int ConsecRes;
LPSTR NewFile;
LPSTR OldFile;
LPSTR NewResFile;
LPSTR OldResFile;
LPSTR iString;
//char *blank = "";
//u8 restype;
u32 iValueList[100];
u32 sRangeLo;
u32 sRangeHi;

s32 __declspec(dllexport) CALLBACK SLL(u32 value, int shift)
{
	return (s32)(value << shift);
}
s32 __declspec(dllexport) CALLBACK SRL(u32 value, int shift)
{
	return (s32)(value >> shift);
}
float __declspec(dllexport) CALLBACK Long2Single(u32 value)
{
	float tmp=0;
	u32 *tmp2=(u32*)(&tmp);
	*tmp2 = value;
	return tmp;
}
s32 __declspec(dllexport) CALLBACK Single2Long(float value)
{
	float tmp=0;
	u32 *tmp2=(u32*)(&tmp);
	tmp = value;
	return (s32)*tmp2;
}
s32 __declspec(dllexport) CALLBACK Double2LLUpper(double value)
{
	double tmp=0;
	u64 *tmp2=(u64*)(&tmp);
	LPSTR outval;
	tmp = value;
	return (s32)(*tmp2>>32);
}
s32 __declspec(dllexport) CALLBACK Double2LLLower(double value)
{
	double tmp=0;
	u64 *tmp2=(u64*)(&tmp);
	LPSTR outval;
	tmp = value;
	return (s32)(*tmp2 & 0xFFFFFFFF);
}
/*
double __declspec(dllexport) CALLBACK Long2Double(u32 left, u32 right)
{
	double tmp=0;
	u64 *tmp2=(u64*)(&tmp);
	*tmp2 = ((u64)right|(u64)left<<32);
	return tmp;
}
*/

/*
BSTR __declspec(dllexport) CALLBACK StringExample(BSTR stringVar)
{
	LPSTR buffer;
	buffer = (LPSTR)stringVar; // The address is coerced into an LPSTR.
	MessageBox(NULL,buffer,"in C++",0);
	buffer = _strrev(buffer);
	return (BSTR)buffer;
//	return(SysAllocString(stringVar)); // Since buffer has the address, the argument
									   // can still be returned.
}
*/

BOOL APIENTRY DllMain (HINSTANCE hInst     /* Library instance handle. */ ,
                       DWORD reason        /* Reason this function is being called. */ ,
                       LPVOID reserved     /* Not used. */ )
{
//    spLog = fopen("c:\\temp\\splog.txt","wt");
    switch (reason)
    {
      case DLL_PROCESS_ATTACH:
        break;

      case DLL_PROCESS_DETACH:
        break;

      case DLL_THREAD_ATTACH:
        break;

      case DLL_THREAD_DETACH:
        break;
    }

    /* Returns TRUE on success, FALSE on failure */
    return TRUE;
}
