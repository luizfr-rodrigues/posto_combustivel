unit DAO.Bomba;

interface

uses
  Model.Conexao, Model.Bomba, System.Generics.Collections;

type
  IBombaDAO = interface
    ['{A9A1E6D1-A787-4EF3-B15D-ABCF36A63868}']
    procedure ConsultarTodos(const AListaBombas: TObjectList<TBomba>);
    procedure ConsultarPorId(const AId_Bomba: Integer; const ABomba: TBomba);
  end;

  TBombaDAO = class(TInterfacedObject, IBombaDAO)
  private
    FQuery: IQuery;

    function RetornarSQLConsulta: string;

  public
    class function New: IBombaDAO;

    constructor Create;
    destructor Destroy; override;

    procedure ConsultarTodos(const AListaBombas: TObjectList<TBomba>);
    procedure ConsultarPorId(const AId_Bomba: Integer; const ABomba: TBomba);
  end;

implementation

uses
  System.SysUtils;

{ TBombaDAO }

procedure TBombaDAO.ConsultarPorId(const AId_Bomba: Integer; const ABomba: TBomba);
var
  StrComandoSQL: TStringBuilder;
begin
  StrComandoSQL := TStringBuilder.Create;
  Try
    StrComandoSQL.Append(RetornarSQLConsulta);
    StrComandoSQL.Append('where b.id_bomba = ' + IntToStr(AId_Bomba));

    FQuery.Open(StrComandoSQL.ToString);

    with FQuery.DataSet do
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

    FQuery.Close;

  Finally
    FreeAndNil(StrComandoSQL);
  End;
end;

procedure TBombaDAO.ConsultarTodos(const AListaBombas: TObjectList<TBomba>);
var
  Bomba: TBomba;
begin
  FQuery.Open(RetornarSQLConsulta);

  with FQuery.DataSet do
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

  FQuery.Close;
end;

constructor TBombaDAO.Create;
begin
  FQuery := TQueryFactory.New.Query;
end;

destructor TBombaDAO.Destroy;
begin

  inherited;
end;

class function TBombaDAO.New: IBombaDAO;
begin
  Result := TBombaDAO.Create;
end;

function TBombaDAO.RetornarSQLConsulta: string;
var
  StrComandoSQL: TStringBuilder;
begin
  Result := EmptyStr;

  StrComandoSQL := TStringBuilder.Create;
  Try
    StrComandoSQL.Append('Select ');
    StrComandoSQL.Append('  b.id_bomba, b.numero, ');
    StrComandoSQL.Append('  t.id_tanque, t.numero as numero_tanque, ');
    StrComandoSQL.Append('  tc.id_tipo_combustivel, tc.descricao as descricao_tipo_combustivel ');
    StrComandoSQL.Append('From Bomba B ');
    StrComandoSQL.Append('  Inner Join Tanque T on t.id_tanque = b.id_tanque ');
    StrComandoSQL.Append('  Inner Join tipocombustivel TC on tc.id_tipo_combustivel = t.id_tipo_combustivel ');

    Result := StrComandoSQL.ToString;
  Finally
    FreeAndNil(StrComandoSQL);
  End;
end;

end.
