unit SelectCategoryXFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts;

type
  TSelectCategoryFrm = class(TFrame)
    RectCategorySelection: TRectangle;
    Text8: TText;
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
    Layout2: TLayout;
    Circle1: TCircle;
    Image2: TImage;
    Text10: TText;
    Layout4: TLayout;
    Circle2: TCircle;
    Image5: TImage;
    Text11: TText;
    Layout5: TLayout;
    Circle3: TCircle;
    Image6: TImage;
    Text12: TText;
    Layout8: TLayout;
    Circle4: TCircle;
    Image7: TImage;
    Text13: TText;
    Layout9: TLayout;
    Circle15: TCircle;
    Image8: TImage;
    Text14: TText;
    procedure DoCategorySelect(Sender: TObject);
  private
    { Private declarations }
    FOnCategorySelect: TNotifyEvent;
  published
    property OnCategorySelect: TNotifyEvent read FOnCategorySelect write FOnCategorySelect;
  public
    { Public declarations }
  end;
var
  SelectCategoryFrm: TSelectCategoryFrm;

implementation

{$R *.fmx}

procedure TSelectCategoryFrm.DoCategorySelect(Sender: TObject);
begin
  if Assigned(FOnCategorySelect) then
    FOnCategorySelect(Sender);
end;

end.
