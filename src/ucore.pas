// Author:  helltar
// Created: 21.02.2015 03:13:33

unit uCore;

interface

{ public declarations }

var
  SH, SW: integer;

procedure Refresh;

implementation

{ add unit functions & procedures here }

procedure Refresh;
begin
  Repaint;
  Delay(24);
end;

initialization

  { add initialization code here }

  SH := GetHeight;
  SW := GetWidth;

end.

