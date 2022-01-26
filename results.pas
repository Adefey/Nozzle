unit Results;

{$mode objfpc}{$H+}

interface

uses
  DataTypes, Functions;

function ProcessAllData(given: InputData): ResultData;

implementation

function ProcessAllData(given: InputData): ResultData;
var
  i: UIntPtr;
  res: ResultData;
begin
  Initialize(res);
  setlength(res.beta, given.CutCount);
  GeneratePrimaryData(res.beta, res.i_critical, given.CutCount,
    given.P_exit, given.P_0, given.k);
  setlength(res.Pressure, given.CutCount);
  setlength(res.Temperature, given.CutCount);
  setlength(res.RelativeVolume, given.CutCount);
  setlength(res.Density, given.CutCount);
  setlength(res.SoundSpeed, given.CutCount);
  setlength(res.StreamSpeed, given.CutCount);
  setlength(res.MachNumber, given.CutCount);
  setlength(res.CutArea, given.CutCount);
  setlength(res.Diameter, given.CutCount);
  setlength(res.NozzleLength, given.CutCount);

  for i := 0 to given.CutCount - 1 do
    //Вычисление по очереди всех параметров для каждого сечения
  begin
    res.Pressure[i] := FindPressure(res.beta[i], given.P_0);
    res.Temperature[i] := FindTemperature(res.beta[i], given.T_0, given.k);
    res.RelativeVolume[i] := FindRelatuveVolume(res.Pressure[i],
      res.Temperature[i], given.R);
    res.Density[i] := FindDensity(res.RelativeVolume[i]);
    res.SoundSpeed[i] := FindSoundSpeed(res.Temperature[i], given.k, given.R);
    res.StreamSpeed[i] := FindStreamSpeed(res.Temperature[i], given.T_0,
      given.R, given.k);
    res.MachNumber[i] := FindMachNumber(res.StreamSpeed[i], res.SoundSpeed[i]);
    res.CutArea[i] := FindCutArea(res.Density[i], res.StreamSpeed[i], given.G);
    res.Diameter[i] := FindDiameter(res.CutArea[i]);
  end;

  for i := 0 to res.i_critical - 1 do
    //Нахождение длины дозвуковой части
    res.NozzleLength[i] := FindSubSonicLegth(res.Diameter[i],
      res.Diameter[res.i_critical], given.alpha_2);

  if (FindSubSonicLegth(res.Diameter[res.i_critical], res.Diameter[res.i_critical],
    given.alpha_2) = FindSuperSonicLength(res.Diameter[res.i_critical],
    res.Diameter[res.i_critical], given.alpha_1)) then
    res.NozzleLength[res.i_critical] := 0;
  //Нахождение длины в критическом сечении не имеет смысла, так как все равно получится 0, но я оставил на всякий случай.

  for i := res.i_critical + 1 to given.CutCount - 1 do
    //Нахождение длины сверхзвуковой части
    res.NozzleLength[i] := FindSuperSonicLength(res.Diameter[i],
      res.Diameter[res.i_critical], given.alpha_1);

  res.TotalLength := FindTotalLength(res.NozzleLength);
  //Нахождение суммарной длины

  Result := res;
end;

end.
