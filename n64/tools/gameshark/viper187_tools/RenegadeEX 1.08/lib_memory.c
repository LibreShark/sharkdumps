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

/**********************************************
Dump Memory
***********************************************/
u32 DumpRAM()
{
#if (EMU_INTEGRATE == 1) //Mupen
    extern unsigned long rdram[0x800000/4];
    FILE *emuDump = fopen(RamInfo.NewResultsInfo.dmpFileName, "wb");
	if (!(emuDump)) {
        sprintf(ErrTxt, "Unable to open/create file (DumpRAM,1) -- Error %u", GetLastError());
        MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
    }
    fseek(emuDump,0,SEEK_SET);
    fwrite(rdram, 1, 0x800000, emuDump);
    fclose(emuDump);
    return 0x800000;
#endif
    u32 filesize = 0;
//    u32 chunksize = 0x100000;
    u32 chunksize = 0;
    DWORD bytesread;
    u8 *buffer = NULL;
    u32 RamStart = Settings.Hook.StartAddress;
    u32 i;
    if (!VerifyHook()) {
        MessageBox(NULL, "ProcessID no longer valid. Unable to read memory (DumpRAM, 1)", "Error", MB_OK);
        return 0;
    }
//NDS Specific checks
    if (Settings.Hook.System == SYSTEM_NDS) {
        if (!(RamStart = FindNDSRAM())) {
            sprintf(ErrTxt, "Unable to verify NDS RAM start location (DumpRAM, 1) -- Error %u", GetLastError());
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            return 0;
        }
    }
//NDS Specific checks
    else if (Settings.Hook.StartType == RAM_POINTER) {
        if (ReadProcessMemory(HookedProcess.hProcess, (void*)Settings.Hook.StartAddress, &RamStart, 4, &bytesread) == 0) {
            sprintf(ErrTxt, "Unable to read pointer (DumpRAM, 1) -- Error %u", GetLastError());
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            return 0;
        }
    } else { RamStart = Settings.Hook.StartAddress; }
    if (Settings.Hook.AllRam != BST_CHECKED) {
        chunksize = Settings.Hook.MaxRamSize;
        if (RamInfo.NewRAM) { free(RamInfo.NewRAM); RamInfo.NewRAM = NULL; }
        if (!(RamInfo.NewRAM = (unsigned char*)malloc(chunksize+1))) {
            sprintf(ErrTxt, "Unable to allocate ramdata memory (DumpRAM, 1) -- Error %u", GetLastError());
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            return 0;
        }

        if (ReadProcessMemory(HookedProcess.hProcess, (void*)RamStart, RamInfo.NewRAM, chunksize, &bytesread) == 0) {
            sprintf(ErrTxt, "Unable to dump RAM from process (DumpRAM, 1) -- Error %u", GetLastError());
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            free(RamInfo.NewRAM); RamInfo.NewRAM = NULL; return 0;
        }
        SaveFile(RamInfo.NewRAM, bytesread, RamInfo.NewResultsInfo.dmpFileName, 0, NULL);
        FILE *MapFile = fopen(RamInfo.NewResultsInfo.MapFileName, "wb");
        if (!(MapFile)) { return bytesread; }
        fseek(MapFile,0,SEEK_SET);
        RamInfo.NewResultsInfo.Mapped = 1;
        switch (Settings.Hook.System)
        {
            case SYSTEM_N64:
            {
                putw(0, MapFile);
                putw(0x80000000, MapFile);
                putw(0x800000, MapFile);
            } break;
            case SYSTEM_PS1:
            {
                putw(0, MapFile);
                if (RamInfo.NewResultsInfo.SearchSize == 1) { putw(0x30000000, MapFile); }
                else { putw(0x80000000, MapFile); }
                putw(0x200000, MapFile);
            } break;
            case SYSTEM_GBA_WRAM:
            {
                putw(0, MapFile);
                putw(0x02000000, MapFile);
                putw(0x3FFFF, MapFile);
            } break;
            case SYSTEM_GBA_IRAM:
            {
                putw(0, MapFile);
                putw(0x03000000, MapFile);
                putw(0x7FFF, MapFile);
            } break;
            case SYSTEM_NDS:
            {
                putw(0, MapFile);
                putw(0x02000000, MapFile);
                putw(0x3FFFFF, MapFile);
            } break;
            default: RamInfo.NewResultsInfo.Mapped = 0;
        }
        fclose(MapFile);
        return bytesread;
    }
    //dumping whole process from here on
    RamInfo.NewResultsInfo.Mapped = 1;
    FILE *DumpFile = fopen(RamInfo.NewResultsInfo.dmpFileName, "wb");
    if (!(DumpFile)) {
        sprintf(ErrTxt, "Unable to open dump file (DumpRAM,1) -- Error %u", GetLastError());
        MessageBox(NULL, ErrTxt, "Error", MB_OK);
        return 0;
    }
    fseek(DumpFile,0,SEEK_SET);
    FILE *MapFile = fopen(RamInfo.NewResultsInfo.MapFileName, "wb");
    if (!(MapFile)) {
        sprintf(ErrTxt, "Unable to open map file (DumpRAM,1) -- Error %u", GetLastError());
        MessageBox(NULL, ErrTxt, "Error", MB_OK);
        return 0;
    }
    fseek(MapFile,0,SEEK_SET);
    if (RamInfo.OldResultsInfo.Mapped) {
        if (!(RamInfo.MapSize = LoadFile(&RamInfo.AddressMap, RamInfo.OldResultsInfo.MapFileName, 0, NULL, FALSE))) { return 0; }
        u32 address;
        int DumpedAny = 0;
        for (i = 0; i < RamInfo.MapSize; i += 0xC) {
            address = *(u32*)&RamInfo.AddressMap[i+4];
            chunksize = *(u32*)&RamInfo.AddressMap[i+8];
            if (buffer) { free(buffer); buffer = NULL; }
            if (!(buffer = (unsigned char*)malloc(chunksize+1))) {
                sprintf(ErrTxt, "Unable to allocate buffer memory (DumpRAM, 1) -- Error %u", GetLastError());
                MessageBox(NULL, ErrTxt, "Error", MB_OK);
                fclose(DumpFile); fclose(MapFile); return 0;
            }
            if (ReadProcessMemory(HookedProcess.hProcess, (VOID*)address, buffer, chunksize, &bytesread)) {
                DumpedAny = 1;
                //WARNING INSTEAD
            }
            putw(filesize,MapFile);
            putw(address,MapFile);
            putw(chunksize,MapFile);
            fwrite(buffer,1,chunksize,DumpFile);
            filesize += chunksize;
        }
        free(buffer); buffer = NULL;
        fclose(DumpFile); fclose(MapFile); //fclose(OldMapFile);
        if (!DumpedAny) {
            sprintf(ErrTxt, "Unable to dump RAM from process (DumpRAM, 2) -- Error %u\nAddress: %08X\nRegion Size: %X", GetLastError(), address, chunksize);
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            return 0;
        }
        return filesize;
    }

    MEMORY_BASIC_INFORMATION memInfo; memset(&memInfo,0,sizeof(MEMORY_BASIC_INFORMATION));
    SYSTEM_INFO sysInfo;
    GetSystemInfo(&sysInfo);
    VOID* address = (VOID*)0x11000;
/*
    HMODULE hModule;
    MODULEINFO ModuleInfo;
    EnumProcessModules(HookedProcess.hProcess, &hModule, sizeof(hModule), &bytesread);
    GetModuleInformation(HookedProcess.hProcess, hModule, &ModuleInfo, sizeof(MODULEINFO));
*/
//    VOID* address = sysInfo.lpMinimumApplicationAddress;
    while (address < sysInfo.lpMaximumApplicationAddress) //stop during map lookup???
	{
        VirtualQueryEx(HookedProcess.hProcess, address, &memInfo, sizeof(MEMORY_BASIC_INFORMATION));
        address = memInfo.BaseAddress + memInfo.RegionSize;
//        if (memInfo.BaseAddress == ModuleInfo.lpBaseOfDll) { continue; }
//		if (memInfo.State != MEM_COMMIT) { continue; }
//		if (memInfo.Type != MEM_PRIVATE) { continue; }
		if (memInfo.State == MEM_FREE) { continue; }
		if ((memInfo.Protect & (PAGE_READWRITE|PAGE_WRITECOPY|PAGE_EXECUTE_READWRITE|PAGE_EXECUTE_WRITECOPY)) == 0) { continue; }
		if (memInfo.Protect & (PAGE_NOACCESS|PAGE_READONLY|PAGE_EXECUTE|PAGE_EXECUTE_READ|PAGE_GUARD)) { continue; }

        if (buffer) { free(buffer); buffer = NULL; }
        if (!(buffer = (unsigned char*)malloc((DWORD)memInfo.RegionSize+1))) {
            sprintf(ErrTxt, "Unable to allocate buffer memory (DumpRAM, 2) -- Error %u", GetLastError());
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            fclose(DumpFile); fclose(MapFile);
            return 0;
        }

        if (ReadProcessMemory(HookedProcess.hProcess, memInfo.BaseAddress, buffer, memInfo.RegionSize, &bytesread) == 0) {
                //fail
            sprintf(ErrTxt, "Unable to dump RAM from process (DumpRAM, 3) -- Error %u\nAddress: %08X\nRegion Size: %X\nProtection: %08X\n State: %X, Type: %X", GetLastError(), memInfo.BaseAddress, memInfo.RegionSize, memInfo.Protect, memInfo.State, memInfo.Type);
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            free(buffer); buffer = NULL;
            fclose(DumpFile); fclose(MapFile);
            return 0;
        }
//fprintf(BAH, "%08X, %X\n", (DWORD)memInfo.BaseAddress, memInfo.RegionSize);
        putw(filesize,MapFile);
        putw((DWORD)memInfo.BaseAddress,MapFile);
        putw(memInfo.RegionSize,MapFile);
        fwrite(buffer,1,memInfo.RegionSize,DumpFile);
        filesize += memInfo.RegionSize;
	}
//fclose(BAH);
	free(buffer); buffer = NULL;
    fclose(DumpFile);
    fclose(MapFile);


//sprintf(ErrTxt, "%08X, %08X, %08X, %08X", address, memInfo.BaseAddress, memInfo.RegionSize, memInfo.State);
//sprintf(ErrTxt, "%u", NumEntries);
//MessageBox(NULL, ErrTxt, "Error", MB_OK);
    return filesize;
}

/**********************************************
Find NDS RAM - working method, but the hex string appears at both start of RAM and ROM
***********************************************/
u32 FindNDSRAM()
{
    u32 i;
    u8 *buffer = NULL;
    DWORD bytesread;
    u32 NDSCheck = 0;
    //update this to include the pointers?
    ReadProcessMemory(HookedProcess.hProcess, (void*)Settings.Hook.StartAddress, &NDSCheck, 4, &bytesread);
    if (NDSCheck == 0xE7FFDEFF) {
        return Settings.Hook.StartAddress - Settings.Hook.EntryOffset;
    }
    MEMORY_BASIC_INFORMATION memInfo; memset(&memInfo,0,sizeof(MEMORY_BASIC_INFORMATION));
    SYSTEM_INFO sysInfo;
    GetSystemInfo(&sysInfo);
    VOID* address = (VOID*)0x11000;

    while (address < sysInfo.lpMaximumApplicationAddress) //stop during map lookup???
	{
        VirtualQueryEx(HookedProcess.hProcess, address, &memInfo, sizeof(MEMORY_BASIC_INFORMATION));
        address = memInfo.BaseAddress + memInfo.RegionSize;
//        if (memInfo.BaseAddress == ModuleInfo.lpBaseOfDll) { continue; }
//		if (memInfo.State != MEM_COMMIT) { continue; }
//		if (memInfo.Type != MEM_PRIVATE) { continue; }
		if (memInfo.State == MEM_FREE) { continue; }
		if ((memInfo.Protect & (PAGE_READWRITE|PAGE_WRITECOPY|PAGE_EXECUTE_READWRITE|PAGE_EXECUTE_WRITECOPY)) == 0) { continue; }
		if (memInfo.Protect & (PAGE_NOACCESS|PAGE_READONLY|PAGE_EXECUTE|PAGE_EXECUTE_READ|PAGE_GUARD)) { continue; }

        if (buffer) { free(buffer); buffer = NULL; }
        if (!(buffer = (unsigned char*)malloc((DWORD)memInfo.RegionSize+1))) {
            sprintf(ErrTxt, "Unable to allocate buffer memory (DumpRAM, 2) -- Error %u", GetLastError());
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            return 0;
        }
        if (ReadProcessMemory(HookedProcess.hProcess, memInfo.BaseAddress, buffer, memInfo.RegionSize, &bytesread) == 0) {
                //fail
            sprintf(ErrTxt, "Unable to dump RAM from process (DumpRAM, 3) -- Error %u\nAddress: %08X\nRegion Size: %X\nProtection: %08X\n State: %X, Type: %X", GetLastError(), memInfo.BaseAddress, memInfo.RegionSize, memInfo.Protect, memInfo.State, memInfo.Type);
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            free(buffer); buffer = NULL;
            return 0;
        }
        for (i = 0; i < memInfo.RegionSize; i += 4)
        {
            if ( ((*(u32*)(&buffer[i]) == 0xE7FFDEFF) && (*(u32*)(&buffer[i + 4]) == 0xE7FFDEFF) && (*(u32*)(&buffer[i + 8]) == 0xE7FFDEFF)) && ((memInfo.RegionSize < 0x66A000) || (memInfo.RegionSize < 0x664000)) ) {
                Settings.Hook.StartAddress = (DWORD)memInfo.BaseAddress + i;
                Settings.Hook.StartType = RAM_STATIC;
                SendMessage(hTabDlgs[HOOK_TAB], WM_COMMAND, VCMD_HOOK_SHOW_SETTS, 0);
//                sprintf(ErrTxt, "%X", memInfo.RegionSize);
//                MessageBox(NULL, ErrTxt, "Debug", MB_OK);
                return Settings.Hook.StartAddress;
            }
        }
	}
	free(buffer); buffer = NULL;

    return 0;
}


/**********************************************
FlipAddress
***********************************************/
u32 FlipAddress(u32 address, int size, int endian)
{
    switch (endian)
    {
        case LITTLE_ENDIAN_SYS: case BIG_ENDIAN: { return address; } break;
        case LITTLE_ENDIAN_BIG_SYS:
        {
            if (size == 1) { return address^3; }
            else if (size == 2) { return address^2; }
            else { return address; }
        }
    }
    return address; //Should NOT get here
}

/**********************************************
Write memory
***********************************************/
int WriteRAM(u32 address, u32 value, int size, int endian)
{
    #if (EMU_INTEGRATE == 1) //Mupen
        extern unsigned long rdram[0x800000/4];
        u32 tmpWord = rdram[address/4];
        switch (size)
        {
            case 1:
            {
//                (u8*)rdram[address] = value;
                rdram[address/4] = (rdram[address/4] & (~(0x000000FF << ((3 - (address & 3)) * 8)))) | (value << ((3 - (address & 3)) * 8));
//             rdram[address/4] = (rdram[address/4] & (0xFFFFFFFF << (size * 8))) | value;
            } break;
            case 2:
            {
//                sprintf(ErrTxt, "%X:%X", address, value);
//                MessageBox(NULL, ErrTxt, "Debug", MB_OK);
//                (u8*)rdram[address] = value;
//        sprintf(ErrTxt, "%X, %X, %X, %X", address, rdram[address/4], value, (~(0x0000FFFF << ((2 - (address & 2)) * 8))));
//        MessageBox(NULL, ErrTxt, "Debug", MB_OK);
                rdram[address/4] = (rdram[address/4] & (~(0x0000FFFF << ((2 - (address & 2)) * 8)))) | (value << ((2 - (address & 2)) * 8));
//             rdram[address/4] = (rdram[address/4] & (0xFFFFFFFF >> (size * 8))) | (value << ((4-size) * 8));
            } break;
            case 4: { rdram[address/4] = value; } break;
            case 8:
            {
                rdram[address/4] = (rdram[address/4] & (0xFF << (size * 8))) | (value >> 32);
                rdram[(address/4)+4] = (rdram[(address/4)+4] & (0xFF << (size * 8))) | (value & 0xFFFFFFFF);
            } break;
        }
        if (rdram[address/4] != tmpWord) {
            extern char invalid_code[0x100000];
            if (invalid_code[(address|0x80000000)>>12] == 0) { invalid_code[(address|0x80000000)>>12] = 1; }
        }
        return size;
    #endif
//            silent
    u32 RamStart = Settings.Hook.StartAddress;
    DWORD BytesAccessed;
    if (!VerifyHook()) { return 0; }
    if (Settings.Hook.System == SYSTEM_NDS) {
        if (!(RamStart = FindNDSRAM())) { return 0; }
    }
    else if (Settings.Hook.AllRam) { RamStart = 0; }
    else if (Settings.Hook.StartType == RAM_POINTER) {
        if (ReadProcessMemory(HookedProcess.hProcess, (void*)Settings.Hook.StartAddress, &RamStart, 4, &BytesAccessed) == 0) {
//            sprintf(ErrTxt, "Unable to read pointer (WriteRAM, 1) -- Error %u", GetLastError());
//            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            return 0;
        }
    }
    address = FlipAddress(RamStart + address, size, endian);
    if (WriteProcessMemory(HookedProcess.hProcess, (void*)address, &value, size, &BytesAccessed) == 0) {
//            sprintf(ErrTxt, "Unable to write memory (WriteRAM, 1) -- Error %u", GetLastError());
//            MessageBox(NULL, ErrTxt, "Error", MB_OK);
        return 0;
    }
//sprintf(ErrTxt,"%08X: %08X, %d", address, value, BytesAccessed);
//MessageBox(NULL, ErrTxt, "Error", MB_OK);
    return BytesAccessed;
}

/**********************************************
Read memory
***********************************************/
int ReadRAM(u32 address, u64 *value, int size, int endian)
{
    #if (EMU_INTEGRATE == 1) //Mupen
        extern unsigned long rdram[0x800000/4];
        switch(size)
        {
            case 1: { *value = ByteFromU64(rdram[address/4], 4 + (address & 3)); } return size;
            case 2: { *value = ShortFromU64(rdram[address/4], 4 + (address & 2)); } return size;
            case 4: { *value = rdram[address/4]; } return size;
            case 8: {
                *value = ((u64)(rdram[address/4]) << 32) | rdram[(address/4)+4];
            } return size;
        }
        *value = 0; return 0;
    #endif
//            silent
    u32 RamStart = Settings.Hook.StartAddress;
    DWORD BytesAccessed;
    if (!VerifyHook()) { return 0; }
    if (Settings.Hook.System == SYSTEM_NDS) {
        if (!(RamStart = FindNDSRAM())) { return 0; }
    }
    else if (Settings.Hook.AllRam) { RamStart = 0; }
    else if (Settings.Hook.StartType == RAM_POINTER) {
        if (ReadProcessMemory(HookedProcess.hProcess, (void*)Settings.Hook.StartAddress, &RamStart, 4, &BytesAccessed) == 0) {
            return 0;
        }
    }
    address = FlipAddress(RamStart + address, size, endian);
    if (ReadProcessMemory(HookedProcess.hProcess, (void*)address, value, size, &BytesAccessed) == 0) {
        return 0;
    }
    return BytesAccessed;
}
/**********************************************
Get system address mask
***********************************************/
u32 GetSystemAddressMask(int system, int searchsize)
{
    switch(system)
    {
        case SYSTEM_N64:
        {
            return 0x80000000;
        } break;
        case SYSTEM_PS1:
        {
            if (searchsize > 1) return 0x80000000;
            return 0x30000000;
        } break;
        case SYSTEM_GBA_WRAM: case SYSTEM_NDS:
        {
            return 0x02000000;
        } break;
        case SYSTEM_GBA_IRAM:
        {
            return 0x03000000;
        } break;
    }
    return 0;
}

/**********************************************
InvalidateDynarec
Invalidate dynarec when opening or closing the debugger to recompile all instructions
This is needed because a call to update_debugger() is compiled into every instruction when the debugger is open
~by Parasyte
***********************************************/
#if (EMU_INTEGRATE == 1) //Mupen
void invalidate_dynarec()
{
    extern char invalid_code[0x100000];
    int i;
    for (i = 0; i < 0x100000; i++) {
        invalid_code[i] = 1;
    }
}
#endif

