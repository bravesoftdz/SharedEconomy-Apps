unit CameraXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects,
  FMX.Filter.Effects, FMX.Media, FMX.Platform, FMX.TabControl,
  FMX.MultiResBitmap, MkUtils, FMX.ImgList, FMX.Gestures, System.Messaging;

type
  TCameraFrm = class(TFrame)
    TabControl1: TTabControl;
    GalleryTab: TTabItem;
    CamTab: TTabItem;
    PhotoImage: TImage;
    LayPostTakePic: TLayout;
    BtnPostPic: TRectangle;
    TxtPostBig: TText;
    TxtBtnRetake: TText;
    Layout3: TLayout;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
    Line5: TLine;
    Line6: TLine;
    Line7: TLine;
    Line8: TLine;
    alGetFromCamera: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    ImgPhoto: TImage;
    LayTop: TLayout;
    ImgToggleCamera: TImage;
    CameraComponent: TCameraComponent;
    BtnPostSmall: TRectangle;
    TxtPostSmall: TText;
    TxtGallery: TText;
    RectBackground: TRectangle;
    LayAllowPhotoGallery: TLayout;
    Rectangle1: TRectangle;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    LaySnapshotButtons: TLayout;
    CamCircleMain: TCircle;
    Image4: TImage;
    Layout6: TLayout;
    Layout7: TLayout;
    Circle: TCircle;
    Image1: TImage;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    CloseFrameAct: TAction;
    ImgTorch: TImage;
    Image3: TImage;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    GalleryImage: TImage;
    BtnSelectPhoto: TCornerButton;
    HorzScrollBox1: THorzScrollBox;
    BtnAddPhoto: TCornerButton;
    AddPhotoToListAct: TAction;
    GestureManager1: TGestureManager;
    Timer1: TTimer;
    LayCamPermission: TLayout;
    Rectangle4: TRectangle;
    Text1: TText;
    Text5: TText;
    Text6: TText;
    ImgShowGallery: TImage;
    Text7: TText;
    GetPhotoFromLocalFSAct: TAction;
    OpenDialog1: TOpenDialog;
    TxtItemPhotoList: TText;
    Text9: TText;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure TxtBtnRetakeClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure ImgToggleCameraClick(Sender: TObject);
    procedure ImgTorchClick(Sender: TObject);
    procedure CameraComponentSampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure TabControl1Change(Sender: TObject);
    procedure ImgShowGalleryClick(Sender: TObject);
    procedure CloseFrameActExecute(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure TakePhotoFromLibraryAction1CanActionExec(Sender: TCustomAction;
      var CanExec: Boolean);
    procedure TakePhotoFromLibraryAction1DidCancelTaking;
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromLibraryAction1Update(Sender: TObject);
    procedure TakePhotoFromLibraryAction1Hint(var HintStr: string;
      var CanShow: Boolean);
    procedure AddPhotoToListActExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure TxtPostBigClick(Sender: TObject);
    procedure TxtPostSmallClick(Sender: TObject);
    procedure GetPhotoFromLocalFSActExecute(Sender: TObject);
    procedure Circle2Click(Sender: TObject);
  private
    procedure ChangeTorch(Mode: TTorchMode);
    function AppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
    procedure PhotoGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure PhotoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure PhotoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure DoDidFinish(Sender: TObject; Image: TBitmap); overload;
    procedure DoDidFinish(Image: TBitmap); overload;
    procedure PhotoClick(Sender: TObject);
    procedure FinalStageUpload(Category: String = 'OTHER');
    { Private declarations }
  public
    { Public declarations }
    FrameToReturnTo: TFrame;

    procedure ReadCurrentConfiguration;
    procedure ChangeResolution;
    procedure DoCreate; //override;
    procedure DoInitialize; //override;
    procedure DoDeinitialize; //override;

  end;

implementation

uses Main, DataModule, FMX.MediaLibrary, uSharedEconomyConsts
{$if defined(UserInvisibleTMS)}
  , InvisibleXFrm
{$endif}
, SelectCategoryXFrm;

{$R *.fmx}

procedure TCameraFrm.DoDidFinish(Sender: TObject; Image: TBitmap);
begin
  ImgPhoto.Bitmap.Clear($FF000000);
  ImgPhoto.Bitmap.Assign(Image);
  LayPostTakePic.Visible := True;
{$if defined(UserInvisibleTMS)}
  InvisibleFrm.TMSFMXNativeCameraViewController1.Stop;
{$endif}
end;

procedure TCameraFrm.DoDidFinish(Image: TBitmap);
begin
  GalleryImage.Bitmap.Clear($FF000000);
  GalleryImage.Bitmap.Assign(Image);
  //LayPostTakePic.Visible := True;
  BtnPostSmall.Enabled := True;
{$if defined(UserInvisibleTMS)}
  InvisibleFrm.TMSFMXNativeCameraViewController1.Stop;
{$endif}
end;

procedure TCameraFrm.ImgShowGalleryClick(Sender: TObject);
begin
  TabControl1.ActiveTab := GalleryTab;
end;

procedure TCameraFrm.ImgToggleCameraClick(Sender: TObject);
var
  LActive: Boolean;
begin
  { Select Front Camera }
  LActive := CameraComponent.Active;
  try
    CameraComponent.Active := False;
    if CameraComponent.Kind = TCameraKind.FrontCamera then //!!! potential issue when there is only a camera available
      CameraComponent.Kind := TCameraKind.BackCamera
    else
      CameraComponent.Kind := TCameraKind.FrontCamera;
  finally
    CameraComponent.Active := LActive;
    ChangeResolution;
  end;
end;

procedure TCameraFrm.ImgTorchClick(Sender: TObject);
var
  Mode: TTorchMode;
  Item: TCustomBitmapItem;
  Size: TSize;
begin
  Mode := TTorchMode.ModeAuto;
  Item := nil;
  case CameraComponent.TorchMode of
    TTorchMode.ModeOff:
        Mode := TTorchMode.ModeOn;
    TTorchMode.ModeOn:
        Mode := TTorchMode.ModeAuto;
    TTorchMode.ModeAuto:
        Mode := TTorchMode.ModeOff;
  end;
  CameraComponent.TorchMode := Mode;
  case CameraComponent.TorchMode of
    TTorchMode.ModeOff:
        DataModule1.SESpecificImages.BitmapItemByName('lightning-NO', Item, Size);
    TTorchMode.ModeOn:
        DataModule1.SESpecificImages.BitmapItemByName('lightning', Item, Size);
    TTorchMode.ModeAuto:
        DataModule1.SESpecificImages.BitmapItemByName('lightning-Auto', Item, Size);
  end;
  if Assigned(Item) then
    ImgTorch.Bitmap.Assign(Item.MultiResBitmap.Bitmaps[1.0]);
  if not Assigned(Item) or not CameraComponent.HasTorch then
    begin
      ImgTorch.Enabled := False;
    end;
end;

procedure TCameraFrm.DoCreate;
var
  Item: TCustomBitmapItem;
  Size: TSize;
begin
  LayCamPermission.Visible := False;
  LayAllowPhotoGallery.Visible := False;
  MainForm.ButtonifyGroup(TxtPostSmall);
  MainForm.ButtonifyGroup(TxtPostBig);
  ReadCurrentConfiguration;

  DataModule1.SESpecificImages.BitmapItemByName('lightning-Auto', Item, Size);
  ImgTorch.Bitmap.Assign(Item.MultiResBitmap.Bitmaps[1.0]);
  ImgTorch.Position.X := ImgToggleCamera.Position.X + ImgToggleCamera.Width + 1;

  Image3.Bitmap.Assign(DataModule1.SESpecificImages.Bitmap(Size, 7));
  LayTop.SetFocus;
{$if defined(UserInvisibleTMS)}
  InvisibleFrm := TInvisibleFrm.Create(Self);
  InvisibleFrm.TMSFMXNativeCameraViewController1.InitializeCamera(False);
  InvisibleFrm.TMSFMXNativeCameraViewController1.OnCapturePhoto := DoDidFinish;
{$endif}
{$ifdef MSWINDOWS}
  BtnSelectPhoto.Action := GetPhotoFromLocalFSAct;
{$endif}
end;

procedure TCameraFrm.DoInitialize;
var
  I: Integer;
begin
  BtnAddPhoto.Visible := MainForm.CamDestination = cdItemPic;
  HorzScrollBox1.Visible := BtnAddPhoto.Visible;
  TabControl1.ActiveTab := GalleryTab;
  TabControl1Change(TabControl1);
  Visible := True;
  LayPostTakePic.Visible := False;
  HorzScrollBox1.BeginUpdate;
  try
    for I := HorzScrollBox1.Content.ChildrenCount - 1 downto 0 do
      HorzScrollBox1.Content.Children[I].Free;
  finally
    HorzScrollBox1.EndUpdate;
  end;
end;

procedure TCameraFrm.GetPhotoFromLocalFSActExecute(Sender: TObject);
begin
{$ifdef MSWIndows}
  if OpenDialog1.Execute then
    GalleryImage.Bitmap.LoadFromFile(OpenDialog1.FileName);
{$endif}
  if not BtnAddPhoto.Visible then //expecting only one pic
    BtnPostSmall.Enabled := True
  else
    if HorzScrollBox1.Visible and (HorzScrollBox1.Content.ChildrenCount = 0) then
      BtnAddPhoto.Action.Execute;
end;

procedure TCameraFrm.DoDeinitialize;
begin
  Visible := False;
  CameraComponent.Active := False;
end;

procedure TCameraFrm.Image1Click(Sender: TObject);
begin
  TakePhotoFromCameraAction1.Execute;
end;

procedure TCameraFrm.Image4Click(Sender: TObject);
begin
  CameraComponent.Active := False;
  CamCircleMain.Visible := False;
{$if defined(UserInvisibleTMS)}
  with InvisibleFrm.TMSFMXNativeCameraViewController1 do
    begin
      Start;
      FlashMode := TTMSFMXNativeCameraViewControllerFlashMode(CameraComponent.FlashMode);
      CapturePhoto;
    end;
{$else}
   TakePhotoFromCameraAction1.Execute;
{$endif}
  LayPostTakePic.Visible := True;
  LaySnapshotButtons.Position.Y := LayPostTakePic.Position.Y - LaySnapshotButtons.Height;
end;

procedure TCameraFrm.ReadCurrentConfiguration;
var
  AppEventSvc: IFMXApplicationEventService;
begin
  ChangeResolution;
  ImgTorch.Visible := CameraComponent.HasTorch;
  ChangeTorch(TTorchMode.ModeAuto);
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(AppEventSvc)) then
    AppEventSvc.SetApplicationEventHandler(AppEvent);
  CameraComponent.Active := True;
end;

var
  ImgIndex: Integer;
  MousePosY: Single;
  MousePosX: Single;

procedure TCameraFrm.AddPhotoToListActExecute(Sender: TObject);
var
  Img: TImage;
begin
  if HorzScrollBox1.Content.ChildrenCount >= Tag then
    begin
      ShowMessage(Format('Maximum of %d image slots has been reached for this section! No more images can be added at the moment. Delete some, to make room for others.', [Tag]));
      Exit;
    end;
  Img := TImage.Create(Self);
  with Img do
    begin
      Bitmap.Assign(GalleryImage.Bitmap);
      Align := TAlignLayout.Left;
      Margins.Right := 5;
      Width := HorzScrollBox1.Height * (GalleryImage.Bitmap.Width / GalleryImage.Bitmap.Height);
      WrapMode := TImageWrapMode.Fit;
      Parent := HorzScrollBox1;
      Position.X := 0;
      Tag := ImgIndex;
      Inc(ImgIndex);
      HitTest := True;
      //Touch.GestureManager := GestureManager1;
      OnClick := PhotoClick;
      OnMouseUp := PhotoMouseUp;
      OnMouseDown := PhotoMouseDown;
      //HorzScrollBox1.ScrollBy(HorzScrollBox1.BoundsRect.Width, 0);
      BtnPostSmall.Enabled := True;
      BtnPostSmall.Visible := True;
    end;
end;

function TCameraFrm.AppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
begin
  case AAppEvent of
    TApplicationEvent.WillBecomeInactive:
      CameraComponent.Active := False;
    TApplicationEvent.EnteredBackground:
      CameraComponent.Active := False;
    TApplicationEvent.WillTerminate:
      CameraComponent.Active := False;
  end;
  Result := True;
end;


procedure TCameraFrm.PhotoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  MousePosY := Y;
  MousePosX := X;
end;

procedure TCameraFrm.PhotoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if (Y - MousePosY > 100) and (Abs(X - MousePosX) < 50) then //swipe down
    if Sender is TImage then
      begin
        TImage(Sender).Parent := nil;
        Sender.Free;
        BtnPostSmall.Enabled := HorzScrollBox1.ChildrenCount > 0;
      end;
end;

procedure TCameraFrm.PhotoClick(Sender: TObject);
begin
  GalleryImage.Bitmap.Assign(TImage(Sender).Bitmap);
end;

procedure TCameraFrm.PhotoGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
//
end;

procedure TCameraFrm.ChangeTorch(Mode: TTorchMode);
var
  LActive: Boolean;
begin
  { Turn on automatic Torch, if supported }
  if CameraComponent.HasTorch then
  begin
    LActive := CameraComponent.Active;
    try
      CameraComponent.Active := False;
      CameraComponent.TorchMode := Mode;
    finally
      CameraComponent.Active := LActive;
    end;
  end;
end;

procedure TCameraFrm.Circle2Click(Sender: TObject);
var
  Category: String;
begin
  Category := GetSelectedCategory(Sender);
  FinalStageUpload(Category);
end;

procedure TCameraFrm.FinalStageUpload(Category: String = 'OTHER');
begin
  if Assigned(SelectCategoryFrm) then
    SelectCategoryFrm.Visible := False;
  if HorzScrollBox1.Visible then
    MainForm.PostPicture(HorzScrollBox1, Category)
  else
    MainForm.PostPicture(GalleryImage.Bitmap, Category);
  MainForm.CloseCameraFrame;
end;


procedure TCameraFrm.CloseFrameActExecute(Sender: TObject);
begin
  MainForm.CloseCameraFrame;
end;

procedure TCameraFrm.CameraComponentSampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
  CameraComponent.SampleBufferToBitmap(ImgPhoto.Bitmap, True);
  Timer1.Enabled := False;
  LayCamPermission.Visible := False;
end;

procedure TCameraFrm.ChangeResolution;
var
  LSettings: TArray<TVideoCaptureSetting>;
  LActive: Boolean;
  I: Integer;
begin
  LActive := CameraComponent.Active;
  try
    CameraComponent.Active := False;
    LSettings := CameraComponent.AvailableCaptureSettings;
    for I := Low(LSettings) to High(LSettings) do
      if (LSettings[I].FrameRate = 30) or (LSettings[I].Width = 1080) then
        begin
          CameraComponent.CaptureSetting := LSettings[I]; //select best
          Break;
        end;
  finally
    CameraComponent.Active := LActive;
  end;
end;

procedure TCameraFrm.TabControl1Change(Sender: TObject);
begin
  CameraComponent.Active := TabControl1.ActiveTab = CamTab;
  TxtGallery.Visible := TabControl1.ActiveTab = GalleryTab;
  BtnPostSmall.Visible := BtnSelectPhoto.Visible and (TabControl1.ActiveTab = GalleryTab);
  ImgToggleCamera.Visible := TabControl1.ActiveTab = CamTab;
  ImgTorch.Visible := TabControl1.ActiveTab = CamTab;
  LayTop.Parent := TabControl1.ActiveTab;
  LayTop.Position.Y := 0;

  Timer1.Enabled := CameraComponent.Active;
  LayCamPermission.Visible := (TabControl1.ActiveTab = CamTab) and not Assigned(ImgPhoto.Bitmap);
end;

procedure TCameraFrm.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
  GalleryImage.Bitmap.Assign(Image);
end;

procedure TCameraFrm.TakePhotoFromLibraryAction1CanActionExec(
  Sender: TCustomAction; var CanExec: Boolean);
begin
  CanExec := True;
end;

procedure TCameraFrm.TakePhotoFromLibraryAction1DidCancelTaking;
begin
//
end;

procedure TCameraFrm.TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
begin
  GalleryImage.Bitmap.Assign(Image);
  BtnAddPhoto.Enabled := True;
  if not BtnAddPhoto.Visible then
    BtnPostSmall.Enabled := True; //one pic expected
  if HorzScrollBox1.Visible and (HorzScrollBox1.Content.ChildrenCount = 0) then
    BtnAddPhoto.Action.Execute;
end;

procedure TCameraFrm.TakePhotoFromLibraryAction1Hint(var HintStr: string;
  var CanShow: Boolean);
begin
//
end;

procedure TCameraFrm.TakePhotoFromLibraryAction1Update(Sender: TObject);
begin
//
end;

procedure TCameraFrm.Text1Click(Sender: TObject);
begin
  LayCamPermission.Visible := False;
  TabControl1Change(nil);
end;

procedure TCameraFrm.Timer1Timer(Sender: TObject);
begin
  LayCamPermission.Visible := Assigned(ImgPhoto.Bitmap);
  Timer1.Enabled := False;
end;

procedure TCameraFrm.TxtBtnRetakeClick(Sender: TObject);
begin
  CameraComponent.Active := True;
  LayPostTakePic.Visible := False;
  CamCircleMain.Visible := True;
end;

procedure TCameraFrm.TxtPostBigClick(Sender: TObject);
begin
  CamCircleMain.Visible := True;
  MainForm.PostPicture(ImgPhoto.Bitmap);
end;

procedure TCameraFrm.TxtPostSmallClick(Sender: TObject);
begin
  if MainForm.SelectedItemCategory <> '' then
    FinalStageUpload(MainForm.SelectedItemCategory)
  else
    begin
      if not Assigned(SelectCategoryFrm) then
        SelectCategoryFrm := TSelectCategoryFrm.Create(MainForm);
      SelectCategoryFrm.OnCategorySelect := Circle2Click;
      SelectCategoryFrm.Parent := Self;
      SelectCategoryFrm.Visible := True;
    end;
end;

end.
