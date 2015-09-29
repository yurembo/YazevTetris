(*********************************YazevTetris 2********************************)
(***************************developed by Yazev Yuriy***************************)
(*****************YazevSoft*****************************Yazev's Game***********)
(*******************************17.06.2006 : begin*****************************)
(*******************************16.08.2006 : end*******************************)
(***********************************some history*******************************)
(***********this game is continuing the Yazev's game generation line***********)
(***this is the second part*the first part I began develop at the end of 2004**)
(**********I didn't finish this while, but I will create this...Yeah!!!********)
(********************now 2006***now it's time to YazevTetris 2*****************)
(****using OpenGL for graphics output****using Windows messages for control****)
(*****************developing again after long pause : 25.07.2006***************)

(*19.08.2006 : modified*)

unit YazevTetris2Cod1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OpenGL, AppEvnts, ExtCtrls, StdCtrls;

type
  TYazevBuilding = class(TForm)
    YazevAE: TApplicationEvents;
    YazevTimer: TTimer;
    YazevTransformator: TTimer;
    YazevGameStartButton: TButton;
    YazevGamePauseButton: TButton;
    YazevGameExitButton: TButton;
    YazevGameResetButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure YazevAEIdle(Sender: TObject; var Done: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure YazevTimerTimer(Sender: TObject);
    procedure YazevTransformatorTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure YazevGameStartButtonClick(Sender: TObject);
    procedure YazevGameExitButtonClick(Sender: TObject);
    procedure YazevGamePauseButtonClick(Sender: TObject);
    procedure YazevGameResetButtonClick(Sender: TObject);
  private
    { Private declarations }
    DC : HDC;
    rc : HGLRC;
    lf : LOGFONT;
    heFont, hOldFont : HFont;
    ActiveGL : Bool;
    procedure Setup_OpenGL;
    procedure Create_Environment;
    procedure Destroy_Environment;
    procedure Draw_to_Window;
    procedure Draw_Glass;
    procedure Create_Shape;
    procedure CreateNextShape;
    procedure DestroyNextShape;
    procedure Check_Glass_to_Full;
    procedure Init_TextGL;
    procedure Output_TextGL(number : Integer);
    procedure Output_TextGL2;
    procedure Output_TextGL3;
    procedure Output_TextGL4;
    procedure Output_TextGL5;
    procedure Output_TextGL6;
    procedure Output_TextGL7;
    procedure Output_TextGL8;
    procedure Create_Buttons;
  public
    { Public declarations }
    Game, first_click, Game_Over, kind : Bool;
    level : Integer;
  end;

  type
    TYazevSquare = class
    xpos, ypos, size, zdeg : GLFloat;
    exist, falling : Bool;
    kind : Integer;
    constructor MakeUP(i, view : Integer; x, y : GLFloat);
    destructor KillDOWN(i : Integer);
    procedure Draw(i : Integer);
  end;

  type
    TYazevStick = class
    xpos, ypos, zdeg, lxpos, lypos : GLFloat;
    exist, falling : Bool;
    form : Integer;
    squares : Array [0..3] of TYazevSquare;
    constructor Create; virtual;
    destructor Kill_Out; virtual;
    procedure Draw; virtual;
    procedure TRans; dynamic;
    procedure TRans2; dynamic;
    procedure ReCreate; virtual;
    procedure MoveX(moveleft : Bool); virtual;
    procedure Transformation(number : Integer); virtual;
  end;

  type
    TYazevCube = class(TYazevStick)
    constructor Create; override;
    destructor Kill_Out; override;
    procedure Draw; override;
    procedure ReCreate; override;
    procedure MoveX(moveleft : Bool); override;
    procedure Transformation(number : Integer); override;
  end;

  type
    TYazevShape = class(TYazevStick)
     constructor Create; override;
     destructor Kill_Out; override;
     procedure Draw; override;
     procedure ReCreate; override;
     procedure MoveX(moveleft : Bool); override;
     procedure Transformation(number : Integer); override;
     procedure Trans; override;
     procedure Trans2; override;
  end;

  type
    TYazevLPoker = class(TYazevStick)
     constructor Create; override;
     destructor Kill_Out; override;
     procedure Draw; override;
     procedure ReCreate; override;
     procedure MoveX(moveleft : Bool); override;
     procedure Transformation(number : Integer); override;
     procedure Trans; override;
     procedure Trans2; override;
  end;

  type
    TYazevRPoker = class(TYazevStick)
    constructor Create; override;
    destructor Kill_Out; override;
    procedure Draw; override;
    procedure ReCreate; override;
    procedure MoveX(moveleft : Bool); override;
    procedure Transformation(number : Integer); override;
    procedure Trans; override;
    procedure Trans2; override;
  end;

  type
    TYazevLZigZag = class(TYazevStick)
     constructor Create; override;
     destructor Kill_Out; override;
     procedure Draw; override;
     procedure ReCreate; override;
     procedure MoveX(moveleft : Bool); override;
     procedure Transformation(number : Integer); override;
     procedure Trans; override;
     procedure Trans2; override;
  end;

  type
    TYazevRZigZag = class(TYazevStick)
      constructor Create; override;
      destructor Kill_Out; override;
      procedure Draw; override;
      procedure ReCreate; override;
      procedure MoveX(moveleft : Bool); override;
      procedure Transformation(number : Integer); override;
      procedure Trans; override;
      procedure Trans2; override;
    end;

     type
       TYazevDemoStick = class(TYazevStick)
       constructor Create; override;
       destructor Kill_Out; override;
       procedure ReDraw;
     end;

     type
       TYazevDemoCube = class(TYazevCube)
       constructor Create; override;
       destructor Kill_Out; override;
       procedure ReDraw;
     end;

     type
       TYazevDemoShape = class(TYazevShape)
       constructor Create; override;
       destructor Kill_Out; override;
       procedure ReDraw;
      end;

      type
        TYazevDemoLPoker = class(TYazevLPoker)
        constructor Create; override;
        destructor Kill_Out; override;
        procedure ReDRaw;
      end;

      type
        TYazevDemoRPoker = class(TYazevRPoker)
        constructor Create; override;
        destructor Kill_Out; override;
        procedure ReDraw;
      end;

      type
        TYazevDemoLZigZag = class(TYazevLZigZag)
        constructor Create; override;
        destructor Kill_Out; override;
        procedure ReDraw;
      end;

      type
        TYazevDemoRZigZag = class(TYazevRZigZag)
        constructor Create; override;
        destructor Kill_Out; override;
        procedure ReDraw;
      end;

    const
     square_list = 1;
     square_block = 2;
     square_block_2 = 3;
     distance = 0.10073;
     left_glass_edge = -0.068;   // for square
     bottom_glass_edge = -0.848; // for square
     right_glass_edge = 0.84;    // for square

     cxpos = left_glass_edge;
     cypos = 1.0;

     dxpos = -0.7;
     dypos = -0.1;

     GL_LETTERS = 1000;

     MaxCounts = 300;

     speed = 0.0005;

var
  YazevBuilding: TYazevBuilding;
   square : Array of TYazevSquare; // 10 штук в ширину
                                   // 18 - в высоту
   MaxSquares : Integer = 0;

   speed_down : Double = 0.001;
   start_speed : Double = 0.001;
   acc : Bool = false;
   divisor : Double = 5;

   count : Integer = 0;

   delay : Bool = False;

   stick : TYazevStick = nil;
   cube : TYazevCube = nil;
   shape : TYazevShape = nil;
   lpoker : TYazevLPoker = nil;
   rpoker : TYazevRPoker = nil;
   lzigzag : TYazevLZigZag = nil;
   rzigzag : TYazevRZigZag = nil;

   dstick : TYazevDemoStick = nil;
   dcube : TYazevDemoCube = nil;
   dshape : TYazevDemoShape = nil;
   dlpoker : TYazevDemoLPoker = nil;
   drpoker : TYazevDemoRPoker = nil;
   dlzigzag : TYazevDemoLZigZag = nil;
   drzigzag : TYazevDemoRZigZag = nil;

implementation

{$R *.DFM}

{ TYazevBuilding }

procedure TYazevBuilding.Setup_OpenGL;
var
pfd : TPixelFormatDescriptor;
zPixel : Integer;
begin
FillChar(pfd, SizeOf(pfd), 0);
pfd.dwFlags := PFD_DRAW_TO_WINDOW OR PFD_SUPPORT_OPENGL OR PFD_DOUBLEBUFFER;
pfd.cColorBits := 32;
zPixel := ChoosePixelFormat(DC, @pfd);
SetPixelFormat(DC, zPixel, @pfd);
end;

procedure TYazevBuilding.FormCreate(Sender: TObject);
begin
first_click := true;
DC := GetDC(Handle);
Setup_OpenGL;
rc := wglCreateContext(DC);
wglMakeCurrent(DC, rc);
WindowState := wsMaximized;
ActiveGL := True;
Create_Environment;
Init_TextGL;
Game := false;
Game_Over := false;
kind := false;
end;

procedure TYazevBuilding.FormDestroy(Sender: TObject);
begin
ActiveGL := False;
Destroy_Environment;
DeleteObject(SelectObject(DC, hOldFont));
glDeleteLists(GL_LETTERS, 256);
wglMakeCurrent(0, 0);
wglDeleteContext(rc);
ReleaseDC(Handle, DC);
DeleteDC(DC);
end;

procedure TYazevBuilding.FormResize(Sender: TObject);
begin
Create_Buttons;
glViewPort(0, 0, ClientWidth, ClientHeight);
glLoadIdentity;
gluOrtho2D(-1.0, 1.0, -1.0, 1.0);
InvalidateRect(Handle, nil, False);
end;

procedure TYazevBuilding.Draw_to_Window;
var
ps : TPaintStruct;
i : Integer;
begin
BeginPaint(Handle, ps);
glClear(GL_COLOR_BUFFER_BIT);
Draw_Glass;
for i := Low(square) to High(square) do begin
if (square[i] <> nil) and (square[i].exist) then square[i].Draw(i);
end;
if stick <> nil then stick.Draw;
if cube <> nil then Cube.Draw;
if shape <> nil then shape.Draw;
if lpoker <> nil then lpoker.Draw;
if rpoker <> nil then rpoker.Draw;
if lzigzag <> nil then lzigzag.Draw;
if rzigzag <> nil then rzigzag.Draw;

if dstick <> nil then dstick.ReDraw;
if dcube <> nil then dcube.ReDraw;
if dshape <> nil then dshape.ReDraw;
if dlpoker <> nil then dlpoker.ReDraw;
if drpoker <> nil then drpoker.ReDraw;
if dlzigzag <> nil then dlzigzag.ReDraw;
if drzigzag <> nil then drzigzag.ReDraw;

if (not Game) and (Game_Over) then begin
glPushMatrix;
glColor3f(0.0, 0.0, 0.0);
glTranslatef(-0.8, 0.0, 0.0);
glScalef(0.4, 0.4, 0.4);
Output_TextGL7;
glPopMatrix;
end;

SwapBuffers(DC);
EndPaint(Handle, ps);
end;

procedure TYazevBuilding.Create_Environment;
begin
glEnable(GL_COLOR_MATERIAL);
glClearColor(0.3, 0.7, 0.5, 1.0);
Randomize;
level := 1;
CreateNextShape;
end;

procedure TYazevBuilding.YazevAEIdle(Sender: TObject; var Done: Boolean);
begin
if ActiveGL then begin
Draw_to_Window;
end;
Done := False;
end;

procedure TYazevBuilding.FormActivate(Sender: TObject);
begin
ActiveGL := True;
end;

procedure TYazevBuilding.FormDeactivate(Sender: TObject);
begin
ActiveGL := False;
end;

procedure TYazevBuilding.Draw_Glass;
begin
glColor3f(0.7, 0.7, 0.7);
glPushMatrix;
glRectf(-0.14, 0.9, -0.12, -0.9);
glRectf(-0.14, -0.9, 0.91, -0.92);
glRectf(0.892, -0.92, 0.912, 0.9);
glPopMatrix;
glPushMatrix;
glColor3f(1.0, 0.0, 0.0);
glTranslatef(-0.97, 0.275, 0.0);
glPushMatrix;
glTranslatef(-0.005, 0.55, 0.0);
glPushMatrix;
glScalef(0.15, 0.15, 0.15);
glColor3f(1.0, 1.0, 0.0);
Output_TextGL2;
glPopMatrix;
glPushMatrix;
glTranslatef(0.125, -0.1, 0.0);
glScalef(0.1, 0.1, 0.1);
glColor3f(0.0, 0.0, 0.7);
Output_TextGL3;
glPopMatrix;
glPushMatrix;
glTranslatef(0.08, -0.225, 0.0);
glScalef(0.15, 0.14, 0.14);
glColor3f(0.8, 0.0, 0.0);
Output_TextGL4;
glPopMatrix;
glPushMatrix;
glTranslatef(0.065, -0.34, 0.0);
glScalef(0.11, 0.11, 0.11);
glColor3f(0.8, 0.99, 0.0);
Output_TextGL5;
glPopMatrix;
glPushMatrix;
glTranslatef(0.08, -0.7, 0.0);
glScalef(0.1, 0.1, 0.1);
glColor3f(0.5, 0.0, 0.5);
Output_TextGL6;
glPopMatrix;
glPopMatrix;
glTranslatef(0.0, 0.05, 0.0);
glScalef(0.1, 0.1, 0.1);
glColor3f(1.0, 0.0, 0.0);
Output_TextGL(count);
glPopMatrix;
glPushMatrix;
glTranslatef(0.25, 0.9, 0.0);
glScalef(0.1, 0.1, 0.1);
glColor3f(1.0, 1.0, 1.0);
Output_TextGL8;
glPopMatrix;
end;

procedure TYazevBuilding.Destroy_Environment;
var
i : Integer;
begin
for i := Low(square) to High(square) do
if (square[i] <> nil) and (square[i].exist) then square[i].KillDOWN(i);
//
if stick <> nil then stick.Kill_Out;
if cube <> nil then cube.Kill_Out;
if shape <> nil then shape.Kill_Out;
if lpoker <> nil then lpoker.Kill_Out;
if rpoker <> nil then rpoker.Kill_Out;
if lzigzag <> nil then lzigzag.Kill_Out;
if rzigzag <> nil then rzigzag.Kill_Out;

if dstick <> nil then dstick.Kill_Out;
if dcube <> nil then dcube.Kill_Out;
if dshape <> nil then dshape.Kill_Out;
if dlpoker <> nil then dlpoker.Kill_Out;
if drpoker <> nil then drpoker.Kill_Out;
if dlzigzag <> nil then dlzigzag.Kill_Out;
if drzigzag <> nil then drzigzag.Kill_Out;
//
glDeleteLists(square_list, 1);
glDeleteLists(square_block, 1);
glDeleteLists(square_block_2, 1);
//
SetLength(square, 0)
end;

procedure TYazevBuilding.Create_Shape;
var
i : Integer;
begin
i := 0;

{
i := random(70);
if i < 10 then
stick := TYazevStick.Create
else if i < 20 then
cube := TYazevCube.Create
else if i < 30 then
shape := TYazevShape.Create
else if i < 40 then
lpoker := TYazevLPoker.Create
else if i < 50 then
rpoker := TYazevRPoker.Create
else if i < 60 then
lzigzag := TYazevLZigZag.Create
else if i < 70 then
rzigzag := TYazevRZigZag.Create
}

if dstick <> nil then i := 1 else
if dcube <> nil then i := 2 else
if dshape <> nil then i := 3 else
if dlpoker <> nil then i := 4 else
if drpoker <> nil then i := 5 else
if dlzigzag <> nil then i := 6 else
if drzigzag <> nil then i := 7;

DestroyNextShape;

CreateNextShape;

if i = 1 then stick := TYazevStick.Create else
if i = 2 then cube := TYazevCube.Create else
if i = 3 then shape := TYazevShape.Create else
if i = 4 then lpoker := TYazevLPoker.Create else
if i = 5 then rpoker := TYazevRPoker.Create else
if i = 6 then lzigzag := TYazevLZigZag.Create else
if i = 7 then rzigzag := TYazevRZigZag.Create;
end;

procedure TYazevBuilding.Check_Glass_to_Full;
var
c, x, z, v, p : Integer;
squares : Array [0..9] of Integer;
lev : Array of Integer;
b : Bool;
begin
b := false;
for c := Low(squares) to High(squares) do
squares[c] := -1;
p := 1;
for c := Low(lev) to High(lev) do lev[c] := -1;
for c := 0 to 17 do begin
z := 0;
for x := Low(square) to High(square) do
if square[x] <> nil then
if (square[x].ypos >= bottom_glass_edge + distance * c) and
(square[x].ypos <= bottom_glass_edge + distance + distance * c) then begin
squares[z] := x;
z := z + 1;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++
//Memo1.Lines.Add('Line number: ' + IntToStr(c) + '| squares in line: ' + IntToStr(z));
//++++++++++++++++++++++++++++++++++++++++++++++++
if z = 10 then begin
count := count + 10;
SetLength(lev, p);
lev[p - 1] := c;
p := p + 1;
for v := Low(squares) to High(squares) do
if squares[v] > -1 then
square[squares[v]].KillDOWN(squares[v]);
end;
end;
for z := High(lev) downto Low(lev) do begin
if lev[z] <> -1 then
for x := Low(square) to High(square) do
if square[x] <> nil then
if square[x].ypos >= bottom_glass_edge + distance * lev[z] then
square[x].ypos := square[x].ypos - distance;
b := true;
end;
//+++++++++++++++++++++++++++++++++++++++++++
//Memo1.Lines.Add('');
//+++++++++++++++++++++++++++++++++++++++++++
if b then begin
//Caption := 'Ura!!!';
for c := Low(squares) to High(squares) do
squares[c] := -1;
p := 1;
for c := Low(lev) to High(lev) do lev[c] := -1;
for c := 0 to 17 do begin
z := 0;
for x := Low(square) to High(square) do
if square[x] <> nil then
if (square[x].ypos >= bottom_glass_edge + distance * c) and
(square[x].ypos <= bottom_glass_edge + distance + distance * c) then begin
squares[z] := x;
z := z + 1;
end;
if z = 10 then begin
count := count + 10;
SetLength(lev, p);
lev[p - 1] := c;
p := p + 1;
for v := Low(squares) to High(squares) do
if squares[v] > -1 then
square[squares[v]].KillDOWN(squares[v]);
end;
end;
for z := High(lev) downto Low(lev) do
if lev[z] <> -1 then
for x := Low(square) to High(square) do
if square[x] <> nil then
if square[x].ypos >= bottom_glass_edge + distance * lev[z] then
square[x].ypos := square[x].ypos - distance;
end;
end;

procedure TYazevBuilding.Init_TextGL;
begin
FillChar(lf, SizeOf(LOGFONT), 0);
with lf do begin
lfHeight := -20;
lfWidth := FW_HEAVY;
lfCharSet := ANSI_CHARSET;
lfOutPrecision := OUT_DEFAULT_PRECIS;
lfClipPrecision := CLIP_DEFAULT_PRECIS;
lfQuality := DEFAULT_QUALITY;
lfPitchAndFamily := FF_DONTCARE OR DEFAULT_PITCH;
end;
lstrcpy(lf.lfFaceName, {'Westwood LET'}'Arial Black');
heFont := CreateFontIndirect(lf);
hOldFont := SelectObject(DC, heFont);
if not wglUseFontOutlines(DC, 0, 255, GL_LETTERS, 0.0, 0.5, WGL_FONT_POLYGONS, NIL) then ShowMessage('Can''t output a text');
end;

procedure TYazevBuilding.Output_TextGL(number: Integer);
var
s : String;
begin
s := 'Score: ' + IntToStr(number);
glListBase(GL_LETTERS);
glCallLists(Length(s), GL_UNSIGNED_BYTE, PChar(s));
//
if number >= MaxCounts * level then begin
level := level + 1;
speed_down := speed_down + speed;
start_speed := start_speed + speed;
end
end;

procedure TYazevBuilding.Output_TextGL2;
var
s : String;
begin
s := 'YazevTetris 2';
glListBase(GL_LETTERS);
glCallLists(Length(s), GL_UNSIGNED_BYTE, PChar(s));
end;

procedure TYazevBuilding.Output_TextGL3;
var
s : String;
begin
s := 'developed in';
glListBase(GL_LETTERS);
glCallLists(Length(s), GL_UNSIGNED_BYTE, PChar(s));
end;

procedure TYazevBuilding.Output_TextGL4;
var
s : String;
begin
s := 'YazevSoft';
glListBase(GL_LETTERS);
glCallLists(Length(s), GL_UNSIGNED_BYTE, PChar(s));
end;

procedure TYazevBuilding.Output_TextGL5;
var
s : String;
begin
s := 'by Yazev Yuriy';
glListBase(GL_LETTERS);
glCallLists(Length(s), GL_UNSIGNED_BYTE, PChar(s));
end;

procedure TYazevBuilding.CreateNextShape;
var
i : Integer;
begin
i := random(70);
if i < 10 then dstick := TYazevDemoStick.Create else
if i < 20 then dcube := TYazevDemoCube.Create else
if i < 30 then dshape := TYazevDemoShape.Create else
if i < 40 then dlpoker := TYazevDemoLPoker.Create else
if i < 50 then drpoker := TYazevDemoRPoker.Create else
if i < 60 then dlzigzag := TYazevDemoLZigZag.Create else
if i < 70 then drzigzag := TYazevDemoRZigZag.Create
end;

procedure TYazevBuilding.DestroyNextShape;
begin
if dstick <> nil then dstick.Kill_Out;
if dcube <> nil then dcube.Kill_Out;
if dshape <> nil then dshape.Kill_Out;
if dlpoker <> nil then dlpoker.Kill_Out;
if drpoker <> nil then drpoker.Kill_Out;
if dlzigzag <> nil then dlzigzag.Kill_Out;
if drzigzag <> nil then drzigzag.Kill_Out;
end;

procedure TYazevBuilding.Output_TextGL6;
var
s : String;
begin
s := 'Next shape';
glListBase(GL_LETTERS);
glCallLists(Length(s), GL_UNSIGNED_BYTE, PChar(s));
end;

procedure TYazevBuilding.Create_Buttons;
begin
YazevGameStartButton.Width := Width div 4;
YazevGameStartButton.Height := Height div 19;
YazevGameStartButton.Left := Width div 15;
YazevGameStartButton.Top := Height - Height div 4 - YazevGameStartButton.Height div 2;
YazevGameStartButton.Font.Size := YazevGameStartButton.Height div 2;

YazevGamePauseButton.Width := Width div 4;
YazevGamePauseButton.Height := Height div 19;
YazevGamePauseButton.Left := Width div 15;
YazevGamePauseButton.Top := Height - Height div 4 + YazevGamePauseButton.Height + 5 - YazevGamePauseButton.Height div 2;
YazevGamePauseButton.Font.Size := YazevGamePauseButton.Height div 2;

YazevGameResetButton.Width := Width div 4;
YazevGameResetButton.Height := Height div 19;
YazevGameResetButton.Left := Width div 15;
YazevGameResetButton.Top := Height - Height div 4 + YazevGameResetButton.Height + 5 + YazevGameResetButton.Height + 5 - YazevGameResetButton.Height div 2;
YazevGameResetButton.Font.Size := YazevGameResetButton.Height div 2;

YazevGameExitButton.Width := Width div 4;
YazevGameExitButton.Height := Height div 19;
YazevGameExitButton.Left := Width div 15;
YazevGameExitButton.Top := Height - Height div 4 + YazevGameStartButton.Height + 5 + YazevGamePauseButton.Height + 5 + YazevGamePauseButton.Height + 5 - YazevGamePauseButton.Height div 2;
YazevGameExitButton.Font.Size := YazevGameExitButton.Height div 2;
end;

procedure TYazevBuilding.Output_TextGL7;
var
s : String;
begin
s := 'Game over';
glListBase(GL_LETTERS);
glCallLists(Length(s), GL_UNSIGNED_BYTE, PChar(s));
end;

procedure TYazevBuilding.Output_TextGL8;
var
s : String;
begin
s := 'Level: ' + IntToStr(level);
glListBase(GL_LETTERS);
glCallLists(Length(s), GL_UNSIGNED_BYTE, PChar(s));
end;

{ TYazevSquare }

procedure TYazevSquare.Draw(i : Integer);
begin
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
if kind = 1 then
glCallList(square_list)
else if kind = 2 then
glCallList(square_block)
else if kind = 3 then
glCallList(square_block_2);
glPopMatrix;
end;

destructor TYazevSquare.KillDOWN(i : Integer);
begin
square[i] := nil;
square[i].Free;
end;

constructor TYazevSquare.MakeUP(i, view : Integer; x, y : GLFloat);
begin
xpos := 0;
ypos := 0;
size := 0.091;
kind := view;
if i = 0 then
if kind = 1 then begin
glDeleteLists(square_list, 1);
glNewList(square_list, GL_COMPILE);
glColor3f(random(100) / 100, random(100) / 100, random(100) / 100);
glBegin(GL_QUADS);
glVertex3f(xpos - size / 2, ypos + size / 2, 0.0);
glVertex3f(xpos + size / 2, ypos + size / 2, 0.0);
glVertex3f(xpos + size / 2, ypos - size / 2, 0.0);
glVertex3f(xpos - size / 2, ypos - size / 2, 0.0);
glEnd;
glColor3f(0.0, 0.0, 0.0);
glLineWidth(4.0);
glBegin(GL_LINE_STRIP);
glVertex2f(xpos - size / 2, ypos + size / 2);
glVertex2f(xpos + size / 2, ypos + size / 2);
glVertex2f(xpos + size / 2, ypos - size / 2);
glVertex2f(xpos - size / 2, ypos - size / 2);
glVertex2f(xpos - size / 2, ypos + size / 2);
glEnd;
glEndList;
end else
if kind = 2 then begin
glDeleteLists(square_block, 1);
glNewList(square_block, GL_COMPILE);
glColor3f(random(100) / 100, random(100) / 100, random(100) / 100);
glBegin(GL_QUADS);
glVertex3f(xpos - size / 2, ypos + size / 2, 0.0);
glVertex3f(xpos + size / 2, ypos + size / 2, 0.0);
glVertex3f(xpos + size / 2, ypos - size / 2, 0.0);
glVertex3f(xpos - size / 2, ypos - size / 2, 0.0);
glEnd;
glColor3f(0.0, 0.0, 0.0);
glLineWidth(4.0);
glBegin(GL_LINE_STRIP);
glVertex2f(xpos - size / 2, ypos + size / 2);
glVertex2f(xpos + size / 2, ypos + size / 2);
glVertex2f(xpos + size / 2, ypos - size / 2);
glVertex2f(xpos - size / 2, ypos - size / 2);
glVertex2f(xpos - size / 2, ypos + size / 2);
glEnd;
glEndList;
end else
if kind = 3 then begin
glDeleteLists(square_block_2, 1);
glNewList(square_block_2, GL_COMPILE);
glColor3f(random(100) / 100, random(100) / 100, random(100) / 100);
glBegin(GL_QUADS);
glVertex3f(xpos - size / 2, ypos + size / 2, 0.0);
glVertex3f(xpos + size / 2, ypos + size / 2, 0.0);
glVertex3f(xpos + size / 2, ypos - size / 2, 0.0);
glVertex3f(xpos - size / 2, ypos - size / 2, 0.0);
glEnd;
glColor3f(0.0, 0.0, 0.0);
glLineWidth(4.0);
glBegin(GL_LINE_STRIP);
glVertex2f(xpos - size / 2, ypos + size / 2);
glVertex2f(xpos + size / 2, ypos + size / 2);
glVertex2f(xpos + size / 2, ypos - size / 2);
glVertex2f(xpos - size / 2, ypos - size / 2);
glVertex2f(xpos - size / 2, ypos + size / 2);
glEnd;
glEndList;
end;
//xpos := (left_glass_edge + 0.9) / 2 - size / 2;
//xpos := left_glass_edge + distance * 4;
//ypos := 0.9;
xpos := x;
ypos := y;
exist := True;
//falling := True;
zdeg := 0.0;
end;

procedure TYazevBuilding.YazevTimerTimer(Sender: TObject);
begin
delay := False;
YazevTimer.Enabled := False;
end;

{ TYazevStick }

constructor TYazevStick.Create;
var
i : Integer;
begin
xpos := cxpos;
ypos := cypos;
zdeg := 0;
lxpos := xpos;
lypos := ypos;
for i := Low(squares) to High(squares) do begin
if squares[i] <> nil then break;
squares[i] := TYazevSquare.MakeUP(i, 2, i * distance, 0);
end;
exist := True;
falling := True;
form := 0;
end;

procedure TYazevStick.Draw;
const
size = 0.091;
var
i, k : Integer;
begin

if YazevBuilding.Game then 
ypos := ypos - speed_down;

if ((form = 0) and (ypos < bottom_glass_edge)) then begin
ypos := bottom_glass_edge;
falling := false;
end else
if ((stick <> nil) and (form = 1) and (ypos < bottom_glass_edge + distance))
then begin
//ypos := lypos;
ypos := bottom_glass_edge + distance;
falling := False;
end;

if (stick <> nil) and (stick.form = 1) then begin
if xpos < left_glass_edge - distance then xpos := left_glass_edge - distance
end else
if (stick <> nil) or (cube <> nil) then begin
if xpos < left_glass_edge then
 xpos := left_glass_edge;
end;

if stick <> nil then
if (form = 1) and (xpos >= right_glass_edge - distance) then xpos := right_glass_edge - distance
else if (form = 0) and (xpos >= right_glass_edge - distance * 3) then
xpos := right_glass_edge - distance * 3;

//***********************************************************************************************

if (shape <> nil) and (form > 0) and (ypos < bottom_glass_edge + distance) then begin
 ypos := bottom_glass_edge + distance;
 falling := false;
end;

//***********************************************************************************************

if ((lpoker <> nil) or (rpoker <> nil)) and (form <> 1) and (ypos < bottom_glass_edge + distance * 2) then begin
ypos := bottom_glass_edge + distance * 2;
falling := false;
end;
if ((lpoker <> nil) or (rpoker <> nil)) and (form = 1) and (ypos < bottom_glass_edge + distance) then begin
ypos := bottom_glass_edge + distance;
falling := false;
end;
//****************************************************************************\\
if ((lzigzag <> nil) or (rzigzag <> nil)) and (form = 0) and (ypos < bottom_glass_edge + distance) then begin
ypos := bottom_glass_edge + distance;
falling := false;
end;
if ((lzigzag <> nil) or (rzigzag <> nil)) and (form = 1) and (ypos < bottom_glass_edge + distance * 2) then begin
ypos := bottom_glass_edge + distance * 2;
falling := false;
end;
//******************************************************************************
for k := Low(squares) to High(squares) do
for i := Low(square) to High(square) do
if square[i] <> nil then
if ((squares[k].xpos + size / 2 + xpos > square[i].xpos - size / 2)
and (squares[k].xpos - size / 2 + xpos < square[i].xpos + size / 2)
and (squares[k].ypos + size / 2 + ypos > square[i].ypos - size / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
if ((squares[k].ypos + distance / 2 + ypos > square[i].ypos - distance / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
falling := false;
ypos := lypos;
end;
if ((squares[k].xpos + size / 2 + xpos > square[i].xpos - size / 2)
and (squares[k].xpos - size / 2 + xpos < square[i].xpos + size / 2)
and (squares[k].ypos + size / 2 + ypos > square[i].ypos - size / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
xpos := lxpos;
falling := true;
end;
end;
//*********************************************
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
glRotatef(zdeg, 0.0, 0.0, 1.0);
for i := Low(squares) to High(squares) do squares[i].Draw(i);
glPopMatrix;
 if (not falling) and (ypos = lypos) then begin
   if ypos > 0.85 then begin
 YazevBuilding.Game := false;
 YazevBuilding.Game_Over := true;
 YazevBuilding.YazevGamePauseButton.Enabled := false;
 end else
 YazevBuilding.YazevTransformator.Enabled := True
 end else if (not falling) and (ypos <> lypos) then falling := true;

lxpos := xpos;
lypos := ypos;
end;

procedure TYazevStick.Transformation(number: Integer);
begin
Draw;
square[number] := TYazevSquare.MakeUP(number, 1, xpos + squares[0].xpos, ypos + squares[0].ypos);
square[number + 1] := TYazevSquare.MakeUP(number + 1, 1, xpos + squares[1].xpos, ypos + squares[1].ypos);
square[number + 2] := TYazevSquare.MakeUP(number + 2, 1, xpos + squares[2].xpos, ypos + squares[2].ypos);
square[number + 3] := TYazevSquare.MakeUP(number + 3, 1, xpos + squares[3].xpos, ypos + squares[3].ypos);
end;

destructor TYazevStick.Kill_Out;
var
i : Integer;
begin
for i := Low(squares) to High(squares) do begin
//squares[i].KillDOWN(i);
squares[i] := nil;
squares[i].Free;
end;
if stick <> nil then begin
stick := nil;
stick.Free;
end;
end;

procedure TYazevStick.MoveX(moveleft : Bool);
begin
if moveleft then begin
xpos := xpos - distance;
//right := False;
{delay := True;
YazevBuilding.YazevTimer.Enabled := True;}
end else begin
xpos := xpos + distance;
//left := False;
{delay := True;
YazevBuilding.YazevTimer.Enabled := True; }
end;
end;

procedure TYazevStick.ReCreate;
var
mx : Integer;
begin
MaxSquares := MaxSquares + 4;
mx := High(square) + 1;
SetLength(square, MaxSquares);
//YazevBuilding.Caption := IntToStr(High(square));
//********************************************************************
Transformation(mx);
//********************************************************************
Kill_Out;
//********************************************************************
//YazevBuilding.Create_Shape;
end;

procedure TYazevStick.TRans;
const
size = 0.091;
var
i, k : Integer;
x, y : GLFloat;
begin
x := xpos;
y := ypos;
TRans2;
for k := Low(squares) to High(squares) do
for i := Low(square) to High(square) do
if square[i] <> nil then
if ((squares[k].xpos + size / 2 + xpos > square[i].xpos - size / 2)
and (squares[k].xpos - size / 2 + xpos < square[i].xpos + size / 2)
and (squares[k].ypos + size / 2 + ypos > square[i].ypos - size / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
TRans2;
 xpos := x;
 ypos := y;
end;

if stick <> nil then
if (form = 0) and (xpos < left_glass_edge - distance) then begin
//xpos := left_glass_edge - distance;
xpos := x;
TRans2;
end else
if (form = 1) and (xpos < left_glass_edge - distance / 2) then begin
// xpos := left_glass_edge;
// xpos := left_glass_edge - distance;
xpos := x;
//Trans2;
 end;

if stick <> nil then
if (form = 1) and (xpos >= right_glass_edge - distance) then begin
//xpos := right_glass_edge - distance;
xpos := x;
//TRans2;
end else if (form = 0) and (xpos >= right_glass_edge - distance * 3) then begin
//xpos := right_glass_edge - distance * 3;
xpos := x;
Trans2;
end;

if (stick <> nil) and (form = 1) and (ypos < bottom_glass_edge + distance) then
TRans2;
end;

procedure TYazevStick.TRans2;
begin
if form = 0 then begin
squares[0].ypos := squares[0].ypos - distance;
squares[0].xpos := squares[0].xpos + distance;
squares[1].xpos := squares[1].xpos;
squares[1].ypos := squares[1].ypos;
squares[2].ypos := squares[2].ypos + distance;
squares[2].xpos := squares[2].xpos - distance;
squares[3].ypos := squares[3].ypos + distance*2;
squares[3].xpos := squares[3].xpos - distance*2;
form := 1
end else begin
squares[0].ypos := squares[0].ypos + distance;
squares[0].xpos := squares[0].xpos - distance;
squares[1].xpos := squares[1].xpos;
squares[1].ypos := squares[1].ypos;
squares[2].ypos := squares[2].ypos - distance;
squares[2].xpos := squares[2].xpos + distance;
squares[3].ypos := squares[3].ypos - distance*2;
squares[3].xpos := squares[3].xpos + distance*2;
form := 0
end;
end;

{ TYazevCube }

constructor TYazevCube.Create;
var
p : Integer;
begin
if YazevBuilding.kind then p := 3 else p := 2;
squares[0] := TYazevSquare.MakeUP(0, p, 0, 0);
squares[1] := TYazevSquare.MakeUP(1, p, distance, 0);
squares[2] := TYazevSquare.MakeUP(2, p, 0, distance);
squares[3] := TYazevSquare.MakeUP(3, p, distance, distance);
inherited;
end;

procedure TYazevCube.Draw;
begin
if xpos > right_glass_edge - distance then begin
 xpos := right_glass_edge - distance;
// right := True;
end;
  inherited;
end;

procedure TYazevCube.Transformation(number: Integer);
begin
inherited;
end;

destructor TYazevCube.Kill_Out;
begin
  inherited;
if cube <> nil then begin
cube := nil;
cube.Free;
end
end;

procedure TYazevCube.MoveX(moveleft: Bool);
begin
  inherited;

end;

procedure TYazevCube.ReCreate;
begin
  inherited;
end;

procedure TYazevBuilding.YazevTransformatorTimer(Sender: TObject);
var
obj : TYazevStick;
begin
obj := nil;
if stick <> nil then obj := stick else
if cube <> nil then obj := cube else
if shape <> nil then obj := shape;
if lpoker <> nil then obj := lpoker;
if rpoker <> nil then obj := rpoker;
if lzigzag <> nil then obj := lzigzag;
if rzigzag <> nil then obj := rzigzag;

if (Game) and (obj <> nil) and (obj.ypos = obj.lypos) and (not obj.falling) then begin
obj.ReCreate;
Check_Glass_to_Full;
Create_Shape;
count := count + 5;
end;

YazevTransformator.Enabled := False;
end;

procedure TYazevBuilding.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_ESCAPE then //Close;
if (not first_click) and (not Game_Over) then begin
if Game then
YazevGamePauseButton.Click
else YazevGameStartButton.Click;
end;
if Game then begin
if Key = VK_RIGHT then begin
if stick <> nil then stick.MoveX(false);
if cube <> nil then cube.MoveX(false);
if shape <> nil then shape.MoveX(false);
if lpoker <> nil then lpoker.MoveX(false);
if rpoker <> nil then rpoker.MoveX(false);
if lzigzag <> nil then lzigzag.MoveX(false);
if rzigzag <> nil then rzigzag.MoveX(false);
end;
if Key = VK_LEFT then begin
if stick <> nil then stick.MoveX(true);
if cube <> nil then cube.MoveX(true);
if shape <> nil then shape.MoveX(true);
if lpoker <> nil then lpoker.MoveX(true);
if rpoker <> nil then rpoker.MoveX(true);
if lzigzag <> nil then lzigzag.MoveX(true);
if rzigzag <> nil then rzigzag.MoveX(true);
end;
if Key = VK_DOWN then speed_down := start_speed * divisor;//speed_down * divisor;
if Key = VK_UP then begin
if stick <> nil then stick.TRans;
if shape <> nil then shape.Trans;
if lpoker <> nil then lpoker.Trans;
if rpoker <> nil then rpoker.Trans;
if lzigzag <> nil then lzigzag.Trans;
if rzigzag <> nil then rzigzag.Trans;
end;
end;
//if cube = nil then Caption := 'NIL' else Caption := 'FULL'
end;

procedure TYazevBuilding.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_DOWN then speed_down := start_speed;//speed_down / divisor;
end;

{ TYazevShape }

constructor TYazevShape.Create;
var
p : Integer;
begin
if YazevBuilding.kind then p := 3 else p := 2;
squares[0] := TYazevSquare.MakeUP(0, p, 0.0, 0.0);
squares[1] := TYazevSquare.MakeUP(1, p, distance, 0.0);
squares[2] := TYazevSquare.MakeUP(2, p, distance * 2, 0.0);
squares[3] := TYazevSquare.MakeUP(3, p, distance, distance);
  inherited;
end;

procedure TYazevShape.Draw;
begin
if (form < 3) and (xpos > right_glass_edge - distance * 2) then
 xpos := right_glass_edge - distance * 2 else
if (form = 3) and (xpos > right_glass_edge - distance) then
 xpos := right_glass_edge - distance;
if (form <> 1) and (xpos < left_glass_edge) then
 xpos := left_glass_edge else
if (form = 1) and (xpos < left_glass_edge - distance) then
 xpos := left_glass_edge - distance;
  inherited;
end;

destructor TYazevShape.Kill_Out;
begin
  inherited;
 if shape <> nil then begin
shape := nil;
shape.Free
end
end;

procedure TYazevShape.MoveX(moveleft: Bool);
begin
  inherited;

end;

procedure TYazevShape.ReCreate;
begin
  inherited;

end;

procedure TYazevShape.Trans;
const
size = 0.091;
var
i, k : Integer;
x, y : GLFloat;
begin
x := xpos;
y := ypos;
if not ((form = 1) and (xpos < left_glass_edge - distance)) then
if not ((form = 3) and (xpos > right_glass_edge - distance * 2)) then
TRans2;
for k := Low(squares) to High(squares) do
for i := Low(square) to High(square) do
if square[i] <> nil then
if ((squares[k].xpos + size / 2 + xpos > square[i].xpos - size / 2)
and (squares[k].xpos - size / 2 + xpos < square[i].xpos + size / 2)
and (squares[k].ypos + size / 2 + ypos > square[i].ypos - size / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
if form > 1 then form := form - 2 else
if form = 1 then form := 3 else
if form = 0 then form := 2;
TRans2;
 xpos := x;
 ypos := y;
end;
end;

procedure TYazevShape.Trans2;
begin
if form = 0 then begin
squares[0].xpos := distance;
squares[0].ypos := distance;
squares[1].xpos := distance;
squares[1].ypos := 0.0;
squares[2].xpos := distance;
squares[2].ypos := -distance;
squares[3].xpos := distance * 2;
squares[3].ypos := 0.0;
form := 1
end else
if form = 1 then begin
squares[0].xpos := 0.0;
squares[0].ypos := 0.0;
squares[1].xpos := distance;
squares[1].ypos := 0.0;
squares[2].xpos := distance * 2;
squares[2].ypos := 0.0;
squares[3].xpos := distance;
squares[3].ypos := -distance;
form := 2
end else
if form = 2 then begin
squares[0].xpos := distance;
squares[0].ypos := distance;
squares[1].xpos := distance;
squares[1].ypos := 0.0;
squares[2].xpos := distance;
squares[2].ypos := -distance;
squares[3].xpos := 0.0;
squares[3].ypos := 0.0;
form := 3
end else
if form = 3 then begin
squares[0].xpos := 0.0;
squares[0].ypos := 0.0;
squares[1].xpos := distance;
squares[1].ypos := 0.0;
squares[2].xpos := distance * 2;
squares[2].ypos := 0.0;
squares[3].xpos := distance;
squares[3].ypos := distance;
form := 0
end
end;

procedure TYazevShape.Transformation(number: Integer);
begin
inherited;
end;

{ TYazevLPoker }

constructor TYazevLPoker.Create;
var
i, p : Integer;
begin
if YazevBuilding.kind then p := 3 else p := 2;
for i := 0 to 2 do
squares[i] := TYazevSquare.MakeUp(i, p, 0.0, -distance * i);
squares[3] := TYazevSquare.MakeUp(3, p, distance, 0.0);
  inherited;
end;

procedure TYazevLPoker.Draw;
begin
if (form = 0) and (xpos > right_glass_edge - distance) then
xpos := right_glass_edge - distance;
if ((form = 1) or (form = 3) or (form = 2)) and
(xpos > right_glass_edge - distance * 2) then
xpos := right_glass_edge - distance * 2;
if (form = 2) and (xpos < left_glass_edge - distance) then
xpos := left_glass_edge - distance;
if ((form = 0) or (form = 1) or (form = 3)) and
(xpos < left_glass_edge) then
xpos := left_glass_edge; 
  inherited;
end;

destructor TYazevLPoker.Kill_Out;
begin
  inherited;
 if lpoker <> nil then begin
lpoker := nil;
lpoker.Free
end
end;

procedure TYazevLPoker.MoveX(moveleft: Bool);
begin
  inherited;

end;

procedure TYazevLPoker.ReCreate;
begin
  inherited;

end;

procedure TYazevLPoker.Trans;
const
size = 0.091;
var
i, k : Integer;
x, y : GLFloat;
begin
x := xpos;
y := ypos;
if not ((form = 2) and (xpos < left_glass_edge - distance)) then
if not ((form = 0) and (xpos > right_glass_edge - distance * 2)) then
TRans2;
for k := Low(squares) to High(squares) do
for i := Low(square) to High(square) do
if square[i] <> nil then
if ((squares[k].xpos + size / 2 + xpos > square[i].xpos - size / 2)
and (squares[k].xpos - size / 2 + xpos < square[i].xpos + size / 2)
and (squares[k].ypos + size / 2 + ypos > square[i].ypos - size / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
if form > 1 then form := form - 2 else
if form = 1 then form := 3 else
if form = 0 then form := 2;
TRans2;
 xpos := x;
 ypos := y;
end;
end;

procedure TYazevLPoker.Trans2;
var
i : Integer;
begin
if form = 0 then begin
for i := 0 to 2 do begin
squares[i].xpos := distance * i;
squares[i].ypos := 0.0;
end;
squares[3].xpos := distance * 2;
squares[3].ypos := -distance;
form := 1
end else
if form = 1 then begin
for i := 0 to 2 do begin
squares[i].xpos := distance * 2;
squares[i].ypos := -distance * i;
end;
squares[3].xpos := distance;
squares[3].ypos := -distance * 2;
form := 2
end else
if form = 2 then begin
for i := 2 downto 0 do begin
squares[i].xpos := distance * i;
squares[i].ypos := -distance * 2;
end;
squares[3].xpos := 0.0;
squares[3].ypos := -distance;
form := 3
end else
if form = 3 then begin
for i := 0 to 2 do begin
squares[i].xpos := 0.0;
squares[i].ypos := -distance * i;
end;
squares[3].xpos := distance;
squares[3].ypos := 0.0;
form := 0
end
end;

procedure TYazevLPoker.Transformation(number: Integer);
begin
  inherited;

end;

{ TYazevRPoker }

constructor TYazevRPoker.Create;
var
i, p : Integer;
begin
if YazevBuilding.kind then p := 3 else p := 2;
for i := 0 to 2 do
squares[i] := TYazevSquare.MakeUP(i, p, distance * 2, -distance * i);
squares[3] := TYazevSquare.MakeUP(3, p, distance, 0.0);
  inherited;
end;

procedure TYazevRPoker.Draw;
begin
if (form = 2) and (xpos > right_glass_edge - distance) then
xpos := right_glass_edge - distance;
if ((form = 0) or (form = 1) or (form = 3)) and
(xpos > right_glass_edge - distance * 2) then
xpos := right_glass_edge - distance * 2;
if (form = 0) and (xpos < left_glass_edge - distance) then
xpos := left_glass_edge - distance;
if ((form = 1) or (form = 2) or (form = 3)) and
(xpos < left_glass_edge) then
xpos := left_glass_edge; 
  inherited;
end;

destructor TYazevRPoker.Kill_Out;
begin
  inherited;
 if rpoker <> nil then begin
rpoker := nil;
rpoker.Free
end
end;

procedure TYazevRPoker.MoveX(moveleft: Bool);
begin
  inherited;

end;

procedure TYazevRPoker.ReCreate;
begin
  inherited;

end;

procedure TYazevRPoker.Trans;
const
size = 0.091;
var
i, k : Integer;
x, y : GLFloat;
begin
x := xpos;
y := ypos;
if not ((form = 0) and (xpos < left_glass_edge - distance)) then
if not ((form = 2) and (xpos > right_glass_edge - distance * 2)) then
TRans2;
for k := Low(squares) to High(squares) do
for i := Low(square) to High(square) do
if square[i] <> nil then
if ((squares[k].xpos + size / 2 + xpos > square[i].xpos - size / 2)
and (squares[k].xpos - size / 2 + xpos < square[i].xpos + size / 2)
and (squares[k].ypos + size / 2 + ypos > square[i].ypos - size / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
if form > 1 then form := form - 2 else
if form = 1 then form := 3 else
if form = 0 then form := 2;
TRans2;
 xpos := x;
 ypos := y;
end;
end;

procedure TYazevRPoker.Trans2;
var
i : Integer;
begin
if form = 0 then begin
for i := 0 to 2 do begin
squares[i].xpos := distance * i;
squares[i].ypos := 0.0;
end;
squares[3].xpos := 0.0;
squares[3].ypos := -distance;
form := 1;
end else
if form = 1 then begin
for i := 0 to 2 do begin
squares[i].xpos := 0.0;
squares[i].ypos := -distance * i;
end;
squares[3].xpos := distance;
squares[3].ypos := -distance * 2;
form := 2;
end else
if form = 2 then begin
for i := 0 to 2 do begin
squares[i].xpos := distance * i;
squares[i].ypos := -distance * 2;
end;
squares[3].xpos := distance * 2;
squares[3].ypos := -distance;
form := 3;
end else
if form = 3 then begin
for i := 0 to 2 do begin
squares[i].xpos := distance * 2;
squares[i].ypos := -distance * i;
end;
squares[3].xpos := distance;
squares[3].ypos := 0.0;
form := 0
end

end;

procedure TYazevRPoker.Transformation(number: Integer);
begin
  inherited;

end;

{ TYazevLZigZag }

constructor TYazevLZigZag.Create;
var
p : Integer;
begin
if YazevBuilding.kind then p := 3 else p := 2;
squares[0] := TYazevSquare.MakeUP(0, p, 0.0, -distance);
squares[1] := TYazevSquare.MakeUP(1, p, distance, -distance);
squares[2] := TYazevSquare.MakeUP(2, p, distance, 0.0);
squares[3] := TYazevSquare.MakeUP(3, p, distance * 2, 0.0);
  inherited;
end;

procedure TYazevLZigZag.Draw;
begin
if form = 0 then begin
if xpos > right_glass_edge - distance * 2 then
xpos := right_glass_edge - distance * 2;
if xpos < left_glass_edge then
xpos := left_glass_edge;
end;
if form = 1 then begin
if xpos > right_glass_edge - distance then
xpos := right_glass_edge - distance;
if xpos < left_glass_edge then
xpos := left_glass_edge;
end;
  inherited;
end;

destructor TYazevLZigZag.Kill_Out;
begin
  inherited;
 if lzigzag <> nil then begin
lzigzag := nil;
lzigzag.Free
end
end;

procedure TYazevLZigZag.MoveX(moveleft: Bool);
begin
  inherited;

end;

procedure TYazevLZigZag.ReCreate;
begin
  inherited;

end;

procedure TYazevLZigZag.Trans;
const
size = 0.091;
var
i, k : Integer;
x, y : GLFloat;
begin
x := xpos;
y := ypos;
if not ((form = 1) and (xpos > right_glass_edge - distance - distance / 2)) then
TRans2;
for k := Low(squares) to High(squares) do
for i := Low(square) to High(square) do
if square[i] <> nil then
if ((squares[k].xpos + size / 2 + xpos > square[i].xpos - size / 2)
and (squares[k].xpos - size / 2 + xpos < square[i].xpos + size / 2)
and (squares[k].ypos + size / 2 + ypos > square[i].ypos - size / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
TRans2;
 xpos := x;
 ypos := y;
end;
end;

procedure TYazevLZigZag.Trans2;
begin
if form = 0 then begin
squares[0].xpos := 0.0;
squares[0].ypos := 0.0;
squares[1].xpos := 0.0;
squares[1].ypos := -distance;
squares[2].xpos := distance;
squares[2].ypos := -distance;
squares[3].xpos := distance;
squares[3].ypos := -distance * 2;
form := 1
end else
if form = 1 then begin
squares[0].xpos := 0.0;
squares[0].ypos := -distance;
squares[1].xpos := distance;
squares[1].ypos := -distance;
squares[2].xpos := distance;
squares[2].ypos := 0.0;
squares[3].xpos := distance * 2;
squares[3].ypos := 0.0;
form := 0;
end
end;

procedure TYazevLZigZag.Transformation(number: Integer);
begin
  inherited;

end;

{ TYazevRZigZag }

constructor TYazevRZigZag.Create;
var
p : Integer;
begin
if YazevBuilding.kind then p := 3 else p := 2;
squares[0] := TYazevSquare.MakeUP(0, p, 0.0, 0.0);
squares[1] := TYazevSquare.MakeUP(1, p, distance, 0.0);
squares[2] := TYazevSquare.MakeUP(2, p, distance, -distance);
squares[3] := TYazevSquare.MakeUP(3, p, distance * 2, -distance);
  inherited;
end;

procedure TYazevRZigZag.Draw;
begin
if form = 0 then begin
if xpos > right_glass_edge - distance * 2 then
xpos := right_glass_edge - distance * 2;
if xpos < left_glass_edge then
xpos := left_glass_edge;
end;
if form = 1 then begin
if xpos > right_glass_edge - distance * 2 then
xpos := right_glass_edge - distance * 2;
if xpos < left_glass_edge - distance then
xpos := left_glass_edge - distance;
end;
  inherited;
end;

destructor TYazevRZigZag.Kill_Out;
begin
  inherited;
if rzigzag <> nil then begin
rzigzag := nil;
rzigzag.Free
end
end;

procedure TYazevRZigZag.MoveX(moveleft: Bool);
begin
  inherited;

end;

procedure TYazevRZigZag.ReCreate;
begin
  inherited;

end;

procedure TYazevRZigZag.Trans;
const
size = 0.091;
var
i, k : Integer;
x, y : GLFloat;
begin
x := xpos;
y := ypos;
if not ((form = 1) and (xpos < left_glass_edge - distance {+ distance / 2})) then
TRans2;
for k := Low(squares) to High(squares) do
for i := Low(square) to High(square) do
if square[i] <> nil then
if ((squares[k].xpos + size / 2 + xpos > square[i].xpos - size / 2)
and (squares[k].xpos - size / 2 + xpos < square[i].xpos + size / 2)
and (squares[k].ypos + size / 2 + ypos > square[i].ypos - size / 2)
and (squares[k].ypos - distance / 2 + ypos < square[i].ypos + distance / 2))
then begin
TRans2;
 xpos := x;
 ypos := y;
end;
end;

procedure TYazevRZigZag.Trans2;
begin
if form = 0 then begin
squares[0].xpos := distance * 2;
squares[0].ypos := 0.0;
squares[1].xpos := distance * 2;
squares[1].ypos := -distance;
squares[2].xpos := distance;
squares[2].ypos := -distance;
squares[3].xpos := distance;
squares[3].ypos := -distance * 2;
form := 1
end else
if form = 1 then begin
squares[0].xpos := 0.0;
squares[0].ypos := 0.0;
squares[1].xpos := distance;
squares[1].ypos := 0.0;
squares[2].xpos := distance;
squares[2].ypos := -distance;
squares[3].xpos := distance * 2;
squares[3].ypos := -distance;
form := 0
end
end;

procedure TYazevRZigZag.Transformation(number: Integer);
begin
  inherited;

end;

procedure TYazevBuilding.YazevGameStartButtonClick(Sender: TObject);
begin
Game := true;
Game_Over := false;
if first_click then begin
Create_Shape;
first_click := false;
end;
YazevGamePauseButton.Enabled := true;
YazevGameResetButton.Enabled := true;
YazevGameStartButton.Enabled := false;
end;

{ TYazevDemoStick }

constructor TYazevDemoStick.Create;
begin
YazevBuilding.kind := true;
  inherited;
xpos := dxpos;
ypos := dypos;
YazevBuilding.kind := false
end;

destructor TYazevDemoStick.Kill_Out;
begin
  inherited;
dstick := nil;
dstick.Free
end;

procedure TYazevDemoStick.ReDraw;
var
i : Integer;
begin
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
for i := Low(squares) to High(squares) do
squares[i].Draw(i);
glPopMatrix;
end;

{ TYazevDemoCube }

constructor TYazevDemoCube.Create;
begin
YazevBuilding.kind := true;
  inherited;
xpos := dxpos;
ypos := dypos;
YazevBuilding.kind := false;
end;

destructor TYazevDemoCube.Kill_Out;
begin
  inherited;
dcube := nil;
dcube.Free
end;

procedure TYazevDemoCube.ReDraw;
var
i : Integer;
begin
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
for i := Low(squares) to High(squares) do
squares[i].Draw(i);
glPopMatrix;
end;

{ TYazevDemoShape }

constructor TYazevDemoShape.Create;
begin
YazevBuilding.kind := true;
  inherited;
xpos := dxpos;
ypos := dypos;
YazevBuilding.kind := false;
end;

destructor TYazevDemoShape.Kill_Out;
begin
  inherited;
dshape := nil;
dshape.Free
end;

procedure TYazevDemoShape.ReDraw;
var
i : Integer;
begin
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
for i := Low(squares) to High(squares) do
squares[i].Draw(i);
glPopMatrix;
end;

{ TYazevDemoLPoker }

constructor TYazevDemoLPoker.Create;
begin
YazevBuilding.kind := true;
  inherited;
xpos := dxpos;
ypos := dypos;
YazevBuilding.kind := false;
end;

destructor TYazevDemoLPoker.Kill_Out;
begin
  inherited;
dlpoker := nil;
dlpoker.Free
end;

procedure TYazevDemoLPoker.ReDraw;
var
i : Integer;
begin
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
for i := Low(squares) to High(squares) do
squares[i].Draw(i);
glPopMatrix;
end;

{ TYazevDemoRPoker }

constructor TYazevDemoRPoker.Create;
begin
YazevBuilding.kind := true;
  inherited;
xpos := dxpos;
ypos := dypos;
YazevBuilding.kind := false
end;

destructor TYazevDemoRPoker.Kill_Out;
begin
  inherited;
drpoker := nil;
drpoker.Free
end;

procedure TYazevDemoRPoker.ReDraw;
var
i : Integer;
begin
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
for i := Low(squares) to High(squares) do
squares[i].Draw(i);
glPopMatrix;
end;

{ TYazevDemoLZigZag }

constructor TYazevDemoLZigZag.Create;
begin
YazevBuilding.kind := true;
  inherited;
xpos := dxpos;
ypos := dypos;
YazevBuilding.kind := false
end;

destructor TYazevDemoLZigZag.Kill_Out;
begin
  inherited;
dlzigzag := nil;
dlzigzag.Free
end;

procedure TYazevDemoLZigZag.ReDraw;
var
i : Integer;
begin
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
for i := Low(squares) to High(squares) do
squares[i].Draw(i);
glPopMatrix;
end;

{ TYazevDemoRZigZag }

constructor TYazevDemoRZigZag.Create;
begin
YazevBuilding.kind := true;
  inherited;
xpos := dxpos;
ypos := dypos;
YazevBuilding.kind := false;
end;

destructor TYazevDemoRZigZag.Kill_Out;
begin
  inherited;
drzigzag := nil;
drzigzag.Free
end;

procedure TYazevDemoRZigZag.ReDraw;
var
i : Integer;
begin
glPushMatrix;
glTranslatef(xpos, ypos, 0.0);
for i := Low(squares) to High(squares) do
squares[i].Draw(i);
glPopMatrix;
end;

procedure TYazevBuilding.YazevGameExitButtonClick(Sender: TObject);
begin
Close
end;

procedure TYazevBuilding.YazevGamePauseButtonClick(Sender: TObject);
begin
Game := false;
YazevGameStartButton.Enabled := true;
YazevGamePauseButton.Enabled := false;
end;

procedure TYazevBuilding.YazevGameResetButtonClick(Sender: TObject);
begin
Game := false;
Game_Over := false;
count := 0;
speed_down := 0.001;
start_speed := 0.001;
level := 1;
Destroy_Environment;
first_click := true;
CreateNextShape;
YazevGameStartButton.Enabled := true;
YazevGameResetButton.Enabled := false;
end;

end.
