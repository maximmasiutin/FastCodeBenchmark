unit ReportWriterUnit;

{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
{$ENDIF}

interface

uses
  Classes, Math, SysUtils;

type
  TReportWriter = class
  public
    procedure SectionEnd; virtual;
    procedure SectionParagraph(const Text: string); virtual; abstract;
    procedure SectionStart(const Title: string = ''); virtual; abstract;
    procedure TableEnd; virtual;
    procedure TableField(const Text: string); virtual; abstract;
    procedure TableRow(const Fields: array of string; Header: Boolean = False); virtual;
    procedure TableRowEnd; virtual;
    procedure TableRowStart(Header: Boolean = False); virtual;
    procedure TableStart(const Title: string = ''); virtual; abstract;
  end;

  TReportWriterText = class(TReportWriter)
  private
    FText: string;
    FTextLength: Integer;
  protected
    procedure Write(const S: string);
    procedure WriteLn(const S: string = '');
  public
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(Stream: TStream);
    function ToString: string;
  end;

  TReportWriterTextPlain = class(TReportWriterText)
  private
    FColumnCount: Integer;
    FColumnIndex: Integer;
    FRowHeader: Boolean;
    FRowIndex: Integer;
    FTableList: TList;
  public
    procedure SectionEnd; override;
    procedure SectionParagraph(const Text: string); override;
    procedure SectionStart(const Title: string = ''); override;
    procedure TableEnd; override;
    procedure TableField(const Text: string); override;
    procedure TableRowEnd; override;
    procedure TableRowStart(Header: Boolean = False); override;
    procedure TableStart(const Title: string = ''); override;
  end;

  TReportWriterTextSeparated = class(TReportWriterText)
  private
    FNeedSeparator: Boolean;
    FQuoted: Boolean;
    FSeparator: string;
    function QuoteText(const S: string): string;
  public
    constructor Create(const ASeparator: string; AQuoted: Boolean);
    procedure SectionEnd; override;
    procedure SectionParagraph(const Text: string); override;
    procedure SectionStart(const Title: string = ''); override;
    procedure TableEnd; override;
    procedure TableField(const Text: string); override;
    procedure TableRowEnd; override;
    procedure TableStart(const Title: string = ''); override;

    property Quoted: Boolean read FQuoted;
    property Separator: string read FSeparator;
  end;

implementation

const
  NEWLINE = #13#10;

type
  PTableListEntry = ^TTableListEntry;
  TTableListEntry = record
    ColumnIndex, RowIndex: Integer;
    Text: string;
  end;

function RepeatChar(C: Char; Count: Integer): string; forward;

function RepeatChar(C: Char; Count: Integer): string;
begin
  if Count <= 0 then
    Result := ''
  else
  begin
    SetLength(Result, Count);
    FillChar(Result[1], Count, C);
  end;
end;

procedure TReportWriter.SectionEnd;
begin
  // Empty default implementation
end;

procedure TReportWriter.TableEnd;
begin
  // Empty default implementation
end;

procedure TReportWriter.TableRow(const Fields: array of string; Header: Boolean = False);
var
  I: Integer;
begin
  TableRowStart(Header);
  try
    for I := Low(Fields) to High(Fields) do
      TableField(Fields[I]);
  finally
    TableRowEnd;
  end;
end;

procedure TReportWriter.TableRowEnd;
begin
  // Empty default implementation
end;

procedure TReportWriter.TableRowStart(Header: Boolean);
begin
  // Empty default implementation
end;

procedure TReportWriterText.Write(const S: string);
const
  ALLOCATE_FACTOR = 1.5;
var
  TextLengthNew: Integer;
begin
  if Length(S) = 0 then
    Exit;

  TextLengthNew := FTextLength + Length(S);
  if TextLengthNew > Length(FText) then
    SetLength(FText, Ceil(TextLengthNew * ALLOCATE_FACTOR));

  Move(S[1], FText[FTextLength + 1], Length(S));
  FTextLength := TextLengthNew;
end;

procedure TReportWriterText.WriteLn(const S: string = '');
begin
  Write(S);
  Write(NEWLINE);
end;

procedure TReportWriterText.SaveToFile(const Filename: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TReportWriterText.SaveToStream(Stream: TStream);
begin
  if FTextLength > 0 then
    Stream.WriteBuffer(FText[1], FTextLength);
end;

function TReportWriterText.ToString: string;
begin
  SetLength(FText, FTextLength);
  Result := FText;
end;

procedure TReportWriterTextPlain.SectionEnd;
begin
  WriteLn;
  WriteLn;
end;

procedure TReportWriterTextPlain.SectionParagraph(const Text: string);
begin
  WriteLn(Text);
end;

procedure TReportWriterTextPlain.SectionStart(const Title: string = '');
begin
  if Title <> '' then
  begin
    WriteLn(Title);
    WriteLn;
  end;
end;

procedure TReportWriterTextPlain.TableEnd;
var
  I, RowIndex: Integer;
  ColumnWidths: array of Integer;
  Entry: PTableListEntry;
begin
  try
    SetLength(ColumnWidths, FColumnCount);
    for I := 0 to FTableList.Count - 1 do
    begin
      Entry := PTableListEntry(FTableList[I]);
      if Length(Entry^.Text) > ColumnWidths[Entry^.ColumnIndex] then
        ColumnWidths[Entry^.ColumnIndex] := Length(Entry^.Text);
    end;

    RowIndex := 0;
    for I := 0 to FTableList.Count - 1 do
    begin
      Entry := PTableListEntry(FTableList[I]);
      while RowIndex < Entry^.RowIndex do
      begin
        WriteLn;
        Inc(RowIndex);
      end;

      Write(Entry^.Text);
      Write(RepeatChar(' ', ColumnWidths[Entry^.ColumnIndex] + 1 - Length(Entry^.Text)));
    end;
    WriteLn;
    WriteLn;
  finally
    FreeAndNil(FTableList);
  end;
end;

procedure TReportWriterTextPlain.TableField(const Text: string);
var
  Entry: PTableListEntry;
begin
  New(Entry);
  try
    Entry^.ColumnIndex := FColumnIndex;
    Entry^.RowIndex := FRowIndex;
    Entry^.Text := Text;
    FTableList.Add(Entry);
  except
    Dispose(Entry);
    raise;
  end;

  Inc(FColumnIndex);
  if FColumnIndex > FColumnCount then
    FColumnCount := FColumnIndex;
end;

procedure TReportWriterTextPlain.TableRowEnd;
var
  Entry, EntryNew: PTableListEntry;
  I: Integer;
begin
  if FRowHeader then
  begin
    Inc(FRowIndex);
    for I := FTableList.Count - FColumnIndex to FTableList.Count - 1 do
    begin
      Entry := PTableListEntry(FTableList[I]);
      New(EntryNew);
      try
        EntryNew^.RowIndex := FRowIndex;
        EntryNew^.ColumnIndex := Entry^.ColumnIndex;
        EntryNew^.Text := RepeatChar('-', Length(Entry^.Text));
        FTableList.Add(EntryNew);
      except
        Dispose(EntryNew);
        raise;
      end;
    end;
  end;

  Inc(FRowIndex);
  FColumnIndex := 0;
end;

procedure TReportWriterTextPlain.TableRowStart(Header: Boolean = False);
begin
  FRowHeader := Header;
end;

procedure TReportWriterTextPlain.TableStart(const Title: string = '');
begin
  if Title <> '' then
  begin
    WriteLn(Title);
    WriteLn;
  end;

  FTableList := TList.Create;
  FColumnIndex := 0;
  FRowIndex := 0;
end;

function TReportWriterTextSeparated.QuoteText(const S: string): string;
begin
  if FQuoted then
    Result := '"' + StringReplace(S, '"', '""', [rfReplaceAll]) + '"'
  else
    Result := S;
end;

constructor TReportWriterTextSeparated.Create(const ASeparator: string; AQuoted: Boolean);
begin
  inherited Create;
  FSeparator := ASeparator;
  FQuoted := AQuoted;
end;

procedure TReportWriterTextSeparated.SectionEnd;
begin
  WriteLn;
  WriteLn;
end;

procedure TReportWriterTextSeparated.SectionParagraph(const Text: string);
begin
  WriteLn(QuoteText(Text))
end;

procedure TReportWriterTextSeparated.SectionStart(const Title: string = '');
begin
  if Title <> '' then
  begin
    WriteLn(QuoteText(Title));
    WriteLn;
  end;
end;

procedure TReportWriterTextSeparated.TableEnd;
begin
  WriteLn;
  WriteLn;
end;

procedure TReportWriterTextSeparated.TableField(const Text: string);
begin
  if FNeedSeparator then
    Write(FSeparator);
  Write(QuoteText(Text));
  FNeedSeparator := True;
end;

procedure TReportWriterTextSeparated.TableRowEnd;
begin
  WriteLn;
  FNeedSeparator := False;
end;

procedure TReportWriterTextSeparated.TableStart(const Title: string = '');
begin
  if Title <> '' then
  begin
    WriteLn(QuoteText(Title));
    WriteLn;
  end;
end;

end.
