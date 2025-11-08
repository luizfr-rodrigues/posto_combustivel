unit Dominio.Interfaces.AbastecimentoDAO;

interface

uses
  Dominio.Model.Abastecimento, Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO, Generics.Collections;

type
  IAbastecimentoDAO = interface
    ['{A9A1E6D1-A787-4EF3-B15D-ABCF36A63868}']

    procedure Salvar(AAbastecimento: TAbastecimento);
    procedure ConsultarListaAgrupadoPorDia(AListaAbastecimentoDTO: TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>);
  end;

implementation

end.
