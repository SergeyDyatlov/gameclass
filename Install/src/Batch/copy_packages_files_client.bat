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
rem Client
copy Output\Release\gccl.exe Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\gcclsrv.exe Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\ProcUtils.dll Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\winhkg.dll Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
xcopy Install\Src\Files\Client\*.* Install\Src\Packages\Client /E /Y>>Install\Src\Logs\CopyPackagesFiles.log| ech .
xcopy Install\Src\Files\Skins\*.* Install\Src\Packages\Client\Skins\ /E /Y >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem copy Install\Src\Files\Skins\full\*.* Install\Src\Packages\Client\Skins\full\ >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem copy Install\Src\Files\Skins\new\*.* Install\Src\Packages\Client\Skins\new\ >>Install\Src\Logs\CopyPackagesFiles.log| ech .

copy Install\Src\Files\Sounds\*.* Install\Src\Packages\Client\Sounds >>Install\Src\Logs\CopyPackagesFiles.log| ech .

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
