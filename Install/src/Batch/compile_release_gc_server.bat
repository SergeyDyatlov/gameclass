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

call init_compile.bat

rem ���������
set DCCFlags=GC3SERVER,ASPROTECT
set DCCProjectPath=Server
set DCCProjectName=GCServer.dpr
set DCCPType=exe
set DCCReturnPath=..
call Install\Src\Batch\compile_project

set DCCFlags=ASPROTECT
set DCCProjectPath=Security\OSql
set DCCProjectName=GCOsql
set DCCPType=exe
set DCCReturnPath=..\..
call Install\Src\Batch\compile_project.bat

set DCCFlags=ASPROTECT
set DCCProjectPath=BackupRestore
set DCCProjectName=GCBackupRestore
set DCCPType=exe
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
