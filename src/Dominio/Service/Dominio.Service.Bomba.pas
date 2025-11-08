unit Dominio.Service.Bomba;

interface

uses
  Dominio.Interfaces.BombaService, Dominio.Model.Bomba, Generics.Collections;

type
  TBombaService = class(TInterfacedObject, IBombaService)
  public
    class function New: IBombaService;

    procedure ConsultarTodos(AListaBombas: TObjectList<TBomba>);
    procedure ConsultarPorId(const AId_Bomba: Integer; ABomba: TBomba);
  end;

implementation

{ TBombaService }

uses
  Infra.DAO.DAOFactory;

procedure TBombaService.ConsultarPorId(const AId_Bomba: Integer; ABomba: TBomba);
begin
  TDAOFactory.Bomba.ConsultarPorId(AId_Bomba, ABomba);
end;

procedure TBombaService.ConsultarTodos(AListaBombas: TObjectList<TBomba>);
begin
  TDAOFactory.Bomba.ConsultarTodos(AListaBombas);
end;

class function TBombaService.New: IBombaService;
begin
  Result := TBombaService.Create;
end;

end.
