#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "misc.h"
#include "globals.h"

void txtsearch(int scase) {
    int addy;
    rescount = 0;
    LPSTR tmpString;
    if (scase == 2) str_ucase(iString);
    for (addy = 0; addy < filesize; addy++) {    
        memcpy(tmpString,&NewData[addy],strlen(iString));
        if (scase == 2) str_ucase(tmpString);
        if (strncmp(tmpString,iString,strlen(iString))) { set_bitflag(Results,addy,0); }
        if (get_bitflag(Results, addy)) { rescount++; }
    }
}
void txtsearchWild(int scase) {
    int addy;
    int L;
    rescount = 0;
    char tmpletter;
    if (scase == 4) str_ucase(iString);
    for (addy = 0;addy < filesize; addy++) {
        for (L = 0; L < strlen(iString); L++) {
            tmpletter = NewData[addy + L];
            if (scase == 4) tmpletter = chr_ucase(tmpletter);
            if ((tmpletter != iString[L]) && (iString[L] != '*')) {
                set_bitflag(Results,addy,0);
                break;
            }    
        }
        if (get_bitflag(Results, addy)) { rescount++; }
    }                                                      
}
/*
void WildValSearchOLD(int align) { //allow alignment
    int addy;
    int L;
    rescount = 0;
    str_ucase(iString);
    for (addy = 0;addy < filesize; addy++) {
        for (L = 0; L < strlen(iString); L += 2) {
            if ((((NewData[addy + (L>>1)] >> 4) != chr2val((int)iString[L])) && (iString[L] != '*')) ) {
                set_bitflag(Results,addy,0);
                break;
            }    
            if (((NewData[addy + (L>>1)] & 0xF) != chr2val((int)iString[L+1])) && 
                (iString[L+1] != '*') && (iString[L+1] != '\0')) {
                set_bitflag(Results,addy,0);
                break;
            }    
        }
        if (get_bitflag(Results, addy)) { rescount++; }
    }
    if (align == 1) {
        rescount = 0;
        for (addy = 0; addy < filesize; addy++) {
            if (!(get_bitflag(Results, addy))) { continue; }
            if (addy % (strlen(iString) / 2)) set_bitflag(Results,addy,0);
            else rescount++;
        }
    }                                                                          
}
void WildValSearch(int align) {
    u32 addy;
    rescount = 0;
    for (addy = 0; addy < filesize; addy += ioinc) {
    }
}
*/                           
