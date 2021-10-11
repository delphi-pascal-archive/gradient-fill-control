unit F_Graphics;

interface

uses
  Windows;

// Gradient drawing modes
// GRADIENT_FILL_RECT_H
// GRADIENT_FILL_RECT_V

type
  PTriVertex = ^TTriVertex;
  TTriVertex = packed record
    x     : Longint;
    y     : Longint;
    Red   : WORD;
    Green : WORD;
    Blue  : WORD;
    Alpha : WORD;
  end;
  
procedure GradientFillRect(DC : HDC; RC : TRect; v1Red, v1Green, v1Blue, v2Red, v2Green, v2Blue : WORD; gMode : DWORD);

implementation

procedure GradientFillRect(DC : HDC; RC : TRect; v1Red, v1Green, v1Blue, v2Red, v2Green, v2Blue : WORD; gMode : DWORD);
var
  V : Array [0..1] of TTriVertex;
  R : TGradientRect;
begin
  V[0].x       := RC.Left;
  V[0].y       := RC.Top;
  V[0].Red     := v1Red;
  V[0].Green   := v1Green;
  V[0].Blue    := v1Blue;
  V[0].Alpha   := 0;
  V[1].x       := RC.Right - RC.Left;
  V[1].y       := RC.Bottom - RC.Top;
  V[1].Red     := v2Red;
  V[1].Green   := v2Green;
  V[1].Blue    := v2Blue;
  V[1].Alpha   := 0;
  R.UpperLeft  := 0;
  R.LowerRight := 1;
  GradientFill(DC, _TriVertex((@V[0])^), 2, @R, 1, gMode);
end;

end.