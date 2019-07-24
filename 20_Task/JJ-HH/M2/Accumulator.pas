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
    function Accumulate(_opds_Arr:array of Float64; _symbols:array of string): string;

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


function TCalc.Accumulate(_Opds_Arr: array of Float64; _Symbols: array of string): string;
var
  I,J,K : integer; // for loops
  tmpOpd : array of Float64;
  tmpSym : array of string;  //  setLength ����� �� ��� �迭 ���
  LC:integer;  // Break�� ���� Loop Count
  extA : extended;
  accResult:Float64;  //  ���� �����

begin
  LC:=0;
  SetLength(tmpOpd, Length(_Opds_Arr));
  SetLength(tmpSym, Length(_Symbols));
  for I := 0 to Length(_symbols)-1 do
  begin
    tmpOpd[I] := _opds_Arr[I];
    tmpSym[I] := _symbols[I];
    //ShowMessage('sym:'+tmpSym[I]);
    //ShowMessage('opd:'+ FloatToStr(tmpopd[I]));

  end;
  tmpOpd[Length(_Opds_ARr)-1] := _Opds_ARr[Length(_Opds_ARr)-1];
  //ShowMessage('opd:'+ FloatToStr(tmpopd[Length(_Opds_ARr)-1]));

  I:=0;


 // �� �Է� �� ������ �������� ���� ����,
  while Length(tmpOpd) > 1 do
  begin
    LC:=LC+1;
    if tmpSym[I] = '*' then
    begin
      tmpOpd[I]:=Multi(tmpOpd[I],tmpOpd[I+1]);

      for J := I to Length(tmpSym)-2 do
      begin
        tmpOpd[J+1] := tmpOpd[J+2];
        tmpSym[J] := tmpSym[J+1];
      end;

      SetLength(tmpSym, Length(tmpSym)-1);
      SetLength(tmpOpd, Length(tmpOpd)-1);

      //accResult:=tmpOpd[I];
      I:=0;
    end
    else
    begin
      if tmpSym[I] = '/' then
      begin

        extA:=Divide(tmpOpd[I],tmpOpd[I+1]);
        tmpOpd[I] := extA;
        for J := I to Length(tmpSym)-2 do
        begin
          tmpOpd[J+1] := tmpOpd[J+2];
          tmpSym[J] := tmpSym[J+1];
        end;

        SetLength(tmpSym, Length(tmpSym)-1);
        SetLength(tmpOpd, Length(tmpOpd)-1);

        //accResult:=tmpOpd[I];
        I:=0;

      end
      else
        I:=I+1;
    end;
    if LC > Length(tmpOpd) then
      break;
  end;
  // �� �Է� �� ������ �������� ���� ����

  for K := 0 to Length(tmpSym)-1 do
  begin

    if tmpSym[K] = '+' then
    begin
      tmpOpd[K+1]:=Add(tmpOpd[K],tmpOpd[K+1]);
    end
    else
    begin
      if tmpSym[K] = '-' then
        tmpOpd[K+1]:=Sub(tmpOpd[K],tmpOpd[K+1]);
    end;
  end;

  accResult:=tmpOpd[length(tmpOpd)-1];
  //ShowMessage(FloatToStr(accResult));
  Result:=FloatToStr(accResult);
end;

constructor TCalc.create;
begin

end;

end.
