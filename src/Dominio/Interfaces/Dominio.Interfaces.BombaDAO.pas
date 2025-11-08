unit Dominio.Interfaces.BombaDAO;

interface

uses
  Dominio.Model.Bomba, Generics.Collections;

Type
  IBombaDAO = interface
    ['{A9A1E6D1-A787-4EF3-B15D-ABCF36A63868}']

    procedure ConsultarTodos(AListaBombas: TObjectList<TBomba>);
    procedure ConsultarPorId(const AId_Bomba: Integer; ABomba: TBomba);
  end;

implementation

end.
