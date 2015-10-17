//////////////////////////////////////////////////////////////////////////////
//
// ������ �������� ��������� GetInstallDirectory.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientInstallDirectory;

interface

    //����� � ���. ���������� ������
    function InstallDirectory: String;


implementation
uses
  SysUtils,
  Forms,
  uClientOptionsConst,
  Windows,
  Registry,
  uY2KCommon;

var
  GstrInstallDirectory: String;


function GetInstallDirectory: String;
begin
  Result := ExtractFileDir(Application.ExeName);
end;

function InstallDirectory: String;
begin
//  Result := GstrInstallDirectory;
  Result := ExtractFileDir(Application.ExeName);
end;


initialization
  GstrInstallDirectory := GetInstallDirectory;


end.


