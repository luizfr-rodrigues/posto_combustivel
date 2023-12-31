unit Model.GestorSelecaoBomba;

interface

uses
  Vcl.Controls, Model.Bomba, System.Generics.Collections;

type
  TOnSelecionarEvent = procedure(Sender: TObject; AId_Bomba: Integer) of object;

  IGestorSelecaoBomba = interface
    ['{6D4F4969-2AE6-4CEB-AF23-B66466063104}']
    procedure CriarControlesSelecaoBomba;

    function GetOnSelecionar: TOnSelecionarEvent;
    procedure SetOnSelecionar(Value: TOnSelecionarEvent);

    property OnSelecionar: TOnSelecionarEvent read GetOnSelecionar write SetOnSelecionar;
  end;

  TGestorSelecaoBoma = class(TInterfacedObject, IGestorSelecaoBomba)
  private
    FControlePai: TWinControl;
    FListaBombas: TObjectList<TBomba>;

    FOnSelecionarEvent: TOnSelecionarEvent;

    FUltLinha: Integer;
    FUltColuna: Integer;

    function GetOnSelecionar: TOnSelecionarEvent;
    procedure SetOnSelecionar(Value: TOnSelecionarEvent);

    procedure CarregarListaBombas;

    procedure CriarPanelBomba(const ABomba: TBomba);
    procedure CriarLabelTipoCombustivel(const AControlePai: TWinControl; const ABomba: TBomba);
    procedure CriarLabelIdentificacaoBomba(const AControlePai: TWinControl; const ABomba: TBomba);

    procedure EventoOnClickPanel(Sender: TObject);

  public
    class function New(const AControlePai: TWinControl): IGestorSelecaoBomba;

    constructor Create(const AControlePai: TWinControl);
    destructor Destroy; override;

    procedure CriarControlesSelecaoBomba;
    property OnSelecionar: TOnSelecionarEvent read GetOnSelecionar write SetOnSelecionar;
  end;

implementation

uses
  Vcl.ExtCtrls, System.SysUtils, Vcl.Graphics, Vcl.StdCtrls, System.Classes;

const
  FONTE_TEXTO = 'Arial';

  LARGURA_PANEL = 250;
  ALTURA_PANEL = 200;

  LEFT_COL_1_PANEL = 100;
  LEFT_COL_2_PANEL = 475;
  TOP_LINHA_1_PANEL = 80;
  TOP_LINHA_2_PANEL = 330;

  TAMANHO_FONTE_LABEL_NUMERO_BOMBA = 18;
  ALTURA_LABEL_NUMERO_BOMBA = 50;

  TAMANHO_FONTE_LABEL_TIPO_COMBUSTIVEL = 10;

{ TGestorSelecaoBoma }

procedure TGestorSelecaoBoma.CarregarListaBombas;
var
  Bomba: TBomba;
begin
  Bomba := TBomba.Create;
  try
    Bomba.ConsultarTodos(FListaBombas);
  finally
    FreeAndNil(Bomba);
  end;
end;

constructor TGestorSelecaoBoma.Create(const AControlePai: TWinControl);
begin
  FControlePai := AControlePai;
  FListaBombas := TObjectList<TBomba>.Create;

  FUltLinha := 0;
  FUltColuna := 0;
end;

procedure TGestorSelecaoBoma.CriarControlesSelecaoBomba;
var
  Bomba: TBomba;
begin
  CarregarListaBombas;

  for Bomba in FListaBombas do
  begin
    CriarPanelBomba(Bomba);
  end;
end;

procedure TGestorSelecaoBoma.CriarLabelIdentificacaoBomba(const AControlePai: TWinControl; const ABomba: TBomba);
const
  CAPTION_NUM_BOMBA = 'Bomba'+#13+'N� %d';
var
  LabelBomba: TLabel;
begin
  LabelBomba := TLabel.Create(AControlePai);
  LabelBomba.Parent := AControlePai;

  LabelBomba.Align := alClient;
  LabelBomba.Alignment := taCenter;

  LabelBomba.Caption := Format(CAPTION_NUM_BOMBA, [ABomba.Numero]);

  LabelBomba.Font.Name := FONTE_TEXTO;
  LabelBomba.Font.Size := TAMANHO_FONTE_LABEL_NUMERO_BOMBA;
  LabelBomba.Font.Style := [TFontStyle.fsBold];

  LabelBomba.Layout := tlCenter;

  LabelBomba.ParentColor := True;
  LabelBomba.ParentFont := False;

  LabelBomba.OnClick := EventoOnClickPanel;
end;

procedure TGestorSelecaoBoma.CriarLabelTipoCombustivel(const AControlePai: TWinControl; const ABomba: TBomba);
var
  LabelTipoCombustivel: TLabel;
begin
  LabelTipoCombustivel := TLabel.Create(AControlePai);
  LabelTipoCombustivel.Parent := AControlePai;

  LabelTipoCombustivel.Align := alTop;
  LabelTipoCombustivel.Alignment := taCenter;

  LabelTipoCombustivel.Caption := ABomba.Tanque.Tipo_Combustivel.Descricao;

  LabelTipoCombustivel.Font.Name := FONTE_TEXTO;
  LabelTipoCombustivel.Font.Size := TAMANHO_FONTE_LABEL_TIPO_COMBUSTIVEL;
  LabelTipoCombustivel.Font.Style := [TFontStyle.fsBold];

  LabelTipoCombustivel.Height := ALTURA_LABEL_NUMERO_BOMBA;
  LabelTipoCombustivel.Layout := tlCenter;

  LabelTipoCombustivel.ParentColor := True;
  LabelTipoCombustivel.ParentFont := False;

  LabelTipoCombustivel.OnClick := EventoOnClickPanel;
end;

procedure TGestorSelecaoBoma.CriarPanelBomba(const ABomba: TBomba);
var
  NovoPanel: TPanel;
  LeftPanel, TopPanel: Integer;
begin
  if FUltColuna = 2 then
  begin
    FUltColuna := 1;
    Inc(FUltLinha);
  end
  else
  begin
    Inc(FUltColuna);
    if FUltLinha = 0 then
      Inc(FUltLinha);
  end;

  LeftPanel := LEFT_COL_1_PANEL;
  if FUltColuna = 2 then
  begin
    LeftPanel := LEFT_COL_2_PANEL;
  end;

  TopPanel := TOP_LINHA_1_PANEL;
  if FUltLinha = 2 then
  begin
    TopPanel := TOP_LINHA_2_PANEL;
  end;

  NovoPanel := TPanel.Create(FControlePai);
  NovoPanel.Parent := FControlePai;

  NovoPanel.Width := LARGURA_PANEL;
  NovoPanel.Height := ALTURA_PANEL;
  NovoPanel.Left := LeftPanel;
  NovoPanel.Top := TopPanel;

  NovoPanel.BevelOuter := bvNone;
  NovoPanel.Cursor := crHandPoint;

  NovoPanel.Color := clSkyBlue;
  NovoPanel.Font.Name := FONTE_TEXTO;

  NovoPanel.StyleElements := [seFont, seBorder];
  NovoPanel.Tag := ABomba.Id_Bomba;

  NovoPanel.OnClick := EventoOnClickPanel;

  CriarLabelTipoCombustivel(NovoPanel, ABomba);
  CriarLabelIdentificacaoBomba(NovoPanel, ABomba);
end;

destructor TGestorSelecaoBoma.Destroy;
begin
  FreeAndNil(FListaBombas);

  inherited;
end;

procedure TGestorSelecaoBoma.EventoOnClickPanel(Sender: TObject);
var
  IdSelecionada: Integer;
begin
  if Assigned(FOnSelecionarEvent) then
  begin
    IdSelecionada := 0;
    if Sender is TPanel then
    begin
      IdSelecionada := (Sender as TPanel).Tag;
    end

    else if Sender is TLabel then
    begin
      IdSelecionada := (Sender as TLabel).Parent.Tag;
    end;

    FOnSelecionarEvent(Sender, IdSelecionada);
  end;
end;

function TGestorSelecaoBoma.GetOnSelecionar: TOnSelecionarEvent;
begin
  Result := FOnSelecionarEvent;
end;

class function TGestorSelecaoBoma.New(const AControlePai: TWinControl): IGestorSelecaoBomba;
begin
  Result := TGestorSelecaoBoma.Create(AControlePai);
end;

procedure TGestorSelecaoBoma.SetOnSelecionar(Value: TOnSelecionarEvent);
begin
  FOnSelecionarEvent := Value;
end;

end.
