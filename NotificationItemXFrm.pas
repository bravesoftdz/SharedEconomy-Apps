unit NotificationItemXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Math.Vectors, FMX.Objects, uSharedEconomyConsts, FMX.Layouts;

type
  TNotificationItemFrm = class(TFrame)
    Layout43: TLayout;
    ItemImgSlot: TRectangle;
    Layout44: TLayout;
    TxtTop: TText;
    TxtBottom: TText;
    TxtMiddle: TText;
    Circle15: TCircle;
    TxtName: TText;
    FromImgSlot: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FillInfo(Item: TChatItemData);
  end;

implementation

uses Main, System.Net.HttpClient, System.Net.HttpClientComponent
{$IF Defined(IOS) or Defined(OSX)}
  , Macapi.CoreFoundation
{$endif}
  ;


{$R *.fmx}

procedure TNotificationItemFrm.FillInfo(Item: TChatItemData);
begin
  MainForm.DownloadBitmap(Item.ItemPicPath, ItemImgSlot.Fill.Bitmap.Bitmap, DEFAULT_NO_ITEM_RES_IMG);
  if (Item.FromPicPath <> '') then
    MainForm.DownloadBitmap(Item.FromPicPath, ItemImgSlot.Fill.Bitmap.Bitmap, '')
  else
    TxtName.Text := Item.From.Substring(1,1).ToUpper;
end;

end.
