rem @echo on
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
call create_directories.cmd

rem ���樠������ ��ࠡ�⪨ ���-䠩��
del Install\Src\Logs\CopyPackagesFiles.log >nul 2>nul
Set error_check=

ech "  ����஢���� 䠩��� ��� ���⠫��樨 "
rem ������� ��������� � for �⮡� �� ����஢��� 䠩�� vssver.scc ���५�
rem for /r Install\Src\Files\Presetup %%i in (*.*) do if not -%%~xi==-.scc copy "%%~fi" Install\Src\Packages\Presetup >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem �������� ��������� � for /f �� �ப�⨫�
rem for /f "usebackq tokens=*" %%i in (`dir /b DataBase\Reports\*.xml`) do copy "%%~fi" Install\Src\Packages\DataBase >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Presetup
copy Install\Src\Files\Presetup\*.* Install\Src\Packages\Presetup >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\License.txt Install\Src\Packages\Presetup >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Database
copy DataBase\dbconfig.xml Install\Src\Packages\DataBase >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy DataBase\Reports\*.xml Install\Src\Packages\DataBase >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\GCosql.exe Install\Src\Packages\DataBase >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Server
copy Output\Release\GCServer.exe Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem copy Output\Release\GCKern.dll Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\GCBackupRestore.exe Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Debug\server\GCServer.lng Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Debug\server\FastMM_FullDebugMode.dll Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\Russian.lng Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\Help\GameClass.chm Install\Src\Packages\Server\GCServerRus.chm >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\Help\GameClass.chm Install\Src\Packages\Server\GCServerEng.chm >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Server\*.* Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Scripts\*.* Install\Src\Packages\Server\Scripts >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\WhatsNew.txt Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\readme.txt Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy "Install\src\Files\Traffic Inspector Plug-In"\*.* "Install\Src\Packages\Server\Traffic Inspector Plug-In" >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy "Install\Src\Files\UserGate Plug-In"\*.* "Install\Src\Packages\Server\UserGate Plug-In" >>Install\Src\Logs\CopyPackagesFiles.log| ech .

:lab

find "���⥬� �� 㤠���� ���� 㪠����� ����" <Install\Src\Logs\CopyPackagesFiles.log >Install\Src\Logs\CopyPackagesFiles.txt
find "System cannot find the path specified" <Install\Src\Logs\CopyPackagesFiles.log >>Install\Src\Logs\CopyPackagesFiles.txt
for /f %%i in (Install\Src\Logs\CopyPackagesFiles.txt) DO @SET error_check=%%i 
if "%error_check%"=="" goto no_error
echo  �訡��
pause
more Install\Src\Logs\CopyPackagesFiles.txt
pause
exit
:no_error
echo  OK
del Install\Src\Logs\CopyPackagesFiles.txt >nul 2>nul
del Install\Src\Logs\CopyPackagesFiles.log >nul 2>nul
