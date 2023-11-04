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
  public
    class function New: ICalculoImpostoAbastecimento;
    procedure Calcular(const AAbastecimento: TAbastecimento);
  end;

implementation

uses
  System.Math;

const
  PERCENTUAL_IMPOSTO = 13.00;

{ TCalculoImpostoAbastecimento }

procedure TCalculoImpostoAbastecimento.Calcular(const AAbastecimento: TAbastecimento);
var
  Valor_Imposto: Double;
begin
  Valor_Imposto := AAbastecimento.Valor * (PERCENTUAL_IMPOSTO / 100);
  Valor_Imposto := RoundTo(Valor_Imposto, -2);

  AAbastecimento.Percentual_Imposto := PERCENTUAL_IMPOSTO;
  AAbastecimento.Valor_Imposto := Valor_Imposto;
end;

class function TCalculoImpostoAbastecimento.New: ICalculoImpostoAbastecimento;
begin
  Result := TCalculoImpostoAbastecimento.Create;
end;

end.
