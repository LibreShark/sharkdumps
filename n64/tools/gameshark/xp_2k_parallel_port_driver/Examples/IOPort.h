#ifndef IOPORTH
#define IOPORTH

#ifdef __cplusplus
extern "C" {
#endif

void outport(UINT portid, UINT value);
void outportb(UINT portid, BYTE value);
BYTE inportb(UINT portid);
UINT inport(UINT portid);
BOOL StartUpIoPorts(UINT PortToAccess, BOOL bShowMessageBox, HWND hParentWnd);

#ifdef __cplusplus
}
#endif

#endif
