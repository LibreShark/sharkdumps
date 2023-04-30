@echo off
 
ECHO UTILITY TO UPLOAD MEMPACK FILE TO N64 CONTROLLER MEMPACK
ECHO USAGE: MPK2N64 FILENAME


if exist %1 goto upload
goto end

:upload
PLACE %1 0 MPK2N64.V64 6A38 r

ias --crc MPK2N64.V64

ECHO Ready to send to V64!
pause

talk64 -p2 -l MPK2N64.V64
:end
