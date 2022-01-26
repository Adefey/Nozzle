unit Functions;

{$mode objfpc}{$H+}

interface

uses
  DataTypes, Math;

procedure GeneratePrimaryData(var beta: DataArray; var i_critical: UIntPtr;
  CutCount: integer; var P_exit, P_0, k: DataType);
function FindPressure(beta, P_0: DataType): DataType;
function FindTemperature(beta, T_0, k: DataType): DataType;
function FindRelatuveVolume(P, T, R: DataType): DataType;
function FindDensity(v: DataType): DataType;
function FindSoundSpeed(T, k, R: DataType): DataType;
function FindStreamSpeed(T, T_0, R, k: DataType): DataType;
function FindMachNumber(w, a: DataType): DataType;
function FindCutArea(rho, w, G: DataType): DataType;
function FindDiameter(f: DataType): DataType;
function FindSubSonicLegth(d, d_cr, alpha_2: DataType): DataType;
function FindSuperSonicLength(d, d_cr, alpha_1: DataType): DataType;
function FindTotalLength(l: DataArray): DataType;

implementation

procedure GeneratePrimaryData(var beta: DataArray; var i_critical: UIntPtr;
  CutCount: integer; var P_exit, P_0, k: DataType);
var
  i: UIntPtr;
  low, max, stride, beta_critical: DataType;
begin
  low := P_exit / P_0 + 0.001;
  max := 1 - 0.001;
  stride := (max - low) / (CutCount - 1);
  for i := 0 to CutCount - 1 do
    beta[i] := max - stride * i;
  beta_critical := Power(2 / (k + 1), k / (k - 1));
  i_critical := 0;
  for i := 0 to CutCount - 1 do
    if abs(beta[i] - beta_critical) < abs(beta[i_critical] - beta_critical) then
      i_critical := i;
  beta[i_critical] := beta_critical;
end;

function FindPressure(beta, P_0: DataType): DataType;
  //Нахождение давления
begin
  Result := beta * P_0;
end;

function FindTemperature(beta, T_0, k: DataType): DataType;
  //Нахождение темературы
begin
  Result := T_0 * Power(beta, (k - 1) / k);
end;

function FindRelatuveVolume(P, T, R: DataType): DataType;
  //Нахождение удельного объема
begin
  Result := R * T / P;
end;

function FindDensity(v: DataType): DataType; //Нахождение плотности
begin
  Result := 1 / v;
end;

function FindSoundSpeed(T, k, R: DataType): DataType;
  //Нахождение местной скорости звука
begin
  Result := sqrt(k * R * T);
end;

function FindStreamSpeed(T, T_0, R, k: DataType): DataType;
  //Нахождение скорости потока
begin
  Result := sqrt((2 * k) / (k - 1) * R * (T_0 - T));
end;

function FindMachNumber(w, a: DataType): DataType;
  //Нахождение числа Маха
begin
  Result := w / a;
end;

function FindCutArea(rho, w, G: DataType): DataType;
  //Нахождение площади сечения
begin
  Result := G / (rho * w);
end;

function FindDiameter(f: DataType): DataType;
  //Нахождение диаметра сечения
begin
  Result := sqrt(4 * f / Pi);
end;

function FindSubSonicLegth(d, d_cr, alpha_2: DataType): DataType;
  //Нахождение длины дозвуковой части сопла, считая от критического сечения
begin
  Result := (d - d_cr) / (2 * Tan(alpha_2 / 2));
end;

function FindSuperSonicLength(d, d_cr, alpha_1: DataType): DataType;
  //Нахождение длины сверхзвуковой части сопла, считая от критического сечения
begin
  Result := (d - d_cr) / (2 * Tan(alpha_1 / 2));
end;

function FindTotalLength(l: DataArray): DataType;
  //Нахождение суммарной длины сопла
var
  res: DataType = 0;
begin
  res := l[0] + l[high(l)];
  Result := res;
end;

end.
