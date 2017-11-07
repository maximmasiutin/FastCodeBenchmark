unit CharPosShaUnit;

interface

function CharPos_Sha_Pas_1_a(ch: char; const s: AnsiString): integer;
function CharPos_Sha_Pas_1_b(ch: char; const s: AnsiString): integer;
function CharPos_Sha_Pas_1_c(ch: char; const s: AnsiString): integer;
function CharPos_Sha_Pas_1_d(ch: char; const s: AnsiString): integer;
function CharPos_Sha_Pas_2_a(ch: char; const s: AnsiString): integer;
function CharPos_Sha_Pas_2_b(ch: char; const s: AnsiString): integer;
function CharPos_Sha_Pas_2_c(ch: char; const s: AnsiString): integer;
function CharPos_Sha_Pas_2_d(ch: char; const s: AnsiString): integer;
function CharPos_Sha_IA32_1_a(ch: char; const s: AnsiString): integer;
function CharPos_Sha_IA32_1_b(ch: char; const s: AnsiString): integer;
function CharPos_Sha_IA32_1_c(ch: char; const s: AnsiString): integer;
function CharPos_Sha_IA32_1_d(ch: char; const s: AnsiString): integer;

implementation

function CharPos_Sha_Pas_1_a(ch: char; const s: AnsiString): integer;
var
  c, d, Mask, Sign, Lim, SaveLenAddr: integer;
label
  Next, Last4, Last3, Found1, Found2, NotFound;
begin;
    Result:=integer(s)-4;              // length address
    Mask:=byte(ch);                    // start creation mask
    Lim:=Result;
    c:=-4;
    if Result=-4 then goto NotFound;   // if empty string
    c:=c and pIntegerArray(Lim)[0];    // c:=length - length mod 4
    if c=0 then goto Last3;            // if length<4
    d:=Mask;
    Mask:=(Mask shl 8);
    Lim:=Lim+c;                        // main loop limit
    Mask:=Mask or d;
    cardinal(Sign):=$80808080;         // sign bit in each byte
    c:=Mask;
    SaveLenAddr:=Result;               // save address of length
    Mask:=Mask shl 16;
    d:=pIntegerArray(Result)[1];       // first dword of string
    Mask:=Mask or c;                   // mask created
    inc(Result,4);
    d:=d xor Mask;                     // zero in matched byte
    if cardinal(Result)>=cardinal(Lim) // if last full dword
      then goto Last4;
Next:
    c:=integer(@pchar(d)[-$01010101]); // minus 1 from each byte
    d:=d xor (-1);
    c:=c and d;                        // set sign on in matched byte
    d:=Mask;
    if c and Sign<>0 then goto Found1; // if matched in any byte
    d:=d xor pIntegerArray(Result)[1]; // zero in matched byte
    inc(Result,4);
    if cardinal(Result)<cardinal(Lim)  // if not last full dword
      then goto Next;
Last4:                                 // last dword
    c:=integer(@pchar(d)[-$01010101]); // minus 1 from each byte
    d:=d xor (-1);
    c:=c and d;                        // set sign on in matched byte
    Lim:=SaveLenAddr;                  // get address of length
    if c and Sign<>0 then goto Found2; // if matched in any byte
Last3:                                 // last (length mod 4) bytes
    c:=3;
    c:=c and pIntegerArray(Lim)[0];
    if c=0 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[4]) then begin; Result:=Result-Lim+1;
exit; end;
    if c=1 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[5]) then begin; Result:=Result-Lim+2;
exit; end;
    if c=2 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[6]) then begin; Result:=Result-Lim+3;
exit; end;
NotFound:
    Result:=0; exit;
    goto NotFound;                     // supress compiler warnings
Found1:                                // not last dword ...
    Lim:=SaveLenAddr;                  // ... need address of length
Found2:                                // finally find matched byte
    c:=c and Sign;                     // get sign of each byte
    dec(Result,Lim);                   // index of highest byte in Result
    if word(c)<>0 then dec(Result,2) else c:=c shr 16;
    if byte(c)<>0 then dec(Result);
  end;

function CharPos_Sha_Pas_1_b(ch: char; const s: AnsiString): integer;
var
  c, d, Mask, Sign, Lim, SaveLenAddr: integer;
label
  Next, Last4, Last3, Found1, Found2, NotFound;
begin;
    Result:=integer(s)-4;              // length address
    Mask:=byte(ch);                    // start creation mask
    Lim:=Result;
    c:=-4;
    if Result=-4 then goto NotFound;   // if empty string
    c:=c and pIntegerArray(Lim)[0];    // c:=length - length mod 4
    if c=0 then goto Last3;            // if length<4
    d:=Mask;
    Mask:=(Mask shl 8);
    Lim:=Lim+c;                        // main loop limit
    Mask:=Mask or d;
    cardinal(Sign):=$80808080;         // sign bit in each byte
    c:=Mask;
    SaveLenAddr:=Result;               // save address of length
    Mask:=Mask shl 16;
    d:=pIntegerArray(Result)[1];       // first dword of string
    Mask:=Mask or c;                   // mask created
    inc(Result,4);
    d:=d xor Mask;                     // zero in matched byte
    if cardinal(Result)>=cardinal(Lim) // if last full dword
      then goto Last4;
Next:
    c:=integer(@pchar(d)[-$01010101]); // minus 1 from each byte
    d:=d xor (-1);
    c:=c and d;                        // set sign on in matched byte
    d:=Mask;
    if c and Sign<>0 then goto Found1; // if matched in any byte
    d:=d xor pIntegerArray(Result)[1]; // zero in matched byte
    inc(Result,4);
    if cardinal(Result)<cardinal(Lim)  // if not last full dword
      then goto Next;
Last4:                                 // last dword
    c:=integer(@pchar(d)[-$01010101]); // minus 1 from each byte
    d:=d xor (-1);
    c:=c and d;                        // set sign on in matched byte
    Lim:=SaveLenAddr;                  // get address of length
    if c and Sign<>0 then goto Found2; // if matched in any byte
Last3:                                 // last (length mod 4) bytes
    c:=3;
    c:=c and pIntegerArray(Lim)[0];
    if c=0 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[4]) then begin; Result:=Result-Lim+1;
exit; end;
    if c=1 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[5]) then begin; Result:=Result-Lim+2;
exit; end;
    if c=2 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[6]) then begin; Result:=Result-Lim+3;
exit; end;
NotFound:
    Result:=0; exit;
    goto NotFound;                     // supress compiler warnings
Found1:                                // not last dword ...
    Lim:=SaveLenAddr;                  // ... need address of length
Found2:                                // finally find matched byte
    c:=c and Sign;                     // get sign of each byte
    dec(Result,Lim);                   // index of highest byte in Result
    if word(c)<>0 then dec(Result,2) else c:=c shr 16;
    if byte(c)<>0 then dec(Result);
  end;

function CharPos_Sha_Pas_1_c(ch: char; const s: AnsiString): integer;
var
  c, d, Mask, Sign, Lim, SaveLenAddr: integer;
label
  Next, Last4, Last3, Found1, Found2, NotFound;
begin;
    Result:=integer(s)-4;              // length address
    Mask:=byte(ch);                    // start creation mask
    Lim:=Result;
    c:=-4;
    if Result=-4 then goto NotFound;   // if empty string
    c:=c and pIntegerArray(Lim)[0];    // c:=length - length mod 4
    if c=0 then goto Last3;            // if length<4
    d:=Mask;
    Mask:=(Mask shl 8);
    Lim:=Lim+c;                        // main loop limit
    Mask:=Mask or d;
    cardinal(Sign):=$80808080;         // sign bit in each byte
    c:=Mask;
    SaveLenAddr:=Result;               // save address of length
    Mask:=Mask shl 16;
    d:=pIntegerArray(Result)[1];       // first dword of string
    Mask:=Mask or c;                   // mask created
    inc(Result,4);
    d:=d xor Mask;                     // zero in matched byte
    if cardinal(Result)>=cardinal(Lim) // if last full dword
      then goto Last4;
Next:
    c:=integer(@pchar(d)[-$01010101]); // minus 1 from each byte
    d:=d xor (-1);
    c:=c and d;                        // set sign on in matched byte
    d:=Mask;
    if c and Sign<>0 then goto Found1; // if matched in any byte
    d:=d xor pIntegerArray(Result)[1]; // zero in matched byte
    inc(Result,4);
    if cardinal(Result)<cardinal(Lim)  // if not last full dword
      then goto Next;
Last4:                                 // last dword
    c:=integer(@pchar(d)[-$01010101]); // minus 1 from each byte
    d:=d xor (-1);
    c:=c and d;                        // set sign on in matched byte
    Lim:=SaveLenAddr;                  // get address of length
    if c and Sign<>0 then goto Found2; // if matched in any byte
Last3:                                 // last (length mod 4) bytes
    c:=3;
    c:=c and pIntegerArray(Lim)[0];
    if c=0 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[4]) then begin; Result:=Result-Lim+1;
exit; end;
    if c=1 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[5]) then begin; Result:=Result-Lim+2;
exit; end;
    if c=2 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[6]) then begin; Result:=Result-Lim+3;
exit; end;
NotFound:
    Result:=0; exit;
    goto NotFound;                     // supress compiler warnings
Found1:                                // not last dword ...
    Lim:=SaveLenAddr;                  // ... need address of length
Found2:                                // finally find matched byte
    c:=c and Sign;                     // get sign of each byte
    dec(Result,Lim);                   // index of highest byte in Result
    if word(c)<>0 then dec(Result,2) else c:=c shr 16;
    if byte(c)<>0 then dec(Result);
  end;

function CharPos_Sha_Pas_1_d(ch: char; const s: AnsiString): integer;
var
  c, d, Mask, Sign, Lim, SaveLenAddr: integer;
label
  Next, Last4, Last3, Found1, Found2, NotFound;
begin;
    Result:=integer(s)-4;              // length address
    Mask:=byte(ch);                    // start creation mask
    Lim:=Result;
    c:=-4;
    if Result=-4 then goto NotFound;   // if empty string
    c:=c and pIntegerArray(Lim)[0];    // c:=length - length mod 4
    if c=0 then goto Last3;            // if length<4
    d:=Mask;
    Mask:=(Mask shl 8);
    Lim:=Lim+c;                        // main loop limit
    Mask:=Mask or d;
    cardinal(Sign):=$80808080;         // sign bit in each byte
    c:=Mask;
    SaveLenAddr:=Result;               // save address of length
    Mask:=Mask shl 16;
    d:=pIntegerArray(Result)[1];       // first dword of string
    Mask:=Mask or c;                   // mask created
    inc(Result,4);
    d:=d xor Mask;                     // zero in matched byte
    if cardinal(Result)>=cardinal(Lim) // if last full dword
      then goto Last4;
Next:
    c:=integer(@pchar(d)[-$01010101]); // minus 1 from each byte
    d:=d xor (-1);
    c:=c and d;                        // set sign on in matched byte
    d:=Mask;
    if c and Sign<>0 then goto Found1; // if matched in any byte
    d:=d xor pIntegerArray(Result)[1]; // zero in matched byte
    inc(Result,4);
    if cardinal(Result)<cardinal(Lim)  // if not last full dword
      then goto Next;
Last4:                                 // last dword
    c:=integer(@pchar(d)[-$01010101]); // minus 1 from each byte
    d:=d xor (-1);
    c:=c and d;                        // set sign on in matched byte
    Lim:=SaveLenAddr;                  // get address of length
    if c and Sign<>0 then goto Found2; // if matched in any byte
Last3:                                 // last (length mod 4) bytes
    c:=3;
    c:=c and pIntegerArray(Lim)[0];
    if c=0 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[4]) then begin; Result:=Result-Lim+1;
exit; end;
    if c=1 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[5]) then begin; Result:=Result-Lim+2;
exit; end;
    if c=2 then goto NotFound;
    if byte(Mask)=byte(pchar(Result)[6]) then begin; Result:=Result-Lim+3;
exit; end;
NotFound:
    Result:=0; exit;
    goto NotFound;                     // supress compiler warnings
Found1:                                // not last dword ...
    Lim:=SaveLenAddr;                  // ... need address of length
Found2:                                // finally find matched byte
    c:=c and Sign;                     // get sign of each byte
    dec(Result,Lim);                   // index of highest byte in Result
    if word(c)<>0 then dec(Result,2) else c:=c shr 16;
    if byte(c)<>0 then dec(Result);
  end;

function CharPos_Sha_Pas_2_a(ch: char; const s: AnsiString): integer;
const
  cMinusOnes = -$01010101;
  cSignums   =  $80808080;
var
  Ndx, Len, c, d, Mask, Sign, Save, SaveEnd: integer;
label
  Small, Middle, Large,
  Found0, Found1, Found2, Found3, NotFound,
  Matched, MatchedPlus1, MatchedMinus1, NotMatched,
  Return;
begin
  c:=integer(@pchar(integer(s))[-4]);
  if c=-4 then goto NotFound;
  Len:=pinteger(c)^;
  if Len>24 then goto Large;
  Ndx:=4;
  if Ndx>Len then goto Small;

Middle:
  if pchar(c)[Ndx+0]=ch then goto Found0;
  if pchar(c)[Ndx+1]=ch then goto Found1;
  if pchar(c)[Ndx+2]=ch then goto Found2;
  if pchar(c)[Ndx+3]=ch then goto Found3;
  inc(Ndx,4);
  if Ndx<=Len then goto Middle;

  Ndx:=Len+1;
  if pchar(c)[Len+1]=ch then goto Found0;
  if pchar(c)[Len+2]=ch then goto Found1;
  if pchar(c)[Len+3]<>ch then goto NotFound;
  Result:=integer(@pchar(Ndx)[-1]); exit;
  goto Return; //drop Ndx

Small:
  if Len=0 then goto NotFound; if pchar(c)[Ndx+0]=ch then goto Found0;
  if Len=1 then goto NotFound; if pchar(c)[Ndx+1]=ch then goto Found1;
  if Len=2 then goto NotFound; if pchar(c)[Ndx+2]<>ch then goto NotFound;

Found2: Result:=integer(@pchar(Ndx)[-1]); exit;
Found1: Result:=integer(@pchar(Ndx)[-2]); exit;
Found0: Result:=integer(@pchar(Ndx)[-3]); exit;
NotFound: Result:=0; exit;
  goto NotFound; //kill warning 'Ndx might not have been initialized'
Found3: Result:=integer(@pchar(Ndx)[0]); exit;
  goto Return; //drop Ndx

Large:
  Save:=c;
    Mask:=ord(ch);
  Ndx:=integer(@pchar(c)[+4]);

    d:=Mask;
  inc(Len,c);
  SaveEnd:=Len;
    Mask:=(Mask shl 8);
  inc(Len,+4-16+3);

    Mask:=Mask or d;
  Len:=Len and (-4);
    d:=Mask;
  cardinal(Sign):=cSignums;

    Mask:=Mask shl 16;
  c:=pintegerArray(Ndx)[0];
    Mask:=Mask or d;
  inc(Ndx,4);

    c:=c xor Mask;
    d:=integer(@pchar(c)[cMinusOnes]);
    c:=c xor (-1);
    c:=c and d;
    d:=Mask;

    if c and Sign<>0 then goto MatchedMinus1;
    Ndx:=Ndx and (-4);
    d:=d xor pintegerArray(Ndx)[0];

    if cardinal(Ndx)<cardinal(Len) then repeat;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=Mask;

      d:=d xor pintegerArray(Ndx)[1];
      if c and Sign<>0 then goto Matched;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=pintegerArray(Ndx)[2];
      if c and Sign<>0 then goto MatchedPlus1;
      d:=d xor Mask;

      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      inc(Ndx,12);
      c:=c and d;

      //if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if c and Sign<>0 then goto MatchedMinus1;
      d:=d xor pintegerArray(Ndx)[0];
      until cardinal(Ndx)>=cardinal(Len);

    Len:=SaveEnd;
    while true do begin;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      inc(Ndx,4);
      if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if cardinal(Ndx)<=cardinal(Len)
      then d:=d xor pintegerArray(Ndx)[0]
      else begin;
        if Len=0 then goto NotMatched;
        d:=d xor pintegerArray(Len)[0];
        Ndx:=Len;
        Len:=0;
        end
      end;

NotMatched:
  Result:=0; exit;

MatchedPlus1:   inc(Ndx,8);
MatchedMinus1:  dec(Ndx,4);
Matched:
    c:=c and Sign;
    dec(Ndx,integer(Save)+2);
    if word(c)=0 then begin;
      c:=c shr 16; inc(Ndx,2);
      end;
    if byte(c)<>0 then dec(Ndx);
    Result:=Ndx;
Return:
  end;

procedure Filler1;
asm
 nop
end;

function CharPos_Sha_Pas_2_b(ch: char; const s: AnsiString): integer;
const
  cMinusOnes = -$01010101;
  cSignums   =  $80808080;
var
  Ndx, Len, c, d, Mask, Sign, Save, SaveEnd: integer;
label
  Small, Middle, Large,
  Found0, Found1, Found2, Found3, NotFound,
  Matched, MatchedPlus1, MatchedMinus1, NotMatched,
  Return;
begin
  c:=integer(@pchar(integer(s))[-4]);
  if c=-4 then goto NotFound;
  Len:=pinteger(c)^;
  if Len>24 then goto Large;
  Ndx:=4;
  if Ndx>Len then goto Small;

Middle:
  if pchar(c)[Ndx+0]=ch then goto Found0;
  if pchar(c)[Ndx+1]=ch then goto Found1;
  if pchar(c)[Ndx+2]=ch then goto Found2;
  if pchar(c)[Ndx+3]=ch then goto Found3;
  inc(Ndx,4);
  if Ndx<=Len then goto Middle;

  Ndx:=Len+1;
  if pchar(c)[Len+1]=ch then goto Found0;
  if pchar(c)[Len+2]=ch then goto Found1;
  if pchar(c)[Len+3]<>ch then goto NotFound;
  Result:=integer(@pchar(Ndx)[-1]); exit;
  goto Return; //drop Ndx

Small:
  if Len=0 then goto NotFound; if pchar(c)[Ndx+0]=ch then goto Found0;
  if Len=1 then goto NotFound; if pchar(c)[Ndx+1]=ch then goto Found1;
  if Len=2 then goto NotFound; if pchar(c)[Ndx+2]<>ch then goto NotFound;

Found2: Result:=integer(@pchar(Ndx)[-1]); exit;
Found1: Result:=integer(@pchar(Ndx)[-2]); exit;
Found0: Result:=integer(@pchar(Ndx)[-3]); exit;
NotFound: Result:=0; exit;
  goto NotFound; //kill warning 'Ndx might not have been initialized'
Found3: Result:=integer(@pchar(Ndx)[0]); exit;
  goto Return; //drop Ndx

Large:
  Save:=c;
    Mask:=ord(ch);
  Ndx:=integer(@pchar(c)[+4]);

    d:=Mask;
  inc(Len,c);
  SaveEnd:=Len;
    Mask:=(Mask shl 8);
  inc(Len,+4-16+3);

    Mask:=Mask or d;
  Len:=Len and (-4);
    d:=Mask;
  cardinal(Sign):=cSignums;

    Mask:=Mask shl 16;
  c:=pintegerArray(Ndx)[0];
    Mask:=Mask or d;
  inc(Ndx,4);

    c:=c xor Mask;
    d:=integer(@pchar(c)[cMinusOnes]);
    c:=c xor (-1);
    c:=c and d;
    d:=Mask;

    if c and Sign<>0 then goto MatchedMinus1;
    Ndx:=Ndx and (-4);
    d:=d xor pintegerArray(Ndx)[0];

    if cardinal(Ndx)<cardinal(Len) then repeat;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=Mask;

      d:=d xor pintegerArray(Ndx)[1];
      if c and Sign<>0 then goto Matched;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=pintegerArray(Ndx)[2];
      if c and Sign<>0 then goto MatchedPlus1;
      d:=d xor Mask;

      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      inc(Ndx,12);
      c:=c and d;

      //if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if c and Sign<>0 then goto MatchedMinus1;
      d:=d xor pintegerArray(Ndx)[0];
      until cardinal(Ndx)>=cardinal(Len);

    Len:=SaveEnd;
    while true do begin;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      inc(Ndx,4);
      if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if cardinal(Ndx)<=cardinal(Len)
      then d:=d xor pintegerArray(Ndx)[0]
      else begin;
        if Len=0 then goto NotMatched;
        d:=d xor pintegerArray(Len)[0];
        Ndx:=Len;
        Len:=0;
        end
      end;

NotMatched:
  Result:=0; exit;

MatchedPlus1:   inc(Ndx,8);
MatchedMinus1:  dec(Ndx,4);
Matched:
    c:=c and Sign;
    dec(Ndx,integer(Save)+2);
    if word(c)=0 then begin;
      c:=c shr 16; inc(Ndx,2);
      end;
    if byte(c)<>0 then dec(Ndx);
    Result:=Ndx;
Return:
  end;

procedure Filler2;
asm
 nop
end;

function CharPos_Sha_Pas_2_c(ch: char; const s: AnsiString): integer;
const
  cMinusOnes = -$01010101;
  cSignums   =  $80808080;
var
  Ndx, Len, c, d, Mask, Sign, Save, SaveEnd: integer;
label
  Small, Middle, Large,
  Found0, Found1, Found2, Found3, NotFound,
  Matched, MatchedPlus1, MatchedMinus1, NotMatched,
  Return;
begin
  c:=integer(@pchar(integer(s))[-4]);
  if c=-4 then goto NotFound;
  Len:=pinteger(c)^;
  if Len>24 then goto Large;
  Ndx:=4;
  if Ndx>Len then goto Small;

Middle:
  if pchar(c)[Ndx+0]=ch then goto Found0;
  if pchar(c)[Ndx+1]=ch then goto Found1;
  if pchar(c)[Ndx+2]=ch then goto Found2;
  if pchar(c)[Ndx+3]=ch then goto Found3;
  inc(Ndx,4);
  if Ndx<=Len then goto Middle;

  Ndx:=Len+1;
  if pchar(c)[Len+1]=ch then goto Found0;
  if pchar(c)[Len+2]=ch then goto Found1;
  if pchar(c)[Len+3]<>ch then goto NotFound;
  Result:=integer(@pchar(Ndx)[-1]); exit;
  goto Return; //drop Ndx

Small:
  if Len=0 then goto NotFound; if pchar(c)[Ndx+0]=ch then goto Found0;
  if Len=1 then goto NotFound; if pchar(c)[Ndx+1]=ch then goto Found1;
  if Len=2 then goto NotFound; if pchar(c)[Ndx+2]<>ch then goto NotFound;

Found2: Result:=integer(@pchar(Ndx)[-1]); exit;
Found1: Result:=integer(@pchar(Ndx)[-2]); exit;
Found0: Result:=integer(@pchar(Ndx)[-3]); exit;
NotFound: Result:=0; exit;
  goto NotFound; //kill warning 'Ndx might not have been initialized'
Found3: Result:=integer(@pchar(Ndx)[0]); exit;
  goto Return; //drop Ndx

Large:
  Save:=c;
    Mask:=ord(ch);
  Ndx:=integer(@pchar(c)[+4]);

    d:=Mask;
  inc(Len,c);
  SaveEnd:=Len;
    Mask:=(Mask shl 8);
  inc(Len,+4-16+3);

    Mask:=Mask or d;
  Len:=Len and (-4);
    d:=Mask;
  cardinal(Sign):=cSignums;

    Mask:=Mask shl 16;
  c:=pintegerArray(Ndx)[0];
    Mask:=Mask or d;
  inc(Ndx,4);

    c:=c xor Mask;
    d:=integer(@pchar(c)[cMinusOnes]);
    c:=c xor (-1);
    c:=c and d;
    d:=Mask;

    if c and Sign<>0 then goto MatchedMinus1;
    Ndx:=Ndx and (-4);
    d:=d xor pintegerArray(Ndx)[0];

    if cardinal(Ndx)<cardinal(Len) then repeat;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=Mask;

      d:=d xor pintegerArray(Ndx)[1];
      if c and Sign<>0 then goto Matched;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=pintegerArray(Ndx)[2];
      if c and Sign<>0 then goto MatchedPlus1;
      d:=d xor Mask;

      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      inc(Ndx,12);
      c:=c and d;

      //if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if c and Sign<>0 then goto MatchedMinus1;
      d:=d xor pintegerArray(Ndx)[0];
      until cardinal(Ndx)>=cardinal(Len);

    Len:=SaveEnd;
    while true do begin;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      inc(Ndx,4);
      if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if cardinal(Ndx)<=cardinal(Len)
      then d:=d xor pintegerArray(Ndx)[0]
      else begin;
        if Len=0 then goto NotMatched;
        d:=d xor pintegerArray(Len)[0];
        Ndx:=Len;
        Len:=0;
        end
      end;

NotMatched:
  Result:=0; exit;

MatchedPlus1:   inc(Ndx,8);
MatchedMinus1:  dec(Ndx,4);
Matched:
    c:=c and Sign;
    dec(Ndx,integer(Save)+2);
    if word(c)=0 then begin;
      c:=c shr 16; inc(Ndx,2);
      end;
    if byte(c)<>0 then dec(Ndx);
    Result:=Ndx;
Return:
  end;

procedure Filler3;
asm
 nop
end;

function CharPos_Sha_Pas_2_d(ch: char; const s: AnsiString): integer;
const
  cMinusOnes = -$01010101;
  cSignums   =  $80808080;
var
  Ndx, Len, c, d, Mask, Sign, Save, SaveEnd: integer;
label
  Small, Middle, Large,
  Found0, Found1, Found2, Found3, NotFound,
  Matched, MatchedPlus1, MatchedMinus1, NotMatched,
  Return;
begin
  c:=integer(@pchar(integer(s))[-4]);
  if c=-4 then goto NotFound;
  Len:=pinteger(c)^;
  if Len>24 then goto Large;
  Ndx:=4;
  if Ndx>Len then goto Small;

Middle:
  if pchar(c)[Ndx+0]=ch then goto Found0;
  if pchar(c)[Ndx+1]=ch then goto Found1;
  if pchar(c)[Ndx+2]=ch then goto Found2;
  if pchar(c)[Ndx+3]=ch then goto Found3;
  inc(Ndx,4);
  if Ndx<=Len then goto Middle;

  Ndx:=Len+1;
  if pchar(c)[Len+1]=ch then goto Found0;
  if pchar(c)[Len+2]=ch then goto Found1;
  if pchar(c)[Len+3]<>ch then goto NotFound;
  Result:=integer(@pchar(Ndx)[-1]); exit;
  goto Return; //drop Ndx

Small:
  if Len=0 then goto NotFound; if pchar(c)[Ndx+0]=ch then goto Found0;
  if Len=1 then goto NotFound; if pchar(c)[Ndx+1]=ch then goto Found1;
  if Len=2 then goto NotFound; if pchar(c)[Ndx+2]<>ch then goto NotFound;

Found2: Result:=integer(@pchar(Ndx)[-1]); exit;
Found1: Result:=integer(@pchar(Ndx)[-2]); exit;
Found0: Result:=integer(@pchar(Ndx)[-3]); exit;
NotFound: Result:=0; exit;
  goto NotFound; //kill warning 'Ndx might not have been initialized'
Found3: Result:=integer(@pchar(Ndx)[0]); exit;
  goto Return; //drop Ndx

Large:
  Save:=c;
    Mask:=ord(ch);
  Ndx:=integer(@pchar(c)[+4]);

    d:=Mask;
  inc(Len,c);
  SaveEnd:=Len;
    Mask:=(Mask shl 8);
  inc(Len,+4-16+3);

    Mask:=Mask or d;
  Len:=Len and (-4);
    d:=Mask;
  cardinal(Sign):=cSignums;

    Mask:=Mask shl 16;
  c:=pintegerArray(Ndx)[0];
    Mask:=Mask or d;
  inc(Ndx,4);

    c:=c xor Mask;
    d:=integer(@pchar(c)[cMinusOnes]);
    c:=c xor (-1);
    c:=c and d;
    d:=Mask;

    if c and Sign<>0 then goto MatchedMinus1;
    Ndx:=Ndx and (-4);
    d:=d xor pintegerArray(Ndx)[0];

    if cardinal(Ndx)<cardinal(Len) then repeat;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=Mask;

      d:=d xor pintegerArray(Ndx)[1];
      if c and Sign<>0 then goto Matched;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=pintegerArray(Ndx)[2];
      if c and Sign<>0 then goto MatchedPlus1;
      d:=d xor Mask;

      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      inc(Ndx,12);
      c:=c and d;

      //if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if c and Sign<>0 then goto MatchedMinus1;
      d:=d xor pintegerArray(Ndx)[0];
      until cardinal(Ndx)>=cardinal(Len);

    Len:=SaveEnd;
    while true do begin;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      inc(Ndx,4);
      if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if cardinal(Ndx)<=cardinal(Len)
      then d:=d xor pintegerArray(Ndx)[0]
      else begin;
        if Len=0 then goto NotMatched;
        d:=d xor pintegerArray(Len)[0];
        Ndx:=Len;
        Len:=0;
        end
      end;

NotMatched:
  Result:=0; exit;

MatchedPlus1:   inc(Ndx,8);
MatchedMinus1:  dec(Ndx,4);
Matched:
    c:=c and Sign;
    dec(Ndx,integer(Save)+2);
    if word(c)=0 then begin;
      c:=c shr 16; inc(Ndx,2);
      end;
    if byte(c)<>0 then dec(Ndx);
    Result:=Ndx;
Return:
  end;

function CharPos_Sha_IA32_1_a(ch: char; const s: AnsiString): integer;
asm
     test edx,edx
     jz @@ret0

     push ebp
     push ebx
     push edx
     push esi
     push edi
     mov ecx,[edx-4]

     xor ecx,-1
     jz @@pop0

     mov ah,al;     add ecx,1
     movzx edi,ax;  and ecx,-4
     shl eax,16;    sub edx,ecx
     or edi,eax;    mov ebp,$80808080

     mov eax,edi
     xor edi,[ecx+edx]
     mov esi,eax
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
     add ecx,4
     jge @@last1
     and ebx,ebp
     jnz @@found4;
     xor esi,[ecx+edx]
     mov ebp,ebp //nop
@@find:
     lea ebx,[esi-$01010101]
     xor esi,-1
     and ebx,esi
     mov edi,[ecx+edx+4]
     add ecx,8
     jge @@last2
     xor edi,eax
     and ebx,ebp
     mov esi,[ecx+edx]
     jnz @@found0
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
     xor esi,eax
     and ebx,ebp
     jz @@find;
@@found4:
     add ecx,4
@@found0:
     shr ebx,8;     jc @@inc0
     shr ebx,8;     jc @@inc1
     shr ebx,8;     jc @@inc2
@@inc3: inc ecx
@@inc2: inc ecx
@@inc1: inc ecx
@@inc0:
     pop edi;
     pop esi;       lea eax,[ecx+edx-7]
     pop edx;
     pop ebx;       sub eax,edx
     pop ebp;       cmp eax,[edx-4]
     jg @@ret0
     ret
@@last2:
     and ebx,ebp
     jnz @@found0
     xor edi,eax
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
@@last1:
     and ebx,ebp
     jnz @@found4;
@@pop0:
     pop edi
     pop esi
     pop edx
     pop ebx
     pop ebp
@@ret0:
     xor eax,eax
     //ret
     end;

function CharPos_Sha_IA32_1_b(ch: char; const s: AnsiString): integer;
asm
     test edx,edx
     jz @@ret0

     push ebp
     push ebx
     push edx
     push esi
     push edi
     mov ecx,[edx-4]

     xor ecx,-1
     jz @@pop0

     mov ah,al;     add ecx,1
     movzx edi,ax;  and ecx,-4
     shl eax,16;    sub edx,ecx
     or edi,eax;    mov ebp,$80808080

     mov eax,edi
     xor edi,[ecx+edx]
     mov esi,eax
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
     add ecx,4
     jge @@last1
     and ebx,ebp
     jnz @@found4;
     xor esi,[ecx+edx]
     mov ebp,ebp //nop
@@find:
     lea ebx,[esi-$01010101]
     xor esi,-1
     and ebx,esi
     mov edi,[ecx+edx+4]
     add ecx,8
     jge @@last2
     xor edi,eax
     and ebx,ebp
     mov esi,[ecx+edx]
     jnz @@found0
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
     xor esi,eax
     and ebx,ebp
     jz @@find;
@@found4:
     add ecx,4
@@found0:
     shr ebx,8;     jc @@inc0
     shr ebx,8;     jc @@inc1
     shr ebx,8;     jc @@inc2
@@inc3: inc ecx
@@inc2: inc ecx
@@inc1: inc ecx
@@inc0:
     pop edi;
     pop esi;       lea eax,[ecx+edx-7]
     pop edx;
     pop ebx;       sub eax,edx
     pop ebp;       cmp eax,[edx-4]
     jg @@ret0
     ret
@@last2:
     and ebx,ebp
     jnz @@found0
     xor edi,eax
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
@@last1:
     and ebx,ebp
     jnz @@found4;
@@pop0:
     pop edi
     pop esi
     pop edx
     pop ebx
     pop ebp
@@ret0:
     xor eax,eax
     //ret
     end;

function CharPos_Sha_IA32_1_c(ch: char; const s: AnsiString): integer;
asm
     test edx,edx
     jz @@ret0

     push ebp
     push ebx
     push edx
     push esi
     push edi
     mov ecx,[edx-4]

     xor ecx,-1
     jz @@pop0

     mov ah,al;     add ecx,1
     movzx edi,ax;  and ecx,-4
     shl eax,16;    sub edx,ecx
     or edi,eax;    mov ebp,$80808080

     mov eax,edi
     xor edi,[ecx+edx]
     mov esi,eax
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
     add ecx,4
     jge @@last1
     and ebx,ebp
     jnz @@found4;
     xor esi,[ecx+edx]
     mov ebp,ebp //nop
@@find:
     lea ebx,[esi-$01010101]
     xor esi,-1
     and ebx,esi
     mov edi,[ecx+edx+4]
     add ecx,8
     jge @@last2
     xor edi,eax
     and ebx,ebp
     mov esi,[ecx+edx]
     jnz @@found0
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
     xor esi,eax
     and ebx,ebp
     jz @@find;
@@found4:
     add ecx,4
@@found0:
     shr ebx,8;     jc @@inc0
     shr ebx,8;     jc @@inc1
     shr ebx,8;     jc @@inc2
@@inc3: inc ecx
@@inc2: inc ecx
@@inc1: inc ecx
@@inc0:
     pop edi;
     pop esi;       lea eax,[ecx+edx-7]
     pop edx;
     pop ebx;       sub eax,edx
     pop ebp;       cmp eax,[edx-4]
     jg @@ret0
     ret
@@last2:
     and ebx,ebp
     jnz @@found0
     xor edi,eax
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
@@last1:
     and ebx,ebp
     jnz @@found4;
@@pop0:
     pop edi
     pop esi
     pop edx
     pop ebx
     pop ebp
@@ret0:
     xor eax,eax
     //ret
     end;

function CharPos_Sha_IA32_1_d(ch: char; const s: AnsiString): integer;
asm
     test edx,edx
     jz @@ret0

     push ebp
     push ebx
     push edx
     push esi
     push edi
     mov ecx,[edx-4]

     xor ecx,-1
     jz @@pop0

     mov ah,al;     add ecx,1
     movzx edi,ax;  and ecx,-4
     shl eax,16;    sub edx,ecx
     or edi,eax;    mov ebp,$80808080

     mov eax,edi
     xor edi,[ecx+edx]
     mov esi,eax
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
     add ecx,4
     jge @@last1
     and ebx,ebp
     jnz @@found4;
     xor esi,[ecx+edx]
     mov ebp,ebp //nop
@@find:
     lea ebx,[esi-$01010101]
     xor esi,-1
     and ebx,esi
     mov edi,[ecx+edx+4]
     add ecx,8
     jge @@last2
     xor edi,eax
     and ebx,ebp
     mov esi,[ecx+edx]
     jnz @@found0
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
     xor esi,eax
     and ebx,ebp
     jz @@find;
@@found4:
     add ecx,4
@@found0:
     shr ebx,8;     jc @@inc0
     shr ebx,8;     jc @@inc1
     shr ebx,8;     jc @@inc2
@@inc3: inc ecx
@@inc2: inc ecx
@@inc1: inc ecx
@@inc0:
     pop edi;
     pop esi;       lea eax,[ecx+edx-7]
     pop edx;
     pop ebx;       sub eax,edx
     pop ebp;       cmp eax,[edx-4]
     jg @@ret0
     ret
@@last2:
     and ebx,ebp
     jnz @@found0
     xor edi,eax
     lea ebx,[edi-$01010101]
     xor edi,-1
     and ebx,edi
@@last1:
     and ebx,ebp
     jnz @@found4;
@@pop0:
     pop edi
     pop esi
     pop edx
     pop ebx
     pop ebp
@@ret0:
     xor eax,eax
     //ret
     end;

initialization

 Filler1;
 Filler2;
 Filler3;

end.
