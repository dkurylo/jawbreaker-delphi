unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm3 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Panel2: TPanel;
    CheckBox6: TCheckBox;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    ComboBox3: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox2KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox3KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox4KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox3KeyPress(Sender: TObject; var Key: Char);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox5KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox6KeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm3.Button1Click(Sender: TObject);
begin
Form3.Close;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CheckBox1.Checked=True then Unit1.Form1.Opts8:=1 else Unit1.Form1.Opts8:=0;
  if CheckBox2.Checked=True then Unit1.Form1.Opts7:=1 else Unit1.Form1.Opts7:=0;
  if CheckBox3.Checked=True then Unit1.Form1.Opts6:=1 else Unit1.Form1.Opts6:=0;
  if CheckBox4.Checked=True then Unit1.Form1.Opts5:=1 else Unit1.Form1.Opts5:=0;
  if CheckBox5.Checked=True then begin Unit1.Form1.Opts4:=1; Unit1.Form1.GuestNext1:=1; end else Unit1.Form1.GuestNext1:=0;
  if CheckBox6.Checked=True then Unit1.Form1.BigBoard1:=1 else Unit1.Form1.BigBoard1:=0;
  Unit1.Form1.StyleNext1:=Combobox1.ItemIndex+1;
  Unit1.Form1.ColorBW1:=Combobox2.ItemIndex;
  Unit1.Form1.SoundsType1:=Combobox3.ItemIndex;
  Form1.Enabled:=True;
end;



procedure TForm3.CheckBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.CheckBox2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.CheckBox3KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.CheckBox4KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.CheckBox5KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.CheckBox6KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.ComboBox3KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

procedure TForm3.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(27) then Form3.close;
end;

end.

