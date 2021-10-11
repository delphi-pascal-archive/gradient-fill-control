program sample;

{$R sample.res}

uses
  Windows, Messages, F_Graphics, Dialogs;

const
  RC_GENERAL_DIALOG  = 101;
  RC_ICON_RESOURCE   = 101;
  ID_GRADIENT_STATIC = 101;
  ID_STATIC_GLIFICON = 102;
  ID_STATIC_VERTEXT  = 103;

var
  hApp : Thandle;
  tFont : hFont;
  hImIco : hIcon;

{}
function MainDlgProc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : BOOL; stdcall;
var
  PS   : TPaintStruct;
  Rect : TRect;
begin
  Result := FALSE;
  case uMsg of

    {}
    WM_INITDIALOG :
      begin
        hApp := hWnd;
        {}
        hImIco := LoadImage(hInstance, MAKEINTRESOURCE(RC_ICON_RESOURCE), IMAGE_ICON, 32, 32, LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        if hImIco <> 0 then
          begin
            SendMessage(hApp, WM_SETICON, ICON_SMALL, hImIco);
            SendMessage(GetDlgItem(hApp, ID_STATIC_GLIFICON), STM_SETIMAGE, IMAGE_ICON, hImIco);
          end;
        {}
        tFont := CreateFontW(13, 0, 0, 0, 800, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if tFont <> 0 then
          SendMessage(GetDlgItem(hApp, ID_STATIC_VERTEXT), WM_SETFONT, Integer(tFont), Integer(TRUE));
      end;

    {}
    WM_CTLCOLORSTATIC :
      begin
        SetBkMode(wParam, TRANSPARENT);
        SetBkColor(wParam, TRANSPARENT);
        SetTextColor(wParam, GetSysColor(COLOR_WINDOWTEXT));
        Result := LongBool(GetStockObject(NULL_BRUSH));
        exit;
      end;

    {}
    WM_PAINT :
      begin
        {}
        GetClientRect(GetDlgItem(hApp, ID_GRADIENT_STATIC), Rect);
        {}
        BeginPaint(GetDlgItem(hApp, ID_GRADIENT_STATIC), PS);
        {}
        FillRect(PS.HDC, Rect, GetStockObject(WHITE_BRUSH));
        {}
        GradientFillRect(PS.HDC, Rect, $FF00, $FF00, $FF00, $D200, $DC00, $F900, GRADIENT_FILL_RECT_H);
        {}
        SetBkMode(PS.HDC, TRANSPARENT);
        SetBkColor(PS.HDC, TRANSPARENT);
        SetTextColor(PS.HDC, GetSysColor(COLOR_WINDOWTEXT));
        {}
        Rect.Left := Rect.Left + 10;
        Rect.Right := Rect.Right - 10;
        Rect.Top := Rect.Top + 5;
        Rect.Bottom := Rect.Bottom - 8;
        {}
        EndPaint(GetDlgItem(hApp, ID_GRADIENT_STATIC), PS);
        Result := FALSE;
      end;

    {}
    WM_LBUTTONDOWN :
      begin
        SetCursor(LoadImage(0, IDC_SIZEALL, IMAGE_CURSOR, 32, 32, LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS or LR_SHARED));
        SendMessage(hApp, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
      end;

    {}
    WM_DESTROY, WM_CLOSE :
      begin
        if hImIco <> 0 then
          DeleteObject(hImIco);
        {}
        if tFont <> 0 then
          DeleteObject(tFont);
        PostQuitMessage(0);
      end;
  end;
end;

begin
  {}
  DialogBox(0, MAKEINTRESOURCE(RC_GENERAL_DIALOG), 0, @MainDlgProc);
end.
