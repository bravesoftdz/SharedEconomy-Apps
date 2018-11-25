unit uSharedEconomyConsts;

interface

const
  TERMS_CONDITIONS_URL = 'https://se-api.cyberfusion.co/ui/terms.html';
  PRIVACY_URL = 'https://se-api.cyberfusion.co/ui/privacy.html';
  HELP_LOGIN_URL1 = 'https://se-api.cyberfusion.co/ui/help_login.html';
  HELP_URL = 'https://se-api.cyberfusion.co/ui/help.html';
  API_URLS: array [0..1] of String = ('https://se-api.cyberfusion.co/v1', 'http://se-api.cyberfusion.co/v1');
  HARDCODED_KEY = '34287dbgsdpobfyfqwjndi';
  DEFAULT_NO_ITEM_RES_IMG = 'DEFAULT_NO_ITEM_RES_IMG';
  EMAIL_SUBJECT = 'Check out SharedEconomy';
  EMAIL_BODY = 'Check out SharedEconomy app and make cash renting stuff you don''t use at the moment.'#13#10'<a href="DOWNLOAD_LINK">Download';

  MAX_ABOUT_ME_TEXT_LENGTH = 150;
  MIN_PIC_HEIGHT = 170;

  FAndroidServerKey = '63538920422';

  COLOR_FIRERED = $FFFF3F55;
  COLOR_DEFAULT_USER_PHOTO = $FF73BDC5;

type
  TChatItemData = class
    From: String;
    FromPicPath: String;
    ItemPicPath: String;
    ItemName: String;
    ExtraInfo: String;
  end;

  TCamDestination = (cdProfilePhoto, cdProfilePhotoID, cdItemPic);

var
  CMD_TEMPLATE: String = 'https://se-api.cyberfusion.co/v1';

implementation

end.
