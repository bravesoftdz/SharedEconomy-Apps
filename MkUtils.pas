unit MkUtils;

interface

uses
  System.Net.Mime
{$IFDEF MSWINDOWS}
  , Winapi.ShellAPI, Winapi.Windows
{$ENDIF MSWINDOWS}
{$IFDEF IOS}
  , iOSapi.UIKit
  , Posix.SysSysctl
  , Posix.StdDef
  , FMX.PushNotification.IOS
{$ENDIF}
{$IFDEF POSIX}
  , Posix.Stdlib
{$ENDIF POSIX}
  , System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent
  , System.Classes, FMX.ListView.Appearances, FMX.Objects, FMX.Graphics
  , System.JSON, FMX.Forms, System.Generics.Defaults;

const
  PHP_SESSION_ID_NAME = 'PHPSESSID';
  DEFAULT_CMD_RETRIES = 3;
  SUCCESS = 'Success!';
  FAILED = 'Failed!';
  MAX_HIGH_PHOTO_COUNT = 9;

var
  CMD_TEMPLATE: String = 'http://localhost';

type
  TItemInfo = class;

  TBmpWrapper = class
    ItemInfo: TItemInfo;
    PhotoIndex: Integer;
    Src: String;
  end;

  TChatMessageType = (cmtSent, cmtReceived, cmtRead, cmtReplied);
  TChatMessageTypes = set of TChatMessageType;

  TArrHelper = class
    class procedure AppendArrays<T>(var A: TArray<T>; const B: TArray<T>);
    class function AScan<T>(const Arr: array of T; const Value: T; const Comparer: IEqualityComparer<T>): Integer; overload;
    class function AScan<T>(const Arr: array of T; const Value: T): Integer; overload;
    class function ArrayPairsToPostData<T>(const Arr: array of TNameValuePair): String;
  end;

  TPostParams = TArray<TNameValuePair>;

  TMisc = class
    class procedure Open(sCommand: string);
    class procedure SendEmail(aEmail: string; aSubject: string = ''; aBody: string = '');
  end;
  TMkHTTPMethod = (httpGet, httpHead, httpPost, httpPut, httpDelete, httpConnect, httpOptions, httpTrace, httpPatch);
  TMkWaitState = (wsNoData, wsIncomingData, wsDataComplete);

  TCmdThread = class(TThread)
  private
    FLVItem: TListViewItem;
    FCmd: String;
    LastJSONAnswer: String;
    FRepeatCommandCount: Integer;
    ErrorReason: String;
    LastHttpResponse: IHttpResponse;
    ServerProcessedCommand: Boolean;
    FPHPSessionID: String;
    FCaller: TObject;
    SStream: TStream;
    FOnDataReceived: TNotifyEvent;
    FReportErrors: Boolean;
    FIsBinaryData: Boolean;
    FPostParams: TPostParams;
    FURL: String;
    FSender: TObject;
    FCmdParams: String;
    FMethod: TMkHTTPMethod;
    FAPIUrl: String;
    FWaitingForData: TMkWaitState;
    FMultipartFormData: TMultipartFormData;
    FOnProcessComplete: TNotifyEvent;
    FLastCommandWasErroneous: Boolean;

    procedure SetLVItem(const Value: TListViewItem) ;
    procedure SetCmd(const Value: String);

    procedure ProcessAnswer; dynamic;
    procedure ProcessError; dynamic;

    procedure NetHTTPClient1ValidateServerCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);
    procedure SetCaller(const Value: TObject);
    function GetResponseStream: TMemoryStream;
    function GetResponseStringData: String;
    procedure FireProcessComplete;
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean) ;
    destructor Destroy; override;
    property LVItem: TListViewItem read FLVItem write SetLVItem;
    property Cmd: String read FCmd write SetCmd;
    property CmdParams: String read FCmdParams write FCmdParams;
///    property Params: String read FParams write SetParams;
    property Caller: TObject read FCaller write SetCaller;
    property ResponseStream: TMemoryStream read GetResponseStream;
    property ResponseStringData: String read GetResponseStringData;
    property ReportErrors: Boolean read FReportErrors write FReportErrors;
    property RepeatCommandCount: Integer read FRepeatCommandCount write FRepeatCommandCount;
    property IsBinaryData: Boolean read FIsBinaryData write FIsBinaryData;
    property PostParams: TPostParams read FPostParams write FPostParams;
    property Sender: TObject read FSender write FSender;
    property PHPSessionID: String read FPHPSessionID write FPHPSessionID;
    property HTTPMethod: TMkHTTPMethod read FMethod write FMethod;
    property APIUrl: String read FAPIUrl write FAPIUrl;
    property MultipartFormData: TMultipartFormData read FMultipartFormData write FMultipartFormData;
    property OnProcessComplete: TNotifyEvent read FOnProcessComplete write FOnProcessComplete;
    property LastCommandWasErroneous: Boolean read FLastCommandWasErroneous;

    property OnDataReceived: TNotifyEvent read FOnDataReceived write FOnDataReceived;
  end;

  // ** Standard IV User Info

  TUserInfo = class
    id: Integer;
    username: String;
    password: String;
    first_name: String;
    last_name: String;
    email: String;
    level: Integer;
    pass: String;
    about_me: String;
    phone_number: String;
    birthdate: TDateTime;
    user_status: Integer;
    login_session_datetime: TDateTime;
    comments: String;
    latitude: single;
    longitude: single;
    approximate_location: single;
    notif_messages: Boolean;
    notif_updates: Boolean;
    notif_activity: Boolean;
    picture: String;
    id_picture: String;

    first_rent_complete: Boolean;
    items_posted: Integer;
    items_rented: Integer;

    Photo: TBitmap;
    PhotoID: TBitmap;
  end;

  TItemInfo = class
    id: Integer;
    title: String;
    description: String;
    owner: TUserInfo;
    views: Integer;
    price: single;
    popularity: single;
    category: String;
    category_id: Integer;
    language: String;
    post_date: TDateTime;

    prefix: String;
    first_pic_height: Integer;
    first_pic_width: Integer;

    PhotoCount: Integer;
    Photos: array[0..MAX_HIGH_PHOTO_COUNT] of FMX.Graphics.TBitmap;
    PhotoFilenames: array[0..MAX_HIGH_PHOTO_COUNT] of String;
    Parent: TObject;
  end;

  TChatInfo = class
    id: Integer;
    title: String;
    message: String;
    flags: Integer;
    date: TDateTime;

    ItemInfo: TItemInfo;
    ChatItemFrm: TObject;
  end;

  TItemInfoHelper = class
    class procedure Empty(var ItemInfo: TItemInfo; NullPhotos: Boolean);
  end;

  TUserInfoHelper = class
    class function GetScore<T>(const UserInfo: TUserInfo): Integer;
    class function GetFullName<T>(const UserInfo: TUserInfo): String;
    class function HasPhoto(const UserInfo: TUserInfo): Boolean;
    class function HasPhotoID(const UserInfo: TUserInfo): Boolean;
  end;

  TIVLoginSuccessEvent = procedure (Sender: TObject; var UserInfo: TUserInfo) of object;
  TIVLoginParams = procedure (Sender: TObject; LastLoginKey: String; var UserName, Params, URL: String) of object;
  TIVCmdError = procedure (Sender: TObject; ErrorMessage: String) of object;
  TIVChangeAPIServer = procedure(Sender: TObject; var NewServerURL: String) of object;

  TIVCmdThread = class(TCmdThread)
  private
    FOnLoginFailure: TNotifyEvent;
    FOnLoginSuccess: TIVLoginSuccessEvent;
    FOnLoginParams: TIVLoginParams;
    FLastLoginKey: String;
    UserName: String;
    LoginParams: String;  //???
    FCurrentUserInfo: TUserInfo;
    FOnError: TIVCmdError;
    FOnChangeAPIServer: TIVChangeAPIServer;

    procedure ProcessAnswer; override;
    procedure ProcessError; override;

    function ProcessUserRelatedInfo(var UserInfo: TUserInfo): Boolean;
    function ExtractUserInfo(obj: TJSONObject): TUserInfo;
    procedure ProcessLoginAnswer;
    procedure ProcessUpdateProfile;
  public
    property LoginKey: String read FLastLoginKey write FLastLoginKey;
    property OnLoginSuccess: TIVLoginSuccessEvent read FOnLoginSuccess write FOnLoginSuccess;
    property OnLoginFailure: TNotifyEvent read FOnLoginFailure write FOnLoginFailure;
    property OnLoginParams: TIVLoginParams read FOnLoginParams write FOnLoginParams;
    property OnError: TIVCmdError read FOnError write FOnError;
    property OnChangeAPIServer: TIVChangeAPIServer read FOnChangeAPIServer write FOnChangeAPIServer;
    property CurrentUserInfo: TUserInfo read FCurrentUserInfo;
  end;

  TScopedFrame = class(TFrame)
  public
    procedure DoCreate; virtual; abstract;
    procedure DoInitialize; virtual; abstract;
    procedure DoDeinitialize; virtual; abstract;
  end;

function CalcAgeHumanReadable(Date: TDateTime; DisplayAllUnits: Boolean): String;
function IsValidPhoneNumber(PhoneNumber: String): Boolean;
function IsValidEmail(Email: String): boolean;
function MemoryStreamToString(M: TMemoryStream): string;
function GetMd5HashString(Value: String): String;
function GetSelectedCategory(Sender: TObject; ImgFilter: TImage = nil): String;
{$IFDEF IOS}
  function GetDeviceModelString: String;
{$ENDIF}

implementation

uses SysUtils, TypInfo, UnescapeJSONString, FMX.DialogService.Async,
  System.UITypes, StrUtils, uMkCmd, IdGlobal, IdHash, IdHashMessageDigest,
  System.DateUtils, FMX.Types, FMX.Layouts;

function GetSelectedCategory(Sender: TObject; ImgFilter: TImage = nil): String;
var
  Img: TImage;
  Obj: TFMXObject;
  I: Integer;
  Category: String;
begin
  Img := nil;
  Category := '';
  Obj := TFMXObject(Sender);
  while not (Obj is TLayout) do
    if Obj is TImage then
      begin
        Img := TImage(Obj);
        Break;
      end
    else
      if not (Obj is TLayout) then
        Obj := Obj.Parent;
  if not Assigned(Img) and (Obj is TLayout) then
    for I := 0 to Obj.ChildrenCount - 1 do
      if Obj.Children[I] is TImage  then
        begin
          Img := TImage(Obj);
          Break;
        end;
  if Assigned(Img) then
    begin
      if Assigned(ImgFilter) then
        ImgFilter.Bitmap.Assign(Img.Bitmap);
      Obj := Img.Parent.Parent;
      for I := 0 to Obj.ChildrenCount - 1 do
        if Obj.Children[I] is TText then
          begin
            Category := TText(Obj.Children[I]).Text;
            Break;
          end;
    end;
  Result := Category;
end;

function GetMd5HashString(value: string): string;
var
  hashMessageDigest5: TIdHashMessageDigest5;
begin
  hashMessageDigest5 := nil;
  try
    hashMessageDigest5 := TIdHashMessageDigest5.Create;
    Result := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(value));
  finally
    hashMessageDigest5.Free;
  end;
end;

class function TArrHelper.ArrayPairsToPostData<T>(const Arr: array of TNameValuePair): String;
var
  I: Integer;
begin
  for I := Low(Arr) to High(Arr) do
    Result := Format('%s%s%s=%s', [
      Result,
      ifthen(Result <> '', '&', ''),
      TNameValuePair(Arr[I]).Name,
      Arr[I].Value
    ]);
end;

class function TArrHelper.AScan<T>(const Arr: array of T; const Value: T): Integer;
begin
  Result := AScan<T>(Arr, Value, TEqualityComparer<T>.Default);
end;

class function TArrHelper.AScan<T>(const Arr: array of T; const Value: T;
  const Comparer: IEqualityComparer<T>): Integer;
var
  i: Integer;
begin
  for i := Low(Arr) to High(Arr) do
    if Comparer.Equals(Arr[i], Value) then
      Exit(i);
  Exit(-1);
end;

class procedure TArrHelper.AppendArrays<T>(var A: TArray<T>;
  const B: TArray<T>);
var
  i, L: Integer;
begin
  L := Length(A);
  SetLength(A, L + Length(B));
  for i := 0 to High(B) do
    A[L + i] := B[i];
end;

{$IFDEF IOS}
function GetDeviceModelString: String;
var
  Size: size_t;
  DeviceModelBuffer: array of Byte;
begin
  sysctlbyname('hw.machine', nil, @Size, nil, 0);

  if Size > 0 then
  begin
    SetLength(DeviceModelBuffer, Size);
    sysctlbyname('hw.machine', @DeviceModelBuffer[0], @Size, nil, 0);
    Result := UTF8ToString(MarshaledAString(DeviceModelBuffer));
    if (Result = 'iPhone1,1')    then Result := 'iPhone 1G'
    else
    if (Result = 'iPhone1,2')    then Result := 'iPhone 3G'
    else
    if (Result = 'iPhone2,1')    then Result := 'iPhone 3GS'
    else
    if (Result = 'iPhone3,1')    then Result := 'iPhone 4'
    else
    if (Result = 'iPhone3,3')    then Result := 'Verizon iPhone 4'
    else
    if (Result = 'iPhone4,1')    then Result := 'iPhone 4S'
    else
    if (Result = 'iPhone5,1')    then Result := 'iPhone 5 (GSM)'
    else
    if (Result = 'iPhone5,2')    then Result := 'iPhone 5 (GSM+CDMA)'
    else
    if (Result = 'iPhone5,3')    then Result := 'iPhone 5c (GSM)'
    else
    if (Result = 'iPhone5,4')    then Result := 'iPhone 5c (GSM+CDMA)'
    else
    if (Result = 'iPhone6,1')    then Result := 'iPhone 5s (GSM)'
    else
    if (Result = 'iPhone6,2')    then Result := 'iPhone 5s (GSM+CDMA)'
    else
    if (Result = 'iPhone7,2')    then Result := 'iPhone 6'
    else
    if (Result = 'iPhone7,1')    then Result := 'iPhone 6 Plus'
    else
    if (Result = 'iPhone8,1')    then Result := 'iPhone 6s'
    else
    if (Result = 'iPhone8,2')    then Result := 'iPhone 6s Plus'
    else
    if (Result = 'iPod1,1')      then Result := 'iPod Touch 1G'
    else
    if (Result = 'iPod2,1')      then Result := 'iPod Touch 2G'
    else
    if (Result = 'iPod3,1')      then Result := 'iPod Touch 3G'
    else
    if (Result = 'iPod4,1')      then Result := 'iPod Touch 4G'
    else
    if (Result = 'iPod5,1')      then Result := 'iPod Touch 5G'
    else
    if (Result = 'iPad1,1')      then Result := 'iPad'
    else
    if (Result = 'iPad2,1')      then Result := 'iPad 2 (WiFi)'
    else
    if (Result = 'iPad2,2')      then Result := 'iPad 2 (GSM)'
    else
    if (Result = 'iPad2,3')      then Result := 'iPad 2 (CDMA)'
    else
    if (Result = 'iPad2,4')      then Result := 'iPad 2 (WiFi)'
    else
    if (Result = 'iPad2,5')      then Result := 'iPad Mini (WiFi)'
    else
    if (Result = 'iPad2,6')      then Result := 'iPad Mini (GSM)'
    else
    if (Result = 'iPad2,7')      then Result := 'iPad Mini (GSM+CDMA)'
    else
    if (Result = 'iPad3,1')      then Result := 'iPad 3 (WiFi)'
    else
    if (Result = 'iPad3,2')      then Result := 'iPad 3 (GSM+CDMA)'
    else
    if (Result = 'iPad3,3')      then Result := 'iPad 3 (GSM)'
    else
    if (Result = 'iPad3,4')      then Result := 'iPad 4 (WiFi)'
    else
    if (Result = 'iPad3,5')      then Result := 'iPad 4 (GSM)'
    else
    if (Result = 'iPad3,6')      then Result := 'iPad 4 (GSM+CDMA)'
    else
    if (Result = 'iPad4,1')      then Result := 'iPad Air (WiFi)'
    else
    if (Result = 'iPad4,2')      then Result := 'iPad Air (Cellular)'
    else
    if (Result = 'iPad4,3')      then Result := 'iPad Air'
    else
    if (Result = 'iPad4,4')      then Result := 'iPad Mini 2G (WiFi)'
    else
    if (Result = 'iPad4,5')      then Result := 'iPad Mini 2G (Cellular)'
    else
    if (Result = 'iPad4,6')      then Result := 'iPad Mini 2G'
    else
    if (Result = 'iPad4,7')      then Result := 'iPad Mini 3 (WiFi)'
    else
    if (Result = 'iPad4,8')      then Result := 'iPad Mini 3 (Cellular)'
    else
    if (Result = 'iPad4,9')      then Result := 'iPad Mini 3 (China)'
    else
    if (Result = 'iPad5,3')      then Result := 'iPad Air 2 (WiFi)'
    else
    if (Result = 'iPad5,4')      then Result := 'iPad Air 2 (Cellular)'
    else
    if (Result = 'AppleTV2,1')   then Result := 'Apple TV 2G'
    else
    if (Result = 'AppleTV3,1')   then Result := 'Apple TV 3'
    else
    if (Result = 'AppleTV3,2')   then Result := 'Apple TV 3 (2013)'
    else
    if (Result = 'i386')         then Result := 'Simulator'
    else
    if (Result = 'x86_64')       then Result := 'Simulator';
  end
  else
    Result := EmptyStr;
end;
{$ENDIF}

function IsValidPhoneNumber(PhoneNumber: String): Boolean;
const
  // Valid characters in an "atom"
  atom_chars = ['0'..'9', 'p', '+', '(', ')', ' '];
var
  I: Integer;
begin
  Result := True;
  for I := Low(PhoneNumber) to High(PhoneNumber) do
    if not CharInSet(PhoneNumber[I], atom_chars) then
      begin
        Result := False;
        Exit;
      end;
end;

function IsValidEmail(Email: String): boolean;
// Returns True if the email address is valid
const
  // Valid characters in an "atom"
  atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':', '\', '/', '"', '.', '[', ']', #127];
  // Valid characters in a "quoted-string"
  quoted_string_chars = [#0..#255] - ['"', #13, '\'];
  // Valid characters in a subdomain
  letters = ['A'..'Z', 'a'..'z'];
  letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];
  subdomain_chars = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];
type
  States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
    STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
    STATE_SUBDOMAIN, STATE_HYPHEN);
var
  State: States;
  i, n, subdomains: integer;
  c: char;
begin
  State := STATE_BEGIN;
  n := Length(email);
  i := 1;
  subdomains := 1;
  while (i <= n) do begin
    c := email[i];
    case State of
    STATE_BEGIN:
      if CharInSet(c, atom_chars) then
        State := STATE_ATOM
      else if c = '"' then
        State := STATE_QTEXT
      else
        break;
    STATE_ATOM:
      if c = '@' then
        State := STATE_EXPECTING_SUBDOMAIN
      else if c = '.' then
        State := STATE_LOCAL_PERIOD
      else if not CharInSet(c, atom_chars) then
        break;
    STATE_QTEXT:
      if c = '\' then
        State := STATE_QCHAR
      else if c = '"' then
        State := STATE_QUOTE
      else if not CharInSet(c, quoted_string_chars) then
        break;
    STATE_QCHAR:
      State := STATE_QTEXT;
    STATE_QUOTE:
      if c = '@' then
        State := STATE_EXPECTING_SUBDOMAIN
      else if c = '.' then
        State := STATE_LOCAL_PERIOD
      else
        break;
    STATE_LOCAL_PERIOD:
      if CharInSet(c, atom_chars) then
        State := STATE_ATOM
      else if c = '"' then
        State := STATE_QTEXT
      else
        break;
    STATE_EXPECTING_SUBDOMAIN:
      if CharInSet(c, letters) then
        State := STATE_SUBDOMAIN
      else
        break;
    STATE_SUBDOMAIN:
      if c = '.' then begin
        inc(subdomains);
        State := STATE_EXPECTING_SUBDOMAIN
      end else if c = '-' then
        State := STATE_HYPHEN
      else if not CharInSet(c, letters_digits) then
        break;
    STATE_HYPHEN:
      if CharInSet(c, letters_digits) then
        State := STATE_SUBDOMAIN
      else if c <> '-' then
        break;
    end;
    inc(i);
  end;
  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;


class procedure TMisc.Open(sCommand: string);
begin
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PChar(sCommand), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  _system(Pointer(MarshaledString(Format('open %s', [sCommand]))));
{$ENDIF POSIX}
end;



function MemoryStreamToString(M: TMemoryStream): string;
begin
  SetString(Result, PChar(M.Memory), M.Size div SizeOf(Char));
end;

{ TCmdThread }

constructor TCmdThread.Create(CreateSuspended: Boolean);
begin
  inherited;
  FLVItem := nil;
  FRepeatCommandCount := 1; //give the command a change to run, let response dispatcher to deal with it after initial answer
  FReportErrors := True;
  FMethod := httpGet;
end;

procedure TCmdThread.ProcessAnswer;
begin
  FRepeatCommandCount := 0;
  ServerProcessedCommand := True;
  if Assigned(FOnDataReceived) then
    FOnDataReceived(Self);
end;

procedure TCmdThread.ProcessError;
var
  WasErrorFired: Boolean;    //!!!

  procedure FireError;
  begin
    if FRepeatCommandCount = 0 then
      FMX.DialogService.Async.TDialogServiceAsync.MessageDialog('ERROR: ' + ErrorReason,
         TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOk, 0, nil);
    WasErrorFired := True;
  end;
begin
  if FReportErrors then
    FireError;
end;

procedure TCmdThread.NetHTTPClient1ValidateServerCertificate(
  const Sender: TObject; const ARequest: TURLRequest;
  const Certificate: TCertificate; var Accepted: Boolean);
begin
  Accepted := True;
end;


destructor TCmdThread.Destroy;
begin
  inherited;
end;

procedure TCmdThread.Execute;
var
  HTTPClient1: THTTPClient;
  AHeaders: TArray<System.Net.URLClient.TNameValuePair>;
  SL: TStringList;
begin
  inherited;
  if FIsBinaryData then
    SStream := TMemoryStream.Create
  else
    SStream := TStringStream.Create;
  HTTPClient1 := THTTPClient.Create;
  HTTPClient1.OnValidateServerCertificate := NetHTTPClient1ValidateServerCertificate;
  try
    while (FRepeatCommandCount > 0) do
      try
        Dec(FRepeatCommandCount);
        FLastCommandWasErroneous := False;
        if FIsBinaryData then
          TMemoryStream(SStream).Clear
        else
          TStringStream(SStream).Clear;
        with HTTPClient1 do
        begin
          CookieManager := nil;
          UserAgent := 'yzAccess RESTClient';
          if FMethod = httpGet then
            FURL := Format('%s/%s%s%s', [FAPIUrl, Cmd, ifthen(FCmdParams <> '', '/', ''), FCmdParams])
          else
            FURL := Format('%s/%s', [FAPIUrl, Cmd]);

          if (Length(AHeaders) = 0) and (FPHPSessionID <> '') then
             begin
               SetLength(AHeaders, 1);
               with AHeaders[0] do
                 begin
                   Name := 'Cookie'; //manually set cookie, default cookieManager SUCKS big time
                   Value := Format('%s=%s', [PHP_SESSION_ID_NAME, FPHPSessionID]);
                 end;
             end;
        end;

        case FMethod of
          httpGet:  LastHttpResponse := HTTPClient1.Get(FURL, SStream, AHeaders);
          httpPut:  LastHttpResponse := HTTPClient1.Put(FURL, FMultipartFormData, SStream, AHeaders); //NOT WORKING
          httpPost:
            begin
              if FCmdParams <> '' then
                try
                  SL := TStringList.Create;
                  SL.StrictDelimiter := True;
                  SL.Delimiter := '&';
                  SL.DelimitedText := FCmdParams;
                  LastHttpResponse := HTTPClient1.Post(FURL, SL, SStream, TEncoding.Default, AHeaders);
                except

                end
              else
                LastHttpResponse := HTTPClient1.Post(FURL, FMultipartFormData, SStream, AHeaders);
            end;
        end;

        if Assigned(LastHttpResponse) then
          begin
            if not IsBinaryData and (FCmd <> CMD_SIGNUP) and (FCmd <> CMD_ITEM_PIC)  and (FCmd <> CMD_PIC) then
              try
                LastJSONAnswer := TStringStream(SStream).DataString;
              except

              end;
            if (LastHttpResponse.StatusCode = 200) and (SStream.Size > 0) then
              Synchronize(ProcessAnswer)
            else
              begin
                FLastCommandWasErroneous := True;
                if (FCmd <> CMD_SIGNUP) and (FCmd <> CMD_ITEM_PIC)  and (FCmd <> CMD_PIC) then //list of commands dealing directly with errors
                  Synchronize(ProcessError)
                else
                  begin
                    ServerProcessedCommand := True;
                    Exit;
                  end;
              end;
          end;

      except on E: Exception do
        begin
          FLastCommandWasErroneous := True;
          if FReportErrors then
            begin
              ErrorReason := E.Message;
              Synchronize(ProcessError);
            end;
        end;
      end;
  finally
    Synchronize(FireProcessComplete);
    if FReportErrors then
      if not ServerProcessedCommand then
        begin
          ErrorReason := 'API Server is unreachable or API error detected.'#13#10'Check your Internet connection and try again.';
          //Synchronize(ProcessError);
        end;
    FreeAndNil(SL);
    FreeAndNil(SStream);
    FreeAndNil(HTTPClient1);
    FreeAndNil(FMultipartFormData);  //!!!
  end;
end;

procedure TCmdThread.FireProcessComplete;
begin
  if Assigned(FOnProcessComplete) then
    FOnProcessComplete(Self);
end;

function TCmdThread.GetResponseStream: TMemoryStream;
begin
  Result := TMemoryStream(SStream);
end;

function TCmdThread.GetResponseStringData: String;
begin
  Result := TStringStream(SStream).DataString;
end;

procedure TCmdThread.SetCaller(const Value: TObject);
begin
  FCaller := Value;
end;

procedure TCmdThread.SetCmd(const Value: String);
begin
  FCmd := Value;
end;

procedure TCmdThread.SetLVItem(const Value: TListViewItem);
begin
  FLVItem := Value;
end;

//procedure TCmdThread.SetParams(const Value: String);
//begin
//  FParams := Value;
//end;


// **** TIVCmdThread

function TIVCmdThread.ExtractUserInfo(obj: TJSONObject): TUserInfo;
var
  opair: TJSONPair;
begin
  if Assigned(obj) and Assigned(obj.get('user')) then
    begin
      Result := TUserInfo.Create;
      with Result do
        begin
          obj := obj.get('user').JSONValue as TJSONObject;
          opair := obj.get('id');
          if Assigned(opair) then
            id := StrToInt(opair.JSONValue.Value);
          opair := obj.get('username');
          if Assigned(opair) then
            username := opair.JSONValue.Value;
          opair := obj.get('picture');
          if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
            picture := opair.JSONValue.Value;
          opair := obj.get('id_picture');
          if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
            id_picture := opair.JSONValue.Value;
          opair := obj.get('password');
          if Assigned(opair) then
            password := opair.JSONValue.Value;
          opair := obj.get('first_name');
          if Assigned(opair) then
            first_name := ifthen(opair.JSONValue.Value = 'null', '', opair.JSONValue.Value);
          opair := obj.get('last_name');
          if Assigned(opair) then
            last_name := ifthen(opair.JSONValue.Value = 'null', '', opair.JSONValue.Value);
          opair := obj.get('email');
          if Assigned(opair) then
            email := opair.JSONValue.Value;
          opair := obj.get('level');
          if Assigned(opair) then
            level := StrToIntDef(opair.JSONValue.Value, 0);
          opair := obj.get('about_me');
          if Assigned(opair) then
            about_me := ifthen(opair.JSONValue.Value = 'null', '', opair.JSONValue.Value);
          opair := obj.get('phone_number');
          if Assigned(opair) then
            phone_number := ifthen(opair.JSONValue.Value = 'null', '', opair.JSONValue.Value);
          opair := obj.get('birthdate');
          if Assigned(opair) and (opair.JSONValue.Value <> 'null') then
            birthdate := StrToDateTimeDef(opair.JSONValue.Value, 0);
          opair := obj.get('user_status');
          if Assigned(opair) then
            user_status := StrToIntDef(opair.JSONValue.Value, -1);
          opair := obj.get('latitude');
          if Assigned(opair) then
            latitude := StrToFloatDef(opair.JSONValue.Value, 0);
          opair := obj.get('longitude');
          if Assigned(opair) then
            longitude := StrToFloatDef(opair.JSONValue.Value, 0);
          opair := obj.get('approximate_location');
          if Assigned(opair) then
            approximate_location := StrToFloatDef(opair.JSONValue.Value, 0);
          opair := obj.get('notif_messages');
          if Assigned(opair) then
            notif_messages := Boolean(StrToIntDef(opair.JSONValue.Value, 1));
          opair := obj.get('notif_updates');
          if Assigned(opair) then
            notif_updates := Boolean(StrToIntDef(opair.JSONValue.Value, 1));
          opair := obj.get('notif_activity');
          if Assigned(opair) then
            notif_activity := Boolean(StrToIntDef(opair.JSONValue.Value, 1));
          opair := obj.get('first_item_complete');
          if Assigned(opair) then
            first_rent_complete := Boolean(StrToIntDef(opair.JSONValue.Value, 1));
          opair := obj.get('items_posted');
          if Assigned(opair) then
            items_posted := StrToIntDef(opair.JSONValue.Value, 0);
        end;
    end;
end;

function TIVCmdThread.ProcessUserRelatedInfo(var UserInfo: TUserInfo): Boolean;
var
  obj: TJSONObject;
  obj2: TJSONValue;
  status: String;
begin
  Result := False;
  try
    obj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LastJSONAnswer), 0) as TJSONObject;
    obj2 := obj.GetValue('status');
    if Assigned(obj2) then
      status := TUnescapeJSONString.UnescapeValue(obj2.ToString);
    if (status = SUCCESS) then
      begin
        UserInfo := ExtractUserInfo(obj);
        Result := True;
      end
    else
      begin
        obj2 := obj.GetValue('reason');
        if Assigned(obj2) then
          ErrorReason := TUnescapeJSONString.UnescapeValue(obj2.ToString)
        else
          ErrorReason := 'Could not login due to uknown error, try agian.';
        ProcessError;
      end;
  except
    if ErrorReason = '' then
      ErrorReason := 'Malformed server response.';
    ProcessError;
  end;
end;

procedure TIVCmdThread.ProcessLoginAnswer;

  procedure ProcessStep1Login;
  var
    obj: TJSONObject;
    obj2: TJSONValue;
    status: String;
    I: Integer;
  begin
    for I := 0 to LastHttpResponse.Cookies.Count - 1 do
      if LastHttpResponse.Cookies[I].Name = PHP_SESSION_ID_NAME then
        begin
          FPHPSessionID := LastHttpResponse.Cookies[I].Value;
          Break;
        end;

     try
       obj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LastJSONAnswer), 0) as TJSONObject;
       obj2 := obj.GetValue('status');
       if Assigned(obj2) then
         status := TUnescapeJSONString.UnescapeValue(obj2.ToString);
       if (status = SUCCESS) then
         begin
           obj2 := obj.GetValue('login_session_key');
           if Assigned(obj2) then
              FLastLoginKey := TUnescapeJSONString.UnescapeValue(obj2.ToString);
         end
       else
         begin
           obj2 := obj.GetValue('reason');
           if Assigned(obj2) then
             ErrorReason := TUnescapeJSONString.UnescapeValue(obj2.ToString);
         end;
      except
        // log here the error
      end;

    if FLastLoginKey <> '' then //first stage success, rerun login with additional params
      begin
        if Assigned(FOnLoginParams) then
          FOnLoginParams(Self, FLastLoginKey, Username, FCmdParams, FURL); //pass the arguments to the login step2
        if FCmdParams <> '' then
          begin
            FRepeatCommandCount := DEFAULT_CMD_RETRIES;
            FWaitingForData := wsNoData;
          end
        else
          ProcessError;
      end;
  end;

  procedure ProcessStep2Login;
  var
    UserInfo: TUserInfo;
  begin
    if ProcessUserRelatedInfo(UserInfo) then
      if Assigned(FOnLoginSuccess) then
        FOnLoginSuccess(Self, UserInfo)
      else
    else
      if Assigned(FOnLoginFailure) then
        FOnLoginFailure(Self)
  end;


begin
  if FLastLoginKey = '' then
    ProcessStep1Login
  else
    ProcessStep2Login;
end;

procedure TIVCmdThread.ProcessUpdateProfile;
var
  UserInfo: TUserInfo;
begin
  if ProcessUserRelatedInfo(UserInfo) then
    begin
      FCurrentUserInfo := UserInfo;
    end;
end;


procedure TIVCmdThread.ProcessAnswer;
begin
  inherited;
  if FCmd = CMD_LOGIN then
    ProcessLoginAnswer
  else if FCmd = CMD_UPDATE_PROFILE then
    ProcessUpdateProfile;
end;

procedure TIVCmdThread.ProcessError;
  procedure FireError;
  begin
    if (FRepeatCommandCount <= 0) and Assigned(FOnError) then
       FOnError(Self, ErrorReason);
  end;
begin
  if Cmd = CMD_LOGIN then
    begin
      if (FLastLoginKey = '') then
        begin
          if Assigned(FOnChangeAPIServer) then
            begin
              FRepeatCommandCount := DEFAULT_CMD_RETRIES;
              FOnChangeAPIServer(Self, CMD_TEMPLATE);
            end
          else
            begin
              CMD_TEMPLATE := '';
              if ErrorReason = '' then
                ErrorReason := 'Could not login.';
              FireError;
            end;
        end
      else
        begin
          FireError;
        end;
    end
  else
    FireError;
end;

class procedure TMisc.SendEmail(aEmail: string; aSubject: string = ''; aBody: string = '');
begin
end;


{ TUserInfoHelper }

class function TUserInfoHelper.GetFullName<T>(
  const UserInfo: TUserInfo): String;
begin
  if (UserInfo.first_name = '') and (UserInfo.last_name = '') then
    Result := UserInfo.username
  else
    Result := Format('%s %s', [UserInfo.first_name, UserInfo.last_name]);
end;

class function TUserInfoHelper.GetScore<T>(const UserInfo: TUserInfo): Integer;
begin
  if Assigned(UserInfo) then
    with UserInfo do
      Result := Integer(email <> '') * 25 +
        Integer(Assigned(PhotoID) and (PhotoID.Width > 0)) * 25 +
        Integer(phone_number <> '') * 15 +
        Integer(Assigned(Photo) and (Photo.Width > 0)) * 10 +
        Integer(first_rent_complete) * 5 +
        Integer(items_posted >= 2) * 20;
end;

class function TUserInfoHelper.HasPhoto(const UserInfo: TUserInfo): Boolean;
begin
  Result := Assigned(UserInfo.Photo) and (UserInfo.Photo.Width > 0);
end;

class function TUserInfoHelper.HasPhotoID(const UserInfo: TUserInfo): Boolean;
begin
  Result := Assigned(UserInfo.PhotoID) and (UserInfo.PhotoID.Width > 0);
end;

{ TItemInfoHelper }

class procedure TItemInfoHelper.Empty(var ItemInfo: TItemInfo; NullPhotos: Boolean);
var
  I: Integer;
begin
  ItemInfo.Id := -1;
  if NullPhotos then
    for I := 0 to Length(ItemInfo.Photos) do
      ItemInfo.Photos[I] := nil;
end;


function CalcAgeHumanReadable(Date: TDateTime; DisplayAllUnits: Boolean): String;
var
  UnitsBetween: Integer;
  Units: String;
begin
  if Date = 0 then
    begin
      Result := 'old enough';
      Exit;
    end;
  Units := 'minutes';
  UnitsBetween := MinutesBetween(Date, Now);
  Result := Format('%d %s %s', [UnitsBetween mod 60, Units, Result]);
  if UnitsBetween > 60 then
    begin
      if not DisplayAllUnits then
        Result := '';
      Units := 'hours';
      UnitsBetween := HoursBetween(Date, Now);
      Result := Format('%d %s %s', [UnitsBetween mod 60, Units, Result]);
      if UnitsBetween > 24 then
        begin
          if not DisplayAllUnits then
            Result := '';
          Units := 'days';
          UnitsBetween := DaysBetween(Date, Now);
          Result := Format('%d %s %s', [UnitsBetween mod 7, Units, Result]);
          if UnitsBetween > 7 then
            begin
              if not DisplayAllUnits then
                Result := '';
              Units := 'weeks';
              UnitsBetween := WeeksBetween(Date, Now);
              Result := Format('%d %s %s', [UnitsBetween mod 52, Units, Result]);
              if UnitsBetween > 52 then
                begin
                  if not DisplayAllUnits then
                    Result := '';
                  Units := 'years';
                  UnitsBetween := YearsBetween(Date, Now);
                  Result := Format('%d %s %s', [UnitsBetween, Units, Result]);
                end;
            end;
        end;
    end;
end;

end.

