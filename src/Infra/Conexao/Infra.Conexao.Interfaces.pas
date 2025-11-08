unit Infra.Conexao.Interfaces;

interface

uses
  Data.DB;

type
  IConexaoBD = interface
    ['{9F7CCB65-D333-4B1C-B6D9-0D64CA266099}']

    function Connection: TCustomConnection;
  end;

  IConexaoBDFactory = interface
    ['{E0F6F158-9E15-484F-8589-789C5564C74A}']

    function RetornarConexao: IConexaoBD;
  end;

  IQuery = interface
    ['{4335CA34-9961-46CA-88D3-54B1A4DBB83C}']

    procedure SetSQL(const ASQL: string);
    procedure AddParam(const AName: string; const AValue: Variant);

    procedure Open;
    procedure Close;
    procedure ExecSQL;

    function DataSet: TDataSet;
  end;

  IQueryFactory = interface
    ['{DAC43CB2-C2B2-49F8-B534-4ED8AD993B91}']

    function CriarQuery: IQuery;
  end;

implementation

end.
