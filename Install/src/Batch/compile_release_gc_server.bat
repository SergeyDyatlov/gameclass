rem @echo off
rem -------------------- ��砫� 蠯�� ------------------------------------
rem ��室 � ��୥��� ��४��� �஥�
for /l %%i in (1,1,8) do if not exist rootdir cd ..
rem ��砫�� ࠡ�稩 ��⠫�� ��� ��� ������� 䠩��� - ��୥��� 
rem ��४��� �஥�� (Current\ ��� 3.XX\)
rem ����������� � ���� ���᪠ Install\Src\Batch
if not -%GCMakePath%==- goto PathAlreadySet
for /d %%i in (Install\Src\Batch\) do set GCMakePath=%%~dpi
set Path=%GCMakePath%;%Path%
:PathAlreadySet
rem -------------------- ����� 蠯�� ------------------------------------

echo ������������� release-���ᨨ:

set DelphiPath=c:\Program Files (x86)\Embarcadero\Studio\15.0
set DCCLib=%DelphiPath%\lib\Win32\release
set DCCLib=%DCCLib%;%DelphiPath%\Imports
set DCCLib=%DCCLib%;%DelphiPath%\Dcp
set DCCLib=%DCCLib%;%DelphiPath%\include
set DCCLib=%DCCLib%;C:\Program Files (x86)\FastReports\LibD21
set DCCLib=%DCCLib%;C:\Program Files (x86)\Raize\CS5\Lib\RS-XE7\Win32
set DCCLib=%DCCLib%;%PRootDir%\Components\dcef3\src
set DCCLib=%DCCLib%;%PRootDir%\Components\FastMM\
set DCCLib=%DCCLib%;%PRootDir%\Components\Ehlibv7\RADStudioXE7
set DCCLib=%DCCLib%;%PRootDir%\Components\ExtControll
set DCCLib=%DCCLib%;%PRootDir%\Components\rxlib\units
set DCCLib=%DCCLib%;%PRootDir%\Components\SynEdit\Source
set DCCLib=%DCCLib%;%PRootDir%\Components\VirtualTreeviewV5.3.0\Source
set DCCLib=%DCCLib%;%PRootDir%\Components\y2kControls\Current\Product\Src
set DCCLib=%DCCLib%;%PRootDir%\Components\jedi\jcl\jcl\lib\d21\win32
set DCCLib=%DCCLib%;%PRootDir%\Components\jedi\jcl\jcl\source\include
set DCCLib=%DCCLib%;%PRootDir%\Components\jedi\jvcl\jvcl\lib\D21\win32
set DCCLib=%DCCLib%;%PRootDir%\Components\jedi\jvcl\jvcl\common
set DCCLib=%DCCLib%;%PRootDir%\Components\jedi\jvcl\jvcl\Resources
set DCCLib=%DCCLib%;%PRootDir%\Components\Ehlibv7\RADStudioXE7\Win32\Release
set DCCLib="%DCCLib%"

set DCCLogs=Install\Src\Logs
set DCCOutput=Output\Release
set DCCDcu=Output\Dcu\Release
set DCC32="%DelphiPath%\bin\dcc32.exe"

rem ����塞 exe � dcu
del %DCCOutput%\*.* /q 2>nul
del %DCCDcu%\*.* /q 2>nul
rem ���樠������ ��ࠡ�⪨ ���-䠩��
del %DCCLogs%\ErrorCheck.txt 2>nul
Set error_check=

rem ���������
set DCCFlags=GC3SERVER,ASPROTECT
set DCCProjectPath=Server
set DCCProjectName=GCServer.dpr
set DCCReturnPath=..
call Install\Src\Batch\compile_project

set DCCFlags=ASPROTECT
set DCCProjectPath=Security\OSql
set DCCProjectName=GCOsql
set DCCReturnPath=..\..
call Install\Src\Batch\compile_project.bat

set DCCFlags=ASPROTECT
set DCCProjectPath=BackupRestore
set DCCProjectName=GCBackupRestore
set DCCReturnPath=..
call Install\Src\Batch\compile_project.bat
rem �� ��������� ���㫥�

for /f %%i in (%DCCLogs%\ErrorCheck.txt) DO @SET error_check=%%i
if "%error_check%"=="" goto no_error
echo �訡�� �������樨 !
pause
more %DCCLogs%\ErrorCheck.txt
pause
exit
:no_error
echo ��������� �����襭� �ᯥ譮.
del %DCCLogs%\ErrorCheck.txt >nul
