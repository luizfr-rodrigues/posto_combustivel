unit Infra.Mock.QueryMock;

interface

uses
  Infra.Conexao.Interfaces, Data.DB;

type
  TQueryMock = class(TInterfacedObject, IQuery)
  private
    FDataSet: TDataSet;
    FLastSQL: string;

  public
    constructor Create(ADataSet: TDataSet);

    procedure SetSQL(const ASQL: string);
    procedure AddParam(const AName: string; const AValue: Variant);

    procedure Open;
    procedure Close;
    procedure ExecSQL;

    function DataSet: TDataSet;
  end;

implementation

{ TQueryMock }

procedure TQueryMock.AddParam(const AName: string; const AValue: Variant);
begin

end;

procedure TQueryMock.Close;
begin

end;

constructor TQueryMock.Create(ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
end;

function TQueryMock.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

procedure TQueryMock.ExecSQL;
begin

end;

procedure TQueryMock.Open;
begin

end;

procedure TQueryMock.SetSQL(const ASQL: string);
begin

end;

end.
