unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, MMSystem;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Button1: TButton;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm4.Button1Click(Sender: TObject);
begin
Form4.Close;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Unit1.Form1.NeedNewGameQuestion1:=0;
  Unit1.Form1.NewGame1.Click; //creates a new game;
  Form1.Enabled:=True;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  if Unit1.Form1.Opts4=1 then
  begin
    Label4.Caption:='---';
    Label4.Enabled:=False;
    Label5.Caption:='---';
    Label5.Enabled:=False;
    Label9.Enabled:=False;
    Label10.Enabled:=False;
  end else
  begin
    Label4.Enabled:=True;
    Label5.Enabled:=True;
    Label9.Enabled:=True;
    Label10.Enabled:=True;
  end;

  Unit1.Form1.SoundPlayed1:=0;

  if ((Unit1.Form1.Opts8=1) and (Form4.Caption='High Score!')) then
  begin
    if Form1.SoundsType1=0 then sndPlaySound('HiScore', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC) else sndPlaySound('HiScoreOrig', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC);
    Unit1.Form1.SoundPlayed1:=1;
  end;

  if ((Unit1.Form1.Opts8=1) and (Form4.Caption='Game Over!')) then
  begin
    if Form1.SoundsType1=0 then sndPlaySound('GameOver', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC) else sndPlaySound('GameOverOrig', SND_RESOURCE Or SND_NODEFAULT Or SND_ASYNC);
    Unit1.Form1.SoundPlayed1:=1;
  end;
end;

procedure TForm4.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form4.close;
end;

end.
