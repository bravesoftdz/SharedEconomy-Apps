unit ChatXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  DataModule, System.Math.Vectors, FMX.Controls.Presentation, FMX.Objects,
  FMX.Controls3D, FMX.Layers3D, FMX.Layouts;

type
  TChatFrm = class(TFrame)
    Layout1: TLayout;
    ChatScrollBox: TVertScrollBox;
    Text1: TText;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Main;

procedure TChatFrm.SpeedButton2Click(Sender: TObject);
begin
  MainForm.CloseChat;
end;

end.
