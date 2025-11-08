unit Dominio.Model.TipoCombustivel;

interface

type
  TTipoCombustivel = class
  private
    FDescricao: string;
    FId_Tipo_Combustivel: integer;

    procedure SetDescricao(const Value: string);
    procedure SetId_Tipo_Combustivel(const Value: integer);

  public
    constructor Create;

    property Id_Tipo_Combustivel: integer read FId_Tipo_Combustivel write SetId_Tipo_Combustivel;
    property Descricao: string read FDescricao write SetDescricao;
  end;

implementation

uses
  System.SysUtils;

{ TTipoCombustivel }

constructor TTipoCombustivel.Create;
begin
  FId_Tipo_Combustivel := 0;
  FDescricao := EmptyStr;
end;

procedure TTipoCombustivel.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TTipoCombustivel.SetId_Tipo_Combustivel(const Value: integer);
begin
  FId_Tipo_Combustivel := Value;
end;

end.
