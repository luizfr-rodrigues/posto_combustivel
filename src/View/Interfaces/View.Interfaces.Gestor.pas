unit View.Interfaces.Gestor;

interface

uses
  Datasnap.DBClient;

Type
  TOnSelecionarEvent = procedure(Sender: TObject; AId_Bomba: Integer) of object;

  IGestorSelecaoBomba = interface
    ['{6D4F4969-2AE6-4CEB-AF23-B66466063104}']

    procedure CriarControlesSelecaoBomba;

    function GetOnSelecionar: TOnSelecionarEvent;
    procedure SetOnSelecionar(Value: TOnSelecionarEvent);

    property OnSelecionar: TOnSelecionarEvent read GetOnSelecionar write SetOnSelecionar;
  end;

  IGestorRelatorio = interface
    ['{C55DD8AD-3A7D-4AFB-93A9-ACE5023025D2}']

    procedure CarregarDados(AClientDataSet: TClientDataSet);
  end;

implementation

end.
