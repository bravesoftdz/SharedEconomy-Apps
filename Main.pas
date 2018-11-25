unit Main;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Gestures, System.Actions, FMX.ActnList, FMX.DateTimeCtrls, FMX.Layouts,
  FMX.Maps, FMX.Ani, FMX.Edit, System.Sensors, System.Sensors.Components,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  IdHTTP, System.Notification, IPPeerClient, REST.Backend.PushTypes,
  REST.Backend.MetaTypes, System.JSON, System.PushNotification,
  REST.Backend.BindSource, REST.Backend.PushDevice, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.ServiceComponents,
  REST.Backend.ServiceTypes, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Objects, FMX.ListBox,
  FMX.EditBox, FMX.NumberBox, FMX.ScrollBox, FMX.Memo, IdCookieManager,
  FMX.Platform, FMX.VirtualKeyboard, FMX.DialogService.Async,
  REST.Client, System.ImageList, FMX.ImgList, FMX.MultiView, System.Messaging,
  DataModule, MkUtils, ItemEditXFrm, AniIndicatorXFrm,
  LoginXFrm, StartupXFrm, ForgotXFrm, BrowserXFrm, DashboardXFrm, MyAccountXFrm,
  NotificationsXFrm, ChatDetailXFrm, ChatXFrm, CameraXFrm, NewItemPostedXFrm,
  ItemInfoXFrm, SettingsXFrm, uSharedEconomyConsts,
  FMX.Effects, FMX.Filter.Effects, FMX.StdActns, FMX.MediaLibrary.Actions,
  IdBaseComponent, System.Net.Mime


{$IFDEF Android}
  ,Androidapi.JNI.Os  //TJBuild
  ,Androidapi.Helpers // StringToJString
  ,FMX.PushNotification.Android
{$ENDIF}
{$IFDEF IOS}
  ,iOSapi.UIKit
  ,Posix.SysSysctl
  ,Posix.StdDef
  ,FMX.PushNotification.IOS
{$ENDIF}
  ;
const
  SUCCESS = 'Success!';
  FAILED = 'Failed!';
  APP_NAME = 'Shared Economy';

  PHP_SESSION_ID_NAME = 'PHPSESSID';

  DEFAULT_CMD_RETRIES = 3;


type
  TMainForm = class(TForm)
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    timerDelayAccess: TTimer;
    BackendPush1: TBackendPush;
    PushEvents1: TPushEvents;
    BackendAuth1: TBackendAuth;
    DelayedNotificationsTimer: TTimer;
    LBTabs: TListBox;
    MultiView1: TMultiView;
    Lang1: TLang;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    RESTResponse1: TRESTResponse;
    IdCookieManager1: TIdCookieManager;
    tcMain: TTabControl;
    DashboardTab: TTabItem;
    CameraTab: TTabItem;
    MyAccountTab: TTabItem;
    ChatTab: TTabItem;
    ChatDetailsTab: TTabItem;
    SettingsTab: TTabItem;
    MainMenu: TToolBar;
    LbTitle: TLabel;
    Button1: TButton;
    sbMenu: TSpeedButton;
    NotificationTab: TTabItem;
    Background: TRectangle;
    InvertEffect1: TInvertEffect;
    Image2: TImage;
    FloatAnimationFadeIn: TFloatAnimation;
    FloatAnimLeft: TFloatAnimation;
    FloatAnimOpacityIn: TFloatAnimation;
    FloatAnimScaleX: TFloatAnimation;
    FloatAnimScaleY: TFloatAnimation;
    FloatAnimationTop: TFloatAnimation;
    ChangeBkPicTimer: TTimer;
    BlurEffect1: TBlurEffect;
    LayBtnRentYourStuff: TLayout;
    Layout11: TLayout;
    BtnRentYourStuff: TRectangle;
    Image6: TImage;
    TxtBtnRentYourStuff: TText;
    LayEnableNotification: TLayout;
    Rectangle19: TRectangle;
    RectMessageWindow: TRectangle;
    Circle2: TCircle;
    Image12: TImage;
    Text30: TText;
    Text29: TText;
    FlowLayout4: TFlowLayout;
    Rectangle20: TRectangle;
    TxtBtnNoEnableNotif: TText;
    Rectangle21: TRectangle;
    TxtBtnEnableNotif: TText;
    LayBlackout: TLayout;
    Rectangle13: TRectangle;
    RentPopup: TFlowLayout;
    Rectangle14: TRectangle;
    Image7: TImage;
    Text24: TText;
    Rectangle15: TRectangle;
    Image8: TImage;
    Text25: TText;
    Rectangle16: TRectangle;
    Image9: TImage;
    Text26: TText;
    Rectangle18: TRectangle;
    Text28: TText;
    Rectangle17: TRectangle;
    Image10: TImage;
    Text27: TText;
    BtnCloseRentalPopup: TRectangle;
    Image11: TImage;
    FadeTransitionEffect1: TFadeTransitionEffect;
    FloatAnimRentYourStuff: TFloatAnimation;
    ElasticHeightAnimation: TFloatAnimation;
    WidthAnimation: TFloatAnimation;
    IL_32x32: TImageList;
    LayInviteFriends: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Circle1: TCircle;
    Image1: TImage;
    Text1: TText;
    Text2: TText;
    FlowLayout1: TFlowLayout;
    Rectangle4: TRectangle;
    Text4: TText;
    CalloutRectangle1: TCalloutRectangle;
    Image3: TImage;
    NetHTTPClient1: TNetHTTPClient;
    LbPhotoCaptureSource: TLayout;
    Layout2: TLayout;
    Rectangle3: TRectangle;
    TxtTakePhotoFromGallery: TText;
    Layout3: TLayout;
    Rectangle5: TRectangle;
    TxtTakePhotoFromCamera: TText;
    Layout4: TLayout;
    Rectangle6: TRectangle;
    TxtCancelTakePhoto: TText;
    Layout5: TLayout;
    PhotoSelectorFloatAnimator: TFloatAnimation;
    Text3: TText;
    RectEditItem: TRectangle;
    PhotoScrollBox: THorzScrollBox;
    LayHeader: TLayout;
    TxtHeader: TText;
    Image4: TImage;
    Rectangle7: TRectangle;
    MemoDescription: TMemo;
    ListBox2: TListBox;
    LbiLocation: TListBoxItem;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    EdTitle: TEdit;
    ListBoxItem2: TListBoxItem;
    Text8: TText;
    SwFreeCost: TSwitch;
    LbiPrice: TListBoxItem;
    Text9: TText;
    EdPrice: TEdit;
    LbiCategory: TListBoxItem;
    Layout1: TLayout;
    Rectangle26: TRectangle;
    Text46: TText;
    FloatAnimation2: TFloatAnimation;
    TxtRemainingDescriptionCharCount: TText;
    RectTopNotifWnd: TRectangle;
    Layout7: TLayout;
    Rectangle10: TRectangle;
    TxtCloseNotif: TText;
    FloatAnimation1: TFloatAnimation;
    TxtTitle: TText;
    TxtMessage: TText;
    TimerNotif: TTimer;
    GestureManager1: TGestureManager;
    ShadowEffect1: TShadowEffect;
    TxtNoChat: TText;
    Text6: TText;
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnAddScheduleClick(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure Button3Click(Sender: TObject);
    procedure DelayedNotificationsTimerTimer(Sender: TObject);
    procedure LBTabsChange(Sender: TObject);
    procedure tcMainChange(Sender: TObject);
    procedure NetHTTPClient1ValidateServerCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure OrientationSensor1StateChanged(Sender: TObject);
    procedure sbSettingsClick(Sender: TObject);
    procedure ChangeBkPicTimerTimer(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure TxtBtnNoEnableNotifClick(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure Text27Click(Sender: TObject);
    procedure PreviousTabAction1Update(Sender: TObject);
    procedure TxtTakePhotoFromGalleryClick(Sender: TObject);
    procedure PhotoSelectorFloatAnimatorFinish(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure MemoDescriptionChangeTracking(Sender: TObject);
    procedure Text46Click(Sender: TObject);
    procedure SwFreeCostSwitch(Sender: TObject);
    procedure TxtCloseNotifClick(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LbiCategoryClick(Sender: TObject);
  private
    NotificationsActive: Boolean;
    CurrentAPIUriIndex: Integer;
    NewItemCategory: String;
    AppIsClosing: Boolean;

    function GetHashedPassword: String;
  protected
    FHashedPassword: String;

    PHPSessionID: String;
    CookieManager: TCookieManager;
    FrmSendingCmd: TFrame;
    CurrentUserInfo: TUserInfo;

    property HashedPassword: String read GetHashedPassword;
    procedure PresentLoginFrame(Remove: Boolean = False; ShowLoginPanel: Boolean = False);
    procedure RestoreDefaultStyle;
    procedure SaveDefaultStyle;
  published
    property UserInfo: TUserInfo read CurrentUserInfo;
  private
    { Private declarations }
    Default_Style_Block_Pointer: TMemoryStream;
    CurrentLoginURLIndex: Integer;
    LastTab: TTabItem;
    UpdatingProfileData: Boolean;

    procedure DoServiceConnectionChange(Sender: TObject;
      PushChanges: TPushService.TChanges);
    procedure DoReceiveNotificationEvent(Sender: TObject;
      const ServiceNotification: TPushServiceNotification);
    procedure LogMessage(Msg: String; ClearLogBefore: Boolean = False);
    procedure DoOrientationChanged(const Sender: TObject; const M: TMessage);
    function LoadCredentials: Boolean; //isAutoLogin
    procedure SaveCredentials;
    function GetLoginParams(LastLoginKey: String): String;
    procedure InvalidateSavedPassword;
    function SendCommand(ACmd: String; Params: String = ''; FrmSender: TObject = nil; AMethod: TMkHTTPMethod = httpGet; ProcessCompleteCallback: TNotifyEvent = nil): Boolean; overload;
    function SendCommand(ACmd: String; Params: TMultipartFormData; FrmSender: TObject = nil; AMethod: TMkHTTPMethod = httpGet; ProcessCompleteCallback: TNotifyEvent = nil): Boolean; overload;
    procedure CreateLoginFrame;
    procedure RoundButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure RoundButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure OnCloseDialog(const AResult: System.UiTypes.TModalResult);
    procedure CreateStartupFrame;
    procedure RegisterPushService;
    procedure RegisterDevice;
    procedure UpdateSettings;
    procedure IVChangeAPIServer(Sender: TObject; var NewServerURL: String);
    procedure IVError(Sender: TObject; ErrorMessage: String);
    procedure IVLoginFailure(Sender: TObject);
    procedure IVLoginParams(Sender: TObject;  LastLoginKey: String; var UserName, Params, URL: String);
    procedure IVLoginSuccess(Sender: TObject; var UserInfo: TUserInfo);
    function CreateAPIThread(ACmd: String; FrmSender: TObject = nil; AMethod: TMkHTTPMethod = httpGet; ProcessCompleteCallback: TNotifyEvent = nil): TIVCmdThread;
    procedure UpdateProfileCallback(Sender: TObject);
    procedure UpdateMyAccountInfo;
    procedure SignupComplete(Sender: TObject);
    procedure CloseBlackoutPanel;
    procedure AddNewItemViaPhoto;
    procedure OnAPIThreadTerminate(Sender: TObject);
    procedure OnChatHistoryReceived(Sender: TObject);
    procedure OnPictureDownloaded(Sender: TObject);
    procedure CreateCameraForm;
    procedure GenerateItems(VScroller: TGridPanelLayout);
    function AddNewItem(Sender: TGridPanelLayout; var ItemInfoOrig: TItemInfo): TRectangle;
    procedure GetAllItems(OrderBy: String = 'post_date desc');
    procedure OnItemsReceived(Sender: TObject);
    procedure onUserPicDownloaded(Sender: TObject);
    procedure onUserIDPicDownloaded(Sender: TObject);
    procedure OnPicUploaded(Sender: TObject);
    procedure OnPicForChatReceived(Sender: TObject);
    function CloneCurrentUser: TUserInfo;
    procedure StartDownloadingResources;
    procedure OnThreadedPictureDownloaded(Sender: TObject);
    function GetSelectedItemCategory: String;
    procedure OnCategorySelect(Sender: TObject);
    procedure OnItemUpdateComplete(Sender: TObject);
    function CloneItemInfo(ItemInfo: TItemInfo): TItemInfo;
  public
    StartupFrm: TStartupFrm;
    BrowserFrm: TBrowserFrm;
    ForgotFrm: TForgotFrm;
    DashboardFrm: TDashboardFrm;
    MyAccountFrm: TMyAccountFrm;
    NotificationsFrm: TNotificationsFrm;
    ChatDetailFrm: TChatDetailFrm;
    ItemEditFrm: TItemEditFrm;
    ChatFrm: TChatFrm;
    CameraFrm: TCameraFrm;
    NewItemPostedFrm: TNewItemPostedFrm;
    ItemInfoFrm: TItemInfoFrm;
    SettingsFrm: TSettingsFrm;
    AniIndicatorFrm: TAniIndicatorFrm;
    LocalForms: Array[0..15] of TFrame;
    CategoryList: TStringList;

    AccessTimeout: Integer;
    OldX, OldY: Single;
    CurrentUsername: String;

    PushService: TPushService;
    ServiceConnection: TPushServiceConnection;
    DeviceId: string;
    DeviceToken: string;
    LoginFrm: TLoginFrm;
    CamDestination: TCamDestination;


    procedure WaitStart;  overload;
    procedure WaitEnd; overload;
    procedure LoginSuccess(UserInfo: TUserInfo);
    procedure Logout;
    procedure CreateForgotFrame;
    procedure ShowNotificationConfirmDialog;
    procedure ShowSettings(Sender: TObject; ActiveTabIndex: Integer = 0);
    procedure UpdateProfile(ParamData: String; Callback: TNotifyEvent = nil); overload;
    procedure UpdateProfile(ParamData: TMultipartFormData; Callback: TNotifyEvent = nil); overload;
    procedure UpdateProfile(ParamName, ParamValue: String; Callback: TNotifyEvent = nil); overload;
    procedure UpdateProfile; overload;
    procedure ButtonifyGroup(Sender: TText);

    procedure MoreInfo(Sender: TObject);
    procedure PostNewItem4Rental(Bmp: FMX.Graphics.TBitmap);
    procedure InitialLogin(Sender: TFrame = nil);
    procedure SendForgotEmail(EmailAddress: String; Sender: TFrame = nil);
    procedure Signup(Email, Password, Username: String; Sender: TFrame = nil);
    procedure WaitStart(Frame: TFrame);  overload;
    procedure WaitEnd(Frame: TFrame); overload;
    function GetUrlToMemStream(URL: String): TMemoryStream;
    function DownloadBitmap(URL: String; Bmp: FMX.Graphics.TBitmap; DefaultResourceImgName: String): Boolean;
    procedure DisplayURL(AURL: String; AFrameToReturnTo: TFrame);
    procedure ShowLoginFrame(IsLoginSelected: Boolean = False);
    function LocalMessageDlg(const Msg: string; const DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
      const DefaultBtn: TMsgDlgBtn; const HelpCtx: THelpContext; const CloseProc: TInputCloseDialogProc): Integer;
    procedure AssignBmpIndexToImg(var Bmp: FMX.Graphics.TBitmap; ImageIndex: Integer;
      ImageList: TImageList);
    procedure PasswordUpdatedCallback(Sender: TObject);

    procedure OpenCamera(Sender: TObject = nil; Catergory: String = ''; Dest: TCamDestination = cdItemPic);
    procedure OpenItemDetail(Sender: TObject);
    procedure FilterCategories(Category: String);
    procedure CategoryFiltered(Sender: TObject);
    procedure PostPicture(PhotoImg: FMX.Graphics.TBitmap; FName: String = 'tmp.img'; Category: String = ''); overload;
    procedure PostPicture(ScrollBox: THorzScrollBox; Category: String = ''); overload;
    procedure OpenMyAccount(Sender: TObject);
    procedure AddToFav(ItemInfo: TItemInfo);
    procedure RemoveFromFav(ItemInfo: TItemInfo);
    procedure SendMessageTo(UserID, ItemID: Integer; ChatMessage: String);
    procedure EditItem(ItemInfo: TItemInfo);
    procedure DisplayTopNotification(ATitle, AMessage: String);
    procedure AddChat(ChatInfo: TChatInfo; MessageFlags: TChatMessageTypes);
    procedure FillInUserLogo(UserInfo: TUserInfo; TxtInitial: TText);
    procedure ToggleAniIndicator(ShowAniForm: Boolean = True; AniParent: TFmxObject = nil);

    procedure CloseSettings;
    procedure CloseNotifications;
    procedure CloseChat;
    procedure CloseMoreInfo;
    procedure CancelLogin;
    procedure CloseForgot;
    procedure CloseBrowser;
    procedure CloseCameraFrame;
  published
    property SelectedItemCategory: String read GetSelectedItemCategory;
  end;

var
  MainForm: TMainForm;
  Locked: Boolean;
  is_iPhoneDevice: Boolean;

implementation

uses StrUtils, System.IOUtils, System.Threading, System.DateUtils, ChatItemXFrm,
  Math, FMX.Styles, AppVersion, UnescapeJSONString, System.IniFiles, uMkCmd,
  System.NetEncoding
{$ifdef MSWINDOWS}
  , Windows
{$endif}
  , SelectCategoryXFrm;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}

procedure TMainForm.RemoveFromFav(ItemInfo: TItemInfo);
begin
  //
end;

procedure TMainForm.AddToFav(ItemInfo: TItemInfo);
begin
  //
end;

function TMainForm.GetUrlToMemStream(URL: String): TMemoryStream;
var
  HTTPClient1: THTTPClient;
  HttpResponse: IHttpResponse;
  AHeaders: TArray<System.Net.URLClient.TNameValuePair>;
begin
  Result := TMemoryStream.Create;
  HTTPClient1 := THTTPClient.Create;
  HTTPClient1.OnValidateServerCertificate := NetHTTPClient1ValidateServerCertificate;
  try
    HttpResponse := HTTPClient1.Get(URL, Result);
    SetLength(AHeaders, 1);
    with AHeaders[0] do
      begin
        Name := 'Cookie'; //manually set cookie, default cookieManager SUCKS big time
        Value := Format('%s=%s', [PHP_SESSION_ID_NAME, MainForm.PHPSessionID]);
       end;
  finally
    SetLength(AHeaders, 0);
    FreeAndNil(HTTPClient1);
  end;
end;


procedure TMainForm.InvalidateSavedPassword;
begin
  FHashedPassword := '';
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

function TMainForm.GetHashedPassword: String;
begin
  Result := '';
  if FHashedPassword <> '' then
    Result := FHashedPassword
  else
    if Assigned(LoginFrm) then
      Result := getMd5HashString(LoginFrm.edPassword.Text);
end;

function TMainForm.GetLoginParams(LastLoginKey: String): String;
begin
  Result := '';
  Result := Format('%s/%s', [
    CurrentUsername,
    getMd5HashString(CurrentUsername + HashedPassword + HARDCODED_KEY + LastLoginKey)
  ]);
end;

function TMainForm.LocalMessageDlg(const Msg: string; const DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
   const DefaultBtn: TMsgDlgBtn; const HelpCtx: THelpContext; const CloseProc: TInputCloseDialogProc): Integer;
begin
  FMX.DialogService.Async.TDialogServiceAsync.MessageDialog(Msg, DlgType, Buttons, DefaultBtn, HelpCtx, CloseProc);
  Result := 0;
end;

procedure TMainForm.OnChatHistoryReceived(Sender: TObject);
var
  opair: TJSONPair;
  obj: TJSONObject;
  obj_val: TJSONValue;
  obj_arr: TJSONArray;
  Buddy: TUserInfo;
  Item: TItemInfo;
  ChatObj: TChatInfo;
  I: Integer;
  J: Integer;
  SL: TStringList;
  MsgFlags: TChatMessageTypes;
begin
  if not Assigned(Sender) then
    Exit;
  if not TIVCmdThread(Sender).LastCommandWasErroneous then
    begin
      SL := TStringList.Create;;
      try
        obj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TIVCmdThread(Sender).ResponseStringData), 0) as TJSONObject;
        if Assigned(obj) and Assigned(obj.get('chat')) then
          begin
            obj_val := obj.get('chat').JsonValue;
            if Assigned(obj_val) and (obj_val is TJSONArray) then
              begin
                obj_arr := obj_val as TJSONArray;
                for I := 0 to obj_arr.Count - 1 do
                  begin
                    Buddy := TUserInfo.Create;
                    Item := TItemInfo.Create;
                    ChatObj := TChatInfo.Create;
                    obj := (obj_arr.Items[I] as TJSonObject);
                    opair := obj.get('id');
                    if Assigned(opair) then
                      ChatObj.id := StrToInt(opair.JSONValue.Value);
                    opair := obj.get('title');
                    if Assigned(opair) then
                      ChatObj.title := opair.JSONValue.Value;
                    opair := obj.get('message');
                    if Assigned(opair) then
                      ChatObj.message := opair.JSONValue.Value;
                    opair := obj.get('flags');
                    if Assigned(opair) then
                      ChatObj.flags := StrToIntDef(opair.JSONValue.Value, 0);
                    opair := obj.get('date');
                    if Assigned(opair) then
                      ChatObj.date := StrToDateTimeDef(opair.JSONValue.Value, 0);

                    //item info
                    //c.name, c.description, c.price, c.views, c.post_date, c.popularity, d.name as category
                    opair := obj.get('item_pic');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
                      try
                        SL.Delimiter := ',';
                        SL.StrictDelimiter := True;
                        SL.DelimitedText := opair.JSONValue.Value;
                        Item.prefix := SL[0];
                        Item.Photos[0] := FMX.Graphics.TBitmap.Create;
                        Item.first_pic_width := StrToIntDef(SL[2], 300);
                        Item.first_pic_height := StrToIntDef(SL[3], 300);
                      except
                      end;
                    opair := obj.get('name');
                    if Assigned(opair) then
                      Item.title := opair.JSONValue.Value;
                    opair := obj.get('description');
                    if Assigned(opair) then
                      Item.description := opair.JSONValue.Value;
                    opair := obj.get('price');
                    if Assigned(opair) then
                      Item.price := StrToFloatDef(opair.JSONValue.Value, 0);
                    opair := obj.get('views');
                    if Assigned(opair) then
                      Item.views := StrToIntDef(opair.JSONValue.Value, 0);
                    opair := obj.get('post_date');
                    if Assigned(opair) then
                      Item.post_date := StrToDateTimeDef(opair.JSONValue.Value, 0);
                    opair := obj.get('popularity');
                    if Assigned(opair) then
                      Item.popularity := StrToFloatDef(opair.JSONValue.Value, 0);
                    opair := obj.get('category');
                    if Assigned(opair) then
                      Item.category := opair.JSONValue.Value;

                    //Buddy info
                    //b.picture, b.username, b.first_name, b.last_name
                    opair := obj.get('buddy_id');
                    if Assigned(opair) then
                      Buddy.id := StrToInt(opair.JSONValue.Value);
                    opair := obj.get('username');
                    if Assigned(opair) then
                      Buddy.username := opair.JSONValue.Value;
                    opair := obj.get('first_name');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null')then
                      Buddy.first_name := opair.JSONValue.Value;
                    opair := obj.get('last_name');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
                      Buddy.last_name := opair.JSONValue.Value;
                    opair := obj.get('picture');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null')then
                      SendCommand(CMD_PIC, opair.JSONValue.Value, Buddy, httpGet, OnPictureDownloaded);
                    Item.owner := Buddy;
                    ChatObj.ItemInfo := Item;
                    MsgFlags := [];
                    for J := Ord(Low(TChatMessageType)) to Ord(High(TChatMessageType)) do
                      if ((1 shl Ord(TChatMessageType(I))) and ChatObj.flags) = 1 then
                        Include(MsgFlags, TChatMessageType(I));
                    AddChat(ChatObj, MsgFlags);
                    if SL.Count > 3 then
                      SendCommand(CMD_ITEM_PIC, Item.prefix + SL[1], ChatObj, httpGet, OnPicForChatReceived);
                  end;
              end;
          end;
      finally
        FreeAndNil(SL);
      end;
  end;
end;

procedure TMainForm.OnPicForChatReceived(Sender: TObject);
var
  IVCmdThead: TIVCmdThread;
  BmpWrapper: TBmpWrapper;
  Rect: Trectangle;
  ItemInfo: TItemInfo;
  txt: TText;
begin
  if not Assigned(Sender) then
    Exit;
  IVCmdThead := TIVCmdThread(Sender);
  with IVCmdThead do
    if Assigned(IVCmdThead.Sender) then
      if (IVCmdThead.Sender is TChatInfo) and not LastCommandWasErroneous then
        with TChatItemFrm(TChatInfo(IVCmdThead.Sender).ChatItemFrm) do
          begin
            RectItemPic.Fill.Bitmap.Bitmap.LoadFromStream(ResponseStream);
            FillInUserLogo(TChatInfo(IVCmdThead.Sender).ItemInfo.owner, TxtOwnerInital);
          end;
end;

procedure TMainForm.ToggleAniIndicator(ShowAniForm: Boolean = True; AniParent: TFmxObject = nil);
begin
  if not Assigned(AniIndicatorFrm) then
    AniIndicatorFrm := TAniIndicatorFrm.Create(Self);
  if not Assigned(AniParent) then
    AniParent := Self;
  AniIndicatorFrm.Visible := ShowAniForm;
  AniIndicatorFrm.AniIndicator1.Enabled := ShowAniForm;
  AniIndicatorFrm.Align := TAlignLayout.Contents;
  AniIndicatorFrm.Parent := AniParent;
  if ShowAniForm then
    AniIndicatorFrm.Tag := Integer(BtnRentYourStuff.Visible);
  BtnRentYourStuff.Visible := not ShowAniForm and Boolean(AniIndicatorFrm.Tag);
end;

procedure TMainForm.OnPictureDownloaded(Sender: TObject);
var
  IVCmdThead: TIVCmdThread;
  BmpWrapper: TBmpWrapper;
  Rect: Trectangle;
  ItemInfo: TItemInfo;
  txt: TText;
begin
  if not Assigned(Sender) or AppIsClosing then
    Exit;
  IVCmdThead := TIVCmdThread(Sender);
  with IVCmdThead do
    if Assigned(IVCmdThead.Sender) then
      if (IVCmdThead.Sender is TUserInfo) and not LastCommandWasErroneous then
        with TUserInfo(IVCmdThead.Sender) do
          begin
            if not Assigned(Photo) then
              Photo := FMX.Graphics.TBitmap.Create;
            try
              Photo.LoadFromStream(ResponseStream);
            except
{$IFDEF MSWINDOWS}
              outputdebugstring(PWIdeChar(IVCmdThead.ResponseStringData));
{$ENDIF}
            end;
          end
      else
        if IVCmdThead.Sender is TBmpWrapper then
          try
            BmpWrapper := TBmpWrapper(IVCmdThead.Sender);
            ItemInfo := BmpWrapper.ItemInfo;
//            BmpWrapper.ItemInfo := nil;
            if not LastCommandWasErroneous then
              begin
                if not Assigned(ItemInfo.Photos[BmpWrapper.PhotoIndex]) then
                  ItemInfo.Photos[BmpWrapper.PhotoIndex] := FMX.Graphics.TBitmap.Create;
                ResponseStream.Seek(0, TSeekOrigin.soBeginning);
                ItemInfo.Photos[BmpWrapper.PhotoIndex].LoadFromStream(ResponseStream);
                if Assigned(ItemInfo.Parent) and (ItemInfo.Parent is TRectangle) then
                  begin
                    Rect := TRectangle(ItemInfo.Parent);
                    with Rect.Fill do
                      if not Assigned(Bitmap.Bitmap) or (Bitmap.Bitmap.Width <= 0) or (BmpWrapper.PhotoIndex = 0) then   //if the first pic has been used for paiting the slot, just keep the image in the array, do not paint it
                        begin
                          Bitmap.WrapMode := TWrapMode.TileStretch;
                          Bitmap.Bitmap.Assign(ItemInfo.Photos[BmpWrapper.PhotoIndex]);
                          Kind := TBrushKind.Bitmap;
                          Rect.Height := (Bitmap.Bitmap.Height/Bitmap.Bitmap.Width) * Rect.Width;
                        end;
                    Rect.Touch.GestureManager := GestureManager1;
                  end
                else
                  begin
                    if Assigned(ItemInfo) then ;

                  end;
              end;
            FreeAndNil(BmpWrapper);
            DashboardFrm.Repaint;
          except
          end;

end;

procedure TMainForm.OnCloseDialog(const AResult: System.UiTypes.TModalResult);
begin
  if AResult = mrOK then;
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

procedure TMainForm.LogMessage(Msg: String; ClearLogBefore: Boolean = False);
begin
//  if Assigned(FrmSettings) then
//    with FrmSettings do
//      begin
//        if ClearLogBefore then
//          MemoOutput.ClearContent;
//        LogMessage(Msg);
//      end;
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

procedure TMainForm.IVLoginSuccess(Sender: TObject; var UserInfo: TUserInfo);
begin
  ToggleAniIndicator(False);
  PHPSessionID := TCmdThread(Sender).PHPSessionID;
  CurrentUserInfo := UserInfo;
  LoginSuccess(UserInfo);
end;

procedure TMainForm.IVLoginFailure(Sender: TObject);
begin
  InvalidateSavedPassword;
  PresentLoginFrame(False, True);
  ToggleAniIndicator(False);
end;

procedure TMainForm.IVLoginParams(Sender: TObject; LastLoginKey: String; var UserName, Params, URL: String);
begin
  UserName := CurrentUsername;
  Params := GetLoginParams(LastLoginKey);
end;

procedure TMainForm.IVError(Sender: TObject; ErrorMessage: String);
begin
  ToggleAniIndicator(False);
  if ErrorMessage <> '' then
    MainForm.LocalMessageDlg('ERROR: ' + ErrorMessage, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOk, 0, MainForm.OnCloseDialog);
  if Assigned(Sender) then
    TCmdThread(Sender).RepeatCommandCount := 0;
  if Assigned(CurrentUserInfo) and (CurrentUserInfo.username = '') then
    IVLoginFailure(Sender);
end;

procedure TMainForm.IVChangeAPIServer(Sender: TObject; var NewServerURL: String);
begin
  if CurrentAPIUriIndex < High(API_URLS) then
    begin
      Inc(CurrentAPIUriIndex);
      NewServerURL := API_URLS[CurrentAPIUriIndex];
      CMD_TEMPLATE := NewServerURL;
    end
  else
   IVError(Sender, 'No working API server. Giving up.');
end;

function TMainForm.SendCommand(ACmd: String; Params: TMultipartFormData;
  FrmSender: TObject = nil; AMethod: TMkHTTPMethod = httpGet; ProcessCompleteCallback: TNotifyEvent = nil): Boolean;
begin
  with CreateAPIThread(ACmd, FrmSender, AMethod, ProcessCompleteCallback) do
    begin
      MultipartFormData := Params;
      OnTerminate := OnAPIThreadTerminate;
      Start;
    end;
  Result := True;
end;

procedure TMainForm.OnAPIThreadTerminate(Sender: TObject);
begin
end;

function TMainForm.CreateAPIThread(ACmd: String; FrmSender: TObject = nil;
  AMethod: TMkHTTPMethod = httpGet; ProcessCompleteCallback: TNotifyEvent = nil): TIVCmdThread;
begin
  Result := TIVCmdThread.Create(True);
  with Result do
    begin
      PHPSessionID := Self.PHPSessionID;
      Sender := FrmSender;
      APIUrl := API_URLS[CurrentAPIUriIndex];
      Cmd := ACmd;
      FreeOnTerminate := True;
      HTTPMethod := AMethod;

      OnLoginSuccess := IVLoginSuccess;
      OnLoginFailure := IVLoginFailure;
      OnLoginParams := IVLoginParams;
      OnError := IVError;
      OnChangeAPIServer := IVChangeAPIServer;
      OnProcessComplete := ProcessCompleteCallback;
    end;
end;

function TMainForm.SendCommand(ACmd: String; Params: String = '';
  FrmSender: TObject = nil; AMethod: TMkHTTPMethod = httpGet;
  ProcessCompleteCallback: TNotifyEvent = nil): Boolean;
begin
  with CreateAPIThread(ACmd, FrmSender, AMethod, ProcessCompleteCallback) do
    begin
      CmdParams := Params;
      if (ACmd = CMD_ITEM_PIC) or (ACmd = CMD_PIC) then
        RepeatCommandCount := 1;
      OnTerminate := OnAPIThreadTerminate;
      Start;
    end;
  Result := True;
end;

procedure TMainForm.ShowLoginFrame(IsLoginSelected: Boolean = False);
begin
  BlurEffect1.Enabled := True;
  StartupFrm.Visible := False; //disposing itself
  CreateLoginFrame;
  LoadCredentials;
  PresentLoginFrame();
  if IsLoginSelected then
    with LoginFrm do
      SbSignupSegButtonClick(SbLoginSegButton);
end;

procedure TMainForm.ShowNotificationConfirmDialog;
begin
  LayEnableNotification.Visible := True;
end;

procedure TMainForm.ShowSettings(Sender: TObject; ActiveTabIndex: Integer = 0);
begin
  if Sender is TFrame then
    TFrame(Sender).Enabled := False;   //wait spinner here
  tcMain.TabPosition := TTabPosition.None;
  if not Assigned(SettingsFrm) then
    begin
      SettingsFrm := TSettingsFrm.Create(Self);
      with SettingsFrm do
        begin
          Parent := Self;
          ButtonifyGroup(TxtBtnSave);
          TxtVersion.Text := GetApplicationVersion;
          DefaultTabIndex := ActiveTabIndex;
          if Sender is TFrame then
            CallingFrame := TFrame(Sender);
        end;
    end;

  with SettingsFrm do
    begin
      EdNewPass.Text := '';
      EdConfirmPass.Text := '';
      LbiPass.ItemData.Detail := '';
      CallingFrame.Visible := False;
      Visible := True;
      TcSettings.TabIndex := ActiveTabIndex;
      Tag := 1; //avoid firing update messages when actually setting them
      UpdateSettings;
      Tag := 0;
    end;

  LayBtnRentYourStuff.Visible := False;
end;

procedure TMainForm.CloseSettings;
begin
  with SettingsFrm do
    begin
      Visible := False;
      CallingFrame.Enabled := True;
      CallingFrame.Visible := True;
    end;
  LayBtnRentYourStuff.Visible := True;
  tcMain.TabPosition := TTabPosition.Bottom;
end;

procedure TMainForm.PostPicture(ScrollBox: THorzScrollBox; Category: String = '');
const
  IMG_FNAME_TPL = 'tmp_%d.img';
var
  I: Integer;
  Img: TImage;
  MP: TMultipartFormData;
  FieldName, Filename: String;
  Str: TmemoryStream;
  ItemInfo: TItemInfo;
  UserInfo: TUserInfo;
begin
  ToggleAniIndicator;
  MP := TMultipartFormData.Create;
  Str := TmemoryStream.Create;
  ItemInfo := TItemInfo.Create;

  try
    for I := 0 to ScrollBox.Content.ControlsCount - 1 do
      if ScrollBox.Content.Controls[I] is TImage then
        begin

          Img := TImage(ScrollBox.Content.Controls[I]);
          if not Assigned(Img.Bitmap) or (Img.Bitmap.Width <= 0) then
            Continue; //empty slot
{$IFDEF IOS}
          FileName := System.IOUtils.TPath.Combine(TPath.GetDocumentsPath, Format(IMG_FNAME_TPL, [I]));
{$ELSE}
  {$IF DEFINED(MSWINDOWS) or DEFINED(MACOS)}
          FileName := TPath.GetTempFileName;
  {$else}
          FileName := System.IOUtils.TPath.Combine(TPath.GetHomePath, Format(IMG_FNAME_TPL, [I]));
  {$ENDIF}
{$ENDIF}
          //look for a streaming solution, right now this is a quick dirty thing that works, using  streams didn't
          Str.Clear;
          Img.Bitmap.SaveToStream(Str);
          Str.Seek(0, TSeekOrigin.soBeginning);
          Str.SaveToFile(FileName);
          FieldName := Format('FILE_%d_%d', [Ord(CamDestination), I]);
          MP.AddFile(FieldName, FileName);
          MP.AddField(Format('%s-height', [FieldName]), IntToStr(Img.Bitmap.Height));
          MP.AddField(Format('%s-width', [FieldName]), IntToStr(Img.Bitmap.Width));
          ItemInfo.Photos[ItemInfo.PhotoCount] := FMX.Graphics.TBitmap.Create;
          ItemInfo.Photos[ItemInfo.PhotoCount].Assign(Img.Bitmap);
          if ItemInfo.first_pic_height = 0 then
            begin
              ItemInfo.first_pic_height := Img.Bitmap.Height;
              ItemInfo.first_pic_width := Img.Bitmap.Width;
            end;
          Inc(ItemInfo.PhotoCount);
          //check file deletion after that. should not be a pb as temp files delete themselves, and the rest of the indexed files are reused
        end;
    MP.AddField('category', Category);
    UserInfo := CloneCurrentUser;
    ItemInfo.owner := UserInfo;
    ItemInfo.first_pic_height := Img.Bitmap.Height;
    ItemInfo.first_pic_width := Img.Bitmap.Width;
    ItemInfo.post_date := Now;


  finally
    FreeAndNil(Str);
    CamDestination := cdItemPic;
    SendCommand(CMD_POST_PHOTO_ITEM, MP, ItemInfo, httpPost, OnPicUploaded);
  end;
end;

function TMainForm.CloneCurrentUser: TUserInfo;
begin
  Result := TUserInfo.Create;
  Result.id := CurrentUserInfo.id;
  Result.username := CurrentUserInfo.username;
  Result.first_name := CurrentUserInfo.first_name;
  Result.last_name := CurrentUserInfo.last_name;
  Result.latitude := CurrentUserInfo.latitude;
  Result.longitude := CurrentUserInfo.longitude;
  Result.picture := CurrentUserInfo.picture;
  Result.Photo := FMX.Graphics.TBitmap.Create;
  Result.Photo.Assign(CurrentUserInfo.Photo);
end;

function TMainForm.CloneItemInfo(ItemInfo: TItemInfo): TItemInfo;
begin
  Result := TItemInfo.Create;
  Result.id := ItemInfo.id;
  Result.title := ItemInfo.title;
  Result.description := ItemInfo.description;
  Result.owner := ItemInfo.owner;
  Result.price := ItemInfo.price;
  Result.first_pic_height := ItemInfo.first_pic_height;
  Result.first_pic_width := ItemInfo.first_pic_width;
  Result.post_date := ItemInfo.post_date;
  Result.prefix := ItemInfo.prefix;
  Result.views := ItemInfo.views;
  Result.PhotoCount := ItemInfo.PhotoCount;
  Move(ItemInfo.PhotoFilenames, Result.PhotoFilenames, SizeOf(ItemInfo.PhotoFilenames));
  Move(ItemInfo.Photos, Result.Photos, SizeOf(ItemInfo.Photos));
end;


procedure TMainForm.OnItemsReceived(Sender: TObject);
var
  opair: TJSONPair;
  obj3, obj2, obj: TJSONObject;
  obj_val: TJSONValue;
  obj_arr, obj_arr2: TJSONArray;
  Buddy: TUserInfo;
  InfoItem: TItemInfo;
  I: Integer;
  J: Integer;
  MsgFlags: TChatMessageTypes;
  Rect: TRectangle;

  TE: TEdit;
begin

  if not Assigned(Sender) then
    begin
      ToggleAniIndicator(False);
      Exit;
    end;

  if not TIVCmdThread(Sender).LastCommandWasErroneous then
    begin
      DashboardFrm.VertScrollBox4.BeginUpdate;
      try
        obj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TIVCmdThread(Sender).ResponseStringData), 0) as TJSONObject;
        if Assigned(obj) and Assigned(obj.get('items')) then
          begin
            obj_val := obj.get('items').JsonValue;
            if Assigned(obj_val) and (obj_val is TJSONArray) then
              begin
                obj_arr := obj_val as TJSONArray;
                for I := 0 to obj_arr.Count - 1 do
                  begin
                    obj := (obj_arr.Items[I] as TJSonObject);

                    InfoItem := TItemInfo.Create;
                    //Buddy info
                    //b.picture, b.username, b.first_name, b.last_name
                    Buddy := TUserInfo.Create;
                    opair := obj.get('fk_user_id');
                    if Assigned(opair) then
                      Buddy.id := StrToInt(opair.JSONValue.Value);
                    opair := obj.get('username');
                    if Assigned(opair) then
                      Buddy.username := opair.JSONValue.Value;
                    opair := obj.get('first_name');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null')then
                      Buddy.first_name := opair.JSONValue.Value;
                    opair := obj.get('last_name');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
                      Buddy.last_name := opair.JSONValue.Value;
                    opair := obj.get('picture');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
                      Buddy.picture := opair.JSONValue.Value;
//                      SendCommand(CMD_PIC, IntToStr(Buddy.id), Buddy, httpGet, OnPictureDownloaded);

                    //item info
                    //c.name, c.description, c.price, c.views, c.post_date, c.popularity, d.name as category
                    opair := obj.get('id');
                    if Assigned(opair) then
                      InfoItem.id := StrToInt(opair.JSONValue.Value);
                    opair := obj.get('name');
                    if Assigned(opair)  and (opair.JSONValue.Value <> 'null') then
                      InfoItem.title := opair.JSONValue.Value;
                    opair := obj.get('description');
                    if Assigned(opair)  and (opair.JSONValue.Value <> 'null') then
                      InfoItem.description := opair.JSONValue.Value;
                    opair := obj.get('price');
                    if Assigned(opair) then
                      InfoItem.price := StrToFloatDef(opair.JSONValue.Value, 0);
                    opair := obj.get('views');
                    if Assigned(opair) then
                      InfoItem.views := StrToIntDef(opair.JSONValue.Value, 0);
                    opair := obj.get('post_date');
                    if Assigned(opair) then
                      InfoItem.post_date := StrToDateTimeDef(opair.JSONValue.Value, 0);
                    opair := obj.get('popularity');
                    if Assigned(opair) then
                      InfoItem.popularity := StrToFloatDef(opair.JSONValue.Value, 0);
                    opair := obj.get('category');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
                      InfoItem.category := opair.JSONValue.Value;
                    opair := obj.get('prefix');
                    if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
                      InfoItem.prefix := opair.JSONValue.Value;

                    InfoItem.owner := Buddy;

                    if Assigned(obj.get('photos')) then
                      begin
                        obj_val := obj.get('photos').JsonValue;

                        if Assigned(obj_val) and (obj_val is TJSONArray) then
                          begin
                            obj_arr2 := obj_val as TJSONArray;
                            InfoItem.PhotoCount := obj_arr2.Count;
                            for J := 0 to Min(obj_arr2.Count -1, MAX_HIGH_PHOTO_COUNT) do
                              if Assigned(obj_arr2.Items[J]) then
                              begin
                                obj2 := (obj_arr2.Items[J] as TJSonObject);
                                opair := obj2.get('file_name');
                                if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
                                  InfoItem.PhotoFilenames[J] := opair.JSONValue.Value;
                                if J = 0 then
                                  begin
                                    opair := obj2.get('height');
                                    if Assigned(opair) then
                                      InfoItem.first_pic_height := StrToIntDef(opair.JSONValue.Value, MIN_PIC_HEIGHT);
                                    opair := obj2.get('width');
                                    if Assigned(opair) then
                                      InfoItem.first_pic_width := StrToIntDef(opair.JSONValue.Value, 0);
                                        Rect := AddNewItem(DashboardFrm.ItemsVerticalScroller, InfoItem);
                                  end;
                              end;
                          end;
                      end;
                    if Assigned(Rect) and not Assigned(Rect.TagObject) then
                      Rect.Tag := 1;
                  end;

              end;
          end;
      finally
        DashboardFrm.VertScrollBox4.EndUpdate;
        ToggleAniIndicator(False);
        StartDownloadingResources;
      end;
    end;
  DashboardFrm.Repaint;
end;

const
  MaxThreadCount = 4;
var
  CurrentThreadCount: Integer = 0;

procedure TMainForm.OnThreadedPictureDownloaded(Sender: TObject);
begin
  OnPictureDownloaded(Sender);
  System.AtomicDecrement(CurrentThreadCount);
end;

procedure TMainForm.StartDownloadingResources;
begin
  TTask.Run(
    procedure
    var
      I: Integer;
      AMax: Integer;

      procedure FeedAndDownload(CurrentLayout: TLayout; Index: Integer);
      var
        BmpWrapper: TBmpWrapper;
        Rect: TRectangle;
      begin
        while CurrentThreadCount >= MaxThreadCount do
          begin
            if AppIsClosing then
              Exit;
            Sleep(100);
          end;

        Rect := TRectangle(CurrentLayout.Children[Index]);
        BmpWrapper := TBmpWrapper.Create;
        BmpWrapper.ItemInfo := TItemInfo(Rect.TagObject);
        if Assigned(BmpWrapper.ItemInfo) then
          begin
            BmpWrapper.PhotoIndex := 0;
            BmpWrapper.Src:= Format('%s%s', [BmpWrapper.ItemInfo.prefix, BmpWrapper.ItemInfo.PhotoFilenames[0]]); //download only the first image

            System.AtomicIncrement(CurrentThreadCount);
            SendCommand(CMD_ITEM_PIC, BmpWrapper.Src, BmpWrapper, httpGet, OnThreadedPictureDownloaded);
          end;
      end;
    begin
      try
        AMax := Max(DashboardFrm.LayLeftItemList.ChildrenCount, DashboardFrm.LayRightItemList.ChildrenCount);
        for I := 0 to AMax - 1 do
          begin
            if AppIsClosing then
              Exit; //App is terminating
            if (DashboardFrm.LayLeftItemList.ChildrenCount > I) then
              FeedAndDownload(DashboardFrm.LayLeftItemList, I);
            if AppIsClosing then
              Exit; //App is terminating
            if (DashboardFrm.LayRightItemList.ChildrenCount <> I) then
              FeedAndDownload(DashboardFrm.LayRightItemList, I);
           end;
      except
      end;
    end
  );
end;

procedure TMainForm.GetAllItems(OrderBy: String = 'post_date desc');
begin
  ToggleAniIndicator;
  SendCommand(CMD_ITEM, Format('list/all/%s', [TURI.URLEncode(OrderBy)]), nil, httpGet, OnItemsReceived);
end;

procedure TMainForm.PostPicture(PhotoImg: FMX.Graphics.TBitmap; FName: String = 'tmp.img'; Category: String = '');
var
  MP: TMultipartFormData;
  Filename, Cmd: String;
  Str: TmemoryStream;
begin
{$IFDEF IOS}
  FileName := System.IOUtils.TPath.Combine(TPath.GetDocumentsPath, FName);
{$ELSE}
  {$IF DEFINED(MSWINDOWS) or DEFINED(MACOS)}
    FileName := TPath.GetTempFileName;
  {$else}
    FileName := System.IOUtils.TPath.Combine(TPath.GetHomePath, FName);
  {$ENDIF}
{$ENDIF}
  Str := TmemoryStream.Create;
  PhotoImg.SaveToStream(Str);
  Str.Seek(0, TSeekOrigin.soBeginning);
  Str.SaveToFile(FileName);
  MP := TMultipartFormData.Create;
  with MP do
    begin
      AddFile(Format('FILE_%d', [Ord(CamDestination)]), FileName);
      AddField('category', Category);
    end;
  case CamDestination of
    cdProfilePhoto: Cmd := CMD_POST_PHOTO;
    cdProfilePhotoID: Cmd := CMD_POST_PHOTO_ID;
    cdItemPic: Cmd := CMD_POST_PHOTO_ITEM;
  end;

  SendCommand(Cmd, MP, CameraFrm, httpPost, OnPicUploaded);
end;

procedure TMainForm.OnPicUploaded(Sender: TObject);
var
  ItemInfo: TItemInfo;
begin
  ToggleAniIndicator(False);
  case CamDestination of
    cdProfilePhoto:
      begin
        if not Assigned(UserInfo.Photo) then
          UserInfo.Photo := FMX.Graphics.TBitmap.Create;
        UserInfo.Photo.Assign(CameraFrm.GalleryImage.Bitmap);
        if Assigned(SettingsFrm) then
          FillInUserLogo(UserInfo, SettingsFrm.TxtName);
        if Assigned(MyAccountFrm) then
          FillInUserLogo(CurrentUserInfo, MyAccountFrm.TxtFirstLetter);
        DisplayTopNotification('Upload Success!', 'Profile photo successfully uploaded.');
      end;
    cdProfilePhotoID:
      begin
        if not Assigned(UserInfo.PhotoID) then
          UserInfo.PhotoID := FMX.Graphics.TBitmap.Create;
        UserInfo.PhotoID.Assign(CameraFrm.GalleryImage.Bitmap);
        if Assigned(SettingsFrm) then
          SettingsFrm.LbiPhotoID.ItemData.Detail := '[UPLOADED]';
        DisplayTopNotification('Upload Success!', 'ID Photo successfully uploaded.');
      end;
    cdItemPic:
      begin
        if Assigned(Sender) and Assigned(TIVCmdThread(Sender)) and (TIVCmdThread(Sender).Sender is TItemInfo) then
          begin
            ItemInfo := TItemInfo(TIVCmdThread(Sender).Sender);
            AddNewItem(DashboardFrm.ItemsVerticalScroller, ItemInfo);
            DashboardFrm.Repaint;
          end;
        DisplayTopNotification('Upload Success!', 'Item photo(s) successfully uploaded.');
      end;
  end;

end;

procedure TMainForm.PostNewItem4Rental(Bmp: FMX.Graphics.TBitmap);
begin
//  SendCommand(CMD_UPLOAD_NEW_ITEM);
end;

procedure TMainForm.PresentLoginFrame(Remove: Boolean = False; ShowLoginPanel: Boolean = False);
begin
  if not Assigned(LoginFrm) then
    CreateLoginFrame;
  if Remove then
    begin
      LoginFrm.Visible := False; //Parent := nil
      Self.Fill.Kind := TBrushKind.None;
      LBTabs.ItemIndex := -1;
    end
  else
    begin
      LoginFrm.Parent := Self;
      LoginFrm.Enabled := True;
      LoginFrm.Visible := True;
      Self.Fill.Kind := TBrushKind.Solid;
    end;
  if ShowLoginPanel then
    LoginFrm.SbSignupSegButtonClick(LoginFrm.SbLoginSegButton)
  else
    LoginFrm.SbSignupSegButtonClick(LoginFrm.SbSignupSegButton);
  BlurEffect1.Enabled := not Remove;
  tcMain.Visible := Remove;
  ChangeBkPicTimerTimer(nil);
  ChangeBkPicTimer.Enabled := True;
  //MainMenu.Visible := Remove;
end;

procedure TMainForm.PreviousTabAction1Update(Sender: TObject);
begin
//
end;

procedure TMainForm.RegisterPushService;
begin
  PushService := nil;
  ServiceConnection := nil;

{$IF defined(ANDROID)}
  PushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.GCM);
  PushService.AppProps[TPushService.TAppPropNames.GCMAppID] := FAndroidServerKey;
{$ENDIF}
{$IF defined(IOS) AND defined(CPUARM)}
  PushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.APS);
{$ENDIF}
  if Assigned(PushService) then
    begin
{$IF defined(ANDROID)}
      PushService.AppProps[TPushService.TAppPropNames.GCMAppID] := '370436230522';
{$ENDIF}
      ServiceConnection := TPushServiceConnection.Create(PushService);
      ServiceConnection.OnChange := DoServiceConnectionChange;
      ServiceConnection.OnReceiveNotification := DoReceiveNotificationEvent;
      RegisterDevice;
    end
  else
    begin
      LogMessage('Cannot create a PushService instance!');
      Exit;
    end;
end;

procedure TMainForm.RegisterDevice;
begin
  TTask.Run(
    procedure
    var
      aHTTP: THTTPClient;
    begin
      ServiceConnection.Active := True;
      aHTTP := THTTPClient.Create;
      try
        aHTTP.Get('http://sharedeconomy.impactvision.co.uk/api.php?method=saveToken&deviceID=' + MainForm.DeviceID + '&deviceToken=' +
          MainForm.DeviceToken + '&platform='{$IFDEF ANDROID} + 'ANDROID' {$ELSEIF defined(IOS)} + 'IOS' {$ENDIF});
      finally
        FreeAndNil(aHTTP);
      end;
    end);
end;

procedure TMainForm.FilterCategories(Category: String);
var
  I: Integer;
begin
  if Category <> '' then
    SendCommand(CMD_FILTER_CATEGORY, Category, DashboardFrm, httpGet, CategoryFiltered);
  with DashboardFrm.LayLeftItemList do
    for I := 0 to ChildrenCount - 1 do
      if Assigned(Children[I]) and Assigned(Children[I].TagObject) then
        TControl(Children[I]).Visible := (Category = '') or (TItemInfo(Children[I].TagObject).category = Category);
  with DashboardFrm.LayRightItemList do
    for I := 0 to ChildrenCount - 1 do
      if Assigned(Children[I]) and Assigned(Children[I].TagObject) then
        TControl(Children[I]).Visible := (Category = '') or (TItemInfo(Children[I].TagObject).category = Category);
end;

procedure TMainForm.FloatAnimation1Finish(Sender: TObject);
begin
  RectTopNotifWnd.Visible := not FloatAnimation1.Inverse;
  if RectTopNotifWnd.Visible then
    RectTopNotifWnd.Align := TAlignLayout.Horizontal;
  Invalidate;
end;

procedure TMainForm.DisplayTopNotification(ATitle, AMessage: String);
begin
  TimerNotif.Enabled := True;
  TxtTitle.Text := ATitle;
  TxtMessage.Text := AMessage;
  RectTopNotifWnd.BringToFront;
  FloatAnimation1.Inverse := False;
  RectTopNotifWnd.Position.Y := -RectTopNotifWnd.Height;
  FloatAnimation1.StartValue := -RectTopNotifWnd.Height;
  FloatAnimation1.StopValue := 10;
  RectTopNotifWnd.Visible := True;
end;

procedure TMainForm.FloatAnimation2Finish(Sender: TObject);
begin
  RectEditItem.Visible := not FloatAnimation2.Inverse;
  if RectEditItem.Visible then
    RectEditItem.Align := TAlignLayout.Client;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveCredentials;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
{$IFDEF IOS}
  is_iPhoneDevice := Pos('iPhone', GetDeviceModelString) > 0;
  ChangeBkPicTimer.Enabled := is_iPhoneDevice;
{$ENDIF}
  ToggleAniIndicator;
  CurrentLoginURLIndex := 0;
  Background.Visible := True;
  LayBlackout.Visible := False;
  LayEnableNotification.Visible := False;
  RectEditItem.Visible := False;

{$IF Defined(ANDROID) or Defined(IOS)}
  BorderStyle := TFmxFormBorderStyle.None;
  FullScreen := True;
  SystemStatusBar.Visibility := TFormSystemStatusBar.TVisibilityMode.VisibleAndOverlap;
{$ENDIF}

//  style := TStyleStreaming.LoadFromResource(HInstance, 'iGetAccess', RT_RCDATA);
//  TStyleManager.SetStyle(style);
  TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage, DoOrientationChanged);

  PhotoSelectorFloatAnimator.StartValue := tcMain.Position.Y + tcMain.Height;
  PhotoSelectorFloatAnimator.StopValue := PhotoSelectorFloatAnimator.StartValue - LbPhotoCaptureSource.Height - 60;
  ButtonifyGroup(TxtTakePhotoFromGallery);
  ButtonifyGroup(TxtTakePhotoFromCamera);
  ButtonifyGroup(TxtCancelTakePhoto);

  //MainMenu.Visible := False;
  tcMain.Visible := False;
  CookieManager := TCookieManager.Create;

  RegisterPushService;

  ButtonifyGroup(TxtBtnRentYourStuff);
  ButtonifyGroup(TxtBtnNoEnableNotif);
  ButtonifyGroup(TxtBtnEnableNotif);
  LayBtnRentYourStuff.BringToFront;
  //TxtBtnNoEnableNotif.TextSettings.FontColor := COLOR_FIRERED;

  LayBtnRentYourStuff.Visible := False;

  if LoadCredentials then //
    InitialLogin
  else
    CreateStartupFrame;
  RectEditItem.Visible := False;

//  if not LoadCredentials then //NO AutoLogin
//    PresentLoginFrame
//  else
//    InitialLogin;
end;

procedure TMainForm.ButtonifyGroup(Sender: TText);
begin
  Sender.OnMouseDown := RoundButtonMouseDown;
  Sender.OnMouseUp := RoundButtonMouseUp;
  TRectangle(Sender.Parent).ClipChildren := True;
end;

procedure TMainForm.CreateLoginFrame;
begin
  if not Assigned(LoginFrm) then
    begin
      LoginFrm := TLoginFrm.Create(Self);
      with LoginFrm do
        begin
          Name := Format('LoginFrm%s', [FormatDateTime('hms', Now)]);
          Align := TAlignLayout.Client;
          Parent := Self;
          ButtonifyGroup(TxtBtnLogin);
          FreeAndNil(Rectangle1);
        end;
    end;
end;

procedure TMainForm.CreateStartupFrame;
begin
  if not Assigned(StartupFrm) then
    StartupFrm := TStartupFrm.Create(Self);
  with StartupFrm do
    begin
      Name := Format('StartupFrmFrm%s', [FormatDateTime('hms', Now)]);
      Align := TAlignLayout.Client;
      Parent := Self;
      Text2.Text := 'Terms && Conditions';
{$IFDEF IOS}
      if is_iPhoneDevice then
        ChangeBkPicTimerTimer(nil);
{$ELSE}
      ChangeBkPicTimerTimer(nil);
{$endif}
    end;
end;

procedure TMainForm.DisplayURL(AURL: String; AFrameToReturnTo: TFrame);
begin
  if not Assigned(BrowserFrm) then
    begin
      BrowserFrm := TBrowserFrm.Create(Self);
      with BrowserFrm do
        begin
          Name := Format('BrowserFrmFrmFrm%s', [FormatDateTime('hms', Now)]);
          Align := TAlignLayout.Client;
          Visible := False;
          Parent := Self;
        end;
    end;
  with BrowserFrm do
    begin
      Visible := False;
      FrameToReturnTo := AFrameToReturnTo;
      FrameToReturnTo.Visible := False;
      BringToFront;
      WebBrowser.URL := AURL;
      WebBrowser.Navigate;
    end;
end;

function TMainForm.DownloadBitmap(URL: String; Bmp: FMX.Graphics.TBitmap; DefaultResourceImgName: String): Boolean;
var
  MS: TStream;
begin
  Result := True;
  MS := MainForm.GetUrlToMemStream(URL); //no exception raised, just an empty stream
  if not Assigned(MS) and (DefaultResourceImgName <> '') then
    MS := TResourceStream.Create(HInstance, DefaultResourceImgName, RT_RCDATA)
  else
    Result := False;
  Bmp.LoadFromStream(MS);
  FreeAndNil(MS);
end;

procedure TMainForm.ChangeBkPicTimerTimer(Sender: TObject);
var
  InStream: TResourceStream;
  WasWrong: Boolean;
  ImgScaleFactor, ScreenScaleFactor: Single;
  ImgResName: String;
  I: Integer;
begin
  repeat
    WasWrong := False;
    try
      ImgResName := Format('PngImage_%d', [Random(7)+1]);
      InStream := TResourceStream.Create(HInstance, ImgResName, RT_RCDATA);
    except
      ChangeBkPicTimer.Enabled := False;
      Exit;
    end;
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
            if not Boolean(TFloatAnimation(Image2.Children[I]).Tag) then
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
end;

procedure TMainForm.CloseCameraFrame;
begin
  if Assigned(CameraFrm) then
    begin
      tcMain.ActiveTab := DashboardTab;
      CameraFrm.DoDeinitialize;
    end;
end;

procedure TMainForm.CloseBrowser;
begin
  if Assigned(BrowserFrm) then
    begin
      BrowserFrm.FrameToReturnTo.Visible := True;
      BrowserFrm.Visible := False;
    end;
end;

procedure TMainForm.CloseForgot;
begin
  ForgotFrm := nil;
  LoginFrm.Visible := True;
end;

procedure TMainForm.SendForgotEmail(EmailAddress: String; Sender: TFrame = nil);
begin
  SendCommand(CMD_FORGOT, Format('%s/%s', [EmailAddress, TURI.URLEncode('Password Recovery')]), Sender);
  ForgotFrm.Visible := False;
  ShowMessage('If you entereded a registered email address, you should receive a message shortly, containing instructions on how to reset your password.');
  PresentLoginFrame(False, True);
end;

procedure TMainForm.CreateForgotFrame;
begin
  if not Assigned(ForgotFrm) then
    begin
      ForgotFrm := TForgotFrm.Create(Self);
      with ForgotFrm do
        begin
          Name := Format('ForgotFrm%s', [FormatDateTime('hms', Now)]);
          Align := TAlignLayout.Client;
          Parent := Self;
          ButtonifyGroup(TxtBtnForgot);
          EdUsername.Text := LoginFrm.EdUsernameOrEmail.Text;
        end;
    end;
  ForgotFrm.Visible := True;
end;

procedure TMainForm.Signup(Email, Password, Username: String; Sender: TFrame = nil);
begin
  SendCommand(CMD_SIGNUP, Format('email=%s&password=%s&username=%s', [Email, Password, Username]), Sender, httpPost, SignupComplete);
end;

procedure TMainForm.SignupComplete(Sender: TObject);
begin
  if not Assigned(Sender) then
    Exit;
  if TIVCmdThread(Sender).LastCommandWasErroneous then
    ShowMessage('Singup failed, try another username or email address!')
  else
    begin
      PresentLoginFrame(False, True);
      ShowMessage('Signup Success! Login using your freshly registered credentials.');
    end;
end;

procedure TMainForm.SwFreeCostSwitch(Sender: TObject);
begin
  LbiPrice.Visible := not SwFreeCost.IsChecked;
end;

procedure TMainForm.Image11Click(Sender: TObject);
begin
  LayBlackout.Visible := not LayBlackout.Visible;
  BtnRentYourStuff.Visible := not LayBlackout.Visible;
  WidthAnimation.Inverse := not BtnRentYourStuff.Visible;
  WidthAnimation.Stop;
  WidthAnimation.Start;
end;

procedure TMainForm.Image4Click(Sender: TObject);
var
  I: Integer;
  Img: TImage;
  MP: TMultipartFormData;
  FieldName, Filename: String;
  Str: TmemoryStream;
  ItemInfo: TItemInfo;
  UserInfo: TUserInfo;
begin
  RectEditItem.Align := TAlignLayout.None;
  FloatAnimation2.Inverse := True;
  FloatAnimation2.Start;

  ToggleAniIndicator;
  MP := TMultipartFormData.Create;
  Str := TmemoryStream.Create;
  ItemInfo := ItemInfoFrm.ItemInfo;
  ItemInfo.title := EdTitle.Text;
  ItemInfo.description := MemoDescription.Text;
  if SwFreeCost.IsChecked then
    ItemInfo.price := 0 //free
  else
    ItemInfo.price := StrToFloatDef(EdPrice.Text, -1);  //negotiable
  with MP, ItemInfo do
    begin
      AddField('id', IntToStr(id));
      AddField('price', FloatToStr(price));
      AddField('title', title);
      AddField('category', category);
      AddField('description', description);
      AddField('location', Format('%fx%f', [owner.latitude, owner.longitude]));
    end;
  SendCommand(CMD_UPDATE_ITEM, MP, ItemInfo, httpPut, OnItemUpdateComplete);
end;

procedure TMainForm.OnItemUpdateComplete(Sender: TObject);
begin
  ToggleAniIndicator(False);
  if Assigned(ItemInfoFrm) then
    begin
      ItemInfoFrm.TxtTitle.Text := ItemInfoFrm.ItemInfo.title;
      if ItemInfoFrm.ItemInfo.price = 0 then
        ItemInfoFrm.TxtPrice.Text := 'FREE'
      else
        if ItemInfoFrm.ItemInfo.price < 0 then
          ItemInfoFrm.TxtPrice.Text := 'NEGOTIABLE'
        else
          ItemInfoFrm.TxtPrice.Text := Format('CAD%.2f', [ItemInfoFrm.ItemInfo.price]);
    end;
end;

procedure TMainForm.Image6Click(Sender: TObject);
begin
  CloseBlackoutPanel;
end;

procedure TMainForm.CloseBlackoutPanel;
begin
  LayBlackout.Visible := not LayBlackout.Visible;
  BtnRentYourStuff.Visible := not LayBlackout.Visible;
end;

procedure TMainForm.InitialLogin(Sender: TFrame = nil);
begin
  if Assigned(Sender) and (Sender = LoginFrm) then
    with LoginFrm do
      begin
        CurrentUsername := EdUsernameOrEmail.Text;
        FHashedPassword := GetHashedPassword;
      end;
  CMD_TEMPLATE := API_URLS[CurrentLoginURLIndex];
  SendCommand(CMD_LOGIN, '', Sender);
end;

function TMainForm.LoadCredentials: Boolean;
var
  FileName: String;
  IniFile: TIniFile;
  List: TStringList;
begin
{$IFDEF IOS}
  FileName := System.IOUtils.TPath.Combine(TPath.GetDocumentsPath,'user.data');
{$ELSE}
  {$IF DEFINED(MSWINDOWS) or DEFINED(MACOS)}
    FileName := System.IOUtils.TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'user.data');
  {$else}
    FileName := System.IOUtils.TPath.Combine(TPath.GetHomePath,'user.data');
  {$ENDIF}
{$ENDIF}
  IniFile := TIniFile.Create(FileName);
  List := TStringList.Create;
  try
    IniFile.ReadSections(List);
    CurrentUsername := IniFile.ReadString(GLOBALS_SECTION_NAME, 'CurrentUser', '');
    FHashedPassword := IniFile.ReadString(CurrentUsername, 'Pass', '');
    NotificationsActive := IniFile.ReadBool(CurrentUsername, 'NotificationsActive', False);
    Result := FHashedPassword <> '';
  finally
    FreeAndNil(IniFile);
    FreeAndNil(List);
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  Cnt: Integer;
begin
  AppIsClosing := True;
  Cnt := 50;
  while (CurrentThreadCount > 0) and (Cnt > 0) do
    begin
      Sleep(100);
      Dec(Cnt);
    end;
  TMessageManager.DefaultManager.Unsubscribe(TOrientationChangedMessage, DoOrientationChanged);
  if Assigned(DashboardFrm) then
    DashboardFrm.ClearUserInfo;
  FreeAndNil(CookieManager);
  FreeAndNil(CategoryList);
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

procedure TMainForm.UpdateSettings;
begin
  if Assigned(SettingsFrm) and Assigned(CurrentUserInfo) then
    with SettingsFrm, CurrentUserInfo do
      begin
        FillInUserLogo(CurrentUserInfo, TxtName);
        if Assigned(PhotoID) and (PhotoID.Width > 0) then
          LbiPhotoID.ItemData.Detail := '[COMPLETED]'
        else
          LbiPhotoID.ItemData.Detail := '[NOT UPLOADED]';
        lbiName.ItemData.Detail := Format('%s %s', [first_name, last_name]);
        LbiEmail.ItemData.Detail := Format('%s', [email]);
        LbiAboutMe.ItemData.Detail := Format('info: %d chars', [Length(about_me)]);
        MemoAboutMe.Text := about_me;
        LbiPhoneNumber.ItemData.Detail := Format('%s', [phone_number]);
        if Trim(LbiPhoneNumber.ItemData.Detail) = '' then
          LbiPhoneNumber.ItemData.Detail := '[NO PHONE #]';


        MapView1.Location := TMapCoordinate.Create(latitude, longitude);
        if MapView1.Location.Longitude + MapView1.Location.Latitude = 0 then
          LbiLocation.ItemData.Detail := '[NO LOCATION]'
        else
          LbiLocation.ItemData.Detail := Format('%.2fx%.2f/%.0f', [latitude, longitude, approximate_location]);

        SwNotifMessages.IsChecked := notif_messages;
        SwNotifListUpdates.IsChecked := notif_updates;
        SwNotifActivity.IsChecked := notif_activity;

        TxtSmallUsernameFirstCap.Text := UpperCase(username[1]);
        TxtScoreSmall.Text := Format('%d', [TUserInfoHelper.GetScore<TUserInfo>(CurrentUserInfo)]);
        TxtName.Text := UpperCase(username[1]);
        if (email <> '') then
          LbiScoreEmail.TextSettings.Font.Style := [TFontStyle.fsBold];
        if (TUserInfoHelper.HasPhoto(CurrentUserInfo)) then
          LbiScorePhotoID.TextSettings.Font.Style := [TFontStyle.fsBold];
        if (phone_number <> '') then
          LbiScorePhoneNumber.TextSettings.Font.Style := [TFontStyle.fsBold];
        if (TUserInfoHelper.HasPhotoID(CurrentUserInfo)) then
          LbiScorePhotoID.TextSettings.Font.Style := [TFontStyle.fsBold];
        if (first_rent_complete) then
          LbiScoreFirstRentComplete.TextSettings.Font.Style := [TFontStyle.fsBold];
        if (items_posted >= 2) then
          LbiScorePost2Items.TextSettings.Font.Style := [TFontStyle.fsBold];
        lbighProfile.Text := Format('PROFILE - %s', [username]);
      end;
end;

procedure TMainForm.DoReceiveNotificationEvent(Sender: TObject; const ServiceNotification: TPushServiceNotification);
var
//  MessageText: string;
  NotificationCenter: TNotificationCenter;
  Notification: TNotification;
  Obj: TJsonObject;
  Ob1: TJSONValue;
begin
  NotificationCenter := nil;
  try
    try
      try
        Obj := ServiceNotification.DataObject;
        NotificationCenter := TNotificationCenter.Create(nil);
        Notification := NotificationCenter.CreateNotification;
        try
          Ob1 := Obj.GetValue('gcm.notification.body');
          if (Ob1 <> Nil) then
            Notification.AlertBody := Ob1.Value;

          Ob1 := Obj.GetValue('gcm.notification.title');
          if (Ob1 <> Nil) then
             Notification.Title := Ob1.Value;

          Ob1 := Obj.GetValue('badge');
          if (Ob1 <> Nil) then
             Notification.Number := StrToInt(Ob1.Value);

          Ob1 := Obj.GetValue('gcm.notification.sound');
          if (Ob1 <> Nil) then
            begin
              Notification.SoundName := Ob1.Value;
              Notification.EnableSound := Notification.SoundName <> '';
            end;
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
        if Assigned(NotificationCenter) then
          NotificationCenter.DisposeOf;
      end;
  except
    on E: Exception do
      LogMessage('2: '+E.Message);
  end;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  FService : IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.vksVisible in FService.VirtualKeyBoardState) then
      begin
        FService.HideVirtualKeyboard;
      end
    else
      begin
        // Back button pressed, keyboard not visible or not supported on this platform, lets exit the app...
        if MessageDlg('Exit Application?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbCancel], -1) = mrOK then
          begin
{$IFDEF MSWindows}
            Application.Terminate;
{$ELSE}
  {$IFDEF Android}
            SharedActivity.Finish;
  {$endif}
{$ENDIF}
          end
        else
          begin
            // They changed their mind, so ignore the Back button press...
            Key := 0;
          end;
      end;

    if (tcMain.ActiveTab.Index = 0)  then
      begin
        Key := 0;
      end;
  end;
end;

procedure TMainForm.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if Assigned(SettingsFrm) and SettingsFrm.Visible then
    SettingsFrm.TcSettings.Height := Height - SettingsFrm.LayHeader.Height;
end;

procedure TMainForm.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if Assigned(SettingsFrm) and SettingsFrm.Visible then
    SettingsFrm.TcSettings.Height := Height - SettingsFrm.LayHeader.Height - Bounds.Height;
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
  if LBTabs.ItemIndex >= 0 then
    tcMain.ActiveTab := tcMain.Tabs[Math.Max(0, Integer(LBTabs.ListItems[LBTabs.ItemIndex].Tag))];
  MultiView1.HideMaster;
end;

procedure TMainForm.LbiCategoryClick(Sender: TObject);
begin
  if not Assigned(SelectCategoryFrm) then
    SelectCategoryFrm := TSelectCategoryFrm.Create(MainForm);
  SelectCategoryFrm.OnCategorySelect := OnCategorySelect;
  SelectCategoryFrm.Parent := Self;
  SelectCategoryFrm.Visible := True;
end;

procedure TMainForm.OnCategorySelect(Sender: TObject);
begin
  LbiCategory.ItemData.Detail := GetSelectedCategory(Sender);
  SelectCategoryFrm.Visible := False;
end;

procedure TMainForm.LoginSuccess(UserInfo: TUserInfo);
var
  I: Integer;
begin
  CurrentUsername := UserInfo.username;
  SaveCredentials;
  PresentLoginFrame(True);
  FreeAndNil(LoginFrm);
  tcMain.ActiveTab := DashboardTab;
  if LBTabs.Items.Count = 0 then
    begin
      for I := 0 to tcMain.TabCount - 1 do
        if Boolean(tcMain.Tabs[I].Tag) then   //ignore tagged tabs - beta version
          begin
            LBTabs.Items.Add(tcMain.Tabs[I].Text);
            LBTabs.ListItems[LBTabs.Items.Count - 1].Tag := I;
          end
        else
          tcMain.Tabs[I].Visible := False;
    end;
  tcMain.Visible := True;
  tcMainChange(nil);
  Background.Visible := False;
  Self.Fill.Color := $FFFFFFFF;
  if (UserInfo.picture <> '') then
    SendCommand(CMD_PIC, 'picture', UserInfo, httpGet, onUserPicDownloaded);
  if (UserInfo.id_picture <> '') then
    SendCommand(CMD_PIC, 'id_picture', UserInfo, httpGet, onUserIDPicDownloaded);
  GetAllItems;
end;

procedure TMainForm.onUserPicDownloaded(Sender: TObject);
var
  IVCmdThread: TIVCmdThread;
begin
  if not Assigned(Sender) then
    Exit;
  IVCmdThread := TIVCmdThread(Sender);
  with IVCmdThread do
    if Assigned(IVCmdThread.Sender) and (IVCmdThread.Sender is TUserInfo) then
      with TUserInfo(IVCmdThread.Sender) do
        begin
          if not Assigned(Photo) then
            Photo := FMX.Graphics.TBitmap.Create;
          try
            Photo.LoadFromStream(ResponseStream);
          except

          end;
        end;
end;

procedure TMainForm.onUserIDPicDownloaded(Sender: TObject);
var
  IVCmdThread: TIVCmdThread;
begin
  if not Assigned(Sender) then
    Exit;
  IVCmdThread := TIVCmdThread(Sender);
  with IVCmdThread do
    if Assigned(IVCmdThread.Sender) and (IVCmdThread.Sender is TUserInfo) then
      with TUserInfo(IVCmdThread.Sender) do
        begin
          if not Assigned(PhotoID) then
            PhotoID := FMX.Graphics.TBitmap.Create;
          try
            PhotoID.LoadFromStream(ResponseStream);
          except

          end;
        end;
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

procedure TMainForm.OrientationSensor1StateChanged(Sender: TObject);
begin
 if Assigned(DashboardFrm) then
   DashboardFrm.RecalculateScroller
 else
 if Assigned(MyAccountFrm) then
   MyAccountFrm.RecalculateScroller;
end;

function TMainForm.GetSelectedItemCategory: String;
begin
  Result := NewItemCategory;
end;

procedure TMainForm.OpenCamera(Sender: TObject = nil; Catergory: String = ''; Dest: TCamDestination = cdItemPic);
begin
  NewItemCategory := Catergory;
  if not Assigned(CameraFrm) then
    CreateCameraForm;
  if Assigned(Sender) and (Sender is TFrame) then
    TFrame(Sender).Visible := False;
  CameraFrm.HorzScrollBox1.Content.Controls.Clear;
  CamDestination := Dest;
  if tcMain.ActiveTab <> CameraTab then //nesting
    begin
      tcMain.Tag := 1;
      tcMain.ActiveTab := CameraTab;
      tcMain.Tag := 0;
    end;

  if (CamDestination = cdItemPic) then
    CameraFrm.Tag := MAX_HIGH_PHOTO_COUNT + 1
  else
    CameraFrm.Tag := 1;
end;

procedure TMainForm.OpenItemDetail(Sender: TObject);
begin
//
end;

procedure TMainForm.OpenMyAccount(Sender: TObject);
begin
  TFrame(Sender).Visible := False;
  tcMain.ActiveTab := MyAccountTab;
end;

procedure TMainForm.AssignBmpIndexToImg(var Bmp: FMX.Graphics.TBitmap; ImageIndex: Integer; ImageList: TImageList);
var
  Size: TSize;
begin
  Size.Width := 128;
  Size.Height := 128;
  Bmp.Assign(ImageList.Bitmap(Size, ImageIndex));
end;

procedure TMainForm.UpdateMyAccountInfo;
var
  UserScore: Integer;
  ASize: TSizeF;
begin
   if Assigned(MyAccountFrm) and Assigned(CurrentUserInfo) then
     with MyAccountFrm, CurrentUserInfo do
       begin
         UserScore := TUserInfoHelper.GetScore<TUserInfo>(CurrentUserInfo);
         TxtMoreAboutMe.Text := about_me;
         TxtCAUsername.Text := TUserInfoHelper.GetFullName<TUserInfo>(CurrentUserInfo);;
         TxtUsernameTop.Text :=  TxtCAUsername.Text;
         TxtTrackPosValue.Text := IntToStr(UserScore);
         RectTrackPos.Width := (UserScore/100) * RectTrack.Width;
         RectTrackIndicator.Position.X := RectTrackPos.Width;
         ImgSmallBadge.Visible := UserScore >= 100;
         ImgBigBadge.Visible := UserScore >= 100;
         TxtScore.Text := Format('%d pts',[UserScore]);
         TxtFirstLetter.Text := UpperCase(username[1]);

         ImgSmallBadge.Bitmap.Assign(DataModule1.SESpecificImages.Bitmap(ASize, 30 + 5 * Integer(UserScore < 100)));  //#30 or #35
         LayEnableNotif.Visible := not NotificationsActive;
       end;
end;

procedure TMainForm.CreateCameraForm;
begin
  if not Assigned(CameraFrm) then
    begin
      CameraFrm := TCameraFrm.Create(Self);
      CameraFrm.DoCreate;
    end;
end;

procedure TMainForm.tcMainChange(Sender: TObject);
var
  ActiveFrame: TFrame;
  I: Integer;
begin
  //TxtMainHeader.Text := Format('%s %s', [APP_NAME, tcMain.ActiveTab.Text]);
  if (Assigned(LoginFrm) and not Boolean(LoginFrm.Tag)) then //do not create any form until login succeeds
    Exit;

  ActiveFrame := nil;
  tcMain.TabPosition := TTabPosition.Bottom;
  if not Assigned(LocalForms[tcMain.TabIndex]) then
    begin
      case tcMain.TabIndex of
        0:
          begin
            DashboardFrm := TDashboardFrm.Create(Self);
            DashboardFrm.LayEnableNotif.Visible := not NotificationsActive;
            CategoryList := TStringList.Create;
            for I := 0 to DashboardFrm.CategoryHorizScroll.Content.Controls.Count - 1 do
              CategoryList.Add(TText(DashboardFrm.CategoryHorizScroll.Content.Controls[I].Children[1]).Text);
            with DashboardFrm do
              begin
                Align := TAlignLayout.Client;
                if Assigned(OnResize) then
                  OnResize(nil);
                LayEnableNotif.Visible := not NotificationsActive;
                FilterOptions.Visible := False;

                //GenerateItems(ItemsVerticalScroller);
              end;
            ActiveFrame := DashboardFrm;
            Self.LayBtnRentYourStuff.BringToFront;
            Self.LayBtnRentYourStuff.Margins.Bottom := 5 + tcMain.TabHeight;
            LayBtnRentYourStuff.Visible := True;
          end;
        1: begin
             NotificationsFrm := TNotificationsFrm.Create(Self);
             ActiveFrame := NotificationsFrm;
           end;
        2: begin
             CreateCameraForm;
             with CameraFrm do
               begin
                 Visible := False;
                 CameraFrm.Tag := MAX_HIGH_PHOTO_COUNT;
                 TxtItemPhotoList.Text := Format('%s - max %d allowed', [TxtItemPhotoList.Text, MAX_HIGH_PHOTO_COUNT + 1]);
                 ActiveFrame := CameraFrm;
               end;
           end;
        3: begin
             ChatFrm := TChatFrm.Create(Self);
             SendCommand(CMD_CHAT, '', nil, httpGet, OnChatHistoryReceived);
             ActiveFrame := ChatFrm;
           end;
        4: begin
             MyAccountFrm := TMyAccountFrm.Create(Self);
             UpdateMyAccountInfo;
             with MyAccountFrm do
               begin
               {
                 GenerateItems(RentingScroller);
                 GenerateItems(RentedScroller);
                 GenerateItems(FavoritesScroller);
               }
               end;
             FillInUserLogo(CurrentUserInfo, MyAccountFrm.TxtFirstLetter);

             LayBtnRentYourStuff.Visible := False;
             LayBtnRentYourStuff.BringToFront;
             ActiveFrame := MyAccountFrm;
           end;
        5: begin
             ChatDetailFrm := TChatDetailFrm.Create(Self);
             ActiveFrame := ChatDetailFrm;
           end;
      end;
      if Assigned(ActiveFrame) then
        begin
          ActiveFrame.Parent := tcMain.ActiveTab;
          ActiveFrame.Align := TAlignLayout.Client;
          LocalForms[tcMain.TabIndex] := ActiveFrame;
        end;
    end;

    //Reinitializing when reopened
    case tcMain.TabIndex of
      2: //camera
        begin
          tcMain.TabPosition := TTabPosition.None;
          CameraFrm.Visible := False;
          LbPhotoCaptureSource.Visible := True;
        end;
      else
        begin
          LocalForms[tcMain.TabIndex].Visible := True;
          LocalForms[tcMain.TabIndex].Enabled := True;
        end;
    end;
  if (tcMain.ActiveTab = CameraTab) and not Boolean(tcMain.Tag) then
    OpenCamera(nil, NewItemCategory);

  LayBtnRentYourStuff.Visible := tcMain.TabIndex in [DashboardTab.Index, MyAccountTab.Index];
  if LayBtnRentYourStuff.Visible then
    begin
      FloatAnimRentYourStuff.Stop;
      FloatAnimRentYourStuff.Start;
      //WidthAnimation.Inverse := not BtnRentYourStuff.Visible;
      WidthAnimation.Stop;
      WidthAnimation.Start;
    end;
  LastTab := tcMain.ActiveTab;

end;

procedure TMainForm.TxtCloseNotifClick(Sender: TObject);
begin
  TimerNotif.Enabled := False;
  RectTopNotifWnd.Align := TAlignLayout.None;
  FloatAnimation1.Inverse := True;
  FloatAnimation1.Start;
end;

procedure TMainForm.Text27Click(Sender: TObject);
begin
  NewItemCategory := TText(Sender).Text;
  CloseBlackoutPanel;
  AddNewItemViaPhoto;
end;

procedure TMainForm.AddNewItemViaPhoto;
begin
  if tcMain.ActiveTab = CameraTab then
    begin
      NewItemCategory := '';
      tcMainChange(Self);
    end
  else
    OpenCamera(nil, NewItemCategory);
end;

procedure TMainForm.Text46Click(Sender: TObject);
begin
  Image4Click(Sender);
end;

procedure TMainForm.Text4Click(Sender: TObject);
begin
  TMisc.Open(Format('mailto:?subject=%s&body=%s', [EMAIL_SUBJECT, EMAIL_BODY]));
end;

procedure TMainForm.TxtBtnNoEnableNotifClick(Sender: TObject);
begin
  LayEnableNotification.Visible := False;
  NotificationsActive := Sender = TxtBtnEnableNotif;
  if Assigned(DashboardFrm) then
    DashboardFrm.LayEnableNotif.Visible := not NotificationsActive;
  if Assigned(MyAccountFrm) then
    MyAccountFrm.LayEnableNotif.Visible := not NotificationsActive;
end;

procedure TMainForm.TxtTakePhotoFromGalleryClick(Sender: TObject);
begin
  if not Assigned(CameraFrm) then
    CreateCameraForm;
  PhotoSelectorFloatAnimator.Inverse := True;
  PhotoSelectorFloatAnimator.Start;
  CameraFrm.DoInitialize;
  case TText(Sender).Tag of
    0: tcMain.ActiveTab := DashboardTab;
    1: begin
         CameraFrm.TabControl1.ActiveTab := CameraFrm.GalleryTab;
         CameraFrm.BtnSelectPhoto.Action.Execute;
       end;
    2: CameraFrm.TakePhotoFromCameraAction1.Execute;
  end;
  CameraFrm.Visible := Boolean(Integer(TText(Sender).Tag));
end;

procedure TMainForm.UpdateProfile(ParamData: String; Callback: TNotifyEvent = nil);
var
  Notif: TNotifyEvent;
begin
  if Assigned(SettingsFrm) and not UpdatingProfileData then
    with SettingsFrm do
      begin
        if Assigned(Callback) then
          Notif := Callback
        else
          Notif := UpdateProfileCallback;
        SendCommand(CMD_UPDATE_PROFILE, ParamData, SettingsFrm, httpPost, Notif);
      end;
end;

procedure TMainForm.UpdateProfileCallback(Sender: TObject);
begin
  if not Assigned(Sender) then
    Exit;
  CurrentUserInfo := TIVCmdThread(Sender).CurrentUserInfo;
  ShowSettings(Sender);
  UpdateMyAccountInfo;
end;

procedure TMainForm.PasswordUpdatedCallback(Sender: TObject);
begin
  UpdateProfileCallback(Sender);
  if Assigned(SettingsFrm) then
    begin
      SettingsFrm.LbiPass.ItemData.Detail := '[password updated]';
      FHashedPassword := GetMd5HashString(SettingsFrm.EdNewPass.Text);
      SaveCredentials;
    end;
end;


procedure TMainForm.PhotoSelectorFloatAnimatorFinish(Sender: TObject);
begin
  if PhotoSelectorFloatAnimator.Inverse then
    LbPhotoCaptureSource.Visible := False;
  PhotoSelectorFloatAnimator.Inverse := False;
end;

procedure TMainForm.WaitEnd(Frame: TFrame);
begin
  Frame.Enabled := False;
end;

function TMainForm.AddNewItem(Sender: TGridPanelLayout; var ItemInfoOrig: TItemInfo): TRectangle;
var
  LayLeftItemList: TLayout;
  LayRightItemList: TLayout;

  LastUsedItemList: TLayout;
  LastYLeft, LastYRight: Single;

  ItemInfo: TItemInfo;
begin
  Result := TRectangle.Create(Self);
  LastUsedItemList := TLayout(Sender.Controls[Sender.Tag]);
  LayLeftItemList := TLayout(Sender.Controls[0]);
  LayRightItemList := TLayout(Sender.Controls[1]);
  LastYLeft := LayLeftItemList.Tag;
  LastYRight := LayRightItemList.Tag;

  ItemInfo := CloneItemInfo(ItemInfoOrig);

  ItemInfo.Parent := Result;
  with Result do
    begin
      Align := TAlignLayout.Top;
      Result.Touch.GestureManager := GestureManager1;
      Result.TagObject := ItemInfo;
      Result.OnClick := MainForm.MoreInfo;
      if Assigned(ItemInfo.Photos[0]) and (ItemInfo.Photos[0].Width > 0) then
        begin
          Fill.Bitmap.Bitmap.Assign(ItemInfo.Photos[0]);
          Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
          Fill.Kind := TBrushKind.Bitmap;
          Result.Height := Round(LayLeftItemList.Width * (Fill.Bitmap.Bitmap.Height/Fill.Bitmap.Bitmap.Width));
        end
      else
        begin
          // Generate pastel colors
          Fill.Color := Integer($FF000000) + (205 - Random(20)) shl 16 + (190 - Random(40)) shl 8 + 200 - Random(40);
          //Rect.Height := MIN_PIC_HEIGHT; //at lest display the slot till the pic gets loaded.
          Result.Height := Round(LayLeftItemList.Width * (ItemInfo.first_pic_height/ItemInfo.first_pic_width));
        end;


      Align := TAlignLayout.Top;
      if LastUsedItemList = LayLeftItemList then
        begin
          if LastYLeft + Result.Height < LastYRight  then
            Parent := LayLeftItemList
          else
            Parent := LayRightItemList;
        end
      else
        begin
          if LastYRight + Result.Height < LastYLeft  then
            Parent := LayRightItemList
          else
            Parent := LayLeftItemList;
        end;
      LastUsedItemList := TLayout(Parent);
      XRadius := 10;
      YRadius := 10;
      Margins.Bottom := 10;
      if LastUsedItemList = LayLeftItemList then
        begin
          Result.Position.Y := LastYLeft;
          Align := TAlignLayout.Top;
          LastYLeft := LastYLeft + Result.Height + Margins.Bottom;
        end
      else
        begin
          Result.Position.Y := LastYRight;
          Align := TAlignLayout.Top;
          LastYRight := LastYRight + Result.Height + Margins.Bottom;
        end;
    end;
  Sender.Tag := Integer(LastUsedItemList = LayRightItemList);
  LayLeftItemList.Tag := Round(LastYLeft);
  LayRightItemList.Tag := Round(LastYRight);
  DashboardFrm.ItemsVerticalScroller.Height := Max(LayLeftItemList.Tag, LayRightItemList.Tag);
  if Result.TagObject = nil then
    Result.Tag := Integer(ItemInfo);
end;


procedure TMainForm.GenerateItems(VScroller: TGridPanelLayout);
var
  I, J, K, ImgIndex: Integer;
  ItemInfo: TItemInfo;
  Size: TSize;
begin
  for I := 0 to 30 do
    begin
      ItemInfo := TItemInfo.Create;
      ItemInfo.title := Format('New item #%d', [I]);
      ItemInfo.owner := TUserInfo.Create;
      ItemInfo.owner.username := Format('USERNAME_%d', [I]);
      ItemInfo.price := Random(I*I);
      ItemInfo.PhotoCount := 1 + Random(MAX_HIGH_PHOTO_COUNT);
      ItemInfo.category := CategoryList[Random(CategoryList.Count)];
      for J := 0 to MAX_HIGH_PHOTO_COUNT do
        if J < ItemInfo.PhotoCount then
          begin
            ItemInfo.Photos[J] := FMX.Graphics.TBitmap.Create;
            ImgIndex := Random(DataModule1.ImgListDEMO_DELETE.Count);
            if not DataModule1.ImgListDEMO_DELETE.BestSize(ImgIndex, Size) then
              begin
                Size.Width := 300;
                Size.Height := 300;
              end;
            ItemInfo.Photos[J].Assign(DataModule1.ImgListDEMO_DELETE.Bitmap(Size, ImgIndex));
          end
        else
          ItemInfo.Photos[j] := nil;
      with AddNewItem(VScroller, ItemInfo) do ;
    end;
  VScroller.Height := Max(VScroller.Children[0].Tag, VScroller.Children[1].Tag) + 20;
end;

procedure TMainForm.WaitStart(Frame: TFrame);
begin
  Frame.Enabled := True;
end;

procedure TMainForm.SendMessageTo(UserID, ItemID: Integer; ChatMessage: String);
begin
  SendCommand(CMD_CHAT, Format('dest_id=%d&itemid=%d&message=%s', [
    UserID, ItemID, TURI.URLEncode(ChatMessage)]), nil, httpPost);
end;

procedure TMainForm.FillInUserLogo(UserInfo: TUserInfo; TxtInitial: TText);
begin
  if not Assigned(UserInfo) then
    Exit;
  if Assigned(UserInfo.Photo) and (UserInfo.Photo.Width > 0) then
    begin
      if TxtInitial.Parent is TCircle then
        with TCircle(TxtInitial.Parent).Fill do
          begin
            Kind := TBrushKind.Bitmap;
            Bitmap.WrapMode := TWrapMode.TileStretch;
            Bitmap.Bitmap.Assign(UserInfo.Photo);
            TxtInitial.Visible := False;
          end
      else
        Exit; //should never ever happen
    end
  else
    begin
      TxtInitial.Text := UpperCase(UserInfo.username[1]);
      TxtInitial.Visible := True;
      if TxtInitial.Parent is TCircle then
        with TCircle(TxtInitial.Parent).Fill do
          begin
            Kind := TBrushKind.Solid;
            Bitmap.Bitmap.Clear(COLOR_DEFAULT_USER_PHOTO);
          end
      else
        Exit; //should never ever happen
    end;
end;

procedure TMainForm.AddChat(ChatInfo: TChatInfo; MessageFlags: TChatMessageTypes);
var
  ChatItemFrm: TChatItemFrm;
begin
  TxtNoChat.Visible := False;
  if Assigned(ChatFrm) then
    begin
      ChatItemFrm := TChatItemFrm.Create(Self);
      ChatItemFrm.TagObject := ChatInfo;
      with ChatItemFrm, ChatInfo.ItemInfo do
        begin
          Name := Format('ChatItemFrm_%d', [ChatFrm.ChatScrollBox.Content.ChildrenCount]);
          ChatItemFrm.Align := TAlignLayout.MostTop;
          TxtMessage.Text := ChatInfo.message;
          TxtOwnerName.Text := ifthen(owner.first_name <> '',
            Format('%s %s', [owner.first_name, owner.last_name]),
            owner.username
          );
          TxtItemAge.Text := CalcAgeHumanReadable(post_date, False);
          TxtItemName.Text := title;
          with RectItemPic.Fill do
            begin
              Bitmap.WrapMode := TWrapMode.TileStretch;
              Bitmap.Bitmap.Assign(Photos[0]);  //assign first pic
              Fill.Kind := TBrushKind.Bitmap;
            end;
          FillInUserLogo(owner, TxtOwnerInital);
          GSentReceived.ImageIndex := 46 + Integer(cmtReceived in MessageFlags);
          if cmtReplied in MessageFlags then
            GReadReplied.ImageIndex := 49;
          if cmtRead in MessageFlags then
            GReadReplied.ImageIndex := 48;
          ChatItemFrm.Parent := ChatFrm.ChatScrollBox;
        end;
    end;
end;

procedure TMainForm.SaveCredentials;
var
  FileName: String;
  IniFile: TIniFile;
begin
{$IFDEF IOS}
  FileName := System.IOUtils.TPath.Combine(TPath.GetDocumentsPath,'user.data');
{$ELSE}
  {$IF DEFINED(MSWINDOWS) or DEFINED(MACOS)}
    FileName := System.IOUtils.TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'user.data');
  {$else}
    FileName := System.IOUtils.TPath.Combine(TPath.GetHomePath,'user.data');
  {$ENDIF}
{$ENDIF}
  IniFile := TIniFile.Create(FileName);
  with LoginFrm do
    try
      IniFile.WriteString(GLOBALS_SECTION_NAME, 'CurrentUser', CurrentUsername);
//      if CbStoreCredentials.IsChecked then
//        begin
      IniFile.WriteString(CurrentUsername, 'Pass', HashedPassword);
      IniFile.WriteBool(CurrentUsername, 'StoreCredentials', True);
      IniFile.WriteBool(CurrentUsername, 'NotificationsActive', NotificationsActive);
//
//        end;
    finally
      FreeAndNil(IniFile);
    end;

end;

procedure TMainForm.Rectangle1Click(Sender: TObject);
begin
  LayInviteFriends.Visible := False;
end;

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

procedure TMainForm.sbSettingsClick(Sender: TObject);
begin
  tcMain.ActiveTab := SettingsTab;
end;

procedure TMainForm.Logout;
var
  IniFile: TIniFile;
  FileName: String;
begin
{$IFDEF IOS}
  FileName := System.IOUtils.TPath.Combine(TPath.GetDocumentsPath,'user.data');
{$ELSE}
  {$IF DEFINED(MSWINDOWS) or DEFINED(MACOS)}
    FileName := System.IOUtils.TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'user.data');
  {$else}
    FileName := System.IOUtils.TPath.Combine(TPath.GetHomePath,'user.data');
  {$ENDIF}
{$ENDIF}
  CurrentUserInfo.username := '';
  IniFile := TIniFile.Create(FileName);
  MainMenu.Visible := False;
  SendCommand(CMD_LOGOUT);
  tcMain.Visible := False;
  if not Assigned(LoginFrm) then
    CreateLoginFrame
  else
    with LoginFrm do
      begin
        //CbStoreCredentials.IsChecked := False;
        edPassword.Text := '';
      end;
  IniFile.DeleteKey(CurrentUsername, 'Pass');
  FreeAndNil(IniFile);
  if Assigned(SettingsFrm) then
    SettingsFrm.Visible := False;
  PresentLoginFrame(False, True);
  FreeAndNil(SettingsFrm);
  Self.Fill.Color := $FF000000;
end;

var
  PrevMoreInfoBgColor: TAlphaColor;

procedure TMainForm.EditItem(ItemInfo: TItemInfo);
var
  Size: TSize;
  I: Integer;
  Rect: TRectangle;
begin
{
  RecItemEditFrm := TItemEditFrm.Create(Self);
  with ItemEditFrm do
    begin
      Height := Self.Height;
      FloatAnimation1.Parent := ItemEditFrm;
      ItemEditFrm.Position.Y := -Self.Height;
      FloatAnimation1.StartValue := -Self.Height;
      FloatAnimation1.StopValue := 0;
      Parent := Self;
      ShowModal;
      FloatAnimation1.Inverse := True;
      FloatAnimation1.Start;
    end;
}
  LbiPrice.Visible := not SwFreeCost.IsChecked;
  RectEditItem.BringToFront;
  RectEditItem.Height := Self.ClientHeight;
  RectEditItem.Width := Self.ClientWidth;
  Size.Width := 32;
  Size.Height := 32;
  RectEditItem.Position.X := 0;
  Image4.Bitmap.Assign(DataModule1.SESpecificImages.Bitmap(Size, 45));
  FloatAnimation2.Inverse := False;
  FloatAnimation2.StartValue := -Self.Height;
  FloatAnimation2.StopValue := 0;
  RectEditItem.Visible := True;
  with ItemInfo do
    begin
      EdTitle.Text := title;
      SwFreeCost.IsChecked := price = 0;
      EdPrice.Text := ifthen(price < 0, '', FloatToStr(price));
      MemoDescription.Text := description;
      LbiCategory.ItemData.Detail := category;
    end;

  for I := PhotoScrollBox.Content.Controls.Count - 1 downto 0 do
    PhotoScrollBox.Content.Controls[I].Free;
  for I := 0 to MAX_HIGH_PHOTO_COUNT do
    begin
      Rect := TRectangle.Create(Self);
      with Rect do
        begin
          Parent := PhotoScrollBox;
          Align := TAlignLayout.Left;
          Position.X := 1000;
          Margins.Left := 0;
          Margins.Right := 5;
          Margins.Top := 5;
          Margins.Bottom := 5;
          XRadius := 5;
          YRadius := 5;
          Stroke.Thickness := 0;
          if Assigned(ItemInfo.Photos[I]) then
            begin
              Fill.Bitmap.Bitmap.Assign(ItemInfo.Photos[I]);
              Fill.Kind := TBrushKind.Bitmap;
              Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
            end
          else
            begin
              Fill.Kind := TBrushKind.Solid;
              Fill.Color := $FFD6D6D6;
            end;
        end;
    end;

end;

procedure TMainForm.MemoDescriptionChangeTracking(Sender: TObject);
begin
  TxtRemainingDescriptionCharCount.Text := Format('%d', [1500-Length(MemoDescription.Text)]);
end;

procedure TMainForm.MoreInfo(Sender: TObject);
var
  AItemInfo: TItemInfo;
  I: Integer;
  BmpWrapper: TBmpWrapper;
begin
  if Assigned(Sender) then
    AItemInfo := TItemInfo(TRectangle(Sender).TagObject);
  if not Assigned(Sender) or not Assigned(AItemInfo) then
    begin
      ShowMessage('Missing item info...');
      Exit;
    end;
  PrevMoreInfoBgColor := Fill.Color;
  Fill.Color := $FF262218;
  DashboardFrm.Visible := False;
  tcMain.Visible := False;
  if not Assigned(ItemInfoFrm) then
    begin
      ItemInfoFrm := TItemInfoFrm.Create(Self);
    end;
  with ItemInfoFrm do
    begin
      ItemInfo := AItemInfo;
      RectItemDetail.Visible := False;
      Parent := Self;
      ImgItem.Bitmap.Assign(TRectangle(Sender).Fill.Bitmap.Bitmap);
      LayTop.Parent := ItemInfoFrm;
      LayTop.Padding.Left := 0;
      LayTop.Padding.Right := 0;
      Align := TAlignLayout.Client;
      Visible := True;
      for I := 0 to Iteminfo.PhotoCount - 1 do
        if (Iteminfo.PhotoFilenames[I] <> '') and not Assigned(ItemInfo.Photos[I]) or (FMX.Graphics.TBitmap(ItemInfo.Photos[I]).Width <= 0) then
          begin
            if not Assigned(ItemInfo.Photos[I]) then
              ItemInfo.Photos[I] := FMX.Graphics.TBitmap.Create;
            BmpWrapper := TBmpWrapper.Create;
            BmpWrapper.ItemInfo := ItemInfo;
            BmpWrapper.PhotoIndex := 0;
            BmpWrapper.Src:= Format('%s%s', [BmpWrapper.ItemInfo.prefix, BmpWrapper.ItemInfo.PhotoFilenames[I]]); //download only the first image

            SendCommand(CMD_ITEM_PIC, BmpWrapper.Src, BmpWrapper, httpGet, OnPictureDownloaded);
          end;

      TrackBar1.Value := 0;
      TxtDistance.Text := Format('%.1fkm from you', [1.23]);
      RectAge.Width := TxtItemAge.Width + TxtItemAge.Position.X + RectAge.Height/2;
      if Assigned(ItemInfo) then
        begin
          TrackBar1.Visible := ItemInfo.PhotoCount > 1;
          TrackBar1.Max := ItemInfo.PhotoCount - 1;
          TxtTitle.Text := ItemInfo.title;
          if Assigned(ItemInfo.owner) then
            begin
              TxtLocation.Text := Format('%.2f x %.2f', [ItemInfo.owner.latitude, ItemInfo.owner.longitude]);
              RectEdit.Visible := ItemInfo.owner.username = CurrentUserInfo.username;
              if (ItemInfo.owner.username <> '')  then
                TxtFistLetterUsername.Text := UpperCase(ItemInfo.owner.username[1]);
            end;
          TxtViews.Text := Format('%d', [ItemInfo.views]);
          if ItemInfo.price = 0 then
            TxtPrice.Text := 'FREE'
          else
            if ItemInfo.price < 0 then
              TxtPrice.Text := 'NEGOTIABLE'
            else
              TxtPrice.Text := Format('CAD%.2f', [ItemInfo.price]);
          if ItemInfo.post_date = 0 then
            TxtItemAge.Text := 'old enough'
          else
            TxtItemAge.Text := Format('%d days', [DaysBetween(ItemInfo.post_date, Now)]);
        end
      else
        TrackBar1.Visible := False;
    end;
  LayBtnRentYourStuff.Visible := False;
end;

procedure TMainForm.CloseMoreInfo;
begin
  Fill.Color := PrevMoreInfoBgColor;
  ItemInfoFrm.Visible := False;
  DashboardFrm.Visible := True;
  LayBtnRentYourStuff.Visible := True;
  tcMain.Visible := True;
end;

procedure TMainForm.CloseNotifications;
begin
  if Assigned(NotificationsFrm) then
    NotificationsFrm.Visible := False;
  tcMain.ActiveTab := DashboardTab;
end;

procedure TMainForm.CloseChat;
begin
  if Assigned(ChatFrm) then
    ChatFrm.Visible := False;
  tcMain.ActiveTab := DashboardTab;
end;

procedure TMainForm.RoundButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Btn: TRectangle;
  Obj: TFmxObject;
begin
  if not (Sender is TRectangle) then
    begin
      Obj := TFmxObject(Sender).Parent;
      while not (Obj is TRectangle) do
        Obj := Obj.Parent;
      Btn := Obj as TRectangle;
    end
  else
    Btn := TRectangle(Sender);
  if Btn.Enabled then
    Btn.Fill.Color := $FFfc919d;
end;

procedure TMainForm.RoundButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Btn: TRectangle;
  Obj: TFmxObject;
begin
  if not (Sender is TRectangle) then
    begin
      Obj := TFmxObject(Sender).Parent;
      while not (Obj is TRectangle) do
        Obj := Obj.Parent;
      Btn := Obj as TRectangle;
    end
  else
    Btn := TRectangle(Sender);
  if Btn.Enabled then
    if Boolean(Btn.Tag) then
      Btn.Fill.Color := $FFFFFFFF
    else
      Btn.Fill.Color := $FFFF3F55;
end;


procedure TMainForm.CancelLogin;
begin
  LoginFrm.Visible := False;
  if not Assigned(StartupFrm) then
    CreateStartupFrame;
  StartupFrm.Visible := True;
  BlurEffect1.Enabled := False;
  ChangeBkPicTimerTimer(nil);
  ChangeBkPicTimer.Enabled := True;
end;

procedure TMainForm.CategoryFiltered(Sender: TObject);
begin
//
end;

procedure TMainForm.WaitEnd;
begin
  if Assigned(FrmSendingCmd) then
    WaitStart(FrmSendingCmd);
end;

procedure TMainForm.WaitStart;
begin
  if Assigned(FrmSendingCmd) then
    WaitEnd(FrmSendingCmd);
end;

procedure TMainForm.UpdateProfile(ParamData: TMultipartFormData; Callback: TNotifyEvent = nil);
begin
  if Assigned(SettingsFrm) and not UpdatingProfileData then
    with SettingsFrm do
      SendCommand(CMD_UPDATE_PROFILE, ParamData, SettingsFrm, httpPost, Callback);
end;

procedure TMainForm.UpdateProfile(ParamName, ParamValue: String; Callback: TNotifyEvent = nil);
var
  Mime: TMultipartFormData;
  Notif: TNotifyEvent;
begin
  if Assigned(SettingsFrm) and not UpdatingProfileData then
    with SettingsFrm do
      begin
        Mime := TMultipartFormData.Create();
        Mime.AddField(ParamName, ParamValue);
        if Assigned(Callback) then
          Notif := Callback
        else
          Notif := UpdateProfileCallback;
        SendCommand(CMD_UPDATE_PROFILE, Mime, SettingsFrm, httpPost, Notif);
      end;
end;

procedure TMainForm.UpdateProfile;
var
  Mime: TMultipartFormData;
begin
  if Assigned(SettingsFrm) and not UpdatingProfileData then
    with SettingsFrm do
      begin
        Mime := TMultipartFormData.Create();
        with CurrentUserInfo, Mime do
          begin
            AddField('id', IntToStr(id));
            AddField('username', username);
            AddField('password', password);
            AddField('first_name', first_name);
            AddField('last_name', last_name);
            AddField('email', email);
            AddField('level', IntToStr(level));
            AddField('about_me', about_me);
            AddField('phone_number', phone_number);
            AddField('birthday', DateTimeToStr(birthdate));
            AddField('user_status', IntToStr(user_status));
            AddField('latitude', FloatToStr(latitude));
            AddField('longitude', FloatToStr(longitude));
            AddField('approximate_location', FloatToStr(approximate_location));
            AddField('notif_messages', IntToStr(Integer(notif_messages)));
            AddField('notif_updates', IntToStr(Integer(notif_updates)));
            AddField('notif_activity', IntToStr(Integer(notif_activity)));
          end;
        SendCommand(CMD_UPDATE_PROFILE, Mime, SettingsFrm, httpPost);
      end;
end;

end.

