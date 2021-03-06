unit uDMConection;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, inifiles, Forms, Dialogs;

type
  TDMConection = class(TDataModule)
    Connection: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    CodigoMunicipio : String;
    { Public declarations }
  end;

var
  DMConection: TDMConection;

implementation

{$R *.dfm}

procedure TDMConection.DataModuleCreate(Sender: TObject);
var
  ArquivoIni, BancoDados, DriverName, UserName, PassWord: string;
  LocalServer: Integer;
  Configuracoes: TIniFile;
begin
  ArquivoIni := ExtractFilePath(Application.ExeName) + '\Config.ini';
  if not FileExists(ArquivoIni) then
  begin
    MessageDlg('Arquivo config.ini n�o encontrado!', mtInformation, [mbOK], 0);
    Exit;
  end;
  Configuracoes := TIniFile.Create(ArquivoIni);
  try
    BancoDados := Configuracoes.ReadString('NFSE', 'DATABASE', DriverName);
    DriverName := Configuracoes.ReadString('NFSE', 'DriverName', DriverName);
    UserName := Configuracoes.ReadString('NFSE', 'UserName', UserName);
    PassWord := Configuracoes.ReadString('NFSE', 'PASSWORD', '');
    CodigoMunicipio := Configuracoes.ReadString('NFSE','CodigoMunicipio','');
  finally
    Configuracoes.Free;
  end;

  try
    Connection.ConnectionName := 'Interbase';
    Connection.DriverName := 'Interbase';
    Connection.LibraryName := 'dbexpint.dll';
    Connection.VendorLib := 'gds32.dll';
    Connection.GetDriverFunc := 'getSQLDriverINTERBASE';
    Connection.LoginPrompt := False;

    Connection.Connected := False;
    Connection.Params.Values['SQLDialect'] := '3';
    Connection.Params.Values['DataBase'] := BancoDados;
    Connection.Params.Values['User_Name'] := UserName;
    Connection.Params.Values['Password'] := PassWord;
    Connection.Connected := True;
  except
    MessageDlg('Erro ao conectar o Banco de dados ' + BancoDados, mtInformation, [mbOK], 0);
  end;

end;

end.

