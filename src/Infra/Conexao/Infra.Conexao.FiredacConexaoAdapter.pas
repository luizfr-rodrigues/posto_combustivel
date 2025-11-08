unit Infra.Conexao.FiredacConexaoAdapter;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.DApt, Data.DB, FireDAC.Stan.Param,
  Infra.Conexao.Interfaces;

type
  TFDConexaoAdapter = class(TInterfacedObject, IConexaoBD)
  private
    FConnection: TFDConnection;

    procedure ConfigurarConexao;

  public
    class function New: IConexaoBD;

    constructor Create;
    destructor Destroy; override;

    function Connection: TCustomConnection;
  end;

  TFDQueryAdapter = class(TInterfacedObject, IQuery)
  private
    FQuery: TFDQuery;

  public
    class function New(const AConexao: IConexaoBD): IQuery;

    constructor Create(const AConexao: IConexaoBD);
    destructor Destroy; override;

    procedure SetSQL(const ASQL: string);
    procedure AddParam(const AName: string; const AValue: Variant);

    procedure Open;
    procedure Close;
    procedure ExecSQL;

    function DataSet: TDataSet;
  end;

implementation

uses
  System.SysUtils;

const
  FIREBIRD_DRIVER_ID = 'FB';
  FIREBIRD_USUARIO = 'SYSDBA';
  FIREBIRD_SENHA = 'masterkey';

  PATH_DIRETORIO_BANCO = '..\database\';
  BANCO_DADOS = 'POSTO.FDB';

{ TFDConexaoAdapter }

procedure TFDConexaoAdapter.ConfigurarConexao;
begin
  with FConnection do
  begin
    Params.DriverID := FIREBIRD_DRIVER_ID;
    Params.Database := PATH_DIRETORIO_BANCO + BANCO_DADOS;
    Params.UserName := FIREBIRD_USUARIO;
    Params.Password := FIREBIRD_SENHA;
    Params.Values['CharacterSet'] := 'UTF8';

    with FormatOptions.MapRules.Add do
    begin
      SourceDataType := dtFmtBCD;
      TargetDataType := dtDouble;
    end;

    LoginPrompt := False;
  end;
end;

function TFDConexaoAdapter.Connection: TCustomConnection;
begin
  Result := FConnection;
end;

constructor TFDConexaoAdapter.Create;
begin
  FConnection := TFDConnection.Create(nil);

  ConfigurarConexao;
  FConnection.Connected := True;
end;

destructor TFDConexaoAdapter.Destroy;
begin
  FreeAndNil(FConnection);

  inherited;
end;

class function TFDConexaoAdapter.New: IConexaoBD;
begin
  Result := TFDConexaoAdapter.Create;
end;

{ TFDQueryAdapter }

procedure TFDQueryAdapter.AddParam(const AName: string; const AValue: Variant);
begin
  FQuery.ParamByName(AName).Value := AValue;
end;

procedure TFDQueryAdapter.Close;
begin
  FQuery.Close;
end;

constructor TFDQueryAdapter.Create(const AConexao: IConexaoBD);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(AConexao.Connection);
end;

destructor TFDQueryAdapter.Destroy;
begin
  FreeAndNil(FQuery);

  inherited;
end;

procedure TFDQueryAdapter.ExecSQL;
begin
  FQuery.ExecSQL;
end;

class function TFDQueryAdapter.New(const AConexao: IConexaoBD): IQuery;
begin
  Result := TFDQueryAdapter.Create(AConexao);
end;

procedure TFDQueryAdapter.Open;
begin
  FQuery.Open;
end;

procedure TFDQueryAdapter.SetSQL(const ASQL: string);
begin
  FQuery.SQL.Text := ASQL;
end;

function TFDQueryAdapter.DataSet: TDataSet;
begin
  Result := FQuery;
end;

end.
