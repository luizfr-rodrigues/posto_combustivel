unit DAO.Abastecimento;

interface

uses
  Model.Conexao, Model.Abastecimento;

type
  IAbastecimentoDAO = interface
    ['{A9A1E6D1-A787-4EF3-B15D-ABCF36A63868}']
    procedure Salvar(const AAbastecimento: TAbastecimento);
    function RetornarDadosRelAgrupado: OleVariant;
  end;

  TAbastecimentoDAO = class(TInterfacedObject, IAbastecimentoDAO)
  private
    FQuery: IQuery;

  public
    class function New: IAbastecimentoDAO;

    constructor Create;
    destructor Destroy; override;

    procedure Salvar(const AAbastecimento: TAbastecimento);
    function RetornarDadosRelAgrupado: OleVariant;
  end;

implementation

uses
  System.SysUtils;

{ TAbastecimentoDAO }

constructor TAbastecimentoDAO.Create;
begin
  FQuery := TQueryFactory.New.Query;
end;

destructor TAbastecimentoDAO.Destroy;
begin

  inherited;
end;

function TAbastecimentoDAO.RetornarDadosRelAgrupado: OleVariant;
var
  StrComandoSQL: TStringBuilder;
begin
  StrComandoSQL := TStringBuilder.Create;
  Try
    StrComandoSQL.Append('Select ');
    StrComandoSQL.Append('  Cast(a.Data_Hora as Date) as data_abastecimento, sum(a.valor) as total_valor, ');
    StrComandoSQL.Append('  b.numero as numero_bomba, ');
    StrComandoSQL.Append('  t.numero as numero_tanque, ');
    StrComandoSQL.Append('  tc.descricao as descricao_tipo_combustivel ');
    StrComandoSQL.Append('From ');
    StrComandoSQL.Append('  abastecimento A ');
    StrComandoSQL.Append('Inner Join ');
    StrComandoSQL.Append('  bomba b on b.id_bomba = a.id_bomba ');
    StrComandoSQL.Append('Inner Join ');
    StrComandoSQL.Append('  tanque t on t.id_tanque = b.id_tanque ');
    StrComandoSQL.Append('Inner Join ');
    StrComandoSQL.Append('  tipocombustivel tc on tc.id_tipo_combustivel = t.id_tipo_combustivel ');
    StrComandoSQL.Append('Group By ');
    StrComandoSQL.Append('  Cast(a.Data_Hora as Date), b.numero, t.numero, tc.descricao ');

    FQuery.Open(StrComandoSQL.ToString);
    Result := FQuery.Data;

    FQuery.Close;

  Finally
    FreeAndNil(StrComandoSQL);
  End;
end;

class function TAbastecimentoDAO.New: IAbastecimentoDAO;
begin
  Result := TAbastecimentoDAO.Create;
end;

procedure TAbastecimentoDAO.Salvar(const AAbastecimento: TAbastecimento);
var
  StrComandoSQL: TStringBuilder;
  DataHoraAbastecimento: string;
begin
  Try
    StrComandoSQL := TStringBuilder.Create;

    StrComandoSQL.Append('Insert Into ABASTECIMENTO ');
    StrComandoSQL.Append('(ID_BOMBA, DATA_HORA, QUANTIDADE, VALOR, PERCENTUAL_IMPOSTO, VALOR_IMPOSTO) ');
    StrComandoSQL.Append('Values (');

    StrComandoSQL.Append( IntToStr(AAbastecimento.Bomba.Id_Bomba) ).Append( ', ' );

    DataHoraAbastecimento := 'Null, ';
    if AAbastecimento.DataEhHora > 0 then
      StrComandoSQL.Append( FQuery.DateTimeToStrComandoSQL(AAbastecimento.DataEhHora) ).Append( ', ' );

    StrComandoSQL.Append( FQuery.FloatToStrComandoSQL(AAbastecimento.Quantidade) ).Append( ', ' );
    StrComandoSQL.Append( FQuery.FloatToStrComandoSQL(AAbastecimento.Valor) ).Append( ', ' );
    StrComandoSQL.Append( FQuery.FloatToStrComandoSQL(AAbastecimento.Percentual_Imposto) ).Append( ', ' );
    StrComandoSQL.Append( FQuery.FloatToStrComandoSQL(AAbastecimento.Valor_Imposto) ).Append( ')' );

    FQuery.ExecSQL(StrComandoSQL.ToString);

  Finally
    FreeAndNil(StrComandoSQL);
  End;
end;

end.
