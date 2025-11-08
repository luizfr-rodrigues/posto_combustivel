unit Infra.Conexao.ConexaoFactory;

interface

uses
  Infra.Conexao.Interfaces, Data.DB;

type
  TConexaoFactory = class(TInterfacedObject, IConexaoBDFactory)
  private
    class var FConexao: IConexaoBD;

  public
    class function New: IConexaoBDFactory;
    function RetornarConexao: IConexaoBD;
  end;

  TQueryFactory = class(TInterfacedObject, IQueryFactory)
  public
    class function New: IQueryFactory;
    function CriarQuery: IQuery;
  end;

implementation

uses
  Infra.Conexao.FiredacConexaoAdapter;

{ TConexaoFactory }

function TConexaoFactory.RetornarConexao: IConexaoBD;
begin
  if not Assigned(FConexao) then
    FConexao := TFDConexaoAdapter.New;

   Result := FConexao;
end;

class function TConexaoFactory.New: IConexaoBDFactory;
begin
  Result := TConexaoFactory.Create;
end;

{ TQueryFactory }

class function TQueryFactory.New: IQueryFactory;
begin
  Result := TQueryFactory.Create;
end;

function TQueryFactory.CriarQuery: IQuery;
begin
  Result := TFDQueryAdapter.New(TConexaoFactory.New.RetornarConexao);
end;

end.
