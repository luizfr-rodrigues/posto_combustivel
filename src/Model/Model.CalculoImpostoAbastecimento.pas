unit Model.CalculoImpostoAbastecimento;

interface

uses
  Model.Abastecimento;

type
  ICalculoImpostoAbastecimento = interface
    ['{C848DB66-B244-42C0-8649-DB384CB75D7D}']
    procedure Calcular(const AAbastecimento: TAbastecimento);
  end;

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
