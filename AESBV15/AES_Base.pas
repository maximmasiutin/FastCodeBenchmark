unit AES_Base;

(*************************************************************************

 DESCRIPTION     :  AES basic routines

 REQUIREMENTS    :  TP5-7, D1-D7, FPC, VP  [*see note]

 EXTERNAL DATA   :  ---

 MEMORY USAGE    :  ---

 DISPLAY MODE    :  ---

 REFERENCES      :  [1] http://csrc.nist.gov/fips/fips-197.pdf
                    [2] rijndael-alg-fst.c V2.0/3.0: Rijmen et al Aug1999/Dec2000


 Version  Date      Author      Modification
 -------  --------  -------     ------------------------------------------
 0.23     16.08.03  we          From AESCrypt
 0.24     16.08.03  we          new xor_block
 0.25     18.09.03  we          Static tables, GF routines moved to aes_decr
 0.26     21.09.03  we          routines as functions
 0.27     27.09.03  we          FPC/go32v2
 0.28     05.10.03  we          STD.INC, TP5-6
 0.29     07.12.03  we          BugFix: exit if invalid key length
 0.30     27.12.03  we          BASM16: xorblock
 0.31     01.01.04  we          RotWord inline via shl/shr, SubWord function
 0.32     15.01.04  we          Keysetup like [2]
 0.33     15.01.04  we          BIT16: Keysetup with byte arrays
 0.34     06.03.04  we          removed exit in 128 bit key setup
 0.35     02.07.04  we          {$ifdef DLL} stdcall; {$endif}
 0.36     19.09.04  we/dkc      Cardinals, Delphi4..7 only, no DLL code
**************************************************************************)


(*-------------------------------------------------------------------------
 (C) Copyright 2002-2004 Wolfgang Ehrhardt

 This software is provided 'as-is', without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it
 freely, subject to the following restrictions:

 1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software in
    a product, an acknowledgment in the product documentation would be
    appreciated but is not required.

 2. Altered source versions must be plainly marked as such, and must not be
    misrepresented as being the original software.

 3. This notice may not be removed or altered from any source distribution.


[*note]
This source code is a special edition for the FastCode AES project:
http://dennishomepage.gugs-cats.dk/AESBVxx.zip, xx=01..06.
Dennis Kjaer Christensen stripped the support for pascal compilers other than
Delphi 4..7. This is an updated version of the dkc changes, the full source
code is availables from of http://home.netsurf.de/wolfgang.ehrhardt
----------------------------------------------------------------------------*)


interface


uses AES_Type;


{helper types}
type
  TWA4   = packed array[0..3] of Cardinal;     {AES block as array of Cardinal}
  TBA4   = packed array[0..3] of byte;         {AES "word" as array of byte  }
  TAWk   = packed array[0..4*(AES_WE_MaxRounds+1)-1] of Cardinal; {Key as array of Cardinal}

{-AES static tables}
const
  SBox: array[byte] of byte =
   ($63, $7c, $77, $7b, $f2, $6b, $6f, $c5, $30, $01, $67, $2b, $fe, $d7, $ab, $76,
    $ca, $82, $c9, $7d, $fa, $59, $47, $f0, $ad, $d4, $a2, $af, $9c, $a4, $72, $c0,
    $b7, $fd, $93, $26, $36, $3f, $f7, $cc, $34, $a5, $e5, $f1, $71, $d8, $31, $15,
    $04, $c7, $23, $c3, $18, $96, $05, $9a, $07, $12, $80, $e2, $eb, $27, $b2, $75,
    $09, $83, $2c, $1a, $1b, $6e, $5a, $a0, $52, $3b, $d6, $b3, $29, $e3, $2f, $84,
    $53, $d1, $00, $ed, $20, $fc, $b1, $5b, $6a, $cb, $be, $39, $4a, $4c, $58, $cf,
    $d0, $ef, $aa, $fb, $43, $4d, $33, $85, $45, $f9, $02, $7f, $50, $3c, $9f, $a8,
    $51, $a3, $40, $8f, $92, $9d, $38, $f5, $bc, $b6, $da, $21, $10, $ff, $f3, $d2,
    $cd, $0c, $13, $ec, $5f, $97, $44, $17, $c4, $a7, $7e, $3d, $64, $5d, $19, $73,
    $60, $81, $4f, $dc, $22, $2a, $90, $88, $46, $ee, $b8, $14, $de, $5e, $0b, $db,
    $e0, $32, $3a, $0a, $49, $06, $24, $5c, $c2, $d3, $ac, $62, $91, $95, $e4, $79,
    $e7, $c8, $37, $6d, $8d, $d5, $4e, $a9, $6c, $56, $f4, $ea, $65, $7a, $ae, $08,
    $ba, $78, $25, $2e, $1c, $a6, $b4, $c6, $e8, $dd, $74, $1f, $4b, $bd, $8b, $8a,
    $70, $3e, $b5, $66, $48, $03, $f6, $0e, $61, $35, $57, $b9, $86, $c1, $1d, $9e,
    $e1, $f8, $98, $11, $69, $d9, $8e, $94, $9b, $1e, $87, $e9, $ce, $55, $28, $df,
    $8c, $a1, $89, $0d, $bf, $e6, $42, $68, $41, $99, $2d, $0f, $b0, $54, $bb, $16);


procedure XorBlock(const B1, B2: TAES_WE_Block; var B3: TAES_WE_Block);
  {-xor two blocks, result in third}

function AES_Init(const Key; KeyBits: word; var ctx: TAES_WE_Context): integer;
  {-AES key expansion, error if invalid key size}


implementation

const
  RCon: array[0..9] of Cardinal= ($01,$02,$04,$08,$10,$20,$40,$80,$1b,$36);


{---------------------------------------------------------------------------}
procedure XorBlock(const B1, B2: TAES_WE_Block; var B3: TAES_WE_Block);
  {-xor two blocks, result in third}
var
  a1: TWA4 absolute B1;
  a2: TWA4 absolute B2;
  a3: TWA4 absolute B3;
begin
  a3[0] := a1[0] xor a2[0];
  a3[1] := a1[1] xor a2[1];
  a3[2] := a1[2] xor a2[2];
  a3[3] := a1[3] xor a2[3];
end;


{---------------------------------------------------------------------------}
function AES_Init(const Key; KeyBits: word; var ctx: TAES_WE_Context): integer;
  {-AES key expansion, error if invalid key size}
var
  i,p : integer;
  Nk  : word;
  temp: Cardinal;
begin
  AES_Init := 0;
  fillchar(ctx, sizeof(ctx), 0);

  if (KeyBits<>128) and (KeyBits<>192) and (KeyBits<>256) then begin
    AES_Init := AES_Err_Invalid_Key_Size;
    exit;
  end;

  Nk := KeyBits div 32;
  Move(Key, ctx.RK, 4*Nk);

  ctx.KeyBits := KeyBits;
  ctx.Rounds  := 6 + Nk;
  ctx.Decrypt := 0;

  {Calculate encryption round keys, cf.[2]}
  p := 0;

  {32 bit use shift and mask}
  with ctx do begin
    if keybits=128 then begin
      for i:=0 to 9 do begin
         temp := TAWk(RK)[p+3];
         TAWk(RK)[p+4] := (Cardinal(SBox[(temp shr  8) and $ff])       ) xor
                          (Cardinal(SBox[(temp shr 16) and $ff]) shl  8) xor
                          (Cardinal(SBox[(temp shr 24)        ]) shl 16) xor
                          (Cardinal(SBox[(temp       ) and $ff]) shl 24) xor
                          TAWk(RK)[p] xor RCon[i];
         TAWk(RK)[p+5] := TAWk(RK)[p+1] xor TAWk(RK)[p+4];
         TAWk(RK)[p+6] := TAWk(RK)[p+2] xor TAWk(RK)[p+5];
         TAWk(RK)[p+7] := TAWk(RK)[p+3] xor TAWk(RK)[p+6];
         inc(p,4);
      end;
    end
    else if keybits=192 then begin
      for i:=0 to 7 do begin
        temp := TAWk(RK)[p+5];
        TAWk(RK)[p+ 6] := (Cardinal(SBox[(temp shr  8) and $ff])       ) xor
                          (Cardinal(SBox[(temp shr 16) and $ff]) shl  8) xor
                          (Cardinal(SBox[(temp shr 24)        ]) shl 16) xor
                          (Cardinal(SBox[(temp       ) and $ff]) shl 24) xor
                          TAWk(RK)[p] xor RCon[i];
        TAWk(RK)[p+ 7] := TAWk(RK)[p+1] xor TAWk(RK)[p+6];
        TAWk(RK)[p+ 8] := TAWk(RK)[p+2] xor TAWk(RK)[p+7];
        TAWk(RK)[p+ 9] := TAWk(RK)[p+3] xor TAWk(RK)[p+8];
        if i=7 then exit;
        TAWk(RK)[p+10] := TAWk(RK)[p+4] xor TAWk(RK)[p+ 9];
        TAWk(RK)[p+11] := TAWk(RK)[p+5] xor TAWk(RK)[p+10];
        inc(p,6);
      end;
    end
    else begin
      for i:=0 to 6 do begin
        temp := TAWk(RK)[p+7];
        TAWk(RK)[p+ 8] := (Cardinal(SBox[(temp shr  8) and $ff])       ) xor
                          (Cardinal(SBox[(temp shr 16) and $ff]) shl  8) xor
                          (Cardinal(SBox[(temp shr 24)        ]) shl 16) xor
                          (Cardinal(SBox[(temp       ) and $ff]) shl 24) xor
                          TAWk(RK)[p] xor RCon[i];
        TAWk(RK)[p+ 9] := TAWk(RK)[p+1] xor TAWk(RK)[p+ 8];
        TAWk(RK)[p+10] := TAWk(RK)[p+2] xor TAWk(RK)[p+ 9];
        TAWk(RK)[p+11] := TAWk(RK)[p+3] xor TAWk(RK)[p+10];
        if i=6 then exit;
        temp := TAWk(RK)[p+11];
        TAWk(RK)[p+12] := (Cardinal(SBox[(temp       ) and $ff])       ) xor
                          (Cardinal(SBox[(temp shr  8) and $ff]) shl  8) xor
                          (Cardinal(SBox[(temp shr 16) and $ff]) shl 16) xor
                          (Cardinal(SBox[(temp shr 24)        ]) shl 24) xor
                          TAWk(RK)[p+4];
        TAWk(RK)[p+13] := TAWk(RK)[p+5] xor TAWk(RK)[p+12];
        TAWk(RK)[p+14] := TAWk(RK)[p+6] xor TAWk(RK)[p+13];
        TAWk(RK)[p+15] := TAWk(RK)[p+7] xor TAWk(RK)[p+14];
        inc(p, 8);
      end;
   end
  end;
end;

end.
