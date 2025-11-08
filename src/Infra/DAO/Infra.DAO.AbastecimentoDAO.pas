unit Infra.DAO.AbastecimentoDAO;

interface

uses
  Infra.DAO.BaseDAO, Infra.Conexao.Interfaces, Dominio.Interfaces.AbastecimentoDAO, Dominio.Model.Abastecimento, Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO, Generics.Collections;

type
  TAbastecimentoDAO = class(TBaseDAO, IAbastecimentoDAO)
  public
    class function New(AQueryFactory: IQueryFactory): IAbastecimentoDAO;

    procedure Salvar(AAbastecimento: TAbastecimento);
    procedure ConsultarListaAgrupadoPorDia(AListaAbastecimentoDTO: TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>);
  end;

implementation

uses
  System.SysUtils;

{ TAbastecimentoDAO }

procedure TAbastecimentoDAO.ConsultarListaAgrupadoPorDia(AListaAbastecimentoDTO: TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>);
var
  Query: IQuery;
  AbastecimentoDTO: TRelAbastecimentoAgrupadoPorDiaDTO;

const
  SQL_CONSULTA =
    'SELECT ' +
    '  CAST(A.DATA_HORA AS DATE) AS DATA_ABASTECIMENTO, ' +
    '  SUM(A.VALOR) AS TOTAL_VALOR, ' +
    '  B.NUMERO AS NUMERO_BOMBA, ' +
    '  T.NUMERO AS NUMERO_TANQUE, ' +
    '  TC.DESCRICAO AS DESCRICAO_TIPO_COMBUSTIVEL ' +
    'FROM ABASTECIMENTO A ' +
    '  INNER JOIN BOMBA B ON B.ID_BOMBA = A.ID_BOMBA ' +
    '  INNER JOIN TANQUE T ON T.ID_TANQUE = B.ID_TANQUE ' +
    '  INNER JOIN TIPOCOMBUSTIVEL TC ON TC.ID_TIPO_COMBUSTIVEL = T.ID_TIPO_COMBUSTIVEL ' +
    'GROUP BY CAST(A.DATA_HORA AS DATE), B.NUMERO, T.NUMERO, TC.DESCRICAO';
begin
  Query := FQueryFactory.CriarQuery;

  Query.SetSQL(SQL_CONSULTA);
  Query.Open;

  with Query.DataSet do
  begin
    First;
    while not Eof do
    begin
      AbastecimentoDTO := TRelAbastecimentoAgrupadoPorDiaDTO.Create;

      AbastecimentoDTO.Data := FieldByName('DATA_ABASTECIMENTO').AsDateTime;
      AbastecimentoDTO.Total := FieldByName('TOTAL_VALOR').AsFloat;
      AbastecimentoDTO.NumeroBomba := FieldByName('NUMERO_BOMBA').AsInteger;
      AbastecimentoDTO.NumeroTanque := FieldByName('NUMERO_TANQUE').AsInteger;
      AbastecimentoDTO.DescrTipoCombustivel := FieldByName('DESCRICAO_TIPO_COMBUSTIVEL').AsString;

      AListaAbastecimentoDTO.Add(AbastecimentoDTO);
      Next;
    end;
  end;

  Query.Close;
end;

class function TAbastecimentoDAO.New(AQueryFactory: IQueryFactory): IAbastecimentoDAO;
begin
  Result := TAbastecimentoDAO.Create(AQueryFactory);
end;

procedure TAbastecimentoDAO.Salvar(AAbastecimento: TAbastecimento);
var
  Query: IQuery;

const
  SQL_INSERT =
    'INSERT INTO ABASTECIMENTO ' +
    '  (ID_BOMBA, DATA_HORA, QUANTIDADE, VALOR, PERCENTUAL_IMPOSTO, VALOR_IMPOSTO) ' +
    'VALUES ' +
    '  (:PID_BOMBA, :PDATA_HORA, :PQUANTIDADE, :PVALOR, :PPERCENTUAL_IMPOSTO, :PVALOR_IMPOSTO)';
begin
  Query := FQueryFactory.CriarQuery;

  Query.SetSQL(SQL_INSERT);
  Query.AddParam('PID_BOMBA', AAbastecimento.Bomba.Id_Bomba);
  Query.AddParam('PDATA_HORA', AAbastecimento.DataEhHora);
  Query.AddParam('PQUANTIDADE', AAbastecimento.Quantidade);
  Query.AddParam('PVALOR', AAbastecimento.Valor);
  Query.AddParam('PPERCENTUAL_IMPOSTO', AAbastecimento.Percentual_Imposto);
  Query.AddParam('PVALOR_IMPOSTO', AAbastecimento.Valor_Imposto);

  Query.ExecSQL;
end;

end.
