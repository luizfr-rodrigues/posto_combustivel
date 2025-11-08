unit Dominio.Interfaces.CalculoImposto;

interface

uses
  Dominio.Model.Abastecimento;

Type
  ICalculoImpostoAbastecimento = interface
    ['{C848DB66-B244-42C0-8649-DB384CB75D7D}']

    procedure Calcular(const AAbastecimento: TAbastecimento);
  end;

implementation

end.
