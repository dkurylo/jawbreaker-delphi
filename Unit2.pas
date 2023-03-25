unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
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
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2KeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;


implementation

uses Unit1;

{$R *.DFM}

procedure TForm2.Button1Click(Sender: TObject);
begin
Form2.Close;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Enabled:=True;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
if MessageDlg('Do you really want to reset your statistics?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  Begin
  Form2.Label1.Caption:='0'; Form2.Label2.Caption:='0'; Form2.Label3.Caption:='0'; Form2.Label4.Caption:='0';
  if Unit1.Form1.Opts6=1 then
  begin
    Form2.Label5.Caption:='0.0'; Form2.Label6.Caption:='0.0'; Form2.Label7.Caption:='0.0'; Form2.Label8.Caption:='0.0';
  end else
  begin
    Form2.Label5.Caption:='0'; Form2.Label6.Caption:='0'; Form2.Label7.Caption:='0'; Form2.Label8.Caption:='0';
  end;
  Form2.Label9.Caption:='0'; Form2.Label10.Caption:='0'; Form2.Label11.Caption:='0'; Form2.Label12.Caption:='0';
  Unit1.Form1.Stat11:=0; Unit1.Form1.Stat21:=0; Unit1.Form1.Stat31:=0;
  Unit1.Form1.Stat12:=0; Unit1.Form1.Stat22:=0; Unit1.Form1.Stat32:=0;
  Unit1.Form1.Stat13:=0; Unit1.Form1.Stat23:=0; Unit1.Form1.Stat33:=0;
  Unit1.Form1.Stat14:=0; Unit1.Form1.Stat24:=0; Unit1.Form1.Stat34:=0;
  end;
  Form2.Close;
end;



procedure TForm2.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form2.close;
end;

procedure TForm2.Button2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form2.close;
end;

end.
