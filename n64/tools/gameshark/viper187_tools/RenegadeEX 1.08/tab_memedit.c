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

LRESULT CALLBACK MemDataProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
LRESULT CALLBACK MemEditBoxProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
u32 ShowRAM(u32 address);
WNDPROC oldMemDataProc, oldMemEditBoxProc;
HMENU hMemEdMenu;
u32 CurrMemAddress;
LISTVIEW_ITEM_EDIT_INFO lvMemEditedItem;
const int MemEditRefreshTimer = 3;

BOOL CALLBACK MemoryEditorProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    HWND hMemEdHeader = GetDlgItem(hwnd, HDR_MEM_MENU);
    HWND hMemData = GetDlgItem(hwnd, LSV_MEM_EDITOR);
    HWND hMemEditBox = GetDlgItem(hwnd, TXT_MEM_EDIT);
	switch(message)
	{
		case WM_INITDIALOG:
        {
            SendMessage(hMemData,LVM_DELETEALLITEMS,0,0);
            SendMessage(hMemData,LVM_SETEXTENDEDLISTVIEWSTYLE,0,LVS_EX_FULLROWSELECT|LVS_EX_GRIDLINES|LVS_EX_LABELTIP);
            SendMessage(hMemData, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
            ListViewAddCol(hMemData, "Address", 0, 0x70);
            ListViewAddCol(hMemData, "0-3", 1, 0x70);
            ListViewAddCol(hMemData, "4-7", 2, 0x70);
            ListViewAddCol(hMemData, "8-B", 3, 0x70);
            ListViewAddCol(hMemData, "C-F", 4, 0x70);
            ListViewAddCol(hMemData, "ASCII", 5, 0x140);
		    oldMemDataProc = (WNDPROC)GetWindowLongPtr (hMemData, GWLP_WNDPROC);
		    SetWindowLongPtr (hMemData, GWLP_WNDPROC, (LONG_PTR)MemDataProcedure);
		    SendMessage(hMemEditBox, EM_SETLIMITTEXT, 8, 0);
		    oldMemEditBoxProc = (WNDPROC)GetWindowLongPtr (hMemEditBox, GWLP_WNDPROC);
		    SetWindowLongPtr (hMemEditBox, GWLP_WNDPROC, (LONG_PTR)MemEditBoxProcedure);
		    SetWindowPos(hMemEditBox,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
		    //Menu Setup
            AddHeaderItem(hMemEdHeader, 0x50, "File");
            AddHeaderItem(hMemEdHeader, 0x50, "View");
		    if ((hMemEdMenu = LoadMenu(hinstMain, MAKEINTRESOURCE(MEMORY_EDITOR_MENU))) == NULL) { MessageBox(NULL, "Failed to load menu", "Error", MB_OK); }
		    SetMenuItemData(hMemEdMenu, MNU_MEM_REFRESH_OFF, 0);
		    SetMenuItemData(hMemEdMenu, MNU_MEM_REFRESH_10MS, 10);
		    SetMenuItemData(hMemEdMenu, MNU_MEM_REFRESH_100MS, 100);
		    SetMenuItemData(hMemEdMenu, MNU_MEM_REFRESH_500MS, 500);
		    SetMenuItemData(hMemEdMenu, MNU_MEM_REFRESH_1S, 1000);
		    SetMenuItemData(hMemEdMenu, MNU_MEM_REFRESH_10S, 10000);
		    SetMenuItemData(hMemEdMenu, MNU_MEM_REFRESH_30S, 30000);
		    SetMenuItemData(hMemEdMenu, MNU_MEM_REFRESH_1M, 60000);
		    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_OFF, MFS_CHECKED);
        } break;
        case WM_COMMAND:
        {
			switch(LOWORD(wParam))
            {
			    case LSV_MEM_BEGINEDIT:
			    {
			        if (lvMemEditedItem.Status) { MessageBox(NULL,"Already editing. WTF? (LSV_MEM_BEGINEDIT)","Error",0); break; }
			        KillTimer(hwnd, MemEditRefreshTimer);
			        lvMemEditedItem.iItem = LOWORD(lParam);
			        lvMemEditedItem.iSubItem = HIWORD(lParam);
			        RECT lvEditRect; memset(&lvEditRect,0,sizeof(RECT));
			        lvEditRect.top = lvMemEditedItem.iSubItem;
			        lvEditRect.left = LVIR_LABEL;
			        SendMessage(hMemData, LVM_GETSUBITEMRECT, lvMemEditedItem.iItem, (LPARAM)&lvEditRect);
			        u32 value = ListViewGetHex(hMemData, lvMemEditedItem.iItem, lvMemEditedItem.iSubItem);
			        SetHexWindow(hMemEditBox, value);
			        WINDOWPLACEMENT lvPlace; memset(&lvPlace,0,sizeof(WINDOWPLACEMENT));
			        lvPlace.length = sizeof(WINDOWPLACEMENT);
			        GetWindowPlacement(hMemData, &lvPlace);
			        POINT lvPos;
			        lvPos.x = lvPlace.rcNormalPosition.left;
			        lvPos.y = lvPlace.rcNormalPosition.top;
			        SetWindowPos(hMemEditBox,HWND_TOP,lvPos.x+lvEditRect.left+3,lvPos.y+lvEditRect.top+1,(lvEditRect.right-lvEditRect.left),(lvEditRect.bottom-lvEditRect.top)+1,SWP_SHOWWINDOW);
			        SetFocus(hMemEditBox);
			        SendMessage(hMemEditBox, EM_SETSEL, 0, -1);
			        lvMemEditedItem.Status = 1;
			    } break;
			    case LSV_MEM_ENDEDIT:
			    {
                    if (Settings.MemEdit.RefreshRate) { SetTimer(hwnd, MemEditRefreshTimer, Settings.MemEdit.RefreshRate, NULL); }
			        if ((!lvMemEditedItem.Status) || (!lParam)) {
			            SetWindowPos(hMemEditBox,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
			            lvMemEditedItem.Status = 0;
			            SetFocus(hMemData); break;
                    }
                    u32 value = GetHexWindow(hMemEditBox);
                    char txtValue[9];
                    sprintf(txtValue, "%08X", value);
                    ListViewSetRow(hMemData, lvMemEditedItem.iItem, lvMemEditedItem.iSubItem, 1, txtValue);
                    lvMemEditedItem.Status = 0;
                    SetWindowPos(hMemEditBox,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
                    SetFocus(hMemData);
                    if (lvMemEditedItem.iSubItem == 0) {
                        CurrMemAddress = ShowRAM((value & 0xFFFFFFF0) & ~GetSystemAddressMask(Settings.Hook.System, 4));
                    } else if (lvMemEditedItem.iSubItem < 5) {
                        if (Settings.MemEdit.ByteSwap) { value = FlipBytes(value, 4); }
                        WriteRAM(CurrMemAddress + (lvMemEditedItem.iItem * 0x10) + ((lvMemEditedItem.iSubItem-1) * 4), value, 4, Settings.Hook.Endian);
                    }
                } break;
                case MNU_MEM_SAVE_DUMP:
                {
                    if (!DoFileSave(hwnd, RamInfo.NewResultsInfo.dmpFileName)) { break; }
                    if (!(RamInfo.NewResultsInfo.DumpSize = DumpRAM(RamInfo.NewResultsInfo.dmpFileName))) { break; }
                    FreeRamInfo();
                } break;
                case MNU_MEM_SHOW_BYTESWAPPED:
                {
                    Settings.MemEdit.ByteSwap ^= 1;
                    SetMenuState(hMemEdMenu, MNU_MEM_SHOW_BYTESWAPPED, (Settings.MemEdit.ByteSwap) ? MFS_CHECKED: MFS_UNCHECKED);
                    CurrMemAddress = ShowRAM(CurrMemAddress);
                } break;
                case MNU_MEM_REFRESH_OFF: case MNU_MEM_REFRESH_10MS: case MNU_MEM_REFRESH_100MS: case MNU_MEM_REFRESH_500MS: case MNU_MEM_REFRESH_1S:
                case MNU_MEM_REFRESH_10S: case MNU_MEM_REFRESH_30S: case MNU_MEM_REFRESH_1M:
                {
                    Settings.MemEdit.RefreshRate = GetMenuItemData(hMemEdMenu, LOWORD(wParam));
                    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_OFF, MFS_UNCHECKED);
                    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_10MS, MFS_UNCHECKED);
                    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_100MS, MFS_UNCHECKED);
                    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_500MS, MFS_UNCHECKED);
                    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_1S, MFS_UNCHECKED);
                    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_10S, MFS_UNCHECKED);
                    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_30S, MFS_UNCHECKED);
                    SetMenuState(hMemEdMenu, MNU_MEM_REFRESH_1M, MFS_UNCHECKED);
                    SetMenuState(hMemEdMenu, LOWORD(wParam), MFS_CHECKED);
                    KillTimer(hwnd, MemEditRefreshTimer);
                    if (Settings.MemEdit.RefreshRate) { SetTimer(hwnd, MemEditRefreshTimer, Settings.MemEdit.RefreshRate, NULL); }
                } break;
			}
        } break;
        case WM_NOTIFY:
        {
            switch(LOWORD(wParam))
			{
			    case HDR_MEM_MENU:
			    {
                    NMHEADER *hdInfo = (LPNMHEADER)lParam;
                    if (hdInfo->hdr.code == HDN_ITEMCLICK) {
                        HMENU hSubMenu;
                        POINT pt;
                        RECT hdRect;
                        SendMessage(hMemEdHeader, HDM_GETITEMRECT, hdInfo->iItem, (LPARAM)&hdRect);
                        pt.x = hdRect.left;
                        pt.y = hdRect.bottom;
                        ClientToScreen (hwnd, &pt);
                        hSubMenu = GetSubMenu(hMemEdMenu, hdInfo->iItem);
                        TrackPopupMenu(hSubMenu, TPM_LEFTALIGN | TPM_LEFTBUTTON, pt.x, pt.y+2, 0, hwnd, NULL);
                    }
                } break;
            }
        } break;
        case WM_TIMER:
        {
            KillTimer(hwnd, MemEditRefreshTimer);
            CurrMemAddress = ShowRAM(CurrMemAddress);
            if (Settings.MemEdit.RefreshRate) { SetTimer(hwnd, MemEditRefreshTimer, Settings.MemEdit.RefreshRate, NULL); }
        } break;
        case WM_SHOWWINDOW:
        {
            if (wParam) { CurrMemAddress = ShowRAM(CurrMemAddress); }
        } break;
    }
    return FALSE;
}

/**************************************************************
Memory Editor Listview Procedure
**************************************************************/
LRESULT CALLBACK MemDataProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch(message)
    {
        case WM_VSCROLL:
        {
            if (lvMemEditedItem.Status) { SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_ENDEDIT, 0); }
        } break;
        case WM_MOUSEWHEEL:
        {
            if (lvMemEditedItem.Status) { SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_ENDEDIT, 0); }
            int WheelDelta = (short) HIWORD(wParam);
            int keys = (short) LOWORD(wParam);
            if (WheelDelta == 0 ) { break; }
            DWORD dwPos = GetMessagePos();
            POINT pLoc = { GET_X_LPARAM( dwPos ), GET_Y_LPARAM( dwPos ) };
            ScreenToClient( hwnd, &pLoc );
            int ScrollLines = 0;
            SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, &ScrollLines, 0);
            if (!(ScrollLines) ) { break; }
            if (WheelDelta > 0 ) {
                if (keys & MK_CONTROL) { CurrMemAddress -= SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0) * 0x10; }
                else { CurrMemAddress -= ScrollLines * 0x10; }
            }
            else {
                if (keys & MK_CONTROL) { CurrMemAddress += SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0) * 0x10; }
                else { CurrMemAddress += ScrollLines * 0x10; }
            }
            int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
            CurrMemAddress = ShowRAM(CurrMemAddress);
            LVITEM lvItem;
            memset(&lvItem,0,sizeof(lvItem));
            lvItem.state = LVIS_SELECTED | LVIS_FOCUSED;
            lvItem.stateMask = LVIS_SELECTED | LVIS_FOCUSED;
            SendMessage(hwnd, LVM_SETITEMSTATE, iSelected, (LPARAM)&lvItem);
        }  break;
        case WM_LBUTTONDBLCLK:
        {
            if (lvMemEditedItem.Status) { SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_ENDEDIT, 0); }
            int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
            if (iSelected < 0) { break; }
            int iSubItem = ListViewHitTst(hwnd, GetMessagePos(), iSelected);
            if (iSubItem == 5) { break; }
            SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_BEGINEDIT, MAKELPARAM(iSelected, iSubItem));
        } break;
        case WM_KEYDOWN:
        {
            switch (wParam)
            {
                case VK_NEXT: case VK_PRIOR:
                {
                    int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
                    if (wParam == VK_NEXT) { CurrMemAddress += (SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0) * 0x10); }
                    else { CurrMemAddress -= (SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0) * 0x10); }
                    CurrMemAddress = ShowRAM(CurrMemAddress);
                    ListView_SetItemState(hwnd, iSelected, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                } return 0;
                case VK_UP:
                {
                    int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
                    if (HIWORD(GetKeyState(VK_CONTROL))) { CurrMemAddress -= (SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0) * 0x10); }
                    else if (iSelected > 0) { break; }
                    else { CurrMemAddress -= 0x10; }
                    CurrMemAddress = ShowRAM(CurrMemAddress);
                    ListView_SetItemState(hwnd, iSelected, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                } return 0;
                case VK_DOWN:
                {
                    int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
                    if (HIWORD(GetKeyState(VK_CONTROL))) { CurrMemAddress += (SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0) * 0x10); }
                    else if (iSelected == SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0) - 1) { CurrMemAddress += 0x10; }
                    else { break; }
                    CurrMemAddress = ShowRAM(CurrMemAddress);
                    ListView_SetItemState(hwnd, iSelected, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                } return 0;
                case VK_F5: { CurrMemAddress = ShowRAM(CurrMemAddress); } break;
            }
        } break;
    }
    if (oldMemDataProc) { return CallWindowProc (oldMemDataProc, hwnd, message, wParam, lParam); }
    else { return DefWindowProc (hwnd, message, wParam, lParam); }
}

/**************************************************************
Memory Editor edit box Procedure
**************************************************************/
LRESULT CALLBACK MemEditBoxProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
//    HWND hMemData = GetDlgItem(hTabDlgs[MEMORY_EDITOR_TAB], LSV_MEM_EDITOR);
    switch (message)
    {
        case WM_CHAR:
        {
            if ((wParam == VK_BACK) || (wParam == 24) || (wParam == 3) || (wParam == 22)) { break; } //cut/copy/paste/backspace
            if (wParam == 1) { SendMessage(hwnd, EM_SETSEL, 0, -1); } //select all
            wParam = FilterHexChar(wParam);
        } break;
        case WM_KILLFOCUS:
        {
            SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_ENDEDIT, 0);
        } return 0;
        case WM_KEYDOWN:
        {
            if (wParam == VK_RETURN) { SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_ENDEDIT, 1); }
            if (wParam == VK_ESCAPE) { SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_ENDEDIT, 0); }
            if (wParam == VK_TAB) {
                SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_ENDEDIT, 0);
                if (lvMemEditedItem.iSubItem < 4) {
                    SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_BEGINEDIT, MAKELPARAM(lvMemEditedItem.iItem, lvMemEditedItem.iSubItem + 1));
                } else { SendMessage(hTabDlgs[MEMORY_EDITOR_TAB], WM_COMMAND, LSV_MEM_BEGINEDIT, MAKELPARAM(lvMemEditedItem.iItem + 1, 1)); }
            }
        } break;
    }
    if (oldMemEditBoxProc) { return CallWindowProc (oldMemEditBoxProc, hwnd, message, wParam, lParam); }
	else { return DefWindowProc (hwnd, message, wParam, lParam); }
}

/**************************************************************
Show RAM page
**************************************************************/
u32 ShowRAM(u32 address)
{
    HWND hMemData = GetDlgItem(hTabDlgs[MEMORY_EDITOR_TAB], LSV_MEM_EDITOR);
    int PageSize = SendMessage(hMemData,LVM_GETCOUNTPERPAGE,0,0);
    char txtAddress[9], txtValue[9], txtASCII[17];
    u32 i, v, RamMax = Settings.Hook.MaxRamSize;
    u64 value = 0;
    int iCount = 0;
    if (Settings.Hook.AllRam) { RamMax = 0x7FFFFFFF; }

//    if ((s32)address < 0) { address = 0; }
    if (address >= RamMax) { return RamMax; }
    SendMessage(hMemData, LVM_DELETEALLITEMS, 0, 0);

    for (i = address; i < RamMax; i += 0x10) {
        if (iCount >= PageSize) { break; }
        sprintf(txtAddress, "%08X", i|GetSystemAddressMask(Settings.Hook.System,4));
        ListViewAddRow(hMemData, 1, txtAddress);
        strcpy(txtASCII, "");
        for(v = 0; v < 0x10; v += 4) {
            ReadRAM(i+v, &value, 4, Settings.Hook.System);
            if (Settings.MemEdit.ByteSwap) { value = FlipBytes(value, 4); }
            sprintf(txtValue, "%08X", value);
            ListViewSetRow(hMemData, iCount, (v/4)+1, 1, txtValue);
            Hex2ASCII(value, 4, txtValue);
            sprintf(txtASCII, "%s%s", txtASCII, txtValue);
        }
        ListViewSetRow(hMemData, iCount, 5, 1, txtASCII);
        iCount++;
    }
    SendMessage(hMemData, LVM_SETCOLUMNWIDTH, 0, LVSCW_AUTOSIZE);
    SendMessage(hMemData, LVM_SETCOLUMNWIDTH, 1, LVSCW_AUTOSIZE);
    SendMessage(hMemData, LVM_SETCOLUMNWIDTH, 2, LVSCW_AUTOSIZE);
    SendMessage(hMemData, LVM_SETCOLUMNWIDTH, 3, LVSCW_AUTOSIZE);
    SendMessage(hMemData, LVM_SETCOLUMNWIDTH, 4, LVSCW_AUTOSIZE);
    SendMessage(hMemData, LVM_SETCOLUMNWIDTH, 5, LVSCW_AUTOSIZE);
    return address;
}
