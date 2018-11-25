unit InvisibleXFrm;
{$if defined(IOS)}
  {$define UserInvisibleTMS}
{$endif}
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs
{$if defined(UserInvisibleTMS)}
  , FMX.TMSNativeUIView
  , FMX.TMSNativeUIBaseControl
  , FMX.TMSNativeCameraViewController
{$endif}
  ;

type
  TInvisibleFrm = class(TForm)
  private
    { Private declarations }
  public
  end;

var
  InvisibleFrm: TInvisibleFrm;

implementation

uses CameraXFrm, Main;

{$R *.fmx}

end.
