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

int ListProcesses(HWND hProcessList);
int ListPresets(HWND hPresetCMB, int SetSel);
int SearchProcList(HWND hProcessList, char* findname);
BOOL CALLBACK GetWindowFromProcessID(HWND hWnd, LPARAM lParam);
LRESULT CALLBACK HookListViewProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
WNDPROC oldHookListViewProc = 0;
const int HookTimer = 0x1;

BOOL CALLBACK HookProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
    HWND hProcList = GetDlgItem(hwnd, LSV_HOOK_PROCESSES);
    HWND hPresetCombo = GetDlgItem(hwnd, CMB_HOOK_PRESETS);
    HWND hRamStart = GetDlgItem(hwnd, TXT_HOOK_RAMSTART);
    HWND hMaxRamSize = GetDlgItem(hwnd, TXT_HOOK_RAMSIZE);
    HWND hPresetName = GetDlgItem(hwnd, TXT_HOOK_PNAME);
    HWND hProgramPath = GetDlgItem(hwnd, TXT_HOOK_PROG_PATH);
    HWND hProcessName = GetDlgItem(hwnd, TXT_HOOK_EXENAME);
    HWND hRamStartType = GetDlgItem(hwnd, CMB_HOOK_START_TYPE);
    HWND hEndian = GetDlgItem(hwnd, CMB_HOOK_ENDIAN);
    HWND hHookProcess = GetDlgItem(hwnd, OPT_HOOK_PROCESS);
    HWND hHookFile = GetDlgItem(hwnd, OPT_HOOK_FILE);
    HWND hAutoFind = GetDlgItem(hwnd, CMB_HOOK_AUTOFIND);
    HWND hAllRamChk = GetDlgItem(hwnd, CHK_HOOK_ALL_RAM);
    HWND hAccessType = GetDlgItem(hwnd, CMB_HOOK_ACCESS_TYPE);
    HWND hSystem = GetDlgItem(hwnd, CMB_HOOK_SYSTEM);
    HWND hProgPathButton = GetDlgItem(hwnd, CMD_HOOK_PROG_PATH);
    HWND hEntryOffset = GetDlgItem(hwnd, TXT_HOOK_ENTRY_OFFSET);
	switch(message)
	{
		case WM_INITDIALOG:
        {
            //setup process list
		    oldHookListViewProc = (WNDPROC)GetWindowLongPtr (hProcList, GWLP_WNDPROC);
		    SetWindowLongPtr (hProcList, GWLP_WNDPROC, (LONG_PTR)HookListViewProc);
		    ListViewAddCol(hProcList, "Name", 0, 0x100);
		    ListViewAddCol(hProcList, "Size", 1, 0x60);
		    ListViewAddCol(hProcList, "Handle", 2, 60);
		    ListViewAddCol(hProcList, "Full Path", 3, 200);
            SendMessage(hProcList,LVM_SETEXTENDEDLISTVIEWSTYLE,0,LVS_EX_FULLROWSELECT|LVS_EX_GRIDLINES);
            ListProcesses(hProcList);
            //inputs
            SendMessage(hProgramPath, EM_SETLIMITTEXT, MAX_PATH, 0);
            SendMessage(hRamStart, EM_SETLIMITTEXT, 8, 0);
            SendMessage(hMaxRamSize, EM_SETLIMITTEXT, 8, 0);
            SendMessage(hEntryOffset, EM_SETLIMITTEXT, 8, 0);
            SendMessage(hRamStart, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
            SendMessage(hMaxRamSize, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
            SendMessage(hEntryOffset, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
            SetWindowText(hEntryOffset, "0");
		    wpHexEditBoxes = (WNDPROC)GetWindowLongPtr (hRamStart, GWLP_WNDPROC);
		    SetWindowLongPtr (hRamStart, GWLP_WNDPROC, (LONG_PTR)HexEditBoxProc);
		    SetWindowLongPtr (hMaxRamSize, GWLP_WNDPROC, (LONG_PTR)HexEditBoxProc);
		    SetWindowLongPtr (hEntryOffset, GWLP_WNDPROC, (LONG_PTR)HexEditBoxProc);
            SendMessage(hRamStartType,CB_RESETCONTENT,0,0);
            ComboAddItem(hRamStartType, "Static" , RAM_STATIC);
            ComboAddItem(hRamStartType, "Pointer" , RAM_POINTER);
            ComboAddItem(hEndian, "Little Endian (System)" , LITTLE_ENDIAN_SYS);
            ComboAddItem(hEndian, "Little Endian (Big Endian System)" , LITTLE_ENDIAN_BIG_SYS);
            ComboAddItem(hEndian, "Big Endian" , BIG_ENDIAN);
            SendMessage(hEndian,CB_SETCURSEL,LITTLE_ENDIAN_SYS,0);
            SendMessage(hAutoFind,CB_RESETCONTENT,0,0);
            ComboAddItem(hAutoFind, "Off" , 0);
            ComboAddItem(hAutoFind, "100ms" , 100);
            ComboAddItem(hAutoFind, "500ms" , 500);
            ComboAddItem(hAutoFind, "1 Second" , 1000);
            ComboAddItem(hAutoFind, "10 Seconds" , 10000);
            ComboAddItem(hAutoFind, "30 Seconds" , 30000);
            ComboAddItem(hAutoFind, "1 Minute" , 60000);
//            SendMessage(hAutoFind,CB_SETCURSEL,0,0);
            SendMessage(hAccessType,CB_RESETCONTENT,0,0);
            ComboAddItem(hAccessType, "Auto", SEARCH_ACCESS_AUTO);
            ComboAddItem(hAccessType, "Array (faster, more RAM usage)", SEARCH_ACCESS_ARRAY);
            ComboAddItem(hAccessType, "File (might be slightly slower)", SEARCH_ACCESS_FILE);
            SendMessage(hAccessType,CB_SETCURSEL,0,0);
            SendMessage(hSystem,CB_RESETCONTENT,0,0);
            ComboAddItem(hSystem, "PC", SYSTEM_PC);
            ComboAddItem(hSystem, "Nintendo 64", SYSTEM_N64);
            ComboAddItem(hSystem, "Playstation", SYSTEM_PS1);
            ComboAddItem(hSystem, "Playstation 2", SYSTEM_PS2);
            ComboAddItem(hSystem, "Gameboy Advance (WRAM)", SYSTEM_GBA_WRAM);
            ComboAddItem(hSystem, "Gameboy Advance (IRAM)", SYSTEM_GBA_IRAM);
            ComboAddItem(hSystem, "Gameboy DS", SYSTEM_NDS);
//            ComboAddItem(hSystem, "Gameboy DS", SYSTEM_NDS);
            //setup presets
            ListPresets(hPresetCombo, 0);
            SendMessage(hPresetCombo,CB_SETCURSEL,0,0);
            SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_HOOK_PRESETS, CBN_SELCHANGE),(LPARAM)hPresetCombo);
//            strcpy(cmbString, "project64.exe");
//            if (SearchProcList(hProcList, cmbString)) { MessageBox(NULL,cmbString,"Debug",0); }
		} break;
		case WM_COMMAND:
		{
			switch(LOWORD(wParam))
            {
				case CMB_HOOK_PRESETS:
				{
				    switch(HIWORD(wParam))
					{
					    case CBN_SELCHANGE:
					    {
                            KillTimer(hwnd, HookTimer);
					        int pNum = SendMessage(hPresetCombo,CB_GETITEMDATA,SendMessage(hPresetCombo,CB_GETCURSEL,0,0),0);
					        memcpy(&Settings.Hook, &Settings.Presets[pNum], sizeof(HOOK_VARS));
					        SendMessage(hwnd, WM_COMMAND, VCMD_HOOK_SHOW_SETTS, 0);
					        if (HookedProcess.hProcess) { ResetHook(); }
					        if ((HookedProcess.dwProcessId = SearchProcList(hProcList,Settings.Hook.FileName))) { InitHook(); }
                            else {
                                int hDelay = SendMessage(hAutoFind,CB_GETITEMDATA,SendMessage(hAutoFind,CB_GETCURSEL,0,0),0);
                                if (hDelay > 0) { SetTimer(hwnd, HookTimer, hDelay, NULL); }
					        }
					    } break;
					}
				} break;
                case OPT_HOOK_PROCESS:
                {
                    EnableWindow (hMaxRamSize, TRUE);
                    EnableWindow (hAllRamChk, TRUE);
                    EnableWindow (hRamStartType, TRUE);
                    EnableWindow (hProgPathButton, TRUE);
                    EnableWindow (hAutoFind, TRUE);
                } break;
                case OPT_HOOK_FILE:
                {
                    EnableWindow (hMaxRamSize, FALSE);
                    EnableWindow (hAllRamChk, FALSE);
                    SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_HOOK_START_TYPE, CBN_SELCHANGE),(LPARAM)hRamStartType);
                    EnableWindow (hRamStartType, FALSE);
                    EnableWindow (hProgPathButton, FALSE);
                    EnableWindow (hAutoFind, FALSE);
                } break;
			    case CMD_HOOK_ADD_PRESET:
                {
                    SendMessage(hwnd, WM_COMMAND, VCMD_HOOK_GET_SETTS, 0);
                    int i;
                    BOOL pAdded = FALSE;
                    for (i = 0; i < NUM_PRESETS; i++) {
                        if (Settings.Presets[i].HookType == 0) {
                            memcpy(&Settings.Presets[i], &Settings.Hook, sizeof(HOOK_VARS));
                            pAdded = TRUE;
                            break;
                        }
                    }
                    if (!pAdded) { MessageBox(hwnd, "Max number of presets reached. Delete some.", "Error", MB_OK); break; }
                    ListPresets(hPresetCombo, i);
                    SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_HOOK_PRESETS, CBN_SELCHANGE),(LPARAM)hPresetCombo);
                } break;
			    case CMD_HOOK_UP_PRESET:
			    {
                    SendMessage(hwnd, WM_COMMAND, VCMD_HOOK_GET_SETTS, 0);
                    int pNum = SendMessage(hPresetCombo,CB_GETITEMDATA,SendMessage(hPresetCombo,CB_GETCURSEL,0,0),0);
                    memcpy(&Settings.Presets[pNum], &Settings.Hook, sizeof(HOOK_VARS));
                    ListPresets(hPresetCombo, pNum);
                    SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_HOOK_PRESETS, CBN_SELCHANGE),(LPARAM)hPresetCombo);
                } break;
			    case CMD_HOOK_DEL_PRESET:
			    {
                    int pNum = SendMessage(hPresetCombo,CB_GETITEMDATA,SendMessage(hPresetCombo,CB_GETCURSEL,0,0),0);
                    memset(&Settings.Presets[pNum], 0, sizeof(HOOK_VARS));
                    ListPresets(hPresetCombo, 0);
                    SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_HOOK_PRESETS, CBN_SELCHANGE),(LPARAM)hPresetCombo);
                } break;
                case CMD_HOOK_EXPORT_PRESET:
                {
                    char ssFileName[MAX_PATH];
                    SendMessage(hwnd, WM_COMMAND, VCMD_HOOK_GET_SETTS, 0);
                    if (!DoFileSave(hwnd, ssFileName)) { break; }
                    SaveStruct(&Settings.Hook, sizeof(HOOK_VARS), ssFileName);
                } break;
                case CMD_HOOK_IMPORT_PRESET:
                {
                    char ssFileName[MAX_PATH];
                    if (!DoFileOpen(hwnd, ssFileName)) { break; }
                    if (LoadStruct(&Settings.Hook, sizeof(HOOK_VARS), ssFileName)) { SendMessage(hwnd, WM_COMMAND, VCMD_HOOK_SHOW_SETTS, 0); }
                } break;
			    case CMD_HOOK_DEFAULT_PRESETS:
			    {
                    int i;
                    for (i= 0; i < NUM_PRESETS; i++ ) {
                        memset(&Settings.Presets[i], 0, sizeof(HOOK_VARS));
                        memcpy(&Settings.Presets[i], &Defaults.Presets[i], sizeof(HOOK_VARS));
                    }
                    ListPresets(hPresetCombo, 0);
                    SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_HOOK_PRESETS, CBN_SELCHANGE),(LPARAM)hPresetCombo);
                } break;
			    case CMD_HOOK_REFRESH_PROCS:
			    {
                    ListProcesses(hProcList);
                } break;
			    case CMD_HOOK_LAUNCH:
			    {
                    char lFileName[MAX_PATH], lFilePath[MAX_PATH];
                    if (!DoFileOpen(hwnd, lFileName)) { break; }
                    if(!FileExists(lFileName)) { break; }
                    if (HookedProcess.hProcess) { ResetHook(); }
                    strcpy(lFilePath, lFileName);
                    char *fndchr = strrchr(lFilePath,'\\');
                    *(fndchr) = '\0';
                    STARTUPINFO si; memset(&si, 0, sizeof(STARTUPINFO));
                    si.cb = sizeof(si);
                    CreateProcess( lFileName, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, lFilePath, &si, &HookedProcess );
                    char txtTitle[100];
                    strcpy(txtTitle,PROGRAM_NAME); strcat(txtTitle," - ");
                    fndchr = strrchr(lFileName,'\\');
                    strcat(txtTitle,fndchr+1);
                    SetWindowText(hwndMain,txtTitle);
                } break;
                case VCMD_HOOK_GET_SETTS:
                {
                    GetWindowText(hPresetName, Settings.Hook.Name, sizeof(Settings.Hook.Name));
                    GetWindowText(hProgramPath, Settings.Hook.ProgramPath, sizeof(Settings.Hook.ProgramPath));
                    GetWindowText(hProcessName, Settings.Hook.FileName, sizeof(Settings.Hook.FileName));
                    Settings.Hook.StartAddress = GetHexWindow(hRamStart);
					Settings.Hook.MaxRamSize = GetHexWindow(hMaxRamSize);
                    Settings.Hook.HookType = (SendMessage(hHookProcess,BM_GETCHECK,0,0) == BST_CHECKED) ? HOOK_PROCESS : HOOK_FILE;
                    Settings.Hook.StartType = SendMessage(hRamStartType,CB_GETCURSEL,0,0);
                    Settings.Hook.AllRam = SendMessage(hAllRamChk,BM_GETCHECK,0,0);
                    Settings.Hook.Endian = SendMessage(hEndian,CB_GETITEMDATA,SendMessage(hEndian,CB_GETCURSEL,0,0),0);
                    Settings.Hook.SearchAccess = SendMessage(hAccessType,CB_GETCURSEL,0,0);
                    Settings.Hook.System = SendMessage(hSystem,CB_GETITEMDATA,SendMessage(hSystem,CB_GETCURSEL,0,0),0);
					Settings.Hook.EntryOffset = GetHexWindow(hEntryOffset);
                } break;
                case VCMD_HOOK_SHOW_SETTS:
                {
                    SetWindowText(hPresetName, Settings.Hook.Name);
                    SetWindowText(hProgramPath, Settings.Hook.ProgramPath);
                    SetWindowText(hProcessName, Settings.Hook.FileName);
                    SetHexWindow(hRamStart, Settings.Hook.StartAddress);
                    SetHexWindow(hMaxRamSize, Settings.Hook.MaxRamSize);
                    SendMessage(hRamStartType,CB_SETCURSEL,Settings.Hook.StartType,0);
                    SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_HOOK_START_TYPE, CBN_SELCHANGE),(LPARAM)hRamStartType);

                    SendMessage(hHookFile,BM_SETCHECK, (Settings.Hook.HookType == HOOK_FILE) ? BST_CHECKED : BST_UNCHECKED,0);
                    SendMessage(hHookProcess,BM_SETCHECK, (Settings.Hook.HookType == HOOK_PROCESS) ? BST_CHECKED : BST_UNCHECKED,0);
                    SendMessage(hwnd, WM_COMMAND, (Settings.Hook.HookType == HOOK_PROCESS) ? OPT_HOOK_PROCESS: OPT_HOOK_FILE, 0);
                    SendMessage(hAllRamChk,BM_SETCHECK,Settings.Hook.AllRam,0);
                    SendMessage(hwnd, WM_COMMAND, CHK_HOOK_ALL_RAM, 0);
                    ComboSelFromData(hEndian, Settings.Hook.Endian);
                    SendMessage(hAccessType,CB_SETCURSEL,Settings.Hook.SearchAccess,0);
                    ComboSelFromData(hSystem, Settings.Hook.System);
                    SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_HOOK_ENDIAN, CBN_SELCHANGE),(LPARAM)hEndian);
                    SendMessage(hAutoFind,CB_SETCURSEL,0,0);
                    EnableWindow (hEntryOffset, (Settings.Hook.System == SYSTEM_NDS) ? TRUE : FALSE);
                    if (HookedProcess.hProcess) { ResetHook(); }
                    ListProcesses(hProcList);
                    if ((HookedProcess.dwProcessId = SearchProcList(hProcList,Settings.Hook.FileName))) { InitHook(); }
                } break;
				case CMB_HOOK_AUTOFIND:
				{
				    switch(HIWORD(wParam))
					{
					    case CBN_SELCHANGE:
					    {
                            KillTimer(hwnd, HookTimer);
					        int hDelay = SendMessage(hAutoFind,CB_GETITEMDATA,SendMessage(hAutoFind,CB_GETCURSEL,0,0),0);
					        if (hDelay > 0) { SetTimer(hwnd, HookTimer, hDelay, NULL); }
					    } break;
					}
				} break;
				case CHK_HOOK_ALL_RAM:
                {
                    if (SendMessage(hAllRamChk,BM_GETCHECK,0,0) == BST_CHECKED) {
                        EnableWindow (hRamStart, FALSE);
                        EnableWindow (hMaxRamSize, FALSE);
                        EnableWindow (hRamStartType, FALSE);
                        ComboSelFromData(hEndian, Settings.Hook.Endian);
                        EnableWindow (hEndian, FALSE);
                    } else {
                        if ((SendMessage(hHookFile,BM_GETCHECK,0,0) == BST_CHECKED)) { break; }
                        EnableWindow (hRamStart, TRUE);
                        EnableWindow (hMaxRamSize, TRUE);
                        EnableWindow (hRamStartType, TRUE);
                        EnableWindow (hEndian, TRUE);
                    }
				} break;
				case CMD_HOOK_RUN_PRESET:
                {
                    char lFileName[MAX_PATH], lFilePath[MAX_PATH];
                    GetWindowText(hProgramPath, lFileName, sizeof(lFileName));
                    if(!FileExists(lFileName)) { MessageBox(NULL, "File Not Found. Try actually setting the Program Path, dipshit.", "Error", MB_OK); break; }
                    if (HookedProcess.hProcess) { ResetHook(); }
                    strcpy(lFilePath, lFileName);
                    char *fndchr = strrchr(lFilePath,'\\');
                    *(fndchr) = '\0';
                    STARTUPINFO si; memset(&si, 0, sizeof(STARTUPINFO));
                    si.cb = sizeof(si);
                    CreateProcess( lFileName, NULL, NULL, NULL, FALSE, CREATE_NEW_CONSOLE, NULL, lFilePath, &si, &HookedProcess );
                    char txtTitle[100];
                    strcpy(txtTitle,PROGRAM_NAME); strcat(txtTitle," - ");
                    fndchr = strrchr(lFileName,'\\');
                    strcat(txtTitle,fndchr+1);
                    SetWindowText(hwndMain,txtTitle);
                } break;
                case CMD_HOOK_PROG_PATH:
                {
                    char lFileName[MAX_PATH], lFilePath[MAX_PATH];
                    if (!DoFileOpen(hwnd, lFileName)) { break; }
                    strcpy(lFilePath, lFileName);
                    char *fndchr = strrchr(lFileName,'\\');
                    strcpy(lFileName, fndchr+1);
                    *(fndchr) = '\0';
                    SetWindowText(hProgramPath, lFilePath);
                    SetWindowText(hProcessName, lFileName);
                } break;
                case CMB_HOOK_SYSTEM:
                {
                    switch(HIWORD(wParam))
                    {
                        case CBN_SELCHANGE:
                        {
                            if (SendMessage(hSystem,CB_GETITEMDATA,SendMessage(hSystem,CB_GETCURSEL,0,0),0) == SYSTEM_NDS) {
                                EnableWindow (hEntryOffset, TRUE);
                            } else { EnableWindow (hEntryOffset, FALSE); }
                        } break;
                    }
                } break;
            }
        } break;
        case WM_TIMER:
        {
            KillTimer(hwnd, HookTimer);
            if (HookedProcess.hProcess) { break; }
            ListProcesses(hProcList);
            if ((HookedProcess.dwProcessId = SearchProcList(hProcList,Settings.Hook.FileName))) { InitHook(); }
            else {
                int hDelay = SendMessage(hAutoFind,CB_GETITEMDATA,SendMessage(hAutoFind,CB_GETCURSEL,0,0),0);
                if (hDelay > 0) { SetTimer(hwnd, HookTimer, hDelay, NULL); }
            }
        } break;
        case WM_SHOWWINDOW:
        {
            if (wParam == FALSE) {
                SendMessage(hwnd, WM_COMMAND, VCMD_HOOK_GET_SETTS, 0);
            }
        } break;
        case WM_CLOSE:
        {
            KillTimer(hwnd, HookTimer);
        } break;
	}
	return FALSE;
}

/*******************************************
List processes 
********************************************/
int ListProcesses(HWND hProcessList) {
    HANDLE hProcess;
    DWORD aProcesses[1024], cbNeeded, cProcesses;
    unsigned int i;
    char szProcessName[MAX_PATH];
    char szProcessPath[MAX_PATH];
    char szProcessID[20];
    char szProcessSize[20];
    char szProcessTitle[1024];
    PROCESS_MEMORY_COUNTERS szProcessMemory;
    SendMessage(hProcessList, LVM_DELETEALLITEMS, 0, 0);
    if ( !EnumProcesses( aProcesses, sizeof(aProcesses), &cbNeeded ) )
        return 1;

    cProcesses = cbNeeded / 4;

    for ( i = 0; i < cProcesses; i++ ) {
        if( aProcesses[i] != 0 ) hProcess = OpenProcess( PROCESS_QUERY_INFORMATION|PROCESS_VM_READ, FALSE, aProcesses[i] );
        if (NULL != hProcess )
        {
            GetModuleBaseName( hProcess, NULL, szProcessName, MAX_PATH );
            GetModuleFileNameEx( hProcess, NULL, szProcessPath, MAX_PATH );
            memset(&szProcessMemory,0,sizeof(PROCESS_MEMORY_COUNTERS));
            szProcessMemory.cb = sizeof(PROCESS_MEMORY_COUNTERS);
            GetProcessMemoryInfo(hProcess, &szProcessMemory, sizeof(PROCESS_MEMORY_COUNTERS));
            sprintf(szProcessSize, "%.2f", (float)szProcessMemory.WorkingSetSize / 1024 / 1024);
            szProcessTitle[0] = '\0';
//            GetWindowText(hProcess, szProcessTitle, sizeof(szProcessTitle));
            sprintf(szProcessID, "%u", aProcesses[i]);
            //GetWindowText doesn't work as intended
//            if (GetWindowFromProcessID((HWND)aProcesses[i], (DWORD)&szProcesHwnd)) {
//                GetWindowText(szProcesHwnd, szProcessTitle, sizeof(szProcessTitle));
//            } else { szProcessTitle[0] = '\0'; }

//            ListViewAddRow(hProcessList, 4, szProcessName, szProcessSize, szProcessID, szProcessTitle);
            ListViewAddRow(hProcessList, 4, szProcessName, szProcessSize, szProcessID, szProcessPath);
        }
        CloseHandle( hProcess );
    }
	return 0;
}

/*******************************************
search process list for filename
********************************************/
int SearchProcList(HWND hProcessList, char* findname)
{
    LV_ITEM lvItem; memset(&lvItem,0,sizeof(lvItem));
    char txtProcName[500];
    DWORD ProcId;
    lvItem.pszText=txtProcName;
    lvItem.cchTextMax=sizeof(txtProcName);
    lvItem.iItem = -1;
    while ((lvItem.iItem = SendMessage(hProcessList, LVM_GETNEXTITEM, lvItem.iItem, LVNI_ALL)) >=0) {
        SendMessage(hProcessList, LVM_GETITEMTEXT, lvItem.iItem, (LPARAM)&lvItem);
        if (!StringCompareCI(lvItem.pszText, findname)) {
            lvItem.iSubItem = 2;
            SendMessage(hProcessList, LVM_GETITEMTEXT, lvItem.iItem, (LPARAM)&lvItem);
            sscanf(lvItem.pszText, "%u", &ProcId);
            return ProcId;
        }
    }
    return 0;
}

/********************************************
Generate presets list from Setings struct
********************************************/
int ListPresets(HWND hPresetCMB, int SetSel)
{
    int i, p = 0;
    SendMessage(hPresetCMB,CB_RESETCONTENT,0,0);
    for (i = 0; i < NUM_PRESETS; i++) {
        if (Settings.Presets[i].HookType > 0) {
            ComboAddItem(hPresetCMB, Settings.Presets[i].Name , i);
            if (i == SetSel) { SendMessage(hPresetCMB,CB_SETCURSEL,p,0); }
            p++;
        }
    }
    return p;
}

/*******************************************
ListView handler
********************************************/
LRESULT CALLBACK HookListViewProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case WM_LBUTTONDOWN:
        {
            CallWindowProc (oldHookListViewProc, hwnd, message, wParam, lParam);
            int iItem = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
            if (iItem < 0) { break; }
            if (HookedProcess.hProcess) { ResetHook(); }
            HookedProcess.dwProcessId = ListViewGetDec(hwnd, iItem, 2);
            InitHook();
        } return 0;
        default:
        {
            if (oldHookListViewProc) { return CallWindowProc (oldHookListViewProc, hwnd, message, wParam, lParam); }
            else { return DefWindowProc (hwnd, message, wParam, lParam); }
        }
    }
	return CallWindowProc (oldHookListViewProc, hwnd, message, wParam, lParam);
}


