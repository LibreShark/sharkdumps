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

int d64type0(u32 dval, char *txtop) {
    switch (dval & BITS(16)) {
        case 30: //DDIV
            sprintf(txtop,"DDIV %s%s,%s",SPC(6),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 31: //DDIVU
            sprintf(txtop,"DDIVU %s%s,%s",SPC(5),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 26: //DIV
            sprintf(txtop,"DIV %s%s,%s",SPC(7),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 27: //DIVU
            sprintf(txtop,"DIVU %s%s,%s",SPC(6),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 28: //DMULT
            sprintf(txtop,"DMULT %s%s,%s",SPC(5),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 29: //DMULTU
            sprintf(txtop,"DMULTU %s%s,%s",SPC(4),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 24: //MULT
            sprintf(txtop,"MULT %s%s,%s",SPC(6),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 25: //MULTU
            sprintf(txtop,"MULTU %s%s,%s",SPC(5),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
    }
    switch (dval & BITS(11)) {
        case 4: //SLLV
            sprintf(txtop,"SLLV %s%s,%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,16),N64GPR(dval,21));
            return 0;
        case 6: //SRLV
            sprintf(txtop,"SRLV %s%s,%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,16),N64GPR(dval,21));
            return 0;
        case 7: //SRAV
            sprintf(txtop,"SRAV %s%s,%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,16),N64GPR(dval,21));
            return 0;
        case 8: //JR
            if (((dval >> 6) & BITS(15))) return 1;
            sprintf(txtop,"JR %s%s",SPC(8),N64GPR(dval,21));
            return 0;
        case 9: //JALR
            if ((dval >> 16) & BITS(5)) return 1;
            sprintf(txtop,"JALR %s%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,21));
            return 0;
        case 32: //ADD
            sprintf(txtop,"ADD %s%s,%s,%s",SPC(7),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 33: //ADDU
            sprintf(txtop,"ADDU %s%s,%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 36: //AND
            sprintf(txtop,"AND %s%s,%s,%s",SPC(7),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 44: //DADD
            sprintf(txtop,"DADD %s%s,%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 45: //DADDU
            sprintf(txtop,"DADDU %s%s,%s,%s",SPC(5),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 46: //DSUB
            sprintf(txtop,"DSUB %s%s,%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 47: //DSUBU
            sprintf(txtop,"DSUBU %s%s,%s,%s",SPC(5),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 16: //MFHI
            if (dval >> 16) return 1;
            sprintf(txtop,"MFHI %s%s",SPC(6),N64GPR(dval,11));
            return 0;
        case 17: //MTHI
            if (((dval >> 6) & BITS(15))) return 1;
            sprintf(txtop,"MTHI %s%s",SPC(6),N64GPR(dval,21));
            return 0;
        case 18: //MFLO
            if (dval >> 16) return 1;
            sprintf(txtop,"MFLO %s%s",SPC(6),N64GPR(dval,11));
            return 0;
        case 19: //MTLO
            if (((dval >> 6) & BITS(15))) return 1;
            sprintf(txtop,"MTLO %s%s",SPC(6),N64GPR(dval,21));
            return 0;
        case 20: //DSLLV
            sprintf(txtop,"DSLLV %s%s,%s,%s",SPC(5),N64GPR(dval,11),N64GPR(dval,16),N64GPR(dval,21));
            return 0;
        case 22: //DSRLV
            sprintf(txtop,"DSRLV %s%s,%s,%s",SPC(5),N64GPR(dval,11),N64GPR(dval,16),N64GPR(dval,21));
            return 0;
        case 23: //DSRAV
            sprintf(txtop,"DSRAV %s%s,%s,%s",SPC(5),N64GPR(dval,11),N64GPR(dval,16),N64GPR(dval,21));
            return 0;
        case 39: //NOR
            sprintf(txtop,"NOR %s%s,%s,%s",SPC(7),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 37: //OR
            sprintf(txtop,"OR %s%s,%s,%s",SPC(8),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 42: //SLT
            sprintf(txtop,"SLT %s%s,%s,%s",SPC(7),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 43: //SLTU
            sprintf(txtop,"SLTU %s%s,%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 34: //SUB
            sprintf(txtop,"SUB %s%s,%s,%s",SPC(7),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 35: //SUBU
            sprintf(txtop,"SUBU %s%s,%s,%s",SPC(6),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
        case 38: //XOR
            sprintf(txtop,"XOR %s%s,%s,%s",SPC(7),N64GPR(dval,11),N64GPR(dval,21),N64GPR(dval,16));
            return 0;
    }

    switch (dval & BITS(6)) {
        case 13: //BREAK
            sprintf(txtop,"BREAK");
            return 0;
        case 12: //SYSCALL
            sprintf(txtop,"SYSCALL");
            return 0;
        case 52: //TEQ
            sprintf(txtop,"TEQ %s%s,%s,%X",SPC(7),N64GPR(dval,21),N64GPR(dval,16),((dval >> 6) & BITS(10)));
            return 0;
        case 48: //TGE
            sprintf(txtop,"TGE %s%s,%s,%X",SPC(7),N64GPR(dval,21),N64GPR(dval,16),((dval >> 6) & BITS(10)));
            return 0;
        case 49: //TGEU
            sprintf(txtop,"TGEU %s%s,%s,%X",SPC(6),N64GPR(dval,21),N64GPR(dval,16),((dval >> 6) & BITS(10)));
            return 0;
        case 50: //TLT
            sprintf(txtop,"TLT %s%s,%s,%X",SPC(7),N64GPR(dval,21),N64GPR(dval,16),((dval >> 6) & BITS(10)));
            return 0;
        case 51: //TLTU
            sprintf(txtop,"TLTU %s%s,%s,%X",SPC(6),N64GPR(dval,21),N64GPR(dval,16),((dval >> 6) & BITS(10)));
            return 0;
        case 54: //TNE
            sprintf(txtop,"TNE %s%s,%s,%X",SPC(7),N64GPR(dval,21),N64GPR(dval,16),((dval >> 6) & BITS(10)));
            return 0;
    }
    if (dval >> 21) return 1;
    switch (dval & BITS(6)) {
        case 56: //DSLL
            sprintf(txtop,"DSLL %s%s,%s,%d",SPC(6),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
        case 60: //DSLL32
            sprintf(txtop,"DSLL32 %s%s,%s,%d",SPC(4),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
        case 59: //DSRA
            sprintf(txtop,"DSRA %s%s,%s,%d",SPC(6),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
        case 63: //DSRA32
            sprintf(txtop,"DSRA32 %s%s,%s,%d",SPC(4),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
        case 58: //DSRL
            sprintf(txtop,"DSRL %s%s,%s,%d",SPC(6),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
        case 62: //DSRL32
            sprintf(txtop,"DSRL32 %s%s,%s,%d",SPC(4),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
        case 0: //SLL
            if (dval >> 21) return 1;
            sprintf(txtop,"SLL %s%s,%s,%d",SPC(7),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
        case 3: //SRA
            sprintf(txtop,"SRA %s%s,%s,%d",SPC(7),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
        case 2: //SRL
            sprintf(txtop,"SRL %s%s,%s,%d",SPC(7),N64GPR(dval,11),N64GPR(dval,16),((dval >> 6) & 0x1F));
            return 0;
    }
    return 1;
}

