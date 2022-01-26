program Nozzle;

uses
  DataTypes,
  Inputs,
  Results,
  Outputs;

var
  given: InputData; //Начальные данные, считанные с запуска
  resultParams: ResultData;
  //Полученные данные путем вычисления
begin
  given := GetAllData();
  resultParams := ProcessAllData(given);
  PrintAllData(given, resultParams);
end.
