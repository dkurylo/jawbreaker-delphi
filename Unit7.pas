unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan;

type
  TForm7 = class(TForm)
    Panel3: TPanel;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
  Form7.Close;
end;

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Enabled:=True;
end;

procedure TForm7.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form7.close;
end;

procedure TForm7.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form7.close;
end;

end.
