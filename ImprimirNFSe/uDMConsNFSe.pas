unit uDMConsNFSe;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr, ACBrDFe,
  ACBrNFSe, ACBrBase, ACBrDFeReport, ACBrNFSeDANFSeClass,
  ACBrNFSeDANFSeRLClass;

type
  TDMConsNFSe = class(TDataModule)
    sdsConsNFSe: TSQLDataSet;
    dspConsNFSe: TDataSetProvider;
    cdsConsNFSe: TClientDataSet;
    cdsConsNFSeNUMERO: TIntegerField;
    cdsConsNFSeCOD_CADCLI: TIntegerField;
    cdsConsNFSeDATA_EMISSAO: TDateField;
    cdsConsNFSeCEMP: TStringField;
    cdsConsNFSeSERIE: TStringField;
    cdsConsNFSeVALOR_TOTAL: TFMTBCDField;
    cdsConsNFSeISSQN_VALOR: TFMTBCDField;
    cdsConsNFSeIRRF_VALOR: TFMTBCDField;
    cdsConsNFSePIS_VALOR: TFMTBCDField;
    cdsConsNFSeCOFINS_VALOR: TFMTBCDField;
    cdsConsNFSeCSLL_VALOR: TFMTBCDField;
    sdsEmpresa: TSQLDataSet;
    dspEmpresa: TDataSetProvider;
    cdsEmpresa: TClientDataSet;
    cdsEmpresaCOD_CADEMPRESA: TIntegerField;
    cdsEmpresaNOME: TStringField;
    dsEmpresa: TDataSource;
    cdsEmpresaCEMP: TStringField;
    cdsConsNFSeXML: TMemoField;
    ACBrNFSeDANFSeRL1: TACBrNFSeDANFSeRL;
    ACBrNFSe1: TACBrNFSe;
    cdsConsNFSeCODIGOVERIFICACAO: TStringField;
    cdsEmpresaLOGOTIPO: TBlobField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure imprimirNFSe;
    { Public declarations }
  end;

var
  DMConsNFSe: TDMConsNFSe;

implementation

uses
  uDMConection;

{$R *.dfm}

{ TDMConsNFSe }

procedure TDMConsNFSe.imprimirNFSe;
var
 stStreamNFSe: TStringStream;
begin
  ACBrNFSe1.NotasFiscais.Clear;
  stStreamNFSe := TStringStream.Create(cdsConsNFSeXML.AsString);
  ACBrNFSe1.NotasFiscais.LoadFromStream(stStreamNFSe);
  ACBrNFSe1.NotasFiscais.Items[0].NFSe.CodigoVerificacao := cdsConsNFSeCODIGOVERIFICACAO.AsString;
  ACBrNFSe1.NotasFiscais.Items[0].NFSe.IdentificacaoRps.Numero := cdsConsNFSeNUMERO.AsString;
  ACBrNFSe1.NotasFiscais.Imprimir;
end;

procedure TDMConsNFSe.DataModuleCreate(Sender: TObject);
begin
  ACBrNFSe1.Configuracoes.Geral.CodigoMunicipio := StrToInt(DMConection.CodigoMunicipio);
  ACBrNFSe1.DANFSE.Logo := cdsEmpresaLOGOTIPO.AsString;
end;

end.