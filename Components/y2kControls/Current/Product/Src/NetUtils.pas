unit NetUtils;
interface
uses Windows, Classes;
function GetContainerList(ListRoot:PNetResource):TList; Type
  {$H+}
   PNetRes = ^TNetRes;
   TNetRes = Record
             dwScope       : Integer;
             dwType        : Integer;
             dwDisplayType : Integer;
             dwUsage       : Integer;
             LocalName     : String;
             RemoteName    : String;
             Comment       : String;
             Provider      : String;
           End;
  {H-}

implementation
uses SysUtils;
 type
 PnetResourceArr = ^TNetResource; {TNetResource - ��� ������,
                      ������������� TNetRes, �� ����������� ����, ���
                      ������ ����� string ��� ���� PChar. }

 function GetContainerList(ListRoot: PNetResource):TList;
{���������� ������ ������� ��� � ��������� ListRoot, ������
������� ������ TList - ��� PNetRes, ��� ���� RemoteName ����������
�������������� ������� ��� �������� ������. ���� ListRoot=nil, ��
������������ ����� ������� ������� ����:
1. Microsoft Windows Network
2. Novell Netware Network
����� �������� ������ �������/������� ����� ���� Microsoft, �����
������� ��� ������� ������ ���, ������� �� � �������� ���������,
��������������� ������� ������, ����������� ��� ������ � ������.
����� �������� ������ ����������� ������ - ������� ������ ���...}
{������������, � �� ���� ��� ������ ��� �������� ������.}
Var
  TempRec     : PNetRes;
  Buf         : Pointer;
  Count,
  BufSize,
  Res         : DWORD;
  lphEnum     : THandle;
  p           : PNetResourceArr;
  i           : SmallInt;
  NetworkList : TList;
Begin
  NetworkList := TList.Create;
  Result:=nil;
  BufSize := 8192;
  GetMem(Buf, BufSize);
  Try
    Res := WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_DISK,
RESOURCEUSAGE_CONTAINER{0}, ListRoot,lphEnum);
    {� ���������� �������� ������ lphEnum}
    If Res <> 0 Then Raise Exception(Res);
    Count := $FFFFFFFF; {������� ������ ������� ������� �
������, ������� ����}
    Res := WNetEnumResource(lphEnum, Count, Buf, BufSize); {� ������ Buf - ��������
                         � ���� ������� ���������� �� ��������� ���� TNetResourceArr
                         � � Count - ����� ���� ��������}
    If Res = ERROR_NO_MORE_ITEMS Then Exit;
    If (Res <> 0) Then Raise Exception(Res);
    P := PNetResourceArr(Buf);
    For I := 0 To Count - 1 Do
    Begin                   //��������� ����������� �� ������, ��� ��� ��
      New(TempRec);         //������������ ������ �� ����������  ������ ������� ������ WNet
      TempRec^.dwScope := P^.dwScope;
      TempRec^.dwType := P^.dwType ;
      TempRec^.dwDisplayType := P^.dwDisplayType ;
      TempRec^.dwUsage := P^.dwUsage ;
      TempRec^.LocalName := StrPas(P^.lpLocalName);  {�������  ����� ��� ��� ���������}
      TempRec^.RemoteName := StrPas(P^.lpRemoteName); {� ������  - ������ PChar}
      TempRec^.Comment := StrPas(P^.lpComment);
      TempRec^.Provider := StrPas(P^.lpProvider);
      NetworkList.Add(TempRec);
      Inc(P);
    End;
    Res := WNetCloseEnum(lphEnum);
    {� ��������� ����� - ��� ��!}
    If Res <> 0 Then Raise Exception(Res);
    Result:=NetWorkList;
    Finally
      FreeMem(Buf);
  End;
End;

end.


