unit BrowserXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.WebBrowser, FMX.Controls.Presentation, FMX.Layouts;

type
  TBrowserFrm = class(TFrame)
    WebBrowser: TWebBrowser;
    Layout1: TLayout;
    SbClose: TSpeedButton;
    procedure SbCloseClick(Sender: TObject);
    procedure WebBrowserDidFinishLoad(ASender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FrameToReturnTo: TFrame;
  end;

implementation

{$R *.fmx}

uses Main;

procedure TBrowserFrm.SbCloseClick(Sender: TObject);
begin
  MainForm.CloseBrowser;
end;

procedure TBrowserFrm.WebBrowserDidFinishLoad(ASender: TObject);
begin
  Visible := True;
end;

end.
