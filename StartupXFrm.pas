unit StartupXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Objects, FMX.Layouts, System.ImageList, FMX.ImgList, FMX.Effects,
  FMX.Filter.Effects;

type
  TStartupFrm = class(TFrame)
    Image1: TImage;
    Text6: TText;
    Text5: TText;
    FlowLayout2: TFlowLayout;
    Text7: TText;
    FlowLayoutBreak1: TFlowLayoutBreak;
    Text8: TText;
    FlowLayout1: TFlowLayout;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    LayStage2: TLayout;
    RectBtnLogin: TRectangle;
    TxtBtnSignup: TText;
    Rectangle1: TRectangle;
    TxtBtnLogin: TText;
    procedure Text6Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure TxtBtnSignupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InAppStartup;
  end;

implementation

{$R *.fmx}

uses Main, uSharedEconomyConsts;

procedure TStartupFrm.InAppStartup;
  procedure TextToBlack(Sender: TText);
  begin
    Sender.TextSettings.FontColor := $FF000000;
  end;
begin
  TextToBlack(Text5);
  TextToBlack(Text8);
  TextToBlack(Text7);
  TextToBlack(Text6);
end;

procedure TStartupFrm.Text2Click(Sender: TObject);
begin
  MainForm.DisplayURL(TERMS_CONDITIONS_URL, Self);
end;

procedure TStartupFrm.Text4Click(Sender: TObject);
begin
  MainForm.DisplayURL(PRIVACY_URL, Self);
end;

procedure TStartupFrm.Text6Click(Sender: TObject);
begin
  MainForm.ShowLoginFrame;
//  DisposeOf;
end;

procedure TStartupFrm.TxtBtnSignupClick(Sender: TObject);
begin
  MainForm.ShowLoginFrame(Boolean(TText(Sender).Tag));
end;

end.
