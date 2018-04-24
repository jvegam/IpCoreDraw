unit mainformu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Grids, StdCtrls, ColorBox, ExtDlgs, ComCtrls, IniPropStorage,
  bgrabitmap, BGRABitmapTypes, BGRAGradients;

type

  { TIPCoreDrawF }

  TIPCoreDrawF = class(TForm)
    AddListColorText: TBitBtn;
    AddListColorTop: TBitBtn;
    AddListColorBottom: TBitBtn;
    ChooseColorBottom1: TStaticText;
    ChooseColorBottom2: TStaticText;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    ComponentName: TEdit;
    infoRGBText: TStaticText;
    IniPropStorage1: TIniPropStorage;
    l_Width: TLabel;
    Memo1: TMemo;
    Saveimage: TBitBtn;
    BtnGenerate: TBitBtn;
    ChooseColorBottom: TStaticText;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    infoRGBBottom: TStaticText;
    SavePictureDialog1: TSavePictureDialog;
    edWidth: TScrollBar;
    Shape1: TShape;
    GridEntity: TStringGrid;
    infoRGBTop: TStaticText;
    ChooseColorTop: TStaticText;
    StaticText1: TStaticText;
    UpdateTimer1: TTimer;
    procedure AddListColorBottomClick(Sender: TObject);
    procedure AddListColorTextClick(Sender: TObject);
    procedure AddListColorTopClick(Sender: TObject);
    procedure BtnGenerateClick(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox3Change(Sender: TObject);
    procedure ColorBox4Change(Sender: TObject);
    procedure ComponentNameChange(Sender: TObject);
    procedure GridEntityCheckboxToggled(sender: TObject; aCol, aRow: Integer;
      aState: TCheckboxState);
    procedure GridEntityEditingDone(Sender: TObject);
    procedure GridEntityGetCheckboxState(Sender: TObject; ACol, ARow: Integer;
      var Value: TCheckboxState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridEntityPickListSelect(Sender: TObject);
    procedure GridEntitySelectEditor(Sender: TObject; aCol, aRow: Integer;
      var Editor: TWinControl);
    procedure SaveimageClick(Sender: TObject);
    procedure Shape1Paint(Sender: TObject);
    procedure WidthChange(Sender: TObject);
    procedure UpdateTimer1Timer(Sender: TObject);
  private
    { private declarations }
    Bitmap:TBGRABitmap;
    procedure DrawSymbol(x,y:integer);
    procedure DrawSignal(SignalName:string;Xi,Xf,Yi,Yf:integer;Direction:String;LineBus:TCheckBoxState;TexColor,LineColor:TColor;VMSB,VLSB:String);
  public
    { public declarations }
  end;

var
  IPCoreDrawF: TIPCoreDrawF;

implementation

{$R *.lfm}

uses uglobal;

var
  CustomColorNumber:integer;
  CustomColorNumber2:integer;
  CustomColorNumber3:integer;
  Xo,Yo:integer;


{ TIPCoreDrawF }

procedure TIPCoreDrawF.BtnGenerateClick(Sender: TObject);
var
  R:TRect;
begin

  Bitmap.Fill(BGRAPixelTransparent);

  Xo:=round(Shape1.Width/8);
  Yo:=round(Shape1.Height*0.02);
  Drawsymbol(Xo,Yo);
  //DrawImage(50,clBlue);
  {if assigned(Bitmap) then
  begin
    R:=Shape1.ClientRect;
    Bitmap.Draw(Shape1.Canvas,R,false);
    //Bitmap.SaveToFile('imagen2.png');
  end;
   }
  Shape1.Invalidate;
end;

procedure TIPCoreDrawF.ColorBox1Change(Sender: TObject);
var
  R,G,B:Byte;
begin
  // Obtiene el valor del RGB y lo muestra en infoRGBTop
  RedGreenBlue(ColorBox1.Selected,R,G,B);
  infoRGBTop.Caption:= 'R: '+ Format('%.3d',[R])+' G: '+ Format('%.3d',[G])+ ' B: '+ Format('%.3d',[B]) ;
  if(ColorBox1.ItemIndex=0) then
    AddListColorTop.Enabled:=True    // habilitar boton de agregar a la lista
  else
    AddListColorTop.Enabled:=False;
  UpdateImage:=true;
end;

procedure TIPCoreDrawF.ColorBox2Change(Sender: TObject);
var
  R,G,B:Byte;
begin
  // Obtiene el valor del RGB y lo muestra en infoRGBTop
  RedGreenBlue(ColorBox2.Selected,R,G,B);
  infoRGBBottom.Caption:= 'R: '+ Format('%.3d',[R])+' G: '+ Format('%.3d',[G])+ ' B: '+ Format('%.3d',[B]) ;
  if(ColorBox2.ItemIndex=0) then
    AddListColorBottom.Enabled:=True    // habilitar boton de agregar a la lista
  else
    AddListColorBottom.Enabled:=False;
  UpdateImage:=true;
end;

procedure TIPCoreDrawF.ColorBox3Change(Sender: TObject);
var
  R,G,B:Byte;
begin
  // Obtiene el valor del RGB y lo muestra en infoRGBTop
  RedGreenBlue(ColorBox3.Selected,R,G,B);
  infoRGBText.Caption:= 'R: '+ Format('%.3d',[R])+' G: '+ Format('%.3d',[G])+ ' B: '+ Format('%.3d',[B]) ;
  if(ColorBox3.ItemIndex=0) then
    AddListColorText.Enabled:=True    // habilitar boton de agregar a la lista
  else
    AddListColorText.Enabled:=False;
  UpdateImage:=true;
end;

procedure TIPCoreDrawF.ColorBox4Change(Sender: TObject);
begin
  UpdateImage:=true;
end;

procedure TIPCoreDrawF.ComponentNameChange(Sender: TObject);
begin
   UpdateImage:=true;
end;

procedure TIPCoreDrawF.AddListColorTopClick(Sender: TObject);
var
  NameCustom:string;
begin
  if (ColorBox1.ItemIndex=0)then
    begin
       NameCustom:= 'Custom_'+IntToStr(CustomColorNumber);
       ColorBox1.AddItem(NameCustom,TObject(PtrInt(ColorBox1.Selected)) );
       CustomColorNumber:=CustomColorNumber+1;

    end;
end;

procedure TIPCoreDrawF.AddListColorBottomClick(Sender: TObject);
var
  NameCustom:string;
begin
  if (ColorBox2.ItemIndex=0)then
  begin
       NameCustom:= 'Custom_'+IntToStr(CustomColorNumber2);
       ColorBox2.AddItem(NameCustom,TObject(PtrInt(ColorBox2.Selected)));
       CustomColorNumber2:=CustomColorNumber2+1;
  end;
end;

procedure TIPCoreDrawF.AddListColorTextClick(Sender: TObject);
var
  NameCustom:string;
begin
  if (ColorBox3.ItemIndex=0)then
    begin
       NameCustom:= 'Custom_'+IntToStr(CustomColorNumber2);
       ColorBox3.AddItem(NameCustom,TObject(PtrInt(ColorBox3.Selected)));
       CustomColorNumber3:=CustomColorNumber3+1;
    end;

end;

procedure TIPCoreDrawF.GridEntityCheckboxToggled(sender: TObject; aCol,
  aRow: Integer; aState: TCheckboxState);
begin
    if (ARow > 0) and (ACol = PosCheckBox) then
     DataEntity[aRow-1].CheckBox := aState;
    if (ARow > 0) and (ACol = PosAdd) then
     DataEntity[aRow-1].Add := aState;

    UpdateImage:=true;
end;

procedure TIPCoreDrawF.GridEntityEditingDone(Sender: TObject);
var
  tmpGrid: TStringGrid;
  aRow,aCol:integer;
begin
   tmpGrid:= TStringGrid(Sender);
   aCol:=tmpGrid.col;
   aRow:=tmpGrid.row;

   //ShowMessage('aCol'+IntToStr(aCol)+ ' aROW' + IntToStr(aRow));

    if (ARow > 0) and (ACol = PosPortName) then
     begin
      DataEntity[ARow-1].PortName:= GridEntity.Cells[aCol,aRow];
       //ShowMessage('aCol'+IntToStr(aCol)+ ' aROW' + IntToStr(aRow));
       if (GridEntity.Cells[aCol,aRow] <> '') then  //Si Hay un valor escrito en Portname
         begin
             if (GridEntity.Cells[aCol+1,ARow] = '') then
             begin
              GridEntity.Cells[aCol+1,ARow]:='in';
              DataEntity[ARow-1].Direction:= 'in';
             end;
             //if TCheckboxState(GridEntity.Objects[aCol+2,ARow])=cbGrayed then tmpGrid.Objects[aCol+2,ARow]:=TCheckboxState(cbUnchecked);// Bus
             //if TCheckboxState(GridEntity.Objects[aCol-1,ARow])=cbGrayed then TCheckboxState(GridEntity.Objects[aCol-1,ARow]).cbChecked; // ADD

            DataEntity[ARow-1].Add:=cbChecked;         // habilitar el ADD
            DataEntity[ARow-1].CheckBox:=cbUnChecked;  // habilitar el Bus

         end;

     end;

     if (ARow > 0) and (ACol=PosMSB) then DataEntity[ARow-1].MSB:= GridEntity.Cells[aCol,aRow];
     if (ARow > 0) and (ACol=PosLSB) then DataEntity[ARow-1].LSB:= GridEntity.Cells[aCol,aRow];

     UpdateImage:=true;
end;

procedure TIPCoreDrawF.GridEntityGetCheckboxState(Sender: TObject; ACol,
  ARow: Integer; var Value: TCheckboxState);
begin
  if (ARow > 0) and (ACol = PosCheckBox) then
   Value := DataEntity[ARow-1].CheckBox;
  if (ARow > 0) and (ACol = PosAdd) then
   Value := DataEntity[ARow-1].Add;
  UpdateImage:=true;
end;

procedure TIPCoreDrawF.DrawSymbol(x, y: integer);

function Interp256(value1,value2,position: integer): integer; inline;
begin
     result := (value1*(256-position) + value2*position) shr 8;
end;

function Interp256(color1,color2: TBGRAPixel; position: integer): TBGRAPixel; inline;
begin
     result.red := Interp256(color1.red,color2.red, position);
     result.green := Interp256(color1.green,color2.green, position);
     result.blue := Interp256(color1.blue,color2.blue, position);
     result.alpha := Interp256(color1.alpha,color2.alpha, position);
end;

function CreateGradient(tx,ty: integer;ColorTop,ColorBottom:TColor): TBGRABitmap;
var
  AGradInfo: array [0..1] of TnGradientInfo;
  BGRAcolor: TBGRAPixel;
begin
  AGradInfo[0].Direction:=gdVertical;
  AGradInfo[0].endPercent:=1.0;
  AGradInfo[0].StartColor:=ColorToBGRA(ColortoRGB(ColorTop)); //TColor($D69700)  BGRA(0,0,0,200);

  //Obtiene los componentes RGB del color seleccionado
  RedGreenBlue(ColorBottom,BGRAcolor.red,BGRAcolor.green,BGRAcolor.blue);
  BGRAcolor.alpha:=100;
  AGradInfo[0].StopColor:= BGRAcolor;

  AGradInfo[1].Direction:=gdVertical;
  AGradInfo[1].endPercent:=1.0;
  AGradInfo[1].StartColor:=ColorToBGRA(ColortoRGB(clwhite)); //BGRA(0,0,0,100);
  AGradInfo[1].StopColor:=BGRA(0,0,0,100); // BGRA(255,255,255,50);

  result := nGradientAlphaFill(tx,ty,gdVertical,AGradInfo[0]);
end;

var
  mask: TBGRABitmap;
  layer: TBGRABitmap;
  tex:TBGRABitmap;
  i:integer;
  R:TRect;
  //
   c: TBGRAPixel;
  // calculo de entradas y salidas
  Count_inputs :integer;
  Count_outputs:integer;
  YspaceInput:integer;
  YspaceOutput:integer;
  LineCount:integer;
  BlockWidth:integer;
  BlockHeight:integer;
const
  YspaceOffset=20;
begin

    {
    layer:=TBGRABitmap.Create(Shape1.Width, Shape1.Height);
    layer..GradientFill(0,0,layer.Width,layer.Height,
                       ColorToBGRA(ColortoRGB(LColor),0),ColorToBGRA(ColortoRGB(LColor),0),
                       gtRadial,PointF(layer.Width/2,layer.Height/2),PointF(0,3*layer.Height/4),
                       dmSet);
    Bitmap.PutImage(0,0,layer,dmDrawWithTransparency);
    layer.free;
       }

    // lado izquierdo.
         // others mask.

   //
    //Dibujando shadow.
   { layer:=TBGRABitmap.Create(Shape1.Width-2*x+10, Shape1.Height-2*y+10);
    tex := CreateGradient(layer.Width,layer.Height,clGray,clGray);
    layer.FillRoundRectAntialias(0,0,Shape1.Width-2*x+3,Shape1.Height-2*y+1,Shape1.Width*0.04,Shape1.Width*0.04,tex);

    Bitmap.PutImage(x-1,y+1,layer,dmLinearBlend,220);
    layer.free;}

    // dibijando el componente
    layer:=TBGRABitmap.Create(Shape1.Width-2*x, Shape1.Height-2*y);

    tex := CreateGradient(layer.Width,layer.Height,ColorBox1.Selected,ColorBox2.Selected);
    layer.FillRoundRectAntialias(1,1,Shape1.Width-2*x-3,Shape1.Height-2*y-3,Shape1.Width*0.04,Shape1.Width*0.04,tex);
    layer.RoundRectAntialias(1,1,Shape1.Width-2*x-3,Shape1.Height-2*y-3,Shape1.Width*0.04,Shape1.Width*0.04,BGRA(0,0,0),4);
    //layer.RoundRect(1,1,Shape1.Width-2*x-3,Shape1.Height-2*y-3,20,20,BGRA(80,80,80),dmDrawWithTransparency);
    {layer.GradientFill(0,0,layer.Width,layer.Height,
                       ColorToBGRA(ColortoRGB(LColor)),BGRA(0,0,0),
                       gtRadial,PointF(layer.Width/2,layer.Height/2),PointF(layer.Width*1.5,layer.Height*1.5),
                       dmSet);   }
     // Inicio Component name
     c := ColorToBGRA(ColorToRGB(ColorBox4.Selected)); //retrieve default text color
     layer.FontHeight := 18;
     layer.FontAntialias := True;
     layer.FontStyle := [fsBold];
     layer.TextOut(round(Shape1.Width-2*x)/2,8,ComponentName.Text,c,taCenter);
     // Fin Component name

    mask := TBGRABitmap.Create(layer.Width,layer.Height,BGRABlack);
    mask.FillRoundRectAntialias(0,0,layer.Width,layer.Height,y/2,y/2,BGRAWhite);
    layer.ApplyMask(mask);
    mask.Free;


    Bitmap.PutImage(x,y,layer,dmSet);
    layer.free;

    // dibujando en el canvas del shape
    R:=Shape1.ClientRect;
    Bitmap.Draw(Shape1.Canvas,R,false);

    // dibujando una señal

    // contando las entradas y salidas
    Count_inputs:=0;
    Count_outputs:=0;
    for i:=0 to length(DataEntity) - 1  do
     begin
         if (DataEntity[i].Add=cbChecked) and (DataEntity[i].PortName<>'') then
           begin

             if (DataEntity[i].Direction='in')then Count_inputs:=Count_inputs+1
             else Count_outputs:=Count_outputs+1;

           end;
     end;
    //showMessage('out:'+IntTostr(Count_outputs)+ 'in:'+IntTostr(Count_inputs));

    // calculando el espacio entre señales para entrada y salidas.
    BlockWidth:=Shape1.Width-2*x;
    BlockHeight:=Shape1.Height-2*y;
    YspaceInput:= round( (BlockHeight - 2*YspaceOffset)/(Count_inputs+1));
    YspaceOutput:= round( (BlockHeight - 2*YspaceOffset)/(Count_outputs+1));
    //showMessage('out:'+IntTostr(YspaceOutput)+ '  in:'+IntTostr(YspaceInput));

    // dibujando las entradas
    LineCount:=1;
    for i:=0 to length(DataEntity) - 1  do
     begin
       //LineCount*YspaceInput+YspaceOffset+y
       if (DataEntity[i].Add=cbChecked) and (DataEntity[i].PortName<>'') and (DataEntity[i].Direction='in') then
         begin
           DrawSignal(DataEntity[i].PortName,20,x,LineCount*YspaceInput+YspaceOffset+y,LineCount*YspaceInput+YspaceOffset+y,DataEntity[i].Direction,DataEntity[i].CheckBox,ColorBox3.Selected,clblack,DataEntity[i].MSB,DataEntity[i].LSB);
           LineCount:=LineCount+1;
         end;
     end;

    // dibujando las salidas.
    LineCount:=1;
    for i:=0 to length(DataEntity) - 1  do
     begin
       //LineCount*YspaceInput+YspaceOffset+y
       if (DataEntity[i].Add=cbChecked) and (DataEntity[i].PortName<>'') and (DataEntity[i].Direction<>'in') then
         begin
           DrawSignal(DataEntity[i].PortName,x+BlockWidth,Shape1.Width-20,LineCount*YspaceOutput+YspaceOffset+y,LineCount*YspaceOutput+YspaceOffset+y,DataEntity[i].Direction,DataEntity[i].CheckBox,ColorBox3.Selected,clblack,DataEntity[i].MSB,DataEntity[i].LSB);
           LineCount:=LineCount+1;
         end;
     end;


   // DrawSignal('CLKI',20,x,50,50,'input',cbChecked,ColorBox3.Selected,clblack,'7','0');


end;

procedure TIPCoreDrawF.DrawSignal(SignalName: string; Xi, Xf, Yi, Yf: integer;
  Direction: String; LineBus: TCheckBoxState; TexColor, LineColor: TColor;
  VMSB, VLSB: String);
var

  layer:TBGRABitmap;
  c: TBGRAPixel;
  R:TRect;

begin


  layer:=TBGRABitmap.Create(Shape1.Width,Shape1.Height);

  // {Dibujando las lineas}
  c:=  ColorToBGRA(ColorToRGB(LineColor));
 // c:= BGRA(80,80,80);
  if (Direction='in')then
   begin
      if (LineBus=cbChecked) and not(VMSB='') and not(VLSB='') then
         //layer.RectangleAntialias(Xf-20,Yi-1,Xf,Yf+1,c,1,c)
           //layer.RectangleAntialias(0,Yi-2,Xf,Yf+2,c,1,c)
           layer.RectangleAntialias(Xf-20,Yi-2,Xf,Yf+2,c,1,c)
      else
         //layer.DrawLineAntialias(Xf-20,Yi,Xf,Yf,c,false);
         //layer.DrawLineAntialias(0,Yi,Xf,Yf,c,false);
         //layer.RectangleAntialias(0,Yi-1,Xf,Yf+1,c,1,c)
        layer.RectangleAntialias(Xf-20,Yi-1,Xf,Yf+1,c,1,c)
   end
  else begin
      if (LineBus=cbChecked) and not(VMSB='') and not(VLSB='') then
         //layer.RectangleAntialias(Xi,Yi-1,Xi+20,Yf+1,c,1,c)
         //layer.RectangleAntialias(Xi,Yi-2,Shape1.Width,Yf+2,c,1,c)
         layer.RectangleAntialias(Xi,Yi-2,Xi+20,Yf+2,c,1,c)
      else
         //layer.DrawLineAntialias(Xi,Yi,Xi+20,Yf,c,false);
          //layer.DrawLineAntialias(Xi,Yi,Shape1.Width,Yf,c,false);
         //layer.RectangleAntialias(Xi,Yi-1,Shape1.Width,Yf+1,c,1,c)
         layer.RectangleAntialias(Xi,Yi-1,Xi+20,Yf+1,c,1,c)
   end;

  c:=  ColorToBGRA(ColorToRGB($808080));

  if (Direction='in')then
    begin
      //layer.DrawPolygonAntialias([PointF(Xf-5,Yf-5), PointF(Xf-5,Yf+5), PointF(Xf,Yf+5), PointF(Xf+5,Yf),PointF(Xf,Yf-5)],ColorToBGRA(ColorToRGB(clBlack)),1,c);
      layer.DrawPolygonAntialias([PointF(Xf-3,Yf-5), PointF(Xf-3,Yf+5), PointF(Xf+3,Yf+5), PointF(Xf+8,Yf),PointF(Xf+3,Yf-5)],ColorToBGRA(ColorToRGB(clBlack)),2,c);
     end

  else if (Direction='out') then layer.DrawPolygonAntialias([PointF(Xi-8,Yi-5), PointF(Xi-8,Yi+5), PointF(Xi-3,Yi+5), PointF(Xi+2,Yi),PointF(Xi-3,Yi-5)],ColorToBGRA(ColorToRGB(clBlack)),2,c)
  else begin
      //layer.DrawPolygonAntialias([PointF(Xi-5,Yi-5),PointF(Xi-10,Yi), PointF(Xi-5,Yi+5), PointF(Xi,Yi+5), PointF(Xi+5,Yi),PointF(Xi,Yi-5)],ColorToBGRA(ColorToRGB(clBlack)),1,c)
      layer.DrawPolygonAntialias([PointF(Xi-8,Yi-5),PointF(Xi-13,Yi), PointF(Xi-8,Yi+5), PointF(Xi-3,Yi+5), PointF(Xi+2,Yi),PointF(Xi-3,Yi-5)],ColorToBGRA(ColorToRGB(clBlack)),2,c)

  end;

  // {Dibujando el Texto de la señal}
  c := ColorToBGRA(ColorToRGB(TexColor)); //retrieve default text color
  layer.FontName:='Arial';
  layer.FontHeight := 14;
  layer.FontAntialias := True;
  layer.FontStyle := [fsBold];
  if (Direction='in')then
     begin
       if (LineBus=cbChecked) and not(VMSB='') and not(VLSB='') then
         layer.TextOut(Xf+13,Yf-7,SignalName+' ['+VMSB+':'+VLSB+']',c)
       else
         layer.TextOut(Xf+13,Yf-7,SignalName,c)
      end
  else
     begin
       if (LineBus=cbChecked) and not(VMSB='') and not(VLSB='') then
         layer.TextOut(Xi-17,Yf-7,SignalName+' ['+VMSB+':'+VLSB+']',c,taRightJustify)
      else
         layer.TextOut(Xi-17,Yf-7,SignalName,c,taRightJustify)
     end;
   //layer.TextOut(round((Shape1.Width-2*x)/2),3,ComponentName.Text,c,taCenter);
  //layer.SetPixel(Xf+10-1,Yf-1,c);
  Bitmap.PutImage(0,0,layer,dmDrawWithTransparency);
  layer.free;

  // {Dibujando en el canvas del Shape1}
  R:=Shape1.ClientRect;
  Bitmap.Draw(Shape1.Canvas,R,false);

end;

procedure TIPCoreDrawF.FormCreate(Sender: TObject);
var
  i:integer;
  j:integer;
  R,G,B:Byte;

begin
  {$IFDEF LINUX}
  Font.Size:=10;
  {$ENDIF}
  IP_Image_width:=edWidth.Position;
  Bitmap:=TBGRABitmap.Create(Shape1.width,Shape1.height);
  SetLength(DataEntity, GridEntity.RowCount - 1);
  j:=0;

  for i := 0 to length(DataEntity) - 1 do
   begin
     if (j<2) then
       DataEntity[i].CheckBox := cbUnChecked //TCheckBoxState
     else
       DataEntity[i].CheckBox := cbGrayed; //TCheckBoxState
     j:=j+1;
  end;

  j:=0;
  for i := 0 to length(DataEntity) - 1 do
   begin
     if (j<2) then
       DataEntity[i].Add := cbChecked //TCheckBoxState
     else
       DataEntity[i].Add := cbUnChecked; //TCheckBoxState
     j:=j+1;
  end;

  // set SBA Signals
  DataEntity[0].PortName:='CLK_I';
  DataEntity[1].PortName:='RST_I';
  DataEntity[2].PortName:='STB_I';
  DataEntity[3].PortName:='WE_I';
  DataEntity[4].PortName:='ADR_I';
  DataEntity[5].PortName:='DAT_I';
  DataEntity[6].PortName:='DAT_O';

  DataEntity[0].Direction:='in';
  DataEntity[1].Direction:='in';
  DataEntity[2].Direction:='in';
  DataEntity[3].Direction:='in';
  DataEntity[4].Direction:='in';
  DataEntity[5].Direction:='in';
  DataEntity[6].Direction:='out';
  // Bus
  DataEntity[4].CheckBox:=cbChecked;
  DataEntity[5].CheckBox:=cbChecked;
  DataEntity[6].CheckBox:=cbChecked;

  for i := 1 to 7 do
   begin
     GridEntity.Cells[PosPortName,i]:= DataEntity[i-1].PortName;
     GridEntity.Cells[PosDirection,i]:= DataEntity[i-1].Direction;

   end;

  // TCOLOR
  CustomColorNumber:=1;
  CustomColorNumber2:=1;
  CustomColorNumber3:=1;
  RedGreenBlue(ColorBox1.Selected,R,G,B);
  infoRGBTop.Caption:= 'R: '+ Format('%.3d',[R])+' G: '+ Format('%.3d',[G])+ ' B: '+ Format('%.3d',[B]) ;
  RedGreenBlue(ColorBox2.Selected,R,G,B);
  infoRGBBottom.Caption:= 'R: '+ Format('%.3d',[R])+' G: '+ Format('%.3d',[G])+ ' B: '+ Format('%.3d',[B]) ;
  AddListColorTop.Enabled:=False;
  AddListColorBottom.Enabled:=False;
  AddListColorText.Enabled:=False;
  ColorBox2.AddItem('Custom_0', Tobject($00FFCB51));
  ColorBox1.AddItem('Custom_0', Tobject($00D69700));
  ColorBox2.Selected:=Tcolor($00FFCB51);
//  ColorBox1.Selected:=Tcolor($00D69700);
  ColorBox1.Selected:=clWhite;

  // iniciando valores para el bloque
  //Xo:=round(Shape1.Width/4);
  //Yo:=round(Shape1.Height*0.02);

end;

procedure TIPCoreDrawF.FormDestroy(Sender: TObject);
begin
  if assigned(Bitmap) then FreeAndNil(Bitmap);
end;

procedure TIPCoreDrawF.GridEntityPickListSelect(Sender: TObject);
var
  tmpGrid: TStringGrid;
  aRow,aCol:integer;
begin
   tmpGrid:= TStringGrid(Sender);
   aCol:=tmpGrid.col;
   aRow:=tmpGrid.row;
   DataEntity[ARow-1].Direction:=GridEntity.Cells[aCol,aRow];
   //ShowMessage(DataEntity[ARow-1].Direction);
  // ShowMessage('aCol'+IntToStr(aCol)+ ' aROW' + IntToStr(aRow) );
end;

procedure TIPCoreDrawF.GridEntitySelectEditor(Sender: TObject; aCol, aRow: Integer;
  var Editor: TWinControl);
begin
  if (ARow > 0) and (ACol = PosPortname) then
   begin
    // DataEntity[ARow-1].Add:=cbChecked;
    // DataEntity[ARow-1].CheckBox:=cbUnChecked;
    // DataEntity[ARow-1].Direction:='in';
   end;

end;

procedure TIPCoreDrawF.SaveimageClick(Sender: TObject);
//var
//FileRGB:TBGRABitmap;
begin
 //FileRGB:=TBGRABitmap.Create(Shape1.width,Shape1.height);
 UpdateTimer1.Enabled:=False;
 savePictureDialog1.InitialDir:=GetCurrentDir;
  if (SavePictureDialog1.Execute) then
   begin

     //Bitmap.ConvertToLinearRGB;
    // FileRGB.GetImageFromCanvas(Shape1.Canvas,0,0);
     //FileRGB.SaveToFile(SavePictureDialog1.FileName);
     Bitmap.SaveToFile(SavePictureDialog1.FileName);
     //Bitmap.SaveToFile('image.png');
   end;
  UpdateTimer1.Enabled:=true;
  //FileRGB.Free;
end;

procedure TIPCoreDrawF.Shape1Paint(Sender: TObject);
var
  R:TRect;

begin
 if assigned(Bitmap) then
  begin
    R:=Shape1.ClientRect;
    Bitmap.Draw(Shape1.Canvas,R,false);
    //Bitmap.SaveToFile('imagen2.png');
  end;
end;

procedure TIPCoreDrawF.WidthChange(Sender: TObject);
begin
  UpdateImage:=true;
end;


procedure TIPCoreDrawF.UpdateTimer1Timer(Sender: TObject);
begin
  if(UpdateImage) then
  begin
    UpdateImage:=false;
    IP_Image_width:= Round(edWidth.Position);
    l_width.Caption:= 'Width: '+inttostr(IP_Image_width);
    Memo1.Lines.Add(inttostr(IP_Image_width));
    Bitmap.Fill(BGRAPixelTransparent);
    Xo:=(Shape1.Width-IP_Image_width) div 2;
    Yo:=10;
    Drawsymbol(Xo,Yo);
    Shape1.Invalidate;
  end;
end;

end.

