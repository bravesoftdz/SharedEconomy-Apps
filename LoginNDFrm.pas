unit LoginNDFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, System.Math.Vectors, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, IPPeerClient,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.Actions,
  FMX.ActnList, FMX.StdCtrls, FMX.ListView, FMX.Edit, FMX.Objects, FMX.Layouts,
  FMX.Controls.Presentation;
const
  //DO NOT USE THIS AS USERNAME
  GLOBALS_SECTION_NAME = '___Globals___';
type
  TLoginNDFrame = class(TFrame)
    LayBigBottomContainer: TLayout;
    LbTitle: TLabel;
    Layout2: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    ActionList1: TActionList;
    LoginAct: TAction;
    LoginAgainAct: TAction;
    DoneAct: TAction;
    LoginByQRCodeAct: TAction;
    LoadCredentialsNowAct: TAction;
    SaveCredentialsAct: TAction;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    ListView1: TListView;
    AniIndicator1: TAniIndicator;
    edLocation: TEdit;
    edAddress: TEdit;
    Button3: TButton;
    SignupAct: TAction;
    LayForgot: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Layout7: TLayout;
    EdForgotUsername: TEdit;
    ClearEditButton2: TClearEditButton;
    EdForgotEmail: TEdit;
    ClearEditButton3: TClearEditButton;
    Button5: TButton;
    Button6: TButton;
    LayLoginEdits: TLayout;
    Layout4: TLayout;
    edUsername: TEdit;
    edPassword: TEdit;
    ClearEditButton1: TClearEditButton;
    Layout3: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    ForgotPasswordAct: TAction;
    Text1: TText;
    RectBtnLogin: TRectangle;
    TxtBtnLogin: TText;
    Label4: TText;
    RectBtnSignup: TRectangle;
    TxtBtnSignup: TText;
    Text2: TText;
    CbStoreCredentials: TCheckBox;
    procedure LoginByQRCodeActExecute(Sender: TObject);
    procedure ForgotPasswordActExecute(Sender: TObject);

    procedure TxtBtnLoginClick(Sender: TObject);
  private
  public
  end;

implementation

uses Main, StrUtils, FastCamMain;


{$R *.fmx}

procedure TLoginNDFrame.ForgotPasswordActExecute(Sender: TObject);
begin
  LayBigBottomContainer.Visible := not LayBigBottomContainer.Visible;
  LayLoginEdits.Visible := LayBigBottomContainer.Visible;
  LayForgot.Visible := not LayBigBottomContainer.Visible;
  LbTitle.Text := ifthen(LayBigBottomContainer.Visible, 'Login', 'Passsord Recovery');
end;

procedure TLoginNDFrame.LoginByQRCodeActExecute(Sender: TObject);
var
  FrmFastCam: TFrmFastCam;
begin
  Visible := False;
  FrmFastCam := TFrmFastCam.Create(Self.Owner);
  FrmFastCam.FormCreate(nil);
  FrmFastCam.Parent := Self.Parent;
  FrmFastCam.Align := TAlignLayout.Client;
end;


procedure TLoginNDFrame.TxtBtnLoginClick(Sender: TObject);
begin
  MainForm.InitialLogin;
end;

end.
