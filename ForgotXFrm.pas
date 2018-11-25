unit ForgotXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts;

type
  TForgotFrm = class(TFrame)
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    Text9: TText;
    Layout3: TLayout;
    TxtBtnForgotPassword: TText;
    RectBtnLogin: TRectangle;
    TxtBtnForgot: TText;
    EdUsername: TEdit;
    MailImage: TImage;
    procedure TxtBtnForgotClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Main;

procedure TForgotFrm.SpeedButton1Click(Sender: TObject);
begin
  MainForm.CloseForgot;
  DisposeOf;
end;

procedure TForgotFrm.TxtBtnForgotClick(Sender: TObject);
begin
  MainForm.SendForgotEmail(EdUsername.Text, Self);
end;

end.
