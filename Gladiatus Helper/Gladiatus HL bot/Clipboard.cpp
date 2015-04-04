#include <windows.h>
#include <stdio.h>
#include <iostream>

char *ImportClipboard(HWND hwnd) {
HANDLE hClipData;
char *str = NULL;
char * result = NULL;
result = 0;
       if (IsClipboardFormatAvailable(CF_TEXT)) {
          if (OpenClipboard(hwnd)) {
          hClipData = GetClipboardData(CF_TEXT);
              if (hClipData) {
              str = (char*) GlobalLock(hClipData);
              result = strdup(str);
              GlobalUnlock(hClipData);
              }
          }
       CloseClipboard();
       }
return (result);
}

int main() {
HWND hwnd;
char * text;
FILE * arq;
text=ImportClipboard(hwnd);
     arq = fopen ( "Handle.txt" , "w" );
     if(arq) {
     rewind (arq);
     fputs (text, arq);      
     } fclose ( arq );   
}
