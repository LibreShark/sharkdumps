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
#define EMU_INTEGRATE 0 //Standalone
//#define EMU_INTEGRATE 1 //Mupen

#include <w32api.h>
#define WINVER WindowsNT4
#define _WIN32_IE IE6

#include <windows.h>
#include <windowsx.h>
#include <commctrl.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <shlobj.h>
#include <ctype.h>
#include <psapi.h>
#include <TLHelp32.h>
#include "_types.h"
#include "main_gui.h"

#define NUM_PRESETS 0x64
#define NUM_TABS 5
#define MAX_SEARCHES 100

//TAB IDs
#define HOOK_TAB 0
#define CODE_SEARCH_TAB 1
#define SEARCH_RESULTS_TAB 2
#define MEMORY_EDITOR_TAB 3
#define CHEAT_TAB 4
//#define SETTINGS_TAB 4
//about_tab

//hook types
#define HOOK_PROCESS 1
#define HOOK_FILE 2

//Endian
#define LITTLE_ENDIAN_SYS 0
#define LITTLE_ENDIAN_BIG_SYS 1
#define BIG_ENDIAN 2

//Number Base
#define BASE_DEC 0
#define BASE_HEX 1
#define BASE_FLOAT 2
#define BASE_ASCII 0x100 //for certain custom window/control printing functions

//Start types -- must match combo box order
#define RAM_STATIC 0
#define RAM_POINTER 1

//Hook system types
#define SYSTEM_PC 0x0
#define SYSTEM_N64 0x1
#define SYSTEM_PS1 0x2
#define SYSTEM_PS2 0x4
#define SYSTEM_GBA_WRAM 0x8
#define SYSTEM_GBA_IRAM 0x10
#define SYSTEM_NDS 0x20
//#define SYSTEM_SNES 0x40

//Search types
#define SEARCH_INIT 0x0
#define SEARCH_KNOWN 0x1
#define SEARCH_KNOWN_WILD 0x2
#define SEARCH_GREATER 0x4
#define SEARCH_GREATER_BY 0x8
#define SEARCH_GREATER_LEAST 0x10
#define SEARCH_GREATER_MOST 0x20
#define SEARCH_LESS 0x40
#define SEARCH_LESS_BY 0x80
#define SEARCH_LESS_LEAST 0x100
#define SEARCH_LESS_MOST 0x200
#define SEARCH_EQUAL 0x400
#define SEARCH_EQUAL_NUM_BITS 0x800
#define SEARCH_NEQUAL 0x1000
#define SEARCH_NEQUAL_TO 0x2000
#define SEARCH_NEQUAL_BY 0x4000
#define SEARCH_NEQUAL_LEAST 0x8000
#define SEARCH_NEQUAL_MOST 0x10000
#define SEARCH_NEQUAL_TO_BITS 0x20000
#define SEARCH_NEQUAL_BY_BITS 0x40000
#define SEARCH_IN_RANGE 0x80000
#define SEARCH_NOT_RANGE 0x100000
#define SEARCH_BITS_ANY 0x200000
#define SEARCH_BITS_ALL 0x400000
#define SEARCH_FORGOT 0x800000
//#define SEARCH_KNOWN_LIST 0x800000
//#define SEARCH_NOT_LIST 0x1000000
//Not Wild

//Extended Search Types
#define EXCS_SIGNED 0x1
#define EXCS_OR_EQUAL 0x2
#define EXCS_IGNORE_0 0x4
#define EXCS_IGNORE_FF 0x8
#define EXCS_IGNORE_VALUE 0x10
#define EXCS_IGNORE_IN_RANGE 0x20
#define EXCS_IGNORE_NOT_RANGE 0x40
#define EXCS_IGNORE_N64_POINTERS 0x80
#define EXCS_IGNORE_BYTE_VALUE 0x100
#define EXCS_IGNORE_SHORT_VALUE 0x200
#define EXCS_IGNORE_WORD_VALUE 0x400
#define EXCS_IGNORE_DWORD_VALUE 0x800
#define EXCS_IGNORE_BYTE_RANGE 0x1000
#define EXCS_IGNORE_SHORT_RANGE 0x2000
#define EXCS_IGNORE_WORD_RANGE 0x4000
#define EXCS_IGNORE_DWORD_RANGE 0x8000
#define EXCS_EXCLUDE_CONSEC 0x10000
#define EXCS_EXCLUDE_CONSEC_MATCH_VALUES 0x20000
#define EXCS_INCLUDE_CONSEC 0x40000
#define EXCS_INCLUDE_CONSEC_MATCH_VALUES 0x80000
#define EXCS_INCLUDE_ADDRESS_RANGE 0x100000
#define EXCS_EXCLUDE_UPPER16 0x200000
#define EXCS_EXCLUDE_LOWER16 0x400000
//add exclude MIPS/text
//keep upper/lower only

//Search Access
#define SEARCH_ACCESS_AUTO 0
#define SEARCH_ACCESS_ARRAY 1
#define SEARCH_ACCESS_FILE 2
//create map for GBA/DS? seperate presets for GBA RAM chunks. map everything based on system

//Cheat tab constants
#define CODE_MAX_CHEAT_NAME 256
#define CODE_MAX_NOTE_LEN 1024
//#define CODE_MAX_SYSTEM_NAME 100
#define CODE_MAX_LINES 50
#define CODE_MAX_PER_GAME 1000
//#define CODE_MAX_SYSTEMS 25
//#define CODE_MAX_GAMES 100
#define CODE_MAX_GAME_NAME 256

#define CHEAT_PC 0
#define CHEAT_N64 0x1
#define CHEAT_PS1 0x2
#define CHEAT_PS2 0x4
#define CHEAT_GBA_WRAM 0x8
#define CHEAT_GBA_IRAM 0x10
#define CHEAT_NDS 0x20

typedef struct _HOOK_VARS {
    char Name[1024];
    char HookType;
    char ProgramPath[MAX_PATH];
    char FileName[1024];
    int StartType;
    u32 StartAddress;
    u32 MaxRamSize;
    int AllRam;
    int Endian;
    int SearchAccess;
    u32 System;
    u32 EntryOffset;
} HOOK_VARS;

typedef struct _CODE_SEARCH_SETTINGS {
    char DumpDir[MAX_PATH];
    int NumBase;
    int NumBaseId;
} CODE_SEARCH_SETTINGS;

typedef struct _CODE_SEARCH_VARS {
    int Count;
    int CompareTo;
    int Size;
    u32 Type;
    u32 TypeEx;
    u64 Values[10];
    u64 ValuesEx1[64];
    u64 ValuesEx2[64];
} CODE_SEARCH_VARS;

typedef struct CODE_SEARCH_RESULTS_INFO {
    char dmpFileName[MAX_PATH];
    char MapFileName[MAX_PATH];
    char Mapped;
    int Endian;
    int SearchSize;
    u32 DumpSize;
    u32 ResCount;
    u32 MapFileAddy; //temp
    u32 MapMemAddy; //temp
} CODE_SEARCH_RESULTS_INFO;

typedef struct _SEARCH_RESULTS_LIST {
    char Size;
    u32 Address;
    u64 Values[MAX_SEARCHES];
} SEARCH_RESULTS_LIST;

typedef struct _SEARCH_RESULTS_SETTINGS {
    int DisplayFmt;
    int ExportFmt;
    int ResWriteRate;
    int ResWriteRateId;
    int RamView;
} SEARCH_RESULTS_SETTINGS;

typedef struct _MEMORY_EDITOR_SETTINGS {
    int RefreshRate;
    int ByteSwap;
} MEMORY_EDITOR_SETTINGS;

typedef struct _CHEAT_SETTINGS {
    int WriteRate;
    int WriteRateId;
    int DevButton;
    char dbModified;
    char dbFileName[MAX_PATH];
} CHEAT_SETTINGS;

typedef struct _CHEAT_CODE {
    char Name[CODE_MAX_CHEAT_NAME];
    char Note[CODE_MAX_NOTE_LEN];
    int LineCount;
    BOOL Active;
    u8 Type[CODE_MAX_LINES];
    u32 Address[CODE_MAX_LINES];
    u32 Value[CODE_MAX_LINES];
} CHEAT_CODE;

struct _CHEAT_GAME {
    int System;
    char Name[CODE_MAX_GAME_NAME];
    CHEAT_CODE Codes[CODE_MAX_PER_GAME];
} CheatDB;
/*
struct _CHEAT_SYSTEM {
    int System;
    char Name[CODE_MAX_SYSTEM_NAME];
    CHEAT_GAME Games[CODE_MAX_GAMES];
} CheatDB;
*/
struct ini {
    int VersionNum; //to prevent loading shit from a previous version if struct has changed
    LOGFONT ValueFontInfo;
    HFONT ValueHFont;
    HOOK_VARS Hook;
    HOOK_VARS Presets[NUM_PRESETS];
    CODE_SEARCH_SETTINGS CS;
    SEARCH_RESULTS_SETTINGS Results;
    MEMORY_EDITOR_SETTINGS MemEdit;
    CHEAT_SETTINGS Cheat;
} Settings, Defaults;

typedef struct _LISTVIEW_ITEM_EDIT_INFO {
    BOOL Status;
    int iItem;
    int iSubItem;
} LISTVIEW_ITEM_EDIT_INFO;

struct RAM_INFO {
    int Access;
    u8 *NewRAM;
    u8 *OldRAM;
    FILE *NewFile;
    FILE *OldFile;
    u8 *Results;
    u8 *AddressMap;
    u32 MapSize;
    CODE_SEARCH_RESULTS_INFO OldResultsInfo;
    CODE_SEARCH_RESULTS_INFO NewResultsInfo;
} RamInfo;

//shared vars
extern HANDLE hinstMain;
extern HWND hwndMain;
extern HWND hTabDlgs[NUM_TABS];
extern char ErrTxt[1000];
extern char INIFile[MAX_PATH];
extern WNDPROC wpHexEditBoxes;
extern PROCESS_INFORMATION HookedProcess;
extern SEARCH_RESULTS_LIST *ResultsList;

//macros
#define String2Hex(s,v) sscanf((s),"%x",(v))
#define MAKEU64(l,h) (u64)(l)|((u64)(h)<<32)

//PSAPI bullshit
typedef union _PSAPI_WORKING_SET_BLOCK {
  ULONG_PTR Flags;
  struct {
    ULONG_PTR Protection  :5;
    ULONG_PTR ShareCount  :3;
    ULONG_PTR Shared  :1;
    ULONG_PTR Reserved  :3;
    ULONG_PTR VirtualPage  :20;
  } ;
} PSAPI_WORKING_SET_BLOCK,
 *PPSAPI_WORKING_SET_BLOCK;

typedef struct _PSAPI_WORKING_SET_INFORMATION {
  ULONG_PTR NumberOfEntries;
  PSAPI_WORKING_SET_BLOCK WorkingSetInfo[1];
} PSAPI_WORKING_SET_INFORMATION,
 *PPSAPI_WORKING_SET_INFORMATION;

//tab procedures
BOOL CALLBACK HookProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK CodeSearchProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK SearchResultsProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK MemoryEditorProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK CheatProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);

//misc API
int LoadSettings();
int SaveSettings();
LRESULT CALLBACK HexEditBoxProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
int isHexWindow(HWND txtbox);
u64 GetHexWindow(HWND txtbox);
int SetHexWindow(HWND txtbox, u64 value);
u64 isDecWindow(HWND txtbox);
u64 GetDecWindow(HWND txtbox);
int SetDecWindowU(HWND txtbox, u64 value);
u64 IsFloatWindow(HWND txtbox);
u64 GetFloatWindow(HWND txtbox, int fsize);
int ResetHook();
int InitHook();
int VerifyHook();
BOOL EnableTokenPrivilege (LPTSTR privilege);
int ComboAddItem(HWND hCombo, const char* combostring, DWORD value);
int FreeRamInfo();
int FreeShit();
int SetMenuItemText(HMENU hMenu, UINT id, const char* MenuText);
int SetMenuState(HMENU hMenu, UINT id, UINT state);
int SetMenuItemData(HMENU hMenu, UINT id, UINT data);
int GetMenuItemData(HMENU hMenu, UINT id);
int AddHeaderItem(HWND hHeader, int size, const char* txtHeader);
int SetHeaderItemText(HWND hHeader, int item, const char* txtHeader);
int ComboSelFromData (HWND hCombo, u32 DataValue);

//misc
int FilterHexChar(int lvalue);
int isHex(char* text);
int isDec(char* text);
int isFloat(char* text);
u64 Float2Hex(float floatval);
u64 Double2Hex(double dblval);
int str_lcase(char *str);
int StringCompareCI(char* string1, char* string2);
int SetBitFlag(u8 *flags, int num, int val);
int GetBitFlag(u8 *flags, int num);
int BitCount(u64 countval);
u64 SignExtend64(u64 signval, int sbytes);
u64 ByteFromU64(u64 dword, int valpart);
u64 ShortFromU64(u64 dword, int valpart);
u64 WordFromU64(u64 dword, int valpart);
int Hex2ASCII(u64 value, int bytes, char *string);
u64 FlipBytes(u64 value, int size);

//memory
u32 DumpRAM();
u32 FindNDSRAM();
u64 GetSearchValues(u64 *NewVal, u64 *OldVal, int index, int size, int endian);
u32 FlipAddress(u32 address, int size, int endian);
int WriteRAM(u32 address, u32 value, int size, int endian);
int ReadRAM(u32 address, u64 *value, int size, int endian);
u32 GetSystemAddressMask(int system, int searchsize);
#if (EMU_INTEGRATE == 1) //Mupen
void invalidate_dynarec();
#endif

//fileio
int FileExists(char *filename);
int DoFileOpen(HWND hwnd, char* filename);
int DoFileSave(HWND hwnd, char* filename);
int BrowseForFolder(HWND hwnd, char* filename);
int SaveFile(u8 *buffer, u32 filesize, char* filename, int headerlen, VOID *headerdata);
int LoadFile(u8 **buffer, char* filename, int headerlen, u8 **headerdata, BOOL loadheader);
int SaveStruct(VOID *buffer, u32 filesize, char* filename);
int LoadStruct(VOID *buffer, u32 filesize, char* filename);

//search
int CodeSearch(CODE_SEARCH_VARS Search, HWND hProgressBar);
int CodeSearchEx(u32 address, u64 NewValue, u64 OldValue, CODE_SEARCH_VARS Search);
int FilterResultsEx(CODE_SEARCH_VARS Search, HWND hProgressBar);
int SetExValues(CODE_SEARCH_VARS *SearchInfo, u64 exType, u64 exValue1, u64 exValue2);
u64 GetExSearchValue(u64 *exValues, u64 exType);

//listview
int ListViewAddRow(HWND hListView, int count, ...);
int ListViewSetRow(HWND hListView, int item, int subitem, int count, ...);
int ListViewAddCol(HWND hListView, const char* colName, int colNum, int colWidth);
int ListViewGetText(HWND hListView, int iNum, int iSub, char* iText, int txtLen);
u64 ListViewGetHex(HWND hListView, int iNum, int iSub);
u64 ListViewGetDec(HWND hListView, int iNum, int iSub);
int ListViewHitTst(HWND hListView, DWORD dwPos, int iItem);

