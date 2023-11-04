program ProjPosto;

uses
  Vcl.Forms,
  View.Main in 'view\View.Main.pas' {FrmMain},
  Model.Conexao in 'model\Model.Conexao.pas',
  Model.FiredacConexao in 'model\Model.FiredacConexao.pas',
  Model.TipoCombustivel in 'model\Model.TipoCombustivel.pas',
  Model.Tanque in 'model\Model.Tanque.pas',
  Model.Bomba in 'model\Model.Bomba.pas',
  Model.GestorSelecaoBomba in 'model\Model.GestorSelecaoBomba.pas',
  View.Abastecimento in 'view\View.Abastecimento.pas' {FrmAbastecimento},
  DAO.Bomba in 'DAO\DAO.Bomba.pas',
  Model.Abastecimento in 'Model\Model.Abastecimento.pas',
  DAO.Abastecimento in 'DAO\DAO.Abastecimento.pas',
  Model.CalculoImpostoAbastecimento in 'Model\Model.CalculoImpostoAbastecimento.pas',
  View.RelAbastecimentoAgrupado in 'View\View.RelAbastecimentoAgrupado.pas' {FrmRelAbastecimentoAgrupado},
  Model.GestorRelAbastecimento in 'Model\Model.GestorRelAbastecimento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
