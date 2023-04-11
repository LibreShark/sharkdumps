/*********************************************************************

Author:     Tomas Franzon
Date:       11/09/2000
Program:    UserPort.SYS
Compile:    Use DDK BUILD facility

Purpose:    Give direct port I/O access to user mode programs.

This driver is influenced by an article written by Dale Roberts 8/30/95,
published in May 96 Dr Dobbs Journal, see www.ddj.com.
The driver gives user mode program access to selected ports by changing
the x86-processors IOPM (I/O Permission Map). The driver has one separate
map for all procsesses (AllProcessesIOPM) and one separate map 
(ThroughCreateFileIOPM) for processes that opens the file "\\.\UserPort"

The driver tries to read the registry keys:
HKEY_LOCAL_MACHINE\Software\UserPort\AllProcessesIOPM
HKEY_LOCAL_MACHINE\Software\UserPort\ThroughCreateFileIOPM
It will use the default values below if these doesn't exist.

*********************************************************************/
#include <ntddk.h>

/*
 *  Make sure our structure is packed properly, on byte boundary, not
 * on the default doubleword boundary.
*/
#pragma pack(push,1)

/*
 *  Structures for manipulating the GDT register and a GDT segment
 * descriptor entry.  Documented in Intel processor handbooks.
 */
typedef struct {
	unsigned limit : 16;
	unsigned baselo : 16;
	unsigned basemid : 8;
	unsigned type : 4;
	unsigned system : 1;
	unsigned dpl : 2;
	unsigned present : 1;
	unsigned limithi : 4;
	unsigned available : 1;
	unsigned zero : 1;
	unsigned size : 1;
	unsigned granularity : 1;
	unsigned basehi : 8;
} GDTENT;

typedef struct {
	unsigned short	limit;
	GDTENT	*base;
} GDTREG;

#pragma pack(pop)
/*
 *  The name of our device driver.
 */
#define DEVICE_NAME_STRING	L"UserPort"

/*
  OriginalMapCopy is used to restore the IOPM when the driver exists.
  CurrentMap points to NULL or to the place where the processors IOPM is located.
  Accessmap is the IOPM that is used by the driver.
  Every port address has one cooresponding bit in the IOPM. The driver supports
  addresses from 0x000 to 0x3FF and the IOPM size is then 0x3ff / 8 = 0x80.
 */

UCHAR OriginalAllProcIOPMCopy[0x80];
UCHAR OriginalThroughCreateFileIOPMCopy[0x80];
const UCHAR DefaultMap[0x80]=
/*0x000*/ {0xFF,0xFF,
/*0x010*/  0xFF,0xFF,
/*0x020*/  0xFF,0xFF,
/*0x030*/  0xFF,0xFF,
/*0x040*/  0xFF,0xFF,
/*0x050*/  0xFF,0xFF,
/*0x060*/  0xFF,0xFF,
/*0x070*/  0xFF,0xFF,
/*0x080*/  0xFF,0xFF,
/*0x090*/  0xFF,0xFF,
/*0x0A0*/  0xFF,0xFF,
/*0x0B0*/  0xFF,0xFF,
/*0x0C0*/  0xFF,0xFF,
/*0x0D0*/  0xFF,0xFF,
/*0x0E0*/  0xFF,0xFF,
/*0x0F0*/  0xFF,0xFF,
/*0x100*/  0xFF,0xFF,
/*0x110*/  0xFF,0xFF,
/*0x120*/  0xFF,0xFF,
/*0x130*/  0xFF,0xFF,
/*0x140*/  0xFF,0xFF,
/*0x150*/  0xFF,0xFF,
/*0x160*/  0xFF,0xFF,
/*0x170*/  0xFF,0xFF,
/*0x180*/  0xFF,0xFF,
/*0x190*/  0xFF,0xFF,
/*0x1A0*/  0xFF,0xFF,
/*0x1B0*/  0xFF,0xFF,
/*0x1C0*/  0xFF,0xFF,
/*0x1D0*/  0xFF,0xFF,
/*0x1E0*/  0xFF,0xFF,
/*0x1F0*/  0xFF,0xFF,
/*0x200*/  0x00,0x00,
/*0x210*/  0x00,0x00,
/*0x220*/  0x00,0x00,
/*0x230*/  0x00,0x00,
/*0x240*/  0x00,0x00,
/*0x250*/  0x00,0x00,
/*0x260*/  0x00,0x00,
/*0x270*/  0x00,0x00,
/*0x280*/  0x00,0x00,
/*0x290*/  0x00,0x00,
/*0x2A0*/  0x00,0x00,
/*0x2B0*/  0x00,0x00,
/*0x2C0*/  0x00,0x00,
/*0x2D0*/  0x00,0x00,
/*0x2E0*/  0x00,0x00,
/*0x2F0*/  0x00,0x00,
/*0x300*/  0x00,0x00,
/*0x310*/  0x00,0x00,
/*0x320*/  0x00,0x00,
/*0x330*/  0x00,0x00,
/*0x340*/  0x00,0x00,
/*0x350*/  0x00,0x00,
/*0x360*/  0x00,0x00,
/*0x370*/  0x00,0x00,
/*0x380*/  0xFF,0xFF,
/*0x390*/  0xFF,0xFF,
/*0x3A0*/  0xFF,0xFF,
/*0x3B0*/  0xFF,0x0F,
/*0x3C0*/  0xFF,0xFF,
/*0x3D0*/  0xFF,0xFF,
/*0x3E0*/  0xFF,0x00,
/*0x3F0*/  0x00,0x00};

unsigned OrgGDTSize;     // The original sise of the TSS

/*
 Ke386IoSetAccessProcess() adjusts the IOPM offset pointer to the IOPM at 0x88
 Ke386IoSetAccessProcess() is located in NTOSKRNL.EXE but is not included in any
 header file or documented anywhere...
*/

void Ke386IoSetAccessProcess(PEPROCESS, int);

/*********************************************************************
  Service handler for a CreateFile() user mode call.

  This routine is entered in the driver object function call table by
the DriverEntry() routine.  When the user mode application calls
CreateFile(), this routine gets called while still in the context of
the user mode application, but with the CPL (the processor's Current
Privelege Level) set to 0.  This allows us to do kernel mode
operations.  UserPort() is called to give the calling process I/O
access.  All the user mode application needs do to obtain I/O access
is open this device with CreateFile().  No other operations are
required.
*********************************************************************/
NTSTATUS CreateFileDispatch(
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp
    )
{
  // Give the current process IO access
	Ke386IoSetAccessProcess(PsGetCurrentProcess(), 1);

	Irp->IoStatus.Information = 0;
	Irp->IoStatus.Status = STATUS_SUCCESS;
	IoCompleteRequest(Irp, IO_NO_INCREMENT);
	return STATUS_SUCCESS;
}

// remove the link \\.\UserPort and restore the IOPM 
void UserPortUnload(IN  PDRIVER_OBJECT  DriverObject)
{
	WCHAR DOSNameBuffer[] = L"\\DosDevices\\" DEVICE_NAME_STRING;
	UNICODE_STRING uniDOSString;
	GDTREG gdtreg;
	GDTENT *g;
	short TaskSeg;
	UCHAR *TSSAllProcessesIOPM;
	UCHAR *TSSThroughCreateFileIOPM;
	unsigned i;
	UCHAR *TSSbase; 

	_asm cli;					
	_asm sgdt gdtreg;	
	_asm str TaskSeg;	
	g = gdtreg.base + (TaskSeg >> 3);	
	g->limit = OrgGDTSize;
	g->type = 9;					
	_asm ltr TaskSeg;			
	_asm sti;						

	TSSbase = (UCHAR *) (g->baselo | (g->basemid << 16) | (g->basehi << 24));                
  TSSAllProcessesIOPM = *((USHORT *)(TSSbase + 0x66)) + TSSbase;
 	TSSThroughCreateFileIOPM = TSSbase + 0x88;

	// Restore to the original map
	for (i=0;i<sizeof(DefaultMap);i++)
	{
		TSSAllProcessesIOPM[i] = OriginalAllProcIOPMCopy[i];
		TSSThroughCreateFileIOPM[i] = OriginalThroughCreateFileIOPMCopy[i];
	}

	RtlInitUnicodeString(&uniDOSString, DOSNameBuffer);
	IoDeleteSymbolicLink (&uniDOSString);
	IoDeleteDevice(DriverObject->DeviceObject);
}

// This routine is the entrypoint of the driver.
// This routine reads the AllProcessesIOPM and ThroughCreateFileIOPM from registry and start the driver
NTSTATUS DriverEntry(
    IN PDRIVER_OBJECT DriverObject,
    IN PUNICODE_STRING RegistryPath
    )
{
	PDEVICE_OBJECT deviceObject;
	NTSTATUS status;
	WCHAR NameBuffer[] = L"\\Device\\" DEVICE_NAME_STRING;
	WCHAR DOSNameBuffer[] = L"\\DosDevices\\" DEVICE_NAME_STRING;
	UNICODE_STRING uniNameString, uniDOSString;
	GDTREG gdtreg;
	GDTENT *g;
	short TaskSeg;
	UCHAR *TSSAllProcessesIOPM;
	UCHAR *TSSThroughCreateFileIOPM;
	const UCHAR *AllProcessesIOPM = DefaultMap;
	const UCHAR *ThroughCreateFileIOPM = DefaultMap;
	unsigned i;
	UCHAR *TSSbase; 
  UCHAR InformationBuffer1[sizeof(DefaultMap)+sizeof(KEY_VALUE_PARTIAL_INFORMATION)];
  PKEY_VALUE_PARTIAL_INFORMATION Information1 = (PKEY_VALUE_PARTIAL_INFORMATION)InformationBuffer1;
  UCHAR InformationBuffer2[sizeof(DefaultMap)+sizeof(KEY_VALUE_PARTIAL_INFORMATION)];
  PKEY_VALUE_PARTIAL_INFORMATION Information2 = (PKEY_VALUE_PARTIAL_INFORMATION)InformationBuffer2;
	ULONG ResultLength;
	HANDLE KeyHandle;
	OBJECT_ATTRIBUTES ObjectAttributes;
	UNICODE_STRING ThroughCreateFileIOPMString,AllProcessesIOPMString,RegPathString;

	RtlInitUnicodeString(&AllProcessesIOPMString, L"AllProcessesIOPM");
	RtlInitUnicodeString(&ThroughCreateFileIOPMString, L"ThroughCreateFileIOPM");
	RtlInitUnicodeString(&RegPathString,L"\\Registry\\Machine\\Software\\UserPort");

	InitializeObjectAttributes(&ObjectAttributes,&RegPathString,OBJ_CASE_INSENSITIVE,NULL,NULL);

	if (STATUS_SUCCESS == ZwOpenKey(&KeyHandle, KEY_QUERY_VALUE,&ObjectAttributes))
	{
		if (STATUS_SUCCESS == ZwQueryValueKey(KeyHandle,&ThroughCreateFileIOPMString,KeyValuePartialInformation,Information1,sizeof(InformationBuffer1),&ResultLength))
			ThroughCreateFileIOPM = Information1->Data;
		if (STATUS_SUCCESS == ZwQueryValueKey(KeyHandle,&AllProcessesIOPMString,KeyValuePartialInformation,Information2,sizeof(InformationBuffer2),&ResultLength))
			AllProcessesIOPM = Information2->Data;
		ZwClose(KeyHandle);
	}
	
	_asm cli;							              // don't get interrupted!
	_asm str TaskSeg;                   // get the TSS selector      
	_asm sgdt gdtreg;                   // get the GDT address       
	g = gdtreg.base + (TaskSeg >> 3);   // get the TSS descript
                                        // get the TSS address       
	OrgGDTSize = g->limit;
	g->limit += 0x082;					        // modify TSS segment limit
	g->type = 9;						            // mark TSS as "not busy"
	_asm ltr TaskSeg;					          // reload task register (TR)
	_asm sti;							              // let interrupts continue*/

	TSSbase = (UCHAR *) (g->baselo | (g->basemid << 16) | (g->basehi << 24));                
  TSSAllProcessesIOPM = *((USHORT *)(TSSbase + 0x66)) + TSSbase;
 	TSSThroughCreateFileIOPM = TSSbase + 0x88;

	// Copy the AccessMap to TSSbase + 0x20ad and save the original map
	for (i=0;i<sizeof(DefaultMap);i++)
	{
		OriginalAllProcIOPMCopy[i] = TSSAllProcessesIOPM[i];
		TSSAllProcessesIOPM[i] = AllProcessesIOPM[i];
		OriginalThroughCreateFileIOPMCopy[i] = TSSThroughCreateFileIOPM[i];
		TSSThroughCreateFileIOPM[i] = TSSThroughCreateFileIOPM[i] & ThroughCreateFileIOPM[i];
	}

	//
	//  Set up device driver name and device object.
	//  Make the driver accessable though the file \\.\UserPort
	
	RtlInitUnicodeString(&uniNameString, NameBuffer);
	RtlInitUnicodeString(&uniDOSString, DOSNameBuffer);

	status = IoCreateDevice(DriverObject, 0,
					&uniNameString,
					FILE_DEVICE_UNKNOWN,
					0, FALSE, &deviceObject);

	if(!NT_SUCCESS(status))
		return status;

	status = IoCreateSymbolicLink (&uniDOSString, &uniNameString);

	if (!NT_SUCCESS(status))
		return status;

	//
	//  Initialize the Driver Object with driver's entry points.
	// All we require are the Create and Unload operations.
	//
	DriverObject->MajorFunction[IRP_MJ_CREATE] = CreateFileDispatch;

	DriverObject->DriverUnload = UserPortUnload;

	return STATUS_SUCCESS;
}

