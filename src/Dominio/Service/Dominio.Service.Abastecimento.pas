unit Dominio.Service.Abastecimento;

interface

uses
  Dominio.Interfaces.AbastecimentoService, Dominio.Model.Abastecimento, Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO, Generics.Collections,
  Dominio.Interfaces.CalculoImposto;

type
  TAbastecimentoService = class(TInterfacedObject, IAbastecimentoService)
  public
    class function New: IAbastecimentoService;

    procedure Registrar(AAbastecimento: TAbastecimento; ACalculoImposto: ICalculoImpostoAbastecimento);
    procedure ConsultarListaRelAgrupadoPorDia(AListaAbastecimentoDTO: TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>);
  end;

implementation

uses
  Infra.DAO.DAOFactory;

{ TAbastecimentoService }

procedure TAbastecimentoService.ConsultarListaRelAgrupadoPorDia(AListaAbastecimentoDTO: TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>);
begin
  TDAOFactory.Abastecimento.ConsultarListaAgrupadoPorDia(AListaAbastecimentoDTO);
end;

class function TAbastecimentoService.New: IAbastecimentoService;
begin
  Result := TAbastecimentoService.Create;
end;

procedure TAbastecimentoService.Registrar(AAbastecimento: TAbastecimento; ACalculoImposto: ICalculoImpostoAbastecimento);
begin
  AAbastecimento.Validar;

  ACalculoImposto.Calcular(AAbastecimento);
  TDAOFactory.Abastecimento.Salvar(AAbastecimento);
end;

end.
