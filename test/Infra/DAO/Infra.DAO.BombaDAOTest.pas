unit Infra.DAO.BombaDAOTest;

interface

uses
  DUnitX.TestFramework, Dominio.Interfaces.BombaDAO, Datasnap.DBClient, Infra.Conexao.Interfaces;

type
  [TestFixture]
  TBombaDAOTest = class
  private
    FBombaDAO: IBombaDAO;

    FDataSet: TClientDataSet;
    FQueryFactory: IQueryFactory;

    procedure CarregarDataSetConsultarTodos;
    procedure CarregarDataSetConsultarPorId;
    procedure PrepararDataSet;

  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure ConsultarTodos_Deve_Retornar_Lista_Preenchida;

    [Test]
    procedure ConsultarPorId_Deve_Retornar_Objeto_Preenchido;
  end;

implementation

uses
  Data.DB, Infra.Mock.QueryFactoryMock, Infra.DAO.BombaDAO, System.SysUtils, System.Generics.Collections, Dominio.Model.Bomba;

procedure TBombaDAOTest.CarregarDataSetConsultarPorId;
begin
  PrepararDataSet;

  FDataSet.AppendRecord([1, 1, 1, 1, 1, 'Gasolina']);
  FDataSet.First;
end;

procedure TBombaDAOTest.CarregarDataSetConsultarTodos;
begin
  PrepararDataSet;

  FDataSet.AppendRecord([1, 1, 1, 1, 1, 'Gasolina']);
  FDataSet.AppendRecord([4, 4, 2, 2, 2, 'Óleo Diesel']);
  FDataSet.First;
end;

procedure TBombaDAOTest.ConsultarPorId_Deve_Retornar_Objeto_Preenchido;
var
  Bomba: TBomba;
begin
  Bomba := TBomba.Create;
  try
    CarregarDataSetConsultarPorId;
    FBombaDAO.ConsultarPorId(1, Bomba);

    Assert.AreEqual(1, Bomba.Id_Bomba);
    Assert.AreEqual(SmallInt(1), Bomba.Numero);
    Assert.AreEqual(1, Bomba.Tanque.Id_Tanque);
    Assert.AreEqual(SmallInt(1), Bomba.Tanque.Numero);
    Assert.AreEqual(1, Bomba.Tanque.Tipo_Combustivel.Id_Tipo_Combustivel);
    Assert.AreEqual('Gasolina', Bomba.Tanque.Tipo_Combustivel.Descricao);

  finally
    FreeAndNil(Bomba);
  end;
end;

procedure TBombaDAOTest.ConsultarTodos_Deve_Retornar_Lista_Preenchida;
var
  ListaBomba: TObjectList<TBomba>;
  Bomba: TBomba;
begin
  ListaBomba := TObjectList<TBomba>.Create(True);
  try
    CarregarDataSetConsultarTodos;
    FBombaDAO.ConsultarTodos(ListaBomba);

    Assert.AreEqual(FDataSet.RecordCount, ListaBomba.Count);

    Bomba := ListaBomba[0];
    Assert.AreEqual(1, Bomba.Id_Bomba);
    Assert.AreEqual(SmallInt(1), Bomba.Numero);
    Assert.AreEqual(1, Bomba.Tanque.Id_Tanque);
    Assert.AreEqual(SmallInt(1), Bomba.Tanque.Numero);
    Assert.AreEqual(1, Bomba.Tanque.Tipo_Combustivel.Id_Tipo_Combustivel);
    Assert.AreEqual('Gasolina', Bomba.Tanque.Tipo_Combustivel.Descricao);

    Bomba := ListaBomba[1];
    Assert.AreEqual(4, Bomba.Id_Bomba);
    Assert.AreEqual(SmallInt(4), Bomba.Numero);
    Assert.AreEqual(2, Bomba.Tanque.Id_Tanque);
    Assert.AreEqual(SmallInt(2), Bomba.Tanque.Numero);
    Assert.AreEqual(2, Bomba.Tanque.Tipo_Combustivel.Id_Tipo_Combustivel);
    Assert.AreEqual('Óleo Diesel', Bomba.Tanque.Tipo_Combustivel.Descricao);

  finally
    FreeAndNil(ListaBomba);
  end;
end;

procedure TBombaDAOTest.PrepararDataSet;
begin
  if FDataSet.Active then
  begin
    FDataSet.EmptyDataSet;
  end;

  FDataSet.FieldDefs.Clear;
  FDataSet.FieldDefs.Add('ID_BOMBA', ftInteger);
  FDataSet.FieldDefs.Add('NUMERO', ftInteger);
  FDataSet.FieldDefs.Add('ID_TANQUE', ftInteger);
  FDataSet.FieldDefs.Add('NUMERO_TANQUE', ftInteger);
  FDataSet.FieldDefs.Add('ID_TIPO_COMBUSTIVEL', ftInteger);
  FDataSet.FieldDefs.Add('DESCRICAO_TIPO_COMBUSTIVEL', ftString, 30);
  FDataSet.CreateDataSet;
end;

procedure TBombaDAOTest.Setup;
begin
  FDataSet := TClientDataSet.Create(nil);
  FQueryFactory := TQueryFactoryMock.Create(FDataSet);

  FBombaDAO := TBombaDAO.New(FQueryFactory);
end;

procedure TBombaDAOTest.TearDown;
begin
  FreeAndNil(FDataSet);
end;

initialization
  TDUnitX.RegisterTestFixture(TBombaDAOTest);

end.
