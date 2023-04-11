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

WNDPROC oldResListProc;
LRESULT CALLBACK ResListProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
s64 ShowResPage(s64 ResNum);
int LoadResultsList();
u32 TranslateAddressMap(u8 *Map, u32 MapSize, u32 address);
int ExportResults(int SearchNum);
int ResFmtString(char *tmpstring, int outfmt, int numbytes);
int Result2ActiveList(u32 address, u64 value, int size);
int ApplyResult(u32 address, u64 value, int size);
s64 CurrResNum = 0;
s64 MaxResNum;
SEARCH_RESULTS_LIST *ResultsList = NULL;
HMENU hResMenu;
const int ResWriteTimer = 0x2;

BOOL CALLBACK SearchResultsProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    HWND hResList = GetDlgItem(hwnd, LSV_RES_RESULTS);
    HWND hActList = GetDlgItem(hwnd, LSV_RES_ACTIVE);
    HWND hActAddress = GetDlgItem(hwnd, TXT_RES_ADDRESS);
    HWND hActValue = GetDlgItem(hwnd, TXT_RES_VALUE);
    HWND hActSize = GetDlgItem(hwnd, CMB_RES_SIZE);
    HWND hResHeader = GetDlgItem(hwnd, HDR_RES_MENU);
    HWND hResScroll = GetDlgItem(hwnd, VSCROLL_RES_RESULTS);
	switch(message)
	{
		case WM_INITDIALOG:
        {
            SendMessage(hResList,LVM_DELETEALLITEMS,0,0);
            SendMessage(hResList,LVM_SETEXTENDEDLISTVIEWSTYLE,0,LVS_EX_FULLROWSELECT|LVS_EX_GRIDLINES|LVS_EX_LABELTIP);
            SendMessage(hResList, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
            ListViewAddCol(hResList, "Address", 0, 0x80);
            SendMessage(hActList,LVM_DELETEALLITEMS,0,0);
            SendMessage(hActList,LVM_SETEXTENDEDLISTVIEWSTYLE,0,LVS_EX_FULLROWSELECT|LVS_EX_CHECKBOXES|LVS_EX_GRIDLINES|LVS_EX_LABELTIP);
            SendMessage(hActList, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
            ListViewAddCol(hActList, "Address", 0, 0x70);
            ListViewAddCol(hActList, "Value", 1, 0x80);
            ListViewAddCol(hActList, "Size", 2, 0x30);
            SendMessage(hActList, LVM_SETCOLUMNWIDTH, 2, LVSCW_AUTOSIZE_USEHEADER);
            SendMessage(hActSize,CB_RESETCONTENT,0,0);
            ComboAddItem(hActSize, "8-Bit (1 Byte)" , 1);
            ComboAddItem(hActSize, "16-Bit (2 Bytes)" , 2);
            ComboAddItem(hActSize, "32-Bit (4 Bytes)" , 4);
            ComboAddItem(hActSize, "64-Bit (8 Bytes)" , 8);
            SendMessage(hActSize,CB_SETCURSEL,0,0);
            SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_RES_SIZE, CBN_SELCHANGE),(LPARAM)hActSize);
		    oldResListProc = (WNDPROC)GetWindowLongPtr (hResList, GWLP_WNDPROC);
		    SetWindowLongPtr (hResList, GWLP_WNDPROC, (LONG_PTR)ResListProcedure);
		    //Menu Setup
		    //should disable resizing header but I can't figure out how
            AddHeaderItem(hResHeader, 0x50, "View");
            AddHeaderItem(hResHeader, 0x50, "Export");
            AddHeaderItem(hResHeader, 0x80, "Options");
		    if ((hResMenu = LoadMenu(hinstMain, MAKEINTRESOURCE(RES_LIST_MENU))) == NULL) { MessageBox(NULL, "Failed to load menu", "Error", MB_OK); }
		    SetMenuState(hResMenu, Settings.Results.DisplayFmt, MFS_CHECKED);
		    SendMessage(hActAddress, EM_SETLIMITTEXT, 8, 0);
		    SendMessage(hActValue, EM_SETLIMITTEXT, 16, 0);
		    SendMessage(hActAddress, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
		    SendMessage(hActValue, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
		    SetWindowLongPtr (hActAddress, GWLP_WNDPROC, (LONG_PTR)HexEditBoxProc);
		    SetWindowLongPtr (hActValue, GWLP_WNDPROC, (LONG_PTR)HexEditBoxProc);
		    SetMenuItemData(hResMenu, MNU_RES_WRITE_OFF, 0);
		    SetMenuItemData(hResMenu, MNU_RES_WRITE_10MS, 10);
		    SetMenuItemData(hResMenu, MNU_RES_WRITE_100MS, 100);
		    SetMenuItemData(hResMenu, MNU_RES_WRITE_500MS, 500);
		    SetMenuItemData(hResMenu, MNU_RES_WRITE_1S, 1000);
		    SetMenuItemData(hResMenu, MNU_RES_WRITE_10S, 10000);
		    SetMenuItemData(hResMenu, MNU_RES_WRITE_30S, 30000);
		    SetMenuItemData(hResMenu, MNU_RES_WRITE_1M, 60000);
		    SetMenuState(hResMenu, Settings.Results.ResWriteRateId, MFS_CHECKED);
		    SetMenuState(hResMenu, MNU_RES_RAM_VIEW, Settings.Results.RamView ? MFS_CHECKED : MFS_UNCHECKED);
        } break;
		case WM_COMMAND:
        {
            if ((LOWORD(wParam) >= MNU_RES_MIN_EXPORT) && (LOWORD(wParam) < MNU_RES_MAX_EXPORT)) {
                ExportResults(LOWORD(wParam) & 0xFF);
            }
			switch(LOWORD(wParam))
            {
                case MNU_RES_SHOW_HEX: case MNU_RES_SHOW_DECU: case MNU_RES_SHOW_DECS: case MNU_RES_SHOW_FLOAT:
                {
                    Settings.Results.DisplayFmt = LOWORD(wParam);
			        SetMenuState(hResMenu, MNU_RES_SHOW_HEX, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_SHOW_DECU, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_SHOW_DECS, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_SHOW_FLOAT, MFS_UNCHECKED);
			        SetMenuState(hResMenu, LOWORD(wParam), MFS_CHECKED);
			        ShowResPage(CurrResNum);
                } break;
                case MNU_RES_EXPORT_HEX: case MNU_RES_EXPORT_DECU: case MNU_RES_EXPORT_DECS: case MNU_RES_EXPORT_FLOAT:
                {
                    ExportResults(-1);
                } break;
                case MNU_RES_WRITE_OFF: case MNU_RES_WRITE_10MS: case MNU_RES_WRITE_100MS: case MNU_RES_WRITE_500MS: case MNU_RES_WRITE_1S: case MNU_RES_WRITE_10S:
                case MNU_RES_WRITE_30S: case MNU_RES_WRITE_1M:
                {
                    Settings.Results.ResWriteRate = GetMenuItemData(hResMenu, LOWORD(wParam));
                    Settings.Results.ResWriteRateId = LOWORD(wParam);
			        SetMenuState(hResMenu, MNU_RES_WRITE_OFF, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_WRITE_10MS, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_WRITE_100MS, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_WRITE_500MS, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_WRITE_1S, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_WRITE_10S, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_WRITE_30S, MFS_UNCHECKED);
			        SetMenuState(hResMenu, MNU_RES_WRITE_1M, MFS_UNCHECKED);
			        SetMenuState(hResMenu, LOWORD(wParam), MFS_CHECKED);
                }
                case MNU_RES_RAM_VIEW:
                {
                    Settings.Results.RamView ^= 1;
                    SetMenuState(hResMenu, MNU_RES_RAM_VIEW, (Settings.Results.RamView) ? MFS_CHECKED: MFS_UNCHECKED);
                } break;
                case CMB_RES_SIZE:
                {
                    if (HIWORD(wParam) == CBN_SELCHANGE) {
                        SendMessage(hActValue, EM_SETLIMITTEXT, SendMessage(hActSize,CB_GETITEMDATA,SendMessage(hActSize,CB_GETCURSEL,0,0), 0)*2, 0);
				    }
				} break;
				case CMD_RES_ADD:
                {
                    u32 address = GetHexWindow(hActAddress);
                    u64 value = GetHexWindow(hActValue);
                    int size = SendMessage(hActSize,CB_GETITEMDATA,SendMessage(hActSize,CB_GETCURSEL,0,0), 0);
                    if (address % size) { MessageBox(NULL, "Address must be aligned to match the number of bytes being written, fucknut.", "Error", MB_OK); break; }
                    ListView_SetCheckState(hActList, Result2ActiveList(address, value, size), TRUE);
                } break;
				case CMD_RES_DEL:
                {
                    int iCount = SendMessage(hActList, LVM_GETITEMCOUNT, 0, 0);
                    int i;
                    for (i = 0; i < iCount; i++) {
                        if (SendMessage(hActList, LVM_GETITEMSTATE, i, LVIS_SELECTED)) {
                            SendMessage(hActList, LVM_DELETEITEM, i, 0);
                        }
                    }
                } break;
				case CMD_RES_CLEAR:
                {
                    SendMessage(hActList, LVM_DELETEALLITEMS, 0, 0);
                } break;
				case CMD_RES_ALL_ON:
                {
                    int iCount = SendMessage(hActList, LVM_GETITEMCOUNT, 0, 0);
                    int i;
                    for (i = 0; i < iCount; i++) {
                        ListView_SetCheckState(hActList, i, TRUE);
                    }
                } break;
				case CMD_RES_ALL_OFF:
                {
                    int iCount = SendMessage(hActList, LVM_GETITEMCOUNT, 0, 0);
                    int i;
                    for (i = 0; i < iCount; i++) {
                        ListView_SetCheckState(hActList, i, FALSE);
                    }
                } break;
            }
        } break;
        case WM_VSCROLL:
        {
            if (((HWND)lParam != hResScroll) || (!(ResultsList))) { break; }
            int PageSize = SendMessage(hResList,LVM_GETCOUNTPERPAGE,0,0);
            SCROLLINFO si;
            si.cbSize = sizeof(SCROLLINFO);
            si.fMask  = SIF_ALL;
            GetScrollInfo (hResScroll, SB_VERT, &si);
            switch(LOWORD(wParam))
            {
                case SB_LINEDOWN:
                {
                    si.nPos += 1;
                    CurrResNum = ShowResPage(CurrResNum + 1);
                } break;
                case SB_PAGEDOWN:
                {
                    si.nPos += si.nPage;
                    CurrResNum = ShowResPage(CurrResNum + PageSize);
                } break;
                case SB_LINEUP:
                {
                    si.nPos -= 1;
                    CurrResNum = ShowResPage(CurrResNum - 1);
                } break;
                case SB_PAGEUP:
                {
                    si.nPos -= si.nPage;
                    CurrResNum = ShowResPage(CurrResNum - PageSize);
                } break;
                case SB_THUMBTRACK: case SB_THUMBPOSITION:
                {
                    si.nPos = HIWORD(wParam);
                    si.nTrackPos = HIWORD(wParam);
                } break;
                default: return FALSE; //break;
            }
            si.fMask = SIF_POS;
            SetScrollInfo (hResScroll, SB_VERT, &si, TRUE);
//sprintf(ErrTxt, "%u", si.nPos);
//if (si.nPos > 0) { MessageBox(NULL, ErrTxt, "Debug", MB_OK); }
//                SendMessage(hResList,LVM_GETCOUNTPERPAGE,0,0);
//                sprintf(ErrTxt, "%u", HIWORD(wParam));
//                MessageBox(NULL, ErrTxt, "Debug", MB_OK);
        } break;
        case WM_NOTIFY:
        {
            switch(LOWORD(wParam))
			{
			    case HDR_RES_MENU:
			    {
                    NMHEADER *hdInfo = (LPNMHEADER)lParam;
                    if (hdInfo->hdr.code == HDN_ITEMCLICK) {
                        HMENU hSubMenu;
                        POINT pt;
                        RECT hdRect;
                        SendMessage(hResHeader, HDM_GETITEMRECT, hdInfo->iItem, (LPARAM)&hdRect);
                        pt.x = hdRect.left;
                        pt.y = hdRect.bottom;
                        ClientToScreen (hwnd, &pt);
                        hSubMenu = GetSubMenu(hResMenu, hdInfo->iItem);
                        TrackPopupMenu(hSubMenu, TPM_LEFTALIGN | TPM_LEFTBUTTON, pt.x, pt.y+2, 0, hwnd, NULL);
                    }
                } break;
            }
        } break;
        case WM_INITMENUPOPUP:
        {
            switch(GetMenuItemID((HMENU)wParam, 0))
            {
                case MNU_RES_EXPORT_HEX: case MNU_RES_EXPORT_DECU: case MNU_RES_EXPORT_DECS: case MNU_RES_EXPORT_FLOAT:
                case MNU_RES_EXPORT_GS:
                {
                    int i = MNU_RES_MIN_EXPORT;
                    char mnuString[100];
                    Settings.Results.ExportFmt = GetMenuItemID((HMENU)wParam, 0);
                    while ((DeleteMenu((HMENU)wParam, i, MF_BYCOMMAND)) && (i < MNU_RES_MAX_EXPORT)) { i++; }
                    int SearchCount = SendMessage(GetDlgItem(hTabDlgs[CODE_SEARCH_TAB], CMB_CS_COMPARE_TO),CB_GETCOUNT,0,0) - 1;
                    for (i = 0; i < SearchCount; i++) {
                        sprintf(mnuString, "Search %u", SearchCount - i);
                        AppendMenu((HMENU)wParam, MF_STRING, MNU_RES_MIN_EXPORT + i, mnuString);
                    }
                    if (Settings.Results.ExportFmt != MNU_RES_EXPORT_GS) {
                        SetMenuState(hResMenu, Settings.Results.ExportFmt, (ResultsList) ? MFS_ENABLED : MFS_GRAYED);
                    }
                } break;
            }
        } break;
        case WM_TIMER:
        {
            KillTimer(hwnd, ResWriteTimer);
            int iCount = SendMessage(hActList, LVM_GETITEMCOUNT, 0, 0);
            if (!iCount) { break; }
            int i, size;
            u32 address;
            u64 value;
            for (i = 0; i < iCount; i++) {
                if (ListView_GetCheckState(hActList, i)) {
                    address = ListViewGetHex(hActList, i, 0);
                    value = ListViewGetHex(hActList, i, 1);
                    size = ListViewGetHex(hActList, i, 2);
                    ApplyResult(address, value, size);
                }
            }
            if (Settings.Results.ResWriteRate) { SetTimer(hwnd, ResWriteTimer, Settings.Results.ResWriteRate, NULL); }
        } break;
        case WM_SHOWWINDOW:
        {
            if (wParam) { LoadResultsList(); }
        } break;
	}
	return FALSE;
}

/**************************************************************
Results Listview Procedure
**************************************************************/
LRESULT CALLBACK ResListProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case WM_MOUSEWHEEL:
        {
            int WheelDelta = (short) HIWORD(wParam);
            int keys = (short) LOWORD(wParam);
            if (WheelDelta == 0 ) { break; }
            DWORD dwPos = GetMessagePos();
            POINT pLoc = { GET_X_LPARAM( dwPos ), GET_Y_LPARAM( dwPos ) };
            ScreenToClient( hwnd, &pLoc );
            int ScrollLines = 0;
            SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, &ScrollLines, 0);
            if ( (!(ScrollLines)) || (!(ResultsList)) ) { break; }
            if (WheelDelta > 0 ) {
                if (keys & MK_CONTROL) { CurrResNum -= SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0); }
                else { CurrResNum -= ScrollLines; }
            }
            else {
                if (keys & MK_CONTROL) { CurrResNum += SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0); }
                else { CurrResNum += ScrollLines; }
            }
            int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
            CurrResNum = ShowResPage(CurrResNum);
            LVITEM lvItem;
            memset(&lvItem,0,sizeof(lvItem));
            lvItem.state = LVIS_SELECTED | LVIS_FOCUSED;
            lvItem.stateMask = LVIS_SELECTED | LVIS_FOCUSED;
            SendMessage(hwnd, LVM_SETITEMSTATE, iSelected, (LPARAM)&lvItem);
        } break;
        case WM_LBUTTONDBLCLK: case WM_LBUTTONDOWN:
        {
            if (!(ResultsList)) { break; }
            int iSelected = ListViewHitTst(hwnd, GetMessagePos(), -1);
            if (iSelected < 0) { break; }
            if ((CurrResNum + iSelected) > MaxResNum) { break; }
            int iSubItem = ListViewHitTst(hwnd, GetMessagePos(), iSelected);
            if (iSubItem <= 0) { iSubItem = 1; }
            u32 address = ResultsList[CurrResNum+iSelected].Address;
            u64 value = ResultsList[CurrResNum+iSelected].Values[iSubItem-1];
            ComboSelFromData(GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], CMB_RES_SIZE), ResultsList[0].Size);
            SendMessage(GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], TXT_RES_VALUE), EM_SETLIMITTEXT, ResultsList[0].Size*2, 0);
            SetHexWindow(GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], TXT_RES_ADDRESS), address);
            SetHexWindow(GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], TXT_RES_VALUE), value);
            extern CurrMemAddress;
            if (Settings.Results.RamView == 1) { CurrMemAddress = ShowRAM((address & 0xFFFFFFF0) & ~GetSystemAddressMask(Settings.Hook.System, 4)); }
            if (message == WM_LBUTTONDBLCLK) {
                ListView_SetCheckState(GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], LSV_RES_ACTIVE), Result2ActiveList(address, value, ResultsList[0].Size), TRUE);
            }
//            sprintf(ErrTxt, "%08I64X: %I64X", address, value);
//            MessageBox(NULL, ErrTxt, "Debug", MB_OK);
        } break;
        case WM_KEYDOWN:
        {
            switch (wParam)
            {
                case VK_NEXT: case VK_PRIOR:
                {
                    if (!(ResultsList)) { break; }
                    int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
                    if (wParam == VK_NEXT) { CurrResNum += SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0); }
                    else { CurrResNum -= SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0); }
                    CurrResNum = ShowResPage(CurrResNum);
                    ListView_SetItemState(hwnd, iSelected, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                } return 0;
                case VK_UP:
                {
                    if (!(ResultsList)) { break; }
                    int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
                    if (HIWORD(GetKeyState(VK_CONTROL))) { CurrResNum -= SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0); }
                    else if (iSelected > 0) { break; }
                    else { CurrResNum--; }
                    CurrResNum = ShowResPage(CurrResNum);
                    ListView_SetItemState(hwnd, iSelected, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                } return 0;
                case VK_DOWN:
                {
                    if (!(ResultsList)) { break; }
                    int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
                    if (HIWORD(GetKeyState(VK_CONTROL))) { CurrResNum += SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0); }
                    else if (iSelected == SendMessage(hwnd,LVM_GETCOUNTPERPAGE,0,0) - 1) { CurrResNum++; }
                    else { break; }
                    CurrResNum = ShowResPage(CurrResNum);
                    ListView_SetItemState(hwnd, iSelected, LVIS_SELECTED|LVIS_FOCUSED, LVIS_SELECTED|LVIS_FOCUSED);
                } return 0;
            }
        } break;
    }
    if (oldResListProc) { return CallWindowProc (oldResListProc, hwnd, message, wParam, lParam); }
    else { return DefWindowProc (hwnd, message, wParam, lParam); }
}


/**************************************************************
Load all results
**************************************************************/
int LoadResultsList()
{
    CurrResNum = 0;
    FreeRamInfo();
    u32 i, DumpAddy, SearchCount, DumpNum;
    u64 ResValue;
    FILE *ramFiles[MAX_SEARCHES];
    HWND hCS_CompareTo = GetDlgItem(hTabDlgs[CODE_SEARCH_TAB], CMB_CS_COMPARE_TO);
    HWND hResList = GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], LSV_RES_RESULTS);
    HWND hResScroll = GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], VSCROLL_RES_RESULTS);
    char resFileName[MAX_PATH];
    char txtValue[32];
    SearchCount = SendMessage(hCS_CompareTo,CB_GETCOUNT,0,0) - 1;
    if (!SearchCount) { return 0; }
    i = 1;
    while (SendMessage(hResList,LVM_DELETECOLUMN,i,0)) { i++; }
    for (DumpNum = 0; DumpNum < SearchCount; DumpNum++) {
        sprintf(resFileName,"%ssearch%u.bin",Settings.CS.DumpDir, (SearchCount - DumpNum));
        if (!(LoadStruct(&RamInfo.OldResultsInfo, sizeof(CODE_SEARCH_RESULTS_INFO), resFileName))) { return 0; }
        ramFiles[DumpNum] = fopen(RamInfo.OldResultsInfo.dmpFileName,"rb");
	    if (!(ramFiles[DumpNum])) {
            sprintf(ErrTxt, "Unable to open dump file (ShowResPage,1) -- Error %u", GetLastError());
            MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
	    }
	    sprintf(txtValue, "%u", SearchCount - DumpNum);
	    ListViewAddCol(hResList, txtValue, DumpNum + 1, 0x80);
    }
    sprintf(resFileName,"%ssearch%u.bin",Settings.CS.DumpDir, SearchCount);
    if (!(LoadStruct(&RamInfo.NewResultsInfo, sizeof(CODE_SEARCH_RESULTS_INFO), resFileName))) { return 0; }
    if (!(LoadFile(&RamInfo.Results, resFileName, sizeof(CODE_SEARCH_RESULTS_INFO), NULL, FALSE))) { return 0; }
	fseek(ramFiles[0],0,SEEK_END);
	RamInfo.NewResultsInfo.DumpSize = ftell(ramFiles[0]);
	fseek(ramFiles[0],0,SEEK_SET);
	RamInfo.Access = SEARCH_ACCESS_FILE;
	u8 *AddressMap = NULL;
	u32 MapSize = 0;
	if (RamInfo.OldResultsInfo.Mapped) {
        if (!(MapSize = LoadFile(&AddressMap, RamInfo.OldResultsInfo.MapFileName, 0, NULL, FALSE))) {
            if (AddressMap) { free(AddressMap); AddressMap = NULL; }
        }
	}
	i = 0;
	DumpAddy = 0;
    if (ResultsList) { free(ResultsList); ResultsList = NULL; }
    if (!(ResultsList = (SEARCH_RESULTS_LIST*)malloc(sizeof(SEARCH_RESULTS_LIST) * (RamInfo.NewResultsInfo.ResCount+1)))) {
        sprintf(ErrTxt, "Unable to allocate results list memory (ShowResPage, 1) -- Error %u", GetLastError());
        MessageBox(NULL, ErrTxt, "Error", MB_OK);
        for (DumpNum = 0; DumpNum < SearchCount; DumpNum++) { fclose(ramFiles[DumpNum]); }
        FreeRamInfo(); return 0;
    }

    MaxResNum = RamInfo.NewResultsInfo.ResCount;
    SCROLLINFO si;
    si.cbSize = sizeof(SCROLLINFO);
    si.fMask  = SIF_RANGE | SIF_PAGE;
    si.nMin   = 0;
    si.nMax   = MaxResNum;
    si.nPage  = SendMessage(hResList,LVM_GETCOUNTPERPAGE,0,0);
    SetScrollInfo(hResScroll, SB_VERT, &si, TRUE);
    ResultsList[0].Size = RamInfo.NewResultsInfo.SearchSize;
    while ((DumpAddy < RamInfo.NewResultsInfo.DumpSize) && (i < RamInfo.NewResultsInfo.ResCount)) {
        if (!(GetBitFlag(RamInfo.Results, DumpAddy/RamInfo.NewResultsInfo.SearchSize))) { DumpAddy += RamInfo.NewResultsInfo.SearchSize; continue; }
        ResultsList[i].Address = TranslateAddressMap(AddressMap, MapSize, DumpAddy);
        for (DumpNum = 0; DumpNum < SearchCount; DumpNum++) {
            RamInfo.NewFile = ramFiles[DumpNum];
            GetSearchValues(&ResValue, NULL, DumpAddy, RamInfo.NewResultsInfo.SearchSize, RamInfo.NewResultsInfo.Endian);
            ResultsList[i].Values[DumpNum] = ResValue;
        }
        DumpAddy += RamInfo.NewResultsInfo.SearchSize;
        i++;
    }
    for (DumpNum = 0; DumpNum < SearchCount; DumpNum++) { fclose(ramFiles[DumpNum]); }
    FreeRamInfo();
    ShowResPage(CurrResNum);
    return i;
}

u32 TranslateAddressMap(u8 *Map, u32 MapSize, u32 address)
{
    int i;
    u32 base = 0;
    u32 size = 0;
    for (i = 0; i < MapSize; i+=0xC) {
        base = *(u32*)&Map[i];
        size = *(u32*)&Map[i+8];
        if ((address >= base) && (address < (base + size))) {
            return (*(u32*)&Map[i+4]) + (address - base);
        }
    }
    return address;
}

/**************************************************************
Show 1 page of results
**************************************************************/
s64 ShowResPage(s64 ResNum)
{
    if (!(ResultsList)) { return 0; }
    u32 i, DumpNum, PageSize;
    float tmpFloat=0;
    u32 *CastFloat=(u32*)(&tmpFloat);
    double tmpDouble=0;
    u64 *CastDouble=(u64*)&tmpDouble;
    HWND hResList = GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], LSV_RES_RESULTS);
    HWND hCS_CompareTo = GetDlgItem(hTabDlgs[CODE_SEARCH_TAB], CMB_CS_COMPARE_TO);
    int SearchCount = SendMessage(hCS_CompareTo,CB_GETCOUNT,0,0) - 1;
    char txtAddress[9], txtValue[32], fmtString[20];
    PageSize = SendMessage(hResList,LVM_GETCOUNTPERPAGE,0,0);
    if (ResNum >= MaxResNum) { ResNum = MaxResNum - PageSize; }
//    if (ResNum >= MaxResNum) { FreeRamInfo(); return MaxResNum; }
    if (ResNum < 0) { FreeRamInfo(); return 0; }
    SendMessage(hResList,LVM_DELETEALLITEMS,0,0);
    ResFmtString(fmtString, Settings.Results.DisplayFmt, ResultsList[0].Size);
    for (i = 0; (i < PageSize) && ((ResNum + i) < MaxResNum); i++) {
        sprintf(txtAddress, "%08X", ResultsList[ResNum+i].Address);
        ListViewAddRow(hResList, 1, txtAddress);
        SendMessage(hResList, LVM_SETCOLUMNWIDTH, 0, LVSCW_AUTOSIZE);
        for (DumpNum = 0; DumpNum < SearchCount; DumpNum++) {
            if (Settings.Results.DisplayFmt == MNU_RES_SHOW_FLOAT) {
                *CastDouble = ResultsList[ResNum+i].Values[DumpNum];
                *CastFloat = ResultsList[ResNum+i].Values[DumpNum] & 0xFFFFFFFF;
                sprintf(txtValue, fmtString, (ResultsList[0].Size == 4) ? tmpFloat : tmpDouble);
            } else { sprintf(txtValue, fmtString, ResultsList[ResNum+i].Values[DumpNum]); }
            ListViewSetRow(hResList, i, DumpNum + 1, 1, txtValue);
            SendMessage(hResList, LVM_SETCOLUMNWIDTH, DumpNum + 1, LVSCW_AUTOSIZE);
        }
    }
    return ResNum;
}

/**************************************************************
Export results
**************************************************************/
int ExportResults(int SearchNum)
{
    if (!(ResultsList)) { return 0; }
    u32 i, DumpNum, address;
    u64 value;
    float tmpFloat=0;
    u32 *CastFloat=(u32*)(&tmpFloat);
    double tmpDouble=0;
    u64 *CastDouble=(u64*)&tmpDouble;
    int SearchCount = SendMessage(GetDlgItem(hTabDlgs[CODE_SEARCH_TAB], CMB_CS_COMPARE_TO),CB_GETCOUNT,0,0) - 1;
    char resFileName[MAX_PATH], txtValue[32], fmtString[20], txtLine[4096];
    ResFmtString(fmtString, Settings.Results.DisplayFmt, ResultsList[0].Size);
    if (!DoFileSave(NULL, resFileName)) { return 0; }
    FILE *ResTxtFile = fopen(resFileName, "wt");
    if (!(ResTxtFile)) {
        sprintf(ErrTxt, "Unable to open/create results file (ExportResults,1) -- Error %u", GetLastError());
        MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
    }
    for (i = 0; i < MaxResNum; i++) {
        sprintf(txtLine, "%08X", ResultsList[i].Address);
        if (SearchNum == -1) {
            for (DumpNum = 0; DumpNum < SearchCount; DumpNum++) {
                sprintf(txtValue, fmtString, ResultsList[i].Values[DumpNum]);
                strcat(txtLine, txtValue);
            }
        } else {
            address = ResultsList[i].Address;
            value = ResultsList[i].Values[SearchNum];
            switch (Settings.Results.ExportFmt)
            {
                case MNU_RES_EXPORT_GS:
                {
                    switch (ResultsList[0].Size)
                    {
                        case 1: case 2:
                        {
                            switch (Settings.Hook.System)
                            {
                                case SYSTEM_PC:
                                {
                                    sprintf(txtLine, "%010I64X %08X", address, value);
                                } break;
                                case SYSTEM_N64: case SYSTEM_PS1:
                                {
                                        sprintf(txtLine, "%08X %04X", address, value);
/*
                                    if ((Settings.Hook.System == SYSTEM_PS1) && (ResultsList[0].Size == 1)) {
                                        sprintf(txtLine, "%08X %04X", address|0x30000000, value);
                                    } else { sprintf(txtLine, "%08X %04X", address|0x80000000, value); }
*/
                                } break;
                                case SYSTEM_PS2:
                                {
                                    sprintf(txtLine, "%08X %08X", address, value);
                                } break;
                            }
                        } break;
                        case 4:
                        {
                            switch (Settings.Hook.System)
                            {
                                case SYSTEM_PC:
                                {
                                    sprintf(txtLine, "%010I64X %08X", address|0x2000000000LL, value);
                                } break;
                                case SYSTEM_N64: case SYSTEM_PS1:
                                {
                                    sprintf(txtLine, "%08X %04X\n", address|0x80000000, ShortFromU64(value,(Settings.Hook.System == SYSTEM_PS1 ? 3 : 2)));
                                    sprintf(txtLine, "%s%08X %04X", txtLine, (address|0x80000000) + 2, ShortFromU64(value,(Settings.Hook.System == SYSTEM_PS1 ? 2 : 3)));
                                } break;
                                case SYSTEM_PS2:
                                {
                                    sprintf(txtLine, "%08X %08X", address|0x20000000, value);
                                } break;
                            }
                        } break;
                        case 8:
                        {
                            switch (Settings.Hook.System)
                            {
                                case SYSTEM_PC:
                                {
                                    sprintf(txtLine, "%010I64X %08X\n", address|0x2000000000LL, WordFromU64(value,0));
                                    sprintf(txtLine, "%s%010I64X %08X", txtLine, (address|0x2000000000LL) + 4, WordFromU64(value,1));
                                } break;
                                case SYSTEM_N64: case SYSTEM_PS1:
                                {
                                    sprintf(txtLine, "%08X %04X\n", address|0x80000000, ShortFromU64(value,(Settings.Hook.System == SYSTEM_PS1 ? 1 : 0)));
                                    sprintf(txtLine, "%s%08X %04X\n", txtLine, (address|0x80000000) + 2, ShortFromU64(value,(Settings.Hook.System == SYSTEM_PS1 ? 0 : 1)));
                                    sprintf(txtLine, "%s%08X %04X\n", txtLine, (address|0x80000000) + 4, ShortFromU64(value,(Settings.Hook.System == SYSTEM_PS1 ? 3 : 2)));
                                    sprintf(txtLine, "%s%08X %04X", txtLine, (address|0x80000000) + 6, ShortFromU64(value,(Settings.Hook.System == SYSTEM_PS1 ? 2 : 3)));
                                } break;
                                case SYSTEM_PS2:
                                {
                                    sprintf(txtLine, "%08X %08X", (address|0x20000000), WordFromU64(value,0));
                                    sprintf(txtLine, "%s%08X %08X", txtLine, (address|0x20000000) + 4, WordFromU64(value,1));
                                } break;
                            }
                        } break;
                    }
                } break;
                case MNU_RES_EXPORT_FLOAT:
                {
                    *CastDouble = value;
                    *CastFloat = value & 0xFFFFFFFF;
                    sprintf(txtLine, "%08X ", address);
                    sprintf(txtValue, fmtString, (ResultsList[0].Size == 4) ? tmpFloat : tmpDouble);
                    strcat(txtLine, txtValue);
                } break;
                default:
                {
                    sprintf(txtLine, "%08X ", address);
                    sprintf(txtValue, fmtString, value);
                    strcat(txtLine, txtValue);
                }
            }

//            FmtExportValue(txtLine, ResultsList[i].Address, ResultsList[i].Values[SearchNum]);
//            sprintf(txtValue, fmtString, ResultsList[i].Values[SearchNum]);
//            strcat(txtLine, txtValue);
        }
        fprintf(ResTxtFile, "%s\n", txtLine);
    }
    fclose(ResTxtFile);
    return i;
}

/**************************************************************
ResFmtString - get format string for sprintf while printing results
**************************************************************/
int ResFmtString(char *tmpstring, int outfmt, int numbytes)
{
    switch (outfmt) {
        case MNU_RES_SHOW_HEX: case MNU_RES_EXPORT_HEX:
        { sprintf(tmpstring,"%%0%uI64X", numbytes*2); } break;
        MessageBox(NULL, tmpstring, "Debug", 0);
        case MNU_RES_SHOW_DECU: case MNU_RES_EXPORT_DECU:
        {
            sprintf(tmpstring,"%%I64u");
        } break;
        case MNU_RES_SHOW_DECS: case MNU_RES_EXPORT_DECS:
        {
            sprintf(tmpstring,"%%I64d");
        } break;
        case MNU_RES_SHOW_FLOAT: case MNU_RES_EXPORT_FLOAT:
        {
            if (numbytes == 4) sprintf(tmpstring,"%%f");
            else sprintf(tmpstring,"%%Lf");
        } break;
    }
    return 0;
}

/**************************************************************
Add Code to active list
**************************************************************/
int Result2ActiveList(u32 address, u64 value, int size)
{
    HWND hActList = GetDlgItem(hTabDlgs[SEARCH_RESULTS_TAB], LSV_RES_ACTIVE);
    int iCount = SendMessage(hActList, LVM_GETITEMCOUNT, 0, 0);
    char txtValue[32], txtSize[4], txtAddress[20];
    int i;
    for (i = 0; i < iCount; i++) {
        if (ListViewGetHex(hActList, i, 0) == address) {
            sprintf(txtValue, "%08I64X", value);
            sprintf(txtSize, "%u", size);
            ListViewSetRow(hActList, i, 1, 2, txtValue, txtSize);
            return i;
        }
    }
    sprintf(txtAddress, "%08I64X", address);
    sprintf(txtValue, "%08I64X", value);
    sprintf(txtSize, "%u", size);
    KillTimer(hTabDlgs[SEARCH_RESULTS_TAB], ResWriteTimer);
    if (Settings.Results.ResWriteRate) { SetTimer(hTabDlgs[SEARCH_RESULTS_TAB], ResWriteTimer, Settings.Results.ResWriteRate, NULL); }
    return ListViewAddRow(hActList, 3, txtAddress, txtValue, txtSize);
}

/**************************************************************
ApplyResult - Apply code form active list
**************************************************************/
int ApplyResult(u32 address, u64 value, int size)
{
    switch (Settings.Hook.System)
    {
        case SYSTEM_N64: case SYSTEM_PS1: { address &= 0x7FFFFF; } break;
        case SYSTEM_PS2: { address &= 0x1FFFFFF; } break;
        case SYSTEM_GBA_WRAM: { address &= 0x3FFFF; } break;
        case SYSTEM_GBA_IRAM: { address &= 0x7FFF; } break;
        case SYSTEM_NDS: { address &= 0x3FFFFF; } break;
    }
    if (WriteRAM(address, value, size, Settings.Hook.Endian) == 0) {
        KillTimer(hTabDlgs[SEARCH_RESULTS_TAB], ResWriteTimer);
        SendMessage(hTabDlgs[SEARCH_RESULTS_TAB], WM_COMMAND, CMD_RES_ALL_OFF, 0);
        if (Settings.Results.ResWriteRate) { SetTimer(hTabDlgs[SEARCH_RESULTS_TAB], ResWriteTimer, Settings.Results.ResWriteRate, NULL); }
    }
    return 0;
}
