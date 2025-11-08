unit View.Abastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.UITypes, Dominio.Model.Abastecimento;

type
  TFrmAbastecimento = class(TForm)
    PnFundo: TPanel;
    PnAcoes: TPanel;
    BtnConfirmar: TBitBtn;
    BtnCancelar: TBitBtn;
    LabQtde: TLabel;
    LabValor: TLabel;
    EdtQtde: TEdit;
    EdtValor: TEdit;
    PnInfoBomba: TPanel;
    LabInfoBomba: TLabel;
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure EdtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure EdtQtdeExit(Sender: TObject);
    procedure EdtValorKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorExit(Sender: TObject);
  private
    { Private declarations }
    FAbastecimento: TAbastecimento;

    procedure ValidarTeclaPressionaEditNumerico(var AKey: Char);
    procedure FormatarValorEditNumerico(const AEdit: TEdit; const ANumeroDigitos: SmallInt);

    procedure CarregarInfoBombaSelecionada(const AId_Bomba: Integer);
    procedure CarregarDadosAbastecimento;
  public
    { Public declarations }

    procedure InformarAbastecimento(const AId_Bomba: Integer);
  end;

var
  FrmAbastecimento: TFrmAbastecimento;

implementation

uses
  Utils.Constantes, Dominio.Service.ServiceFactory, Dominio.Model.CalculoImpostoFactory;

{$R *.dfm}

{ TFrmAbastecimento }

procedure TFrmAbastecimento.BtnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente cancelar?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) <> mrYes then
  begin
    Exit;
  end;

  Close;
end;

procedure TFrmAbastecimento.BtnConfirmarClick(Sender: TObject);
begin
  CarregarDadosAbastecimento;

  try
    TServiceFactory.Abastecimento.Registrar(FAbastecimento, TCalculoImpostoFactory.CalcImpostoAbastecimento);

    MessageDlg('Abastecimento registrado com sucesso', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    Close;

  except
    on E: EAbastecimentoValidacao do
    begin
      MessageDlg('Campos inválidos' + #13#13 + E.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    end;

    on E: Exception do
    begin
      MessageDlg('Ocorreu um erro ao salvar o abastecimento' + #13 + E.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    end;
  end;
end;

procedure TFrmAbastecimento.CarregarInfoBombaSelecionada(const AId_Bomba: Integer);
const
  CAPTION_INFO_BOMBA = 'Bomba Nº: %d - %s';
begin
  TServiceFactory.Bomba.ConsultarPorId(AId_Bomba, FAbastecimento.Bomba);
  LabInfoBomba.Caption := Format(CAPTION_INFO_BOMBA, [FAbastecimento.Bomba.Numero, FAbastecimento.Bomba.Tanque.Tipo_Combustivel.Descricao]);
end;

procedure TFrmAbastecimento.EdtQtdeExit(Sender: TObject);
begin
  FormatarValorEditNumerico(TEdit(Sender), NUMERO_DIGITOS_QTDE);
end;

procedure TFrmAbastecimento.EdtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
  ValidarTeclaPressionaEditNumerico(Key);
end;

procedure TFrmAbastecimento.EdtValorExit(Sender: TObject);
begin
  FormatarValorEditNumerico(TEdit(Sender), NUMERO_DIGITOS_VALOR);
end;

procedure TFrmAbastecimento.EdtValorKeyPress(Sender: TObject; var Key: Char);
begin
  ValidarTeclaPressionaEditNumerico(Key);
end;

procedure TFrmAbastecimento.FormatarValorEditNumerico(const AEdit: TEdit; const ANumeroDigitos: SmallInt);
var
  StrValor, FormatDigitos: string;
begin
  if not Assigned(AEdit) then
  begin
    Exit;
  end;

  if AEdit.Text = EmptyStr then
  begin
    Exit;
  end;

  FormatDigitos := '###,##0.' + StringofChar('0', ANumeroDigitos);

  StrValor := FormatFloat(FormatDigitos, StrToFloatDef(AEdit.Text, 0));
  AEdit.Text := StrValor;
end;

procedure TFrmAbastecimento.FormCreate(Sender: TObject);
begin
  FAbastecimento := TAbastecimento.Create;
end;

procedure TFrmAbastecimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FAbastecimento);
end;

procedure TFrmAbastecimento.InformarAbastecimento(const AId_Bomba: Integer);
begin
  FrmAbastecimento := TFrmAbastecimento.Create(nil);
  with FrmAbastecimento do
  begin
    CarregarInfoBombaSelecionada(AId_Bomba);

    ShowModal;
    Free;
  end;
end;

procedure TFrmAbastecimento.CarregarDadosAbastecimento;
begin
  FAbastecimento.Quantidade := StrToFloatDef(EdtQtde.Text, 0);
  FAbastecimento.Valor := StrToFloatDef(EdtValor.Text, 0);
end;

procedure TFrmAbastecimento.ValidarTeclaPressionaEditNumerico(var AKey: Char);
begin
  if AKey in ['0'..'9', #8, #9, ',', '.'] then
  begin
    if AKey = '.' then
      AKey := ',';

    Exit;
  end;

  AKey := #0;
end;

end.
