unit Infra.DAO.AbastecimentoDAOTest;

interface

uses
  DUnitX.TestFramework, Dominio.Interfaces.AbastecimentoDAO, Datasnap.DBClient, Infra.Conexao.Interfaces;

type
  [TestFixture]
  TAbastecimentoDAOTest = class
  private
    FAbastecimentoDAO: IAbastecimentoDAO;

    FDataSet: TClientDataSet;
    FQueryFactory: IQueryFactory;

    procedure CarregarDataSetConsulta;
    procedure PrepararDataSet;

  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure ConsultarListaAgrupadoPorDia_Deve_Retornar_Lista_Preenchida;

    [Test]
    procedure Salvar_Nao_Deve_Gerar_Excecao;
  end;

implementation

uses
  Infra.Mock.QueryFactoryMock, Infra.DAO.AbastecimentoDAO, System.SysUtils,
  Data.DB, Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO,
  System.Generics.Collections, Dominio.Model.Abastecimento;

procedure TAbastecimentoDAOTest.CarregarDataSetConsulta;
begin
  PrepararDataSet;

  FDataSet.AppendRecord([EncodeDate(2025, 11, 08), 100.00, 1, 1, 'Gasolina']);
  FDataSet.AppendRecord([EncodeDate(2025, 11, 08), 353.99, 4, 2, 'Óleo Diesel']);
  FDataSet.First;
end;

procedure TAbastecimentoDAOTest.ConsultarListaAgrupadoPorDia_Deve_Retornar_Lista_Preenchida;
var
  ListaAbastecimento: TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>;
  Abastecimento: TRelAbastecimentoAgrupadoPorDiaDTO;
begin
  ListaAbastecimento := TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>.Create(True);
  try
    CarregarDataSetConsulta;
    FAbastecimentoDAO.ConsultarListaAgrupadoPorDia(ListaAbastecimento);

    Assert.AreEqual(FDataSet.RecordCount, ListaAbastecimento.Count);

    Abastecimento := ListaAbastecimento[0];
    Assert.AreEqual(EncodeDate(2025, 11, 08), Abastecimento.Data);
    Assert.AreEqual(Double(100.00), Abastecimento.Total);
    Assert.AreEqual(1, Abastecimento.NumeroBomba);
    Assert.AreEqual(1, Abastecimento.NumeroTanque);
    Assert.AreEqual('Gasolina', Abastecimento.DescrTipoCombustivel);

    Abastecimento := ListaAbastecimento[1];
    Assert.AreEqual(EncodeDate(2025, 11, 08), Abastecimento.Data);
    Assert.AreEqual(Double(353.99), Abastecimento.Total);
    Assert.AreEqual(4, Abastecimento.NumeroBomba);
    Assert.AreEqual(2, Abastecimento.NumeroTanque);
    Assert.AreEqual('Óleo Diesel', Abastecimento.DescrTipoCombustivel);

  finally
    FreeAndNil(ListaAbastecimento);
  end;
end;

procedure TAbastecimentoDAOTest.PrepararDataSet;
begin
  if FDataSet.Active then
  begin
    FDataSet.EmptyDataSet;
  end;

  FDataSet.FieldDefs.Clear;
  FDataSet.FieldDefs.Add('DATA_ABASTECIMENTO', ftDate);
  FDataSet.FieldDefs.Add('TOTAL_VALOR', ftFloat);
  FDataSet.FieldDefs.Add('NUMERO_BOMBA', ftInteger);
  FDataSet.FieldDefs.Add('NUMERO_TANQUE', ftInteger);
  FDataSet.FieldDefs.Add('DESCRICAO_TIPO_COMBUSTIVEL', ftString, 30);
  FDataSet.CreateDataSet;
end;

procedure TAbastecimentoDAOTest.Salvar_Nao_Deve_Gerar_Excecao;
var
  Abastecimento: TAbastecimento;
begin
  Abastecimento := TAbastecimento.Create;
  try
    try
      FAbastecimentoDAO.Salvar(Abastecimento);
    except
      Assert.Fail('Salvar não deve gerar exceção');
    end;

  finally
    FreeAndNil(Abastecimento);
  end;
end;

procedure TAbastecimentoDAOTest.Setup;
begin
  FDataSet := TClientDataSet.Create(nil);
  FQueryFactory := TQueryFactoryMock.Create(FDataSet);

  FAbastecimentoDAO := TAbastecimentoDAO.New(FQueryFactory);
end;

procedure TAbastecimentoDAOTest.TearDown;
begin
  FreeAndNil(FDataSet);
end;

initialization
  TDUnitX.RegisterTestFixture(TAbastecimentoDAOTest);

end.
