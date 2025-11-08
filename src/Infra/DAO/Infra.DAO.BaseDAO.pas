unit Infra.DAO.BaseDAO;

interface

uses
  Infra.Conexao.Interfaces;

type
  TBaseDAO = class(TInterfacedObject)
  protected
    FQueryFactory: IQueryFactory;

  public
    constructor Create(AQueryFactory: IQueryFactory); virtual;
  end;

implementation

{ TBaseDAO }

constructor TBaseDAO.Create(AQueryFactory: IQueryFactory);
begin
  FQueryFactory := AQueryFactory;
end;

end.
