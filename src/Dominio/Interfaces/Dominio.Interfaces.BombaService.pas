unit Dominio.Interfaces.BombaService;

interface

uses
  Dominio.Model.Bomba, Generics.Collections;

Type
  IBombaService = interface
    ['{EE4D4601-9BCA-4755-A0A9-ADCB77173834}']

    procedure ConsultarTodos(AListaBombas: TObjectList<TBomba>);
    procedure ConsultarPorId(const AId_Bomba: Integer; ABomba: TBomba);
  end;

implementation

end.
