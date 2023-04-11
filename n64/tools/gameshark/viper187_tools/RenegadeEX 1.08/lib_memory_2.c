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


/**********************************************************************
Get Search Values -- NewRAM or NewFile must be loaded before calling this
***********************************************************************/
u64 GetSearchValues(u64 *NewVal, u64 *OldVal, int index, int size, int endian)
{
    int i;
//    u64 tmpvalue = 0;
    *NewVal = 0;
    if(RamInfo.OldRAM) {  *OldVal = 0; }
    if (RamInfo.Access == SEARCH_ACCESS_ARRAY) {
        switch (endian)
        {
            case LITTLE_ENDIAN_SYS:
            {
                switch (size)
                {
                    case 1:
                    {
                        *NewVal = RamInfo.NewRAM[index];
                        if(RamInfo.OldRAM) { *OldVal = RamInfo.OldRAM[index]; }
                    } return 1;
                    case 2:
                    {
                        *NewVal = *(u16*)(&RamInfo.NewRAM[index]);
                        if(RamInfo.OldRAM) { *OldVal = *(u16*)(&RamInfo.OldRAM[index]); }
                    } return 1;
                    case 4:
                    {
                        *NewVal = *(u32*)(&RamInfo.NewRAM[index]);
                        if(RamInfo.OldRAM) { *OldVal = *(u32*)(&RamInfo.OldRAM[index]); }
                    } return 1;
                    case 8:
                    {
                        *NewVal = MAKEU64(*(u32*)(&RamInfo.NewRAM[index+4]),*(u32*)(&RamInfo.NewRAM[index]));
                        if(RamInfo.OldRAM) { *OldVal = MAKEU64(*(u32*)(&RamInfo.OldRAM[index+4]),*(u32*)(&RamInfo.OldRAM[index])); }
                    } return 1;
                }
            } break;
            case LITTLE_ENDIAN_BIG_SYS:
            {
                switch (size)
                {
                    case 1:
                    {
                        *NewVal = *(u8*)&RamInfo.NewRAM[index^3];
                        if(RamInfo.OldRAM) { *OldVal = *(u8*)&RamInfo.OldRAM[index^3]; }
                    } return 1;
                    case 2:
                    {
                        *NewVal = *(u16*)(&RamInfo.NewRAM[index^2]);
                        if(RamInfo.OldRAM) { *OldVal = *(u16*)(&RamInfo.OldRAM[index^2]); }
                    } return 1;
                    case 4:
                    {
                        *NewVal = *(u32*)(&RamInfo.NewRAM[index]);
                        if(RamInfo.OldRAM) { *OldVal = *(u32*)(&RamInfo.OldRAM[index]); }
                    } return 1;
                    case 8:
                    {
                        *NewVal = MAKEU64(*(u32*)(&RamInfo.NewRAM[index+4]),*(u32*)(&RamInfo.NewRAM[index]));
                        if(RamInfo.OldRAM) { *OldVal = MAKEU64(*(u32*)(&RamInfo.OldRAM[index+4]),*(u32*)(&RamInfo.OldRAM[index])); }
                    } return 1;
                }
            } break;
            case BIG_ENDIAN:
            {
                for (i = 0; i < size; i++) {
                    *NewVal |= (((u64)RamInfo.NewRAM[index + i]) << (8 * (size - i - 1)));
                    if(RamInfo.OldRAM) { *OldVal |= (((u64)RamInfo.OldRAM[index + i]) << (8 * (size - i - 1))); }
                }
            }  return 1;
        }
    } else {
        switch (endian)
        {
            case LITTLE_ENDIAN_SYS:
            {
                fseek(RamInfo.NewFile,index,SEEK_SET);
                if (RamInfo.OldFile) { fseek(RamInfo.OldFile,index,SEEK_SET); }
                switch (size)
                {
                    case 1:
                    {
                        *NewVal = getc(RamInfo.NewFile);
                        if (RamInfo.OldFile) { *OldVal = getc(RamInfo.OldFile); }
                    } return 1;
                    case 2:
                    {
                        *NewVal = getc(RamInfo.NewFile) | (getc(RamInfo.NewFile)<<8);
                        if (RamInfo.OldFile) { *OldVal = getc(RamInfo.OldFile) | (getc(RamInfo.OldFile)<<8); }
                    } return 1;
                    case 4:
                    {
                        *NewVal = getw(RamInfo.NewFile);
                        if (RamInfo.OldFile) { *OldVal = getw(RamInfo.OldFile); }
                    } return 1;
                    case 8:
                    {
                        *NewVal = ((u64)getw(RamInfo.NewFile)<<32) | getw(RamInfo.NewFile);
                        if (RamInfo.OldFile) { *OldVal = ((u64)getw(RamInfo.OldFile)<<32) | getw(RamInfo.OldFile); }
                    } return 1;
                }
            } break;
            case LITTLE_ENDIAN_BIG_SYS:
            {
                switch (size)
                {
                    case 1:
                    {
                        fseek(RamInfo.NewFile,index^3,SEEK_SET);
                        *NewVal = getc(RamInfo.NewFile);
                        if (RamInfo.OldFile) {
                            fseek(RamInfo.OldFile,index^3,SEEK_SET);
                            *OldVal = getc(RamInfo.OldFile);
                        }
                    } return 1;
                    case 2:
                    {
                        fseek(RamInfo.NewFile,index^2,SEEK_SET);
                        *NewVal = getc(RamInfo.NewFile) | (getc(RamInfo.NewFile)<<8);
                        if (RamInfo.OldFile) {
                            fseek(RamInfo.OldFile,index^2,SEEK_SET);
                            *OldVal = getc(RamInfo.OldFile) | (getc(RamInfo.OldFile)<<8);
                        }
                    } return 1;
                    case 4:
                    {
                        fseek(RamInfo.NewFile,index,SEEK_SET);
                        *NewVal = getw(RamInfo.NewFile);
                        if (RamInfo.OldFile) {
                            fseek(RamInfo.OldFile,index,SEEK_SET);
                            *OldVal = getw(RamInfo.OldFile);
                        }
                    } return 1;
                    case 8:
                    {
                        fseek(RamInfo.NewFile,index,SEEK_SET);
                        *NewVal = ((u64)getw(RamInfo.NewFile)<<32) | getw(RamInfo.NewFile);
                        if (RamInfo.OldFile) {
                            fseek(RamInfo.OldFile,index,SEEK_SET);
                            *OldVal = ((u64)getw(RamInfo.OldFile)<<32) | getw(RamInfo.OldFile);
                        }
                    } return 1;
                }
            } break;
            case BIG_ENDIAN:
            {
                fseek(RamInfo.NewFile,index,SEEK_SET);
                if (RamInfo.OldFile) { fseek(RamInfo.OldFile,index,SEEK_SET); }
                for (i = 0; i < size; i++) {
                    *NewVal |= (((u64)getc(RamInfo.NewFile)) << (8 * (size - i - 1)));
                    if (RamInfo.OldFile) { *OldVal |= (((u64)getc(RamInfo.OldFile)) << (8 * (size - i - 1))); }
                }
            }  return 1;
        }
    }
    return 0;
}

