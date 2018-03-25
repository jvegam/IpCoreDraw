unit uglobal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,StdCtrls;

type
  TMyInput = record
    Add: TCheckBoxState;
    PortName: string;
    Direction: string;
    CheckBox: TCheckBoxState;
    MSB: string;
    LSB: string;
  end;

var
  DataEntity: array of TMyInput;
  IP_Image_width:Real;
  UpdateImage:Boolean;
const
  PosAdd = 0;
  PosPortName = 1;
  PosDirection = 2;
  PosCheckBox = 3;
  PosMSB = 4;
  PosLSB = 5;

implementation



end.

