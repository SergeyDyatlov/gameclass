rem @echo off
rem -------------------- ������ ����� ------------------------------------
rem ����� � �������� ���������� ������
for /l %%i in (1,1,8) do if not exist rootdir cd ..
rem -------------------- ����� ����� ------------------------------------

mkdir Install\src\Logs
mkdir Output\dcu\Release
mkdir Output\Release
mkdir Output\Setup
mkdir Output\Debug\server

copy Install\Src\Files\Server\*.* Output\Debug\server

rem ������� ������ �����
del Install\src\Packages\DataBase\*.sqp 2>nul
del Install\src\Packages\DataBase\*.sql 2>nul

rem ����������� sql-������ � sqp
ech "����������� sql-������ � sqp "

for /r DataBase\SQLCode %%i in (GCBase*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" 
for /r DataBase\SQLCode %%i in (GCSync*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" 
for /r DataBase\SQLCode %%i in (mssql_pm*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" 
copy "DataBase\dbconfig.xml" "Output\Debug\sql\" 



