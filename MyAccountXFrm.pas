unit MyAccountXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.TabControl, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, System.ImageList, FMX.ImgList, DataModule, FMX.Ani;

type
  TMyAccountFrm = class(TFrame)
    Layout4: TLayout;
    SpeedButton5: TSpeedButton;
    LayTopAccountPageTitle: TLayout;
    TxtUsernameTop: TText;
    Layout19: TFlowLayout;
    Image15: TImage;
    VertScrollBox4: TVertScrollBox;
    Layout5: TLayout;
    Layout6: TLayout;
    TxtCAUsername: TText;
    TxtCALocation: TText;
    Circle1: TCircle;
    TxtFirstLetter: TText;
    RectScoringPanel: TRectangle;
    Rectangle2: TRectangle;
    Layout7: TLayout;
    ImgSmallBadge: TImage;
    RectTrack: TRectangle;
    RectTrackPos: TRectangle;
    RectTrackIndicator: TRectangle;
    TxtTrackPosValue: TText;
    Text14: TText;
    Layout9: TLayout;
    Text16: TText;
    TxtScore: TText;
    Layout8: TLayout;
    Text19: TText;
    Text20: TText;
    Text15: TText;
    Layout10: TLayout;
    Text21: TText;
    Image5: TImage;
    Line1: TLine;
    Image4: TImage;
    Text17: TText;
    Image1: TImage;
    Image2: TImage;
    Image7: TImage;
    Image8: TImage;
    Image6: TImage;
    Text1: TText;
    Image9: TImage;
    TxtMoreAboutMe: TText;
    ImgBigBadge: TImage;
    Image11: TImage;
    FloatAnimation1: TFloatAnimation;
    LayEnableNotif: TLayout;
    Rectangle33: TRectangle;
    SpeedButton12: TSpeedButton;
    Text64: TText;
    SpeedButton1: TSpeedButton;
    TxtNoItems: TText;
    ListItemsTC: TTabControl;
    RentingTab: TTabItem;
    RentingScroller: TGridPanelLayout;
    LayRentingRight: TLayout;
    LayRentingLeft: TLayout;
    RentedTab: TTabItem;
    FavTab: TTabItem;
    ReviewsTab: TTabItem;
    RentedScroller: TGridPanelLayout;
    LayRentedRight: TLayout;
    LayRentedLeft: TLayout;
    FavoritesScroller: TGridPanelLayout;
    LayFavRight: TLayout;
    LayFavLeft: TLayout;
    procedure VertScrollBox4ViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure Text22Click(Sender: TObject);
    procedure VertScrollBox4Resize(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure Layout10Click(Sender: TObject);
    procedure Text64Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure ListItemsTCChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RecalculateScroller;
  end;

implementation

uses Math, Main, uSharedEconomyConsts;

{$R *.fmx}

procedure TMyAccountFrm.SpeedButton4Click(Sender: TObject);
begin
  MainForm.ShowSettings(Self);
end;

procedure TMyAccountFrm.Text22Click(Sender: TObject);
begin
  MainForm.ShowNotificationConfirmDialog;
end;

procedure TMyAccountFrm.Text64Click(Sender: TObject);
begin
  MainForm.ShowNotificationConfirmDialog;
end;

procedure TMyAccountFrm.FloatAnimation1Finish(Sender: TObject);
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  MainForm.AssignBmpIndexToImg(Bmp, 27, DataModule1.SESpecificImages);
  Image9.Bitmap.Assign(Bmp);
end;

procedure TMyAccountFrm.Image11Click(Sender: TObject);
begin
  MainForm.OpenCamera(Self, '', cdProfilePhoto);
end;

procedure TMyAccountFrm.Image9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  Bmp: TBitmap;
begin
  Image9.Tag := 1 - Image9.Tag;
  Bmp := TBitmap.Create;
  MainForm.AssignBmpIndexToImg(Bmp, 28, DataModule1.SESpecificImages);
  Image9.Bitmap.Assign(Bmp);
  FloatAnimation1.Inverse := Boolean(Image9.Tag);
  FloatAnimation1.Start;
  TxtMoreAboutMe.Visible := FloatAnimation1.Inverse;
end;

procedure TMyAccountFrm.Layout10Click(Sender: TObject);
begin
  MainForm.ShowSettings(Self, 8{MainForm.SettingsFrm.EarnPointsTab});
end;

procedure TMyAccountFrm.ListItemsTCChange(Sender: TObject);
begin
  TxtNoItems.Visible := (ListItemsTC.ActiveTab <> ReviewsTab) and
    (ListItemsTC.ActiveTab.Children[1].Children[0].Children[0].ChildrenCount +
      ListItemsTC.ActiveTab.Children[1].Children[0].Children[1].ChildrenCount = 0);
  TxtNoItems.Position.Y := ListItemsTC.Position.Y - 1;
end;

procedure TMyAccountFrm.RecalculateScroller;
var
  HPadding: Single;
begin
  HPadding := 10 + ListItemsTC.TabHeight + Integer(LayEnableNotif.Visible) * LayEnableNotif.Height;
  ListItemsTC.Height := HPadding +
  Max(
    Max(
      Max(LayRentingLeft.Tag, LayRentingRight.Tag),
      Max(LayRentedLeft.Tag, LayRentedRight.Tag)
    ),
    Max(LayFavLeft.Tag, LayFavRight.Height)
   );
end;

procedure TMyAccountFrm.VertScrollBox4Resize(Sender: TObject);
begin
  if not Boolean(Tag) then
    RecalculateScroller;
{$IF not defined(MSWINDOWS) and not defined(OSX)}
  Tag := 1;
{$ENDIF}
end;

procedure TMyAccountFrm.VertScrollBox4ViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
  LayTopAccountPageTitle.Opacity := Max(0, Min(1, VertScrollBox4.ViewportPosition.Y/100));
end;

end.
