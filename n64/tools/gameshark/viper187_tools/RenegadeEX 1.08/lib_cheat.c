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

int ApplyCodesPS2(int CodeNum, int cdButton);
int ApplyCodesN64(int CodeNum, int cdButton);
int ApplyCodesGBA(int CodeNum, int cdButton);
u32 BitModValue(u32 rValue, u32 iValue, int type);
BOOL CompareActivatorValue(u32 address, u64 value, int size, int type, int endian);

int ApplyCheats()
{
    int cdButton = ((GetAsyncKeyState(0xBB) & 32768) == 32768) ? 1 : 0;
    int i;
    for (i = 0; i < CODE_MAX_PER_GAME; i++)
    {
        if(!CheatDB.Codes[i].Active) { continue; }
        switch(CheatDB.System)
        {
            case CHEAT_PS2: case CHEAT_PC: { ApplyCodesPS2(i, cdButton); } break;
            case CHEAT_N64: case CHEAT_PS1: { ApplyCodesN64(i, cdButton); } break;
            case CHEAT_GBA_IRAM: case CHEAT_GBA_WRAM: { ApplyCodesGBA(i, cdButton); } break;
            case CHEAT_NDS: { ApplyCodesNDS(i, cdButton); } break;
        }
    }
    return 0;
}

/**************************************************************
ApplyCodesPS2- PS2/PC code handler
**************************************************************/
int ApplyCodesPS2(int CodeNum, int cdButton)
{
    u64 tmpValue = 0, tmpAddress = 0;
    int line, tmpType = 0;
    for(line = 0; line < CheatDB.Codes[CodeNum].LineCount; line++)
    {
        switch(CheatDB.Codes[CodeNum].Type[line])
        {
            case 0: case 1: case 2: //constant writes
            {
//sprintf(ErrTxt,"%d", CheatDB.Codes[CodeNum].Type[line]);
//MessageBox(NULL, ErrTxt, "Error", MB_OK);
                WriteRAM(CheatDB.Codes[CodeNum].Address[line], CheatDB.Codes[CodeNum].Value[line], 1 << CheatDB.Codes[CodeNum].Type[line], LITTLE_ENDIAN_SYS);
            } break;
            case 3: //inc/dec
            {
                tmpType = ((CheatDB.Codes[CodeNum].Address[line] >> 20) % 2) ? 0 : 1;
                int tmpSize = 1 << (((CheatDB.Codes[CodeNum].Address[line] >> 20) - 1)/2);
                if (tmpSize == 4) {
                    if ((line + 1) >= CheatDB.Codes[CodeNum].LineCount) { break; }
                    tmpValue = (CheatDB.Codes[CodeNum].Type[line] << 28)|CheatDB.Codes[CodeNum].Address[line+1];
                } else { tmpValue = CheatDB.Codes[CodeNum].Address[line] & 0xFFFF; }
                u64 tmpValue2 = 0;
                if (ReadRAM(CheatDB.Codes[CodeNum].Value[line], &tmpValue2, tmpSize, LITTLE_ENDIAN_SYS) == 0) { break; }
                tmpValue = BitModValue(tmpValue2, tmpValue, tmpType);
                WriteRAM(CheatDB.Codes[CodeNum].Value[line], tmpValue, tmpSize, LITTLE_ENDIAN_SYS);
            } break;
            case 4: //patch/serial repeater
            {
                if ((line + 1) >= CheatDB.Codes[CodeNum].LineCount) { break; }
                tmpAddress = CheatDB.Codes[CodeNum].Address[line];
                tmpValue = (CheatDB.Codes[CodeNum].Type[line+1]<<28)|CheatDB.Codes[CodeNum].Address[line+1];
                int patch;
                for (patch = 0; patch < (CheatDB.Codes[CodeNum].Value[line] >> 16); patch++)
                {
                    WriteRAM(tmpAddress, tmpValue, 4, LITTLE_ENDIAN_SYS);
                    tmpAddress += (CheatDB.Codes[CodeNum].Value[line] & 0xFF) * 4;
                    tmpValue += CheatDB.Codes[CodeNum].Value[line+1];
                }
                line++;
            } break;
            case 5: //Copy Bytes
            {
                if ((line + 1) >= CheatDB.Codes[CodeNum].LineCount) { break; }
                int i;
                for (i = 0; i < CheatDB.Codes[CodeNum].Value[line]; i++)
                {
                    if (ReadRAM(CheatDB.Codes[CodeNum].Address[line] + i, &tmpValue, 1, LITTLE_ENDIAN_SYS)) {
                        WriteRAM(CheatDB.Codes[CodeNum].Address[line+1] + i, tmpValue, 1, LITTLE_ENDIAN_SYS);
                    }
                }
                line++;
            } break;
            case 6: //Pointer Write
            {
                if ((line + 1) >= CheatDB.Codes[CodeNum].LineCount) { break; }
                ReadRAM(CheatDB.Codes[CodeNum].Address[line], &tmpAddress, 4, LITTLE_ENDIAN_SYS);
                if ((tmpAddress == 0) || (tmpAddress > 0x1FFFFFF)) { break; }
                WriteRAM(tmpAddress + CheatDB.Codes[CodeNum].Value[line+1], CheatDB.Codes[CodeNum].Value[line], 1 << (CheatDB.Codes[CodeNum].Address[line+1] >> 16), LITTLE_ENDIAN_SYS);
            } break;
            case 7: //Slide
            {
                tmpAddress = CheatDB.Codes[CodeNum].Address[line];
                u32 pCount = 0, pTotal = CheatDB.Codes[CodeNum].Value[line];
                while (pCount < pTotal)
                {
                    line++; if (line >= CheatDB.Codes[CodeNum].LineCount) { break; }
                    WriteRAM(tmpAddress + (pCount * 4), (CheatDB.Codes[CodeNum].Type[line] << 28)|CheatDB.Codes[CodeNum].Address[line], 4, LITTLE_ENDIAN_SYS);
                    pCount++; if (pCount >= pTotal) { break; }
                    WriteRAM(tmpAddress + (pCount * 4), CheatDB.Codes[CodeNum].Value[line], 4, LITTLE_ENDIAN_SYS);
                    pCount++;
                }
            } break;
            case 0xD: //16-bit Conditional Write
            {
                if (CompareActivatorValue(CheatDB.Codes[CodeNum].Address[line], CheatDB.Codes[CodeNum].Value[line] & 0xFFFF, 2, CheatDB.Codes[CodeNum].Value[line] >> 20, LITTLE_ENDIAN_SYS)) { break; }
                else {
                    while ((line + 1) < CheatDB.Codes[CodeNum].LineCount)
                    {
                        line ++;
                        if (CheatDB.Codes[CodeNum].Type[line] != 0xD) { break; }
                    }
                }
            } break;
            case 0xE: //16-bit Multi-Address Conditional Write
            {
                int tmpCount = 0;
                if (CheatDB.System == CHEAT_PS2) {
                    tmpAddress = CheatDB.Codes[CodeNum].Value[line] & 0xFFFFFFF;
                    tmpType = CheatDB.Codes[CodeNum].Value[line] >> 28;
                    tmpValue = CheatDB.Codes[CodeNum].Address[line] & 0xFFFF;
                    tmpCount = CheatDB.Codes[CodeNum].Address[line] >> 16;
                } else {
                    tmpAddress = CheatDB.Codes[CodeNum].Value[line];
                    tmpType = CheatDB.Codes[CodeNum].Address[line] & 0xF;
                    tmpValue = (CheatDB.Codes[CodeNum].Address[line] >> 4) & 0xFFFF;
                    tmpCount = CheatDB.Codes[CodeNum].Address[line] >> 20;
                }
                if (CompareActivatorValue(tmpAddress, tmpValue, 2, tmpType, LITTLE_ENDIAN_SYS)) { break; }
                else { line += tmpCount; }
            } break;
        }
    }
    return 0;
}

/**************************************************************
ApplyCodesN64 - N64/PS1 code handler
**************************************************************/
int ApplyCodesN64(int CodeNum, int cdButton)
{
    int sEndian = (CheatDB.System == CHEAT_N64) ? LITTLE_ENDIAN_BIG_SYS : LITTLE_ENDIAN_SYS;
    u64 tmpValue = 0, tmpAddress = 0;
    int line, tmpType = 0;
    for(line = 0; line < CheatDB.Codes[CodeNum].LineCount; line++)
    {
        switch(CheatDB.Codes[CodeNum].Type[line])
        {
            case 0x30: case 0x80: case 0x81: case 0x82: case 0xA0: case 0xA1: case 0xA2: case 0x88: case 0x89: case 0x8A: case 0xA8: case 0xA9: case 0xAA: //constant writes
            {
                if ((CheatDB.Codes[CodeNum].Type[line] & 8) && (!cdButton)) { break; }
                if ((CheatDB.System == CHEAT_PS1) && (CheatDB.Codes[CodeNum].Type[line] & 0x80)) { tmpType = CheatDB.Codes[CodeNum].Type[line] | 1; }
                else { tmpType = CheatDB.Codes[CodeNum].Type[line]; }
                WriteRAM(CheatDB.Codes[CodeNum].Address[line], CheatDB.Codes[CodeNum].Value[line], 1 << (tmpType & 7), sEndian);
            } break;
            case 0: case 1: case 2: case 3: case 4: case 8: case 9: case 0xA: case 0xB: case 0xC: case 0x10: case 0x11: case 0x12: case 0x13: case 0x14:
            case 0x18: case 0x19: case 0x1A: case 0x1B: case 0x1C: case 0x20: case 0x21: case 0x22: case 0x23: case 0x24: case 0x28: case 0x29: case 0x2A:
            case 0x2B: case 0x2C: //bitwise types
            {
                if ((CheatDB.Codes[CodeNum].Type[line] & 8) && (!cdButton)) { break; }
                ReadRAM(CheatDB.Codes[CodeNum].Address[line], &tmpValue, 1 << (CheatDB.Codes[CodeNum].Type[line] >> 4), sEndian);
                tmpValue = BitModValue(tmpValue, CheatDB.Codes[CodeNum].Value[line], (CheatDB.Codes[CodeNum].Type[line] & 7));
                WriteRAM(CheatDB.Codes[CodeNum].Address[line], tmpValue, 1 << (CheatDB.Codes[CodeNum].Type[line] >> 4), sEndian);
            } break;
            case 0x50: case 0x58: //patch/serial repeater
            {
                if ((CheatDB.Codes[CodeNum].Type[line] & 8) && (!cdButton)) { break; }
                if ((line + 1) >= CheatDB.Codes[CodeNum].LineCount) { break; }
                if ((CheatDB.Codes[CodeNum].Type[line+1] & 8) && (!cdButton)) { break; }
                if ((CheatDB.Codes[CodeNum].Type[line+1] & 0xB0) == 0) { break; }
                tmpAddress = CheatDB.Codes[CodeNum].Address[line+1];
                tmpValue = CheatDB.Codes[CodeNum].Value[line+1];
//                if ((CheatDB.System == CHEAT_PS1) && (CheatDB.Codes[CodeNum].Type[line+1] & 0x80)) { tmpType = CheatDB.Codes[CodeNum].Type[line+1] | 1; }
//                else { tmpType = CheatDB.Codes[CodeNum].Type[line+1]; }
                int patch;
                for (patch = 0; patch < (CheatDB.Codes[CodeNum].Address[line] >> 8); patch++)
                {
                    WriteRAM(tmpAddress, tmpValue, 1 << (CheatDB.Codes[CodeNum].Type[line+1] & 7), sEndian);
                    tmpAddress += (CheatDB.Codes[CodeNum].Address[line] & 0xFF);
                    tmpValue += CheatDB.Codes[CodeNum].Value[line];
                }
                line++;
            } break;
            case 0x60: case 0x68: //slide
            {
                if ((CheatDB.Codes[CodeNum].Type[line] & 8) && (!cdButton)) { break; }
                tmpAddress = CheatDB.Codes[CodeNum].Address[line];
                u32 pCount = 0, pTotal = CheatDB.Codes[CodeNum].Value[line];
                while (pCount < pTotal)
                {
                    line++; if (line >= CheatDB.Codes[CodeNum].LineCount) { break; }
                    WriteRAM(tmpAddress + (pCount * 4), (CheatDB.Codes[CodeNum].Type[line] << 24)|CheatDB.Codes[CodeNum].Address[line], 4, sEndian);
                    pCount++; if (pCount >= pTotal) { break; }
                    WriteRAM(tmpAddress + (pCount * 4), CheatDB.Codes[CodeNum].Value[line], 4, sEndian);
                    pCount++;
                }
            } break;
            case 0x70: case 0x71: case 0x78: case 0x79: //pointer writes
            {
                if ((CheatDB.Codes[CodeNum].Type[line] & 8) && (!cdButton)) { break; }
                ReadRAM(CheatDB.Codes[CodeNum].Address[line], &tmpAddress, 4, sEndian);
                if ((((tmpAddress >> 24) != 0x80) && ((tmpAddress >> 24) != 0x70)) || (tmpAddress == 0)) { break; }
                tmpAddress &= 0xFFFFFFF;
                if ((CheatDB.System == CHEAT_N64) && (tmpAddress > 0x7FFFFF)) { break; }
                if ((CheatDB.System == CHEAT_PS1) && (tmpAddress > 0x1FFFFF)) { break; }
                WriteRAM(tmpAddress + (CheatDB.Codes[CodeNum].Value[line] >> 16), CheatDB.Codes[CodeNum].Value[line] & 0xFFFF, 1 << (CheatDB.Codes[CodeNum].Type[line] & 7), sEndian);
            } break;
            case 0xC2: case 0xC8: //Copy Bytes
            {
                if ((CheatDB.Codes[CodeNum].Type[line] & 8) && (!cdButton)) { break; }
                if ((line + 1) >= CheatDB.Codes[CodeNum].LineCount) { break; }
                int i;
                for (i = 0; i < CheatDB.Codes[CodeNum].Value[line]; i++)
                {
                    if (ReadRAM(CheatDB.Codes[CodeNum].Address[line] + i, &tmpValue, 1, sEndian)) {
                        WriteRAM(CheatDB.Codes[CodeNum].Address[line+1] + i, tmpValue, 1, sEndian);
                    }
                }
                line++;
            } break;
            case 0xD0: case 0xD1: case 0xD2: case 0xD3: case 0xE0: case 0xE1: case 0xE2: case 0xE3: //Equal, Not Equal, Greater, Less
            {
                int tmpSize = 0;
                if (CheatDB.System == CHEAT_N64) {
                    tmpType = ((CheatDB.Codes[CodeNum].Type[line] & 7) + ((CheatDB.Codes[CodeNum].Type[line] >> 4 == 0xE) ? 4 : 0))/2;
                    tmpSize = 1 << (CheatDB.Codes[CodeNum].Type[line] & 7);
                } else {
                    tmpType = (CheatDB.Codes[CodeNum].Type[line] & 7);
                    tmpSize = (CheatDB.Codes[CodeNum].Type[line] & 0xE0) ? 1 : 2;
                }
                if (CompareActivatorValue(CheatDB.Codes[CodeNum].Address[line], CheatDB.Codes[CodeNum].Value[line], tmpSize, tmpType, sEndian)) { break; }
                else {
                    while ((line + 1) < CheatDB.Codes[CodeNum].LineCount)
                    {
                        line ++;
                        if (((CheatDB.Codes[CodeNum].Type[line] & 0xF0) != 0xD0) && ((CheatDB.Codes[CodeNum].Type[line] & 0xF0) != 0xE0)) { break; }
                    }
                }
            } break;
        }
    }
    return 0;
}

/**************************************************************
GBA code handler
**************************************************************/
int ApplyCodesGBA(int CodeNum, int cdButton)
{
    u64 tmpValue = 0, tmpAddress = 0;
    int line, tmpType = 0;
    for(line = 0; line < CheatDB.Codes[CodeNum].LineCount; line++)
    {
        switch(CheatDB.Codes[CodeNum].Type[line])
        {
            case 0: case 1: case 2: //constant writes
            {
                WriteRAM(CheatDB.Codes[CodeNum].Address[line] & 0xFFFFF, CheatDB.Codes[CodeNum].Value[line], 1 << CheatDB.Codes[CodeNum].Type[line], LITTLE_ENDIAN_SYS);
            } break;
            case 0xD: //16-bit Conditional Write
            {
                if (CompareActivatorValue(CheatDB.Codes[CodeNum].Address[line] & 0xFFFFF, CheatDB.Codes[CodeNum].Value[line] & 0xFFFF, 2, 0, LITTLE_ENDIAN_SYS)) { break; }
                else {
                    while ((line + 1) < CheatDB.Codes[CodeNum].LineCount)
                    {
                        line ++;
                        if (CheatDB.Codes[CodeNum].Type[line] != 0xD) { break; }
                    }
                }
            } break;
            case 0xE: //16-bit Multi-Address Conditional Write
            {
                tmpAddress = CheatDB.Codes[CodeNum].Value[line] & 0xFFFFF;
                tmpValue = CheatDB.Codes[CodeNum].Address[line] & 0xFFFF;
                if (CompareActivatorValue(tmpAddress, tmpValue, 2, 0, LITTLE_ENDIAN_SYS)) { break; }
                else { line += (CheatDB.Codes[CodeNum].Address[line] >> 16); }
            } break;
        }
    }
    return 0;
}

/**************************************************************
NDS code handler
**************************************************************/
int ApplyCodesNDS(int CodeNum, int cdButton)
{
    u64 tmpValue = 0, tmpAddress = 0;
    int line, tmpType = 0;
    for(line = 0; line < CheatDB.Codes[CodeNum].LineCount; line++)
    {
        switch(CheatDB.Codes[CodeNum].Type[line])
        {
            case 0: case 1: case 2: //constant writes
            {
                WriteRAM(CheatDB.Codes[CodeNum].Address[line] & 0x3FFFFF, CheatDB.Codes[CodeNum].Value[line], 1 << CheatDB.Codes[CodeNum].Type[line], LITTLE_ENDIAN_SYS);
            } break;
            case 6: //Pointer
            {
                if ((line + 1) >= CheatDB.Codes[CodeNum].LineCount) { break; }
                int tmpSize = 1 << ((CheatDB.Codes[CodeNum].Value[line+1] >> 16) & 0xF);
                tmpType = (CheatDB.Codes[CodeNum].Value[line + 1] >> 20) & 0xF;
                tmpValue = CheatDB.Codes[CodeNum].Value[line + 1] & 0xFFFF;
                ReadRAM(CheatDB.Codes[CodeNum].Address[line], &tmpAddress, 4, LITTLE_ENDIAN_SYS);
                tmpAddress &= 0x3FFFFF;
                if ((tmpAddress == 0) || ((tmpAddress + CheatDB.Codes[CodeNum].Address[line +1]) > 0x3FFFFF)) { line++; break; }
                if (!(CompareActivatorValue(CheatDB.Codes[CodeNum].Address[line], tmpValue, tmpSize, tmpType, LITTLE_ENDIAN_SYS))) { line++; break; }
                tmpSize = 1 << ((CheatDB.Codes[CodeNum].Value[line+1] >> 24) & 0xF);
                WriteRAM(tmpAddress + CheatDB.Codes[CodeNum].Address[line +1], CheatDB.Codes[CodeNum].Value[line], 1 << CheatDB.Codes[CodeNum].Type[line], LITTLE_ENDIAN_SYS);
            } break;
            case 0xD: //16-bit Multi-Address Conditional Write
            {
                tmpValue = CheatDB.Codes[CodeNum].Value[line] & 0xFFFF;
                tmpType = (CheatDB.Codes[CodeNum].Value[line] >> 20) & 0xF;
                int tmpSize = ((CheatDB.Codes[CodeNum].Value[line] >> 16) & 0xF) ? 1 : 2;
                if (CompareActivatorValue(CheatDB.Codes[CodeNum].Address[line] & 0x3FFFFF, tmpValue, tmpSize, tmpType, LITTLE_ENDIAN_SYS)) { break; }
                else { line += (CheatDB.Codes[CodeNum].Value[line] >> 24); }
            } break;
        }
    }
    return 0;
}

/**************************************************************
BitModValue - for bitwise code types
**************************************************************/
u32 BitModValue(u32 rValue, u32 iValue, int type)
{
    switch(type)
    {
        case 0: return rValue + iValue;
        case 1: return rValue - iValue;
        case 2: return rValue & iValue;
        case 3: return rValue|iValue;
        case 4: return rValue ^ iValue;
    }
    return rValue;
}

/**************************************************************
Compare Activator Values - for Activators/Jokers
**************************************************************/
BOOL CompareActivatorValue(u32 address, u64 value, int size, int type, int endian)
{
    u64 tmpValue = 0;
    if (ReadRAM(address, &tmpValue, size, endian) == 0) { return 0; }
    switch(type)
    {
        case 0: return (tmpValue == value);
        case 1: return (tmpValue != value);
        case 2: return (tmpValue < value);
        case 3: return (tmpValue > value);
    }
    return 0;
}

