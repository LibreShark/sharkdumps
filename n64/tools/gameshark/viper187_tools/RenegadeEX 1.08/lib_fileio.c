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

/**********************************************
File Exsistance check
***********************************************/
int FileExists(char *filename)
{
    FILE *f = fopen(filename,"rb");
    if (!(f)) { return 0; }
    fclose(f);
    return 1;
}

/**********************************************
Pick File dialog
***********************************************/
int DoFileOpen(HWND hwnd, char* filename)
{
	OPENFILENAME ofn;
	strcpy(filename,"");

	ZeroMemory(&ofn, sizeof(ofn));
//maybe use strrchar and sprintf with string length specification to allow more flexiable extension filtering?
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hwnd;
	ofn.lpstrFilter = "All Files (*.*)\0*.*\0";
	ofn.lpstrFile = filename;
	ofn.nMaxFile = MAX_PATH;
	ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_HIDEREADONLY;
//	ofn.lpstrDefExt = "txt";

	if(GetOpenFileName(&ofn)) //success
	{
//	    if (ofn.Flags & OFN_READONLY) { *access = 1; }
//	    else { *access = 0; }
        return 1;
	} else { return 0; }
}

int DoFileSave(HWND hwnd, char* filename)
{
	OPENFILENAME ofn;
	strcpy(filename,"");
	ZeroMemory(&ofn, sizeof(ofn));

	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hwnd;
	ofn.lpstrFilter = "All Files (*.*)\0*.*\0";
	ofn.lpstrFile = filename;
	ofn.nMaxFile = MAX_PATH;
	ofn.Flags = OFN_EXPLORER | OFN_PATHMUSTEXIST | OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT;
//	ofn.lpstrDefExt = "txt";

	if(GetSaveFileName(&ofn))
	{
        return 1;
	} else { return 0; }
}

/**********************************************
Pick Folder dialog
***********************************************/
int BrowseForFolder(HWND hwnd, char* filename) {
    BROWSEINFO bInfo; ZeroMemory(&bInfo, sizeof(bInfo));
    char buffer[MAX_PATH]; ZeroMemory(&buffer, sizeof(buffer));
    bInfo.hwndOwner = hwnd;
    bInfo.pszDisplayName = buffer;
//    bInfo.lpszTitle = "Pick Dir";
    bInfo.ulFlags = BIF_RETURNONLYFSDIRS;
    LPCITEMIDLIST pFolder = SHBrowseForFolder(&bInfo);
    if (!pFolder) { return 0; }
    if (!SHGetPathFromIDList(pFolder, filename)) { return 0; }
    return 1;
}

/**********************************************
SaveFile
***********************************************/
int SaveFile(u8 *buffer, u32 filesize, char* filename, int headerlen, VOID *headerdata)
{
    FILE *f;
    int i;
	f = fopen(filename,"wb");
	if (!(f)) {
        sprintf(ErrTxt, "Unable to open/create file (SaveFile,1) -- Error %u", GetLastError());
        MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
    }
	fseek(f,0,SEEK_SET);
	if (headerlen) { fwrite(headerdata,1,headerlen,f); }
	fwrite(buffer,1,filesize,f);
	fclose(f);
	return filesize;
}

/**********************************************
LoadFile
***********************************************/
int LoadFile(u8 **buffer, char* filename, int headerlen, u8 **headerdata, BOOL loadheader)
{
    FILE *f;
    int i;
    u32 filesize;
	f = fopen(filename,"rb");
	if (!(f)) {
        sprintf(ErrTxt, "Unable to open file (LoadFile,1) -- Error %u", GetLastError());
        MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
    }
	fseek(f,0,SEEK_END);
	filesize = ftell(f);
	fseek(f,0,SEEK_SET);
    if (headerlen > filesize) {
	    MessageBox(NULL,"Header length greater than file size. WTF? Idiot. (LoadFile,1)","Error",0);
	    fclose(f); return 0;
	}
    if (*buffer) { free(*buffer); *buffer = NULL; }
    if (!(*buffer = (unsigned char*)malloc(filesize+1))) {
        sprintf(ErrTxt, "Unable to allocate buffer memory (LoadFile, 1) -- Error %u", GetLastError());
        MessageBox(NULL, ErrTxt, "Error", MB_OK);
        fclose(f); return 0;
    }
    if ((loadheader) && (headerlen)) {
        if (*headerdata) { free(*headerdata); *headerdata = NULL; }
        if (!(*headerdata = (unsigned char*)malloc(headerlen))) {
            sprintf(ErrTxt, "Unable to allocate header memory (LoadFile, 1) -- Error %u", GetLastError());
            MessageBox(NULL, ErrTxt, "Error", MB_OK);
            free(*headerdata); *headerdata = NULL;
            fclose(f); return 0;
        }
        fread(*headerdata,1,headerlen,f);
        filesize -= headerlen;
    } else {
        filesize -= headerlen;
        fseek(f,headerlen,SEEK_SET);
    }
	fread(*buffer,1,filesize,f);
	fclose(f);
	return filesize;
}

/**********************************************
SaveStruct
***********************************************/
int SaveStruct(VOID *buffer, u32 filesize, char* filename)
{
    FILE *f;
    int i;
	f = fopen(filename,"wb");
	if (!(f)) {
        sprintf(ErrTxt, "Unable to open/create file (SaveStruct,1) -- Error %u", GetLastError());
        MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
    }
	fseek(f,0,SEEK_SET);
	fwrite(buffer,1,filesize,f);
	fclose(f);
	return filesize;
}

/**********************************************
LoadStruct
***********************************************/
int LoadStruct(VOID *buffer, u32 filesize, char* filename)
{
    FILE *f;
    int i;
	f = fopen(filename,"rb");
	if (!(f)) {
        sprintf(ErrTxt, "Unable to open/create file (LoadStruct,1) -- Error %u", GetLastError());
        MessageBox(NULL,ErrTxt,"Error",MB_OK); return 0;
    }
	fseek(f,0,SEEK_SET);
	fread(buffer,1,filesize,f);
	fclose(f);
	return filesize;
}

