@REM call .\clean.bat
mkdir obj
mkdir build
mkdir lib

:: Assemble the hUGEDriver source into an RGBDS object file
rgbasm -DGBDK -o./obj/hUGEDriver.obj -i.. ../hUGEDriver.asm

:: Convert the RGBDS object file into a GBDK object file
python ..\tools\rgb2sdas.py -o obj/hUGEDriver.o obj/hUGEDriver.obj

:: Make the library
sdar -ru lib/hUGEDriver.lib obj/hUGEDriver.o

:: Build the rom!
@REM @set GBDK=..\..\..\gbdk
@REM %GBDK%\bin\lcc.exe -I../include -Wl-llib/hUGEDriver.lib -o build/gbdk_player_example.gb src/gbdk_player_example.c src/sample_song.c

@set GBDK=..\..\..\gbdk
%GBDK%\bin\lcc.exe -autobank -I../include -Wl-llib/hUGEDriver.lib -Wf--debug -Wl-y -Wb-ext=.rel -Wb-v -Wl-yt0x1B -Wl-yoA -Wl-ya4 -o build/hugetracker-test.gb^
 src\*.c 