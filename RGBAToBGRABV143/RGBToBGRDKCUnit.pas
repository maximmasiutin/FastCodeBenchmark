unit RGBToBGRDKCUnit;

interface

uses
 Windows, Graphics;

procedure RGBToBGR_DKC_Pas_12(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_Pas_13(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_Pas_14(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_Pas_15(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_Pas_16(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_Pas_17(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_7(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_8(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_9(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_10(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_11(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_12(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_13(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_14(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_15(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_16(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_17(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_18(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_19(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_20(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_21(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_22(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_IA32_23(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_MMX_3(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_SSE_2(SrcDestBitmap : TBitmap);
procedure RGBToBGR_DKC_SSE_4(SrcDestBitmap : TBitmap);

implementation

uses
 MainUnit, SysUtils;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Optimized for:     Blended
//Instructionset(s): IA32

procedure RGBToBGR_DKC_Pas_12(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNo, ColNoMax : Cardinal;
 SrcPixelRGB : TRGBColor;
 pScanLine : PByteArray;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     for ColNo := 0 to ColNoMax do
      begin
       SrcPixelRGB.Red := pScanLine[4*ColNo];
       SrcPixelRGB.Green := pScanLine[4*ColNo+1];
       SrcPixelRGB.Blue := pScanLine[4*ColNo+2];
       pScanLine[4*ColNo] := SrcPixelRGB.Blue;
       pScanLine[4*ColNo+1] := SrcPixelRGB.Green;
       pScanLine[4*ColNo+2] := SrcPixelRGB.Red;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_Pas_13(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray);
 var
  ColNox, ColNoxTimesFour : Cardinal;
  Red : Byte;

 begin
  ColNox := 0;
  repeat
   ColNoxTimesFour := ColNox * 4;
   Red := pScanLinex[ColNoxTimesFour];
   pScanLinex[ColNoxTimesFour] := pScanLinex[ColNoxTimesFour+2];
   pScanLinex[ColNoxTimesFour+2] := Red;
   Inc(ColNox);
  until(ColNox > ColNoMax);
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_Pas_14(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;
 ColNox, ColNoxTimesFour : Cardinal;
 Red : Byte;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     ColNox := 0;
     repeat
      ColNoxTimesFour := ColNox * 4;
      Red := pScanLine[ColNoxTimesFour];
      pScanLine[ColNoxTimesFour] := pScanLine[ColNoxTimesFour+2];
      pScanLine[ColNoxTimesFour+2] := Red;
      Inc(ColNox);
     until(ColNox > ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_Pas_15(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;
 ColNo, ColNoxTimesFour : Integer;
 Red : Byte;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     ColNo := ColNoMax;
     repeat
      ColNoxTimesFour := ColNo * 4;
      Red := pScanLine[ColNoxTimesFour];
      pScanLine[ColNoxTimesFour] := pScanLine[ColNoxTimesFour+2];
      pScanLine[ColNoxTimesFour+2] := Red;
      Dec(ColNo);
     until(ColNo < 0);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_Pas_16(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;
 ColNo, ColNoxTimesFour : Integer;
 Red, Blue : Byte;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     ColNo := ColNoMax;
     repeat
      ColNoxTimesFour := ColNo * 4;
      Red := pScanLine[ColNoxTimesFour];
      Blue := pScanLine[ColNoxTimesFour+2];
      pScanLine[ColNoxTimesFour] := Blue;
      pScanLine[ColNoxTimesFour+2] := Red;
      Dec(ColNo);
     until(ColNo < 0);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_Pas_17(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;
 ColNo, ColNoxTimesFour, ColNoxTimesFourPlusTwo : Integer;
 Red, Blue : Byte;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     ColNo := ColNoMax;
     repeat
      ColNoxTimesFour := ColNo * 4;
      ColNoxTimesFourPlusTwo := ColNoxTimesFour + 2;
      Red := pScanLine[ColNoxTimesFour];
      Blue := pScanLine[ColNoxTimesFourPlusTwo];
      pScanLine[ColNoxTimesFour] := Blue;
      pScanLine[ColNoxTimesFourPlusTwo] := Red;
      Dec(ColNo);
     until(ColNo < 0);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_7(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    add  edx,edx
    add  edx,edx
    add  eax,edx
  @LoopStart :
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    jns  @LoopStart
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_8(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push ebx
    push esi
    mov  esi,edx
  @LoopStart :
    mov  edx,esi
    shl  edx,$02
    mov  cl,[eax+edx]
    mov  bl,[eax+edx+$02]
    mov  [eax+edx],bl
    mov  [eax+edx+$02],cl
    sub  esi, 1
    jns  @LoopStart
    pop  esi
    pop  ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_9(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    shl  edx,2
  @LoopStart :
    mov  ecx,[eax+edx]
    mov  [eax+edx+2],cl
    shr  ecx, 16
    mov  [eax+edx],cl
    sub  edx, 4
    jns  @LoopStart
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_10(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    add  edx,edx
    add  edx,edx
    add  eax,edx
  @LoopStart :
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    js   @LoopEnd
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    jns  @LoopStart
  @LoopEnd :
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_11(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    add  edx,edx
    add  edx,edx
    add  eax,edx
  @LoopStart :
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    js   @LoopEnd
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    js   @LoopEnd
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    jns  @LoopStart
  @LoopEnd :
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_12(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push  ebx
    push  esi
    mov   esi,edx
  @LoopStart :
    mov   edx,esi
    shl   edx,$02
    movzx ecx,[eax+edx]
    movzx ebx,[eax+edx+$02]
    mov   [eax+edx],bl
    mov   [eax+edx+$02],cl
    sub   esi, 1
    jns   @LoopStart
    pop   esi
    pop   ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_13(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    add  edx,edx
    add  edx,edx
    add  eax,edx
  @LoopStart :
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    js   @LoopEnd
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    js   @LoopEnd
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    js   @LoopEnd
    mov  ecx,[eax]
    bswap ecx
    ror  ecx,8
    mov  [eax],ecx
    sub  eax,4
    sub  edx,4
    jns  @LoopStart
  @LoopEnd :
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_14(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push ebx
    push esi
    push edi
    mov  edi,edx
    //ColNox := 0;
    xor  esi,esi
  @LoopStart :
    //ColNoxTimesFour := ColNox * 4;
    mov ecx,esi
    shl ecx,$02
    //Red := pScanLinex[ColNoxTimesFour];
    mov dl,[eax+ecx]
    //pScanLinex[ColNoxTimesFour] := pScanLinex[ColNoxTimesFour+2];
    mov bl,[eax+ecx+$02]
    mov [eax+ecx],bl
    //pScanLinex[ColNoxTimesFour+2] := Red;
    mov [eax+ecx+$02],dl
    //Inc(ColNox);
    inc esi
    //until(ColNox > ColNoMax);
    cmp esi,edi
    jbe @LoopStart
    pop edi
    pop esi
    pop ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_15(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push ebx
    push esi
    push edi
    mov  edi,edx
    //ColNox := 0;
    xor  esi,esi
  @LoopStart :
    //ColNoxTimesFour := ColNox * 4;
    mov ecx,esi
    shl ecx,$02
    //Red := pScanLinex[ColNoxTimesFour];
    mov dl,[eax+ecx]
    //pScanLinex[ColNoxTimesFour] := pScanLinex[ColNoxTimesFour+2];
    mov bl,[eax+ecx+$02]
    //pScanLinex[ColNoxTimesFour+2] := Red;
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    //Inc(ColNox);
    inc esi
    //until(ColNox > ColNoMax);
    cmp esi,edi
    jbe @LoopStart
    pop edi
    pop esi
    pop ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_16(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push ebx
    push esi
    push edi
    mov  edi,edx
    //ColNox := 0;
    xor  esi,esi
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
  @LoopStart :
    //ColNoxTimesFour := ColNox * 4;
    mov ecx,esi
    shl ecx,$02
    //Red := pScanLinex[ColNoxTimesFour];
    mov dl,[eax+ecx]
    //pScanLinex[ColNoxTimesFour] := pScanLinex[ColNoxTimesFour+2];
    mov bl,[eax+ecx+$02]
    //pScanLinex[ColNoxTimesFour+2] := Red;
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    //Inc(ColNox);
    inc esi
    //until(ColNox > ColNoMax);
    cmp esi,edi
    jbe @LoopStart
    pop edi
    pop esi
    pop ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_17(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push ebx
    push esi
    push edi
    mov  edi,edx
    //ColNox := 0;
    xor  esi,esi
  @LoopStart :
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    ja  @LoopEnd
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    jbe @LoopStart
   @LoopEnd :
    pop edi
    pop esi
    pop ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_18(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push ebx
    push esi
    push edi
    mov  edi,edx
    //ColNox := 0;
    xor  esi,esi
  @LoopStart :
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    ja  @LoopEnd
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    ja  @LoopEnd
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    jbe @LoopStart
   @LoopEnd :
    pop edi
    pop esi
    pop ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_19(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push ebx
    push esi
    push edi
    mov  edi,edx
    //ColNox := 0;
    xor  esi,esi
  @LoopStart :
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    ja  @LoopEnd
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    ja  @LoopEnd
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    ja  @LoopEnd
    mov ecx,esi
    shl ecx,$02
    mov dl,[eax+ecx]
    mov bl,[eax+ecx+$02]
    mov [eax+ecx+$02],dl
    mov [eax+ecx],bl
    inc esi
    cmp esi,edi
    jbe @LoopStart
   @LoopEnd :
    pop edi
    pop esi
    pop ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_20(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    push ebx
    push esi
    push edi
    mov  edi,edx
    xor  esi,esi
  @LoopStart :
    mov ecx,esi
    shl ecx,$02
    add ecx,eax
    mov dl,[ecx]
    mov bl,[ecx+2]
    mov [ecx+2],dl
    mov [ecx],bl
    inc esi
    cmp esi,edi
    jbe @LoopStart
    pop edi
    pop esi
    pop ebx
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_21(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    add   edx,edx
    add   edx,edx
    add   eax,edx
  @LoopStart :
    mov   ecx,[eax]
    bswap ecx
    ror   ecx,8
    mov   [eax],ecx
    sub   eax,4
    sub   edx,4
    js    @LoopEnd
    mov   ecx,[eax]
    bswap ecx
    ror   ecx,8
    mov   [eax],ecx
    sub   eax,4
    sub   edx,4
    jns   @LoopStart
  @LoopEnd :
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_22(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     asm
        mov   eax,pScanLine
        mov   edx,ColNoMax
        add   edx,edx
        add   edx,edx
        add   eax,edx
      @LoopStart :
        mov   ecx,[eax]
        bswap ecx
        ror   ecx,8
        mov   [eax],ecx
        sub   eax,4
        sub   edx,4
        jns   @LoopStart
     end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

procedure RGBToBGR_DKC_IA32_23(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     asm
        mov   eax,pScanLine
        mov   edx,ColNoMax
        add   edx,edx
        add   edx,edx
        add   eax,edx
      @LoopStart :
        mov   ecx,[eax]
        bswap ecx
        ror   ecx,8
        mov   [eax],ecx
        sub   eax,4
        sub   edx,4
        js    @LoopEnd
        mov   ecx,[eax]
        bswap ecx
        ror   ecx,8
        mov   [eax],ecx
        sub   eax,4
        sub   edx,4
        jns   @LoopStart
      @LoopEnd :
     end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure RGBToBGR_DKC_SSE2_2(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    cmp    edx, 1
    jae    @MMX
    shl    edx,2
  @LoopStart1 :
    mov    ecx,[eax+edx]
    mov    [eax+edx+2],cl
    shr    ecx, 16
    mov    [eax+edx],cl
    sub    edx, 4
    jns    @LoopStart1
    jmp    @Exit
  @MMX :
    add    edx,edx
    add    edx,edx
    add    edx,4
  @LoopStart2 :
    pxor      mm1,mm1
    pxor      mm2,mm2
    sub       edx,8
    movq      mm0,[eax+edx]
    punpcklbw mm1,mm0
    punpckhbw mm2,mm0
    pshufw    mm3,mm1,$C6
    pshufw    mm4,mm2,$C6
    psrlq     mm3,8
    psrlq     mm4,8
    packuswb  mm3,mm4
    movq      [eax+edx],mm3
    cmp       edx,4
    ja        @LoopStart2
    emms
    sub    edx,4
    cmp    edx,0
    jbe    @LoopStart1
  @Exit :
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/3 2006
//Instructionset(s): IA32, MMX

procedure RGBToBGR_DKC_MMX_3(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 const
  {$IFDEF VER180}
  MASK1 : UInt64 = $FF00FF00FF00FF00;
  MASK2 : UInt64 = $00FF000000FF0000;
  MASK3 : UInt64 = $000000FF000000FF;
  {$ELSE}
  {$IFDEF VER170}
  MASK1 : UInt64 = $FF00FF00FF00FF00;
  MASK2 : UInt64 = $00FF000000FF0000;
  MASK3 : UInt64 = $000000FF000000FF;
  {$ELSE}
  MASK1 : Int64 = $FF00FF00FF00FF00;
  MASK2 : Int64 = $00FF000000FF0000;
  MASK3 : Int64 = $000000FF000000FF;
  {$ENDIF}
  {$ENDIF}

 asm
    cmp    edx, 1
    jae    @MMX
    shl    edx,2
  @LoopStart1 :
    mov    ecx,[eax+edx]
    mov    [eax+edx+2],cl
    shr    ecx, 16
    mov    [eax+edx],cl
    sub    edx, 4
    jns    @LoopStart1
    jmp    @Exit
  @MMX :
    add    edx,edx
    add    edx,edx
    add    edx,4
    movq   mm3, MASK1
    movq   mm4, MASK2
    movq   mm5, MASK3
  @LoopStart2 :
    sub    edx,8
    movq   mm0,[eax+edx]
    movq   mm1,mm0
    movq   mm2,mm0
    pand   mm0,mm3
    pand   mm1,mm4
    pand   mm2,mm5
    psrlq  mm1,16
    psllq  mm2,16
    por    mm0,mm1
    por    mm0,mm2
    movq   [eax+edx],mm0
    cmp    edx,4
    ja     @LoopStart2
    emms
    sub    edx,4
    cmp    edx,0
    jbe    @LoopStart1
  @Exit :
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32, MMX, SSE

procedure RGBToBGR_DKC_SSE_2(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 asm
    cmp    edx, 1
    jae    @MMX
    shl    edx,2
  @LoopStart1 :
    mov    ecx,[eax+edx]
    mov    [eax+edx+2],cl
    shr    ecx, 16
    mov    [eax+edx],cl
    sub    edx, 4
    jns    @LoopStart1
    jmp    @Exit
  @MMX :
    add    edx,edx
    add    edx,edx
    add    edx,4
  @LoopStart2 :
    pxor      mm1,mm1
    pxor      mm2,mm2
    sub       edx,8
    movq      mm0,[eax+edx]
    punpcklbw mm1,mm0
    punpckhbw mm2,mm0
    pshufw    mm3,mm1,$C6
    pshufw    mm4,mm2,$C6
    psrlq     mm3,8
    psrlq     mm4,8
    packuswb  mm3,mm4
    movq      [eax+edx],mm3
    cmp       edx,4
    ja        @LoopStart2
    emms
    sub    edx,4
    cmp    edx,0
    jbe    @LoopStart1
  @Exit :
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/3 2006
//Instructionset(s): IA32, MMX, SSE

procedure RGBToBGR_DKC_SSE_4(SrcDestBitmap : TBitmap);
var
 RowNoMax, RowNo, ColNoMax : Cardinal;
 pScanLine : PByteArray;

 procedure InnerLoop(pScanLinex : PByteArray; ColNoMax : Cardinal);
 const
  {$IFDEF VER180}
  MASK1 : UInt64 = $FF00FF00FF00FF00;
  MASK2 : UInt64 = $00FF00FF00FF00FF;
  {$ELSE}
  {$IFDEF VER170}
  MASK1 : UInt64 = $FF00FF00FF00FF00;
  MASK2 : UInt64 = $00FF00FF00FF00FF;
  {$ELSE}
  MASK1 : Int64 = $FF00FF00FF00FF00;
  MASK2 : Int64 = $00FF00FF00FF00FF;
  {$ENDIF}
  {$ENDIF}


 asm
    cmp    edx, 1
    jae    @MMX
    add    edx,edx
    add    edx,edx
  @LoopStart1 :
    mov    ecx,[eax+edx]
    mov    [eax+edx+2],cl
    shr    ecx,16
    mov    [eax+edx],cl
    sub    edx,4
    jns    @LoopStart1
    jmp    @Exit
  @MMX :
    add    edx,edx
    add    edx,edx
    add    edx,4
  @LoopStart2 :
    sub    edx,8
    movq   mm0,[eax+edx]
    movq   mm1,mm0
    pand   mm0,MASK1
    pand   mm1,MASK2
    pshufw mm2,mm1,$B1
    por    mm2,mm0
    movq   [eax+edx],mm2
    cmp    edx,4
    ja     @LoopStart2
    emms
    sub    edx,4
    test   edx,edx
    jbe    @LoopStart1
  @Exit :
 end;

begin
 if SrcDestBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if (SrcDestBitmap.Width > 0) and
    (SrcDestBitmap.Height > 0) then
  begin
   RowNoMax := SrcDestBitmap.Height-1;
   ColNoMax := SrcDestBitmap.Width-1;
   for RowNo := 0 to RowNoMax do
    begin
     pScanLine := SrcDestBitmap.ScanLine[RowNo];
     InnerLoop(pScanLine, ColNoMax);
    end;
  end;
end;

end.
