unit Infra.DAO.BombaDAO;

interface

uses
  Infra.DAO.BaseDAO, Infra.Conexao.Interfaces, Dominio.Interfaces.BombaDAO, Dominio.Model.Bomba, System.Generics.Collections;

type
  TBombaDAO = class(TBaseDAO, IBombaDAO)
  public
    class function New(AQueryFactory: IQueryFactory): IBombaDAO;

    procedure ConsultarTodos(AListaBombas: TObjectList<TBomba>);
    procedure ConsultarPorId(const AId_Bomba: Integer; ABomba: TBomba);
  end;

implementation

uses
  System.SysUtils, Data.DB;

const
  SQL_CONSULTA_BASE =
    'SELECT ' +
    '  B.ID_BOMBA, B.NUMERO, ' +
    '  T.ID_TANQUE, T.NUMERO AS NUMERO_TANQUE, ' +
    '  TC.ID_TIPO_COMBUSTIVEL, TC.DESCRICAO AS DESCRICAO_TIPO_COMBUSTIVEL ' +
    'FROM BOMBA B ' +
    '  INNER JOIN TANQUE T ON T.ID_TANQUE = B.ID_TANQUE ' +
    '  INNER JOIN TIPOCOMBUSTIVEL TC ON TC.ID_TIPO_COMBUSTIVEL = T.ID_TIPO_COMBUSTIVEL';

{ TBombaDAO }

procedure TBombaDAO.ConsultarPorId(const AId_Bomba: Integer; ABomba: TBomba);
var
  Query: IQuery;
  SQLConsulta: string;

const
  SQL_CONSULTA_POR_ID = '%s WHERE B.ID_BOMBA = :PID_BOMBA;';
begin
  SQLConsulta := Format(SQL_CONSULTA_POR_ID, [SQL_CONSULTA_BASE]);

  Query := FQueryFactory.CriarQuery;

  Query.SetSQL(SQLConsulta);
  Query.AddParam('pid_bomba', AId_Bomba);
  Query.Open;

  with Query.DataSet do
  begin
    if not IsEmpty then
    begin
      ABomba.Id_Bomba := FieldByName('id_bomba').AsInteger;
      ABomba.Numero := FieldByName('numero').AsInteger;

      ABomba.Tanque.Id_Tanque := FieldByName('id_tanque').AsInteger;
      ABomba.Tanque.Numero := FieldByName('numero_tanque').AsInteger;

      ABomba.Tanque.Tipo_Combustivel.Id_Tipo_Combustivel := FieldByName('id_tipo_combustivel').AsInteger;
      ABomba.Tanque.Tipo_Combustivel.Descricao := FieldByName('descricao_tipo_combustivel').AsString;
    end;
  end;

  Query.Close;
end;

procedure TBombaDAO.ConsultarTodos(AListaBombas: TObjectList<TBomba>);
var
  Query: IQuery;
  SQLConsulta: string;
  Bomba: TBomba;

const
  SQL_CONSULTA_TODOS = '%s ORDER BY TC.ID_TIPO_COMBUSTIVEL, B.NUMERO';
begin
  SQLConsulta := Format(SQL_CONSULTA_TODOS, [SQL_CONSULTA_BASE]);

  Query := FQueryFactory.CriarQuery;

  Query.SetSQL(SQLConsulta);
  Query.Open;

  with Query.DataSet do
  begin
    First;
    while not Eof do
    begin
      Bomba := TBomba.Create;

      Bomba.Id_Bomba := FieldByName('id_bomba').AsInteger;
      Bomba.Numero := FieldByName('numero').AsInteger;

      Bomba.Tanque.Id_Tanque := FieldByName('id_tanque').AsInteger;
      Bomba.Tanque.Numero := FieldByName('numero_tanque').AsInteger;

      Bomba.Tanque.Tipo_Combustivel.Id_Tipo_Combustivel := FieldByName('id_tipo_combustivel').AsInteger;
      Bomba.Tanque.Tipo_Combustivel.Descricao := FieldByName('descricao_tipo_combustivel').AsString;

      AListaBombas.Add(Bomba);
      Next;
    end;
  end;

  Query.Close;
end;

class function TBombaDAO.New(AQueryFactory: IQueryFactory): IBombaDAO;
begin
  Result := TBombaDAO.Create(AQueryFactory);
end;

end.
