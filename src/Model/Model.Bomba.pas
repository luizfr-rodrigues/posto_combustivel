unit Model.Bomba;

interface

uses
  Model.Tanque, System.Generics.Collections;

type
  TBomba = class
  private
    FTanque: TTanque;

    FId_Bomba: Integer;
    FNumero: SmallInt;

    procedure SetId_Bomba(const Value: Integer);
    procedure SetNumero(const Value: SmallInt);

  public
    constructor Create;
    destructor Destroy; override;

    procedure ConsultarTodos(const AListaBombas: TObjectList<TBomba>);
    procedure ConsultarPorId(const AId_Bomba: Integer);

    property Tanque: TTanque read FTanque;

    property Id_Bomba: Integer read FId_Bomba write SetId_Bomba;
    property Numero: SmallInt read FNumero write SetNumero;
  end;

implementation

uses
  System.SysUtils, DAO.Bomba;

{ TBomba }

procedure TBomba.ConsultarPorId(const AId_Bomba: Integer);
begin
  TBombaDAO.New.ConsultarPorId(AId_Bomba, Self);
end;

procedure TBomba.ConsultarTodos(const AListaBombas: TObjectList<TBomba>);
begin
  TBombaDAO.New.ConsultarTodos(AListaBombas);
end;

constructor TBomba.Create;
begin
  FTanque := TTanque.Create;

  FId_Bomba := 0;
  FNumero := 0;
end;

destructor TBomba.Destroy;
begin
  FreeAndNil(FTanque);

  inherited;
end;

procedure TBomba.SetId_Bomba(const Value: Integer);
begin
  FId_Bomba := Value;
end;

procedure TBomba.SetNumero(const Value: SmallInt);
begin
  FNumero := Value;
end;

end.
