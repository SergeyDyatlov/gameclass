unit uGCStrUtils;

interface

function FilterString(instr: string):string;
function ProtectFloatToStr(Value:Double):string;

implementation

uses
  SysUtils;

// ��������� ������ �� ������ ��������
function FilterString(instr: string):string;
var
  i: integer;
  tmpChar : AnsiString;
begin
  for i:= 1 to instr.Length do
  begin
    { ������������ ������ � s - ������ ������������ ����� }
             { TODO : ����������, �.�. �������� �������� }
    tmpChar := AnsiString(instr[i]);
    if not (Char(tmpChar [1]) in ['a'..'z', 'A'..'Z','�'..'�', '�'..'�', '0'..'9', '_', '-', '.', ' ']) then
      instr[i] := '*';
  end;
  FilterString := instr;
end;

function ProtectFloatToStr(Value:Double):string;
var
  str: string;
begin
  str := FloatToStr(Value);
  Result := StringReplace(str,',','.',[rfReplaceAll, rfIgnoreCase]);
end;

end.
 