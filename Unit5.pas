unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, XPMan;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm5.Button1Click(Sender: TObject);
begin
  Form5.Close;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Enabled:=True;
end;

procedure TForm5.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form5.Close;
end;

end.
