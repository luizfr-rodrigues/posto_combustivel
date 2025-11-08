unit Dominio.Model.CalculoImpostoFactory;

interface

uses
  Dominio.Interfaces.CalculoImposto;

type
  TCalculoImpostoFactory = class
  public
    class function CalcImpostoAbastecimento: ICalculoImpostoAbastecimento;
  end;

implementation

{ TCalculoImpostoFactory }

uses
  Dominio.Model.CalculoImpostoAbastecimento;

class function TCalculoImpostoFactory.CalcImpostoAbastecimento: ICalculoImpostoAbastecimento;
begin
  Result := TCalculoImpostoAbastecimento.New;
end;

end.
