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
#include <psapi.h>
#include "types.h"
//#include "globals.h"
//#define RAM_CHUNK_SIZE 0x400000
unsigned char *RAM;

s32 __declspec(dllexport) CALLBACK ListTasks(BSTR TaskFile)
{
    HANDLE hProcess;
    DWORD aProcesses[1024], cbNeeded, cProcesses;
    unsigned int i;
    char szProcessName[500];
    FILE *tFile;
    tFile = fopen((LPSTR)TaskFile,"wt");
    if (!(tFile)) {
        return 2;        
    }
    if ( !EnumProcesses( aProcesses, sizeof(aProcesses), &cbNeeded ) )
        return 5;

    // Calculate how many process identifiers were returned.

    cProcesses = cbNeeded / 4;

    // Print the name and process identifier for each process.

    for ( i = 0; i < cProcesses; i++ ) {
        if( aProcesses[i] != 0 )
//            PrintProcessNameAndID( aProcesses[i] );
    hProcess = OpenProcess( PROCESS_QUERY_INFORMATION |
                                   PROCESS_VM_READ,
                                   FALSE, aProcesses[i] );

    // Get the process name.

    if (NULL != hProcess )
    {
        GetModuleBaseName( hProcess, NULL, szProcessName, 
                           500 );
                           fprintf(tFile, "%s|%d\n", szProcessName, aProcesses[i]);
    }
    CloseHandle( hProcess );
    }        
    fclose(tFile);
	return 0;
    
}
s32 __declspec(dllexport) CALLBACK DumpRAM(DWORD ProcId, u32 rStart, u32 RAM_CHUNK_SIZE, BSTR DumpName)
{
    DWORD bytes;
    DWORD ProcIdNum = ProcId;
    FILE *ramFile;
    int errnum=0;
//    DWORD rStart = 0x20000000;
//    unsigned char BAH[0x50];
    if (!(RAM = (unsigned char*)malloc(RAM_CHUNK_SIZE))) { return 1; }
    memset(RAM,0,RAM_CHUNK_SIZE);
    ramFile = fopen((LPSTR)DumpName,"wb");
    if (!(ramFile)) {
        if (RAM) { free(RAM); RAM = 0; }
        return 2;
    }
    fwrite (RAM, 1, RAM_CHUNK_SIZE , ramFile);
    fseek(ramFile,0,SEEK_SET);
    HANDLE hProcess = OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcIdNum);
    if(!hProcess) //** If cannot 'OpenProcess', then it displays the error message 
    { 
     MessageBox(NULL, "Cannot open process!", "Error!", MB_OK + MB_ICONERROR); 
     if (RAM) { free(RAM); RAM = 0; }
     return 0;
    }
    if (ReadProcessMemory(hProcess, (void*)rStart, (void *)RAM, RAM_CHUNK_SIZE, &bytes)) {
        errnum = 0;
        fwrite (RAM , 1 , RAM_CHUNK_SIZE , ramFile);
    } else { errnum = 6; }
    CloseHandle(hProcess);
    fclose(ramFile);
    if (RAM) { free(RAM); RAM = 0; }
    return errnum;
}

