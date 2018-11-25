unit SettingsXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.ListBox, DataModule,
  FMX.TabControl, FMX.Edit, FMX.ScrollBox, FMX.Memo, FMX.ComboEdit, FMX.Maps,
  FMX.WebBrowser, FMX.Effects, System.Sensors, System.Sensors.Components;

type
  TSettingsFrm = class(TFrame)
    LayHeader: TLayout;
    SpeedButton1: TSpeedButton;
    TxtHeader: TText;
    TcSettings: TTabControl;
    MainTab: TTabItem;
    ListBox1: TListBox;
    lbighProfile: TListBoxGroupHeader;
    LbiPhoto: TListBoxItem;
    Circle15: TCircle;
    TxtName: TText;
    ImgUserPhoto: TImage;
    lbiName: TListBoxItem;
    LbiEmail: TListBoxItem;
    LbiLocation: TListBoxItem;
    LbiAboutMe: TListBoxItem;
    LbiPass: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ChangeNameTab: TTabItem;
    EdNewName: TEdit;
    Rectangle1: TRectangle;
    TxtBtnSave: TText;
    EmailTab: TTabItem;
    LocationTab: TTabItem;
    AboutMeTab: TTabItem;
    ChangePasswordTab: TTabItem;
    EdNewEmailAddress: TEdit;
    Layout2: TLayout;
    Rectangle3: TRectangle;
    Text4: TText;
    Layout3: TLayout;
    TxtApprox: TText;
    Switch1: TSwitch;
    MapView1: TMapView;
    ComboEdit1: TComboEdit;
    MemoAboutMe: TMemo;
    RectBtnSaveBio: TRectangle;
    Text6: TText;
    Text7: TText;
    RectBtnSavePass: TRectangle;
    TxtBtnChangePass: TText;
    EdNewPass: TEdit;
    EdConfirmPass: TEdit;
    PushNotificationsTab: TTabItem;
    Layout4: TLayout;
    Text8: TText;
    SwNotifMessages: TSwitch;
    Layout5: TLayout;
    Text9: TText;
    SwNotifListUpdates: TSwitch;
    Layout6: TLayout;
    Text10: TText;
    SwNotifActivity: TSwitch;
    WebBrowserTab: TTabItem;
    WebBrowser1: TWebBrowser;
    EarnPointsTab: TTabItem;
    RectCurrentScorring: TRectangle;
    ShadowEffect1: TShadowEffect;
    Circle1: TCircle;
    TxtScoreSmall: TText;
    TxtSmallUsernameFirstCap: TText;
    Layout1: TLayout;
    Text13: TText;
    Text12: TText;
    LockImage: TImage;
    ListBox2: TListBox;
    LbiScoreEmail: TListBoxItem;
    LbiScorePhotoID: TListBoxItem;
    LbiScorePhoneNumber: TListBoxItem;
    ListBoxGroupHeader4: TListBoxGroupHeader;
    ListBoxItem18: TListBoxItem;
    LbiScoreProfilePicture: TListBoxItem;
    Line1: TLine;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    Line2: TLine;
    ListBoxItem12: TListBoxItem;
    LbiScoreFirstRentComplete: TListBoxItem;
    LbiPhoneNumber: TListBoxItem;
    PhoneTab: TTabItem;
    Rectangle2: TRectangle;
    Text15: TText;
    EdNewPhoneNumber: TEdit;
    ListBoxItem17: TListBoxItem;
    Rectangle26: TRectangle;
    Text46: TText;
    ListBoxItem21: TListBoxItem;
    TxtVersion: TText;
    ListBoxGroupHeader5: TListBoxGroupHeader;
    LbiScorePost2Items: TListBoxItem;
    Text16: TText;
    Text14: TText;
    TxtCurrentPhoneNo: TText;
    LbiPhotoID: TListBoxItem;
    LbiTheme: TListBoxItem;
    ListBoxGroupHeader6: TListBoxGroupHeader;
    LanguageTab: TTabItem;
    LbiLanguage: TListBoxItem;
    ThemeTab: TTabItem;
    RectBtnSaveEmail: TRectangle;
    Text1: TText;
    Text3: TText;
    TxtCurrentEmail: TText;
    Layout7: TLayout;
    Text17: TText;
    Layout8: TLayout;
    Text20: TText;
    cbLanguages: TComboBox;
    StyleBox: TComboBox;
    LocationSensor1: TLocationSensor;
    TrackBar1: TTrackBar;
    procedure Text46Click(Sender: TObject);
    procedure LbiPhotoClick(Sender: TObject);
    procedure lbiNameClick(Sender: TObject);
    procedure LbiEmailClick(Sender: TObject);
    procedure LbiLocationClick(Sender: TObject);
    procedure LbiAboutMeClick(Sender: TObject);
    procedure LbiPassClick(Sender: TObject);
    procedure ListBoxItem7Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListBoxItem8Click(Sender: TObject);
    procedure ListBoxItem9Click(Sender: TObject);
    procedure ListBoxItem10Click(Sender: TObject);
    procedure MemoAboutMeChangeTracking(Sender: TObject);
    procedure MemoAboutMeEnter(Sender: TObject);
    procedure TcSettingsChange(Sender: TObject);
    procedure EdNewEmailAddressChangeTracking(Sender: TObject);
    procedure EdNewPassChangeTracking(Sender: TObject);
    procedure TxtBtnSaveClick(Sender: TObject);
    procedure TxtBtnChangePassClick(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure EdNewNameChangeTracking(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure Text6Click(Sender: TObject);
    procedure EdNewPhoneNumberChangeTracking(Sender: TObject);
    procedure LbiPhoneNumberClick(Sender: TObject);
    procedure Text15Click(Sender: TObject);
    procedure SwNotifMessagesSwitch(Sender: TObject);
    procedure SwNotifListUpdatesSwitch(Sender: TObject);
    procedure SwNotifActivitySwitch(Sender: TObject);
    procedure LbiThemeClick(Sender: TObject);
    procedure cbLanguagesChange(Sender: TObject);
    procedure StyleBoxChange(Sender: TObject);
    procedure LbiLanguageClick(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure LbiPhotoIDClick(Sender: TObject);
    procedure LbiScoreFirstRentCompleteClick(Sender: TObject);
    procedure LbiScorePost2ItemsClick(Sender: TObject);
  private
    MapCenter: TMapCoordinate;
    MyMarker: TMapMarkerDescriptor;
    AreaCircle: TMapCircleDescriptor;
  public
    DefaultTabIndex: Integer;
    CallingFrame: TFrame;
    LastLocation: TLocationCoord2D;
    { Public declarations }
  end;

implementation

uses Main, uSharedEconomyConsts, MkUtils, FMX.Styles;

{$R *.fmx}

procedure TSettingsFrm.EdNewNameChangeTracking(Sender: TObject);
begin
  TxtBtnSave.Enabled := EdNewName.Text <> '';
end;

procedure TSettingsFrm.cbLanguagesChange(Sender: TObject);
begin
  MainForm.Lang1.Lang := MainForm.Lang1.Resources[cbLanguages.ItemIndex];
  LbiLanguage.ItemData.Detail := cbLanguages.Selected.Text;
end;

procedure TSettingsFrm.EdNewEmailAddressChangeTracking(Sender: TObject);
begin
  RectBtnSaveEmail.Enabled := EdNewEmailAddress.Text <> '';
end;

procedure TSettingsFrm.EdNewPhoneNumberChangeTracking(Sender: TObject);
begin
  Rectangle2.Enabled := EdNewPhoneNumber.Text <> '';
end;

procedure TSettingsFrm.EdNewPassChangeTracking(Sender: TObject);
begin
  RectBtnSavePass.Enabled := (EdNewPass.Text <> '') and (EdNewPass.Text = EdConfirmPass.Text);
end;

procedure TSettingsFrm.LbiPhoneNumberClick(Sender: TObject);
begin
  TCSettings.ActiveTab := PhoneTab;
  TxtCurrentPhoneNo.Text := LbiPhoneNumber.ItemData.Detail;
end;

procedure TSettingsFrm.ListBoxItem10Click(Sender: TObject);
begin
  MainForm.DisplayURL(PRIVACY_URL, Self);
  TxtHeader.Text := 'PRIVACY POLICY';
end;

procedure TSettingsFrm.LbiPhotoClick(Sender: TObject);
begin
  MainForm.OpenCamera(Self, '', cdProfilePhoto);
end;

procedure TSettingsFrm.LbiPhotoIDClick(Sender: TObject);
begin
  MainForm.OpenCamera(Self, '', cdProfilePhotoID);
end;

procedure TSettingsFrm.LbiScoreFirstRentCompleteClick(Sender: TObject);
begin
  MainForm.OpenMyAccount(Self);
end;

procedure TSettingsFrm.LbiScorePost2ItemsClick(Sender: TObject);
begin
  MainForm.OpenMyAccount(Self);
end;

procedure TSettingsFrm.LbiThemeClick(Sender: TObject);
begin
  TcSettings.ActiveTab := ThemeTab;
end;

procedure TSettingsFrm.lbiNameClick(Sender: TObject);
begin
  EdNewName.TextPrompt := Format('%s - Enter new name', [lbiName.ItemData.Detail]);
  TCSettings.ActiveTab := ChangeNameTab;
end;

procedure TSettingsFrm.LbiEmailClick(Sender: TObject);
begin
  TCSettings.ActiveTab := EmailTab;
  TxtCurrentEmail.Text := LbiEmail.ItemData.Detail;
end;

procedure TSettingsFrm.LbiLanguageClick(Sender: TObject);
begin
  TcSettings.ActiveTab := LanguageTab;
end;

procedure TSettingsFrm.LbiLocationClick(Sender: TObject);
begin
  TCSettings.ActiveTab := LocationTab;
end;

procedure TSettingsFrm.LbiAboutMeClick(Sender: TObject);
begin
  TCSettings.ActiveTab := AboutMeTab;
end;

procedure TSettingsFrm.LbiPassClick(Sender: TObject);
begin
  TCSettings.ActiveTab := ChangePasswordTab;
end;

procedure TSettingsFrm.ListBoxItem7Click(Sender: TObject);
begin
  TCSettings.ActiveTab := PushNotificationsTab;
end;

procedure TSettingsFrm.ListBoxItem8Click(Sender: TObject);
begin
  MainForm.DisplayURL(HELP_URL, Self);
  TxtHeader.Text := 'HELP';
end;

procedure TSettingsFrm.ListBoxItem9Click(Sender: TObject);
begin
  MainForm.DisplayURL(TERMS_CONDITIONS_URL, Self);
  TxtHeader.Text := 'TERMS && CONDITIONS';
end;

procedure TSettingsFrm.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  LastLocation := NewLocation;
  MapView1.DeleteChildren;
  MapCenter := TMapCoordinate.Create(NewLocation.Latitude, NewLocation.Longitude);
  MyMarker := TMapMarkerDescriptor.Create(MapCenter, 'My Location');

  with MyMarker do
    begin
      FreeAndNil(Icon);
      Icon := TBitmap.Create;
      Opacity := 0.5;
      MainForm.AssignBmpIndexToImg(Icon, 40, DataModule1.SESpecificImages);
      Snippet := 'From where I am renting my stuff';
      Title := 'My Current Location';
      Draggable := True;
      Visible := True;
      MapView1.AddMarker(MyMarker);
      MapView1.Location := MapCenter;
    end;
  AreaCircle := TMapCircleDescriptor.Create(MapCenter, TrackBar1.Value);  //this is a static function, no allocation
  AreaCircle.FillColor := $8000FF00;
  AreaCircle.StrokeColor := AreaCircle.FillColor;
  MapView1.AddCircle(AreaCircle);
end;

procedure TSettingsFrm.MemoAboutMeChangeTracking(Sender: TObject);
begin
  Text7.Text := Format('%d', [MAX_ABOUT_ME_TEXT_LENGTH - MemoAboutMe.Text.Length]);
  RectBtnSaveBio.Enabled := MemoAboutMe.Text <> '';
end;

procedure TSettingsFrm.MemoAboutMeEnter(Sender: TObject);
begin
  MemoAboutMe.MaxLength := MAX_ABOUT_ME_TEXT_LENGTH;
end;

procedure TSettingsFrm.SpeedButton1Click(Sender: TObject);
begin
  if TcSettings.TabIndex = DefaultTabIndex then
    MainForm.CloseSettings
  else
    TcSettings.TabIndex := DefaultTabIndex;
end;

procedure TSettingsFrm.StyleBoxChange(Sender: TObject);
var
  style: TFMXObject;
begin
  style := TStyleStreaming.LoadFromResource(HInstance, StyleBox.Selected.Text, RT_RCDATA);
  TStyleManager.SetStyle(style);
  LbiTheme.ItemData.Detail := StyleBox.Selected.Text;
end;

procedure TSettingsFrm.Switch1Switch(Sender: TObject);
begin
  TrackBar1.Visible := Switch1.IsChecked;
  LocationSensor1.Accuracy := TrackBar1.Value;
  LocationSensor1.Distance := TrackBar1.Value;
  if Switch1.IsChecked then
    begin
      TxtApprox.Text := Format('Use approximate location (%d)', [Round(TrackBar1.Value)]);
      if Assigned(MapView1.Children) then
        MapView1.Children[1].Free;
      AreaCircle := TMapCircleDescriptor.Create(MapCenter, TrackBar1.Value);
      with AreaCircle do
        begin
          FillColor := $3200FF00;
          StrokeColor := FillColor;
          Radius := TrackBar1.Value;
          MapView1.AddCircle(AreaCircle);
        end;
    end
  else
    begin
      TxtApprox.Text := 'Use approximate location';
    end;
end;

procedure TSettingsFrm.SwNotifActivitySwitch(Sender: TObject);
begin
  if Tag = 0 then
    MainForm.UpdateProfile(Format('notif_activity=%d', [Integer(SwNotifActivity.IsChecked)]));
end;

procedure TSettingsFrm.SwNotifListUpdatesSwitch(Sender: TObject);
begin
  if Tag = 0 then
    MainForm.UpdateProfile(Format('notif_updates=%d', [Integer(SwNotifListUpdates.IsChecked)]));
end;

procedure TSettingsFrm.SwNotifMessagesSwitch(Sender: TObject);
begin
  if Tag = 0 then
    MainForm.UpdateProfile(Format('notif_messages=%d', [Integer(SwNotifMessages.IsChecked)]));
end;

procedure TSettingsFrm.TcSettingsChange(Sender: TObject);
begin
  if TcSettings.ActiveTab.Text <> '' then
    TxtHeader.Text := TcSettings.ActiveTab.Text;
  case TcSettings.ActiveTab.Index of
    8: //EarnPointsTab
      with MainForm.UserInfo do
      begin
        LbiScoreEmail.Enabled := email = '';
        LbiScoreProfilePicture.Enabled := not Assigned(Photo) or (Photo.Width <= 0);
        LbiScorePhotoID.Enabled := not Assigned(PhotoID) or (PhotoID.Width <= 0);
        LbiScorePhoneNumber.Enabled := phone_number = '';
        LbiScoreFirstRentComplete.Enabled := items_rented <= 0;
        LbiScorePost2Items.Enabled := items_posted <= 1;
      end;
  end;
  RectCurrentScorring.Visible := TcSettings.ActiveTab = EarnPointsTab;
  LocationSensor1.Active := TcSettings.ActiveTab = LocationTab;
  TrackBar1.Visible := Switch1.IsChecked;
end;

procedure TSettingsFrm.Text15Click(Sender: TObject);
begin
  if not IsValidPhoneNumber(EdNewPhoneNumber.Text) then
    begin
      ShowMessage('Invalid phone number, please try again!');
    end
  else
    begin
      TcSettings.ActiveTab := MainTab;
      LbiPhoneNumber.ItemData.Detail := '[updating...]';
      MainForm.UpdateProfile(Format('phone_number=%s', [EdNewPhoneNumber.Text]));
    end;
end;

procedure TSettingsFrm.Text1Click(Sender: TObject);
begin
  if not IsValidEmail(EdNewEmailAddress.Text) then
    begin
      ShowMessage('Invalid email address, please try again!');
    end
  else
    begin
      TcSettings.ActiveTab := MainTab;
      LbiEmail.ItemData.Detail := '[updating...]';
      MainForm.UpdateProfile(Format('email=%s', [EdNewEmailAddress.Text]));
    end;
end;

procedure TSettingsFrm.Text46Click(Sender: TObject);
begin
  Hide;
  MainForm.Logout;
end;

procedure TSettingsFrm.Text4Click(Sender: TObject);
begin
  TcSettings.ActiveTab := MainTab;
  MainForm.UpdateProfile(Format('latitude=%f&longitude=%f&approximate_location=%.0f', [
    LastLocation.Latitude,
    LastLocation.Longitude,
    Integer(Switch1.IsChecked) * TrackBar1.Value
  ]));
end;

procedure TSettingsFrm.Text6Click(Sender: TObject);
begin
  TcSettings.ActiveTab := MainTab;
  LbiAboutMe.ItemData.Detail := '[updating...]';
  MainForm.UpdateProfile(Format('about_me=%s', [MemoAboutMe.Text]));
end;

procedure TSettingsFrm.TxtBtnChangePassClick(Sender: TObject);
begin
  TcSettings.ActiveTab := MainTab;
  LbiPass.ItemData.Detail := '[updating...]';
  MainForm.UpdateProfile(Format('password=%s', [GetMd5HashString(EdNewPass.Text)]), MainForm.PasswordUpdatedCallback);
end;

procedure TSettingsFrm.TxtBtnSaveClick(Sender: TObject);
var
  I: Integer;
  FistName, LastName: String;
begin
  TcSettings.ActiveTab := MainTab;
  lbiName.ItemData.Detail := '[updating...]';
  I := Pos(' ', EdNewName.Text);
  if I > 0 then
    begin
      FistName := Copy(EdNewName.Text, 1, I - 1);
      LastName := Copy(EdNewName.Text, I + 1);
    end
  else
    begin
      FistName := EdNewName.Text;
      LastName := '';
    end;
  MainForm.UpdateProfile(Format('first_name=%s&last_name=%s', [FistName, LastName]));
end;

end.
