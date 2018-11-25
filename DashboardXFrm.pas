unit DashboardXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, DataModule,
  FMX.Gestures, FMX.Effects, FMX.Filter.Effects, FMX.ListBox, FMX.SearchBox,
  MkUtils;

type
  TDashboardFrm = class(TFrame)
    VertScrollBox4: TVertScrollBox;
    CategoryHorizScroll: THorzScrollBox;
    Layout32: TLayout;
    Circle5: TCircle;
    Image22: TImage;
    Text65: TText;
    Layout28: TLayout;
    Circle6: TCircle;
    Image23: TImage;
    Text63: TText;
    Layout30: TLayout;
    Circle7: TCircle;
    Image32: TImage;
    Text66: TText;
    LayCatMotors: TLayout;
    Circle8: TCircle;
    Image25: TImage;
    Text67: TText;
    Layout34: TLayout;
    Circle9: TCircle;
    Image26: TImage;
    Text68: TText;
    Layout35: TLayout;
    Circle10: TCircle;
    Image27: TImage;
    Text69: TText;
    Layout36: TLayout;
    Circle11: TCircle;
    Image28: TImage;
    Text70: TText;
    Layout37: TLayout;
    Circle12: TCircle;
    Image29: TImage;
    Text71: TText;
    Layout38: TLayout;
    Circle13: TCircle;
    Image30: TImage;
    Text72: TText;
    LayCatAuto: TLayout;
    Circle14: TCircle;
    Image31: TImage;
    Text73: TText;
    FilterOptions: THorzScrollBox;
    Rectangle43: TRectangle;
    Image34: TImage;
    LayEnableNotif: TLayout;
    Rectangle33: TRectangle;
    SpeedButton12: TSpeedButton;
    Text64: TText;
    Layout1: TLayout;
    Circle1: TCircle;
    Image1: TImage;
    Text1: TText;
    Layout2: TLayout;
    Circle2: TCircle;
    Image2: TImage;
    Text2: TText;
    Layout3: TLayout;
    Circle3: TCircle;
    Image4: TImage;
    Text3: TText;
    Layout4: TLayout;
    Circle4: TCircle;
    Image5: TImage;
    Text4: TText;
    Layout5: TLayout;
    Circle15: TCircle;
    Image6: TImage;
    Text5: TText;
    LayPopular: TLayout;
    RectBtnLocation: TRectangle;
    Image35: TImage;
    Text78: TText;
    Image3: TImage;
    LayItemZone: TLayout;
    ItemsVerticalScroller: TGridPanelLayout;
    GestureManager1: TGestureManager;
    SpeedButton1: TSpeedButton;
    ImgFilter: TImage;
    InvertEffect1: TInvertEffect;
    LbSearch: TListBox;
    ListBoxHeader1: TListBoxHeader;
    EdSearch: TSearchBox;
    Layout6: TLayout;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    Image7: TImage;
    Text8: TText;
    Image8: TImage;
    Text9: TText;
    TxtInvite: TText;
    TxtCancel: TText;
    LayLeftItemList: TLayout;
    LayRightItemList: TLayout;
    procedure Text64Click(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure VertScrollBox4ViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure EdSearchEnter(Sender: TObject);
    procedure EdSearchExit(Sender: TObject);
    procedure TxtCancelClick(Sender: TObject);
    procedure TxtInviteClick(Sender: TObject);
    procedure EdSearchKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Circle2Click(Sender: TObject);
    procedure VertScrollBox4Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure Image34Click(Sender: TObject);
    procedure EdSearchKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    procedure RepositionControls;
    { Private declarations }
  public
    procedure RecalculateScroller;
    procedure ClearUserInfo;
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses Main, Math, FMX.TabControl, uSharedEconomyConsts;

procedure TDashboardFrm.Circle2Click(Sender: TObject);
begin
  FilterOptions.Visible := True;
  MainForm.FilterCategories(GetSelectedCategory(Sender, ImgFilter));
  CategoryHorizScroll.Visible := False;
  RepositionControls;
end;

procedure TDashboardFrm.ClearUserInfo;
var
  I: Integer;
begin
  for I := LayLeftItemList.ChildrenCount - 1  downto 0 do
    TItemInfo(LayLeftItemList.Children[I].TagObject).Free;
  for I := LayRightItemList.ChildrenCount - 1  downto 0 do
    TItemInfo(LayRightItemList.Children[I].TagObject).Free;
end;

procedure TDashboardFrm.Image34Click(Sender: TObject);
begin
  FilterOptions.Visible := False;
  CategoryHorizScroll.Visible := True;
  CategoryHorizScroll.Position.Y := 0;
  RepositionControls;
  MainForm.FilterCategories('');
end;

procedure TDashboardFrm.EdSearchEnter(Sender: TObject);
begin
  TxtCancel.Visible := True;
  VertScrollBox4.Visible := False;
  LayPopular.Visible := False;
  LbSearch.Align := TAlignLayout.Client;
end;

procedure TDashboardFrm.EdSearchExit(Sender: TObject);
begin
  TxtCancel.Visible := False;
  VertScrollBox4.Visible := True;
  LayPopular.Visible := True;
  LbSearch.Align := TAlignLayout.Top;
  LbSearch.Height := 44;
end;

procedure TDashboardFrm.EdSearchKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  EdSearchEnter(nil);
end;

procedure TDashboardFrm.EdSearchKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  MainForm.FormKeyUp(Sender, Key, KeyChar, Shift);
end;

procedure TDashboardFrm.FrameResize(Sender: TObject);
begin
  if not Boolean(Tag) then
    RecalculateScroller;
{$IF not defined(MSWINDOWS) and not defined(OSX)}
  Tag := 1;
{$ENDIF}
end;

procedure TDashboardFrm.RecalculateScroller;
var
  I: Integer;
  Rect: TRectangle;
  MaxY: Single;
begin
  MaxY := 0;
  for I := 0 to LayLeftItemList.ChildrenCount - 1 do
    begin
      Rect := TRectangle(LayLeftItemList.Children[I]);
      Rect.Height := Rect.Width / (Rect.Fill.Bitmap.Bitmap.Width / Rect.Fill.Bitmap.Bitmap.Height);
      MaxY := Max(MaxY, Rect.Position.Y + Rect.Height);
    end;
  for I := 0 to LayRightItemList.ChildrenCount - 1 do
    begin
      Rect := TRectangle(LayRightItemList.Children[I]);
      Rect.Height := Rect.Width / (Rect.Fill.Bitmap.Bitmap.Width / Rect.Fill.Bitmap.Bitmap.Height);
      MaxY := Max(MaxY, Rect.Position.Y + Rect.Height);
    end;
  LayItemZone.Height := MaxY + 10;
end;

procedure TDashboardFrm.Text64Click(Sender: TObject);
begin
  MainForm.ShowNotificationConfirmDialog;
end;

procedure TDashboardFrm.TxtInviteClick(Sender: TObject);
begin
  MainForm.LayInviteFriends.Visible := True;
  MainForm.LayInviteFriends.BringToFront;
end;

procedure TDashboardFrm.TxtCancelClick(Sender: TObject);
begin
  EdSearch.Text := '';
  EdSearchExit(nil);
  MainForm.tcMain.ActiveTab.SetFocus;
end;

var
  PrevScrollPos: Single;

procedure TDashboardFrm.VertScrollBox4Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TDashboardFrm.RepositionControls;
begin
  LayPopular.Position.Y := 0;
  if VertScrollBox4.ViewportPosition.Y < PrevScrollPos then
    begin
      LbSearch.Visible := True;
      MainForm.tcMain.TabPosition := TTabPosition.Bottom;
      if VertScrollBox4.ViewportPosition.Y < LayItemZone.Position.Y then
        LayPopular.Parent := LayItemZone
      else
        LayPopular.Position.Y := LbSearch.Height;
      MainForm.LayBtnRentYourStuff.Margins.Bottom := 5 + MainForm.tcMain.TabHeight;
    end
  else
    if VertScrollBox4.ViewportPosition.Y > (CategoryHorizScroll.Height + Integer(LayEnableNotif.Visible) * LayEnableNotif.Height) then
      begin
        LbSearch.Visible := False;
        LayPopular.Parent := Self;
        MainForm.tcMain.TabPosition := TTabPosition.None;
        MainForm.LayBtnRentYourStuff.Margins.Bottom := 5;
      end
    else
      begin
        LayPopular.Parent := LayItemZone;
      end;

  PrevScrollPos := VertScrollBox4.ViewportPosition.Y;
end;

procedure TDashboardFrm.VertScrollBox4ViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
  if OldViewportPosition = NewViewportPosition then
    Exit;
  RepositionControls;
end;

end.
