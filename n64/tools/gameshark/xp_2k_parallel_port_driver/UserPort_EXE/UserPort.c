#include <windows.h>
#include <string.h>
#include "resource.h"

char szDriverFileName[MAX_PATH];
char DriverName[]="UserPort";
HWND hDlg;

unsigned Chars2Hex (char ch, unsigned oldval)
{
	int nHex;

	if ((ch>='0') && (ch<='9'))
		nHex=ch-'0';
	else if ((ch>='a') && (ch<='f'))
		nHex=ch-'a'+10;
	else if ((ch>='A') && (ch<='F'))
		nHex=ch-'A'+10;
	else
		return oldval;
	return oldval*16+nHex;
}

void UpperString(char *Str)
{
	int i,Len;

	Len=strlen(Str);
	for (i=0;i<Len;i++)
		if (Str[i]>'Z')
			Str[i]-=32;
}

BOOL StopDriver()
{
  SC_HANDLE  schService;
  SC_HANDLE   schSCManager;
  SERVICE_STATUS  serviceStatus;


  schSCManager = OpenSCManager (NULL,                 // machine (NULL == local)
                                NULL,                 // database (NULL == default)
                                SC_MANAGER_ALL_ACCESS // access required
                                );
  if (schSCManager == NULL)
  {
    return FALSE;
  }

  schService = OpenService (schSCManager,
                            DriverName,
                            SERVICE_ALL_ACCESS
                            );

  if (schService == NULL)
  {
	  CloseServiceHandle (schSCManager);
    return FALSE;
  }

  ControlService (schService, SERVICE_CONTROL_STOP, &serviceStatus);

  DeleteService (schService);

  CloseServiceHandle (schService);
  CloseServiceHandle (schSCManager);
	return TRUE;
}

BOOL StartDriver()
{
  SC_HANDLE  schService = NULL;
  SC_HANDLE   schSCManager;
  HANDLE   hDriver;
	DWORD LastError;
	char szMess[300];
	char szTmp[MAX_PATH];

	lstrcpy(szTmp,szDriverFileName);
	szTmp[12] = '\0';
	if (lstrcmpi(szTmp,"\\SystemRoot\\")==0)
	{
		GetWindowsDirectory(szTmp,sizeof(szTmp));
		lstrcat(szTmp,szDriverFileName+11);
	}
	else
		lstrcpy(szTmp,szDriverFileName);


  hDriver = CreateFile (szTmp,
                        GENERIC_READ,
                        0,
                        NULL,
                        OPEN_EXISTING,
                        FILE_ATTRIBUTE_NORMAL,
                        NULL
                        );
	if (hDriver==INVALID_HANDLE_VALUE)
	{
		wsprintf(szMess,"Driver does not exist:\r\n%s",szTmp);
    MessageBox(hDlg,szMess,"UserPort",MB_OK);
		return FALSE;
	}

	CloseHandle(hDriver);

  schSCManager = OpenSCManager (NULL,                 // machine (NULL == local)
                                NULL,                 // database (NULL == default)
                                SC_MANAGER_ALL_ACCESS // access required
                                );

  if (schSCManager == NULL)
  {
    if (GetLastError()	==	ERROR_ACCESS_DENIED)
      MessageBox(hDlg,"You are not authorized to install drivers.\r\nPlase contact your administrator.","UserPort",MB_OK);
		else
      MessageBox(hDlg,"Unable to start driver!","UserPort",MB_OK);

		return FALSE;
  }

  schService = CreateService (schSCManager,          // SCManager database
                              DriverName,           // name of service
                              DriverName,           // name to display
                              SERVICE_START,//SERVICE_ALL_ACCESS,    // desired access
                              SERVICE_KERNEL_DRIVER, // service type
                              SERVICE_SYSTEM_START,  // start type
                              SERVICE_ERROR_NORMAL,  // error control type
                              szDriverFileName,            // service's binary
                              NULL,                  // no load ordering group
                              NULL,                  // no tag identifier
                              NULL,                  // no dependencies
                              NULL,                  // LocalSystem account
                              NULL                   // no password
                              );

  if (schService == NULL)
  {
		LastError = GetLastError();
    if (LastError == ERROR_SERVICE_EXISTS)
      MessageBox(hDlg,"Driver already started!","UserPort",MB_OK);
    else if (LastError	==	ERROR_ACCESS_DENIED)
      MessageBox(hDlg,"You are not authorized to install drivers.\r\nPlase contact your administrator.","UserPort",MB_OK);
		else
      MessageBox(hDlg,"Unable to start driver!","UserPort",MB_OK);

		CloseServiceHandle (schSCManager);
		return FALSE;
  }

  StartService (schService,    // service identifier
                0,             // number of arguments
                NULL           // pointer to arguments
                );

  CloseServiceHandle (schService);
  CloseServiceHandle (schSCManager);
	return TRUE;
}

BOOL GetStartAndStopAddress(char *szStr, unsigned *nStartAddress, unsigned *nStopAddress)
{
	unsigned i, nStart = 0, nStop = 0;

	for (i=0;(szStr[i]!='\0')&&(szStr[i]!='-');i++)
		nStart = Chars2Hex(szStr[i], nStart);

	if (szStr[i]=='\0')
		return FALSE;

	for (i++;(szStr[i]!='\0')&&(szStr[i]!='-');i++)
		nStop = Chars2Hex(szStr[i], nStop);

	*nStartAddress = nStart;
	*nStopAddress = nStop;

	if (nStop < nStart)
		return FALSE;
	if (nStop > 0x3ff)
		return FALSE;

	return TRUE;
}

BOOL AddAUMPBtn()
{
	char szTemp[256];
	char szTemp2[256];
	unsigned nStartAddress,nStopAddress;

	GetDlgItemText(hDlg,IDC_AUMP_EDIT_ADD,szTemp,sizeof(szTemp));

	if (!GetStartAndStopAddress(szTemp, &nStartAddress, &nStopAddress))
	{
    MessageBox(hDlg,"Wrong syntax. Use: \"startadress - stopaddress\" (000 - 3ff)","UserPort",MB_OK);
		return FALSE;
	}

	wsprintf(szTemp2,"%X - %X",nStartAddress,nStopAddress);
	SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)szTemp2);
	SetDlgItemText(hDlg,IDC_AUMP_EDIT_ADD,"");
	return TRUE;
}

BOOL AddTCFBtn()
{
	char szTemp[256];
	char szTemp2[256];
	unsigned nStartAddress,nStopAddress;

	GetDlgItemText(hDlg,IDC_TCF_EDIT_ADD,szTemp,sizeof(szTemp));

	if (!GetStartAndStopAddress(szTemp, &nStartAddress, &nStopAddress))
	{
    MessageBox(hDlg,"Wrong syntax. Use: \"startadress - stopaddress\" (000 - 3ff)","UserPort",MB_OK);
		return FALSE;
	}

	wsprintf(szTemp2,"%X - %X",nStartAddress,nStopAddress);
	SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)szTemp2);
	SetDlgItemText(hDlg,IDC_TCF_EDIT_ADD,"");
	return TRUE;
}

BOOL UpdateBtn()
{
  HKEY hKey;
  DWORD wType;
	UCHAR AllProcessesIOPM[0x80];
	UCHAR ThroughCreateFileIOPM[0x80];
	unsigned  nCount,i,j;
	char szTemp[256];
	unsigned nStartAddress,nStopAddress;

	for (i=0;i<sizeof(AllProcessesIOPM);i++)
		AllProcessesIOPM[i] = 0xff;

	nCount = SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_GETCOUNT, 0,0);

	for (i=0;i<nCount;i++)
	{
		SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_GETTEXT, i,(LPARAM)szTemp);
		if (GetStartAndStopAddress(szTemp, &nStartAddress, &nStopAddress))
		{
			for (j=nStartAddress;j<=nStopAddress;j++)
				AllProcessesIOPM[j>>3] &= ~(1 << (j&7));
		}
	}

	for (i=0;i<sizeof(ThroughCreateFileIOPM);i++)
		ThroughCreateFileIOPM[i] = 0xff;

	nCount = SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_GETCOUNT, 0,0);

	for (i=0;i<nCount;i++)
	{
		SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_GETTEXT, i,(LPARAM)szTemp);
		if (GetStartAndStopAddress(szTemp, &nStartAddress, &nStopAddress))
		{
			for (j=nStartAddress;j<=nStopAddress;j++)
				ThroughCreateFileIOPM[j>>3] &= ~(1 << (j&7));
		}
	}

  if (RegCreateKeyEx(HKEY_LOCAL_MACHINE,
		  "Software\\UserPort",0,"",
			REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,
			NULL,&hKey,&wType) == ERROR_SUCCESS)
  {
	  RegSetValueEx(hKey,
				"AllProcessesIOPM",0,REG_BINARY,
				(BYTE *)AllProcessesIOPM,sizeof(AllProcessesIOPM));
	  RegSetValueEx(hKey,
				"ThroughCreateFileIOPM",0,REG_BINARY,
				(BYTE *)ThroughCreateFileIOPM,sizeof(ThroughCreateFileIOPM));

	  RegCloseKey(hKey);
		if (StopDriver())
		{
			Sleep(200);
			StartDriver();
		}
		return TRUE;
  }

	return FALSE;
}

BOOL ReadRegistry()
{
	UCHAR AllProcessesIOPM[0x80];
	UCHAR ThroughCreateFileIOPM[0x80];
	char szTemp[256];
	unsigned i,nStartAddress,nStopAddress;

  DWORD cb,wType, bResult1 = FALSE, bResult2 = FALSE;
  HKEY hKey;

  if (RegOpenKeyEx(HKEY_LOCAL_MACHINE,
		  "Software\\UserPort",0,KEY_READ,
		  &hKey) == ERROR_SUCCESS)
  {
 	  cb = sizeof(AllProcessesIOPM);
	  if (RegQueryValueEx(hKey,"AllProcessesIOPM",0,&wType,(BYTE *)AllProcessesIOPM,&cb) == ERROR_SUCCESS)
		  bResult1 = TRUE;
 	  cb = sizeof(ThroughCreateFileIOPM);
	  if (RegQueryValueEx(hKey,"ThroughCreateFileIOPM",0,&wType,(BYTE *)ThroughCreateFileIOPM,&cb) == ERROR_SUCCESS)
		  bResult2 = TRUE;
	  RegCloseKey(hKey);
  }

	if ((bResult1 == FALSE) || (bResult2 == FALSE))
		return FALSE;

	for (i=0;i <sizeof(AllProcessesIOPM)<<3;i++)
	{
		if ((AllProcessesIOPM[i>>3] & (1 << (i&7))) == 0)
		{
			nStartAddress = i;
		  do
			{
				nStopAddress = i;
				i++;
		  } while ((i < sizeof(AllProcessesIOPM)<<3) && ((AllProcessesIOPM[i>>3] & (1 << (i&7))) == 0));
			wsprintf(szTemp,"%X - %X",nStartAddress,nStopAddress);
			SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)szTemp);
		}
	}

	for (i=0;i <sizeof(ThroughCreateFileIOPM)<<3;i++)
	{
		if ((ThroughCreateFileIOPM[i>>3] & (1 << (i&7))) == 0)
		{
			nStartAddress = i;
		  do
			{
				nStopAddress = i;
				i++;
		  } while ((i < sizeof(ThroughCreateFileIOPM)<<3) && ((ThroughCreateFileIOPM[i>>3] & (1 << (i&7))) == 0));
			wsprintf(szTemp,"%X - %X",nStartAddress,nStopAddress);
			SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)szTemp);
		}
	}

	return TRUE;
}

BOOL AddAUMPDefaults()
{
	int nCount,i;
	
	nCount = SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_GETCOUNT, 0,0);

	for (i=0;i<nCount;i++)
		SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_DELETESTRING, 0,0);

	SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)"200 - 37F");
	SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)"3BC - 3BF");
	SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)"3E8 - 3FF");
	return TRUE;
}
BOOL AddTCFDefaults()
{
	int nCount,i;
	
	nCount = SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_GETCOUNT, 0,0);

	for (i=0;i<nCount;i++)
		SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_DELETESTRING, 0,0);

	SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)"200 - 37F");
	SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)"3BC - 3BF");
	SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_ADDSTRING, 0,(LPARAM)"3E8 - 3FF");
	return TRUE;
}

BOOL WINAPI DlgProc(
	HWND		hWnd,            //Handtag till fönster, 16-bitar
	UINT   	msg,             //Meddelande, unsigned int
	WPARAM	wParam,          //Parameter (word), unsigned int
	LPARAM	lParam )         //Parameter (long), unsigned long int
{
	char szTemp[256];
	int nIndex;
	switch (msg)
	{
		case WM_INITDIALOG:
			hDlg=hWnd;
			if (!ReadRegistry())
			{
				AddTCFDefaults();
				AddAUMPDefaults();
			}
			break;
		case WM_COMMAND:
			switch (LOWORD(wParam))
			{
				case IDCANCEL:
					PostQuitMessage ( 0 );
					EndDialog(hWnd,FALSE);
					break;
				case IDC_BUTTON_START:
					StartDriver();
					break;
				case IDC_BUTTON_STOP:
					if (!StopDriver())
					{
				    if (GetLastError()	==	ERROR_ACCESS_DENIED)
							MessageBox(hDlg,"You are not authorized to remove drivers.\r\nPlase contact your administrator.","UserPort",MB_OK);
						else
							MessageBox(hDlg,"Driver is not installed!","UserPort",MB_OK);
					}
					break;
				case IDC_AUMP_BUTTON_ADD:
					AddAUMPBtn();
					break;
				case IDC_TCF_BUTTON_ADD:
					AddTCFBtn();
					break;
				case IDC_BUTTON_UPDATE:
					UpdateBtn();
					break;
				case IDC_AUMP_BUTTON_REMOVE:
						nIndex = SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_GETCURSEL, 0,0);
						SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_DELETESTRING, nIndex,0);
						EnableWindow(GetDlgItem(hWnd,IDC_AUMP_BUTTON_REMOVE), FALSE);
					break;
				case IDC_TCF_BUTTON_REMOVE:
						nIndex = SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_GETCURSEL, 0,0);
						SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_DELETESTRING, nIndex,0);
						EnableWindow(GetDlgItem(hWnd,IDC_TCF_BUTTON_REMOVE), FALSE);
					break;
				case IDC_AUMP_BUTTON_DEFAULTS:
					AddAUMPDefaults();
					break;
				case IDC_TCF_BUTTON_DEFAULTS:
					AddTCFDefaults();
					break;
				case IDC_AUMP_EDIT_ADD:
					GetDlgItemText(hDlg,IDC_AUMP_EDIT_ADD,szTemp,sizeof(szTemp));
					EnableWindow(GetDlgItem(hWnd,IDC_AUMP_BUTTON_ADD), szTemp[0]!='\0');
					break;
				case IDC_TCF_EDIT_ADD:
					GetDlgItemText(hDlg,IDC_TCF_EDIT_ADD,szTemp,sizeof(szTemp));
					EnableWindow(GetDlgItem(hWnd,IDC_TCF_BUTTON_ADD), szTemp[0]!='\0');
					break;
				case IDC_AUMP_LIST_GRANTS:
					if (HIWORD(wParam) == LBN_SELCHANGE)
					{
						nIndex = SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_GETCURSEL, 0,0);
						SendDlgItemMessage(hDlg, IDC_AUMP_LIST_GRANTS,LB_SETCURSEL, nIndex,0);
						EnableWindow(GetDlgItem(hWnd,IDC_AUMP_BUTTON_REMOVE), TRUE);
					}
					break;
				case IDC_TCF_LIST_GRANTS:
					if (HIWORD(wParam) == LBN_SELCHANGE)
					{
						nIndex = SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_GETCURSEL, 0,0);
						SendDlgItemMessage(hDlg, IDC_TCF_LIST_GRANTS,LB_SETCURSEL, nIndex,0);
						EnableWindow(GetDlgItem(hWnd,IDC_TCF_BUTTON_REMOVE), TRUE);
					}
					break;
				default:
					return FALSE;
					break;
			}
			break;
		default:
			return FALSE;
	}
	return TRUE;
} //DlgProc

int WINAPI WinMain(
	HINSTANCE hInstance,
	HINSTANCE hPrevInstance,
	LPSTR lpszCmdline,
	int nShow )
{
	MSG msg;

	OSVERSIONINFO osvi;
	
	GetVersionEx(&osvi);

	if ((osvi.dwPlatformId == VER_PLATFORM_WIN32_WINDOWS) || (osvi.dwPlatformId == VER_PLATFORM_WIN32s))
	{
		MessageBox(NULL,"UserPort does not work on Windows 3.11/95/98/Me.\r\n\r\nUsermode programs does always have access to ports in Windows 3.11/95/98.\r\nThis program is therefore not needed on these operating systems.","UserPort",MB_OK);
		return 0;
	}

	if (lpszCmdline[0] != '\0')
	  lstrcpy(szDriverFileName, lpszCmdline);
	else
		lstrcpy(szDriverFileName,"\\SystemRoot\\System32\\Drivers\\UserPort.sys");
	CreateDialog(
		hInstance,
		MAKEINTRESOURCE(IDD_USERPORT),
		NULL,
		(DLGPROC)DlgProc);

	SetClassLong(hDlg,GCL_HICON,(long)LoadIcon ( hInstance, MAKEINTRESOURCE(IDI_APP)));

	while ( GetMessage ( &msg, NULL, 0, 0 ) )
	{
		if (IsDialogMessage(hDlg,&msg))
			continue;
		TranslateMessage ( &msg );
		DispatchMessage ( &msg );
	}
	return 0;
}  //WinMain
