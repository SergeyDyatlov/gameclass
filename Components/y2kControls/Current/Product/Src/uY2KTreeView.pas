//////////////////////////////////////////////////////////////////////////////
//
// TY2KTreeView
// ��������� ��������� ������������ TTreeView.
// ����� ����������� ����������� ������ �� ������ StateImages �� �����
// ���� �� ������. ������������ ��� ���������� 'CheckTreeView' �� �������� �
// CheckListBox. ������������ ���������� ����� ���������� ��������� �������:
// 1 - 2, 3 - 4 � �.�. �������� - "check", ������ - "uncheck".
// ��� ���������� ������ ����������:
//   - � ��������� ������� TImageList,
//   - ��������� � TImageList ��� ������� ��� ������,
//   - ��� �������� ��������� ������ ��� ������� �������� ������ ��������
//     StateIndex.
// *) ������� ������ �� ������������. ��������, ������ ����������
//    ������������ TTreeView ��� � �� ����������.
//
// ��������� �������� RecursiveCheck.
// ���� ����������� � True, �� ��������� StateIndex ��� ��������� ���� ������
// �� ����� ��������� ��������� ���� �������� �����. ��������! �� �������� ���
// ����������� ��������� �������� StateIndex.
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KTreeView;

interface

uses
  SysUtils,
  Classes,
  Controls,
  ComCtrls,
  Messages;

type

  //
  // TY2KTreeView
  //

  TY2KTreeView = class(TTreeView)
  private
    // fields
    FbRecursiveCheck: boolean;

    // private methods
    // ����������� ��������� ��������� StateIndex
    procedure _SetChildStateIndex(ANode: TTreeNode);
    procedure _SetParentStateIndex(ANode: TTreeNode);

  protected
    // overrided methods
    procedure WndProc(var Message : TMessage); override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState;
        X, Y : Integer); override;

  published
    // properties
    property RecursiveCheck: boolean read FbRecursiveCheck
        write FbRecursiveCheck;

  end; // TY2KTreeView

implementation

uses
  commctrl;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// overrided methods

procedure TY2KTreeView.WndProc(var Message : TMessage);
var
  node: TTreeNode;
begin
  inherited;

  if ([csDesigning, csLoading, csReading] * ComponentState) <> [] then
    Exit;

  if not FbRecursiveCheck then
    Exit;

  if not Assigned(StateImages)then
    Exit;

  if message.msg = TVM_SETITEM then begin
    if (PTVITEM(message.lparam).mask
        and (TVIF_STATE or TVIF_HANDLE)) > 0 then begin
      node := items.getnode(PTVITEM(message.lparam).hitem);
      if (node.stateindex > 0) then begin
        FbRecursiveCheck := FALSE;
        _SetChildStateIndex(node);
        _SetParentStateIndex(node);
        FbRecursiveCheck:= TRUE;
      end;
    end;
  end;
end; // TY2KTreeView.WndProc


procedure TY2KTreeView.MouseDown(Button : TMouseButton; Shift : TShiftState;
    X, Y : Integer);
var
  index: integer;
begin
   inherited;

   if Assigned(StateImages)then begin
     if(htonStateIcon in getHitTestInfoAt(x, y))then begin
       if Selected.StateIndex > 0 then
         if odd(Selected.StateIndex) then
           Selected.StateIndex := Selected.StateIndex + 1
         else
           Selected.StateIndex := Selected.StateIndex - 1;
     end;
   end;

end; // TY2KTreeView.MouseDown


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

// ��� ���� �������� ������ ���������
// � ������������ � ���������� ��������
procedure TY2KTreeView._SetChildStateIndex(ANode: TTreeNode);
var
  nodeChild: TTreeNode;
begin
  if not Assigned(ANode) then
    Exit;

  nodeChild := ANode.GetFirstChild();
  while Assigned(nodeChild) do begin
    if (odd(ANode.StateIndex) and not odd(nodeChild.StateIndex))
        or (not odd(ANode.StateIndex) and odd(nodeChild.StateIndex)) then
      if odd(nodeChild.StateIndex) then
        nodeChild.StateIndex := nodeChild.StateIndex + 1
      else
        nodeChild.StateIndex := nodeChild.StateIndex - 1;
    _SetChildStateIndex(nodeChild);
    nodeChild := ANode.GetNextChild(nodeChild);
  end;

end; // TY2KTreeView._SetStateIndex


// ��� ���� ��������� ������ ��������� ������ � ������ ������ �������
// ��������� ("���������� �������������")
procedure TY2KTreeView._SetParentStateIndex(ANode: TTreeNode);
var
  nodeParent: TTreeNode;
begin
  if not Assigned(ANode) then
    Exit;

  nodeParent := ANode.Parent;
  if Assigned(nodeParent) then begin
    if (not odd(ANode.StateIndex) and odd(nodeParent.StateIndex)) then
      if odd(nodeParent.StateIndex) then
        nodeParent.StateIndex := nodeParent.StateIndex + 1
      else
        nodeParent.StateIndex := nodeParent.StateIndex - 1;
    _SetParentStateIndex(nodeParent);
  end;

end; // TY2KTreeView._SetParentStateIndex


end. ////////////////////////// end of file //////////////////////////////////
