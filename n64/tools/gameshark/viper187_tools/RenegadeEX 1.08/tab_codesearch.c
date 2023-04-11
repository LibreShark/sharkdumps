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

LRESULT CALLBACK ExSearchListProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
LRESULT CALLBACK ExListEditProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
LRESULT CALLBACK SearchValueBoxProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
WNDPROC oldExSearchListProc;
WNDPROC oldExListEditProc;
WNDPROC oldSearchValueBoxProc;

LISTVIEW_ITEM_EDIT_INFO lvExEditedItem;
CODE_SEARCH_VARS Search;
HMENU hCSMenu;

BOOL CALLBACK CodeSearchProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    HWND hSearchSize = GetDlgItem(hwnd, CMB_CS_SEARCH_SIZE);
    HWND hCompareTo = GetDlgItem(hwnd, CMB_CS_COMPARE_TO);
    HWND hSearchType = GetDlgItem(hwnd, CMB_CS_SEARCH_TYPE);
    HWND hExSearchList = GetDlgItem(hwnd, LSV_CS_EXSEARCH);
    HWND hValue1 = GetDlgItem(hwnd, TXT_CS_VALUE1);
    HWND hValue2 = GetDlgItem(hwnd, TXT_CS_VALUE2);
    HWND hExEdit = GetDlgItem(hwnd, TXT_CS_EX_EDIT);
    HWND hResCount = GetDlgItem(hwnd, LBL_CS_RESCOUNT);
    HWND hProgress = GetDlgItem(hwnd, PGB_CS_PROGRESS);
    HWND hCSHeader = GetDlgItem(hwnd, HDR_CS_MENU);
	switch(message)
	{
		case WM_INITDIALOG:
        {
		    oldExSearchListProc = (WNDPROC)GetWindowLongPtr (hExSearchList, GWLP_WNDPROC);
		    SetWindowLongPtr (hExSearchList, GWLP_WNDPROC, (LONG_PTR)ExSearchListProcedure);
		    oldExListEditProc = (WNDPROC)GetWindowLongPtr (hExEdit, GWLP_WNDPROC);
		    SetWindowLongPtr (hExEdit, GWLP_WNDPROC, (LONG_PTR)ExListEditProcedure);
		    SetWindowPos(hExEdit,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
            //Search Sizes
            SendMessage(hSearchSize,CB_RESETCONTENT,0,0);
            ComboAddItem(hSearchSize, "8-Bit (1 Byte)" , 1);
            ComboAddItem(hSearchSize, "16-Bit (2 Bytes)" , 2);
            ComboAddItem(hSearchSize, "32-Bit (4 Bytes)" , 4);
            ComboAddItem(hSearchSize, "64-Bit (8 Bytes)" , 8);
            //Compare To
            SendMessage(hCompareTo,CB_RESETCONTENT,0,0);
            ComboAddItem(hCompareTo, "New Search" , 0);
            //Search Types
            SendMessage(hSearchType,CB_RESETCONTENT,0,0);
            ComboAddItem(hSearchType, "Initial Dump" , SEARCH_INIT);
            ComboAddItem(hSearchType, "I Forgot (just dump again and keep results)" , SEARCH_FORGOT);
            ComboAddItem(hSearchType, "Known Value" , SEARCH_KNOWN);
            ComboAddItem(hSearchType, "Known Value w/ Wildcards (Hex Input Only)" , SEARCH_KNOWN_WILD);
            ComboAddItem(hSearchType, "Greater Than" , SEARCH_GREATER);
            ComboAddItem(hSearchType, "Greater Than By <value>" , SEARCH_GREATER_BY);
            ComboAddItem(hSearchType, "Greater Than By At Least <value>" , SEARCH_GREATER_LEAST);
            ComboAddItem(hSearchType, "Greater Than By At Most <value>" , SEARCH_GREATER_MOST);
            ComboAddItem(hSearchType, "Less Than" , SEARCH_LESS);
            ComboAddItem(hSearchType, "Less Than By <value>" , SEARCH_LESS_BY);
            ComboAddItem(hSearchType, "Less Than By At Least <value>" , SEARCH_LESS_LEAST);
            ComboAddItem(hSearchType, "Less Than By At Most <value>" , SEARCH_LESS_MOST);
            ComboAddItem(hSearchType, "Equal To" , SEARCH_EQUAL);
            ComboAddItem(hSearchType, "Equal To # Bits" , SEARCH_EQUAL_NUM_BITS);
            ComboAddItem(hSearchType, "Not Equal To" , SEARCH_NEQUAL);
            ComboAddItem(hSearchType, "Not Equal To <value>" , SEARCH_NEQUAL_TO);
            ComboAddItem(hSearchType, "Not Equal By <value>" , SEARCH_NEQUAL_BY);
            ComboAddItem(hSearchType, "Not Equal By At Least <value>" , SEARCH_NEQUAL_LEAST);
            ComboAddItem(hSearchType, "Not Equal By At Most <value>" , SEARCH_NEQUAL_MOST);
            ComboAddItem(hSearchType, "Not Equal To # Bits" , SEARCH_NEQUAL_TO_BITS);
            ComboAddItem(hSearchType, "Not Equal By # Bits" , SEARCH_NEQUAL_BY_BITS);
            ComboAddItem(hSearchType, "In-Range" , SEARCH_IN_RANGE);
            ComboAddItem(hSearchType, "Not In-Range" , SEARCH_NOT_RANGE);
            ComboAddItem(hSearchType, "Active Bits (Any)" , SEARCH_BITS_ANY);
            ComboAddItem(hSearchType, "Active Bits (All)" , SEARCH_BITS_ALL);
            //extended search options
            SendMessage(hExSearchList,LVM_DELETEALLITEMS,0,0);
            SendMessage(hExSearchList,LVM_SETEXTENDEDLISTVIEWSTYLE,0,LVS_EX_FULLROWSELECT|LVS_EX_CHECKBOXES|LVS_EX_GRIDLINES|LVS_EX_LABELTIP);
            ListViewAddCol(hExSearchList, "Option", 0, 0x230);
            ListViewAddCol(hExSearchList, "Value1/Low", 1, 0x9A);
            ListViewAddCol(hExSearchList, "Value2/High", 2, 0x9A);
            ListViewAddCol(hExSearchList, "", 3, 0);
            char ExVal[20];
            sprintf(ExVal, "%X", EXCS_SIGNED);
            ListViewAddRow(hExSearchList,4,"Signed", "-", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_OR_EQUAL);
            ListViewAddRow(hExSearchList,4,"Or Equal To", "-", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_0);
            ListViewAddRow(hExSearchList,4,"Ignore results that are 0", "-", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_FF);
            ListViewAddRow(hExSearchList,4,"Ignore results that are FF,FFFF,etc.", "-", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_VALUE);
            ListViewAddRow(hExSearchList,4,"Ignore results that are <value>", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_IN_RANGE);
            ListViewAddRow(hExSearchList,4,"Ignore results that are in a specified value range", "0", "0", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_NOT_RANGE);
            ListViewAddRow(hExSearchList,4,"Ignore results that aren't in a specified value range", "0", "0", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_N64_POINTERS);
            ListViewAddRow(hExSearchList,4,"Ignore N64 pointers", "-", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_BYTE_VALUE);
            ListViewAddRow(hExSearchList,4,"Ignore any result that's part of a specified 8-Bit value", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_SHORT_VALUE);
            ListViewAddRow(hExSearchList,4,"Ignore any result that's part of a specified 16-Bit (aligned) value", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_WORD_VALUE);
            ListViewAddRow(hExSearchList,4,"Ignore any result that's part of a specified 32-Bit (aligned) value", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_DWORD_VALUE);
            ListViewAddRow(hExSearchList,4,"Ignore any result that's part of a specified 64-Bit (aligned) value", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_BYTE_RANGE);
            ListViewAddRow(hExSearchList,4,"Ignore any result that's part of a specified 8-Bit range", "0", "0", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_SHORT_RANGE);
            ListViewAddRow(hExSearchList,4,"Ignore any result that's part of a specified 16-Bit (aligned) range", "0", "0", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_WORD_RANGE);
            ListViewAddRow(hExSearchList,4,"Ignore any result that's part of a specified 32-Bit (aligned) range", "0", "0", ExVal);
            sprintf(ExVal, "%X", EXCS_IGNORE_DWORD_RANGE);
            ListViewAddRow(hExSearchList,4,"Ignore any result that's part of a specified 64-Bit (aligned) range", "0", "0", ExVal);
            sprintf(ExVal, "%X", EXCS_EXCLUDE_CONSEC);
            ListViewAddRow(hExSearchList,4,"Exclude results with # consecutive addresses", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_EXCLUDE_CONSEC_MATCH_VALUES);
            ListViewAddRow(hExSearchList,4,"Exclude results with # consecutive addresses and matching values", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_INCLUDE_CONSEC);
            ListViewAddRow(hExSearchList,4,"Include Only results with # consecutive addresses", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_INCLUDE_CONSEC_MATCH_VALUES);
            ListViewAddRow(hExSearchList,4,"Include Only results with # consecutive addresses and matching values", "0", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_INCLUDE_ADDRESS_RANGE);
            ListViewAddRow(hExSearchList,4,"Include Only results within specified address range (set search area)", "0", "0", ExVal);
            sprintf(ExVal, "%X", EXCS_EXCLUDE_UPPER16);
            ListViewAddRow(hExSearchList,4,"Exclude 16-bit Upper Address (0,4,8,C) results", "-", "-", ExVal);
            sprintf(ExVal, "%X", EXCS_EXCLUDE_LOWER16);
            ListViewAddRow(hExSearchList,4,"Exclude 16-bit Lower Address (2,6,A,E) results", "-", "-", ExVal);

            SetWindowText(hValue1, "0");
            SetWindowText(hValue2, "0");
            SendMessage(hValue1, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
            SendMessage(hValue2, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
            SendMessage(hExEdit, WM_SETFONT, (WPARAM)Settings.ValueHFont, TRUE);
		    oldSearchValueBoxProc = (WNDPROC)GetWindowLongPtr (hValue1, GWLP_WNDPROC);
		    SetWindowLongPtr (hValue1, GWLP_WNDPROC, (LONG_PTR)SearchValueBoxProc);
		    SetWindowLongPtr (hValue2, GWLP_WNDPROC, (LONG_PTR)SearchValueBoxProc);
            SendMessage(hSearchSize,CB_SETCURSEL,0,0);
            SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_SEARCH_SIZE, CBN_SELCHANGE),(LPARAM)hSearchSize);
            SendMessage(hCompareTo,CB_SETCURSEL,0,0);
            SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_COMPARE_TO, CBN_SELCHANGE),(LPARAM)hCompareTo);
            SendMessage(hSearchType,CB_SETCURSEL,0,0);
            SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_SEARCH_TYPE, CBN_SELCHANGE),(LPARAM)hSearchType);

            AddHeaderItem(hCSHeader, 0x50, "Options");
		    if ((hCSMenu = LoadMenu(hinstMain, MAKEINTRESOURCE(CODE_SEARCH_MENU))) == NULL) { MessageBox(NULL, "Failed to load menu", "Error", MB_OK); }
		    SetMenuItemData(hCSMenu, MNU_CS_INPUT_HEX, BASE_HEX);
		    SetMenuItemData(hCSMenu, MNU_CS_INPUT_DEC, BASE_DEC);
		    SetMenuItemData(hCSMenu, MNU_CS_INPUT_FLOAT, BASE_FLOAT);
		    SetMenuState(hCSMenu, Settings.CS.NumBaseId, MFS_CHECKED);
		    SetMenuItemText(hCSMenu, MNU_CS_DUMP_DIR, Settings.CS.DumpDir);
        } break;
		case WM_COMMAND:
        {
			switch(LOWORD(wParam))
            {
                case CMB_CS_SEARCH_SIZE:
                {
                    switch(HIWORD(wParam))
                    {
                        case CBN_SELCHANGE:
                        {
                            Search.Size = SendMessage(hSearchSize,CB_GETITEMDATA,SendMessage(hSearchSize,CB_GETCURSEL,0,0),0);
                            switch((Search.Type == SEARCH_KNOWN_WILD) ? BASE_HEX : Settings.CS.NumBase)
                            {
                                case BASE_DEC:
                                {
                                    SendMessage(hValue1, EM_SETLIMITTEXT, 31, 0);
                                    SendMessage(hValue2, EM_SETLIMITTEXT, 31, 0);
                                } break;
                                case BASE_HEX:
                                {
                                    SendMessage(hValue1, EM_SETLIMITTEXT, Search.Size*2, 0);
                                    SendMessage(hValue2, EM_SETLIMITTEXT, Search.Size*2, 0);
                                } break;
                                case BASE_FLOAT:
                                {
                                    SendMessage(hValue1, EM_SETLIMITTEXT, 32, 0);
                                    SendMessage(hValue2, EM_SETLIMITTEXT, 32, 0);
                                } break;
                            }
                        } break;
                    }
                } break;
                case CMB_CS_SEARCH_TYPE:
                {
                    switch(HIWORD(wParam))
                    {
                        case CBN_SELCHANGE:
                        {
                            Search.Type = SendMessage(hSearchType,CB_GETITEMDATA,SendMessage(hSearchType,CB_GETCURSEL,0,0),0);
                            Search.CompareTo = SendMessage(hCompareTo,CB_GETCURSEL,0,0);
                            SetWindowText(hValue1, "0");
                            SetWindowText(hValue2, "0");
                            switch(Search.Type)
                            {
                                case SEARCH_INIT:
                                {
                                    SetWindowPos(hValue1, 0, 0, 0, 0, 0, SWP_HIDEWINDOW|SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER);
                                    SetWindowPos(hValue2, 0, 0, 0, 0, 0, SWP_HIDEWINDOW|SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER);
                                    SendMessage(hCompareTo,CB_SETCURSEL,0,0);
                                    SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_COMPARE_TO, CBN_SELCHANGE),(LPARAM)hCompareTo);
                                } break;
                                case SEARCH_KNOWN: case SEARCH_KNOWN_WILD:
                                case SEARCH_GREATER_BY: case SEARCH_GREATER_LEAST: case SEARCH_GREATER_MOST:
                                case SEARCH_LESS_BY: case SEARCH_LESS_LEAST: case SEARCH_LESS_MOST:
                                case SEARCH_EQUAL_NUM_BITS: case SEARCH_NEQUAL_TO: case SEARCH_NEQUAL_BY: case SEARCH_NEQUAL_LEAST:
                                case SEARCH_NEQUAL_MOST: case SEARCH_NEQUAL_TO_BITS: case SEARCH_NEQUAL_BY_BITS:
                                case SEARCH_BITS_ANY: case SEARCH_BITS_ALL:
                                {
                                    SetWindowPos(hValue1, 0, 0, 0, 0, 0, SWP_SHOWWINDOW|SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER);
                                    SetWindowPos(hValue2, 0, 0, 0, 0, 0, SWP_HIDEWINDOW|SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER);
                                } break;
                                case SEARCH_GREATER: case SEARCH_LESS: case SEARCH_EQUAL: case SEARCH_NEQUAL:
                                {
                                    if (Search.CompareTo == 0) { MessageBox(NULL, "You can't compare without an initial dump, asshole.", "Error", MB_OK); return 0; }
                                    SetWindowPos(hValue1, 0, 0, 0, 0, 0, SWP_HIDEWINDOW|SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER);
                                    SetWindowPos(hValue2, 0, 0, 0, 0, 0, SWP_HIDEWINDOW|SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER);
                                } break;
                                case SEARCH_IN_RANGE: case SEARCH_NOT_RANGE:
                                {
                                    SetWindowPos(hValue1, 0, 0, 0, 0, 0, SWP_SHOWWINDOW|SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER);
                                    SetWindowPos(hValue2, 0, 0, 0, 0, 0, SWP_SHOWWINDOW|SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER);
                                } break;
                            }
                            SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_SEARCH_SIZE, CBN_SELCHANGE),(LPARAM)hSearchSize);
                        } break;
                    }
                } break;
			    case LSV_CS_BEGINEDIT:
			    {
			        if (lvExEditedItem.Status) { MessageBox(NULL,"Already editing. WTF? (LSV_CS_BEGINEDIT)","Error",0); break; }
			        if ((HIWORD(lParam) < 1) || (HIWORD(lParam) > 2)) { break; }
			        char txtInput[20];
			        lvExEditedItem.iItem = LOWORD(lParam);
			        lvExEditedItem.iSubItem = HIWORD(lParam);
			        RECT lvEditRect; memset(&lvEditRect,0,sizeof(RECT));
			        lvEditRect.top = lvExEditedItem.iSubItem;
			        lvEditRect.left = LVIR_LABEL;
			        SendMessage(hExSearchList, LVM_GETSUBITEMRECT, lvExEditedItem.iItem, (LPARAM)&lvEditRect);
			        Search.Size = SendMessage(hSearchSize,CB_GETITEMDATA,SendMessage(hSearchSize,CB_GETCURSEL,0,0),0);
			        u32 ExType = ListViewGetHex(hExSearchList, lvExEditedItem.iItem, 3);
			        switch(ExType)
			        {
                        case EXCS_IGNORE_VALUE: case EXCS_IGNORE_IN_RANGE:
                        {
                            SendMessage(hExEdit, EM_SETLIMITTEXT, Search.Size*2, 0);
                        } break;
                        case EXCS_IGNORE_BYTE_VALUE: case EXCS_IGNORE_BYTE_RANGE:
                        {
                            SendMessage(hExEdit, EM_SETLIMITTEXT, 2, 0);
                        } break;
                        case EXCS_IGNORE_SHORT_VALUE: case EXCS_IGNORE_SHORT_RANGE:
                        {
                            SendMessage(hExEdit, EM_SETLIMITTEXT, 4, 0);
                        } break;
                        case EXCS_IGNORE_WORD_VALUE: case EXCS_IGNORE_WORD_RANGE:
                        case EXCS_INCLUDE_ADDRESS_RANGE:
                        {
                            SendMessage(hExEdit, EM_SETLIMITTEXT, 8, 0);
                        } break;
                        case EXCS_IGNORE_DWORD_VALUE: case EXCS_IGNORE_DWORD_RANGE:
                        {
                            SendMessage(hExEdit, EM_SETLIMITTEXT, 16, 0);
                        } break;
                        case EXCS_EXCLUDE_CONSEC: case EXCS_EXCLUDE_CONSEC_MATCH_VALUES:
                        case EXCS_INCLUDE_CONSEC: case EXCS_INCLUDE_CONSEC_MATCH_VALUES:
                        {
                            if (lvExEditedItem.iSubItem == 2) { return 0; }
                            SendMessage(hExEdit, EM_SETLIMITTEXT, 4, 0);
                        } break;
			        }
			        ListViewGetText(hExSearchList, lvExEditedItem.iItem, lvExEditedItem.iSubItem, txtInput, sizeof(txtInput));
			        SetWindowText(hExEdit,txtInput);
			        WINDOWPLACEMENT lvPlace; memset(&lvPlace,0,sizeof(WINDOWPLACEMENT));
			        lvPlace.length = sizeof(WINDOWPLACEMENT);
			        GetWindowPlacement(hExSearchList, &lvPlace);
			        POINT lvPos;
			        lvPos.x = lvPlace.rcNormalPosition.left;
			        lvPos.y = lvPlace.rcNormalPosition.top;
			        SetWindowPos(hExEdit,HWND_TOP,lvPos.x+lvEditRect.left+3,lvPos.y+lvEditRect.top+1,(lvEditRect.right-lvEditRect.left),(lvEditRect.bottom-lvEditRect.top)+1,SWP_SHOWWINDOW);
			        SetFocus(hExEdit);
			        SendMessage(hExEdit, EM_SETSEL, 0, -1);
			        lvExEditedItem.Status = 1;
			    } break;
			    case LSV_CS_ENDEDIT:
                {
                    if ((!lvExEditedItem.Status) || (!lParam)) {
                        lvExEditedItem.Status = 0;
                        SetWindowPos(hExEdit,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
                        SetFocus(hExSearchList); break;
                    }
			        char txtValue[20];
			        if (isHexWindow(hExEdit)) { GetWindowText(hExEdit, txtValue, sizeof(txtValue)); }
			        else { strcpy(txtValue, "0"); }
			        ListViewSetRow(hExSearchList, lvExEditedItem.iItem, lvExEditedItem.iSubItem, 1, txtValue);
                    lvExEditedItem.Status = 0;
                    SetWindowPos(hExEdit,HWND_BOTTOM,0,0,0,0,SWP_HIDEWINDOW);
                    SetFocus(hExSearchList);
			    } break;
			    case CMD_CS_QUICK_INIT:
			    {
                    ComboSelFromData(hSearchType, SEARCH_INIT);
			        SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_SEARCH_TYPE, CBN_SELCHANGE),(LPARAM)hSearchType);
			        SendMessage(hwnd, WM_COMMAND, CMD_CS_SEARCH, 0);
			    } break;
			    case CMD_CS_QUICK_EQUAL:
			    {
                    ComboSelFromData(hSearchType, SEARCH_EQUAL);
			        SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_SEARCH_TYPE, CBN_SELCHANGE),(LPARAM)hSearchType);
			        SendMessage(hwnd, WM_COMMAND, CMD_CS_SEARCH, 0);
			    } break;
			    case CMD_CS_QUICK_NOTEQUAL:
			    {
                    ComboSelFromData(hSearchType, SEARCH_NEQUAL);
			        SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_SEARCH_TYPE, CBN_SELCHANGE),(LPARAM)hSearchType);
			        SendMessage(hwnd, WM_COMMAND, CMD_CS_SEARCH, 0);
			    } break;
			    case CMD_CS_QUICK_GREATER:
			    {
                    ComboSelFromData(hSearchType, SEARCH_GREATER);
			        SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_SEARCH_TYPE, CBN_SELCHANGE),(LPARAM)hSearchType);
			        SendMessage(hwnd, WM_COMMAND, CMD_CS_SEARCH, 0);
			    } break;
			    case CMD_CS_QUICK_LESS:
			    {
                    ComboSelFromData(hSearchType, SEARCH_LESS);
			        SendMessage(hwnd, WM_COMMAND, MAKEWPARAM(CMB_CS_SEARCH_TYPE, CBN_SELCHANGE),(LPARAM)hSearchType);
			        SendMessage(hwnd, WM_COMMAND, CMD_CS_SEARCH, 0);
			    } break;
			    case CMD_CS_DUMP:
			    {
                    if (!DoFileSave(hwnd, RamInfo.NewResultsInfo.dmpFileName)) { break; }
                    if (!(RamInfo.NewResultsInfo.DumpSize = DumpRAM(RamInfo.NewResultsInfo.dmpFileName))) { break; }
                    FreeRamInfo();
			    } break;
			    case CMD_CS_LOAD:
                {
                    char ResFileName[MAX_PATH];
                    if (!DoFileOpen(hwnd, RamInfo.NewResultsInfo.dmpFileName)) { break; }
                    if (!(LoadStruct(&RamInfo.OldResultsInfo, sizeof(CODE_SEARCH_RESULTS_INFO), RamInfo.NewResultsInfo.dmpFileName))) { break; }
                    if (!(LoadFile(&RamInfo.Results, RamInfo.NewResultsInfo.dmpFileName, sizeof(CODE_SEARCH_RESULTS_INFO), NULL, FALSE))) { break; }
                    sprintf(ResFileName, "%ssearch1.bin", Settings.CS.DumpDir);
                    sprintf(RamInfo.NewResultsInfo.dmpFileName, "%sram1.bin", Settings.CS.DumpDir);
                    sprintf(RamInfo.NewResultsInfo.MapFileName, "%sram1.map", Settings.CS.DumpDir);
                    rename (RamInfo.NewResultsInfo.dmpFileName, RamInfo.OldResultsInfo.dmpFileName);
                    if (RamInfo.OldResultsInfo.Mapped) { rename (RamInfo.NewResultsInfo.MapFileName, RamInfo.OldResultsInfo.MapFileName); }
                    SaveFile(RamInfo.Results, (RamInfo.OldResultsInfo.DumpSize/Search.Size/8), ResFileName, sizeof(CODE_SEARCH_RESULTS_INFO), &RamInfo.OldResultsInfo);
                    SendMessage(hCompareTo,CB_RESETCONTENT,0,0);
                    ComboAddItem(hCompareTo, "New Search" , 0);
                    ComboAddItem(hCompareTo, "Search 1" , 0);
                    SendMessage(hCompareTo,CB_SETCURSEL,1,0);
                    SetDecWindowU(hResCount, RamInfo.OldResultsInfo.ResCount);
                    FreeRamInfo();
                } break;
                case CMD_CS_UNDO:
                {
                    Search.Count = SendMessage(hCompareTo,CB_GETCOUNT,0,0);
                    if (Search.Count <= 1) { break; }
                    if (Search.Count > 2) {
                        sprintf(RamInfo.NewResultsInfo.dmpFileName, "%ssearch%u.bin", Settings.CS.DumpDir, Search.Count - 2);
                        if (!(LoadStruct(&RamInfo.OldResultsInfo, sizeof(CODE_SEARCH_RESULTS_INFO), RamInfo.NewResultsInfo.dmpFileName))) { break; }
                        SetDecWindowU(hResCount, RamInfo.OldResultsInfo.ResCount);
                    } else { SetDecWindowU(hResCount, 0); }
                    SendMessage(hCompareTo, CB_DELETESTRING, Search.Count - 1, 0);
                    SendMessage(hCompareTo, CB_SETCURSEL, Search.Count - 2,0);
                    FreeRamInfo();
                } break;
			    case CMD_CS_SEARCH:
			    {
                    memset(&Search,0,sizeof(CODE_SEARCH_VARS));
                    FreeRamInfo();
                    Search.Size = SendMessage(hSearchSize,CB_GETITEMDATA,SendMessage(hSearchSize,CB_GETCURSEL,0,0),0);
                    Search.Type = SendMessage(hSearchType,CB_GETITEMDATA,SendMessage(hSearchType,CB_GETCURSEL,0,0),0);
                    Search.CompareTo = SendMessage(hCompareTo,CB_GETCURSEL,0,0);
                    Search.Count = SendMessage(hCompareTo,CB_GETCOUNT,0,0);
                    if (Search.CompareTo == 0) { Search.Count = 1; }
                    int i;
                    char txtValue[17];
                    switch(Search.Type)
                    {
                        case SEARCH_INIT:
                        {
                            Search.CompareTo = 0;
                            Search.Count = 1;
                        } break;
                        case SEARCH_KNOWN_WILD:
                        {
                            GetWindowText(hValue1, txtValue, sizeof(txtValue));
                            Search.Values[1] = 0xFFFFFFFFFFFFFFFFLL;
                            for (i = 0; i < strlen(txtValue); i++) {
                                if (txtValue[i] == '*') {
                                    Search.Values[1] &= ~((u64)0xF << ((strlen(txtValue) - i - 1) * 4));
                                    txtValue[i] = '0';
                                }
                            }
                            String2Hex(txtValue,&Search.Values[0]);
                        } break;
                        case SEARCH_KNOWN:
                        case SEARCH_GREATER_BY: case SEARCH_GREATER_LEAST: case SEARCH_GREATER_MOST:
                        case SEARCH_LESS_BY: case SEARCH_LESS_LEAST: case SEARCH_LESS_MOST:
                        case SEARCH_EQUAL_NUM_BITS: case SEARCH_NEQUAL_TO: case SEARCH_NEQUAL_BY: case SEARCH_NEQUAL_LEAST:
                        case SEARCH_NEQUAL_MOST: case SEARCH_NEQUAL_TO_BITS: case SEARCH_NEQUAL_BY_BITS:
                        case SEARCH_BITS_ANY: case SEARCH_BITS_ALL:
                        case SEARCH_IN_RANGE: case SEARCH_NOT_RANGE:
                        {
                            switch((Search.Type & (SEARCH_EQUAL_NUM_BITS|SEARCH_NEQUAL_TO_BITS|SEARCH_NEQUAL_BY_BITS|SEARCH_BITS_ANY|SEARCH_BITS_ALL)) &&
                            (Settings.CS.NumBase == BASE_FLOAT) ? BASE_HEX : Settings.CS.NumBase)
                            {
                                case BASE_HEX:
                                {
                                    Search.Values[0] = GetHexWindow(hValue1);
                                    Search.Values[1] = GetHexWindow(hValue2);
                                } break;
                                case BASE_DEC:
                                {
                                    Search.Values[0] = GetDecWindow(hValue1);
                                    Search.Values[1] = GetDecWindow(hValue2);
                                } break;
                                case BASE_FLOAT:
                                {
                                    Search.Values[0] = GetFloatWindow(hValue1, Search.Size);
                                    Search.Values[1] = GetFloatWindow(hValue2, Search.Size);
                                } break;
                            }
                        } break;
                        case SEARCH_GREATER: case SEARCH_LESS: case SEARCH_EQUAL: case SEARCH_NEQUAL:
                        {
                            if ((Search.Count == 1) || (Search.CompareTo == 0)) { MessageBox(NULL, "You can't compare without an initial dump, asshole.", "Error", MB_OK); return 0; }
                        } break;
                    }
                    int exCount = SendMessage(hExSearchList, LVM_GETITEMCOUNT, 0, 0);
                    for (i = 0; i < exCount; i++) {
                        if (ListView_GetCheckState(hExSearchList, i)) {
                            Search.TypeEx |= ListViewGetHex(hExSearchList, i, 3);
                            SetExValues(&Search, ListViewGetHex(hExSearchList, i, 3), ListViewGetHex(hExSearchList, i, 1), ListViewGetHex(hExSearchList, i, 2));
                        }
                    }
                    if (Search.Count > MAX_SEARCHES) { MessageBox(NULL,"Holy fuck! 100 searches? If you didn't find the code by now, give it up.","Error",MB_OK); break; }
                    if (Settings.Hook.SearchAccess == SEARCH_ACCESS_AUTO) {
						//WTF?
                        RamInfo.Access = (Settings.Hook.AllRam == BST_CHECKED) ? SEARCH_ACCESS_FILE : SEARCH_ACCESS_ARRAY;
                    } else { RamInfo.Access = Settings.Hook.SearchAccess; }
                    char sdFileName[MAX_PATH];

                    if (Search.CompareTo) {
                        sprintf(sdFileName, "%ssearch%u.bin", Settings.CS.DumpDir, Search.CompareTo);
                        if (!(LoadStruct(&RamInfo.OldResultsInfo, sizeof(CODE_SEARCH_RESULTS_INFO), sdFileName))) { break; }
                        if (!(LoadFile(&RamInfo.Results, sdFileName, sizeof(CODE_SEARCH_RESULTS_INFO), NULL, FALSE))) { break; }
                    }
                    sprintf(RamInfo.NewResultsInfo.dmpFileName, "%sram%u.bin", Settings.CS.DumpDir, Search.Count);
                    RamInfo.NewResultsInfo.Endian = Settings.Hook.Endian;
                    RamInfo.NewResultsInfo.SearchSize = Search.Size;
                    if (Settings.Hook.HookType == HOOK_PROCESS) {
                        sprintf(RamInfo.NewResultsInfo.MapFileName, "%sram%u.map", Settings.CS.DumpDir, Search.Count);
                        if (!(RamInfo.NewResultsInfo.DumpSize = DumpRAM())) { break; }
                    } else {
                        if (!DoFileOpen(hwnd, RamInfo.NewResultsInfo.dmpFileName)) { break; }
                        RamInfo.NewFile = fopen(RamInfo.NewResultsInfo.dmpFileName, "rb");
                        if (!(RamInfo.NewFile)) {
                            sprintf(ErrTxt, "Unable to open ram dump (CMD_CS_SEARCH,1) -- Error %u", GetLastError());
                            MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
                        }
                        fseek(RamInfo.NewFile,0,SEEK_END);
                        RamInfo.NewResultsInfo.DumpSize = ftell(RamInfo.NewFile);
                        fclose(RamInfo.NewFile);
                    }
                    if (!Search.CompareTo) {
                        Search.Count = 1;
                        SendMessage(hCompareTo,CB_RESETCONTENT,0,0);
                        ComboAddItem(hCompareTo, "New Search" , 0);
                        SendMessage(hCompareTo,CB_SETCURSEL,0,0);
                        sprintf(sdFileName, "%ssearch%u.bin", Settings.CS.DumpDir, Search.Count);
                        if (!(RamInfo.Results = (unsigned char*)malloc(RamInfo.NewResultsInfo.DumpSize/Search.Size/8))) {
                            sprintf(ErrTxt, "Unable to allocate results memory (CMD_CS_SEARCH, 1) -- Error %u", GetLastError());
                            MessageBox(NULL, ErrTxt, "Error", MB_OK); return 0;
                        }
                        memset(RamInfo.Results, 0xFF, (RamInfo.NewResultsInfo.DumpSize/Search.Size/8));
                        if (!(SaveFile(RamInfo.Results, (RamInfo.NewResultsInfo.DumpSize/Search.Size/8), sdFileName, sizeof(CODE_SEARCH_RESULTS_INFO), &RamInfo.NewResultsInfo))) { break; }
                    }

                    sprintf(sdFileName, "Search %u", Search.Count);
                    ComboAddItem(hCompareTo, sdFileName , Search.Count);
                    SendMessage(hCompareTo,CB_SETCURSEL,Search.Count,0);
                    if (Search.Type == SEARCH_INIT) {
                        SetDecWindowU(hResCount, RamInfo.NewResultsInfo.DumpSize/Search.Size);
                        FreeRamInfo();
                        break;
                    }
                    if (Search.Type == SEARCH_FORGOT) {
                        if (!Search.CompareTo) {
                            MessageBox(NULL, "No previous results. You apparently forgot to start a search at all, you fuckin idiot. Try again.", "Error", MB_OK);
                            break;
                        }
                        sprintf(sdFileName, "%ssearch%u.bin", Settings.CS.DumpDir, Search.Count);
                        SaveFile(RamInfo.Results, (RamInfo.NewResultsInfo.DumpSize/Search.Size/8), sdFileName, sizeof(CODE_SEARCH_RESULTS_INFO), &RamInfo.NewResultsInfo);
                        FreeRamInfo();
                        break;
                    }
                    if (RamInfo.Access == SEARCH_ACCESS_ARRAY) {
                        if (!(LoadFile(&RamInfo.NewRAM, RamInfo.NewResultsInfo.dmpFileName, 0, NULL, FALSE))) { break; }
                        if (Search.CompareTo) {
                            if (!LoadFile(&RamInfo.OldRAM, RamInfo.OldResultsInfo.dmpFileName, 0, NULL, FALSE)) { return 0; }
                        }
                    } else {
                        RamInfo.NewFile = fopen(RamInfo.NewResultsInfo.dmpFileName, "rb");
                        if (!(RamInfo.NewFile)) {
                            sprintf(ErrTxt, "Unable to open ram dump (CMD_CS_SEARCH,2) -- Error %u", GetLastError());
                            MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
                        }
                        if (Search.CompareTo) {
                            RamInfo.OldFile = fopen(RamInfo.OldResultsInfo.dmpFileName, "rb");
                            if (!(RamInfo.OldFile)) {
                                sprintf(ErrTxt, "Unable to open ram dump (CMD_CS_SEARCH,3) -- Error %u", GetLastError());
                                MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
                            }
                        }
                    }
                    if ((RamInfo.OldResultsInfo.DumpSize > 0) && (RamInfo.OldResultsInfo.DumpSize != RamInfo.NewResultsInfo.DumpSize)) {
                        MessageBox(NULL, "RAM dumps don't match in size. Are you trying to compare files of different size?", "Error", MB_OK);
                        return 0;
                    }
                    SendMessage(hProgress, PBM_SETRANGE, 0, MAKELPARAM(0, (RamInfo.NewResultsInfo.DumpSize/0x100000)+((RamInfo.NewResultsInfo.DumpSize % 0x100000) ? 1:0)));
                    SendMessage(hProgress, PBM_SETSTEP, 1, 0);
                    CodeSearch(Search, hProgress);
                    sprintf(sdFileName, "%ssearch%u.bin", Settings.CS.DumpDir, Search.Count);
                    SaveFile(RamInfo.Results, (RamInfo.NewResultsInfo.DumpSize/Search.Size/8), sdFileName, sizeof(CODE_SEARCH_RESULTS_INFO), &RamInfo.NewResultsInfo);
                    SetDecWindowU(hResCount, RamInfo.NewResultsInfo.ResCount);
                    FreeRamInfo();
//sprintf(ErrTxt, "%u", RamInfo.NewResultsInfo.ResCount);
//MessageBox(NULL,ErrTxt,"Error",0);
			    } break;
			    case MNU_CS_INPUT_HEX: case MNU_CS_INPUT_DEC: case MNU_CS_INPUT_FLOAT:
                {
                    Settings.CS.NumBase = GetMenuItemData(hCSMenu, LOWORD(wParam));
                    Settings.CS.NumBaseId = LOWORD(wParam);
                    SetMenuState(hCSMenu, MNU_CS_INPUT_HEX, MFS_UNCHECKED);
                    SetMenuState(hCSMenu, MNU_CS_INPUT_DEC, MFS_UNCHECKED);
                    SetMenuState(hCSMenu, MNU_CS_INPUT_FLOAT, MFS_UNCHECKED);
                    SetMenuState(hCSMenu, LOWORD(wParam), MFS_CHECKED);
                } break;
			    case MNU_CS_SET_DUMP_DIR:
			    {
                    char DumpPath[MAX_PATH];
                    if (BrowseForFolder(hwnd, DumpPath)) {
                        strcpy(Settings.CS.DumpDir, DumpPath);
                        SetMenuItemText(hCSMenu, MNU_CS_DUMP_DIR, Settings.CS.DumpDir);
                    }
			    } break;
            }
        } break;
        case WM_NOTIFY:
        {
            switch(LOWORD(wParam))
			{
			    case HDR_CS_MENU:
			    {
                    NMHEADER *hdInfo = (LPNMHEADER)lParam;
                    if (hdInfo->hdr.code == HDN_ITEMCLICK) {
                        HMENU hSubMenu;
                        POINT pt;
                        RECT hdRect;
                        SendMessage(hCSHeader, HDM_GETITEMRECT, hdInfo->iItem, (LPARAM)&hdRect);
                        pt.x = hdRect.left;
                        pt.y = hdRect.bottom;
                        ClientToScreen (hwnd, &pt);
                        hSubMenu = GetSubMenu(hCSMenu, hdInfo->iItem);
                        TrackPopupMenu(hSubMenu, TPM_LEFTALIGN | TPM_LEFTBUTTON, pt.x, pt.y+2, 0, hwnd, NULL);
                    }
                } break;
            }
        } break;
	}
	return FALSE;
}

/********************************
Extended Search Options ListView handler
*********************************/
LRESULT CALLBACK ExSearchListProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case WM_VSCROLL: case WM_MOUSEWHEEL:
        {
            if (lvExEditedItem.Status) { SendMessage(hTabDlgs[CODE_SEARCH_TAB], WM_COMMAND, LSV_CS_ENDEDIT, 0); }
        } break;
        case WM_LBUTTONUP:
        {
            int iSelected = ListViewHitTst(hwnd, GetMessagePos(), -1);
            if (iSelected < 0) { break; }
            if (!ListView_GetCheckState(hwnd, iSelected)) { break; }
            if (!(ListViewGetHex(hwnd, iSelected, 3) & (EXCS_EXCLUDE_CONSEC|EXCS_INCLUDE_CONSEC|EXCS_EXCLUDE_CONSEC_MATCH_VALUES|EXCS_INCLUDE_CONSEC_MATCH_VALUES))) { break; }
            int i, x = 0;
            int exCount = SendMessage(hwnd, LVM_GETITEMCOUNT, 0, 0);
            for (i = 0; i < exCount; i++) {
                if ((ListView_GetCheckState(hwnd, i)) && (ListViewGetHex(hwnd, i, 3) &
                    (EXCS_EXCLUDE_CONSEC|EXCS_INCLUDE_CONSEC|EXCS_EXCLUDE_CONSEC_MATCH_VALUES|EXCS_INCLUDE_CONSEC_MATCH_VALUES))) {
                        x++;
                }
            }
            if (x > 1) {
                ListView_SetCheckState(hwnd, iSelected, FALSE);
                MessageBox(NULL, "Only 1 Consecutive/Matching Results option can be used at a time.", "Error", MB_OK);
            }
        } break;
        case WM_LBUTTONDBLCLK:
        {
            if (lvExEditedItem.Status) { SendMessage(hTabDlgs[CODE_SEARCH_TAB], WM_COMMAND, LSV_CS_ENDEDIT, 0); }
            int iSelected = SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0);
            if (iSelected < 0) { break; }
            int iSubItem = ListViewHitTst(hwnd, GetMessagePos(), iSelected);
            u32 ExType = ListViewGetHex(hwnd, iSelected, 3);
            if (ExType & (EXCS_SIGNED|EXCS_OR_EQUAL|EXCS_IGNORE_0|EXCS_IGNORE_FF|EXCS_IGNORE_N64_POINTERS)) { break; }
            if ((ExType & (EXCS_IGNORE_VALUE|EXCS_IGNORE_BYTE_VALUE|EXCS_IGNORE_SHORT_VALUE|EXCS_IGNORE_WORD_VALUE|EXCS_IGNORE_DWORD_VALUE|EXCS_EXCLUDE_CONSEC|EXCS_EXCLUDE_CONSEC_MATCH_VALUES|EXCS_INCLUDE_CONSEC|EXCS_INCLUDE_CONSEC_MATCH_VALUES)) && (iSubItem == 2)) { break; }
            SendMessage(hTabDlgs[CODE_SEARCH_TAB], WM_COMMAND, LSV_CS_BEGINEDIT, MAKELPARAM(iSelected, iSubItem));
        } return 0;
        case WM_NOTIFY:
        {
                if (((NMHDR*)lParam)->code == HDN_BEGINTRACKW) { return TRUE; }
                if (((NMHDR*)lParam)->code == HDN_BEGINTRACKA) { return TRUE; }
        } break;
    }
	if (oldExSearchListProc) { return CallWindowProc (oldExSearchListProc, hwnd, message, wParam, lParam); }
	else { return DefWindowProc (hwnd, message, wParam, lParam); }
}

/********************************
Extended Search Options - Listview editbox handler
*********************************/
LRESULT CALLBACK ExListEditProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
//    HWND hListData = GetDlgItem(hTabDlgs[CODE_SEARCH_TAB], LSV_CS_EXSEARCH);
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
            SendMessage(hTabDlgs[CODE_SEARCH_TAB], WM_COMMAND, LSV_CS_ENDEDIT, 0);
        } return 0;
        case WM_KEYDOWN:
        {
            if (wParam == VK_RETURN) { SendMessage(hTabDlgs[CODE_SEARCH_TAB], WM_COMMAND, LSV_CS_ENDEDIT, 1); }
            if (wParam == VK_ESCAPE) { SendMessage(hTabDlgs[CODE_SEARCH_TAB], WM_COMMAND, LSV_CS_ENDEDIT, 0); }
            if (wParam == VK_F3) {
                if (lvExEditedItem.iSubItem == 1) {
                    SendMessage(hTabDlgs[CODE_SEARCH_TAB], WM_COMMAND, LSV_CS_ENDEDIT, 0);
                    SendMessage(hTabDlgs[CODE_SEARCH_TAB], WM_COMMAND, LSV_CS_BEGINEDIT, MAKELPARAM(lvExEditedItem.iItem, lvExEditedItem.iSubItem + 1));
                }
            }
        } break;
    }
	if (oldExListEditProc) { return CallWindowProc (oldExListEditProc, hwnd, message, wParam, lParam); }
	else { return DefWindowProc (hwnd, message, wParam, lParam); }
}

/********************************
Search Value box handler
*********************************/
LRESULT CALLBACK SearchValueBoxProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case WM_CHAR:
        {
            if ((wParam == VK_BACK) || (wParam == 24) || (wParam == 3) || (wParam == 22)) { break; } //cut/copy/paste/backspace
            if (wParam == 1) { SendMessage(hwnd, EM_SETSEL, 0, -1); } //select all
            HWND hSearchType = GetDlgItem(hTabDlgs[CODE_SEARCH_TAB], CMB_CS_SEARCH_TYPE);
            Search.Type = SendMessage(hSearchType,CB_GETITEMDATA,SendMessage(hSearchType,CB_GETCURSEL,0,0),0);
            if ((Search.Type & SEARCH_KNOWN_WILD) && (wParam == 42)) { break; } //asterisk
            switch ((Search.Type & (SEARCH_KNOWN_WILD|SEARCH_EQUAL_NUM_BITS|SEARCH_NEQUAL_TO_BITS|SEARCH_NEQUAL_BY_BITS|SEARCH_BITS_ANY|SEARCH_BITS_ALL)) ?
            BASE_HEX : Settings.CS.NumBase)
            {
                case BASE_HEX: { wParam = FilterHexChar(wParam); } break;
                case BASE_DEC: { wParam = ((isdigit(wParam))|| (wParam == '-')) ? wParam : 0; } break;
                case BASE_FLOAT: { wParam = (isdigit(wParam) || (wParam == '.') || (wParam == '-')) ? wParam : 0; } break;
            }
        } break;
        case WM_PASTE:
        {
            char txtInput[20], txtInput2[20];
            GetWindowText(hwnd, txtInput, sizeof(txtInput));
            CallWindowProc (wpHexEditBoxes, hwnd, message, wParam, lParam);
            GetWindowText(hwnd, txtInput2, sizeof(txtInput2));
            if ((!isHexWindow(hwnd)) || (strlen(txtInput2) > SendMessage(hwnd, EM_GETLIMITTEXT, 0, 0))) { SetWindowText(hwnd, txtInput); }
        } return 0;
        default:
        {
            if (oldSearchValueBoxProc) {
                return CallWindowProc (oldSearchValueBoxProc, hwnd, message, wParam, lParam);
            } else { return DefWindowProc (hwnd, message, wParam, lParam); }
        }
   }
   return CallWindowProc (oldSearchValueBoxProc, hwnd, message, wParam, lParam);
}

