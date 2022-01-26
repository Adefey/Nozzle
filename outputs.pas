unit Outputs;

{$mode objfpc}{$H+}

interface

uses DataTypes;

procedure PrintAllData(given: InputData; resParams: ResultData);

implementation

procedure PrintAllData(given: InputData; resParams: ResultData);
var
  i: UIntPtr;
begin
  Writeln('Beta: ': 16, 'Pressure': 16, 'Temperature': 16, 'Relative volume': 16, 'Density': 16, 'Sound speed': 16, 'Stream speed': 16, 'Mach number': 16, 'Cut area': 16, 'Diameter': 16, 'Length part': 16);
  //Вывод всех значений
  for i := 0 to given.CutCount - 1 do
  begin
    Writeln(resParams.beta[i]: 16: 6, resParams.Pressure[i]: 16: 6, resParams.Temperature[i]: 16: 6, resParams.RelativeVolume[i]: 16: 6, resParams.Density[i]: 16: 6, resParams.SoundSpeed[i]: 16: 6, resParams.StreamSpeed[i]: 16: 6, resParams.MachNumber[i]: 16: 6, resParams.CutArea[i]: 16: 6, resParams.Diameter[i]: 16: 6, resParams.NozzleLength[i]: 16: 6);
  end;
  Write('Total nozzle length: ': 20); //Вывод суммарной длины
  WriteLn(resParams.TotalLength: 16: 6);
end;

end.
