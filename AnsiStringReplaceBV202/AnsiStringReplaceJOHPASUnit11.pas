unit AnsiStringReplaceJOHPASUnit11;

interface

{$I version.inc}

uses
  Windows, SysUtils, StrUtils;

{Equivalent of StringReplace for Non Multi Byte Character Sets}
function StringReplace_JOH_PAS_11(const S, OldPattern, NewPattern: AnsiString;
                                  Flags: TReplaceFlags): AnsiString;

//Size = 1232 + 256 (Table) + 4 (srCodePage) = 1492 Bytes

implementation

var
  AnsiUpcase: packed array[Char] of Char; {Uppcase Lookup Table}
  srCodePage: UINT; {Active String Replace Windows CodePage}

{Setup Lookup Table for Ansi Uppercase}
procedure InitialiseAnsiUpcase;
var
  Ch: Char;
begin
  srCodePage := GetACP; {Save CodePage}
  for Ch := #0 to #255 do                           
    AnsiUpcase[Ch] := Ch;
  CharUpperBuffA(@AnsiUpcase, 256);
end;

{$IFNDEF Delphi2005Plus}
  {$I D7PosEx.inc}
{$ENDIF}

{Case Insensitive PosEx based on Ansi Uppercase}
{AnsiUpcase must be initialized before this function is called}
function AnsiPosExIC(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  StrLen, SubLen, Len: Integer;
  PStr, PSub, PMax   : PChar;
  FirstChar          : Char; {First Character of SubStr}
begin
  Result := 0;
  SubLen := Length(SubStr);
  StrLen := Length(S);
  if (SubLen = 0) then
    Exit;
  PSub := Pointer(SubStr);
  PStr := Pointer(S);
  PMax := PStr + StrLen - SubLen; {Maximum Start Position}
  Inc(PStr, Offset - 1);
  if PStr > PMax then
    Exit;
  FirstChar := AnsiUpcase[PSub^];
  if SubLen = 1 then
    repeat {Single Character Saarch}
      if AnsiUpcase[PStr^] = FirstChar then
        begin
          Result := PStr + 1 - Pointer(S);
          Exit;
        end;
      if AnsiUpcase[PStr[1]] = FirstChar then
        begin
          if PStr < PMax then {Within Valid Range}
            Result := PStr + 2 - Pointer(S);
          Exit;
        end;
      Inc(PStr, 2);
    until PStr > PMax
  else
    begin {Multi-Character Search}
      Dec(SubLen, 2); {Characters to Check after Match}
      repeat
        if AnsiUpcase[PStr^] = FirstChar then
          begin
            Len := SubLen;
            while True do
              begin
                if (AnsiUpcase[PSub[Len  ]] <> AnsiUpcase[PStr[Len  ]])
                or (AnsiUpcase[PSub[Len+1]] <> AnsiUpcase[PStr[Len+1]]) then
                  Break; {No Match}
                Dec(Len, 2);
                if Len < 0 then
                  begin {First Char already Checked}
                    Result := PStr + 1 - Pointer(S);
                    Exit;
                  end;
              end;
          end;
        if AnsiUpcase[PStr[1]] = FirstChar then
          begin
            Len := SubLen;
            while True do
              begin
                if (AnsiUpcase[PSub[Len  ]] <> AnsiUpcase[PStr[Len+1]])
                or (AnsiUpcase[PSub[Len+1]] <> AnsiUpcase[PStr[Len+2]]) then
                  Break; {No Match}
                Dec(Len, 2);
                if Len < 0 then
                  begin {First Char already Checked}
                    if PStr < PMax then {Within Valid Range}
                      Result := PStr + 2 - Pointer(S);
                    Exit;
                  end;
              end;
          end;
        Inc(PStr, 2);
      until PStr > PMax;
    end;
end;

{Replace all occurance of Old with New (Ignoring Case) in Non-Nil String S}
procedure CharReplaceIC(var S: AnsiString; const Old, New: Char);
var
  I: Cardinal;
  P: PChar;
  C: Char;
begin
  C := AnsiUpcase[Old];
  P := Pointer(S);
  I := PCardinal(P - 4)^; {Length(S), Safe since S <> NIL}
  repeat
    Dec(I);
    if AnsiUpcase[P[I]] = C then
      P[I] := New;
  until I = 0;
end;

{Replace all occurance of Old with New in Non-Nil String S}
procedure CharReplace(var S: AnsiString; const Old, New: Char);
var
  I: Cardinal;
  P: PChar;
begin
  P := Pointer(S);
  I := PCardinal(P - 4)^; {Length(S), Safe since S <> NIL}
  repeat
    Dec(I);
    if P[I] = Old then
      P[I] := New;
  until I = 0;
end;

function StringReplace_JOH_PAS_11(const S, OldPattern, NewPattern: AnsiString;
                                  Flags: TReplaceFlags): AnsiString;
type
  TPosEx   = function(const SubStr, S: string; Offset: Integer): Integer;
  TCharRep = procedure(var S : AnsiString; const Old, New : Char);
const
  StaticBufferSize = 16;
  Locate : array[Boolean] of TPosEx   = (PosEx, AnsiPosExIC);
  Replace: array[Boolean] of TCharRep = (CharReplace, CharReplaceIC);
var
  SrcLen, OldLen, NewLen, Found, Count, Start, Match, Matches, BufSize,
  Remainder   : Integer;
  StaticBuffer: array[0..StaticBufferSize-1] of Integer;
  Buffer      : PIntegerArray;
  PSrc, PRes  : PChar;
  IgnoreCase  : Boolean;
begin
  SrcLen := Length(S);
  OldLen := Length(OldPattern);
  NewLen := Length(NewPattern);
  if (OldLen = 0) or (SrcLen < OldLen) then
    begin
      if SrcLen = 0 then
        Result := '' {Needed for Non-Nil Zero Length Strings}
      else
        Result := S
    end
  else
    begin
      IgnoreCase := rfIgnoreCase in Flags;
      if IgnoreCase then
        if GetACP <> srCodePage then {Check CodePage}
          InitialiseAnsiUpcase; {CodePage Changed - Update Lookup Table}
      if rfReplaceAll in Flags then
        begin
          if (OldLen = 1) and (NewLen = 1) then
            begin {Single Character Replacement}
              SetLength(Result, SrcLen);
              Move(Pointer(S)^, Pointer(Result)^, SrcLen);
              Replace[IgnoreCase](Result, OldPattern[1], NewPattern[1]);
              Exit;
            end;
          Found := Locate[IgnoreCase](OldPattern, S, 1);
          if Found <> 0 then
            begin
              Buffer    := @StaticBuffer;
              BufSize   := StaticBufferSize;
              Matches   := 1;
              Buffer[0] := Found;
              repeat
                Inc(Found, OldLen);
                Found := Locate[IgnoreCase](OldPattern, S, Found);
                if Found > 0 then
                  begin
                    if Matches = BufSize then
                      begin {Create or Expand Dynamic Buffer}
                        BufSize := BufSize + (BufSize shr 1); {Grow by 50%}
                        if Buffer = @StaticBuffer then
                          begin {Create Dynamic Buffer}
                            GetMem(Buffer, BufSize * SizeOf(Integer));
                            Move(StaticBuffer, Buffer^, SizeOf(StaticBuffer));
                          end
                        else {Expand Dynamic Buffer}
                          ReallocMem(Buffer, BufSize * SizeOf(Integer));
                      end;
                    Buffer[Matches] := Found;
                    Inc(Matches);
                  end
              until Found = 0;
              SetLength(Result, SrcLen + (Matches * (NewLen - OldLen)));
              PSrc := Pointer(S);
              PRes := Pointer(Result);
              Start := 1;
              Match := 0;
              repeat
                Found := Buffer[Match];
                Count := Found - Start;
                Start := Found + OldLen;
                if Count > 0 then
                  begin
                    Move(PSrc^, PRes^, Count);
                    Inc(PRes, Count);
                  end;
                Inc(PSrc, Count + OldLen);
                Move(Pointer(NewPattern)^, PRes^, NewLen);
                Inc(PRes, NewLen);
                Inc(Match);
              until Match = Matches;
              Remainder := SrcLen - Start;
              if Remainder >= 0 then
                Move(PSrc^, PRes^, Remainder + 1);
              if BufSize <> StaticBufferSize then
                FreeMem(Buffer); {Free Dynamic Buffer if Created}
            end
          else {No Matches Found}
            Result := S
        end
      else
        begin {Replace First Occurance Only}
          Found := Locate[IgnoreCase](OldPattern, S, 1);
          if Found <> 0 then
            begin {Match Found}
              SetLength(Result, SrcLen - OldLen + NewLen);
              Dec(Found);
              PSrc := Pointer(S);
              PRes := Pointer(Result);
              if NewLen = OldLen then
                begin
                  Move(PSrc^, PRes^, SrcLen);
                  Inc(PRes, Found);
                  Move(Pointer(NewPattern)^, PRes^, NewLen);
                end
              else
                begin 
                  Move(PSrc^, PRes^, Found);
                  Inc(PRes, Found);
                  Inc(PSrc, Found + OldLen);
                  Move(Pointer(NewPattern)^, PRes^, NewLen);
                  Inc(PRes, NewLen);
                  Move(PSrc^, PRes^, SrcLen - Found - OldLen);
                end;
            end
          else {No Matches Found}
            Result := S
        end;
    end;
end;

initialization
  srCodePage := 0; {Invalidate AnsiUpcase Lookup Table}
end.

