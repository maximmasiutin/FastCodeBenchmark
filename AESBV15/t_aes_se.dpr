{-Test prog for AES (Fastcode special edition) basic functions , we Sep. 2004}

program T_AES_WS;

{$J+,N+}
{$apptype console}

uses
  aes_type, aes_encr, aes_decr;

const
  key128 : TAES_WE_Block = ($2b,$7e,$15,$16,$28,$ae,$d2,$a6,
                            $ab,$f7,$15,$88,$09,$cf,$4f,$3c);

  plain  : TAES_WE_Block= ($6b,$c1,$be,$e2,$2e,$40,$9f,$96,
                           $e9,$3d,$7e,$11,$73,$93,$17,$2a);

  ct_ecb : TAES_WE_Block = ($3a,$d7,$7b,$b4,$0d,$7a,$36,$60,
                            $a8,$9e,$ca,$f3,$24,$66,$ef,$97);

var
  ct: TAES_WE_Block;
  Context: TAES_WE_Context;


{---------------------------------------------------------------------------}
function same(const B1, B2: TAES_WE_Block): boolean;
  {-compares two AES blocks}
var
  i: integer;
begin
  result := false;
  for i:=0 to 15 do begin
    if B1[i]<>B2[i] then exit;
  end;
  result := true;
end;


{---------------------------------------------------------------------------}
procedure TestECB;
  {-Test encr/decr of a single block}
begin
  if AES_Init_Encr(key128, 128, context)<>0 then begin
    writeln('*** Error Init_Encr');
    exit;
  end;
  AES_WE_Encrypt(context, plain, ct);
  if not same(ct, ct_ecb) then begin
    writeln('*** Error encrypt');
    exit;
  end
  else writeln('Encrypt ok');

  if AES_Init_Decr(key128, 128, context)<>0 then begin
    writeln('*** Error Init_Decr');
    exit;
  end;
  AES_WE_Decrypt(context, ct_ecb, ct);
  if not same(plain, ct) then begin
    writeln('*** Error decrypt');
    exit;
  end
  else writeln('Decrypt ok');
end;

begin
  writeln('Test program AES (Fastcode special ed.) basic functions   (C) 2004 W.Ehrhardt');
  TestECB;
end.
