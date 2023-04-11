unit IOPort;

interface
uses windows;

procedure outport(portid : integer; value : integer);
procedure outportb(portid : integer; value : BYTE);
function inportb(portid : integer) : byte;
function inport(portid : integer) : integer;
function StartUpIoPorts(PortToAccess : integer) : boolean;

implementation

var
 bPrivException : boolean;

procedure outport(portid : integer; value : integer);
Begin
  asm
    mov edx,portid;
    mov eax,value;
    out dx,ax;
  end;
end;

procedure outportb(portid : integer; value : BYTE);
Begin
  asm
    mov edx,portid
    mov al,value
    out dx,al
  end;
end;

function inportb(portid : integer) : byte;
Var value : byte;
Begin
  asm
    mov edx,portid
    in al,dx
    mov value,al
  end;
  inportb := value;
end;

function inport(portid : integer) : integer;
Var value : integer;
Begin
  value := 0;
  asm
    mov edx,portid
    in ax,dx
    mov value,eax
  end;
  inport := value;
end;

function StartUpIoPorts(PortToAccess : integer) : boolean;
Var hUserPort : THandle;
Begin
  hUserPort := CreateFile('\\.\UserPort', GENERIC_READ, 0, nil,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  CloseHandle(hUserPort); // Activate the driver
  Sleep(100); // We must make a process switch

  try
    inportb(PortToAccess);  // Try to access the given port address
  except
    MessageBox(0,'fel','fel',MB_OK);
  end;
end;

end.