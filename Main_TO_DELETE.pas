unit Main_TO_DELETE;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Gestures, System.Actions, FMX.ActnList, FMX.DateTimeCtrls, FMX.Layouts,
  FMX.Maps, FMX.Ani, FMX.Edit, System.Sensors, System.Sensors.Components,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdCmdTCPClient,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  IdHTTP, System.Notification, IPPeerClient, REST.Backend.PushTypes,
  REST.Backend.MetaTypes, System.JSON, System.PushNotification,
  REST.Backend.BindSource, REST.Backend.PushDevice, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.ServiceComponents,
  REST.Backend.ServiceTypes, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Objects, FMX.ListBox,
  FMX.EditBox, FMX.NumberBox, FMX.ScrollBox, FMX.Memo, DataModule,
  StartupXFrm, FMX.MultiView, (*DashboardNDFrm, AccountMgmtNDFrm, InventoryXFrm, RentedItemsXFrm,*)
  FMX.Effects, FMX.ImgList, System.ImageList, System.Messaging;
const
//  CMD_TEMPLATE = 'http://jira.cyberfusionair.io:7555/seapi/public';
  CMD_TEMPLATE = 'https://sharedeconomy.impactvision.co.uk';
  PHP_SESSION_ID: String = '';
  SUCCESS = 'Success!';
  FAILED = 'Failed!';
  APP_NAME = 'Shared Economy';
  DEFAULT_ACCESS_TIMEOUT = 10;

type
  TPersonalInfo = record
    Username: String;
    FullName: String;
    Email: String;
    Address: String;
    AboutMe: String;
    PhoneNumber: String;
  end;
  TCmdThread = class(TThread)
  private
    FLVItem: TListViewItem;
    FCmd: String;
    FParams: String;
    procedure SetLVItem(const Value: TListViewItem) ;
    procedure SetCmd(const Value: String);
    procedure SetParams(const Value: String) ;
    procedure RemoveCommandFromCmdQueue;
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean) ;
    property LVItem: TListViewItem read FLVItem write SetLVItem;
    property Cmd: String read FCmd write SetCmd;
    property Params: String read FParams write SetParams;
  end;

  TMainForm = class(TForm)
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    timerDelayAccess: TTimer;
    LockUnlockAct: TAction;
    LocationSensor1: TLocationSensor;
    StartStopDelayedAccessTImer: TAction;
    ArcTimer: TTimer;
    AddGeofenceAct: TAction;
    TriggerGeofenceAct: TAction;
    ListGeofencesAct: TAction;
    AddPhoneNumbersAct: TAction;
    ListPhoneNumbersAct: TAction;
    DeleteGeofenceAct: TAction;
    DeletePhoneNumbersAct: TAction;
    TriggerPhoneNumbersAct: TAction;
    AddScheduleAct: TAction;
    DeleteScheduleAct: TAction;
    TriggerScheduleAct: TAction;
    ListScheduleAct: TAction;
    OpenBuildingDoorAct: TAction;
    OpenFlatDoorAct: TAction;
    BackendPush1: TBackendPush;
    PushEvents1: TPushEvents;
    BackendAuth1: TBackendAuth;
    StartCentralHeatingAct: TAction;
    StopCentralHeatingAct: TAction;
    tcMain: TTabControl;
    BookingTab: TTabItem;
    SettingsTab: TTabItem;
    StartProgramAct: TAction;
    DelayedNotificationsTimer: TTimer;
    DashboardTab: TTabItem;
    OpenOutDoorAct: TAction;
    FlatDoorAct: TAction;
    DeliveryAct: TAction;
    WalkInAct: TAction;
    TimedWalkIn: TAction;
    ToggleManualAutomateHeatingAct: TAction;
    ToggleLockUnlockAct: TAction;
    AniIndicator1: TAniIndicator;
    LBTabs: TListBox;
    MainMenu: TToolBar;
    LbTitle: TLabel;
    MultiView1: TMultiView;
    sbMenu: TSpeedButton;
    AccountMgmtTab: TTabItem;
    Lang1: TLang;
    Check4updatesTimer: TTimer;
    InventoryTab: TTabItem;
    ItemsIRentedTab: TTabItem;
    ChangeBkPicTimer: TTimer;
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnAddScheduleClick(Sender: TObject);
    procedure OpenBuildingDoorActExecute(Sender: TObject);
    procedure OpenFlatDoorActExecute(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure Button3Click(Sender: TObject);
    procedure StartCentralHeatingActExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DelayedNotificationsTimerTimer(Sender: TObject);
    procedure FlatDoorActExecute(Sender: TObject);
    procedure OpenOutDoorActExecute(Sender: TObject);
    procedure ToggleLockUnlockActExecute(Sender: TObject);
    procedure LBTabsChange(Sender: TObject);
    procedure tcMainChange(Sender: TObject);
    procedure NetHTTPClient1ValidateServerCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure OrientationSensor1StateChanged(Sender: TObject);
    procedure Check4updatesTimerTimer(Sender: TObject);
    procedure ChangeBkPicTimerTimer(Sender: TObject);
  private
    { Private declarations }
    function DispatchCommand(Cmd: String; Params: String = ''): Boolean;
    procedure DoServiceConnectionChange(Sender: TObject;
      PushChanges: TPushService.TChanges);
    procedure DoReceiveNotificationEvent(Sender: TObject;
      const ServiceNotification: TPushServiceNotification);
    procedure LogMessage(Msg: String; ClearLogBefore: Boolean = False);
    procedure DoOrientationChanged(const Sender: TObject; const M: TMessage);
  public
    AccessTimeout: Integer;
    OldX, OldY: Single;

    PushService: TPushService;
    ServiceConnection: TPushServiceConnection;
    DeviceId: string;
    DeviceToken: string;
    SpareInstanceOfLoginFrm, LoginFrm: TLoginFrm;
    procedure LoginSuccess;
    procedure Logout;
    procedure AddTimer;
    function LocalMessageDlg(const Msg: string; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
  end;

var
  MainForm: TMainForm;
  PersonalInfo: TPersonalInfo;
  Locked: Boolean;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows,
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Posix.Stdlib,
{$ENDIF POSIX}
  StrUtils, System.IOUtils, System.Threading, Math, FMX.Styles,
  FMX.Platform, AppVersion;

const
  CMD_LOCK = 'lock';
  CMD_OPEN_BUILDING_DOOR = 'open_building_door';
  CMD_OPEN_FLAT_DOOR = 'open_flat_door';
  CMD_TIMED_DELIVERY = 'timed_delivery';
  CMD_TIMED_WALK_IN = 'timed_walk_in';

  CMD_ADD_GEOFENCE = 'add_geofence';
  CMD_ADD_SCHEDULE = 'add_schedule';
  CMD_ADD_TIMER = 'add_timer';
  CMD_ADD_PHONE = 'add_phone';

  CMD_LIST_GEOFENCE = 'list_geofence';
  CMD_LIST_SCHEDULE = 'list_schedule';
  CMD_LIST_TIMER = 'list_timer';
  CMD_LIST_PHONE = 'list_phone';

  CMD_TRIGGER_GEOFENCE = 'trigger_geofence';
  CMD_TRIGGER_SCHEDULE = 'trigger_schedule';
  CMD_TRIGGER_TIMER = 'trigger_timer';
  CMD_TRIGGER_PHONE = 'trigger_phone';

  CMD_DELETE_GEOFENCE = 'delete_geofence';
  CMD_DELETE_SCHEDULE = 'delete_schedule';
  CMD_DELETE_TIMER = 'delete_timer';
  CMD_DELETE_PHONE = 'delete_phone';

  CMD_GET_UPDATES = 'get_updates';

var
(*  FrmiGA: TFrmiGA;
  FrmBooking: TFrmBooking;
  FrmSettings: TFrmSettings;
  FrmInventory: TFrmInventory;
  FrmMyAccount: TFrmAccountMgmt;
  FrmItemsIRented: TFrmItemsIRented;
*)
  LocalForms: Array[0..10] of TFrame;

{$R *.fmx}

var
  CurrentVersion: String;
  SelfDownladableLink: String;

{ TCmdThread }

constructor TCmdThread.Create(CreateSuspended: Boolean);
begin
  inherited;
  FLVItem := nil;
end;

procedure TCmdThread.Execute;
var
  SStream: TStringStream;
  HTTPClient1: THTTPClient;
  HttpResponse: IHttpResponse;
  S: String;
begin
  inherited;
  SStream := TStringStream.Create;
  HTTPClient1 := THTTPClient.Create;
  try
    HTTPClient1.OnValidateServerCertificate := MainForm.NetHTTPClient1ValidateServerCertificate;
    HTTPClient1.UserAgent := 'yzAccess RESTClient';
    S := Format('%s/cmd/%s/%s', [CMD_TEMPLATE, Cmd, ifthen(Params='', 'NULL', Params)]);
    HttpResponse := HTTPClient1.Get(S, SStream);
    if (HttpResponse.StatusCode = 200) and (copy(SStream.DataString, 0, 2) <> 'OK') then
      begin
            S := SStream.DataString;
            // Response dispatcher for each command
            if Cmd = CMD_GET_UPDATES then
              if S <> CurrentVersion then
                begin
                  MainForm.Check4updatesTimer.Enabled := False; //whatever the answer, don't bother again
                  if MainForm.LocalMessageDlg(Format('A new version is available to download: %s\nClick YES to proceed downloading.', [S]),
                    TMsgDlgType.mtInformation, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes], 0) = mrYes then
                      begin
{$IFDEF MSWINDOWS}
                        ShellExecute(0, 'OPEN', PChar(SelfDownladableLink), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
                        _system('open a');// PAnsiChar('open ' + SelfDownladableLink));
{$ENDIF POSIX}
                      end;

                end;

      end
    else
      ;
  finally
    FreeAndNil(SStream);
    HTTPClient1.DisposeOf;
    Synchronize(RemoveCommandFromCmdQueue);
  end;
end;

procedure TCmdThread.SetCmd(const Value: String);
begin
  FCmd := Value;
end;

procedure TCmdThread.SetLVItem(const Value: TListViewItem);
begin
  FLVItem := Value;
end;

procedure TCmdThread.SetParams(const Value: String);
begin
  FParams := Value;
end;

procedure TCmdThread.RemoveCommandFromCmdQueue; //(LVItem: TListViewItem);
var
  FIndex: Integer;
begin
(*  if Assigned(FrmiGA) then
    with FrmiGA do
     begin
       LvCommandQueue.BeginUpdate;
       try
         FIndex := LvCommandQueue.Items.IndexOf(FLVItem);
         if (FIndex >= 0) then
           LvCommandQueue.Items.Delete(FIndex);
       finally
         LvCommandQueue.EndUpdate;
       end;
     end;
*)
end;


procedure TMainForm.DoOrientationChanged(const Sender: TObject; const M: TMessage);
var
  screenService: IFMXScreenService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, screenService) then begin
    case screenService.GetScreenOrientation of
      TScreenOrientation.Landscape, TScreenOrientation.InvertedLandscape:
        begin
          if Assigned(LoginFrm) then

        end;
    end;
  end;
end;

function TMainForm.LocalMessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
   HelpCtx: Longint): Integer;
begin
{$IF Defined(MSWINDOWS) or Defined(MACOS)}
   Result := MessageDlg(Msg, DlgType, Buttons, HelpCtx);
{$else}
   Result := 0;
{$endif}
end;

procedure TMainForm.AddTimer;
begin
  DispatchCommand(CMD_ADD_TIMER, Format('%d', [AccessTimeout]));
end;

procedure TMainForm.btnAddScheduleClick(Sender: TObject);
begin
//  DispatchCommand('add_schedule', Format('"d%s %s, %s %s ', [Integer(Locked)]));
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
(*
  with ListView1.Items.Add do
    begin
      Text := EdPhoneNumber.Text;
      Detail := ifthen(CbOnetimeAccess.IsChecked, '1 time access', 'Full time access');
    end;
*)
end;

procedure TMainForm.ChangeBkPicTimerTimer(Sender: TObject);
var
  InStream: TResourceStream;
  WasWrong: Boolean;
  ImgScaleFactor, ScreenScaleFactor: Single;
  I: Integer;
begin
{  repeat
    WasWrong := False;
    InStream := TResourceStream.Create(HInstance, Format('JpgImage_%d', [Random(29)+1]), RT_RCDATA);
    try
      try
        Image2.Opacity := 0;
        Image2.Bitmap.LoadFromStream(InStream);
        ImgScaleFactor := Image2.Bitmap.Height/Image2.Bitmap.Width;
        ScreenScaleFactor := Background.Height/Background.Width;
        if ImgScaleFactor <= ScreenScaleFactor then
          begin
            Image2.Height := Background.Height;
            Image2.Width := Image2.Height/ImgScaleFactor;
          end
        else
          begin
            Image2.Width := Background.Width;
            Image2.Height := Image2.Width * ImgScaleFactor;
          end;
        Image2.Position.X := 0;
        Image2.Position.Y := 0;
        for I := 0 to Image2.ChildrenCount - 1 do
          if Image2.Children[I] is TFloatAnimation then
           // if not Boolean(TFloatAnimation(Image2.Children[I]).Tag) then
            begin
              Image2.Opacity := 0;
              TFloatAnimation(Image2.Children[I]).Stop;
              TFloatAnimation(Image2.Children[I]).Start;
              Image2.Opacity := 0;
            end;
      finally
        FreeAndNil(InStream);
      end;
    except
      WasWrong := True;
    end;
  until not WasWrong;
  }
end;

procedure TMainForm.Check4updatesTimerTimer(Sender: TObject);
begin
  DispatchCommand(CMD_GET_UPDATES, CurrentVersion);
end;

procedure TMainForm.LogMessage(Msg: String; ClearLogBefore: Boolean = False);
begin
(*
  if Assigned(FrmSettings) then
    with FrmSettings do
      begin
        if ClearLogBefore then
          MemoOutput.ClearContent;
        LogMessage(Msg);
      end;
      *)
end;

procedure TMainForm.Logout;
begin
  tcMain.Visible := False;
  LoginFrm := SpareInstanceOfLoginFrm;
  with LoginFrm do
    begin
      Parent := Self;
      Application.ProcessMessages;
(*
      SwStoreCredentials.IsChecked := False;
      LogoImage.RotationAngle := 0;
      edPassword.Text := '';
      //Clear pass from ini
      SaveCredentialsActExecute(nil);
      Busy;
      Application.ProcessMessages;
      DelayedLogoutTimer.Enabled := True;
*)
    end;
end;

procedure TMainForm.DelayedNotificationsTimerTimer(Sender: TObject);
begin
  DelayedNotificationsTimer.Enabled := False;
  TTask.Run(
    procedure
    begin
      try
        ServiceConnection.Active := True;
      except
      end;
    end
  );
end;

function TMainForm.DispatchCommand(Cmd: String; Params: String = ''): Boolean;
var
  LVItem: TListViewItem;
  CmdThread: TCmdThread;
begin
(*
  with FrmiGA do
    begin
      if Assigned(FrmiGA) then
        begin
          LVItem := LvCommandQueue.Items.AddItem(0);
          with LVItem do
            begin
              Text := Format('%s - %s', [TimeToStr(Now()), Cmd]);
              Detail := 'zxzxxxx';
            end;
        end;
*)
      CmdThread := TCmdThread.Create(True);
      CmdThread.Cmd := Cmd;
      CmdThread.Params := Params;
      CmdThread.LVItem := LVItem;
      CmdThread.FreeOnTerminate := True;
      CmdThread.Start;
      Result := True;
//    end;
end;

procedure TMainForm.FlatDoorActExecute(Sender: TObject);
begin
  OpenFlatDoorActExecute(Sender);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DataModule1 := TDataModule1.Create(Self);
  TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage, DoOrientationChanged);
  AccessTimeout := DEFAULT_ACCESS_TIMEOUT;
  sbMenu.Visible := False;
  tcMain.Visible := False;
  PushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.GCM);
  if not Assigned(PushService) then
    begin
      LogMessage('Cannot create a PushService instance!');
    end
  else
    PushService.AppProps[TPushService.TAppPropNames.GCMAppID] := '1:318351347507:android:c0804db416c9c979';
  ServiceConnection := TPushServiceConnection.Create(PushService);
  ServiceConnection.OnChange := DoServiceConnectionChange;
  ServiceConnection.OnReceiveNotification := DoReceiveNotificationEvent;

  CurrentVersion := GetApplicationVersion;
  SelfDownladableLink := Format('%s/deploy/', [CMD_TEMPLATE]);

  LoginFrm := TLoginFrm.Create(Owner);
  with LoginFrm do
    begin
      Parent := Self;
      Align := TAlignLayout.Client;
//      LoadCredentialsNowActExecute(nil);
    end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  TMessageManager.DefaultManager.Unsubscribe(TOrientationChangedMessage, DoOrientationChanged);
end;

procedure TMainForm.DoServiceConnectionChange(Sender: TObject; PushChanges: TPushService.TChanges);
begin
  if TPushService.TChange.DeviceToken in PushChanges then
  try
    DeviceId := PushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceId];
    DeviceToken := PushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];
  except
    on E: Exception do
      LogMessage('DoServiceConnectionChange '+E.Message);
  end;
end;

procedure TMainForm.DoReceiveNotificationEvent(Sender: TObject; const ServiceNotification: TPushServiceNotification);
var
  MessageText: string;
  NotificationCenter: TNotificationCenter;
  Notification: TNotification;
  Obj: TJsonObject;
  Ob1: TJSONValue;
begin
  try
    try
      try
        Obj := ServiceNotification.DataObject;
        Ob1 := Obj.GetValue('message');
        if (Ob1 <> Nil) then
          MessageText := Ob1.Value;
        NotificationCenter := TNotificationCenter.Create(nil);
        Notification := NotificationCenter.CreateNotification;
        try
          Ob1 := Obj.GetValue('name');
          if (Ob1 <> Nil) then
             Notification.Name := Ob1.Value;
          Notification.AlertBody := MessageText;

          Ob1 := Obj.GetValue('title');
          if (Ob1 <> Nil) then
             Notification.Title := Ob1.Value;

          Ob1 := Obj.GetValue('badge');
          if (Ob1 <> Nil) then
             Notification.Number := StrToInt(Ob1.Value);

          Ob1 := Obj.GetValue('sound');
          Notification.EnableSound := (Ob1 <> Nil) and ( Ob1.Value <> '');
          NotificationCenter.PresentNotification(Notification);

          LogMessage(Obj.ToString, True);
        finally
          Notification.DisposeOf;
        end;
        except
        on E: Exception do
          LogMessage('1: '+E.Message);
        end;
      finally
        NotificationCenter.DisposeOf;
      end;
  except
    on E: Exception do
      LogMessage('2: '+E.Message);
  end;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if (tcMain.ActiveTab.Index = 0)  then
    begin
      Key := 0;
    end;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  //DelayedNotificationsTimer.Enabled := True;
end;

procedure TMainForm.GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if tcMain.ActiveTab <> tcMain.Tabs[tcMain.TabCount - 1] then
          tcMain.ActiveTab := tcMain.Tabs[tcMain.TabIndex + 1];
        Handled := True;
      end;

    sgiRight:
      begin
        if tcMain.ActiveTab <> tcMain.Tabs[0] then
          tcMain.ActiveTab := tcMain.Tabs[tcMain.TabIndex - 1];
        Handled := True;
      end;
  end;
end;

procedure TMainForm.LBTabsChange(Sender: TObject);
begin
  tcMain.ActiveTab := tcMain.Tabs[Math.Max(0, LBTabs.ItemIndex)];
  MultiView1.HideMaster;
end;

procedure TMainForm.LoginSuccess;
var
  I: Integer;
begin
  tcMain.TabPosition := TTabPosition.None;
  sbMenu.Visible := True;
  LBTabs.Clear;
  for I := 0 to tcMain.TabCount - 1 do
    LBTabs.Items.Add(tcMain.Tabs[I].Text);
  MainMenu.Visible := True;
  tcMain.Visible := True;
  SpareInstanceOfLoginFrm := LoginFrm;
  LoginFrm := nil;
  tcMain.ActiveTab := DashboardTab;
  tcMainChange(nil);
  Fill.Kind := TBrushKind.None;
end;

procedure TMainForm.NetHTTPClient1ValidateServerCertificate(
  const Sender: TObject; const ARequest: TURLRequest;
  const Certificate: TCertificate; var Accepted: Boolean);
begin
  Accepted := True;
end;

procedure TMainForm.NotificationCenter1ReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);
begin
///  MessageDlg('Got notif', M )
end;

procedure TMainForm.OpenBuildingDoorActExecute(Sender: TObject);
begin
  DispatchCommand(CMD_OPEN_BUILDING_DOOR);
end;

procedure TMainForm.OpenFlatDoorActExecute(Sender: TObject);
begin
    DispatchCommand(CMD_OPEN_FLAT_DOOR);
end;

procedure TMainForm.OpenOutDoorActExecute(Sender: TObject);
begin
  OpenBuildingDoorActExecute(Sender);
end;

procedure TMainForm.OrientationSensor1StateChanged(Sender: TObject);
begin
//
end;

procedure TMainForm.StartCentralHeatingActExecute(Sender: TObject);
begin
  StopCentralHeatingAct.Enabled := True;
  StartCentralHeatingAct.Enabled := False;
  TButton(Sender).Action := StopCentralHeatingAct;
end;

procedure TMainForm.tcMainChange(Sender: TObject);
var
  ActiveFrame: TFrame;
begin
  LBtitle.Text := Format('%s %s', [APP_NAME, tcMain.ActiveTab.Text]);
  if Assigned(LoginFrm) and not Boolean(LoginFrm.Tag) then //do not create any form until login succeeds
    Exit;
(*
  if not Assigned(LocalForms[tcMain.TabIndex]) then
    begin
      case tcMain.TabIndex of
        0:
          begin
            FrmiGA := TFrmiGA.Create(Self);
            ActiveFrame := FrmiGA;
            FrmiGA.FrameCreate(nil);
          end;
        1:
          begin
            FrmBooking := TFrmBooking.Create(Self);
            ActiveFrame := FrmBooking;
          end;
        2:
          begin
            FrmMyAccount := TFrmAccountMgmt.Create(Self);
            with FrmMyAccount do
              with PersonalInfo do
                begin
                  edUsername.Text := FullName;
                  edAddress.Text := Address;
                  memoAboutMe.Text := AboutMe;
                  edEmail.Text := Email;
                  edPhoneNumber.Text := PhoneNumber;
                end;
            ActiveFrame := FrmMyAccount;
          end;
        3:
          begin
            FrmInventory := TFrmInventory.Create(Self);
            ActiveFrame := FrmInventory;
          end;
        4:
          begin
            FrmItemsIRented := TFrmItemsIRented.Create(Self);
            ActiveFrame := FrmItemsIRented;
          end;
        5:
          begin
            FrmSettings := TFrmSettings.Create(Self);
            ActiveFrame := FrmSettings;
          end;
      end;
      if not Assigned(ActiveFrame) then
        Exit; //!!!
      ActiveFrame.Parent := tcMain.ActiveTab;
      ActiveFrame.Align := TAlignLayout.Client;
      LocalForms[tcMain.TabIndex] := ActiveFrame;
    end;
*)
end;

(*
procedure TMainForm.RestoreDefaultStyle();
begin
  Default_Style_Block_Pointer := TMemoryStream.Create;
  TStyleStreaming.SaveToStream(TStyleManager.ActiveStyle(Self),Default_Style_Block_Pointer,TStyleFormat.Binary);
end;

procedure TMainForm.SaveDefaultStyle();
begin
   Default_Style_Block_Pointer.Position := 0;
   TStyleManager.SetStyle(TStyleStreaming.LoadFromStream(Default_Style_Block_Pointer));
end;
*)
procedure TMainForm.ToggleLockUnlockActExecute(Sender: TObject);
begin
(*
  with FrmiGA do
  begin
    ToggleLockUnlockAct.ImageIndex := 45 - ToggleLockUnlockAct.ImageIndex;
    FrmiGA.Enabled := ToggleLockUnlockAct.ImageIndex = 23;
    DispatchCommand(CMD_LOCK, IntToStr(Integer(FrmiGA.Enabled)));
  end;
*)
end;

end.

