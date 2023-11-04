unit Model.FiredacConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.DApt, Data.DB, Model.Conexao;

type
  TFiredacConexao = class(TInterfacedObject, IConexao)
  private
    FConnection: TFDConnection;

    procedure ConfigurarConexao;

  public
    class function New: IConexao;

    constructor Create;
    destructor Destroy; override;

    function Connection: TCustomConnection;
  end;

  TFiredacQuery = class(TQueryBase)
  private
    FQuery: TFDQuery;

  public
    class function New(const AConexao: IConexao): IQuery;

    constructor Create(const AConexao: IConexao);
    destructor Destroy; override;

    function DataSet: TDataSet; override;

    procedure Open(const AStrSQL: String); override;
    procedure Close; override;

    function Data: OleVariant; override;

    procedure ExecSQL(const AStrSQL: String); override;
  end;

implementation

uses
  System.SysUtils, Datasnap.Provider;

const
  FIREBIRD_DRIVER_ID = 'FB';
  FIREBIRD_USUARIO = 'SYSDBA';
  FIREBIRD_SENHA = 'masterkey';

  PATH_DIRETORIO_BANCO = '..\database\';
  BANCO_DADOS = 'POSTO.FDB';

{ TFiredacQuery }

procedure TFiredacQuery.Close;
begin
  FQuery.Close;
end;

constructor TFiredacQuery.Create(const AConexao: IConexao);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(AConexao.Connection);
end;

destructor TFiredacQuery.Destroy;
begin
  FreeAndNil(FQuery);

  inherited;
end;

procedure TFiredacQuery.ExecSQL(const AStrSQL: String);
begin
  FQuery.ExecSQL(AStrSQL);
end;

class function TFiredacQuery.New(const AConexao: IConexao): IQuery;
begin
  Result := TFiredacQuery.Create(AConexao);
end;

procedure TFiredacQuery.Open(const AStrSQL: String);
begin
  FQuery.Open(AStrSQL);
end;

function TFiredacQuery.Data: OleVariant;
var
  Provider: TDatasetProvider;
begin
  Provider := TDataSetProvider.Create(nil);
  try
    Provider.UpdateMode := upWhereKeyOnly;
    Provider.Options := Provider.Options + [poReadOnly];
    Provider.DataSet := FQuery;

    Result := Provider.Data;

  finally
    FreeAndNil(Provider);
  end;
end;

function TFiredacQuery.DataSet: TDataSet;
begin
  Result := FQuery;
end;

{ TFiredacConexao }

procedure TFiredacConexao.ConfigurarConexao;
begin
  with FConnection do
  begin
    Params.DriverID := FIREBIRD_DRIVER_ID;
    Params.Database := PATH_DIRETORIO_BANCO + BANCO_DADOS;
    Params.UserName := FIREBIRD_USUARIO;
    Params.Password := FIREBIRD_SENHA;

    with FormatOptions.MapRules.Add do
    begin
      SourceDataType := dtFmtBCD;
      TargetDataType := dtDouble;
    end;

    LoginPrompt := False;
  end;
end;

function TFiredacConexao.Connection: TCustomConnection;
begin
  Result := FConnection;
end;

constructor TFiredacConexao.Create;
begin
  FConnection := TFDConnection.Create(nil);

  ConfigurarConexao;
  FConnection.Connected := True;
end;

destructor TFiredacConexao.Destroy;
begin
  FreeAndNil(FConnection);

  inherited;
end;

class function TFiredacConexao.New: IConexao;
begin
  Result := TFiredacConexao.Create;
end;

end.
