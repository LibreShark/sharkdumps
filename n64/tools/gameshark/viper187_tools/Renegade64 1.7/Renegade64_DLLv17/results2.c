#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "misc.h"
#include "globals.h"

int PrintResultsMulti(int outfmt) {
//    FILE *rFile;
    u64 NewValue;
    int addy=0;
    char txtfmt[128];
    float tmpfloat=0;
    u32 *castfloat=(u32*)(&tmpfloat);
    double tmpdouble=0;
    u64 *castdouble=(u64*)&tmpdouble;
    if ((outfmt == 3) && (iobytes > 4)) outfmt = 2;
    if ((outfmt == 4) && (iobytes != 4) && (iobytes != 8)) outfmt = 2;
    if ((outfmt < 2) && (outfmt > 4) && (outfmt != 13)) { outfmt = 2; }
//    getfmtstring(txtfmt,outfmt);
    errnum = loadfile(&NewData,OldFile,header);
    if (errnum != 0) { FreeShit(); return errnum; }
    for (addy = addy; addy < filesize ; addy += ioinc) {
        if (!(get_bitflag(Results, addy / ioinc))) { continue; }
        NewValue = getdata(NewData,addy);
        *castdouble = NewValue;
        *castfloat = (u32)(NewValue & 0xFFFFFFFF);
        switch(outfmt) {
            case 2: //hex
                if (iobytes > 4) fprintf(rFile,txtfmt,addy,(NewValue<<32)|(NewValue>>32));
                else fprintf(rFile,txtfmt,addy,NewValue);
                break;
            case 3: //dec
                fprintf(rFile,txtfmt,addy,NewValue);
                break;
            case 4: //float,double
                if (iobytes == 4) fprintf(rFile,txtfmt,addy,tmpfloat);
                else if (iobytes == 8) fprintf(rFile,txtfmt,addy,tmpdouble);
                break;
/*
            case 13: //ASCII
                fprintf(rFile,"%08X: ",addy);
                for (gba = 0; gba < strlen(iString); gba++) {
                    chr = NewData[addy + gba];
                    if (chr < 32) chr = 46;
                    fprintf(rFile,"%c",chr);
                }
                fprintf(rFile,"\n");
                break;
*/
        }
    }
//    fclose(rFile);
    return 0;
}
void getfmtstrmulti(char *tmpstring,int outfmt) {
    switch (outfmt) {
        case 2: //hex
            if (iobytes < 5) sprintf(tmpstring,"%%08X: %%0%dX\n",(iobytes * 2));
            else sprintf(tmpstring,"%%08X: %%08X%%08X\n");    
            break;
        case 3: //decimal
            if (xOpt & 1) sprintf(tmpstring,"%%08X: %%d\n");
            else sprintf(tmpstring,"%%08X: %%u\n");    
            break;
        case 4: //float, double
            if (iobytes == 4) sprintf(tmpstring,"%%08X: %%f\n");
            else sprintf(tmpstring,"%%08X: %%Lf\n");
            break;
    }
}

