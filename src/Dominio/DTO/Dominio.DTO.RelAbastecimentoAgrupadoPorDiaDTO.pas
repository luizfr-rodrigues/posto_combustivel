unit Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO;

interface

type
  TRelAbastecimentoAgrupadoPorDiaDTO = class
  private
    FNumeroTanque: integer;
    FDescrTipoCombustivel: string;
    FTotal: Double;
    FNumeroBomba: integer;
    FData: TDate;

    procedure SetData(const Value: TDate);
    procedure SetDescrTipoCombustivel(const Value: string);
    procedure SetNumeroBomba(const Value: integer);
    procedure SetNumeroTanque(const Value: integer);
    procedure SetTotal(const Value: Double);

  public
    property Data: TDate read FData write SetData;
    property Total: Double read FTotal write SetTotal;
    property NumeroBomba: integer read FNumeroBomba write SetNumeroBomba;
    property NumeroTanque: integer read FNumeroTanque write SetNumeroTanque;
    property DescrTipoCombustivel: string read FDescrTipoCombustivel write SetDescrTipoCombustivel;
  end;

implementation

{ TRelAbastecimentoAgrupadoPorDiaDTO }

procedure TRelAbastecimentoAgrupadoPorDiaDTO.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TRelAbastecimentoAgrupadoPorDiaDTO.SetDescrTipoCombustivel(const Value: string);
begin
  FDescrTipoCombustivel := Value;
end;

procedure TRelAbastecimentoAgrupadoPorDiaDTO.SetNumeroBomba(const Value: integer);
begin
  FNumeroBomba := Value;
end;

procedure TRelAbastecimentoAgrupadoPorDiaDTO.SetNumeroTanque(const Value: integer);
begin
  FNumeroTanque := Value;
end;

procedure TRelAbastecimentoAgrupadoPorDiaDTO.SetTotal(const Value: Double);
begin
  FTotal := Value;
end;

end.
