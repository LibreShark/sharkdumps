#include <windows.h>
static BOOL bPrivException = FALSE;

void outport(UINT portid, UINT value)
{
  __asm mov edx,portid;
  __asm mov eax,value;
  __asm out dx,ax;
}
void outportb(UINT portid, BYTE value)
{
  __asm mov edx,portid
  __asm mov al,value
  __asm out dx,al
}

BYTE inportb(UINT portid)
{
  unsigned char value;
  
  __asm mov edx,portid
  __asm in al,dx
  __asm mov value,al
  return value;
}

UINT inport(UINT portid)
{
  int value=0;
  __asm mov edx,portid
  __asm in ax,dx
  __asm mov value,eax
  return value;
}

LONG WINAPI HandlerExceptionFilter ( EXCEPTION_POINTERS *pExPtrs )
{

	if (pExPtrs->ExceptionRecord->ExceptionCode == EXCEPTION_PRIV_INSTRUCTION)
	{
		pExPtrs->ContextRecord->Eip ++; // Skip the OUT or IN instruction that caused the exception
		bPrivException = TRUE;
		return EXCEPTION_CONTINUE_EXECUTION;
	}
	else
		return EXCEPTION_CONTINUE_SEARCH;
}

BOOL StartUpIoPorts(UINT PortToAccess, BOOL bShowMessageBox, HWND hParentWnd)
{
	HANDLE hUserPort;

  hUserPort = CreateFile("\\\\.\\UserPort", GENERIC_READ, 0, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
  CloseHandle(hUserPort); // Activate the driver
	Sleep(100); // We must make a process switch

	SetUnhandledExceptionFilter(HandlerExceptionFilter);
	
	bPrivException = FALSE;
	inportb(PortToAccess);  // Try to access the given port address

	if (bPrivException)
	{
		if (bShowMessageBox)
		{
    	MessageBox(hParentWnd,"Privileged instruction exception has occured!\r\n\r\n"
												 "To use this program under Windows NT or Windows 2000\r\n"
												 "you need to install the driver 'UserPort.SYS' and grant\r\n"
												 "access to the ports used by this program.",
												 NULL,MB_OK);
    }
		return FALSE;
	}
	return TRUE;
}

