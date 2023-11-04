unit Model.Conexao;

interface

uses
  Data.DB;

type
  IConexao = interface
    ['{9F7CCB65-D333-4B1C-B6D9-0D64CA266099}']

    function Connection: TCustomConnection;
  end;

  IQuery = interface
    ['{4335CA34-9961-46CA-88D3-54B1A4DBB83C}']

    function DataSet: TDataSet;

    procedure Open(const AStrSQL: String);
    procedure Close;

    function Data: OleVariant;

    procedure ExecSQL(const AStrSQL: String);

    function DateTimeToStrComandoSQL(const AValue: TDateTime): string;
    function FloatToStrComandoSQL(const AValue: Double): string;
  end;

  TQueryBase = class abstract(TInterfacedObject, IQuery)
  public
    function DataSet: TDataSet; virtual; abstract;

    procedure Open(const AStrSQL: String); virtual; abstract;
    procedure Close; virtual; abstract;

    function Data: OleVariant; virtual; abstract;

    procedure ExecSQL(const AStrSQL: String); virtual; abstract;

    function DateTimeToStrComandoSQL(const AValue: TDateTime): string; virtual;
    function FloatToStrComandoSQL(const AValue: Double): string;  virtual;
  end;

  IQueryFactory = interface
    ['{DAC43CB2-C2B2-49F8-B534-4ED8AD993B91}']

    function Query: IQuery;
  end;

  IConexaoFactory = interface
    ['{E0F6F158-9E15-484F-8589-789C5564C74A}']

    function Conexao: IConexao;
  end;

  TConexaoFactory = class(TInterfacedObject, IConexaoFactory)
  private
    class var FConexao: IConexao;

  public
    class function New: IConexaoFactory;
    function Conexao: IConexao;
  end;

  TQueryFactory = class(TInterfacedObject, IQueryFactory)
  public
    class function New: IQueryFactory;
    function Query: IQuery;
  end;

implementation

uses
  Model.FiredacConexao, System.SysUtils;

{ TQueryFactory }

class function TQueryFactory.New: IQueryFactory;
begin
  Result := TQueryFactory.Create;
end;

function TQueryFactory.Query: IQuery;
begin
  Result := TFiredacQuery.New(TConexaoFactory.New.Conexao);
end;

{ TConexaoFactory }

function TConexaoFactory.Conexao: IConexao;
begin
  if not Assigned(FConexao) then
    FConexao := TFiredacConexao.New;

   Result := FConexao;
end;

class function TConexaoFactory.New: IConexaoFactory;
begin
  Result := TConexaoFactory.Create;
end;

{ TQueryBase }

function TQueryBase.DateTimeToStrComandoSQL(const AValue: TDateTime): string;
begin
  Result := QuotedStr( FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', AValue) );
end;

function TQueryBase.FloatToStrComandoSQL(const AValue: Double): string;
begin
  Result := StringReplace(FloatToStr(AValue), ',', '.', [rfReplaceAll]);
end;

end.
