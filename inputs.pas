unit Inputs;

{$mode objfpc}{$H+}

interface

uses
  DataTypes, SysUtils;

function GetAllData(): InputData;

implementation

function GetAllData(): InputData;
var
  res: InputData;
begin
  res.CutCount := StrToInt(ParamStr(1));
  res.R := StrToFloat(ParamStr(2));
  res.k := StrToFloat(ParamStr(3));
  res.P_0 := StrToFloat(ParamStr(4));
  res.T_0 := StrToFloat(ParamStr(5));
  res.P_exit := StrToFloat(ParamStr(6));
  res.G := StrToFloat(ParamStr(7));
  res.alpha_1 := StrToFloat(ParamStr(8)) / 180 * Pi;
  res.alpha_2 := StrToFloat(ParamStr(9)) / 180 * Pi;
  Result := res;
end;

end.
