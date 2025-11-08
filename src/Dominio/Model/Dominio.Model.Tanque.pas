unit Dominio.Model.Tanque;

interface

uses
  Dominio.Model.TipoCombustivel;

type
  TTanque = class
  private
    FTipo_Combustivel: TTipoCombustivel;

    FNumero: SmallInt;
    FId_Tanque: Integer;

    procedure SetId_Tanque(const Value: Integer);
    procedure SetNumero(const Value: SmallInt);

  public
    constructor Create;
    destructor Destroy; override;

    property Tipo_Combustivel: TTipoCombustivel read FTipo_Combustivel;

    property Id_Tanque: Integer read FId_Tanque write SetId_Tanque;
    property Numero: SmallInt read FNumero write SetNumero;
  end;

implementation

uses
  System.SysUtils;

{ TTanque }

constructor TTanque.Create;
begin
  FTipo_Combustivel := TTipoCombustivel.Create;

  FId_Tanque := 0;
  FNumero := 0;
end;

destructor TTanque.Destroy;
begin
  FreeAndNil(FTipo_Combustivel);

  inherited;
end;

procedure TTanque.SetId_Tanque(const Value: Integer);
begin
  FId_Tanque := Value;
end;

procedure TTanque.SetNumero(const Value: SmallInt);
begin
  FNumero := Value;
end;

end.
