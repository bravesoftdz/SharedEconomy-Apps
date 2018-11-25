unit ItemInfoXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Math.Vectors, FMX.Controls.Presentation, FMX.Objects, FMX.Controls3D,
  FMX.Layers3D, FMX.Layouts, FMX.Effects, FMX.TabControl, DataModule, FMX.ImgList,
  FMX.Maps, FMX.Ani, MkUtils;

type
  TItemInfoFrm = class(TFrame)
    LayTop: TLayout;
    HorzScrollBox3: THorzScrollBox;
    Rectangle48: TRectangle;
    Text95: TText;
    Rectangle49: TRectangle;
    Image37: TImage;
    Text96: TText;
    Rectangle50: TRectangle;
    Text97: TText;
    Rectangle51: TRectangle;
    Text98: TText;
    Rectangle52: TRectangle;
    Text99: TText;
    Rectangle53: TRectangle;
    Text100: TText;
    LayItemBasicInfo: TLayout;
    Layout44: TLayout;
    TxtPrice: TText;
    Layout3D2: TLayout3D;
    TxtTitle: TText;
    Layout3D3: TLayout3D;
    Circle15: TCircle;
    TxtFistLetterUsername: TText;
    ImgSelectToFavorite: TImage;
    RectShare: TRectangle;
    Text3: TText;
    Image4: TImage;
    SbClose: TSpeedButton;
    LayTop2: TLayout;
    RectBtnLocation: TRectangle;
    Text78: TText;
    Image35: TImage;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    ImgRemoveFromFavorite: TImage;
    ImgItem: TImage;
    TrackBar1: TTrackBar;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    RectItemDetail: TRectangle;
    MapView1: TMapView;
    Layout3: TLayout;
    TxtLocation: TText;
    Glyph1: TGlyph;
    TxtDistance: TText;
    Layout4: TLayout;
    TxtItemAge: TText;
    Glyph2: TGlyph;
    TxtViews: TText;
    Glyph3: TGlyph;
    RectAge: TRectangle;
    Rectangle5: TRectangle;
    ItemDetailFloatAnimation: TFloatAnimation;
    RectEdit: TRectangle;
    Text1: TText;
    Glyph4: TGlyph;
    procedure ImgRemoveFromFavoriteClick(Sender: TObject);
    procedure ImgSelectToFavoriteClick(Sender: TObject);
    procedure SbCloseClick(Sender: TObject);
    procedure Text78Click(Sender: TObject);
    procedure ItemDetailFloatAnimationFinish(Sender: TObject);
    procedure Text96Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ImgItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ImgItemMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Text1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ItemInfo: TItemInfo;
  end;

implementation

uses Main, Math, ChatXFrm;

{$R *.fmx}

var
  LastMMY, LastMMX: Single;


procedure TItemInfoFrm.ImgItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  LastMMY := Y;
  LastMMX := X;
end;

procedure TItemInfoFrm.ImgItemMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Y - LastMMY < -20 then
    TrackBar1.Value := Round(TrackBar1.Value + 1) mod Round(TrackBar1.Max + 1);
  if Y - LastMMY > 20 then
    TrackBar1.Value := Round(TrackBar1.Value + TrackBar1.Max) mod Round(TrackBar1.Max + 1);
end;

procedure TItemInfoFrm.ImgRemoveFromFavoriteClick(Sender: TObject);
begin
  ImgRemoveFromFavorite.Visible := False;
  ImgSelectToFavorite.Visible := True;
  MainForm.RemoveFromFav(ItemInfo);
end;

procedure TItemInfoFrm.ImgSelectToFavoriteClick(Sender: TObject);
begin
  ImgRemoveFromFavorite.Visible := True;
  ImgSelectToFavorite.Visible := False;
  MainForm.AddToFav(ItemInfo);
end;

procedure TItemInfoFrm.ItemDetailFloatAnimationFinish(Sender: TObject);
begin
  RectItemDetail.Align := TAlignLayout.Client;
end;

procedure TItemInfoFrm.SbCloseClick(Sender: TObject);
begin
  if RectItemDetail.Visible then
    begin
      LayTop.Parent := Self;
      RectItemDetail.Visible := False;
      RectBtnLocation.Visible := True;
      //RectShare.Visible := True;
      LayTop.Padding.Left := 0;
      LayTop.Padding.Right := 0;
    end
  else
    MainForm.CloseMoreInfo;
end;

procedure TItemInfoFrm.Text1Click(Sender: TObject);
begin
  MainForm.EditItem(ItemInfo);
end;

procedure TItemInfoFrm.Text78Click(Sender: TObject);
begin
  LayTop.Parent := RectItemDetail;
  RectShare.Visible := False;
  RectBtnLocation.Visible := False;
  RectItemDetail.Align := TAlignLayout.None;
  RectItemDetail.Height := LayItemBasicInfo.Position.Y - 10;
  RectItemDetail.Width := ImgItem.Width;

  ItemDetailFloatAnimation.StartValue := -RectItemDetail.Height;
  ItemDetailFloatAnimation.StopValue := 0;
  RectItemDetail.Visible := True;
  LayTop.Padding.Left := -20;
  LayTop.Padding.Right := -20;
end;

procedure TItemInfoFrm.Text96Click(Sender: TObject);
var
  UserID: Integer;
  ChatMessage: String;
  ChatInfo: TChatInfo;
begin
  ChatMessage := TText(Sender).Text;
  MainForm.RectTopNotifWnd.Visible := False;
  if Assigned(ItemInfo) then
    begin
      if Assigned(ItemInfo.owner) then
        UserID := ItemInfo.owner.id
      else
        UserID := 0;
      MainForm.SendMessageTo(
        UserID,
        ItemInfo.id,
        ChatMessage
      );
      ChatInfo := TChatInfo.Create;
      ChatInfo.ItemInfo := ItemInfo;
      ChatInfo.message := ChatMessage;
      MainForm.AddChat(ChatInfo, [cmtSent]);
    end
  else
    MainForm.SendMessageTo(
      0,
      0,
      ChatMessage
    );

  MainForm.DisplayTopNotification('Private Message', Format('Message has been sent: %s', [TText(Sender).Text]));
end;

procedure TItemInfoFrm.TrackBar1Change(Sender: TObject);
begin
  if not Assigned(ItemInfo) then
    TrackBar1.Visible := False
  else
    ImgItem.Bitmap.Assign(ItemInfo.Photos[Round(TrackBar1.Value)]);
end;

end.
