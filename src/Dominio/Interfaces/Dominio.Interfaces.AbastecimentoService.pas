unit Dominio.Interfaces.AbastecimentoService;

interface

uses
  Dominio.Model.Abastecimento, Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO, Generics.Collections, Dominio.Interfaces.CalculoImposto;

type
  IAbastecimentoService = interface
    ['{A5F9EECE-5A07-4FF5-8E52-40A818C82453}']

    procedure Registrar(AAbastecimento: TAbastecimento; ACalculoImposto: ICalculoImpostoAbastecimento);
    procedure ConsultarListaRelAgrupadoPorDia(AListaAbastecimentoDTO: TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>);
  end;

implementation

end.
