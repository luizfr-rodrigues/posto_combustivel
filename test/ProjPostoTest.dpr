program ProjPostoTest;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  Dominio.Model.CalculoImpostoAbastecimentoTest in 'Dominio\Model\Dominio.Model.CalculoImpostoAbastecimentoTest.pas',
  Dominio.Model.Abastecimento in '..\src\Dominio\Model\Dominio.Model.Abastecimento.pas',
  Dominio.Model.CalculoImpostoAbastecimento in '..\src\Dominio\Model\Dominio.Model.CalculoImpostoAbastecimento.pas',
  Dominio.Model.Bomba in '..\src\Dominio\Model\Dominio.Model.Bomba.pas',
  Dominio.Model.Tanque in '..\src\Dominio\Model\Dominio.Model.Tanque.pas',
  Dominio.Model.TipoCombustivel in '..\src\Dominio\Model\Dominio.Model.TipoCombustivel.pas',
  Utils.Constantes in '..\src\Utils\Utils.Constantes.pas',
  Dominio.Interfaces.CalculoImposto in '..\src\Dominio\Interfaces\Dominio.Interfaces.CalculoImposto.pas',
  Dominio.Model.AbastecimentoTest in 'Dominio\Model\Dominio.Model.AbastecimentoTest.pas',
  Infra.DAO.BombaDAOTest in 'Infra\DAO\Infra.DAO.BombaDAOTest.pas',
  Infra.DAO.BombaDAO in '..\src\Infra\DAO\Infra.DAO.BombaDAO.pas',
  Infra.DAO.BaseDAO in '..\src\Infra\DAO\Infra.DAO.BaseDAO.pas',
  Infra.Conexao.Interfaces in '..\src\Infra\Conexao\Infra.Conexao.Interfaces.pas',
  Dominio.Interfaces.BombaDAO in '..\src\Dominio\Interfaces\Dominio.Interfaces.BombaDAO.pas',
  Infra.Mock.QueryMock in 'Infra\Mock\Infra.Mock.QueryMock.pas',
  Infra.Mock.QueryFactoryMock in 'Infra\Mock\Infra.Mock.QueryFactoryMock.pas',
  Infra.DAO.AbastecimentoDAOTest in 'Infra\DAO\Infra.DAO.AbastecimentoDAOTest.pas',
  Infra.DAO.AbastecimentoDAO in '..\src\Infra\DAO\Infra.DAO.AbastecimentoDAO.pas',
  Dominio.Interfaces.AbastecimentoDAO in '..\src\Dominio\Interfaces\Dominio.Interfaces.AbastecimentoDAO.pas',
  Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO in '..\src\Dominio\DTO\Dominio.DTO.RelAbastecimentoAgrupadoPorDiaDTO.pas';

{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
