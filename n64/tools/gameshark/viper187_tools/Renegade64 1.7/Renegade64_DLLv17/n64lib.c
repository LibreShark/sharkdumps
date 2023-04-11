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

char *GPR64names[] = { "$zero", "$at", "$v0", "$v1", "$a0", "$a1", "$a2", "$a3", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5",
"t6", "$t7", "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7", "$t8", "$t9", "$k0", "$k1", "$gp",
"$sp", "$s8", "$ra", "$ZERO", "$AT", "$V0", "$V1", "$A0", "$A1", "$A2", "$A3", "$T0", "$T1", "$T2", "$T3",
"$T4", "$T5", "$T6", "$T7", "$S0", "$S1", "$S2", "$S3", "$S4", "$S5", "$S6", "$S7", "$T8", "$T9", "$K0",
"$K1", "$GP", "$SP", "$S8", "$RA", "ZERO", "AT", "V0", "V1", "A0", "A1", "A2", "A3", "T0", "T1", "T2", "T3",
"T4", "T5", "T6", "T7", "S0", "S1", "S2", "S3", "S4", "S5", "S6", "S7", "T8", "T9", "K0", "K1", "GP", "SP",
"S8", "RA", "R0", "R1", "R2", "R3", "R4", "R5", "R6", "R7", "R8", "R9", "R10", "R11", "R12", "R13", "R14",
"R15", "R16", "R17", "R18", "R19", "R20", "R21", "R22", "R23", "R24", "R25", "R26", "R27", "R28", "R29",
"R30", "R31" };

char *N64COP0names[] = { "Index", "Random", "EntryLo0", "EntryLo1", "Context", "Pagemask", "Wired", "*Reserved*",
"BadVAddr", "Count", "EntryHi", "Compare", "Status", "Cause", "EPC", "PRevID", "Config", "LLAddr", "WatchLo",
"WatchHi", "XContext", "*Reserved*", "*Reserved*", "*Reserved*", "*Reserved*", "*Reserved*", "PErr", "CacheErr",
"TagLo", "TagHi", "ErrorEPC", "*Reserved*" };

char *N64COP1names[] = { "F0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "F13",
"F14", "F15", "F16", "F17", "F18", "F19", "F20", "F21", "F22", "F23", "F24", "F25", "F26", "F27", "F28",
"F29", "F30", "F31" };

char *Spaces[] = { "", " ", "  ", "   ", "    ", "     ", "      ", "       ", "        ", "         ", "          " };

int DisN64(u32 dval, char *txtop, int addy) {
    if ((dval == 0) || ((dval >> 16) == 0x2400)) {
        sprintf(txtop,"NOP");
        return 0;
    }
    switch (dval) {
        case 0xF:
            sprintf(txtop,"SYNC"); return 0;
        case 0x42000018:
            sprintf(txtop,"ERET"); return 0;
        case 0x42000008:
            sprintf(txtop,"TLBP"); return 0;
        case 0x42000001:
            sprintf(txtop,"TLBR"); return 0;
        case 0x42000002:
            sprintf(txtop,"TLBWI"); return 0;
        case 0x42000006:
            sprintf(txtop,"TLWR"); return 0;
    }
    switch ((dval >> 26)) {
        case 0: return d64type0(dval, txtop);
        case 1: return d64type1(dval, txtop, addy);
        case 2: //J
            sprintf(txtop,"J %s%08X",SPC(9),(dval & BITS(26)) * 4);
            return 0;
        case 3: //JAL
            sprintf(txtop,"JAL %s%08X",SPC(7),(dval & BITS(26)) * 4);
            return 0;
        case 4: //BEQ
            sprintf(txtop,"BEQ %s%s,%s,%08X",SPC(7),N64GPR(dval,21),N64GPR(dval,16),btarget(addy,dval));
            return 0;
        case 5: //BNE
            sprintf(txtop,"BNE %s%s,%s,%08X",SPC(7),N64GPR(dval,21),N64GPR(dval,16),btarget(addy,dval));
            return 0;
        case 6: //BLEZ
            if ((dval >> 16) & BITS(5)) return 1;
            sprintf(txtop,"BLEZ %s%s,%s,%08X",SPC(6),N64GPR(dval,21),N64GPR(dval,16),btarget(addy,dval));
            return 0;
        case 7: //BGTZ
            if ((dval >> 16) & BITS(5)) return 1;
            sprintf(txtop,"BGTZ %s%s,%s,%08X",SPC(6),N64GPR(dval,21),N64GPR(dval,16),btarget(addy,dval));
            return 0;
        case 8: //ADDI
            sprintf(txtop,"ADDI %s%s,%s,%04X",SPC(6),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 9: //ADDIU
            sprintf(txtop,"ADDIU %s%s,%s,%04X",SPC(5),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 10: //SLTI
            sprintf(txtop,"SLTI %s%s,%s,%04X",SPC(6),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 11: //SLTIU
            sprintf(txtop,"SLTIU %s%s,%s,%04X",SPC(5),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 12: //ANDI
            sprintf(txtop,"ANDI %s%s,%s,%04X",SPC(6),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 13: //ORI
            sprintf(txtop,"ORI %s%s,%s,%04X",SPC(7),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 14: //XORI
            sprintf(txtop,"XORI %s%s,%s,%04X",SPC(6),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 15: //LUI
            if ((dval >> 21) & BITS(5)) return 1;
            sprintf(txtop,"LUI %s%s,%04X",SPC(7),N64GPR(dval,16),(dval & 0xFFFF));
            return 0;
        case 16: //MFC0, MTC0
            if ((!((dval >> 21) & BITS(5))) && (!(dval & BITS(11)))) {
                sprintf(txtop,"MFC0 %s%s,%s",SPC(6),N64GPR(dval,16),N64COP0(dval,11));
                return 0;
            }
            else if ((((dval >> 21) & BITS(5)) == 4) && (!(dval & BITS(11)))) {
                sprintf(txtop,"MTC0 %s%s,%s",SPC(6),N64GPR(dval,16),N64COP0(dval,11));
                return 0;
            } else return 1;
        case 17: return d64type2(dval, txtop, addy);
        case 20: //BEQL
            sprintf(txtop,"BEQL %s%s,%s,%08X",SPC(6),N64GPR(dval,21),N64GPR(dval,16),btarget(addy,dval));
            return 0;
        case 21: //BNEL
            sprintf(txtop,"BNEL %s%s,%s,%08X",SPC(6),N64GPR(dval,21),N64GPR(dval,16),btarget(addy,dval));
            return 0;
        case 22: //BLEZL
            if ((dval >> 16) & BITS(5)) return 1;
            sprintf(txtop,"BLEZL %s%s,%s,%08X",SPC(5),N64GPR(dval,21),N64GPR(dval,16),btarget(addy,dval));
            return 0;
        case 23: //BGTZL
            if ((dval >> 16) & BITS(5)) return 1;
            sprintf(txtop,"BGTZL %s%s,%s,%08X",SPC(6),N64GPR(dval,21),N64GPR(dval,16),btarget(addy,dval));
            return 0;
        case 24: //DADDI
            sprintf(txtop,"DADDI %s%s,%s,%04X",SPC(5),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 25: //DADDIU
            sprintf(txtop,"DADDIU %s%s,%s,%04X",SPC(4),N64GPR(dval,16),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 26: //LDL
            sprintf(txtop,"LDL %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 27: //LDR
            sprintf(txtop,"LDR %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 32: //LB
            sprintf(txtop,"LB %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 33: //LH
            sprintf(txtop,"LH %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 34: //LWL
            sprintf(txtop,"LWL %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 35: //LW
            sprintf(txtop,"LW %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 36: //LBU
            sprintf(txtop,"LBU %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 37: //LHU
            sprintf(txtop,"LHU %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 38: //LWR
            sprintf(txtop,"LWR %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 39: //LWU
            sprintf(txtop,"LWU %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 40: //SB
            sprintf(txtop,"SB %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 41: //SH
            sprintf(txtop,"SH %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 42: //SWL
            sprintf(txtop,"SWL %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 43: //SW
            sprintf(txtop,"SW %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 44: //SDL
            sprintf(txtop,"SDL %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 45: //SDR
            sprintf(txtop,"SDR %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 46: //SWR
            sprintf(txtop,"SWR %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 47: //CACHE
            sprintf(txtop,"CACHE %s%s,%04X(%s)",SPC(5),N64COP0(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 48: //LL
            sprintf(txtop,"LL %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 49: //LWC1
            sprintf(txtop,"LWC1 %s%s,%04X(%s)",SPC(6),N64COP1(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 52: //LLD
            sprintf(txtop,"LLD %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 53: //LDC1
            sprintf(txtop,"LDC1 %s%s,%04X(%s)",SPC(6),N64COP1(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 55: //LD
            sprintf(txtop,"LD %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 56: //SC
            sprintf(txtop,"SC %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 57: //SWC1
            sprintf(txtop,"SWC1 %s%s,%04X(%s)",SPC(6),N64COP1(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 60: //SCD
            sprintf(txtop,"SCD %s%s,%04X(%s)",SPC(7),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 61: //SDC1
            sprintf(txtop,"SDC1 %s%s,%04X(%s)",SPC(6),N64COP1(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
        case 63: //SD
            sprintf(txtop,"SD %s%s,%04X(%s)",SPC(8),N64GPR(dval,16),(dval & 0xFFFF),N64GPR(dval,21));
            return 0;
    }
    return 1;
}
char* N64GPR(u32 disvalue, int regpos) {
    switch (stype) {
        case 1:
            return GPR64names[((disvalue >> regpos) & 0x1F)];
        case 2:
            return GPR64names[((disvalue >> regpos) & 0x1F) + 32];
        case 3:
            return GPR64names[((disvalue >> regpos) & 0x1F) + 64];
        case 4:
            return GPR64names[((disvalue >> regpos) & 0x1F) + 96];
    }
}
char* N64COP0(u32 disvalue, int regpos) {
    return N64COP0names[((disvalue >> regpos) & 0x1F)];
}
char* N64COP1(u32 disvalue, int regpos) {
    return N64COP1names[((disvalue >> regpos) & 0x1F)];
}
char N64FPFMT(u32 disvalue, int regpos) {
    switch ((disvalue >> regpos) & 0x1F) {
        case 16: return 83;
        case 17: return 68;
        case 20: return 87;
        case 21: return 76;
    }
}
char* SPC(int spcval) {
    if (iosize = 0) { spcval = 0; }
    return Spaces[spcval];
}
u32 BITS(int numbits) {
    return (0xFFFFFFFF >> (32-numbits)) ;
}
int btarget(int addy, int disvalue) {
    //get branch target
    return ((addy + 4) + ((short int)(disvalue & 0xFFFF) * 4));
}
int isFMT(u32 disvalue, int regpos) {
    switch((disvalue >> regpos) & 0x1F) {
        case 16: case 17: case 20: case 21: return 1;
    }
    return 0;
}
