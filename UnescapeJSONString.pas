unit UnescapeJSONString;

interface
uses
  System.JSON;

type
  TUnescapeJSONString = class(TJSONString)
  private
  public
    constructor Create(const AValue: string); overload;
    class function UnescapeValue(const AValue: string): string;
    function EscapeValue(const AValue: string): string;
  end;

implementation
uses
  System.SysUtils;

  { TSvJsonString }

constructor TUnescapeJSONString.Create(const AValue: string);
begin
  inherited Create(UnescapeValue(AValue));
end;

function TUnescapeJSONString.EscapeValue(const AValue: string): string;

  procedure AddChars(const AChars: string; var Dest: string; var AIndex: Integer); inline;
  begin
    System.Insert(AChars, Dest, AIndex);
    System.Delete(Dest, AIndex + 2, 1);
    Inc(AIndex, 2);
  end;

  procedure AddUnicodeChars(const AChars: string; var Dest: string; var AIndex: Integer); inline;
  begin
    System.Insert(AChars, Dest, AIndex);
    System.Delete(Dest, AIndex + 6, 1);
    Inc(AIndex, 6);
  end;

var
  i, ix: Integer;
  AChar: Char;
begin
  Result := AValue;
  ix := 1;
  for i := 1 to System.Length(AValue) do
  begin
    AChar :=  AValue[i];
    case AChar of
      '/', '\', '"':
      begin
        System.Insert('\', Result, ix);
        Inc(ix, 2);
      end;
      #8:  //backspace \b
      begin
        AddChars('\b', Result, ix);
      end;
      #9:
      begin
        AddChars('\t', Result, ix);
      end;
      #10:
      begin
        AddChars('\n', Result, ix);
      end;
      #12:
      begin
        AddChars('\f', Result, ix);
      end;
      #13:
      begin
        AddChars('\r', Result, ix);
      end;
      #0 .. #7, #11, #14 .. #31:
      begin
        AddUnicodeChars('\u' + IntToHex(Word(AChar), 4), Result, ix);
      end
      else
      begin
        if Word(AChar) > 127 then
        begin
          AddUnicodeChars('\u' + IntToHex(Word(AChar), 4), Result, ix);
        end
        else
        begin
          Inc(ix);
        end;
      end;
    end;
  end;
end;

class function TUnescapeJSONString.UnescapeValue(const AValue: string): string;
begin
  if (Length(AValue) > 2) and (Copy(AValue, 1, 1) = '"') then
     Result := Copy(AValue, 2, length(AValue) - 2)
  else
      Result := AValue;
end;

end.
