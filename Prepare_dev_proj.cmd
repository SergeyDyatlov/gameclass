rem @echo off
rem -------------------- ������ ����� ------------------------------------
rem ����� � �������� ���������� ������
for /l %%i in (1,1,8) do if not exist rootdir cd ..
rem -------------------- ����� ����� ------------------------------------

mkdir Install\src\Logs
mkdir Output\dcu\Release
mkdir Output\Release
mkdir Output\Setup


