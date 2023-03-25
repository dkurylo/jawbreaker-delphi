unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, MPlayer, Buttons, ToolWin, ComCtrls, MMSystem,
  ActnMan, ActnColorMaps, XPMan;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Game1: TMenuItem;
    About1: TMenuItem;
    NewGame1: TMenuItem;
    Options1: TMenuItem;
    N1: TMenuItem;
    Help1: TMenuItem;
    ExitProgram1: TMenuItem;
    N3: TMenuItem;
    Manual1: TMenuItem;
    Statistics1: TMenuItem;
    Undo1: TMenuItem;
    Options2: TMenuItem;
    N2: TMenuItem;
    Panel3: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    VersionHistory1: TMenuItem;
    XPManifest1: TXPManifest;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure NewGame1Click(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Statistics1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure ExitProgram1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Manual1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure VersionHistory1Click(Sender: TObject);

  private
    SoundPlayed: integer;
    Stat: array[1..3,1..4] of integer;
    Opts: array[1..8] of integer;
    GuestNext: integer;
    StyleNext: integer;
    Style: integer;
    Bonus: integer;
    NeedNewGameQuestion: integer;
    BigBoard: integer;
    ColorBW: integer;
    SoundsType: integer;

  public
    property SoundPlayed1: integer read SoundPlayed write SoundPlayed;
    property Bonus1: integer read Bonus write Bonus;
    property GuestNext1: integer read GuestNext write GuestNext;
    property StyleNext1: integer read StyleNext write StyleNext;
    property ColorBW1: integer read ColorBW write ColorBW;
    property SoundsType1: integer read SoundsType write SoundsType;
    property Style1: integer read Style write Style;
    property Opts1: integer read Opts[1] write Opts[1];
    property Opts2: integer read Opts[2] write Opts[2];
    property Opts3: integer read Opts[3] write Opts[3];
    property Opts4: integer read Opts[4] write Opts[4];
    property Opts5: integer read Opts[5] write Opts[5];
    property Opts6: integer read Opts[6] write Opts[6];
    property Opts7: integer read Opts[7] write Opts[7];
    property Opts8: integer read Opts[8] write Opts[8];
    property Stat11: integer read Stat[1,1] write Stat[1,1];
    property Stat21: integer read Stat[2,1] write Stat[2,1];
    property Stat31: integer read Stat[3,1] write Stat[3,1];
    property Stat12: integer read Stat[1,2] write Stat[1,2];
    property Stat22: integer read Stat[2,2] write Stat[2,2];
    property Stat32: integer read Stat[3,2] write Stat[3,2];
    property Stat13: integer read Stat[1,3] write Stat[1,3];
    property Stat23: integer read Stat[2,3] write Stat[2,3];
    property Stat33: integer read Stat[3,3] write Stat[3,3];
    property Stat14: integer read Stat[1,4] write Stat[1,4];
    property Stat24: integer read Stat[2,4] write Stat[2,4];
    property Stat34: integer read Stat[3,4] write Stat[3,4];
    property NeedNewGameQuestion1: integer read NeedNewGameQuestion write NeedNewGameQuestion;
    property BigBoard1: integer read Bigboard write Bigboard;
  end;

const
  Version=1;

var
  Form1: TForm1;
  Bitmap: TBitmap;
  F: textfile;
  Ch1,Ch2,Ch3:char;
  Arr:array[0..12,0..13] of integer;
  ArrUndo,ArrTemp:array[1..11,1..12] of integer;
  ArrMask:array[0..12,0..13] of integer;
  Ballsdown:array[1..12] of Integer;
  StRand:array[1..22,1..11] of Integer;
  StAlt:array[1..11] of Integer;
  StAltCnt,StAltUndoNeeded,StPointer,StPointerUndo,StLoadedZero: integer;
  Confirm,jmax,ic1,jc1,ic2,jc2,xc,yc,BS,k,i,j,n,m,s,d,Ver,i2,j2,ArrMaskRight,ArrMaskLeft,Cond,Ballz,Selected,C,GameEnd,Score,ScoreUndo: integer;
  x1,y1,CWidth,CHeight,BoardChangedSize,BallSize,CircleRadius,Cr1x,Cr2x,Cr3x,Cr4x,Cr5x,Cry,BallSizeSm,BallSmDeltaY,CircleModX,CircleModY,ColorBWOld: integer;

  implementation

uses Unit2, Unit3, Unit4, Unit5, Unit6, Unit7;

{$R *.DFM}
{$R 'Resource.res'}
{$R 'Sound.res'}

procedure BoardChgCoords(Board: Integer);
begin
  if Board=0 then
  begin
    x1:=11+3; y1:=4; CWidth:=242+3; CHeight:=247; BallSize:=20;
    Form1.ClientWidth:=248; Form1.ClientHeight:=274;
    Form1.Label4.Left:=138; Form1.Panel3.Top:=251; Form1.Panel3.Width:=219; Form1.SpeedButton1.Top:=250; Form1.SpeedButton1.Left:=224;
    Form1.Canvas.Font.Size:=7; CircleRadius:=25; Cr1x:=10; Cr2x:=7; Cr3x:=5; Cr4x:=3; Cr5x:=1; Cry:=7; BallSizeSm:=14; BallSmDeltaY:=3; CircleModX:=9; CircleModY:=2;
  end else
  begin
    x1:=20+3; y1:=7; CWidth:=480+3; CHeight:=493; BallSize:=40;
    Form1.ClientWidth:=486; Form1.ClientHeight:=519;
    Form1.Label4.Left:=376; Form1.Panel3.Top:=496; Form1.Panel3.Width:=457; Form1.SpeedButton1.Top:=495; Form1.SpeedButton1.Left:=462;
    Form1.Canvas.Font.Size:=13; CircleRadius:=46; Cr1x:=18; Cr2x:=14; Cr3x:=9; Cr4x:=5; Cr5x:=1; Cry:=12; BallSizeSm:=26; BallSmDeltaY:=7; CircleModX:=17; CircleModY:=5;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Visible:=False;
  Randomize;
  //apply starting variable parameters
  NeedNewGameQuestion1:=1; //(check the code) to avoid "New Game" question if the old game was fully played
  Canvas.Font.Name:='Tahoma';

  //read the saved game
  if (not FileExists('Jawbreak.svg')) then
  begin
  //if the saved game file doesn't exist;
    MessageDlg('Cannot find a saved game file in the local directory. A new file will be created with default settings.', mtError, [mbOK], 0);
    AssignFile(F, 'Jawbreak.svg');
    ReWrite(F);
    Write(F, chr(Version));
    for i:=1 to 6 do Write(F, chr(0));
    for i:=1 to 11 do
    begin
      for j:=1 to 12 do
      begin
        Arr[i,j]:=Random(5)+1;
        Write(F, Chr(Arr[i,j]));
      end;
    end;
    for i:=1 to 32 do Write(F, chr(0));
    Write(F, chr(15));
    Write(F, chr(1)); Write(F, chr(1)); Write(F, chr(0));
    for i:=1 to 11 do
    begin
      for j:=1 to 11 do
      begin
        Write(F, chr(0));
      end;
    end;
    Write(F, chr(0)); //Write BigBoard Settings (small)
    Write(F, chr(0)); //Write Board Color Settings (colored)
    Write(F, chr(0)); //Write SoundsType (custom sounds)
    Write(F, chr(0)); //Null byte - if I'll need it in future
    CloseFile(F);
  end else
  begin //if the saved game file version is not compatible
    AssignFile(F, 'Jawbreak.svg');
    Reset(F);
    Read(F, Ch1);
    Closefile(F);
    Ver:=ord(Ch1);
    if Ver<>Version then
    begin
      MessageDlg('The file version of your saved game is incompatible with the current program version. All your saved game data will be reseted.', mtError, [mbOK], 0);
      AssignFile(F, 'Jawbreak.svg');
      ReWrite(F);
      Write(F, chr(Version));
      for i:=1 to 6 do Write(F, chr(0));
      for i:=1 to 11 do
      begin
        for j:=1 to 12 do
        begin
          Arr[i,j]:=Random(5)+1;
          Write(F, Chr(Arr[i,j]));
        end;
      end;
      for i:=1 to 32 do Write(F, chr(0));
      Write(F, chr(15));
      Write(F, chr(1)); Write(F, chr(1)); Write(F, chr(0));
      for i:=1 to 11 do
      begin
        for j:=1 to 11 do
        begin
          Write(F, chr(0)); //balls positions and colors
        end;
      end;
      Write(F, chr(0)); //Write BigBoard Settings (small)
      Write(F, chr(0)); //Write Board Color Settings (colored)
      Write(F, chr(0)); //Write SoundsType (custom sounds)
      Write(F, chr(0)); //Null byte - if I'll need it in future
      CloseFile(F);
    end;
  end;

  //if a saved game file exits - load saved settings - it 100% exists, because we at least just created it
  AssignFile(F, 'Jawbreak.svg');
  Reset(F);
  Read(F, Ch1); Ver:=ord(Ch1);
  if Ver=Version then
  begin
    Read(F, Ch1); Read(F, Ch2);
    C:=ord(Ch1)*256+ord(Ch2);
    if C<Screen.Height then Form1.Top:=C else Form1.Top:=0;
    Read(F, Ch1); Read(F, Ch2);
    C:=ord(Ch1)*256+ord(Ch2);
    if C<Screen.Width then Form1.Left:=C else Form1.Left:=0;
    Read(F, Ch1); Read(F, Ch2);
    Score:=(ord(Ch1)*256+ord(Ch2))*100;
    for i:=1 to 11 do
    begin
      for j:=1 to 12 do
      begin
      Read(F, Ch1);
      C:=ord(Ch1);
      if C<6 then Arr[i,j]:=C else Arr[i,j]:=0; //if a ballz data in the file is bad (not in the 0-5 range), replace the bad ball with a blank space
      Arr[i,j]:=C
      end;
    end;
    for i:=1 to 4 do
    begin
      Read(F, Ch1); Read(F, Ch2); Read(F, Ch3);
      Stat[1,i]:= ord(Ch1)*65536+ord(Ch2)*256+ord(Ch3);
      Read(F, Ch1); Read(F, Ch2); Read(F, Ch3);
      Stat[2,i]:= ord(Ch1)*65536+ord(Ch2)*256+ord(Ch3);
      Read(F, Ch1); Read(F, Ch2);
      Stat[3,i]:= (ord(Ch1)*256+ord(Ch2))*100;
    end;
    Read(F, Ch1);
    S:=ord(Ch1);
    for i:=1 to 8 do
    begin
      Opts[9-i]:=S mod 2;
      S:=trunc(S/2);
    end;
    Read(F, Ch1);
    C:=ord(Ch1);
    if C<5 then Style:=C else Style:=1;
    Read(F, Ch1);
    C:=ord(Ch1);
    if C<5 then StyleNext:=C else StyleNext:=1;
    Read(F, Ch1);
    C:=ord(Ch1);
    if C<2 then GuestNext:=C else GuestNext:=0;
    StLoadedZero:=0;
    for i:=1 to 11 do
    begin
      for j:=1 to 11 do
      begin
        Read(F, Ch1);
        StRand[i,j]:=ord(Ch1);
        StLoadedZero:=StLoadedZero+StRand[i,j];
      end;
    end;
    if (not EOF(F)) then
    begin
      read(F, Ch1);
      if ord(Ch1)=1 then BigBoard:=1 else BigBoard:=0;
    end else BigBoard:=0;
    BoardChangedSize:=BigBoard;
    BoardChgCoords(BigBoard);
    Label3.Caption:=inttostr(trunc(Score/100));
    if (not EOF(F)) then
    begin
      read(F, Ch1);
      if ord(Ch1)=1 then ColorBW:=1 else ColorBW:=0;
      read(F, Ch1);
      if ord(Ch1)=1 then SoundsType:=1 else SoundsType:=0;
    end else
      begin
        ColorBW:=0;
        SoundsType:=0;
      end;
    ColorBWOld:=ColorBW;
  CloseFile(F);

    if StLoadedZero=0 then StLoadedZero:=1 else StLoadedZero:=11;
    for i:=StLoadedZero to 22 do
    begin
      StAltCnt:=Random(11)+1;
      if StAltCnt<11 then
      begin
        for j:=1 to 12-StAltCnt-1 do
        begin
          StRand[i,j]:=0;
        end;
      end;
      for j:=12-StAltCnt to 11 do
      begin
        StRand[i,j]:=Random(5)+1;
      end;
    end;

    StPointer:=1;

    if Style=1 then
    begin
      Label4.Caption:='Standard';
      jmax:=12;
    end;

    if Style=2 then
    begin
      StAltCnt:=0;
      Label4.Caption:='Continuous';
      jmax:=11;
      for i:=1 to 11 do
      begin
        StAlt[i]:=StRand[StPointer,i];
        Arr[i,12]:=0;
        if StAlt[i]<>0 then StAltCnt:=StAltCnt+1;
      end;
    end;

    if Style=3 then
    begin
      Label4.Caption:='Shifter';
      jmax:=12;
    end;

    if Style=4 then
    begin
      StAltCnt:=0;
      Label4.Caption:='Megashift';
      jmax:=11;
      for i:=1 to 11 do
      begin
        StAlt[i]:=StRand[StPointer,i];
        Arr[i,12]:=0;
        if StAlt[i]<>0 then StAltCnt:=StAltCnt+1;
      end;
    end;
    Form1.Visible:=True;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin //save game while exiting from the game
    AssignFile(F, 'Jawbreak.svg');
    ReWrite(F);
    Ch1:=chr(Version);
    Write(F, Ch1);
    if ((Form1.Top<=Screen.Height-Form1.Height) and (Form1.Top>=0)) then
    begin
      S:=Form1.Top div 256;
      Ch1:=chr(S);
      Write(F, Ch1);
      Ch2:=chr(Form1.Top - S*256);
      Write(F, Ch2);
    end else
      begin
        if (Form1.Top>Screen.Height-Form1.Height) then
        begin
          S:=(Screen.Height-Form1.Height) div 256;
          Ch1:=chr(S);
          Write(F, Ch1);
          Ch2:=chr(Form1.Top - S*256);
          Write(F, Ch2);
        end else
        begin
          Write(F, chr(0));
          Write(F, chr(0));
        end;
      end;
    if ((Form1.Left<=Screen.Width-Form1.Left) and (form1.left>=0)) then
    begin
      S:=Form1.Left div 256;
      Ch1:=chr(S);
      Write(F, Ch1);
      Ch2:=chr(Form1.Left - S*256);
      Write(F, Ch2);
    end else
      begin
        if (Form1.Left>Screen.Width-Form1.Width) then
        begin
          S:=(Screen.Width-Form1.Width) div 256;
          Ch1:=chr(S);
          Write(F, Ch1);
          Ch2:=chr(Form1.Left - S*256);
          Write(F, Ch2);
        end else
        begin
          Write(F, chr(0));
          Write(F, chr(0));
        end;
      end;
    S:=trunc(Score/100) div 256;
    Ch1:=chr(S);
    Write(F, Ch1);
    Ch2:=chr(trunc(Score/100) - S*256);
    Write(F, Ch2);
    if ((Style=1) or (Style=3)) then
    begin
      for i:=1 to 11 do
      begin
        for j:=1 to 12 do
        begin
          Ch1:=chr(Arr[i,j]);
          Write(F, Ch1);
        end;
      end;
    end;
    if ((Style=2) or (Style=4)) then
    begin
      for i:=1 to 11 do
      begin
        for j:=1 to 12 do
        begin
          if j=12 then Ch1:=chr(0) else Ch1:=chr(Arr[i,j]);
          Write(F, Ch1);
        end;
      end;
    end;
    for i:=1 to 4 do
    begin
      S:=Stat[1,i] div 65536;
      D:=Stat[1,i] div 256;
      Ch1:=chr(S);
      Write(F, Ch1);
      Ch2:=chr(D - S*256);
      Write(F, Ch2);
      Ch3:=chr(Stat[1,i] - D*256);
      Write(F, Ch3);

      S:=Stat[2,i] div 65536;
      D:=Stat[2,i] div 256;
      Ch1:=chr(S);
      Write(F, Ch1);
      Ch2:=chr(D - S*256);
      Write(F, Ch2);
      Ch3:=chr(Stat[2,i] - D*256);
      Write(F, Ch3);

      S:=(trunc(Stat[3,i]/100)) div 256;
      Ch1:=chr(S);
      Write(F, Ch1);
      Ch2:=chr(trunc(Stat[3,i]/100) - S*256);
      Write(F, Ch2);
    end;

    S:=0; d:=1;
    for i:=1 to 8 do
    begin
      S:=S+(Opts[9-i])*d;
      D:=d*2;
    end;
    Ch1:=chr(S);
    Write(F, Ch1);
    Ch1:=chr(Style);
    Write(F, Ch1);
    Ch1:=chr(StyleNext);
    Write(F, Ch1);
    Ch1:=chr(GuestNext);
    Write(F, Ch1);
    for i:=1 to 11 do
    begin
      for j:=1 to 11 do
      begin
        if ((Style=1) or (Style=3)) then
        begin
          Ch1:=chr(0);
          Write(F, Ch1);
        end;
        if ((Style=2) or (Style=4)) then
        begin
          if i+stPointer-1>22 then Ch1:=chr(StRand[i+StPointer-1-22,j]) else Ch1:=chr(StRand[i+StPointer-1,j]);
          Write(F, Ch1);
        end;
      end;
    end;
    Write(F, chr(BigBoard)); //Write BigBoard Settings
    Write(F, chr(ColorBW)); //Write Color Settings
    Write(F, chr(SoundsType)); //Write SoundsType
    Write(F, chr(0)); //Null byte - if I'll need it in future
    CloseFile(F);
end;

procedure TForm1.FormPaint(Sender: TObject); //draw a graphics if a form is repainted
begin
  if ((BoardChangedSize<>BigBoard) or (ColorBW<>ColorBWOld)) then
  begin
    ColorBWOld:=ColorBW;
    BoardChangedSize:=BigBoard;
//   Form1.Visible:=False; //workaround to update form while changing the board size from large to small (remnants of a big board at the down and right border) (part1)
//   Now using Form1.Refresh 2 lines below, but I left an ability to change
    BoardChgCoords(BigBoard);
    Form1.Refresh;
    if Selected=1 then
    begin
      xc:=0; yc:=0;
      j:=1; i:=1;
      while xc=0 do //or yc=0 - no matter
      begin
        if ArrMask[i,j]=1 then
        begin
          xc:=trunc(x1+(i-1)*BallSize-CircleRadius); if xc<x1-CircleModX then xc:=x1-CircleModX;
          yc:=trunc(y1+(j-1)*BallSize-CircleRadius); if yc<y1-CircleModY then yc:=y1-CircleModY;
        end;
        i:=i+1;
        if i=12 then
        begin
          j:=j+1;
          i:=1;
        end;
      end;
    end;
  end;
  Canvas.Pen.Color:=clBlack; Canvas.Brush.Color:=clWhite;
  begin
    Canvas.Rectangle(Rect(3,0,CWidth,CHeight));
    if ((style=2) or (style=4)) then Canvas.Rectangle(Rect(3,CHeight-BallSize,CWidth,CHeight));
    if BigBoard=0 then
    begin
      for i:=1 to 11 do
      begin
        for j:=1 to jmax do
        begin
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end else
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end;
          finally
            Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end else
    begin
      for i:=1 to 11 do
      begin
        for j:=1 to jmax do
        begin
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end else
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end;
          finally
            Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end;
    if selected=1 then
    //redraw the lines and an oval with a score
    begin
      Canvas.Pen.Color:=clBlack;
      for i:=1 to 11 do
      begin
        for j:=1 to jmax do
        begin
          if (ArrMask[i+1,j]<ArrMask[i,j]) then
          begin
            ArrMaskRight:=0; ArrMaskLeft:=0;
            if ((ArrMask[i+1,j-1]=1) and (ArrMask[i,j-1]=1)) then ArrMaskLeft:=1;
            if ((ArrMask[i+1,j+1]=1) and (ArrMask[i,j+1]=1)) then ArrMaskRight:=1;
            Form1.Canvas.MoveTo((x1+i*BallSize-1),(y1+j*BallSize-1+ArrMaskRight));
            Form1.Canvas.LineTo((x1+i*BallSize-1),(y1+(j-1)*BallSize-1-ArrMaskLeft));
          end;
          if (ArrMask[i-1,j]<ArrMask[i,j]) then
          begin
            ArrMaskRight:=0; ArrMaskLeft:=0;
            if ((ArrMask[i-1,j+1]=1) and (ArrMask[i,j+1]=1)) then ArrMaskLeft:=1;
            if ((ArrMask[i-1,j-1]=1) and (ArrMask[i,j-1]=1)) then ArrMaskRight:=1;
            Form1.Canvas.MoveTo((x1+(i-1)*BallSize),(y1+(j-1)*BallSize-ArrMaskRight));
            Form1.Canvas.LineTo((x1+(i-1)*BallSize),(y1+j*BallSize+ArrMaskLeft));
          end;
          if (ArrMask[i,j+1]<ArrMask[i,j]) then
          begin
            ArrMaskRight:=0; ArrMaskLeft:=0;
            if ((ArrMask[i+1,j+1]=1) and (ArrMask[i+1,j]=1)) then ArrMaskLeft:=1;
            if ((ArrMask[i-1,j+1]=1) and (ArrMask[i-1,j]=1)) then ArrMaskRight:=1;
            Form1.Canvas.MoveTo((x1+i*BallSize-1+ArrMaskLeft),(y1+j*BallSize-1));
            Form1.Canvas.LineTo((x1+(i-1)*BallSize-1-ArrMaskRight),(y1+j*BallSize-1));
          end;
          if (ArrMask[i,j-1]<ArrMask[i,j]) then
          begin
            ArrMaskRight:=0; ArrMaskLeft:=0;
            if ((ArrMask[i+1,j-1]=1) and (ArrMask[i+1,j]=1)) then ArrMaskRight:=1;
            if ((ArrMask[i-1,j-1]=1) and (ArrMask[i-1,j]=1)) then ArrMaskLeft:=1;
            Form1.Canvas.MoveTo((x1+(i-1)*BallSize-ArrMaskLeft),(y1+(j-1)*BallSize));
            Form1.Canvas.LineTo((x1+i*BallSize+ArrMaskRight),(y1+(j-1)*BallSize));
          end;
        end;
      end;
      if Arr[i2,j2]=1 then Canvas.Brush.Color:=$00FFB000;
      if Arr[i2,j2]=2 then Canvas.Brush.Color:=$00FFB0FF;
      if Arr[i2,j2]=3 then Canvas.Brush.Color:=$00B0FFA0;
      if Arr[i2,j2]=4 then Canvas.Brush.Color:=$00B0B0FF;
      if Arr[i2,j2]=5 then Canvas.Brush.Color:=$00B0FFFF;
      Canvas.Ellipse(xc,yc,xc+CircleRadius,yc+CircleRadius);
      BS:=(Ballz-1)*Ballz;
      if BS<10 then Canvas.TextOut(xc+Cr1x,yc+Cry,inttostr(BS))
      else if BS<100 then
        Canvas.TextOut(xc+Cr2x,yc+Cry,inttostr(BS))
          else if BS<1000 then
            Canvas.TextOut(xc+Cr3x,yc+Cry,inttostr(BS))
              else if BS<10000 then
                Canvas.TextOut(xc+Cr4x,yc+Cry,inttostr(BS))
                  else Canvas.TextOut(xc+Cr5x,yc+Cry,inttostr(BS)); //max points is 17292
      Canvas.Brush.Color:=clWhite;
    end;
    if ((style=2) or (style=4)) then
    //redraw the StAlt
    if BigBoard=0 then
    begin
      for i:=12-StAltCnt to 11 do
      begin
        Bitmap:=TBitmap.Create;
        try
          if ColorBW=0 then
          begin
            if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
          end else
          begin
            if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
          end;
        finally
          Form1.Canvas.Brush.Bitmap:=nil;
          Bitmap.Free;
        end;
      end;
    end else
    begin
      for i:=12-StAltCnt to 11 do
      begin
        Bitmap:=TBitmap.Create;
        try
          if ColorBW=0 then
          begin
            if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
          end else
          begin
            if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
          end;
        finally
          Form1.Canvas.Brush.Bitmap:=nil;
          Bitmap.Free;
        end;
      end;
    end;
  end;
//  Form1.Visible:=True; //walkaround to update form while changing the board size from large to small (remnants of a big board at the down and right border) (part2)
end;


procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    i2:=trunc(((x-x1)/BallSize)+1);
    j2:=trunc(((y-y1)/BallSize)+1);
  if ((selected=1) and (ArrMask[i2,j2]=1)) then //if there is a selection (onclick)
  begin
    if Arrmask[i2,j2]=1 then
    begin
    //save undo positions
      for i:=1 to 11 do
      begin
        for j:=1 to jmax do
        begin
        ArrUndo[i,j]:=Arr[i,j];
        end;
      end;
      //delete a circle with points and restore ballz under it
      ic1:=trunc(((xc-x1)/BallSize)+1);
      jc1:=trunc(((yc-y1)/BallSize)+1);
      ic2:=trunc(((xc-x1+CircleRadius)/BallSize));
      jc2:=trunc(((yc-y1+CircleRadius)/BallSize));
      if ic1<1 then begin ic2:=trunc(((xc-x1+CircleRadius-1)/BallSize)+1); ic1:=1; end;
      if jc1<1 then begin jc2:=trunc(((yc-y1+CircleRadius-1)/BallSize)+1); jc1:=1; end;
      if BigBoard=0 then
      begin
        for i:= ic1 to ic2 do
        begin
          for j:= jc1 to jc2 do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end else
      begin
        for i:= ic1 to ic2 do
        begin
          for j:= jc1 to jc2 do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end;
      Canvas.Pen.Color:=clWhite;
      if ((Style=2) or (Style=4)) then Canvas.Rectangle(4,1,x1,CHeight-BallSize) else Canvas.Rectangle(4,1,x1,CHeight-1);
      Canvas.Rectangle(4,1,CWidth-1,y1);
      //graphics effect while killing ballz
      if BigBoard=0 then
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            if ArrMask[i,j]=1 then
            begin
              if Ballz<10 then
              begin
                Bitmap:=TBitmap.Create;
                try
                  if ColorBW=0 then
                  begin
                    if Arr[i,j]=1 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Blue-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=2 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Cyan-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=3 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Green-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=4 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Red-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=5 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Yellow-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                  end else
                  begin
                    if Arr[i,j]=1 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Blue-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=2 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Cyan-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=3 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Green-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=4 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Red-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=5 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Yellow-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                  end;
                finally
                  Form1.Canvas.Brush.Bitmap:=nil;
                  Bitmap.Free;
                end;
              end else
              begin
                Bitmap:=TBitmap.Create;
                try
                  if ColorBW=0 then
                  begin
                    if Arr[i,j]=1 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Blue-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=2 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Cyan-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=3 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Green-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=4 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Red-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=5 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Yellow-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                  end else
                  begin
                    if Arr[i,j]=1 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Blue-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=2 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Cyan-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=3 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Green-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=4 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Red-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=5 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Yellow-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                  end;
                finally
                  Form1.Canvas.Brush.Bitmap:=nil;
                  Bitmap.Free;
                end;
              end;
            end;
          end;
        end;
      end else
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            if ArrMask[i,j]=1 then
            begin
              if Ballz<10 then
              begin
                Bitmap:=TBitmap.Create;
                try
                  if ColorBW=0 then
                  begin
                    if Arr[i,j]=1 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=2 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=3 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Green-lg-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=4 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Red-lg-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=5 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-x'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                  end else
                  begin
                    if Arr[i,j]=1 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=2 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=3 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Green-lg-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=4 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Red-lg-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=5 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-x-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                  end;
                finally
                  Form1.Canvas.Brush.Bitmap:=nil;
                  Bitmap.Free;
                end;
              end else
              begin
                Bitmap:=TBitmap.Create;
                try
                  if ColorBW=0 then
                  begin
                    if Arr[i,j]=1 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=2 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=3 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Green-lg-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=4 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Red-lg-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=5 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-y'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                  end else
                  begin
                    if Arr[i,j]=1 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=2 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=3 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Green-lg-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=4 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Red-lg-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                    if Arr[i,j]=5 then begin if Opts5=1 then begin Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-y-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap); end; Arr[i,j]:=0; end;
                  end;
                finally
                  Form1.Canvas.Brush.Bitmap:=nil;
                  Bitmap.Free;
                end;
              end;
            end;
          end;
        end;
      end;
      //sound effect while killing ballz
      if Ballz<10 then
      begin
        if Opts8=1 then begin if SoundsType=0 then sndPlaySound('Pop1', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC) else sndPlaySound('Pop1Orig', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC); end;
      end;
      if Ballz>=10 then
      begin
        if Opts8=1 then begin if SoundsType=0 then sndPlaySound('Pop2', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC) else sndPlaySound('Pop2Orig', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC); end;
      end;
      //pause (using timer)
      if Opts5=1 then Sleep(250);
      //ballz go down
      for i:=1 to 11 do
      begin
        c:=1;
        for j:=1 to jmax do
        begin
          Ballsdown[jmax+1-j]:=0;
          if Arr[i,jmax+1-j]<>0 then begin Ballsdown[jmax+1-c]:=Arr[i,jmax+1-j]; c:=c+1; end;
        end;
        for j:=1 to jmax do Arr[i,jmax+1-j]:=ballsdown[jmax+1-j];
      end;
      //redraw the ballz map (could be deleted if needed)
{
      if BigBoard=0 then
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end else
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end;
}

      if Style=1 then
      begin
      //colums check & go right
        c:=1;
        for i:=1 to 11 do
        begin
          if Arr[12-i,jmax]<>0 then
          begin
            for j:=1 to jmax do
            begin
              ArrTemp[12-c,j]:=Arr[12-i,j];
            end;
          c:=c+1;
          end;
        end;
        for i:=1 to 11 do begin for j:=1 to jmax do begin Arr[i,j]:=ArrTemp[i,j]; ArrTemp[i,j]:=0; end; end;
      end;

      if style=2 then
      begin
      //colums check & go right
        c:=1;
        for i:=1 to 11 do
        begin
          if Arr[12-i,jmax]<>0 then
          begin
            for j:=1 to jmax do
            begin
              ArrTemp[12-c,j]:=Arr[12-i,j];
            end;
          c:=c+1;
          end;
        end;
        for i:=1 to 11 do begin for j:=1 to jmax do begin Arr[i,j]:=ArrTemp[i,j]; ArrTemp[i,j]:=0; end; end;
      //redraw the ballz map (could be deleted if needed)
{
      if BigBoard=0 then
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end else
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end;
}
        //generate undo parameters
        StAltUndoNeeded:=1;
        StPointerUndo:=StPointer;
        //free columns fill with ballz from StAlt
        for i:=1 to 11 do
        begin
          if Arr[12-i,jmax]=0 then //bug was reported Arr[i,jmax]=0 --> Arr[12-i,jmax]=0
          begin
            for j:=1 to jmax do
            begin
              Arr[12-i,j]:=StAlt[j]; //bug was reported Arr[i,j]:=StAlt[j] --> Arr[12-i,j]:=StAlt[j]
            end;
            //generate a StAlt ballz map
            Canvas.Pen.Color:=clBlack;
            Canvas.Rectangle(3,CHeight-BallSize,CWidth,CHeight);
            StPointer:=StPointer+1; if StPointer>22 then StPointer:=StPointer-22;
            for m:=1 to 11 do
            begin
              StAlt[m]:=StRand[StPointer,m];
            end;
            //generate the pseudo-random StAlt map at the [Current+11,j] field
            StAltCnt:=Random(11)+1;
            if StPointer+11-1>22 then
            begin
              for n:=1 to StAltCnt do
              begin
                StRand[StPointer-11-1,12-n]:=Random(5)+1;
              end;
              if StAltCnt<11 then
              begin
                for n:=StAltCnt+1 to 11 do
                begin
                 StRand[StPointer-11-1,12-n]:=0;
                end;
              end;
            end else
            begin
              for n:=1 to StAltCnt do
              begin
                StRand[StPointer+11-1,12-n]:=Random(5)+1;
              end;
              if StAltCnt<11 then
              begin
                for n:=StAltCnt+1 to 11 do
                begin
                 StRand[StPointer+11-1,12-n]:=0;
                end;
              end;
            end;
            StAltCnt:=0;
            for m:=1 to 11 do
            begin
              if StAlt[m]<>0 then StAltCnt:=StAltCnt+1;
            end;
            if BigBoard=0 then
            begin
              for m:=12-StAltCnt to 11 do
              begin
                Bitmap:=TBitmap.Create;
                try
                  if ColorBW=0 then
                  begin
                    if StAlt[m]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                  end else
                  begin
                    if StAlt[m]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                  end;
                finally
                Form1.Canvas.Brush.Bitmap:=nil;
                Bitmap.Free;
                end;
              end;
            end else
            begin
              for m:=12-StAltCnt to 11 do
              begin
                Bitmap:=TBitmap.Create;
                try
                  if ColorBW=0 then
                  begin
                    if StAlt[m]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                  end else
                  begin
                    if StAlt[m]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                  end;
                finally
                Form1.Canvas.Brush.Bitmap:=nil;
                Bitmap.Free;
                end;
              end;
            end;
          end;
        end;
      end;

      if style=3 then
      begin
      //fall right
        for j:=1 to jmax do
        begin
          c:=1;
          for i:=1 to 11 do
          begin
            Ballsdown[12-i]:=0;
            if Arr[12-i,j]<>0 then begin Ballsdown[jmax-c]:=Arr[12-i,j]; c:=c+1; end;
          end;
          for i:=1 to 11 do Arr[12-i,j]:=ballsdown[12-i];
        end;
      end;

      if style=4 then
      begin
      //fall right
        for j:=1 to jmax do
        begin
          c:=1;
          for i:=1 to 11 do
          begin
            Ballsdown[12-i]:=0;
            if Arr[12-i,j]<>0 then begin Ballsdown[jmax+1-c]:=Arr[12-i,j]; c:=c+1; end;
          end;
          for i:=1 to 11 do Arr[12-i,j]:=ballsdown[12-i];
        end;
      //redraw the ballz map (could be deleted if needed)
      if BigBoard=0 then
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end else
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end;
        //generate undo parameters
        StAltUndoNeeded:=1;
        StPointerUndo:=StPointer;
        //free columns fill with a ballz from StAlt
        for i:=1 to 11 do
        begin
          if Arr[12-i,jmax]=0 then //bug was reported Arr[i,jmax]=0 --> Arr[12-i,jmax]=0
          begin
            for j:=1 to jmax do
            begin
              Arr[12-i,j]:=StAlt[j]; //bug was reported Arr[i,j]:=StAlt[j]; --> Arr[12-i,j]:=StAlt[j];
            end;
            //generate a StAlt ballz map
            Canvas.Pen.Color:=clBlack;
            Canvas.Rectangle(3,CHeight-BallSize,CWidth,CHeight);
            StPointer:=StPointer+1; if StPointer>22 then StPointer:=StPointer-22;
            for m:=1 to 11 do
            begin
              StAlt[m]:=StRand[StPointer,m];
            end;
            //generate the pseudo-random StAlt map at the [Current+11,j] field
            StAltCnt:=Random(11)+1;
            if StPointer+11-1>22 then
            begin
              for n:=1 to StAltCnt do
              begin
                StRand[StPointer-11-1,12-n]:=Random(5)+1;
              end;
              if StAltCnt<11 then
              begin
                for n:=StAltCnt+1 to 11 do
                begin
                 StRand[StPointer-11-1,12-n]:=0;
                end;
              end;
            end else
            begin
              for n:=1 to StAltCnt do
              begin
                StRand[StPointer+11-1,12-n]:=Random(5)+1;
              end;
              if StAltCnt<11 then
              begin
                for n:=StAltCnt+1 to 11 do
                begin
                 StRand[StPointer+11-1,12-n]:=0;
                end;
              end;
            end;
            StAltCnt:=0;
            for m:=1 to 11 do
            begin
              if StAlt[m]<>0 then StAltCnt:=StAltCnt+1;
            end;

            if BigBoard=0 then
            begin
              for m:=12-StAltCnt to 11 do
              begin
                Bitmap:=TBitmap.Create;
                try
                  if ColorBW=0 then
                  begin
                    if StAlt[m]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                  end else
                  begin
                    if StAlt[m]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                  end;
                finally
                Form1.Canvas.Brush.Bitmap:=nil;
                Bitmap.Free;
                end;
              end;
            end else
            begin
              for m:=12-StAltCnt to 11 do
              begin
                Bitmap:=TBitmap.Create;
                try
                  if ColorBW=0 then
                  begin
                    if StAlt[m]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                  end else
                  begin
                    if StAlt[m]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                    if StAlt[m]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-m-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
                  end;
                finally
                Form1.Canvas.Brush.Bitmap:=nil;
                Bitmap.Free;
                end;
              end;
            end;
          end;
        end;
        //fall right
        for j:=1 to jmax do
        begin
          c:=1;
          for i:=1 to 11 do
          begin
            Ballsdown[12-i]:=0;
            if Arr[12-i,j]<>0 then begin Ballsdown[jmax+1-c]:=Arr[12-i,j]; c:=c+1; end;
          end;
          for i:=1 to 11 do Arr[12-i,j]:=ballsdown[12-i];
        end;
      end;

      //redraw the ballz map
      if BigBoard=0 then
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end else
      begin
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            Bitmap:=TBitmap.Create;
            try
              if ColorBW=0 then
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end else
              begin
                if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
                if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              end;
            finally
              Form1.Canvas.Brush.Bitmap:=nil;
              Bitmap.Free;
            end;
          end;
        end;
      end;

      ScoreUndo:=Score;
      Score:=Score+(Ballz*(Ballz-1))*100;
      Label3.Caption:=inttostr(trunc(Score/100));
      Selected:=0;
      Ballz:=0;
      for i:=1 to 11 do for j:=1 to jmax do ArrMask[i,j]:=0;
      //check for the end of the game
      GameEnd:=1;
      for i:=1 to 11 do
      begin
        for j:=1 to jmax do
        begin
          if ((Arr[i+1,j]=Arr[i,j]) and (Arr[i,j]<>0)) then GameEnd:=0;
          if ((Arr[i-1,j]=Arr[i,j]) and (Arr[i,j]<>0)) then GameEnd:=0;
          if ((Arr[i,j+1]=Arr[i,j]) and (Arr[i,j]<>0)) then GameEnd:=0;
          if ((Arr[i,j-1]=Arr[i,j]) and (Arr[i,j]<>0)) then GameEnd:=0;
        end;
      end;
      //if GameEnd then run the GameEnd form and modify results
      if gameend=1 then
      begin
        Undo1.Enabled:=False; SpeedButton1.Enabled:=False;
        bonus:=10000;
        for i:=1 to 11 do for j:=1 to jmax do if ((Arr[i,j]<>0) and (bonus>=2000)) then Bonus:=Bonus-2000; //count the ballz that lasted after the GameEnd
        Form1.Enabled:=False;
        Form4.Left:=trunc((Form1.Width-Form4.Width)/2+Form1.Left);
        Form4.Top:=trunc((Form1.Height-Form4.Height)/2+Form1.Top);
        Form4.Label1.Caption:=IntToStr(trunc(Score/100));
        Form4.Label2.Caption:=IntToStr(trunc(Bonus/100));
        Form4.Label3.Caption:=IntToStr(trunc((Bonus+Score)/100));
        if Opts4=0 then
        begin
          for k:=1 to 4 do
          begin
            if Style=k then
            begin
              if Opts6=1 then
              begin
                Form4.Label4.Caption:=inttostr(trunc(((stat[2,k]*stat[1,k]+Score+Bonus)/(Stat[1,k]+1))/100))+'.'+inttostr(trunc((stat[2,k]*stat[1,k]+Score+Bonus)/(Stat[1,k]+1)) mod 100);
              end else
              begin
                Form4.Label4.Caption:=inttostr(round(((stat[2,k]*stat[1,k]+Score+Bonus)/(Stat[1,k]+1))/100));
              end;
              Form4.Label5.Caption:=inttostr(stat[1,k]+1);
              if (((Score+Bonus)>Stat[3,k]) and (Opts4=0)) then
              begin
                Stat[3,k]:=(Score+Bonus);
                Form4.Caption:='High Score!';
              end else
              begin
                Form4.Caption:='Game Over!';
              end;
            end;
          end;
        end;
        Form4.Visible:=True;
      end else begin Undo1.Enabled:=True; SpeedButton1.Enabled:=True; end;
    end;
  end else //if a click is outside the selected region
  if selected=1 then
  begin
    selected:=0;
    Ballz:=0;
    //erase lines around ballz and clear ArrMask
    Canvas.Pen.Color:=clWhite;
    for i:=1 to 11 do
    begin
      for j:=1 to jmax do
      begin
        if (ArrMask[i+1,j]<ArrMask[i,j]) then
        begin
          ArrMaskRight:=0; ArrMaskLeft:=0;
          if ((ArrMask[i+1,j-1]=1) and (ArrMask[i,j-1]=1)) then ArrMaskLeft:=1;
          if ((ArrMask[i+1,j+1]=1) and (ArrMask[i,j+1]=1)) then ArrMaskRight:=1;
          Form1.Canvas.MoveTo((x1+i*BallSize-1),(y1+j*BallSize-1+ArrMaskRight));
          Form1.Canvas.LineTo((x1+i*BallSize-1),(y1+(j-1)*BallSize-1-ArrMaskLeft));
        end;
        if (ArrMask[i-1,j]<ArrMask[i,j]) then
        begin
          ArrMaskRight:=0; ArrMaskLeft:=0;
          if ((ArrMask[i-1,j+1]=1) and (ArrMask[i,j+1]=1)) then ArrMaskLeft:=1;
          if ((ArrMask[i-1,j-1]=1) and (ArrMask[i,j-1]=1)) then ArrMaskRight:=1;
          Form1.Canvas.MoveTo((x1+(i-1)*BallSize),(y1+(j-1)*BallSize-ArrMaskRight));
          Form1.Canvas.LineTo((x1+(i-1)*BallSize),(y1+j*BallSize+ArrMaskLeft));
        end;
        if (ArrMask[i,j+1]<ArrMask[i,j]) then
        begin
          ArrMaskRight:=0; ArrMaskLeft:=0;
          if ((ArrMask[i+1,j+1]=1) and (ArrMask[i+1,j]=1)) then ArrMaskLeft:=1;
          if ((ArrMask[i-1,j+1]=1) and (ArrMask[i-1,j]=1)) then ArrMaskRight:=1;
          Form1.Canvas.MoveTo((x1+i*BallSize-1+ArrMaskLeft),(y1+j*BallSize-1));
          Form1.Canvas.LineTo((x1+(i-1)*BallSize-1-ArrMaskRight),(y1+j*BallSize-1));
        end;
        if (ArrMask[i,j-1]<ArrMask[i,j]) then
        begin
          ArrMaskRight:=0; ArrMaskLeft:=0;
          if ((ArrMask[i+1,j-1]=1) and (ArrMask[i+1,j]=1)) then ArrMaskRight:=1;
          if ((ArrMask[i-1,j-1]=1) and (ArrMask[i-1,j]=1)) then ArrMaskLeft:=1;
          Form1.Canvas.MoveTo((x1+(i-1)*BallSize-ArrMaskLeft),(y1+(j-1)*BallSize));
          Form1.Canvas.LineTo((x1+i*BallSize+ArrMaskRight),(y1+(j-1)*BallSize));
        end;
      end;
    end;
    for i:=1 to 11 do for j:=1 to jmax do ArrMask[i,j]:=0;
    //delete a circle with points and restore ballz under it
    ic1:=trunc(((xc-x1)/BallSize)+1);
    jc1:=trunc(((yc-y1)/BallSize)+1);
    ic2:=trunc(((xc-x1+CircleRadius)/BallSize));
    jc2:=trunc(((yc-y1+CircleRadius)/BallSize));
    if ic1<1 then begin ic2:=trunc(((xc-x1+CircleRadius-1)/BallSize)+1); ic1:=1; end;
    if jc1<1 then begin jc2:=trunc(((yc-y1+CircleRadius-1)/BallSize)+1); jc1:=1; end;
    if BigBoard=0 then
    begin
      for i:= ic1 to ic2 do
      begin
        for j:= jc1 to jc2 do
        begin
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end else
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end;
          finally
            Form1.Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end else
    begin
      for i:= ic1 to ic2 do
      begin
        for j:= jc1 to jc2 do
        begin
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end else
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end;
          finally
            Form1.Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end;
    Canvas.Pen.Color:=clWhite;
    if ((Style=2) or (Style=4)) then Canvas.Rectangle(4,1,x1,CHeight-BallSize) else Canvas.Rectangle(4,1,x1,CHeight-1);
    Canvas.Rectangle(4,1,CWidth-1,y1);
  end else //if there is no selection (onclick)
  if selected=0 then
  begin
    if ((Arr[i2,j2]<>0) and ((Arr[i2+1,j2]=Arr[i2,j2]) or (Arr[i2-1,j2]=Arr[i2,j2]) or (Arr[i2,j2+1]=Arr[i2,j2]) or (Arr[i2,j2-1]=Arr[i2,j2]))) then
    begin
      ArrMask[i2,j2]:=1;
      Selected:=1;
      //generate ArrMask
      Cond:=0;
      WHILE Cond=0 DO
      begin
        Cond:=1;
        for i:=1 to 11 do
        begin
          for j:=1 to jmax do
          begin
            if ((Arr[i,j]=Arr[i2,j2]) and (ArrMask[i,j]=0) and (ArrMask[i+1,j]+ArrMask[i-1,j]+ArrMask[i,j+1]+ArrMask[i,j-1]>0)) then begin Cond:=0; ArrMask[i,j]:=1; end;
            if ((Arr[i,j]=Arr[i2,j2]) and (ArrMask[i,j]=0) and (ArrMask[i+1,j]+ArrMask[i-1,j]+ArrMask[i,j+1]+ArrMask[i,j-1]>0)) then begin Cond:=0; ArrMask[i,j]:=1; end;
            if ((Arr[i,j]=Arr[i2,j2]) and (ArrMask[i,j]=0) and (ArrMask[i+1,j]+ArrMask[i-1,j]+ArrMask[i,j+1]+ArrMask[i,j-1]>0)) then begin Cond:=0; ArrMask[i,j]:=1; end;
            if ((Arr[i,j]=Arr[i2,j2]) and (ArrMask[i,j]=0) and (ArrMask[i+1,j]+ArrMask[i-1,j]+ArrMask[i,j+1]+ArrMask[i,j-1]>0)) then begin Cond:=0; ArrMask[i,j]:=1; end;
          end;
        end;
      end;
      //count the selected ballz and draw a selection
      Canvas.Pen.Color:=clBlack;
      for i:=1 to 11 do
      begin
        for j:=1 to jmax do
        begin
          if ArrMask[i,j]=1 then Ballz:=Ballz+1;
          if (ArrMask[i+1,j]<ArrMask[i,j]) then
          begin
            ArrMaskRight:=0; ArrMaskLeft:=0;
            if ((ArrMask[i+1,j-1]=1) and (ArrMask[i,j-1]=1)) then ArrMaskLeft:=1;
            if ((ArrMask[i+1,j+1]=1) and (ArrMask[i,j+1]=1)) then ArrMaskRight:=1;
            Form1.Canvas.MoveTo((x1+i*BallSize-1),(y1+j*BallSize-1+ArrMaskRight));
            Form1.Canvas.LineTo((x1+i*BallSize-1),(y1+(j-1)*BallSize-1-ArrMaskLeft));
          end;
          if (ArrMask[i-1,j]<ArrMask[i,j]) then
          begin
            ArrMaskRight:=0; ArrMaskLeft:=0;
            if ((ArrMask[i-1,j+1]=1) and (ArrMask[i,j+1]=1)) then ArrMaskLeft:=1;
            if ((ArrMask[i-1,j-1]=1) and (ArrMask[i,j-1]=1)) then ArrMaskRight:=1;
            Form1.Canvas.MoveTo((x1+(i-1)*BallSize),(y1+(j-1)*BallSize-ArrMaskRight));
            Form1.Canvas.LineTo((x1+(i-1)*BallSize),(y1+j*BallSize+ArrMaskLeft));
          end;
          if (ArrMask[i,j+1]<ArrMask[i,j]) then
          begin
            ArrMaskRight:=0; ArrMaskLeft:=0;
            if ((ArrMask[i+1,j+1]=1) and (ArrMask[i+1,j]=1)) then ArrMaskLeft:=1;
            if ((ArrMask[i-1,j+1]=1) and (ArrMask[i-1,j]=1)) then ArrMaskRight:=1;
            Form1.Canvas.MoveTo((x1+i*BallSize-1+ArrMaskLeft),(y1+j*BallSize-1));
            Form1.Canvas.LineTo((x1+(i-1)*BallSize-1-ArrMaskRight),(y1+j*BallSize-1));
          end;
          if (ArrMask[i,j-1]<ArrMask[i,j]) then
          begin
            ArrMaskRight:=0; ArrMaskLeft:=0;
            if ((ArrMask[i+1,j-1]=1) and (ArrMask[i+1,j]=1)) then ArrMaskRight:=1;
            if ((ArrMask[i-1,j-1]=1) and (ArrMask[i-1,j]=1)) then ArrMaskLeft:=1;
            Form1.Canvas.MoveTo((x1+(i-1)*BallSize-ArrMaskLeft),(y1+(j-1)*BallSize));
            Form1.Canvas.LineTo((x1+i*BallSize+ArrMaskRight),(y1+(j-1)*BallSize));
          end;
        end;
      end;
      //draw a circle to show the points in
      xc:=0; yc:=0;
      j:=1; i:=1;
      while xc=0 do //or yc=0 - no matter
      begin
        if ArrMask[i,j]=1 then
        begin
          xc:=trunc(x1+(i-1)*BallSize-CircleRadius); if xc<x1-CircleModX then xc:=x1-CircleModX;
          yc:=trunc(y1+(j-1)*BallSize-CircleRadius); if yc<y1-CircleModY then yc:=y1-CircleModY;
        end;
        i:=i+1;
        if i=12 then
        begin
          j:=j+1;
          i:=1;
        end;
      end;
      if ((selected=1) and (ArrMask[i2,j2]=1)) then
      begin
        if Arr[i2,j2]=1 then Canvas.Brush.Color:=$00FFB000;
        if Arr[i2,j2]=2 then Canvas.Brush.Color:=$00FFB0FF;
        if Arr[i2,j2]=3 then Canvas.Brush.Color:=$00B0FFA0;
        if Arr[i2,j2]=4 then Canvas.Brush.Color:=$00B0B0FF;
        if Arr[i2,j2]=5 then Canvas.Brush.Color:=$00B0FFFF;
        Canvas.Ellipse(xc,yc,xc+CircleRadius,yc+CircleRadius);
        BS:=(Ballz-1)*Ballz;
        if BS<10 then Canvas.TextOut(xc+Cr1x,yc+Cry,inttostr(BS))
        else if BS<100 then
          Canvas.TextOut(xc+Cr2x,yc+Cry,inttostr(BS))
            else if BS<1000 then
              Canvas.TextOut(xc+Cr3x,yc+Cry,inttostr(BS))
                else if BS<10000 then
                  Canvas.TextOut(xc+Cr4x,yc+Cry,inttostr(BS))
                    else Canvas.TextOut(xc+Cr5x,yc+Cry,inttostr(BS)); //max points is 17292
        Canvas.Brush.Color:=clWhite;
      end;
    end;
  end;
end;

procedure TForm1.NewGame1Click(Sender: TObject);
begin
  Confirm:=0;
  if ((Opts7=1) and (NeedNewGameQuestion1=1)) then
  begin
    if MessageDlg('Do you really want to begin a new game?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Confirm:=1 else Confirm:=0;
  end;
  NeedNewGameQuestion1:=1;

  if Confirm=0 then
  begin
    Undo1.Enabled:=False; SpeedButton1.Enabled:=False;
    //erase lines around ballz if they are
    if selected=1 then
    begin
      selected:=0;
      Ballz:=0;
      //clear ArrMask
      for i:=1 to 11 do for j:=1 to 12 do ArrMask[i,j]:=0;
    end;
    //modify the statistics if needed (if not in guest mode) and play sounds
    for k:=1 to 4 do
    begin
      if style=k then
      begin
        if Opts4=0 then
        begin
          bonus:=10000;
          for i:=1 to 11 do for j:=1 to jmax do if ((Arr[i,j]<>0) and (bonus>=2000)) then Bonus:=Bonus-2000; //count the ballz that lasted after the GameEnd
          stat[2,k]:=trunc((stat[2,k]*stat[1,k]+Score+Bonus)/(Stat[1,k]+1));
          stat[1,k]:=stat[1,k]+1;
          if Score>Stat[3,k] then
          begin
          Stat[3,k]:=Score;
            //sound effect if HiScore
            if Opts8=1 then begin if SoundsType=0 then sndPlaySound('HiScore', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC) else if SoundPlayed<>1 then begin sndPlaySound('HiScoreOrig', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC); end; end;
          end else
          //sound effect if not HiScore (but NewGame)
          begin
            if Opts8=1 then begin if SoundsType=0 then sndPlaySound('NewGame', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC) else if SoundPlayed<>1 then begin sndPlaySound('NewGameOrig', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC); end; end;
          end;
        end else
        begin
        //sound effect if NewGame in Guest Mode
          if Opts8=1 then begin if SoundsType=0 then sndPlaySound('NewGame', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC) else if SoundPlayed<>1 then begin sndPlaySound('NewGameOrig', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC); end; end;
        end;
      end;
    end;
    SoundPlayed:=0;
    //Clear current score and bonus
    Score:=0;
    ScoreUndo:=0;
    Label3.Caption:=inttostr(trunc(Score/100));
    Bonus:=10000;
    //modify the game style & label and clear the edges of field
    Canvas.Pen.Color:=clWhite;
    Canvas.Rectangle(4,1,CWidth-1,y1);
    Canvas.Rectangle(4,1,x1,CHeight-1);
    if (((StyleNext=1) or (StyleNext=3)) and ((Style=2) or (Style=4))) then
    begin
      Canvas.Rectangle(4+CWidth-1-x1,1,CWidth-1,CHeight-1);
    end;
    if (((StyleNext=2) or (StyleNext=4)) and ((Style=1) or (Style=3))) then
    begin
      Canvas.Rectangle(4+CWidth-1-x1,1,CWidth-1,CHeight-1);
      Canvas.Rectangle(4,CHeight-BallSize-y1,CWidth-1,CHeight-BallSize+1);
    end;
    Opts4:=GuestNext;
    Style:=StyleNext;
    if style=1 then begin Label4.Caption:='Standard'; jmax:=12; end;
    if style=2 then begin Label4.Caption:='Continuous'; jmax:=11; end;
    if style=3 then begin Label4.Caption:='Shifter'; jmax:=12; end;
    if style=4 then begin Label4.Caption:='MegaShift'; jmax:=11; end;
    //generate a StAlt map
    if ((Style=2) or (Style=4)) then
    begin
      Canvas.Pen.Color:=clBlack;
      Canvas.Rectangle(3,CHeight-BallSize,CWidth,CHeight);
      if StPointer+11>22 then
      begin
        StPointer:=StPointer-11
      end else
      begin
        StPointer:=StPointer+11;
      end;
      for m:=1 to 11 do
      begin
        StAlt[m]:=StRand[StPointer,m];
      end;
      //generate the pseudo-random StAlt map at the [Current+11,j] field
      StAltCnt:=Random(11)+1;
      if StPointer+11-1>22 then
      begin
        for n:=1 to StAltCnt do
        begin
          StRand[StPointer-11-1,12-n]:=Random(5)+1;
        end;
        if StAltCnt<11 then
        begin
          for n:=StAltCnt+1 to 11 do
          begin
            StRand[StPointer-11-1,12-n]:=0;
          end;
        end;
      end else
      begin
        for n:=1 to StAltCnt do
        begin
          StRand[StPointer+11-1,12-n]:=Random(5)+1;
        end;
        if StAltCnt<11 then
        begin
          for n:=StAltCnt+1 to 11 do
          begin
            StRand[StPointer+11-1,12-n]:=0;
          end;
        end;
      end;
      StAltCnt:=0;
      for m:=1 to 11 do
      begin
        if StAlt[m]<>0 then StAltCnt:=StAltCnt+1;
      end;
      if BigBoard=0 then
      begin
        for i:=12-StAltCnt to 11 do
        begin
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            end else
            begin
              if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            end;
          finally
            Form1.Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end else
      begin
        for i:=12-StAltCnt to 11 do
        begin
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            end else
            begin
              if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
              if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            end;
          finally
            Form1.Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end;
    //generate a new Ballz map
    if BigBoard=0 then
    begin
      for i:=1 to 11 do
      begin
        for j:=1 to jmax do
        begin
          Arr[i,j]:=Random(5)+1;
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end else
            begin
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end;
          finally
            Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end else
    begin
      for i:=1 to 11 do
      begin
        for j:=1 to jmax do
        begin
          Arr[i,j]:=Random(5)+1;
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end else
            begin
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end;
          finally
            Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end;
    if ((Style=2) or (Style=4)) then
    begin
      for i:=1 to 11 do
      begin
        Arr[i,12]:=0;
      end;
    end;
  end;
end;

procedure TForm1.Undo1Click(Sender: TObject);
begin
  //sound effect if Undo
  if Opts8=1 then begin if SoundsType=0 then sndPlaySound('Undo', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC) else sndPlaySound('UndoOrig', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC); end;
  Score:=ScoreUndo;
  Label3.Caption:=inttostr(trunc(Score/100));
  Ballz:=0;
  //delete a circle with points and restore ballz under it
  if selected=1 then
  begin
    ic1:=trunc(((xc-x1)/BallSize)+1);
    jc1:=trunc(((yc-y1)/BallSize)+1);
    ic2:=trunc(((xc-x1+CircleRadius)/BallSize));
    jc2:=trunc(((yc-y1+CircleRadius)/BallSize));
    if ic1<1 then begin ic2:=trunc(((xc-x1+CircleRadius-1)/BallSize)+1); ic1:=1; end;
    if jc1<1 then begin jc2:=trunc(((yc-y1+CircleRadius-1)/BallSize)+1); jc1:=1; end;
    if BigBoard=0 then
    begin
      for i:= ic1 to ic2 do
      begin
        for j:= jc1 to jc2 do
        begin
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end else
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end;
          finally
            Form1.Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end else
    begin
      for i:= ic1 to ic2 do
      begin
        for j:= jc1 to jc2 do
        begin
          Bitmap:=TBitmap.Create;
          try
            if ColorBW=0 then
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end else
            begin
              if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
              if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            end;
          finally
            Form1.Canvas.Brush.Bitmap:=nil;
            Bitmap.Free;
          end;
        end;
      end;
    end;
    Canvas.Pen.Color:=clWhite;
    if ((Style=2) or (Style=4)) then Canvas.Rectangle(4,1,x1,CHeight-BallSize) else Canvas.Rectangle(4,1,x1,CHeight-1);
    Canvas.Rectangle(4,1,CWidth-1,y1);
  end;
  //draw the previous StAlt Ballz
  if (((Style=2) or (Style=4)) and (StAltUndoNeeded=1)) then
  begin
    Canvas.Pen.Color:=clBlack;
    Canvas.Rectangle(3,CHeight-BallSize,CWidth,CHeight);
    StPointer:=StPointerUndo;
    StAltCnt:=0;
    for i:=1 to 11 do
    begin
      StAlt[i]:=StRand[StPointer,i];
      if StAlt[i]<>0 then StAltCnt:=StAltCnt+1;
    end;
    if BigBoard=0 then
    begin
      for i:=12-StAltCnt to 11 do
      begin
        Bitmap:=TBitmap.Create;
        try
          if ColorBW=0 then
          begin
            if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
          end else
          begin
            if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
          end;
        finally
          Form1.Canvas.Brush.Bitmap:=nil;
          Bitmap.Free;
        end;
      end;
    end else
    begin
      for i:=12-StAltCnt to 11 do
      begin
        Bitmap:=TBitmap.Create;
        try
          if ColorBW=0 then
          begin
            if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
          end else
          begin
            if StAlt[i]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
            if StAlt[i]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-sm-bw'); Canvas.Draw(trunc((4+CWidth-StAltCnt*BallSizeSm)/2+(12-i-1)*BallSizeSm),(CHeight-BallSize+BallSmDeltaY),BitMap);
          end;
        finally
          Form1.Canvas.Brush.Bitmap:=nil;
          Bitmap.Free;
        end;
      end;
    end;
    StAltUndoNeeded:=0;
  end;
//draw the previous ballz position
  if BigBoard=0 then
  begin
    for i:=1 to 11 do
    begin
      for j:=1 to jmax do
      begin
        Arr[i,j]:=ArrUndo[i,j];
        Bitmap:=TBitmap.Create;
        try
          if ColorBW=0 then
          begin
            if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
          end else
          begin
            if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
          end;
        finally
          Form1.Canvas.Brush.Bitmap:=nil;
          Bitmap.Free;
        end;
      end;
    end;
  end else
  begin
    for i:=1 to 11 do
    begin
      for j:=1 to jmax do
      begin
        Arr[i,j]:=ArrUndo[i,j];
        Bitmap:=TBitmap.Create;
        try
          if ColorBW=0 then
          begin
            if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
          end else
          begin
            if Arr[i,j]=0 then Bitmap.LoadFromResourceName(HInstance, 'Blank-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=1 then Bitmap.LoadFromResourceName(HInstance, 'Blue-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=2 then Bitmap.LoadFromResourceName(HInstance, 'Cyan-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=3 then Bitmap.LoadFromResourceName(HInstance, 'Green-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=4 then Bitmap.LoadFromResourceName(HInstance, 'Red-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
            if Arr[i,j]=5 then Bitmap.LoadFromResourceName(HInstance, 'Yellow-lg-bw'); Canvas.Draw((x1+(i-1)*BallSize),(y1+(j-1)*BallSize),BitMap);
          end;
        finally
          Form1.Canvas.Brush.Bitmap:=nil;
          Bitmap.Free;
        end;
      end;
    end;
  end;
  Undo1.Enabled:=False; SpeedButton1.Enabled:=False;
  //reset the selection mask array and selection status
  Selected:=0;
  for i:=1 to 11 do
  begin
    for j:=1 to jmax do
    begin
     ArrMask[i,j]:=0;
    end;
  end;
end;

procedure TForm1.Statistics1Click(Sender: TObject);
begin
  Form1.Enabled:=False;
  Form2.Left:=trunc((Form1.Width-Form2.Width)/2+Form1.Left);
  Form2.Top:=trunc((Form1.Height-Form2.Height)/2+Form1.Top);
  Form2.Label1.Caption:=inttostr(stat[1,1]); Form2.Label2.Caption:=inttostr(stat[1,2]); Form2.Label3.Caption:=inttostr(stat[1,3]); Form2.Label4.Caption:=inttostr(stat[1,4]);
  if Opts6=1 then
  begin
    Form2.Label5.Caption:=inttostr(trunc(stat[2,1]/100))+'.'+inttostr(stat[2,1] mod 100); Form2.Label6.Caption:=inttostr(trunc(stat[2,2]/100))+'.'+inttostr(stat[2,2] mod 100); Form2.Label7.Caption:=inttostr(trunc(stat[2,3]/100))+'.'+inttostr(stat[2,3] mod 100); Form2.Label8.Caption:=inttostr(trunc(stat[2,4]/100))+'.'+inttostr(stat[2,4] mod 100);
  end else
  begin
    Form2.Label5.Caption:=inttostr(round(stat[2,1]/100)); Form2.Label6.Caption:=inttostr(round(stat[2,2]/100)); Form2.Label7.Caption:=inttostr(round(stat[2,3]/100)); Form2.Label8.Caption:=inttostr(round(stat[2,4]/100));
  end;
  Form2.Label9.Caption:=inttostr(trunc(stat[3,1]/100)); Form2.Label10.Caption:=inttostr(trunc(stat[3,2]/100)); Form2.Label11.Caption:=inttostr(trunc(stat[3,3]/100)); Form2.Label12.Caption:=inttostr(trunc(stat[3,4]/100));
  Form2.Visible:=True;
end;

procedure TForm1.Options1Click(Sender: TObject);
begin
  Form1.Enabled:=False;
  Form3.Left:=trunc((Form1.Width-Form3.Width)/2+Form1.Left);
  Form3.Top:=trunc((Form1.Height-Form3.Height)/2+Form1.Top);
  If Opts8=1 then Form3.CheckBox1.Checked:=True else Form3.CheckBox1.Checked:=False;
  If Opts7=1 then Form3.CheckBox2.Checked:=True else Form3.CheckBox2.Checked:=False;
  If Opts6=1 then Form3.CheckBox3.Checked:=True else Form3.CheckBox3.Checked:=False;
  If Opts5=1 then Form3.CheckBox4.Checked:=True else Form3.CheckBox4.Checked:=False;
  If GuestNext=1 then Form3.CheckBox5.Checked:=True else Form3.CheckBox5.Checked:=False;
  BoardChangedSize:=BigBoard;
  If BigBoard=1 then Form3.CheckBox6.Checked:=True else Form3.CheckBox6.Checked:=False;
  Form3.ComboBox1.ItemIndex:=StyleNext-1;
  ColorBWOld:=ColorBW;
  Form3.ComboBox2.ItemIndex:=ColorBW;
  Form3.ComboBox3.ItemIndex:=SoundsType;
  Form3.Visible:=True;
end;

procedure TForm1.ExitProgram1Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Undo1.Click;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  Form5.Left:=trunc((Form1.Width-Form5.Width)/2+Form1.Left);
  Form5.Top:=trunc((Form1.Height-Form5.Height)/2+Form1.Top);
  Form1.Enabled:=False;
  Form5.Visible:=True;
end;

procedure TForm1.Manual1Click(Sender: TObject);
begin
  Form6.Left:=trunc((Form1.Width-Form6.Width)/2+Form1.Left);
  Form6.Top:=trunc((Form1.Height-Form6.Height)/2+Form1.Top);
  Form1.Enabled:=False;
  Form6.Visible:=True;
end;

procedure TForm1.VersionHistory1Click(Sender: TObject);
begin
  Form7.Left:=trunc((Form1.Width-Form7.Width)/2+Form1.Left);
  Form7.Top:=trunc((Form1.Height-Form7.Height)/2+Form1.Top);
  Form1.Enabled:=False;
  Form7.Visible:=True;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form1.close;
end;

end.
