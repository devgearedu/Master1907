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

    function Add( _opdA, _opdB:real): real;
    function Sub( _opdA, _opdB:real): real;
    function Multi( _opdA, _opdB:real): real;
    function Divide( _opdA, _opdB:real): extended;
    function Accumulate(_opds_Arr, _symbols:array of string): string;

  public
    constructor create;
  end;


implementation

{ TCalc }


function TCalc.Add(_opdA, _opdB: real): real;
begin
  Result := _opdA + _opdB;
end;

function TCalc.Sub(_opdA, _opdB: real): real;
begin
  Result := _opdA - _opdB;
end;

function TCalc.Multi(_opdA, _opdB: real): real;
begin
  Result := _opdA * _opdB;
end;

function TCalc.Divide(_opdA, _opdB: real): extended;
begin
  try
    Result:=_opdA / _opdB;
  except
    on e: EMathError do
      showMessage('0���� ���� �� �����ϴ�.');
  end;
end;


function TCalc.Accumulate(_Opds_Arr, _Symbols: array of string): string;
var
  I,J,K : integer; // for loops
  opdsLen, symbolsLen: integer;  //  setLength ����� �� ��� �ε����� ���
  LC:integer;  // �б⸦ ���� ���� ī��Ʈ
  extA : extended;
  accResult:string;

begin
  I:=0;
  LC:=0;
  opdsLen := Length(_opds_Arr);
  symbolsLen := Length(_Symbols);
  //Len:=Length(_Opds_Arr);

  while Length(_Opds_Arr) > 1 do
  begin
    LC:=LC+1;

    if _Symbols[I] = '*' then
    begin
      _Opds_Arr[I]:=floattostr(Multi(strtofloat(_Opds_Arr[I]),strtofloat(_Opds_Arr[I+1])));

      for J := I to symbolsLen-2 do
      begin
        _Opds_Arr[J+1] := _Opds_Arr[J+2];
        _Symbols[J] := _Symbols[J+1];
      end;

      symbolsLen:=symbolsLen-1;
      opdsLen:=opdsLen-1;


      accResult:=_Opds_Arr[I];

      I:=0;
    end
    else
      if _Symbols[I] = '/' then
      begin

        extA:=Divide(strtofloat(_Opds_Arr[I]),strtofloat(_Opds_Arr[I+1]));
        _Opds_Arr[I] :=floattostr(extA);
        for J := I to symbolsLen-2 do
        begin
          _Opds_Arr[J+1] := _Opds_Arr[J+2];
          _Symbols[J] := _Symbols[J+1];
        end;

        symbolsLen:=symbolsLen-1;
        opdsLen:=opdsLen-1;


        accResult:=_Opds_Arr[I];

        I:=0;
      end
      else
        I:=I+1;

    if LC > Length(_Opds_Arr) then
      break;
  end;
  // �� �Է� �� ������ �������� ���� ����


  for K := 0 to symbolsLen-1 do
  begin
    if _Symbols[K] = '+' then
    begin
      _Opds_Arr[K+1]:=floattostr(Add(strtofloat(_Opds_Arr[K]),strtofloat(_Opds_Arr[K+1])));
    end
    else
    begin
      if _Symbols[K] = '-' then
        _Opds_Arr[K+1]:=floattostr(Sub(strtofloat(_Opds_Arr[K]),strtofloat(_Opds_Arr[K+1])));
    end;
  end;

  accResult:=_Opds_Arr[opdsLen-1];

  Result:=accResult;
end;

constructor TCalc.create;
begin

end;

end.
