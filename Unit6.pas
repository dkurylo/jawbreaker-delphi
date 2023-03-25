unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm6 = class(TForm)
    Button1: TButton;
    Panel3: TPanel;
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
  Form6: TForm6;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm6.Button1Click(Sender: TObject);
begin
  Form6.Close;
end;

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Enabled:=True;
end;

procedure TForm6.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form6.close;
end;

procedure TForm6.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form6.close;
end;

end.
