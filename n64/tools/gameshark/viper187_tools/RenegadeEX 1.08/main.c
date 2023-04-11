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

HANDLE hinstMain;
HWND hwndMain = NULL;
HWND hTabDlgs[NUM_TABS];
char ErrTxt[1000];
char INIFile[MAX_PATH];
WNDPROC wpHexEditBoxes;
PROCESS_INFORMATION HookedProcess;

BOOL CALLBACK MainProc(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam);
int InitTabControl(HWND hwnd, LPARAM lParam);


#if (EMU_INTEGRATE == 0)
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
	LPSTR lpCmdLine, int nCmdShow)
{
   INITCOMMONCONTROLSEX blah;
   blah.dwSize = sizeof(INITCOMMONCONTROLSEX);
   blah.dwICC = -1;
   InitCommonControlsEx(&blah);
   hinstMain = hInstance;
   hwndMain = CreateDialog(hInstance,MAKEINTRESOURCE(DLG_RENEGADEX),HWND_DESKTOP,MainProc);
   sprintf(ErrTxt, "%u", GetLastError());
   if (!hwndMain) { MessageBox(NULL,ErrTxt, "debug",MB_OK); }

   if (!hwndMain) return FALSE;
   ShowWindow(hwndMain, nCmdShow);
   UpdateWindow(hwndMain);
   MSG msg;
//   HACCEL AccelMain = LoadAccelerators(hinstMain, "MainAccel");
   while(GetMessage(&msg, NULL, 0, 0))
   {
       //msg.hwnd could determine which procedure to translate accelerator for.
//       if (!TranslateAccelerator(hwndMain, AccelMain, &msg)) {
           TranslateMessage(&msg);
           DispatchMessage(&msg);
//       }
    }
   return (int)msg.wParam;
}
#endif

BOOL CALLBACK MainProc(HWND hwnd, UINT Message, WPARAM wParam, LPARAM lParam)
{
    //use a procedure for each tab
//    HWND hTabCtrl = GetDlgItem(hwnd, TAB_MAIN);
//    HWND hResultsList = GetDlgItem(hwnd, LSV_RESULTS);
//    HWND hSearchButton = GetDlgItem(hwnd, CMD_SEARCH);
//    HWND hStatus = GetDlgItem(hwnd, STATUS_BAR);
//    HMENU hMenu = GetMenu(hwnd);
//    char txtInput[256];

	switch(Message)
	{
		case WM_INITDIALOG:
        {
            memset(&HookedProcess, 0, sizeof(PROCESS_INFORMATION));
            LoadSettings();
		    InitTabControl(hwnd, lParam);
            #if (EMU_INTEGRATE > 0)
                Settings.Hook.SearchAccess = SEARCH_ACCESS_ARRAY;
                Settings.Hook.System = SYSTEM_N64;
                Settings.Hook.HookType = HOOK_PROCESS;
                Settings.Hook.MaxRamSize = 0x800000;
                Settings.Hook.StartAddress = 0;
                Settings.Hook.StartType = RAM_STATIC;
                Settings.Hook.Endian = LITTLE_ENDIAN_BIG_SYS;
                SendMessage(hTabDlgs[HOOK_TAB], WM_COMMAND, VCMD_HOOK_SHOW_SETTS, 0);
            #endif
		} break;
        case WM_NOTIFY:
        {
            NMHDR *hdr = (LPNMHDR)lParam;
            if (hdr->code == TCN_SELCHANGING || hdr->code == TCN_SELCHANGE)
            {
                int index = TabCtrl_GetCurSel(hdr->hwndFrom);
                #if (EMU_INTEGRATE == 0)
                if (index >= 0 && index < NUM_TABS) ShowWindow(hTabDlgs[index], (hdr->code == TCN_SELCHANGE) ? SW_SHOW : SW_HIDE);
                #else
                if (index >= 1 && index < NUM_TABS) ShowWindow(hTabDlgs[index], (hdr->code == TCN_SELCHANGE) ? SW_SHOW : SW_HIDE);

//                if (index >= 0 && index < NUM_TABS) ShowWindow(hTabDlgs[index+1], (hdr->code == TCN_SELCHANGE) ? SW_SHOW : SW_HIDE);
                #endif
            }
        } break;
        case WM_COMMAND:
        {
			switch(LOWORD(wParam))
            {
                /*
                case VKEY_CMD_F5:
                {
                    int tIndex = SendMessage(hTabCtrl, TCM_GETCURSEL, 0, 0);
                    sprintf(ErrTxt, "%u", tIndex);
                    MessageBox(NULL,ErrTxt,"Debug",0);
                } break;
                */
            }
        } break;
		case WM_CLOSE:
		{
		    #if (EMU_INTEGRATE > 0)
		    ShowWindow(hwndMain, SW_HIDE); return TRUE;
		    #endif
		    FreeShit();
            if (HookedProcess.hProcess) {
                CloseHandle(HookedProcess.hProcess);
                CloseHandle(HookedProcess.hThread);
            }
            SendMessage(hTabDlgs[CHEAT_TAB], WM_COMMAND, MNU_CHEAT_NEW_DB, 0);
            SaveSettings();
            DestroyWindow(hwnd);
		} break;
		case WM_DESTROY:
		{
			PostQuitMessage(0);
        } return 0;
		default:
			return FALSE;
//		    return DefWindowProc(hwnd, Message, wParam, lParam);
	}
	return FALSE;
//    return DefWindowProc(hwnd, Message, wParam, lParam);
    //return 0 and default to DefWindowProc?
}

/***************************************************
Tab control
****************************************************/
int InitTabControl(HWND hwnd, LPARAM lParam)
{
    TCITEM tabitem;
    HWND hTab;

    hTab = GetDlgItem(hwnd, TAB_MAIN);
    memset(&tabitem, 0, sizeof(tabitem));

    tabitem.mask = TCIF_TEXT;
	tabitem.cchTextMax = MAX_PATH;

//	#if (EMU_INTEGRATE == 0)
    tabitem.pszText = "Hook";
    SendMessage(hTab, TCM_INSERTITEM, HOOK_TAB, (LPARAM)&tabitem);
//    #endif

    tabitem.pszText = "Search";
    SendMessage(hTab, TCM_INSERTITEM, CODE_SEARCH_TAB, (LPARAM)&tabitem);

    tabitem.pszText = "Results";
    SendMessage(hTab, TCM_INSERTITEM, SEARCH_RESULTS_TAB, (LPARAM)&tabitem);

    tabitem.pszText = "Memory Editor";
    SendMessage(hTab, TCM_INSERTITEM, MEMORY_EDITOR_TAB, (LPARAM)&tabitem);

    tabitem.pszText = "Cheat";
    SendMessage(hTab, TCM_INSERTITEM, CHEAT_TAB, (LPARAM)&tabitem);

	// Get the position that the dialogs should be displayed
	RECT rt,itemrt;
//	GetWindowRect(GetDlgItem(hwnd, LBL_TAB), &rt);
	GetWindowRect(hTab, &rt);
    TabCtrl_GetItemRect(hTab,1,&itemrt);
    rt.top -= (itemrt.top - itemrt.bottom);
    rt.bottom -= rt.top;
    rt.right  -= rt.left;
	ScreenToClient(hTab, (LPPOINT)&rt);

	// Create the dialogs modelessly and move them appropriately
//	#if (EMU_INTEGRATE == 0)
    hTabDlgs[HOOK_TAB] = CreateDialog((HINSTANCE)lParam, (LPSTR)DLG_HOOK, hTab, (DLGPROC)HookProc);
//    #endif
    hTabDlgs[CODE_SEARCH_TAB] = CreateDialog((HINSTANCE)lParam, (LPSTR)DLG_CODE_SEARCH, hTab, (DLGPROC)CodeSearchProc);
    hTabDlgs[SEARCH_RESULTS_TAB] = CreateDialog((HINSTANCE)lParam, (LPSTR)DLG_SEARCH_RESULTS, hTab, (DLGPROC)SearchResultsProc);
    hTabDlgs[MEMORY_EDITOR_TAB] = CreateDialog((HINSTANCE)lParam, (LPSTR)DLG_MEMORY_EDITOR, hTab, (DLGPROC)MemoryEditorProc);
    hTabDlgs[CHEAT_TAB] = CreateDialog((HINSTANCE)lParam, (LPSTR)DLG_CHEAT, hTab, (DLGPROC)CheatProc);

//    #if (EMU_INTEGRATE == 0)
    MoveWindow(hTabDlgs[HOOK_TAB], rt.left, rt.top, rt.right, rt.bottom, 0);
//    #endif
    MoveWindow(hTabDlgs[CODE_SEARCH_TAB], rt.left, rt.top, rt.right, rt.bottom, 0);
    MoveWindow(hTabDlgs[SEARCH_RESULTS_TAB], rt.left, rt.top, rt.right, rt.bottom, 0);
    MoveWindow(hTabDlgs[MEMORY_EDITOR_TAB], rt.left, rt.top, rt.right, rt.bottom, 0);
    MoveWindow(hTabDlgs[CHEAT_TAB], rt.left, rt.top, rt.right, rt.bottom, 0);

    // Show the default dialog
#if (EMU_INTEGRATE == 0)
    SendMessage(hTab, TCM_SETCURFOCUS, HOOK_TAB, 0);
    ShowWindow(hTabDlgs[HOOK_TAB], SW_SHOW);
#else
//    ShowWindow(hTabDlgs[CODE_SEARCH_TAB], SW_SHOW);
//    SendMessage(hTab, TCM_SETCURSEL, CODE_SEARCH_TAB, 0);
    SendMessage(hTab, TCM_SETCURFOCUS, CODE_SEARCH_TAB, 0);
#endif
    return 0;
}


