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
LoadSettings
***********************************************/
int LoadSettings() {
    memset(&Defaults,0,sizeof(Defaults));
    memset(&Settings,0,sizeof(Settings));
    if (GetModuleFileName(NULL,INIFile,sizeof(INIFile)) ) {
        char *fndchr = strrchr(INIFile,'\\');
        *(fndchr + 1) = '\0';
        strcpy(Defaults.CS.DumpDir, INIFile);
        strcat(Defaults.CS.DumpDir, "Searches\\");
        strcat(INIFile,"REx.cfg");
    } else {
        sprintf(INIFile,"REx.cfg");
        strcpy(Defaults.CS.DumpDir, "Searches\\");
    }
    Defaults.ValueFontInfo = (LOGFONT){ 0, 10, 0, 0, 10, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, FF_MODERN, "Terminal"} ;
    Defaults.ValueHFont = CreateFontIndirect(&Defaults.ValueFontInfo);
    Defaults.CS.NumBase = BASE_HEX;
    Defaults.CS.NumBaseId = MNU_CS_INPUT_HEX;
    Defaults.Results.ResWriteRate = 100;
    Defaults.Results.ResWriteRateId = MNU_RES_WRITE_100MS;
    Defaults.Results.DisplayFmt = MNU_RES_SHOW_HEX;
    Defaults.Cheat.WriteRate = 100;
    Defaults.Cheat.WriteRateId = MNU_CHEAT_WRITE_100MS;
    int x = 0;
    //PC
    strcpy(Defaults.Presets[x].Name, "PC Games");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "");
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_PC;
    Defaults.Presets[x].AllRam = BST_CHECKED;
    x++;
    //project 64 1.6 8MB, XP SP2/3 Static
    strcpy(Defaults.Presets[x].Name, "Project64 v1.6 (Static)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "Project64.exe");
    Defaults.Presets[x].StartType = RAM_STATIC;
    Defaults.Presets[x].StartAddress = 0x3B0A0000;
    Defaults.Presets[x].MaxRamSize = 0x7FFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_BIG_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_N64;
    x++;
    //project 64 1.6 8MB, XP SP2/3 Pointer
    strcpy(Defaults.Presets[x].Name, "Project64 v1.6 (Pointer)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "Project64.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x4D6A1C;
    Defaults.Presets[x].MaxRamSize = 0x7FFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_BIG_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_N64;
    x++;
    //Mupen 64 0.5.1 8MB, XP SP2/3 Static
    strcpy(Defaults.Presets[x].Name, "Mupen 64 0.5.1 (Static)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "mupen64.exe");
    Defaults.Presets[x].StartType = RAM_STATIC;
    Defaults.Presets[x].StartAddress = 0x8DCC00;
    Defaults.Presets[x].MaxRamSize = 0x7FFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_BIG_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_N64;
    x++;
    //Mupen 64 0.5.1 8MB, XP SP2/3 pointer
    strcpy(Defaults.Presets[x].Name, "Mupen 64 0.5.1 (Pointer)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "mupen64.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x46D010;
    Defaults.Presets[x].MaxRamSize = 0x7FFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_BIG_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_N64;
    x++;
    //Nemu64 0.8 4MB, XP Static
    strcpy(Defaults.Presets[x].Name, "Nemu64 0.8 4MB (Static)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "nemu64.exe");
    Defaults.Presets[x].StartType = RAM_STATIC;
    Defaults.Presets[x].StartAddress = 0x10020000;
    Defaults.Presets[x].MaxRamSize = 0x3FFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_BIG_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_N64;
    x++;
    //Nemu64 0.8 8MB, XP Static
    strcpy(Defaults.Presets[x].Name, "Nemu64 0.8 8MB (Static)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "nemu64.exe");
    Defaults.Presets[x].StartType = RAM_STATIC;
    Defaults.Presets[x].StartAddress = 0x10020000;
    Defaults.Presets[x].MaxRamSize = 0x7FFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_BIG_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_N64;
    x++;
    //PCSX 1.5 w/Debugger Pointer
    strcpy(Defaults.Presets[x].Name, "PCSX 1.5 w/Debugger (Pointer)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "pcsx.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x49BFB8;
    Defaults.Presets[x].MaxRamSize = 0x1FFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_PS1;
    x++;
    //PCSX2 0.9.4 (pointer)
    strcpy(Defaults.Presets[x].Name, "PCSX2 0.9.4 (TLB Build Only)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "pcsx2t.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x263E8A8;
    Defaults.Presets[x].MaxRamSize = 0x1FFFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_PS2;
    x++;
    //PCSX2 0.9.4 SVN 390 (static)
    strcpy(Defaults.Presets[x].Name, "PCSX2 0.9.4 SVN390 (TLB Build Only)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "pcsx2tsvn390.exe");
    Defaults.Presets[x].StartType = RAM_STATIC;
    Defaults.Presets[x].StartAddress = 0x9B10050;
    Defaults.Presets[x].MaxRamSize = 0x1FFFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_PS2;
    x++;
    //PCSX2 0.9.6 (static)
    strcpy(Defaults.Presets[x].Name, "PCSX2 0.9.6");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "pcsx2 0.9.6.exe");
    Defaults.Presets[x].StartType = RAM_STATIC;
    Defaults.Presets[x].StartAddress = 0x4DB1000;
    Defaults.Presets[x].MaxRamSize = 0x1FFFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_PS2;
    x++;
    //VBA-M SVN750 WRAM
    strcpy(Defaults.Presets[x].Name, "VBA-M SVN750 (WRAM/0200)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "visualboyadvance.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x67A988;
    Defaults.Presets[x].MaxRamSize = 0x3FFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_GBA_WRAM;
    x++;
    //VBA-M SVN750 IRAM
    strcpy(Defaults.Presets[x].Name, "VBA-M SVN750 (IRAM/0300)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "visualboyadvance.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x67A990;
    Defaults.Presets[x].MaxRamSize = 0x7FFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_GBA_IRAM;
    x++;
    //VBA 1.7.2 SDL WRAM
    strcpy(Defaults.Presets[x].Name, "VisualBoyAdvance 1.7.2 SDL (WRAM/0200)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "visualboyadvance-sdl.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x587170;
    Defaults.Presets[x].MaxRamSize = 0x3FFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_GBA_WRAM;
    x++;
    //VBA 1.7.2 SDL IRAM
    strcpy(Defaults.Presets[x].Name, "VisualBoyAdvance 1.7.2 SDL (IRAM/0300)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "visualboyadvance-sdl.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x587178;
    Defaults.Presets[x].MaxRamSize = 0x7FFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_GBA_IRAM;
    x++;
    //No$GBA NDS RAM
    strcpy(Defaults.Presets[x].Name, "No$GBA 2.6a (NDS RAM)");
    Defaults.Presets[x].HookType = HOOK_PROCESS;
    strcpy(Defaults.Presets[x].FileName, "no$gba.exe");
    Defaults.Presets[x].StartType = RAM_POINTER;
    Defaults.Presets[x].StartAddress = 0x00473de4;
    Defaults.Presets[x].MaxRamSize = 0x3FFFFF;
    Defaults.Presets[x].Endian = LITTLE_ENDIAN_SYS;
    Defaults.Presets[x].SearchAccess = SEARCH_ACCESS_AUTO;
    Defaults.Presets[x].System = SYSTEM_NDS;
    x++;

    FILE *f;
    f = fopen(INIFile,"rb");
    if (!(f)) {
        memcpy(&Settings,&Defaults,sizeof(Defaults));
        mkdir(Settings.CS.DumpDir);
        return 1;
    }
    fseek(f,0,SEEK_SET);
    fread(&Settings,1,sizeof(Settings),f);
    fclose(f);
    mkdir(Settings.CS.DumpDir);
    return 0;
}

/**********************************************
SaveSettings
***********************************************/
int SaveSettings()
{
    SaveStruct(&Settings, sizeof(Settings), INIFile);
    return 0;
}

/**********************************************
Hex editbox procedure - forces a textbox to hex input
-check length of current text on maxlength change???
***********************************************/
LRESULT CALLBACK HexEditBoxProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case WM_CHAR:
        {
            if ((wParam == VK_BACK) || (wParam == 24) || (wParam == 3) || (wParam == 22)) { break; } //cut/copy/paste/backspace
            if (wParam == 1) { SendMessage(hwnd, EM_SETSEL, 0, -1); } //select all
//            if (SendMessage(hwnd, EM_GETLIMITTEXT, 0, 0) == 8) {
                wParam = FilterHexChar(wParam);
//            }
        } break;
        case WM_PASTE:
        {
            char txtInput[20], txtInput2[20];
            GetWindowText(hwnd, txtInput, sizeof(txtInput));
            CallWindowProc (wpHexEditBoxes, hwnd, message, wParam, lParam);
            GetWindowText(hwnd, txtInput2, sizeof(txtInput2));
            if ((!isHexWindow(hwnd)) || (strlen(txtInput2) > SendMessage(hwnd, EM_GETLIMITTEXT, 0, 0))) { SetWindowText(hwnd, txtInput); }
        } return 0;
   }
   if (wpHexEditBoxes) { return CallWindowProc (wpHexEditBoxes, hwnd, message, wParam, lParam); }
   else { return DefWindowProc (hwnd, message, wParam, lParam); }
}

/**********************************************
Hex window functions
***********************************************/
int isHexWindow(HWND txtbox)
{
    char txtInput[17];
    GetWindowText(txtbox, txtInput, sizeof(txtInput));
    return isHex(txtInput);
}

u64 GetHexWindow(HWND txtbox)
{
    char txtInput[17];
    u64 tvalue=0;
    GetWindowText(txtbox, txtInput, sizeof(txtInput));
    if (isHex(txtInput)) { sscanf(txtInput,"%I64x",&tvalue); }
    return tvalue;
}

int SetHexWindow(HWND txtbox, u64 value)
{
    char txtValue[20], fmtString[20];
    sprintf(fmtString, "%%0%uI64X", SendMessage(txtbox, EM_GETLIMITTEXT, 0, 0));
    sprintf(txtValue, fmtString, value);
    SetWindowText(txtbox, txtValue);
    return 0;
}

/**********************************************
Decimal window functions
***********************************************/
u64 isDecWindow(HWND txtbox)
{
    char txtInput[31];
    GetWindowText(txtbox, txtInput, sizeof(txtInput));
    return isDec(txtInput);
}
u64 GetDecWindow(HWND txtbox)
{
    char txtInput[31];
    u64 tvalue=0;
    GetWindowText(txtbox, txtInput, sizeof(txtInput));
    if (isDec(txtInput)) { sscanf(txtInput,"%I64d",&tvalue); }
    return tvalue;
}
int SetDecWindowU(HWND txtbox, u64 value)
{
    char txtValue[31];
    sprintf(txtValue, "%I64u", value);
    SetWindowText(txtbox, txtValue);
    return 0;
}

/**********************************************
Float window functions
***********************************************/
u64 IsFloatWindow(HWND txtbox)
{
    char txtInput[30];
    GetWindowText(txtbox, txtInput, sizeof(txtInput));
    return isFloat(txtInput);
}

u64 GetFloatWindow(HWND txtbox, int fsize)
{
    char txtInput[30];
    float tmpFloat;
    double tmpDouble;
    GetWindowText(txtbox, txtInput, sizeof(txtInput));
    if (!isFloat(txtInput)) { return 0; }
    if (fsize == 4 ) {
        sscanf(txtInput, "%f", &tmpFloat);
        return Float2Hex(tmpFloat);
    }
    else {
        sscanf(txtInput, "%Lf", &tmpDouble);
        return Double2Hex(tmpDouble);
    }
}


/**********************************************
Set hook info
***********************************************/
int ResetHook()
{
    CloseHandle(HookedProcess.hProcess);
    CloseHandle(HookedProcess.hThread);
    memset(&HookedProcess, 0, sizeof(PROCESS_INFORMATION));
    SetWindowText(hwndMain,PROGRAM_NAME);
    return 0;
}

int InitHook()
{
    if ( !EnableTokenPrivilege (SE_DEBUG_NAME) )
    {
        MessageBox(NULL, "Cannot get required privilege", "Error", MB_OK);
        return 1;
    }
    HookedProcess.hProcess = OpenProcess(PROCESS_ALL_ACCESS, FALSE, HookedProcess.dwProcessId);
    char txtTitle[100], szProcessName[80];
    strcpy(txtTitle,PROGRAM_NAME); strcat(txtTitle," - ");
    GetModuleBaseName(HookedProcess.hProcess, NULL, szProcessName, 80 );
    strcat(txtTitle,szProcessName);
    SetWindowText(hwndMain,txtTitle);
    SetWindowText(GetDlgItem(hTabDlgs[HOOK_TAB], TXT_HOOK_EXENAME), szProcessName);
    return 0;
}

int VerifyHook()
{
    char szProcessName[MAX_PATH];
    if ((HookedProcess.hProcess == 0) || (HookedProcess.dwProcessId == 0)) { return 0; }
    GetModuleBaseName( HookedProcess.hProcess, NULL, szProcessName, MAX_PATH );
    if (StringCompareCI(szProcessName, Settings.Hook.FileName)) { return 0; }
    return 1; //returns 1 if hook is still good
}

/**********************************************
Enable Token Privilege - set debug(?) privilege
***********************************************/
BOOL EnableTokenPrivilege (LPTSTR privilege)
{
    HANDLE hToken;
    TOKEN_PRIVILEGES token_privileges;
    DWORD dwSize;
    ZeroMemory (&token_privileges, sizeof (token_privileges));
    token_privileges.PrivilegeCount = 1;
    if ( !OpenProcessToken (GetCurrentProcess(), TOKEN_ALL_ACCESS, &hToken))
        return FALSE;
    if (!LookupPrivilegeValue ( NULL, privilege, &token_privileges.Privileges[0].Luid))
    {
        CloseHandle (hToken);
        return FALSE;
    }

    token_privileges.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;
    if (!AdjustTokenPrivileges ( hToken, FALSE, &token_privileges, 0, NULL, &dwSize))
    {
        CloseHandle (hToken);
        return FALSE;
    }
    CloseHandle (hToken);
    return TRUE;
}

/**********************************************
Combobox Add Item
***********************************************/
int ComboAddItem(HWND hCombo, const char* combostring, DWORD value)
{
    int iCount = SendMessage(hCombo,CB_GETCOUNT,0,0);
    SendMessage(hCombo,CB_ADDSTRING,iCount,(LPARAM)combostring);
    return SendMessage(hCombo,CB_SETITEMDATA,iCount,value);
}

/**********************************************
Free shit
***********************************************/

int FreeShit()
{
    FreeRamInfo();
    if (ResultsList) { free(ResultsList); ResultsList = NULL; }
    return 0;
}

/**********************************************
Free RAM info
***********************************************/
int FreeRamInfo()
{
    if (RamInfo.NewRAM) { free(RamInfo.NewRAM); RamInfo.NewRAM = NULL; }
    if (RamInfo.OldRAM) { free(RamInfo.OldRAM); RamInfo.OldRAM = NULL; }
    if (RamInfo.NewFile) { fclose(RamInfo.NewFile); RamInfo.NewFile = NULL; }
    if (RamInfo.OldFile) { fclose(RamInfo.OldFile); RamInfo.OldFile = NULL; }
    if (RamInfo.AddressMap) { free(RamInfo.AddressMap); RamInfo.AddressMap = NULL; }
    if (RamInfo.Results) { free(RamInfo.Results); RamInfo.Results = NULL; }
    RamInfo.MapSize = 0;
    memset(&RamInfo.OldResultsInfo, 0, sizeof(CODE_SEARCH_RESULTS_INFO));
    memset(&RamInfo.NewResultsInfo, 0, sizeof(CODE_SEARCH_RESULTS_INFO));
    return 0;
}

/**********************************************
Set fState (checked/disabled/etc) of a menu item
***********************************************/
int SetMenuState(HMENU hMenu, UINT id, UINT state)
{
    MENUITEMINFO mnuItem; memset(&mnuItem,0,sizeof(mnuItem));
    mnuItem.cbSize = sizeof(MENUITEMINFO);
    mnuItem.fMask = MIIM_STATE;
    mnuItem.fState = state;
    return SetMenuItemInfo(hMenu, id, FALSE, &mnuItem);
}

/**********************************************
Set Menu Item Text
***********************************************/
int SetMenuItemText(HMENU hMenu, UINT id, const char* MenuText)
{
    MENUITEMINFO mnuItem; memset(&mnuItem,0,sizeof(MENUITEMINFO));
    mnuItem.cbSize = sizeof(MENUITEMINFO);
    mnuItem.fMask = MIIM_STRING;
    mnuItem.dwTypeData = (char*)MenuText;
    return SetMenuItemInfo(hMenu, id, FALSE, &mnuItem);
}

/**********************************************
Set Menu Item Data
***********************************************/
int SetMenuItemData(HMENU hMenu, UINT id, UINT data)
{
    MENUITEMINFO mnuItem; memset(&mnuItem,0,sizeof(MENUITEMINFO));
    mnuItem.cbSize = sizeof(MENUITEMINFO);
    mnuItem.fMask = MIIM_DATA;
    mnuItem.dwItemData = data;
    return SetMenuItemInfo(hMenu, id, FALSE, &mnuItem);
}

/**********************************************
Get Menu Item Data
***********************************************/
int GetMenuItemData(HMENU hMenu, UINT id)
{
    MENUITEMINFO mnuItem; memset(&mnuItem,0,sizeof(MENUITEMINFO));
    mnuItem.cbSize = sizeof(MENUITEMINFO);
    mnuItem.fMask = MIIM_DATA;
    GetMenuItemInfo(hMenu, id, FALSE, &mnuItem);
    return mnuItem.dwItemData;
}

/**********************************************
Add Header Item
***********************************************/
int AddHeaderItem(HWND hHeader, int size, const char* txtHeader)
{
    HDITEM hdItem; memset(&hdItem,0,sizeof(HDITEM));
    hdItem.mask = HDI_TEXT | HDI_FORMAT | HDI_WIDTH;
    hdItem.cxy = size;
    hdItem.cchTextMax = strlen(txtHeader);
    hdItem.pszText = (char*)txtHeader;
    hdItem.fmt = HDF_LEFT | HDF_STRING;
    return SendMessage(hHeader, HDM_INSERTITEM, SendMessage(hHeader, HDM_GETITEMCOUNT,0,0), (LPARAM)&hdItem);
}

/**********************************************
Set Header Item Text
***********************************************/
int SetHeaderItemText(HWND hHeader, int item, const char* txtHeader)
{
    HDITEM hdItem; memset(&hdItem,0,sizeof(HDITEM));
    hdItem.mask = HDI_TEXT;
    hdItem.cchTextMax = strlen(txtHeader);
    hdItem.pszText = (char*)txtHeader;
    hdItem.fmt = HDF_STRING;
    return SendMessage(hHeader, HDM_SETITEM, item, (LPARAM)&hdItem);
}

/**********************************************
ComboSelFromData - Set selected combo box item based on item data
***********************************************/
int ComboSelFromData (HWND hCombo, u32 DataValue)
{
    int i;
    int NumItems = SendMessage(hCombo, CB_GETCOUNT, 0, 0);
    for (i = 0; i < NumItems; i++) {
        if (SendMessage(hCombo, CB_GETITEMDATA, i, 0) == DataValue) {
            SendMessage(hCombo,CB_SETCURSEL,i,0); return i;
        }
    }
    return -1;
}


