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

char* FPCONDs[] = { "F", "UN", "EQ", "UEQ", "OLT", "ULT", "OLE", "ULE", "SF", "NGLE", "SEQ", "NGL", "LT",
"NGE", "LE", "NGT" };

int d64type2(u32 dval, char *txtop, int addy) {
//    if (!((dval >> 16) & BITS(5))) {
    if ( ( ((dval >> 16) & BITS(5)) == 0) && (isFMT(dval,21)) ) {
        switch (dval & BITS(6)) {
            case 5: //ABS
                sprintf(txtop,"ABS.%c %s%s,%s",N64FPFMT(dval,21),SPC(5),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 10: //CEIL.L
                sprintf(txtop,"CEIL.L.%c %s%s,%s",N64FPFMT(dval,21),SPC(2),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 14: //CEIL.W
                sprintf(txtop,"CEIL.L.%c %s%s,%s",N64FPFMT(dval,21),SPC(2),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 33: //CVT.D
                sprintf(txtop,"CVT.D.%c %s%s,%s",N64FPFMT(dval,21),SPC(3),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 37: //CVT.L
                sprintf(txtop,"CVT.L.%c %s%s,%s",N64FPFMT(dval,21),SPC(3),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 32: //CVT.S
                sprintf(txtop,"CVT.S.%c %s%s,%s",N64FPFMT(dval,21),SPC(3),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 36: //CVT.W
                sprintf(txtop,"CVT.W.%c %s%s,%s",N64FPFMT(dval,21),SPC(3),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 11: //FLOOR.L
                sprintf(txtop,"FLOOR.L.%c %s%s,%s",N64FPFMT(dval,21),SPC(1),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 15: //FLOOR.W
                sprintf(txtop,"FLOOR.W.%c %s%s,%s",N64FPFMT(dval,21),SPC(1),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 6: //MOV
                sprintf(txtop,"MOV.%c %s%s,%s",N64FPFMT(dval,21),SPC(5),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 7: //NEG
                sprintf(txtop,"NEG.%c %s%s,%s",N64FPFMT(dval,21),SPC(5),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 8: //ROUND.L
                sprintf(txtop,"ROUND.L.%c %s%s,%s",N64FPFMT(dval,21),SPC(1),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 12: //ROUND.W
                sprintf(txtop,"ROUND.W.%c %s%s,%s",N64FPFMT(dval,21),SPC(1),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 4: //SQRT
                sprintf(txtop,"SQRT.%c %s%s,%s",N64FPFMT(dval,21),SPC(4),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 9: //TRUNC.L
                sprintf(txtop,"TRUNC.L.%c %s%s,%s",N64FPFMT(dval,21),SPC(1),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
            case 13: //TRUNC.W
                sprintf(txtop,"TRUNC.W.%c %s%s,%s",N64FPFMT(dval,21),SPC(1),N64COP1(dval,6),N64COP1(dval,11));
                return 0;
        }
    }
    if (!(dval & BITS(11))) {
        switch ((dval >> 21) & BITS(5)) {
            case 2: //CFC1
                sprintf(txtop,"CFC1 %s%s,%s",SPC(6),N64GPR(dval,16),N64COP1(dval,11));
                return 0;
            case 6: //CTC1
                sprintf(txtop,"CTC1 %s%s,%s",SPC(6),N64GPR(dval,16),N64COP1(dval,11));
                return 0;
            case 1: //DMFC1
                sprintf(txtop,"DMFC1 %s%s,%s",SPC(5),N64GPR(dval,16),N64COP1(dval,11));
                return 0;
            case 5: //DMTC1
                sprintf(txtop,"DMTC1 %s%s,%s",SPC(5),N64GPR(dval,16),N64COP1(dval,11));
                return 0;
            case 0: //MFC1
                sprintf(txtop,"MFC1 %s%s,%s",SPC(6),N64GPR(dval,16),N64COP1(dval,11));
                return 0;
            case 4: //MTC1
                sprintf(txtop,"MTC1 %s%s,%s",SPC(6),N64GPR(dval,16),N64COP1(dval,11));
                return 0;
        }
    }
    if ((((dval >> 21) & BITS(5)) == 8) && (!((dval >> 18) & BITS(3)))) {
        switch ((dval >> 16) & 3) {
            case 0: //BC1F
                sprintf(txtop,"BC1F %08X",SPC(6),btarget(addy,dval));
                return 0;
            case 1: //BC1T
                sprintf(txtop,"BC1T %08X",SPC(6),btarget(addy,dval));
                return 0;
            case 2: //BC1FL
                sprintf(txtop,"BC1FL %08X",SPC(5),btarget(addy,dval));
                return 0;
            case 3: //BC1TL
                sprintf(txtop,"BC1TL %08X",SPC(5),btarget(addy,dval));
                return 0;
        }
    }
    if ((((dval >> 21) & BITS(5)) == 16) || (((dval >> 21) & BITS(5)) == 17) ||
        (((dval >> 21) & BITS(5)) == 20) || (((dval >> 21) & BITS(5)) == 21)) {
            switch (dval & BITS(6)) {
                case 0: //ADD
                    sprintf(txtop,"ADD.%c %s%s,%s",N64FPFMT(dval,21),SPC(5),N64COP1(dval,6),N64COP1(dval,11),N64COP1(dval,16));
                    return 0;
                case 3: //DIV
                    sprintf(txtop,"DIV.%c %s%s,%s",N64FPFMT(dval,21),SPC(5),N64COP1(dval,6),N64COP1(dval,11),N64COP1(dval,16));
                    return 0;
                case 2: //MUL
                    sprintf(txtop,"MUL.%c %s%s,%s",N64FPFMT(dval,21),SPC(5),N64COP1(dval,6),N64COP1(dval,11),N64COP1(dval,16));
                    return 0;
                case 1: //SUB
                    sprintf(txtop,"SUB.%c %s%s,%s",N64FPFMT(dval,21),SPC(5),N64COP1(dval,6),N64COP1(dval,11),N64COP1(dval,16));
                    return 0;
            }
    }
    if (((dval >> 4) & BITS(7)) == 3) {
        sprintf(txtop,"C.%s.%c %s%s,%s",FPCONDs[dval & 15],N64FPFMT(dval,21),SPC(5),N64COP1(dval,11),N64COP1(dval,16));
    }
    return 1;
}
