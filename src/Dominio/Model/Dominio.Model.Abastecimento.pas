unit Dominio.Model.Abastecimento;

interface

uses
  Dominio.Model.Bomba, System.SysUtils;

type
  EAbastecimentoValidacao = class(Exception);

  TAbastecimento = class
  private
    FBomba: TBomba;

    FValor: Double;
    FQuantidade: Double;
    FDataEhHora: TDateTime;
    FValor_Imposto: Double;
    FPercentual_Imposto: Double;

    procedure SetQuantidade(const Value: Double);
    procedure SetValor(const Value: Double);
    procedure SetDataEhHora(const Value: TDateTime);
    procedure SetValor_Imposto(const Value: Double);
    procedure SetPercentual_Imposto(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Validar;

    property Bomba: TBomba read FBomba;

    property DataEhHora: TDateTime read FDataEhHora write SetDataEhHora;
    property Quantidade: Double read FQuantidade write SetQuantidade;
    property Valor: Double read FValor write SetValor;
    property Percentual_Imposto: Double read FPercentual_Imposto write SetPercentual_Imposto;
    property Valor_Imposto: Double read FValor_Imposto write SetValor_Imposto;
  end;

implementation

uses
  Utils.Constantes;

{ TAbastecimento }

constructor TAbastecimento.Create;
begin
  FBomba := TBomba.Create;

  FDataEhHora := Now;
  FQuantidade := 0;
  FValor := 0;
  FPercentual_Imposto := 0;
  FValor_Imposto := 0;
end;

destructor TAbastecimento.Destroy;
begin
  FreeAndNil(FBomba);

  inherited;
end;

procedure TAbastecimento.SetDataEhHora(const Value: TDateTime);
begin
  FDataEhHora := Value;
end;

procedure TAbastecimento.SetPercentual_Imposto(const Value: Double);
begin
  FPercentual_Imposto := Value;
end;

procedure TAbastecimento.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TAbastecimento.SetValor(const Value: Double);
begin
  FValor := Value;
end;

procedure TAbastecimento.SetValor_Imposto(const Value: Double);
begin
  FValor_Imposto := Value;
end;

procedure TAbastecimento.Validar;
var
  MsgValidacao: TStringBuilder;
begin
  MsgValidacao := TStringBuilder.Create;
  try
    if Self.Bomba.Id_Bomba = 0 then
    begin
      MsgValidacao.Append(MSG_VALIDACAO_BOMBA_NAO_INFORMADA);
    end;

    if Self.Quantidade = 0 then
    begin
      if MsgValidacao.Length > 0 then
      begin
        MsgValidacao.Append(#13);
      end;

      MsgValidacao.Append(MSG_VALIDACAO_QTDE_NAO_INFORMADA);
    end;

    if Self.Valor = 0 then
    begin
      if MsgValidacao.Length > 0 then
      begin
        MsgValidacao.Append(#13);
      end;

      MsgValidacao.Append(MSG_VALIDACAO_VALOR_NAO_INFORMADO);
    end;

    if MsgValidacao.Length > 0 then
    begin
      raise EAbastecimentoValidacao.Create(MsgValidacao.ToString);
    end;

  finally
    FreeAndNil(MsgValidacao);
  end;
end;

end.
