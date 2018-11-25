unit LoginXFrm;

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
  TLoginFrm = class(TFrame)
    Rectangle1: TRectangle;
    ListView1: TListView;
    LayBigBottomContainer: TLayout;
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
    Text1: TText;
    FlowLayout1: TFlowLayout;
    SbSignupSegButton: TSpeedButton;
    SbLoginSegButton: TSpeedButton;
    Layout3: TLayout;
    TxtBtnForgotPassword: TText;
    RectBtnLogin: TRectangle;
    TxtBtnLogin: TText;
    EdUsername: TEdit;
    Image2: TImage;
    SpeedButton6: TSpeedButton;
    EdPassword: TEdit;
    LockImage: TImage;
    SpeedButton5: TSpeedButton;
    EdUsernameOrEmail: TEdit;
    MailImage: TImage;
    SpeedButton4: TSpeedButton;
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    Text9: TText;
    Text10: TText;
    procedure ForgotPasswordActExecute(Sender: TObject);

    procedure TxtBtnLoginClick(Sender: TObject);
    procedure SbSignupSegButtonClick(Sender: TObject);
    procedure Text10Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure TxtBtnForgotPasswordClick(Sender: TObject);
  private
  public
  end;

implementation

uses Main, StrUtils, uSharedEconomyConsts, Math, MkUtils;


{$R *.fmx}

procedure TLoginFrm.ForgotPasswordActExecute(Sender: TObject);
begin
//
end;

procedure TLoginFrm.SbSignupSegButtonClick(Sender: TObject);
begin
  SbLoginSegButton.IsPressed := Sender = SbLoginSegButton;
  SbSignupSegButton.IsPressed := not SbLoginSegButton.IsPressed;
  EdUsername.Visible := SbSignupSegButton.IsPressed;
  TxtBtnForgotPassword.Visible := SbLoginSegButton.IsPressed;
  TxtBtnLogin.Text := TSpeedButton(Sender).Text;
  TxtBtnLogin.Tag := Integer(SbLoginSegButton.IsPressed);
  EdUsernameOrEmail.TextPrompt := ifthen(SbLoginSegButton.IsPressed, '  Username or email address', '  Email');
end;

procedure TLoginFrm.SpeedButton1Click(Sender: TObject);
begin
  MainForm.CancelLogin;
end;

procedure TLoginFrm.SpeedButton4Click(Sender: TObject);
begin
  TEdit(TFmxObject(Sender).Parent).Text := '';
end;

procedure TLoginFrm.Text10Click(Sender: TObject);
begin
  MainForm.DisplayURL(HELP_LOGIN_URL1, Self);
end;

procedure TLoginFrm.TxtBtnForgotPasswordClick(Sender: TObject);
begin
  Visible := False;
  MainForm.CreateForgotFrame;
end;

procedure TLoginFrm.TxtBtnLoginClick(Sender: TObject);
begin
  if Boolean(TxtBtnLogin.Tag) then
    MainForm.InitialLogin(Self)
  else
    MainForm.Signup(EdUsernameOrEmail.Text, GetMd5HashString(EdPassword.Text), EdUsername.Text, Self);
end;

end.
