unit View.Main;

interface

uses
  Winapi.Windows, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, System.Classes, Vcl.ExtCtrls, Vcl.Forms, Model.GestorSelecaoBomba;

type
  TFrmMain = class(TForm)
    PnLateralAcoes: TPanel;
    BtnRelatorio: TBitBtn;
    BtnSair: TBitBtn;
    PnAreaTrabalho: TPanel;
    PnTopo: TPanel;
    Label3: TLabel;
    procedure BtnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    FGestorSelecaoBomba: IGestorSelecaoBomba;

    procedure BombaSelecionar(Sender: TObject; AId_Bomba: Integer);

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  View.Abastecimento, View.RelAbastecimentoAgrupado;

{ TFrmMain }

procedure TFrmMain.BombaSelecionar(Sender: TObject; AId_Bomba: Integer);
begin
  FrmAbastecimento.InformarAbastecimento(AId_Bomba);
end;

procedure TFrmMain.BtnRelatorioClick(Sender: TObject);
begin
  FrmRelAbastecimentoAgrupado.AbrirRelatorio;
end;

procedure TFrmMain.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
begin
  FGestorSelecaoBomba.CriarControlesSelecaoBomba;
  FGestorSelecaoBomba.OnSelecionar := BombaSelecionar;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FGestorSelecaoBomba := TGestorSelecaoBoma.New(PnAreaTrabalho);
end;

Initialization
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

end.
