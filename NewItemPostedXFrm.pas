unit NewItemPostedXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TNewItemPostedFrm = class(TFrame)
    Layout1: TLayout;
    SbClose: TSpeedButton;
    Layout2: TLayout;
    BtnPostPic: TRectangle;
    TxtBtnLogin: TText;
    TxtBtnRetake: TText;
  private
    { Private declarations }
  public
    { Public declarations }
    FrameToReturnTo: TFrame;
  end;

implementation

{$R *.fmx}

end.
