unit View.Gestor.GestorFactory;

interface

uses
  View.Interfaces.Gestor, Vcl.Controls, Dominio.Interfaces.AbastecimentoService;

type
  TGestorFactory = class
    class function SelecaoBomba(const AControlePai: TWinControl): IGestorSelecaoBomba;
    class function RelAbastecimentoAgrupado(AServiceAbastecimento: IAbastecimentoService): IGestorRelatorio;
  end;

implementation

{ TGestorFactory }

uses
  View.Gestor.GestorSelecaoBomba, View.Gestor.GestorRelAbastecimento;

class function TGestorFactory.RelAbastecimentoAgrupado(AServiceAbastecimento: IAbastecimentoService): IGestorRelatorio;
begin
  Result := TGestorRelAbastecimentoAgrupado.New(AServiceAbastecimento);
end;

class function TGestorFactory.SelecaoBomba(const AControlePai: TWinControl): IGestorSelecaoBomba;
begin
  Result := TGestorSelecaoBomba.New(AControlePai);
end;

end.
