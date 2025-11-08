unit Dominio.Model.AbastecimentoTest;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TAbastecimentoTest = class
  public
    [Test]
    procedure ValidarFalhaTest;

    [Test]
    procedure ValidarSucessoTest;
  end;

implementation

uses
  Dominio.Model.Abastecimento, System.SysUtils, Utils.Constantes;

procedure TAbastecimentoTest.ValidarFalhaTest;
var
  Abastecimento: TAbastecimento;
  MsgExcept: string;
begin
  Abastecimento := TAbastecimento.Create;
  try
    try
      Abastecimento.Validar;
      Assert.Fail('Era esperado uma exceção');

    except
      on E: EAbastecimentoValidacao do
      begin
        MsgExcept := E.Message;
        Assert.IsTrue(MsgExcept.Contains(MSG_VALIDACAO_BOMBA_NAO_INFORMADA), 'Mensagem de exceção não contém o campo "Bomba de combustível".');
        Assert.IsTrue(MsgExcept.Contains(MSG_VALIDACAO_QTDE_NAO_INFORMADA), 'Mensagem de exceção não contém o campo "Quantidade".');
        Assert.IsTrue(MsgExcept.Contains(MSG_VALIDACAO_VALOR_NAO_INFORMADO), 'Mensagem de exceção não contém o campo "Valor".');
      end;
    end;

  finally
    FreeAndNil(Abastecimento);
  end;
end;

procedure TAbastecimentoTest.ValidarSucessoTest;
var
  Abastecimento: TAbastecimento;
begin
  Abastecimento := TAbastecimento.Create;
  try
    Abastecimento.Bomba.Id_Bomba := 1;
    Abastecimento.Quantidade := 10;
    Abastecimento.Valor := 100;

    try
      Abastecimento.Validar;
    except
      Assert.Fail('Não era esperado uma exceção');
    end;

  finally
    FreeAndNil(Abastecimento);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TAbastecimentoTest);

end.
