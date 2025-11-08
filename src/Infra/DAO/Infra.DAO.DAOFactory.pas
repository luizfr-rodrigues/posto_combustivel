unit Infra.DAO.DAOFactory;

interface

uses
  Dominio.Interfaces.BombaDAO, Dominio.Interfaces.AbastecimentoDAO;

type
  TDAOFactory = class
  public
    class function Bomba: IBombaDAO;
    class function Abastecimento: IAbastecimentoDAO;
  end;

implementation

{ TDAOFactory }

uses
  Infra.DAO.BombaDAO, Infra.DAO.AbastecimentoDAO, Infra.Conexao.ConexaoFactory;

class function TDAOFactory.Abastecimento: IAbastecimentoDAO;
begin
  Result := TAbastecimentoDAO.New(TQueryFactory.New);
end;

class function TDAOFactory.Bomba: IBombaDAO;
begin
  Result := TBombaDAO.New(TQueryFactory.New);
end;

end.
