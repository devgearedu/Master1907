unit Accumulator;

interface

Uses
  VCL.Dialogs, System.Sysutils;

type

  // TCalc : ���� ���α׷����� ������ ��� �� ��� ���� ��ȯ�ϴ�Class
  TCalc = class(TObject)
    {
      ������ ��Ģ������ �ǿ������� Ÿ��(����/�Ǽ�)�� ���� overload�� ����
      opd�� operand�� �����Դϴ�.
    }
    function Add( _opdA, _opdB:integer): integer; overload;
    function Add( _opdA, _opdB:real): real; overload;

    function Sub( _opdA, _opdB:integer): integer; overload;
    function Sub( _opdA, _opdB:real): real; overload;

    function Multi( _opdA, _opdB:integer): integer; overload;
    function Multi( _opdA, _opdB:real): real; overload;

    function Divide( _opdA, _opdB:integer): real; overload;
    function Divide( _opdA, _opdB:real): extended; overload;

  public
    constructor create;
  end;




implementation

{ TCalc }

function TCalc.Add(_opdA, _opdB: integer): integer;
begin
  Result := _opdA + _opdB;
end;

function TCalc.Add(_opdA, _opdB: real): real;
begin
  Result := _opdA + _opdB;
end;

constructor TCalc.create;
begin

end;

function TCalc.Divide(_opdA, _opdB: integer): real;
begin
    Result := _opdA / _opdB;
end;

function TCalc.Divide(_opdA, _opdB: real): extended;
begin
  Result:=_opdA / _opdB;
end;

function TCalc.Multi(_opdA, _opdB: integer): integer;
begin
  Result := _opdA * _opdB;
end;

function TCalc.Multi(_opdA, _opdB: real): real;
begin
  Result := _opdA * _opdB;
end;

function TCalc.Sub(_opdA, _opdB: integer): integer;
begin
  Result := _opdA - _opdB;
end;

function TCalc.Sub(_opdA, _opdB: real): real;
begin
  Result := _opdA - _opdB;
end;

end.
