unit Model.GestorRelAbastecimento;

interface

uses
  Datasnap.DBClient;

type
  IGestorRelAbastecimentoAgrupado = interface
    ['{EA3DA1CD-F5BE-4025-8951-1D49A7A3DF54}']

    procedure CarregarDados(const AClientDataSet: TClientDataSet);
  end;

  TGestorRelAbastecimentoAgrupado = class(TInterfacedObject, IGestorRelAbastecimentoAgrupado)
  public
    class function New: IGestorRelAbastecimentoAgrupado;
    procedure CarregarDados(const AClientDataSet: TClientDataSet);
  end;

implementation

uses
  Data.DB, Model.Abastecimento, System.SysUtils;

{ TGestorRelAbastecimentoAgrupado }

procedure TGestorRelAbastecimentoAgrupado.CarregarDados(const AClientDataSet: TClientDataSet);
var
  Abastecimento: TAbastecimento;
begin
  Abastecimento := TAbastecimento.Create;
  try
    AClientDataSet.Data := Abastecimento.RetornarDadosRelAgrupado;

  finally
    FreeAndNil(Abastecimento);
  end;
end;

class function TGestorRelAbastecimentoAgrupado.New: IGestorRelAbastecimentoAgrupado;
begin
  Result := TGestorRelAbastecimentoAgrupado.Create;
end;

end.
