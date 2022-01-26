unit DataTypes;

{$mode objfpc}{$H+}

interface

type
  DataType = double;
  //Тип используемых данных - число с плавающей точкой двойной точности

  DataArray = array of DataType;
  //Тип массива данных для десяти значений

  InputData = record
    //Структура, содержащая в себе начальные данные о сопле
    CutCount: integer;
    R: DataType;
    k: DataType;
    P_0: DataType;
    T_0: DataType;
    P_exit: DataType;
    G: DataType;
    alpha_1: DataType;
    alpha_2: DataType;
  end;

  ResultData = record //Структура, содержащая в себе решение
    beta: DataArray;
    Pressure: DataArray;
    Temperature: DataArray;
    RelativeVolume: DataArray;
    Density: DataArray;
    SoundSpeed: DataArray;
    StreamSpeed: DataArray;
    MachNumber: DataArray;
    CutArea: DataArray;
    Diameter: DataArray;
    NozzleLength: DataArray;
    TotalLength: DataType;
    i_critical: UIntPtr;
  end;

implementation

end.
