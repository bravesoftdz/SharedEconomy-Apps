unit NotificationsXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation;

type
  TNotificationsFrm = class(TFrame)
    LayHeader: TLayout;
    TxtHeader: TText;
    SpeedButton1: TSpeedButton;
    VertScrollBox1: TVertScrollBox;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Main;

procedure TNotificationsFrm.SpeedButton1Click(Sender: TObject);
begin
  MainForm.CloseNotifications;
end;

end.
