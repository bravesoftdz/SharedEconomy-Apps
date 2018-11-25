unit DataModule;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, FMX.ImgList, FMX.Types,
  FMX.Controls;

type
  TDataModule1 = class(TDataModule)
    ImageList1: TImageList;
    SESpecificImages: TImageList;
    WhiteStyleBook: TStyleBook;
    ImgListDEMO_DELETE: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
