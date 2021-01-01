// Author:  helltar
// Created: 21.02.2015 03:45:14

unit uGame;

interface

{ public declarations }

procedure Menu;
procedure RunGame;

implementation

{ add unit functions & procedures here }

uses
  uCore,
  uRect,
  uPlatfrm;

var
  Level: integer;

procedure Cls;
begin
  SetColor(0, 0, 0);
  FillRect(0, 0, SW, SH);
end;

procedure CheckLevel(AScore: integer);
begin
  if AScore = 100 then
    Level := 3;
  if AScore = 200 then
    Level := 4;
  if AScore = 300 then
    Level := 5;
  if AScore = 400 then
    Level := 6;
  if AScore = 500 then
    Level := 7;
  if AScore = 600 then
    Level := 8;
end;

procedure DrawGameInfo;
const
  L_MARG = 32;
  T_MARG = 20;

var
  sLife, sScore, sLevel: string;

begin
  sLife := 'Life: ' + IntegerToString(Life);
  sScore := 'Score: ' + IntegerToString(Score);
  sLevel := 'Level: ' + IntegerToString(Level);

  SetColor(255, 255, 255);

  DrawText(sLife, SW - GetStringWidth(sLife) - L_MARG, T_MARG * 2);
  DrawText(sScore, SW - GetStringWidth(sScore) - L_MARG, T_MARG * 3);
  DrawText(sLevel, SW - GetStringWidth(sLevel) - L_MARG, T_MARG * 4);
end;

procedure DrawCubes;
begin
  DrawBox(Level);
  DrawBomb(Level);
  DrawBonus(Level + 1);
end;

function IsGameOver: boolean;
begin
  Result := Life <= 0;
end;

procedure start;
var
  key: integer;
  out: boolean;

begin
  out := false;

  repeat
    SetColor(255, 255, 255);
    FillRect(0, 0, getWidth, getHeight);

    Repaint;
    Delay(20);

    key := getKeyClicked;

    if KEY = KE_KEY0 then
      out := true;

    key := keyToAction(key);
  until out;
end;

procedure Menu;
var
  key, pos, i, hh: integer;
  menu: array[1..4] of string;

begin
  pos := 1;
  hh := getHeight / 10;

  menu[1] := 'Играть';
  menu[2] := 'Выход';

  repeat
    SetColor(255, 255, 255);
    FillRect(0, 0, getWidth, getHeight);

    for i := 0 to 10 do
    begin
      FillRect(0, i * hh, getWidth, hh);
    end;

    for i := 1 to 2 do
    begin
      if i = pos then
      begin
        SetColor(33, 33, 33);
        FillRoundRect(-20, i * 30 + 20, getWidth - 40, 25, 20, 20);
        SetColor(255, 255, 255);
        DrawText(menu[i], 20, i * 30 + 20);
      end
      else
      begin
        SetColor(33, 33, 33);
        FillRoundRect(-20, i * 30 + 20, getWidth - 60, 25, 20, 20);
        SetColor(255, 255, 255);
        DrawText(menu[i], 5, i * 30 + 20);
      end;
    end;

    SetColor(0, 0, 0);
    DrawText('CatchRect', 20, 10);

    Repaint;
    Delay(20);

    key := getKeyClicked;
    key := keyToAction(key);

    if key = GA_UP then
      if pos = 1 then
        pos := 2
      else
        pos := pos - 1;

    if key = GA_DOWN then
      if pos = 2 then
        pos := 1
      else
        pos := pos + 1;

    if key = GA_FIRE then
    begin
      if pos = 1 then
        repeat
          RunGame;
        until false;

      if pos = 2 then
        halt;
    end;
  until false;
end;

procedure DrawGOS; // game over screen
const
  GAME_OVER = 'Game Over';

begin
  Cls;
  SetColor(255, 20, 20);
  SetFont(FONT_FACE_PROPORTIONAL, FONT_STYLE_BOLD, FONT_SIZE_LARGE);
  DrawText(GAME_OVER, (GetWidth - GetStringWidth(GAME_OVER)) div 2, 100);
  Refresh;
  Delay(5000);
  Menu;
end;

procedure RunGame;
begin
  Cls;
  DrawCubes;
  MovePlatfrm;
  DrawGameInfo;
  CheckLevel(Score);

  if IsGameOver then
    DrawGOS;

  Refresh;
end;

initialization

  { add initialization code here }

  Level := 2;

end.

