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
#include <windows.h>

#define PROGRAM_NAME "RenegadeEX v1.06"
#define DLG_RENEGADEX 0x1
#define TAB_MAIN 0x2

//#define VKEY_CMD_F5 0x300
#define VCMD_HOOK_GET_SETTS 0x301
#define LSV_CS_BEGINEDIT 0x302
#define LSV_CS_ENDEDIT 0x303
#define VCMD_HOOK_SHOW_SETTS 0x304
#define LSV_MEM_BEGINEDIT 0x305
#define LSV_MEM_ENDEDIT 0x306
#define LSV_CHEAT_GAME_BEGINEDIT 0x307
#define LSV_CHEAT_GAME_ENDEDIT 0x308
#define LSV_CHEAT_CODE_BEGINEDIT 0x309
#define LSV_CHEAT_CODE_ENDEDIT 0x30A

//Search Results Menu
#define RES_LIST_MENU 0x200
#define MNU_RES_EXPORT_HEX 0x201
#define MNU_RES_SHOW_HEX 0x202
#define MNU_RES_SHOW_DECU 0x203
#define MNU_RES_SHOW_DECS 0x204
#define MNU_RES_SHOW_FLOAT 0x205
#define MNU_RES_EXPORT_DECU 0x206
#define MNU_RES_EXPORT_DECS 0x207
#define MNU_RES_EXPORT_FLOAT 0x208
#define MNU_RES_EXPORT_GS 0x209
#define MNU_RES_WRITE_OFF 0x20A
#define MNU_RES_WRITE_10MS 0x20B
#define MNU_RES_WRITE_100MS 0x20C
#define MNU_RES_WRITE_500MS 0x20D
#define MNU_RES_WRITE_1S 0x20F
#define MNU_RES_WRITE_10S 0x210
#define MNU_RES_WRITE_30S 0x211
#define MNU_RES_WRITE_1M 0x212
#define MNU_RES_RAM_VIEW 0x213

//results export - all IDs between min and max are reserved for this. (ID & 0xFF) Must sync with search num
#define MNU_RES_MIN_EXPORT 0x400
#define MNU_RES_MAX_EXPORT 0x500

//Memory Editor menu
#define MEMORY_EDITOR_MENU 0x600
#define MNU_MEM_SAVE_DUMP 0x601
#define MNU_MEM_SHOW_BYTESWAPPED 0x602
#define MNU_MEM_REFRESH_OFF 0x603
#define MNU_MEM_REFRESH_10MS 0x604
#define MNU_MEM_REFRESH_100MS 0x605
#define MNU_MEM_REFRESH_500MS 0x606
#define MNU_MEM_REFRESH_1S 0x607
#define MNU_MEM_REFRESH_10S 0x608
#define MNU_MEM_REFRESH_30S 0x609
#define MNU_MEM_REFRESH_1M 0x60A

//Code Search Menu
#define CODE_SEARCH_MENU 0x700
#define MNU_CS_SET_DUMP_DIR 0x701
#define MNU_CS_INPUT_HEX 0x702
#define MNU_CS_INPUT_DEC 0x703
#define MNU_CS_INPUT_FLOAT 0x704
#define MNU_CS_DUMP_DIR 0x705

//Cheat Menu
#define CHEAT_MENU 0x800
#define MNU_CHEAT_WRITE_OFF 0x801
#define MNU_CHEAT_WRITE_5MS 0x802
#define MNU_CHEAT_WRITE_10MS 0x803
#define MNU_CHEAT_WRITE_100MS 0x804
#define MNU_CHEAT_WRITE_500MS 0x805
#define MNU_CHEAT_WRITE_1S 0x806
#define MNU_CHEAT_WRITE_5S 0x807
#define MNU_CHEAT_WRITE_10S 0x808
#define MNU_CHEAT_WRITE_30S 0x809
#define MNU_CHEAT_NEW_DB 0x80A
#define MNU_CHEAT_OPEN_DB 0x80B
#define MNU_CHEAT_SAVE_DB 0x80C
#define MNU_CHEAT_SAVE_DB_AS 0x80D
#define MNU_CHEAT_ALL_OFF 0x80E
#define MNU_CHEAT_ALL_ON 0x80F

//Hook tab
#define DLG_HOOK 0x1000
#define LSV_HOOK_PROCESSES 0x1001
#define CMB_HOOK_PRESETS 0x1002
#define LBL_HOOK_PROG_PATH 0x1003
#define TXT_HOOK_PROG_PATH 0x1004
#define LBL_HOOK_EXENAME 0x1005
#define TXT_HOOK_EXENAME 0x1006
#define LBL_HOOK_STARTADDY 0x1007
#define TXT_HOOK_RAMSTART 0x1008
#define CMB_HOOK_START_TYPE 0x1009
#define LBL_HOOK_RAMSIZE 0x1010
#define TXT_HOOK_RAMSIZE 0x1011
#define CHK_HOOK_ALL_RAM 0x1012
#define LBL_HOOK_ENDIAN 0x1013
#define CMB_HOOK_ENDIAN 0x1014
#define CMD_HOOK_ADD_PRESET 0x1015
#define CMD_HOOK_UP_PRESET 0x1016
#define LBL_HOOK_PRESET 0x1017
#define CMD_HOOK_DEL_PRESET 0x1018
#define LBL_HOOK_HTYPE 0x1019
#define OPT_HOOK_PROCESS 0x1020
#define OPT_HOOK_FILE 0x1021
#define LBL_HOOK_PNAME 0x1022
#define TXT_HOOK_PNAME 0x1023
#define CMD_HOOK_REFRESH_PROCS 0x1024
#define CMD_HOOK_LAUNCH 0x1025
#define LBL_HOOK_AUTOFIND 0x1026
#define CMB_HOOK_AUTOFIND 0x1027
#define CMD_HOOK_EXPORT_PRESET 0x1028
#define CMD_HOOK_IMPORT_PRESET 0x1029
#define CMD_HOOK_DEFAULT_PRESETS 0x1030
#define LBL_HOOK_ACCESS_TYPE 0x1031
#define CMB_HOOK_ACCESS_TYPE 0x1032
#define CMD_HOOK_RUN_PRESET 0x1033
#define CMD_HOOK_PROG_PATH 0x1034
#define LBL_HOOK_SYSTEM 0x1035
#define CMB_HOOK_SYSTEM 0x1036
#define LBL_HOOK_ENTRY_OFFSET 0x1037
#define TXT_HOOK_ENTRY_OFFSET 0x1038

//Code Search tab
#define DLG_CODE_SEARCH 0x1100
#define GRP_CS_SEARCH_SIZE 0x1101
#define CMB_CS_SEARCH_SIZE 0x1102
#define GRP_CS_COMPARE_TO 0x1103
#define CMB_CS_COMPARE_TO 0x1104
#define GRP_CS_SEARCH_TYPE 0x1105
#define CMB_CS_SEARCH_TYPE 0x1106
#define LBL_CS_VALUES 0x1107
#define TXT_CS_VALUE1 0x1108
#define TXT_CS_VALUE2 0x1109
#define LBL_CS_VALUE2 0x1110
#define GRP_CS_EXSEARCH 0x1111
#define LSV_CS_EXSEARCH 0x1112
#define CMD_CS_SEARCH 0x1113
#define CMD_CS_UNDO 0x1114
#define CMD_CS_LOAD 0x1115
#define CMD_CS_QUICK_INIT 0x1116
#define CMD_CS_QUICK_EQUAL 0x1117
#define CMD_CS_QUICK_NOTEQUAL 0x1118
#define CMD_CS_QUICK_GREATER 0x1119
#define CMD_CS_QUICK_LESS 0x1120
#define LBL_CS_QUICK_SEARCH 0x1121
#define TXT_CS_EX_EDIT 0x1122
#define LBL_CS_RESLABEL 0x1123
#define LBL_CS_RESCOUNT 0x1124
#define CMD_CS_DUMP 0x1125
#define GRP_CS_PROGRESS 0x1126
#define PGB_CS_PROGRESS 0x1127
#define HDR_CS_MENU 0x1128

//Options tab
#define DLG_SETTINGS 0x1200
#define GRP_SETT_CS 0x1201
#define LBL_SETT_NUM_BASE 0x1202
#define OPT_SETT_DEC 0x1203
#define LBL_SETT_DUMP_DIR 0x1204
#define TXT_SETT_DUMP_DIR 0x1205
#define CMD_SETT_DUMP_DIR 0x1206
#define OPT_SETT_HEX 0x1207
#define OPT_SETT_FLOAT 0x1208
#define LBL_SETT_RES_WRITE 0x1209
#define CMB_SETT_RES_WRITE 0x1210

//Results tab
#define DLG_SEARCH_RESULTS 0x1300
#define GRP_RES_RESULTS 0x1301
#define GRP_RES_ACTIVE 0x1302
#define LSV_RES_RESULTS 0x1303
#define LSV_RES_ACTIVE 0x1304
#define LBL_RES_ADDRESS 0x1305
#define TXT_RES_ADDRESS 0x1306
#define LBL_RES_VALUE 0x1307
#define TXT_RES_VALUE 0x1308
#define CMB_RES_SIZE 0x1309
#define LBL_RES_SIZE 0x1310
#define CMD_RES_ADD 0x1311
#define HDR_RES_MENU 0x1312
#define VSCROLL_RES_RESULTS 0x1313
#define CMD_RES_DEL 0x1314
#define CMD_RES_CLEAR 0x1315
#define CMD_RES_ALL_ON 0x1316
#define CMD_RES_ALL_OFF 0x1317

//Memory Editor tab
#define DLG_MEMORY_EDITOR 0x1400
#define HDR_MEM_MENU 0x1401
#define LSV_MEM_EDITOR 0x1402
#define TXT_MEM_EDIT 0x1403

//Cheat tab
#define DLG_CHEAT 0x1500
#define HDR_CHEAT_MENU 0x1501
#define GRP_CHEAT_GAME_NAME 0x1502
#define TXT_CHEAT_GAME_NAME 0x1503
//#define TXT_CHEAT_GAME_NAME 0x1504
#define CMB_CHEAT_CODE_TYPE 0x1505
#define GRP_CHEAT_CODE_TYPE 0x1506
//#define LBL_CHEAT_CODE_TYPE 0x1507
#define TXT_CHEAT_CODE_NAME 0x1508
#define LSV_CHEAT_CODES 0x1510
//#define LSV_CHEAT_GAMES 0x1511
#define GRP_CHEAT_CODE 0x1512
#define TXT_CHEAT_CODE 0x1513
#define GRP_CHEAT_NOTE 0x1514
#define TXT_CHEAT_NOTE 0x1515
#define CMD_CHEAT_SET_CODE 0x1516
#define DLG_CHEAT_BUTTON 0x150A

