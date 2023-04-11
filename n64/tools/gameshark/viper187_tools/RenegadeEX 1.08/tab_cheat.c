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

LRESULT CALLBACK CodeEditBoxProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
LRESULT CALLBACK CodeListProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
LRESULT CALLBACK CodeNameEditProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK CheatButtonDlg(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
WNDPROC oldCodeEditBoxProc;
WNDPROC oldCodeListProc;
WNDPROC oldCodeNameEditProc;

int ParseCode();
int RemoveChar(char *string, int length, char chr);
int ListCodes();
u32 FindEmptyCode();
int ShowCode(u32 CodeNum);
int ApplyCheats();
HMENU hCheatMenu;
const int CheatWriteTimer = 4;
LISTVIEW_ITEM_EDIT_INFO lvCodeNameEdit;

BOOL CALLBACK CheatProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    HWND hCodeList = GetDlgItem(hwnd, LSV_CHEAT_CODES);
    HWND hSystemType = GetDlgItem(hwnd, CMB_CHEAT_CODE_TYPE);
    HWND hCode = GetDlgItem(hwnd, TXT_CHEAT_CODE);
    HWND hNote = GetDlgItem(hwnd, TXT_CHEAT_NOTE);
    HWND hCheatHeader = GetDlgItem(hwnd, HDR_CHEAT_MENU);
    HWND hGameName = GetDlgItem(hwnd, TXT_CHEAT_GAME_NAME);
    HWND hCodeName = GetDlgItem(hwnd, TXT_CHEAT_CODE_NAME);
	switch(message)
	{
		case WM_INITDIALOG:
        {
            SendMessage(hCodeList,LVM_SETEXTENDEDLISTVIEWSTYLE,0,LVS_EX_FULLROWSELECT|LVS_EX_GRIDLINES|LVS_EX_LABELTIP|LVS_EX_CHECKBOXES);
            SendMessage(hCodeList,LVM_DELETEALLITEMS,0,0);
            ListViewAddCol(hCodeList, "Codes", 0, 0x50);
            SendMessage(hCodeList, LVM_SETCOLUMNWIDTH, 0, LVSCW_AUTOSIZE_USEHEADER);
            ListViewAddCol(hCodeList, "", 1, 0);
		    oldCodeListProc = (WNDPROC)GetWindowLongPtr (hCodeList, GWLP_WNDPROC);
		    SetWindowLongPtr (hCodeList, GWLP_WNDPROC, (LONG_PTR)CodeListProcedure);
            //textboxes
            SendMessage(hNote, EM_SETLIMITTEXT, CODE_MAX_NOTE_LEN, 0);
            SendMessage(hCode, EM_SETLIMITTEXT, CODE_MAX_LINES*21, 0);
            SendMessage(hGameName, EM_SETLIMITTEXT, CODE_MAX_GAME_NAME, 0);
            SendMessage(hCodeName, EM_SETLIMITTEXT, CODE_MAX_CHEAT_NAME, 0);
		    SetWindowPos(hCodeName,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
		    oldCodeEditBoxProc = (WNDPROC)GetWindowLongPtr (hCode, GWLP_WNDPROC);
		    SetWindowLongPtr (hCode, GWLP_WNDPROC, (LONG_PTR)CodeEditBoxProcedure);
		    oldCodeNameEditProc = (WNDPROC)GetWindowLongPtr (hCodeName, GWLP_WNDPROC);
		    SetWindowLongPtr (hCodeName, GWLP_WNDPROC, (LONG_PTR)CodeNameEditProcedure);
		    //Menu Setup
            AddHeaderItem(hCheatHeader, 0x50, "File");
            AddHeaderItem(hCheatHeader, 0x50, "Options");
            AddHeaderItem(hCheatHeader, 0x110, "Cheat Device Button (0xBB)");
		    if ((hCheatMenu = LoadMenu(hinstMain, MAKEINTRESOURCE(CHEAT_MENU))) == NULL) { MessageBox(NULL, "Failed to load menu", "Error", MB_OK); }
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_OFF, 0);
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_5MS, 5);
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_10MS, 10);
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_100MS, 100);
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_500MS, 500);
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_1S, 1000);
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_5S, 5000);
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_10S, 10000);
		    SetMenuItemData(hCheatMenu, MNU_CHEAT_WRITE_30S, 30000);
		    SetMenuState(hCheatMenu, Settings.Cheat.WriteRateId, MFS_CHECKED);
		    if (Settings.Cheat.WriteRate) { SetTimer(hwnd, CheatWriteTimer, Settings.Cheat.WriteRate, NULL); }
            ComboAddItem(hSystemType, "PC", CHEAT_PC);
            ComboAddItem(hSystemType, "Nintendo 64", CHEAT_N64);
            ComboAddItem(hSystemType, "Playstation", CHEAT_PS1);
            ComboAddItem(hSystemType, "Playstation 2", CHEAT_PS2);
            ComboAddItem(hSystemType, "Gameboy Advance WRAM (0200)", CHEAT_GBA_WRAM);
            ComboAddItem(hSystemType, "Gameboy Advance IRAM (0300)", CHEAT_GBA_IRAM);
            ComboAddItem(hSystemType, "Gameboy DS", CHEAT_NDS);
            if (FileExists(Settings.Cheat.dbFileName)) { SendMessage(hwnd, WM_COMMAND, MNU_CHEAT_OPEN_DB, 1); }
		    else { SendMessage(hwnd, WM_COMMAND, MNU_CHEAT_NEW_DB, 0); }
        } break;
        case WM_COMMAND:
        {
			switch(LOWORD(wParam))
            {
                case MNU_CHEAT_WRITE_OFF: case MNU_CHEAT_WRITE_5MS: case MNU_CHEAT_WRITE_10MS: case MNU_CHEAT_WRITE_100MS: case MNU_CHEAT_WRITE_500MS:
                case MNU_CHEAT_WRITE_1S: case MNU_CHEAT_WRITE_5S: case MNU_CHEAT_WRITE_10S: case MNU_CHEAT_WRITE_30S:
                {
                    Settings.Cheat.WriteRate = GetMenuItemData(hCheatMenu, LOWORD(wParam));
                    Settings.Cheat.WriteRateId = LOWORD(wParam);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_OFF, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_5MS, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_10MS, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_100MS, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_500MS, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_1S, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_5S, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_10S, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, MNU_CHEAT_WRITE_30S, MFS_UNCHECKED);
                    SetMenuState(hCheatMenu, LOWORD(wParam), MFS_CHECKED);
                    KillTimer(hwnd, CheatWriteTimer);
                    if (Settings.Cheat.WriteRate) { SetTimer(hwnd, CheatWriteTimer, Settings.Cheat.WriteRate, NULL); }
                } break;
                case MNU_CHEAT_NEW_DB:
                {
                    if (Settings.Cheat.dbModified) {
			            if (MessageBox(hwnd, "Save Current DB first?", "Warning", MB_YESNO|MB_ICONQUESTION) == IDYES) {
			                if (!FileExists(Settings.Cheat.dbFileName)) { SendMessage(hwnd, WM_COMMAND, MNU_CHEAT_SAVE_DB_AS, 0); }
			                else { SendMessage(hwnd, WM_COMMAND, MNU_CHEAT_SAVE_DB, 0); }
			            }
                    }
                    SendMessage(hCodeList,LVM_DELETEALLITEMS,0,0);
                    char txtCodeNum[9];
                    sprintf(txtCodeNum, "%x", CODE_MAX_PER_GAME);
                    ListViewAddRow(hCodeList, 2, "New Code", txtCodeNum);
                    SendMessage(hCodeList, LVM_SETSELECTIONMARK, 0, 0);
                    ListView_SetItemState(hCodeList, 0, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                    memset(&CheatDB, 0, sizeof(CheatDB));
                    SetWindowText(hCode, "");
                    SetWindowText(hNote, "");
                    EnableWindow(hCode, FALSE);
                    EnableWindow(hNote, FALSE);
                    SendMessage(hSystemType, CB_SETCURSEL, 0, 0);
                    SetWindowText(hGameName, "");
                    Settings.Cheat.dbFileName[0] = '\0';
                    Settings.Cheat.dbModified = 0;
                } break;
                case MNU_CHEAT_OPEN_DB:
                {
                    char dbFileName[MAX_PATH];
                    if (lParam) {
                        if (!FileExists(Settings.Cheat.dbFileName)) { break; }
                        strcpy(dbFileName, Settings.Cheat.dbFileName);
                    } else {
                        if (!DoFileOpen(hwnd, dbFileName)) { break; }
                    }
                    if (!LoadStruct(&CheatDB, sizeof(CheatDB), dbFileName)) { break; }
                    strcpy(Settings.Cheat.dbFileName, dbFileName);
                    SendMessage(hCodeList,LVM_DELETEALLITEMS,0,0);
                    char txtCodeNum[9];
                    sprintf(txtCodeNum, "%x", CODE_MAX_PER_GAME);
                    ListViewAddRow(hCodeList, 2, "New Code", txtCodeNum);
                    SendMessage(hCodeList, LVM_SETSELECTIONMARK, 0, 0);
                    ListView_SetItemState(hCodeList, 0, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                    SetWindowText(hGameName, CheatDB.Name);
                    SetWindowText(hCode, "");
                    SetWindowText(hNote, "");
                    EnableWindow(hCode, FALSE);
                    EnableWindow(hNote, FALSE);
                    ComboSelFromData(hSystemType, CheatDB.System);
                    Settings.Cheat.dbModified = 0;
                    int i, iCount = 1;
                    for (i = 0; i < CODE_MAX_PER_GAME; i++)
                    {
                        sprintf(txtCodeNum, "%x", i);
                        if (CheatDB.Codes[i].LineCount) {
                            ListViewAddRow(hCodeList, 2, CheatDB.Codes[i].Name, txtCodeNum);
                            if (CheatDB.Codes[i].Active) { ListView_SetCheckState(hCodeList, iCount, TRUE); }
                            iCount++;
                        }
                    }
                } break;
                case MNU_CHEAT_SAVE_DB:
                {
                    GetWindowText(hGameName, CheatDB.Name, CODE_MAX_GAME_NAME);
                    if (!FileExists(Settings.Cheat.dbFileName)) { SendMessage(hwnd, WM_COMMAND, MNU_CHEAT_SAVE_DB_AS, 0); }
                    if (!SaveStruct(&CheatDB, sizeof(CheatDB), Settings.Cheat.dbFileName)) { break; }
                    Settings.Cheat.dbModified = 0;
                } break;
                case MNU_CHEAT_SAVE_DB_AS:
                {
                    GetWindowText(hGameName, CheatDB.Name, CODE_MAX_GAME_NAME);
                    char dbFileName[MAX_PATH];
                    if (!DoFileSave(hwnd, dbFileName)) { break; }
                    if (!SaveStruct(&CheatDB, sizeof(CheatDB), dbFileName)) { break; }
                    strcpy(Settings.Cheat.dbFileName, dbFileName);
                    Settings.Cheat.dbModified = 0;
                } break;
                case MNU_CHEAT_ALL_OFF:
                {
                    u32 iCount = SendMessage(hCodeList, LVM_GETITEMCOUNT, 0, 0);
                    int i;
                    for (i = 1; i < iCount; i++) { ListView_SetCheckState(hCodeList, i, FALSE); }
                } break;
                case MNU_CHEAT_ALL_ON:
                {
                    u32 iCount = SendMessage(hCodeList, LVM_GETITEMCOUNT, 0, 0);
                    int i;
                    for (i = 1; i < iCount; i++) { ListView_SetCheckState(hCodeList, i, TRUE); }
                } break;
                case CMB_CHEAT_CODE_TYPE:
                {
                    if (HIWORD(wParam) == CBN_SELCHANGE) {
                        if (SendMessage(hCodeList, LVM_GETITEMCOUNT, 0, 0) > 1) {
                            MessageBox(NULL, "Don't change the system after adding codes, numbnut.", "Warning", MB_OK);
                            ComboSelFromData(hSystemType, CheatDB.System); break;
                        }
                        CheatDB.System = SendMessage(hSystemType,CB_GETITEMDATA,SendMessage(hSystemType,CB_GETCURSEL,0,0),0);
                    }
                } break;

                case CMD_CHEAT_SET_CODE:
                {
/*
                    if (!(IsCodeString(txtCode, strlen(txtCode)))) {
                        //This check could be removed to accommodate encrypted shit
                        MessageBox(NULL, "Bad code input. Hex motherfucker! Do you speak it?", "Error", MB_OK);
                        break;
                    }
*/
//                    int iSelected = SendMessage(hCodeList, LVM_GETSELECTIONMARK, 0, 0);
//                    int CodeNum = -1;
//                    if (iSelected != -1) { CodeNum = ListViewGetHex(hCodeList, iSelected, 1); }
//                    if (ParseCode(txtCode, strlen(txtCode)) == 0) { break; }
                    if (ParseCode() == 0) { break; }
                } break;
                case LSV_CHEAT_CODE_BEGINEDIT:
                {
                    //remember if codes are on/off
//			        if (lvCodeNameEdit.Status) { MessageBox(NULL,"Already editing. WTF? (LSV_CHEAT_CODE_BEGINEDIT)","Error",0); break; }
			        lvCodeNameEdit.iItem = LOWORD(lParam);
			        lvCodeNameEdit.iSubItem = HIWORD(lParam);
			        RECT lvEditRect; memset(&lvEditRect,0,sizeof(RECT));
			        lvEditRect.top = 0;
			        lvEditRect.left = LVIR_LABEL;
			        SendMessage(hCodeList, LVM_GETSUBITEMRECT, lvCodeNameEdit.iItem, (LPARAM)&lvEditRect);
			        char txtCodeName[CODE_MAX_CHEAT_NAME];
			        ListViewGetText(hCodeList, lvCodeNameEdit.iItem, lvCodeNameEdit.iSubItem, txtCodeName, CODE_MAX_CHEAT_NAME);
			        SetWindowText(hCodeName, txtCodeName);
			        WINDOWPLACEMENT lvPlace; memset(&lvPlace,0,sizeof(WINDOWPLACEMENT));
			        lvPlace.length = sizeof(WINDOWPLACEMENT);
			        GetWindowPlacement(hCodeList, &lvPlace);
			        POINT lvPos;
			        lvPos.x = lvPlace.rcNormalPosition.left;
			        lvPos.y = lvPlace.rcNormalPosition.top;
			        SetWindowPos(hCodeName,HWND_TOP,lvPos.x+lvEditRect.left+3,lvPos.y+lvEditRect.top+1,(lvEditRect.right-lvEditRect.left),(lvEditRect.bottom-lvEditRect.top)+1,SWP_SHOWWINDOW);
			        SetFocus(hCodeName);
			        SendMessage(hCodeName, EM_SETSEL, 0, -1);
			        lvCodeNameEdit.Status = 1;
                } break;
                case LSV_CHEAT_CODE_ENDEDIT:
                {
			        if ((!lvCodeNameEdit.Status) || (!lParam)) {
			            SetWindowPos(hCodeName,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
			            lvCodeNameEdit.Status = 0;
			            SetFocus(hCodeList); break;
                    }
                    lvCodeNameEdit.Status = 0;
                    SetWindowPos(hCodeName,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
                    SetFocus(hCodeList);
                    u32 CodeNum = ListViewGetHex(hCodeList, lvCodeNameEdit.iItem, 1);
                    if (CodeNum == CODE_MAX_PER_GAME) {
                        CodeNum = FindEmptyCode();
                        if (CodeNum == CODE_MAX_PER_GAME) { break; }
                    }
			        char txtCodeNum[9]; sprintf(txtCodeNum, "%x", CodeNum);
			        GetWindowText(hCodeName, CheatDB.Codes[CodeNum].Name, CODE_MAX_CHEAT_NAME);
			        if (lvCodeNameEdit.iItem) {
                        ListViewSetRow(hCodeList, lvCodeNameEdit.iItem, lvCodeNameEdit.iSubItem, 1, CheatDB.Codes[CodeNum].Name);
                    } else {
                        ListViewAddRow(hCodeList, 2, CheatDB.Codes[CodeNum].Name, txtCodeNum);
                        SendMessage(hCodeList, LVM_SETSELECTIONMARK, 0, SendMessage(hCodeList, LVM_GETITEMCOUNT, 0, 0)-1);
                        ListView_SetItemState(hCodeList, SendMessage(hCodeList, LVM_GETITEMCOUNT, 0, 0)-1, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                    }
                    Settings.Cheat.dbModified = 1;
                } break;
            }
        } break;
        case WM_NOTIFY:
        {
            switch(LOWORD(wParam))
			{
			    case HDR_CHEAT_MENU:
			    {
                    NMHEADER *hdInfo = (LPNMHEADER)lParam;
                    if (hdInfo->hdr.code == HDN_ITEMCLICK) {
                        HMENU hSubMenu;
                        POINT pt;
                        RECT hdRect;
                        SendMessage(hCheatHeader, HDM_GETITEMRECT, hdInfo->iItem, (LPARAM)&hdRect);
                        pt.x = hdRect.left;
                        pt.y = hdRect.bottom;
                        ClientToScreen (hwnd, &pt);
                        if (hdInfo->iItem == 2) {
                            Settings.Cheat.DevButton = DialogBox(hinstMain, MAKEINTRESOURCE(DLG_CHEAT_BUTTON), hwnd, CheatButtonDlg);
                            char txtButton[50];
                            sprintf(txtButton, "Cheat Device Button (0x%X)", Settings.Cheat.DevButton);
                            SetHeaderItemText(hCheatHeader, hdInfo->iItem, txtButton);
                        } else {
                        hSubMenu = GetSubMenu(hCheatMenu, hdInfo->iItem);
                        TrackPopupMenu(hSubMenu, TPM_LEFTALIGN | TPM_LEFTBUTTON, pt.x, pt.y+2, 0, hwnd, NULL);
                        }
                    }
                } break;
            }
        } break;
        case WM_TIMER:
        {
            KillTimer(hwnd, CheatWriteTimer);
            ApplyCheats();
            if (Settings.Cheat.WriteRate) { SetTimer(hwnd, CheatWriteTimer, Settings.Cheat.WriteRate, NULL); }
        } break;
    }
	return FALSE;
}

/**************************************************************
Code Edit Procedure
**************************************************************/
LRESULT CALLBACK CodeEditBoxProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case WM_CHAR:
        {
            if ((wParam == VK_BACK) || (wParam == 24) || (wParam == 3) || (wParam == 22) || (wParam == VK_RETURN) || (wParam == VK_SPACE)) { break; } //cut/copy/paste/backspace
            if (wParam == 1) { SendMessage(hwnd, EM_SETSEL, 0, -1); } //select all
            wParam = FilterHexChar(wParam);
        } break;
    }
    if (oldCodeEditBoxProc) { return CallWindowProc (oldCodeEditBoxProc, hwnd, message, wParam, lParam); }
    else { return DefWindowProc (hwnd, message, wParam, lParam); }
}


/**************************************************************
Code List Procedure
**************************************************************/
LRESULT CALLBACK CodeListProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case LVM_SETSELECTIONMARK:
        {
            if (lParam < 0) { break; }
            int CodeNum = ListViewGetHex(hwnd, lParam, 1);
            ShowCode(CodeNum);
        } break;
        case WM_LBUTTONDOWN:
        {
            int iCode = ListViewHitTst(hwnd, GetMessagePos(), -1);
            if (iCode < 0) { break; }
            int CodeNum = ListViewGetHex(hwnd, iCode, 1);
            ShowCode(CodeNum);
        } break;
        case WM_LBUTTONUP:
        {
            int iCode = ListViewHitTst(hwnd, GetMessagePos(), -1);
            if (iCode < 0) { break; }
            int CodeNum = ListViewGetHex(hwnd, iCode, 1);
            if (CodeNum == CODE_MAX_PER_GAME) { break; }
            CheatDB.Codes[CodeNum].Active = ListView_GetCheckState(hwnd, iCode) ? TRUE : FALSE;
            KillTimer(hwnd, CheatWriteTimer);
            if (Settings.Cheat.WriteRate) { SetTimer(hwnd, CheatWriteTimer, Settings.Cheat.WriteRate, NULL); }
        } break;
        case WM_LBUTTONDBLCLK:
        {
            if (lvCodeNameEdit.Status) { SendMessage(hTabDlgs[CHEAT_TAB], WM_COMMAND, LSV_CHEAT_CODE_ENDEDIT, 0); }
            int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
            if (iSelected < 0) { break; }
            SendMessage(hTabDlgs[CHEAT_TAB], WM_COMMAND, LSV_CHEAT_CODE_BEGINEDIT, MAKELPARAM(iSelected, 0));
        } break;
        case WM_NOTIFY:
        {
                if (((NMHDR*)lParam)->code == HDN_BEGINTRACKW) { return TRUE; }
                if (((NMHDR*)lParam)->code == HDN_BEGINTRACKA) { return TRUE; }
        } break;
        case WM_KEYUP:
        {
            if (wParam == VK_DELETE) {
                int iCode = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
                if (iCode <= 0) { break; }
                u32 CodeNum = ListViewGetHex(hwnd, iCode, 1);
                memset(&CheatDB.Codes[CodeNum], 0, sizeof(CHEAT_CODE));
                SendMessage(hwnd, LVM_DELETEITEM, iCode, 0);
                SetWindowText(GetDlgItem(hTabDlgs[CHEAT_TAB], TXT_CHEAT_CODE), "");
                SetWindowText(GetDlgItem(hTabDlgs[CHEAT_TAB], TXT_CHEAT_NOTE), "");
                EnableWindow(GetDlgItem(hTabDlgs[CHEAT_TAB], TXT_CHEAT_CODE), FALSE);
                EnableWindow(GetDlgItem(hTabDlgs[CHEAT_TAB], TXT_CHEAT_NOTE), FALSE);
            }
        } break;
    }
    if (oldCodeListProc) { return CallWindowProc (oldCodeListProc, hwnd, message, wParam, lParam); }
    else { return DefWindowProc (hwnd, message, wParam, lParam); }
}

/**************************************************************
Code Name Edit Procedure
**************************************************************/
LRESULT CALLBACK CodeNameEditProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case WM_CHAR:
        {
            if ((wParam == VK_BACK) || (wParam == 24) || (wParam == 3) || (wParam == 22) || (wParam == VK_RETURN) || (wParam == VK_SPACE)) { break; } //cut/copy/paste/backspace
            if (wParam == 1) { SendMessage(hwnd, EM_SETSEL, 0, -1); } //select all
        } break;
        case WM_KILLFOCUS:
        {
            SendMessage(hTabDlgs[CHEAT_TAB], WM_COMMAND, LSV_CHEAT_CODE_ENDEDIT, 0);
        } return 0;
        case WM_KEYDOWN:
        {
            if (wParam == VK_RETURN) { SendMessage(hTabDlgs[CHEAT_TAB], WM_COMMAND, LSV_CHEAT_CODE_ENDEDIT, 1); }
            if (wParam == VK_ESCAPE) { SendMessage(hTabDlgs[CHEAT_TAB], WM_COMMAND, LSV_CHEAT_CODE_ENDEDIT, 0); }
        } break;
    }
    if (oldCodeNameEditProc) { return CallWindowProc (oldCodeNameEditProc, hwnd, message, wParam, lParam); }
    else { return DefWindowProc (hwnd, message, wParam, lParam); }
}

BOOL CALLBACK CheatButtonDlg(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch(message)
    {
        case WM_KEYUP:
        {
            EndDialog(hwnd, wParam);
        } break;
		case WM_CLOSE:
        {
//			EndDialog(hwnd, 0);
        } break;
        default:
            return FALSE;
   }
   return TRUE;
}
/**************************************************************
Parse Code
**************************************************************/
int ParseCode()
{
    u32 address[CODE_MAX_LINES], value[CODE_MAX_LINES];
    u8 type[CODE_MAX_LINES];
    int i = 0, c = 0;
    char *codeline, codepart[20];
    HWND hCode = GetDlgItem(hTabDlgs[CHEAT_TAB], TXT_CHEAT_CODE);
    char txtCode[CODE_MAX_LINES*21];
    GetWindowText(hCode, txtCode, sizeof(txtCode));
    int length = strlen(txtCode);
    length = RemoveChar(txtCode, length, ' ');
    length = RemoveChar(txtCode, length, '\r');
    codeline = strtok(txtCode, "\n");
    while (codeline != NULL)
    {
        if (c == CODE_MAX_LINES) {
            sprintf(ErrTxt, "Max is %u lines per code. (ParseCode)", CODE_MAX_LINES);
            MessageBox(NULL, ErrTxt, "Error", MB_OK); return 0;
        }
        switch(CheatDB.System)
        {
            case CHEAT_PC:
            {
                if ((strlen(codeline) != 16) && (strlen(codeline) != 17)) { MessageBox(NULL, "PC codes are 16-17 digits long, you dumb son of a bitch. (ParseCode)", "Error", MB_OK); return 0; }
                if (!isHex(codeline)) { MessageBox(NULL, "Bad code input. Hex motherfucker! Do you speak it? (ParseCode)", "Error", MB_OK); return 0; }
                strncpy(codepart,codeline, 1); codepart[1] = '\0';
                String2Hex(codepart, &type[c]);
                strncpy(codepart,&codeline[1], (strlen(codeline)-9)); codepart[strlen(codeline)-9] = '\0';
                String2Hex(codepart, &address[c]);
                strcpy(codepart,&codeline[strlen(codeline)-8]); codepart[8] = '\0';
                String2Hex(codepart, &value[c]);
                c++;
            } break;
            case CHEAT_PS2: case CHEAT_GBA_WRAM: case CHEAT_GBA_IRAM: case CHEAT_NDS:
            {
                if (strlen(codeline) != 16) { MessageBox(NULL, "PS2/GBA codes are 16 digits long, you dumb son of a bitch. (ParseCode)", "Error", MB_OK); return 0; }
                if (!isHex(codeline)) { MessageBox(NULL, "Bad code input. Hex motherfucker! Do you speak it? (ParseCode)", "Error", MB_OK); return 0; }
                strncpy(codepart,codeline, 1); codepart[1] = '\0';
                String2Hex(codepart, &type[c]);
                strncpy(codepart,&codeline[1], 7); codepart[7] = '\0';
                String2Hex(codepart, &address[c]);
                strcpy(codepart,&codeline[8]); codepart[8] = '\0';
                String2Hex(codepart, &value[c]);
                c++;
            } break;
            case CHEAT_N64: case CHEAT_PS1:
            {
                if ((strlen(codeline) != 12) && (strlen(codeline) != 16)) { MessageBox(NULL, "N64 and PS1 codes are 12 or 16 digits long, you dumb son of a bitch. (ParseCode)", "Error", MB_OK); return 0; }
                if (!isHex(codeline)) { MessageBox(NULL, "Bad code input. Hex motherfucker! Do you speak it? (ParseCode)", "Error", MB_OK); return 0; }
                strncpy(codepart,codeline, 2); codepart[2] = '\0';
                String2Hex(codepart, &type[c]);
                strncpy(codepart,&codeline[2], 6); codepart[6] = '\0';
                String2Hex(codepart, &address[c]);
                strcpy(codepart,&codeline[8]); codepart[strlen(codeline) - 8] = '\0';
                String2Hex(codepart, &value[c]);
                c++;
            } break;
        }
        codeline = strtok(NULL, "\n");
    }
    if (c == 0) { MessageBox(NULL, "No codes found. Enter codes to match the system type. (ParseCode)", "Error", MB_OK); return 0; }
    HWND hCodeList = GetDlgItem(hTabDlgs[CHEAT_TAB], LSV_CHEAT_CODES);
    HWND hNote = GetDlgItem(hTabDlgs[CHEAT_TAB], TXT_CHEAT_NOTE);
    int iCode = SendMessage(hCodeList, LVM_GETSELECTIONMARK, 0, 0);
    if (iCode <= 0) { MessageBox(NULL, "Select a code entry from the fucking list. (ParseCode)", "Error", MB_OK); return 0; }
    u32 CodeNum = ListViewGetHex(hCodeList, iCode, 1);
    CheatDB.Codes[CodeNum].LineCount = c;
    memset(CheatDB.Codes[CodeNum].Type, 0, CODE_MAX_LINES);
    memset(CheatDB.Codes[CodeNum].Address, 0, CODE_MAX_LINES);
    memset(CheatDB.Codes[CodeNum].Value, 0, CODE_MAX_LINES);
    memcpy(CheatDB.Codes[CodeNum].Type, type, CODE_MAX_LINES);
    memcpy(CheatDB.Codes[CodeNum].Address, address, CODE_MAX_LINES);
    memcpy(CheatDB.Codes[CodeNum].Value, value, CODE_MAX_LINES);
    GetWindowText(hNote, CheatDB.Codes[CodeNum].Note, CODE_MAX_NOTE_LEN);
    Settings.Cheat.dbModified = 1;
    return 1;
}

/**************************************************************
RemoveChar
**************************************************************/
int RemoveChar(char *string, int length, char chr)
{
    int i, x = 0;
    char newstring[length];
    for (i = 0; i < length; i++)
    {
        if (string[i] != chr) { newstring[x] = string[i]; x++; }
    }
    newstring[x] = '\0';
    strcpy(string, newstring);
    return x;
}

/**************************************************************
FindEmptyCode - Finds the first empty code entry in the list for GameNum
**************************************************************/
u32 FindEmptyCode()
{
    int i;
    for (i = 0; i < CODE_MAX_PER_GAME; i++)
    {
        if (!CheatDB.Codes[i].LineCount) { return i; }
    }
    return CODE_MAX_PER_GAME;
}

/**************************************************************
ShowCode - Show code/note
**************************************************************/
int ShowCode(u32 CodeNum)
{
    HWND hCode = GetDlgItem(hTabDlgs[CHEAT_TAB], TXT_CHEAT_CODE);
    HWND hNote = GetDlgItem(hTabDlgs[CHEAT_TAB], TXT_CHEAT_NOTE);
    SetWindowText(hCode, "");
    SetWindowText(hNote, "");
    if (CodeNum == CODE_MAX_PER_GAME) {
        EnableWindow(hCode, FALSE);
        EnableWindow(hNote, FALSE);
        return 0;
    }
    EnableWindow(hCode, TRUE);
    EnableWindow(hNote, TRUE);
    if (CheatDB.Codes[CodeNum].LineCount == 0) { return 1; }
    char txtCode[CODE_MAX_LINES*21]; txtCode[0] = '\0';
    int i;
    for (i = 0; i < CheatDB.Codes[CodeNum].LineCount; i++) {
        switch(CheatDB.System)
        {
            case CHEAT_PC: case CHEAT_PS2: case CHEAT_GBA_WRAM: case CHEAT_GBA_IRAM: case CHEAT_NDS:
            {
                sprintf(txtCode, "%s%01X%07X %08X\r\n", txtCode, CheatDB.Codes[CodeNum].Type[i],
                        CheatDB.Codes[CodeNum].Address[i], CheatDB.Codes[CodeNum].Value[i]);
            } break;
            case CHEAT_N64: case CHEAT_PS1:
            {
                if (CheatDB.Codes[CodeNum].Value[i] > 0xFFFF) {
                    sprintf(txtCode, "%s%02X%06X %08X\r\n", txtCode, CheatDB.Codes[CodeNum].Type[i],
                            CheatDB.Codes[CodeNum].Address[i], CheatDB.Codes[CodeNum].Value[i]);
                } else {
                    sprintf(txtCode, "%s%02X%06X %04X\r\n", txtCode, CheatDB.Codes[CodeNum].Type[i],
                            CheatDB.Codes[CodeNum].Address[i], CheatDB.Codes[CodeNum].Value[i]);
                }
            } break;
        }
    }
    SetWindowText(hCode, txtCode);
    SetWindowText(hNote, CheatDB.Codes[CodeNum].Note);
    return 1;
}
