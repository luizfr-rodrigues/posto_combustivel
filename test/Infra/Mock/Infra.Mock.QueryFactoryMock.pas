unit Infra.Mock.QueryFactoryMock;

interface

uses
  Infra.Conexao.Interfaces, Data.DB;

type
  TQueryFactoryMock = class(TInterfacedObject, IQueryFactory)
  private
    FDataSet: TDataSet;

  public
    constructor Create(ADataSet: TDataSet);
    function CriarQuery: IQuery;
  end;

implementation

{ TQueryFactoryMock }

uses
  Infra.Mock.QueryMock;

constructor TQueryFactoryMock.Create(ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
end;

function TQueryFactoryMock.CriarQuery: IQuery;
begin
  Result := TQueryMock.Create(FDataSet);
end;

end.
