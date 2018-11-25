unit ItemEditXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Ani;

type
  TItemEditFrm = class(TForm)
    LayHeader: TLayout;
    TxtHeader: TText;
    Image3: TImage;
    FloatAnimation1: TFloatAnimation;
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DoCreate;
  end;

var
  ItemEditFrm: TItemEditFrm;

implementation

{$R *.fmx}

uses DataModule;

{ TItemEditFrm }

procedure TItemEditFrm.DoCreate;
var
  Size: TSizeF;
begin
  Image3.Bitmap.Assign(DataModule1.SESpecificImages.Bitmap(Size, 7));
end;

procedure TItemEditFrm.FloatAnimation1Finish(Sender: TObject);
begin
  Visible := not FloatAnimation1.Inverse;
end;

end.
