unit Dominio.Model.CalculoImpostoAbastecimentoTest;

interface

uses
  DUnitX.TestFramework, Dominio.Model.Abastecimento;

type
  [TestFixture]
  TCalculoImpostoAbastecimentoTest = class
  private
    FAbastecimento: TAbastecimento;

  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure CalcularTest;

    [Test]
    procedure CalcularComArredondamentoTest;
  end;

implementation

uses
  Dominio.Model.CalculoImpostoAbastecimento, System.SysUtils;

procedure TCalculoImpostoAbastecimentoTest.CalcularComArredondamentoTest;
var
  ValorImpostoEsperado: Double;
begin
  FAbastecimento.Valor := 79.99;
  // ( 79.99 * (13 / 100) )
  ValorImpostoEsperado := 10.40;

  TCalculoImpostoAbastecimento.New.Calcular(FAbastecimento);

  Assert.AreEqual(ValorImpostoEsperado, FAbastecimento.Valor_Imposto);
end;

procedure TCalculoImpostoAbastecimentoTest.CalcularTest;
var
  ValorImpostoEsperado: Double;
begin
  FAbastecimento.Valor := 100.00;
  // ( 100.00 * (13 / 100) )
  ValorImpostoEsperado := 13.00;

  TCalculoImpostoAbastecimento.New.Calcular(FAbastecimento);

  Assert.AreEqual(ValorImpostoEsperado, FAbastecimento.Valor_Imposto);
end;

procedure TCalculoImpostoAbastecimentoTest.Setup;
begin
  FAbastecimento := TAbastecimento.Create;
end;

procedure TCalculoImpostoAbastecimentoTest.TearDown;
begin
  FreeAndNil(FAbastecimento);
end;

initialization
  TDUnitX.RegisterTestFixture(TCalculoImpostoAbastecimentoTest);

end.
