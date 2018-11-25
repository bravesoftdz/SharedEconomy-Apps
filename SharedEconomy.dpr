program SharedEconomy;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  MkUtils in 'MkUtils.pas',
  uSharedEconomyConsts in 'uSharedEconomyConsts.pas',
  StartupXFrm in 'StartupXFrm.pas' {StartupFrm: TFrame},
  DataModule in 'DataModule.pas' {DataModule1: TDataModule},
  Main in 'Main.pas' {MainForm},
  LoginXFrm in 'LoginXFrm.pas' {LoginFrm: TFrame},
  AppVersion in 'AppVersion.pas',
  UnescapeJSONString in 'UnescapeJSONString.pas',
  BrowserXFrm in 'BrowserXFrm.pas' {BrowserFrm: TFrame},
  ForgotXFrm in 'ForgotXFrm.pas' {ForgotFrm: TFrame},
  ChatXFrm in 'ChatXFrm.pas' {ChatFrm: TFrame},
  DashboardXFrm in 'DashboardXFrm.pas' {DashboardFrm: TFrame},
  MyAccountXFrm in 'MyAccountXFrm.pas' {MyAccountFrm: TFrame},
  NotificationsXFrm in 'NotificationsXFrm.pas' {NotificationsFrm: TFrame},
  CameraXFrm in 'CameraXFrm.pas' {CameraFrm: TFrame},
  NewItemPostedXFrm in 'NewItemPostedXFrm.pas' {NewItemPostedFrm: TFrame},
  NotificationItemXFrm in 'NotificationItemXFrm.pas' {NotificationItemFrm: TFrame},
  ItemInfoXFrm in 'ItemInfoXFrm.pas' {ItemInfoFrm: TFrame},
  SettingsXFrm in 'SettingsXFrm.pas' {SettingsFrm: TFrame},
  InvisibleXFrm in 'InvisibleXFrm.pas' {InvisibleFrm},
  uMkCmd in 'uMkCmd.pas',
  ItemDetailXFrm in 'ItemDetailXFrm.pas' {Form1},
  ItemEditXFrm in 'ItemEditXFrm.pas' {ItemEditFrm},
  ChatItemXFrm in 'ChatItemXFrm.pas' {ChatItemFrm: TFrame},
  AniIndicatorXFrm in 'AniIndicatorXFrm.pas' {AniIndicatorFrm: TFrame},
  SelectCategoryXFrm in 'SelectCategoryXFrm.pas' {SelectCategoryFrm: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TInvisibleFrm, InvisibleFrm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TItemEditFrm, ItemEditFrm);
  Application.Run;
end.
