unit uGCDevices;

interface

uses Classes,
     uClientInfoConst;
type
  // ��� ����������
  TDevicetype = ( DeviceType_PC,              // ����
                  DeviceType_SNMP,
                  DeviceType_Uncnoun );       // SNMP-�������
  TGCDevice = class
    public
      online:Boolean;                         // ���������� � ����
      controled: Boolean;                     // ���������� �����������
      constructor Create;
      function GetDiviceType:TDevicetype;     // ��������� ���� ����������
      procedure SetState(State:TClientState); // ��������� ��������� ����������

      function SendData(data:WideString):boolean;
      function PowerOff: Boolean;
      function PowerOn: Boolean;
      function Reboot: Boolean;
      function Logoff: Boolean;
  end;


implementation

{ TDevice }

constructor TGCDevice.Create;
begin
  online:=false;
  controled:=false;
end;

function TGCDevice.GetDiviceType: TDevicetype;
begin
  result:=DeviceType_Uncnoun;
end;

function TGCDevice.Logoff: Boolean;
begin
  result := false;
end;

function TGCDevice.PowerOff: Boolean;
begin
  result := false;
end;

function TGCDevice.PowerOn: Boolean;
begin
  result := false;
end;

function TGCDevice.Reboot: Boolean;
begin
  result := false;
end;

function TGCDevice.SendData(data: WideString): boolean;
begin
  result := false;
end;

procedure TGCDevice.SetState(State: TClientState);
begin

end;

end.
