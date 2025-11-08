unit Dominio.Service.ServiceFactory;

interface

uses
  Dominio.Interfaces.BombaService, Dominio.Interfaces.AbastecimentoService;

type
  TServiceFactory = class
  public
    class function Bomba: IBombaService;
    class function Abastecimento: IAbastecimentoService;
  end;

implementation

{ TServiceFactory }

uses
  Dominio.Service.Bomba, Dominio.Service.Abastecimento;

class function TServiceFactory.Abastecimento: IAbastecimentoService;
begin
  Result := TAbastecimentoService.New;
end;

class function TServiceFactory.Bomba: IBombaService;
begin
  Result := TBombaService.New;
end;

end.
