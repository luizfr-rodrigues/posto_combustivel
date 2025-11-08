unit Dominio.Model.CalculoImpostoAbastecimento;

interface

uses
  Dominio.Interfaces.CalculoImposto, Dominio.Model.Abastecimento;

type
  TCalculoImpostoAbastecimento = class(TInterfacedObject, ICalculoImpostoAbastecimento)
  private
    function RetornarPercentualImpostos: Double;

  public
    class function New: ICalculoImpostoAbastecimento;
    procedure Calcular(const AAbastecimento: TAbastecimento);
  end;

implementation

uses
  System.Math;

{ TCalculoImpostoAbastecimento }

procedure TCalculoImpostoAbastecimento.Calcular(const AAbastecimento: TAbastecimento);
var
  PercentualImposto, ValorImpostoCalculado: Double;
begin
  PercentualImposto := RetornarPercentualImpostos;

  ValorImpostoCalculado := AAbastecimento.Valor * (PercentualImposto / 100);
  ValorImpostoCalculado := RoundTo(ValorImpostoCalculado, -2);

  AAbastecimento.Percentual_Imposto := PercentualImposto;
  AAbastecimento.Valor_Imposto := ValorImpostoCalculado;
end;

class function TCalculoImpostoAbastecimento.New: ICalculoImpostoAbastecimento;
begin
  Result := TCalculoImpostoAbastecimento.Create;
end;

function TCalculoImpostoAbastecimento.RetornarPercentualImpostos: Double;
begin
  Result := 13.00;
end;

end.
