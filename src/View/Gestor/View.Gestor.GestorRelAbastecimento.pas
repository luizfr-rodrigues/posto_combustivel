unit View.Gestor.GestorRelAbastecimento;

interface

uses
  View.Interfaces.Gestor, Dominio.Interfaces.AbastecimentoService, Datasnap.DBClient;

type
  TGestorRelAbastecimentoAgrupado = class(TInterfacedObject, IGestorRelatorio)
  private
    FServiceAbastecimento: IAbastecimentoService;

  public
    class function New(AServiceAbastecimento: IAbastecimentoService): IGestorRelatorio;
    constructor Create(AServiceAbastecimento: IAbastecimentoService);

    procedure CarregarDados(AClientDataSet: TClientDataSet);
  end;


implementation

{ TGestorRelAbastecimentoAgrupado }

uses
  Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO, Generics.Collections, System.SysUtils;

procedure TGestorRelAbastecimentoAgrupado.CarregarDados(AClientDataSet: TClientDataSet);
var
  ListaAbasteciomentoDTO: TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>;
  AbastecimentoDTO: TRelAbastecimentoAgrupadoPorDiaDTO;
begin
  if not Assigned(AClientDataSet) then
    raise Exception.Create('ClientDataSet não instânciado');

  AClientDataSet.EmptyDataSet;

  ListaAbasteciomentoDTO := TObjectList<TRelAbastecimentoAgrupadoPorDiaDTO>.Create;
  try
    FServiceAbastecimento.ConsultarListaRelAgrupadoPorDia(ListaAbasteciomentoDTO);

    for AbastecimentoDTO in ListaAbasteciomentoDTO do
    begin
      AClientDataSet.Append;
      AClientDataSet.FieldByName('data_abastecimento').AsDateTime := AbastecimentoDTO.Data;
      AClientDataSet.FieldByName('total_valor').AsFloat := AbastecimentoDTO.Total;
      AClientDataSet.FieldByName('numero_bomba').AsInteger := AbastecimentoDTO.NumeroBomba;
      AClientDataSet.FieldByName('numero_tanque').AsInteger := AbastecimentoDTO.NumeroTanque;
      AClientDataSet.FieldByName('descricao_tipo_combustivel').AsString := AbastecimentoDTO.DescrTipoCombustivel;
      AClientDataSet.Post;
    end;

  finally
    FreeAndNil(ListaAbasteciomentoDTO);
  end;
end;

constructor TGestorRelAbastecimentoAgrupado.Create(AServiceAbastecimento: IAbastecimentoService);
begin
  FServiceAbastecimento := AServiceAbastecimento;
end;

class function TGestorRelAbastecimentoAgrupado.New(AServiceAbastecimento: IAbastecimentoService): IGestorRelatorio;
begin
  Result := TGestorRelAbastecimentoAgrupado.Create(AServiceAbastecimento);
end;

end.
