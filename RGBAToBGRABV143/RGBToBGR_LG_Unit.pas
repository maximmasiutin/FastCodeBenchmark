unit RGBToBGR_LG_Unit;

interface

implementation

//Author:            Lars Gravengaard
//Date:              1/12 2004
//Instructionset(s): Pascal

procedure RGBToBGRLBGPas1(SrcDestBitmap : TBitmap);
var
  r, c, ARowMax, AColMax,ScanIncr: Integer;
  pScanLine: PInteger;

procedure  loop_pas (const ARowMax:Integer;const AColMax:Integer;const 
ScanIncr:Integer);
var Row,Col :Cardinal;
begin
  for Row := 0 to ARowMax do
  begin
    for Col := 0 to AColMax do
    begin
      pScanLine^ := (pScanLine^ and $0000ff00)+  ((pScanLine^ and $00ff0000) 
shr 16)+ ((pScanLine^ and

$000000ff) shl 16);
      inc(pScanLine, 1);
    end;
    dec(pScanLine, ScanIncr);
  end;
end;

begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
   AColMax := SrcDestBitmap.Width - 1;
   if  ((AColMax < 1)or(SrcDestBitmap.Height < 2 )) then
   begin
     for r := 0 to SrcDestBitmap.Height - 1 do
     begin
       pScanLine := SrcDestBitmap.ScanLine[r];
       for c := 0 to AColMax do
       begin
         pScanLine^ := (pScanLine^ and $0000ff00)+  ((pScanLine^ and 
$00ff0000) shr 16)+ ((pScanLine^ and

$000000ff) shl 16);
         inc(pScanLine, 1);
       end;
     end;
   end
   else // quick mode
   begin
     ARowMax := SrcDestBitmap.Height - 1;
     pScanLine := SrcDestBitmap.ScanLine[0];
     ScanIncr := (Cardinal(pScanLine) - Cardinal(SrcDestBitmap.ScanLine[1])) 
div 2; //
     loop_pas (ARowMax,AColMax,ScanIncr);
   end;
end;

//Author:            Lars Gravengaard
//Date:              1/12 2004
//Instructionset(s): IA32 (486 and up)

procedure RGBToBGRLBGIA32_1(SrcDestBitmap : TBitmap);
var
  r, c, ARowMax, AColMax,ScanIncr: Integer;
  pScanLine: PInteger;

procedure BSwap(S : PInteger);
asm
   MOV  EDX,[eax]
   bswap EDX
   shr   EDX, 8
   MOV  [eax],EDX
end;

procedure  loop (const ARowMax:Integer;const AColMax:Integer;const 
ScanIncr:Integer);
var Row,Col :Cardinal;
begin
  for Row := 0 to ARowMax do
  begin
    for Col := 0 to AColMax do
    begin
    BSwap(pScanLine);
//      pScanLine^ := (pScanLine^ and $0000ff00)+  ((pScanLine^ and 
$00ff0000) shr 16)+ ((pScanLine^ and

$000000ff) shl 16);
      inc(pScanLine, 1);
    end;
    dec(pScanLine, ScanIncr);
  end;
end;

begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
   AColMax := SrcDestBitmap.Width - 1;
   if  ((AColMax < 1)or(SrcDestBitmap.Height < 2 )) then
   begin
     for r := 0 to SrcDestBitmap.Height - 1 do
     begin
       pScanLine := SrcDestBitmap.ScanLine[r];
       for c := 0 to AColMax do
       begin
         BSwap(pScanLine);
         inc(pScanLine, 1);
       end;
     end;
   end
   else // quick mode
   begin
     ARowMax := SrcDestBitmap.Height - 1;
     pScanLine := SrcDestBitmap.ScanLine[0];
     ScanIncr := (Cardinal(pScanLine) - Cardinal(SrcDestBitmap.ScanLine[1])) 
div 2;
     loop (ARowMax,AColMax,ScanIncr);
   end;
end;

//Author:            Lars Gravengaard
//Date:              1/12 2004
//Instructionset(s): IA32 (486 and up)

procedure RGBToBGRLBGIA32_2(SrcDestBitmap : TBitmap);
var
  r, c, ARowMax, AColMax,ScanIncr: integer;    //ARowMax,
  pScanLine: PInteger;

procedure BSwap(S : PInteger);
asm
   MOV  EDX,[eax]
   bswap EDX
   shr   EDX, 8
   MOV  [eax],EDX
end;

procedure loop 
(S:PInteger;ARowMax:Integer;AColMax:Integer;ScanIncr:Integer);
asm
//push ebp
//mov ebp,esp
//       push ecx
        push ebx
        push edi
        mov edi,edx
        inc edi
        shl ecx,2
        add ecx,$04
@a4:    mov ebx,ecx  //   ecx = AColMax
@a3:    MOV  EDX,[eax]
        bswap EDX
        shr   EDX, 8
        MOV  [eax],EDX
        add eax,$04
        sub ebx,$04
        jnz @a3
@a2:    mov edx,[ebp+$08]
        sub eax,edx
        dec edi
        jnz @a4
@end:   pop edi
        pop ebx
      //  pop ecx
end;

begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
   AColMax := SrcDestBitmap.Width - 1;
   if  ((AColMax < 1)or(SrcDestBitmap.Height < 2 )) then
   begin
     for r := 0 to SrcDestBitmap.Height - 1 do
     begin
       pScanLine := SrcDestBitmap.ScanLine[r];
       for c := 0 to AColMax do
       begin
         BSwap(pScanLine);
         inc(pScanLine, 1);
       end;
     end;
   end
   else // quick mode
   begin
     ARowMax := SrcDestBitmap.Height - 1;
     pScanLine := SrcDestBitmap.ScanLine[0];
     ScanIncr := (Cardinal(pScanLine) - Cardinal(SrcDestBitmap.ScanLine[1])) 
* 2;
     loop (pScanLine,ARowMax,AColMax,ScanIncr);
   end;
end;

end.
 