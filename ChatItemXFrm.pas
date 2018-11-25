unit ChatItemXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Math.Vectors, FMX.Objects, FMX.Controls3D, FMX.Layers3D, FMX.Layouts,
  DataModule, FMX.ImgList;

type
  TChatItemFrm = class(TFrame)
    Layout43: TLayout;
    RectItemPic: TRectangle;
    Layout44: TLayout;
    TxtOwnerName: TText;
    Layout3D1: TLayout3D;
    TxtItemAge: TText;
    Layout3D2: TLayout3D;
    TxtItemName: TText;
    Layout3D3: TLayout3D;
    Layout1: TLayout;
    Circle15: TCircle;
    TxtOwnerInital: TText;
    Layout2: TLayout;
    GSentReceived: TGlyph;
    GReadReplied: TGlyph;
    TxtMessage: TText;
    Layout3D4: TLayout3D;
    Rectangle1: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
