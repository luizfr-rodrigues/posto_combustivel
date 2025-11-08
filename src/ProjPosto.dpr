program ProjPosto;

uses
  Vcl.Forms,
  View.Main in 'View\View.Main.pas' {FrmMain},
  View.Abastecimento in 'View\View.Abastecimento.pas' {FrmAbastecimento},
  View.RelAbastecimentoAgrupado in 'View\View.RelAbastecimentoAgrupado.pas' {FrmRelAbastecimentoAgrupado},
  View.Interfaces.Gestor in 'View\Interfaces\View.Interfaces.Gestor.pas',
  View.Gestor.GestorRelAbastecimento in 'View\Gestor\View.Gestor.GestorRelAbastecimento.pas',
  View.Gestor.GestorSelecaoBomba in 'View\Gestor\View.Gestor.GestorSelecaoBomba.pas',
  View.Gestor.GestorFactory in 'View\Gestor\View.Gestor.GestorFactory.pas',
  Utils.Constantes in 'Utils\Utils.Constantes.pas',
  Infra.Conexao.Interfaces in 'Infra\Conexao\Infra.Conexao.Interfaces.pas',
  Infra.Conexao.ConexaoFactory in 'Infra\Conexao\Infra.Conexao.ConexaoFactory.pas',
  Infra.Conexao.FiredacConexaoAdapter in 'Infra\Conexao\Infra.Conexao.FiredacConexaoAdapter.pas',
  Infra.DAO.BaseDAO in 'Infra\DAO\Infra.DAO.BaseDAO.pas',
  Infra.DAO.BombaDAO in 'Infra\DAO\Infra.DAO.BombaDAO.pas',
  Infra.DAO.AbastecimentoDAO in 'Infra\DAO\Infra.DAO.AbastecimentoDAO.pas',
  Infra.DAO.DAOFactory in 'Infra\DAO\Infra.DAO.DAOFactory.pas',
  Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO in 'Dominio\DTO\Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO.pas',
  Dominio.Interfaces.BombaService in 'Dominio\Interfaces\Dominio.Interfaces.BombaService.pas',
  Dominio.Interfaces.AbastecimentoService in 'Dominio\Interfaces\Dominio.Interfaces.AbastecimentoService.pas',
  Dominio.Interfaces.BombaDAO in 'Dominio\Interfaces\Dominio.Interfaces.BombaDAO.pas',
  Dominio.Interfaces.AbastecimentoDAO in 'Dominio\Interfaces\Dominio.Interfaces.AbastecimentoDAO.pas',
  Dominio.Model.TipoCombustivel in 'Dominio\Model\Dominio.Model.TipoCombustivel.pas',
  Dominio.Model.Tanque in 'Dominio\Model\Dominio.Model.Tanque.pas',
  Dominio.Model.Bomba in 'Dominio\Model\Dominio.Model.Bomba.pas',
  Dominio.Model.Abastecimento in 'Dominio\Model\Dominio.Model.Abastecimento.pas',
  Dominio.Model.CalculoImpostoAbastecimento in 'Dominio\Model\Dominio.Model.CalculoImpostoAbastecimento.pas',
  Dominio.Service.ServiceFactory in 'Dominio\Service\Dominio.Service.ServiceFactory.pas',
  Dominio.Service.Bomba in 'Dominio\Service\Dominio.Service.Bomba.pas',
  Dominio.Service.Abastecimento in 'Dominio\Service\Dominio.Service.Abastecimento.pas',
  Dominio.Interfaces.CalculoImposto in 'Dominio\Interfaces\Dominio.Interfaces.CalculoImposto.pas',
  Dominio.Model.CalculoImpostoFactory in 'Dominio\Model\Dominio.Model.CalculoImpostoFactory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
