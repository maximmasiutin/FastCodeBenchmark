unit PosShaUnit;

interface

function Pos_Sha_Pas_0(const SubStr: AnsiString; const Str: AnsiString): Integer;

implementation

function Pos_Sha_Pas_0(const SubStr: AnsiString; const Str: AnsiString): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pEnd: pchar;
label
  Ret, Ret0, Ret1, Next0, Next1;
begin;
  p:=pointer(Str);
  pSub:=pointer(SubStr);

  //if need pure Pascal uncomment this paragraph
  //and comment out the next 3 paragraphs
{
  len:=length(Str);
  lenSub:=length(SubStr);
  pEnd:=p+len;
  pStart:=p;
  pEnd:=pEnd-lenSub;
  if (len<=0) or (lenSub<=0) or (p>pEnd) then begin;
    Result:=0;
    exit;
    end;
}

  if (p=nil) or (pSub=nil) then begin;
    Result:=0;
    exit;
    end;

  len:=pinteger(p-4)^;
  lenSub:=pinteger(pSub-4)^;
  if (len<lenSub) or (lenSub<=0) then begin;
    Result:=0;
    exit;
    end;

  pEnd:=p+len;
  pStart:=p;
  pEnd:=pEnd-lenSub;

  ch:=pSub[0];

  if lenSub=1 then begin;
    repeat;
      if ch=p[0] then goto Ret0;
      if ch=p[1] then goto Ret1;
      p:=p+2;
      until p>pEnd;
    Result:=0;
    exit;
    end;

  repeat;
    if ch=p[0] then begin;
      len:=lensub;
      repeat;
        if psub[len-1]<>p[len-1] then goto Next0;
        if psub[len-2]<>p[len-2] then goto Next0;
        len:=len-2;
        until len<2;
      goto Ret0;
Next0:end;

    if ch=p[1] then begin;
      len:=lensub;
      repeat;
        if psub[len-1]<>p[len] then goto Next1;
        if psub[len-2]<>p[len-1] then goto Next1;
        len:=len-2;
        until len<2;
      goto Ret1;
Next1:end;

    p:=p+2;
    until p>pEnd;
  Result:=0;
  exit;

Ret1:
  inc(pEnd);
  p:=p+2;
  if p<=pEnd then goto Ret;
  Result:=0;
  exit;
Ret0:
  inc(p);
Ret:
  Result:=p-pStart;
  end;

end.
