unit View.RelAbastecimentoAgrupado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Datasnap.DBClient, RLReport;

type
  TFrmRelAbastecimentoAgrupado = class(TForm)
    CDSAbastecimento: TClientDataSet;
    CDSAbastecimentodata_abastecimento: TDateField;
    CDSAbastecimentonumero_bomba: TSmallintField;
    CDSAbastecimentonumero_tanque: TSmallintField;
    CDSAbastecimentodescricao_tipo_combustivel: TStringField;
    CDSAbastecimentototal_valor: TCurrencyField;
    RLReport: TRLReport;
    DataSource: TDataSource;
    RLGroupData: TRLGroup;
    RLBandCabecalhoGroup: TRLBand;
    RLLabDataAbastecimento: TRLLabel;
    RLDBTextDataAbastecimento: TRLDBText;
    RLBandDetalhe: TRLBand;
    RLDBTextValor: TRLDBText;
    RLDBTextNumeroBomba: TRLDBText;
    RLDBTextNumeroTanque: TRLDBText;
    RLDBTextDescrTipoCombustivel: TRLDBText;
    RLBandRodabeGroup: TRLBand;
    RLDBResultValor: TRLDBResult;
    RLLabTotalGroup: TRLLabel;
    RLBandCabecalho: TRLBand;
    RLLabTituloRelatorio: TRLLabel;
    RLLabNumeroBomba: TRLLabel;
    RLLabNumeroTanque: TRLLabel;
    RLLabDescrTipoCombustivel: TRLLabel;
    RLLabValor: TRLLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function CarregarDados: Boolean;

  public
    { Public declarations }
    procedure AbrirRelatorio;
  end;

var
  FrmRelAbastecimentoAgrupado: TFrmRelAbastecimentoAgrupado;

implementation

{$R *.dfm}

uses Model.Abastecimento, Model.GestorRelAbastecimento;

{ TFrmRelAgrupado }

procedure TFrmRelAbastecimentoAgrupado.AbrirRelatorio;
begin
  FrmRelAbastecimentoAgrupado := TFrmRelAbastecimentoAgrupado.Create(nil);
  with FrmRelAbastecimentoAgrupado do
  begin
    if CarregarDados then
    begin
      RLReport.PreviewModal;
    end;

    Free;
  end;
end;

function TFrmRelAbastecimentoAgrupado.CarregarDados: Boolean;
begin
  TGestorRelAbastecimentoAgrupado.New.CarregarDados(CDSAbastecimento);
  Result := not CDSAbastecimento.IsEmpty;

  if not Result then
  begin
    MessageDlg('Nenhum registro encontrado', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
  end;
end;

procedure TFrmRelAbastecimentoAgrupado.FormCreate(Sender: TObject);
begin
  CDSAbastecimento.CreateDataSet;
end;

end.
