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

int d64type1(u32 dval, char *txtop, int addy) {
    switch ((dval >> 16) & BITS(5)) {
        case 1: //BGEZ
            sprintf(txtop,"BGEZ %s%s,%08X",SPC(6),N64GPR(dval,21),btarget(addy,dval));
            return 0;
        case 17: //BGEZAL
            sprintf(txtop,"BGEZAL %s%s,%08X",SPC(4),N64GPR(dval,21),btarget(addy,dval));
            return 0;
        case 19: //BGEZALL
            sprintf(txtop,"BGEZALL %s%s,%08X",SPC(3),N64GPR(dval,21),btarget(addy,dval));
            return 0;
        case 3: //BGEZL
            sprintf(txtop,"BGEZL %s%s,%08X",SPC(5),N64GPR(dval,21),btarget(addy,dval));
            return 0;
        case 0: //BLTZ
            sprintf(txtop,"BLTZ %s%s,%08X",SPC(6),N64GPR(dval,21),btarget(addy,dval));
            return 0;
        case 16: //BLTZAL
            sprintf(txtop,"BLTZAL %s%s,%08X",SPC(4),N64GPR(dval,21),btarget(addy,dval));
            return 0;
        case 18: //BLTZALL
            sprintf(txtop,"BLTZALL %s%s,%08X",SPC(3),N64GPR(dval,21),btarget(addy,dval));
            return 0;
        case 2: //BLTZL
            sprintf(txtop,"BLTZL %s%s,%08X",SPC(5),N64GPR(dval,21),btarget(addy,dval));
            return 0;
        case 12: //TEQI
            sprintf(txtop,"TEQI %s%s,%04X",SPC(6),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 8: //TGEI
            sprintf(txtop,"TGEI %s%s,%04X",SPC(6),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 9: //TGEIU
            sprintf(txtop,"TGEIU %s%s,%04X",SPC(5),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 10: //TLTI
            sprintf(txtop,"TLTI %s%s,%04X",SPC(6),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 11: //TLTIU
            sprintf(txtop,"TLTIU %s%s,%04X",SPC(5),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
        case 14: //TNEI
            sprintf(txtop,"TNEI %s%s,%04X",SPC(6),N64GPR(dval,21),(dval & 0xFFFF));
            return 0;
    }
    return 1;
}

