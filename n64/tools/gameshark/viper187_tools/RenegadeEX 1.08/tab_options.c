#include "main.h"

//need font picking

BOOL CALLBACK OptionsProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    HWND hBaseDec = GetDlgItem(hwnd, OPT_SETT_DEC);
    HWND hBaseHex = GetDlgItem(hwnd, OPT_SETT_HEX);
    HWND hBaseFloat = GetDlgItem(hwnd, OPT_SETT_FLOAT);
    HWND hDumpDir = GetDlgItem(hwnd, TXT_SETT_DUMP_DIR);
    HWND hResWrite = GetDlgItem(hwnd, CMB_SETT_RES_WRITE);
	switch(message)
	{
		case WM_INITDIALOG:
        {
            SendMessage(hBaseDec,BM_SETCHECK, (Settings.CS.NumBase == BASE_DEC) ? BST_CHECKED : BST_UNCHECKED,0);
            SendMessage(hBaseHex,BM_SETCHECK, (Settings.CS.NumBase == BASE_HEX) ? BST_CHECKED : BST_UNCHECKED,0);
            SetWindowText(hDumpDir, Settings.CS.DumpDir);
            SendMessage(hResWrite,CB_RESETCONTENT,0,0);
            ComboAddItem(hResWrite, "0ms" , 0);
            ComboAddItem(hResWrite, "100ms" , 100);
            ComboAddItem(hResWrite, "500ms" , 500);
            ComboAddItem(hResWrite, "1 Second" , 1000);
            ComboAddItem(hResWrite, "10 Seconds" , 10000);
            ComboAddItem(hResWrite, "30 Seconds" , 30000);
            ComboAddItem(hResWrite, "1 Minute" , 60000);
            ComboSelFromData(hResWrite, Settings.Results.ResWriteRate);
        } break;
		case WM_COMMAND:
        {
			switch(LOWORD(wParam))
            {
                case OPT_SETT_DEC:
                {
                    Settings.CS.NumBase = BASE_DEC;
				} break;
                case OPT_SETT_HEX:
                {
                    Settings.CS.NumBase = BASE_HEX;
				} break;
                case OPT_SETT_FLOAT:
                {
                    Settings.CS.NumBase = BASE_FLOAT;
				} break;
			    case CMD_SETT_DUMP_DIR:
			    {
                    char DumpPath[MAX_PATH];
                    if (BrowseForFolder(hwnd, DumpPath)) {
                        strcpy(Settings.CS.DumpDir, DumpPath);
                        SetWindowText(hDumpDir, Settings.CS.DumpDir);
                    }
			    } break;
            }
        } break;
        case WM_SHOWWINDOW:
        {
            if (wParam == FALSE) {
                Settings.Results.ResWriteRate = SendMessage(hResWrite,CB_GETITEMDATA,SendMessage(hResWrite,CB_GETCURSEL,0,0), 0);
            }
        } break;
	}
	return FALSE;
}

