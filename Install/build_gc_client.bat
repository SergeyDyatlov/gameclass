@echo off
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
set PRootDir=k:\Projects\gameclass
rem -------------------- ����� 蠯�� ------------------------------------

set BASE_VERSION=3.85.7
set APP_VERSION=3.85.7 Alpha
set CLIENT_VERSION=3.85.7
set SQL_SCRIPT_VERSION=3857

rem Install\src\Batch\gc_replace_versions.vbs "%BASE_VERSION%" "%APP_VERSION%"
echo ����ࠥ��� ����� %APP_VERSION%
rem ToDo need compile GameClass.chm

rem ��������� exe-䠩���
call compile_release_gc_client.bat


rem �����⮢�� 䠩��� ��� ᮧ����� ����ਡ�⨢�:
call copy_packages_files_client.bat
cd Install\Src\NSIS
"c:\Program Files (x86)\NSIS\makensis.exe" gc_client.nsi

pause