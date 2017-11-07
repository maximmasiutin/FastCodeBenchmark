unit FastcodeRGBToBGRDC01;

(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Fastcode
 *
 * The Initial Developer of the Original Code is Fastcode
 *
 * Portions created by the Initial Developer are Copyright (C) 2002-2004
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)

//Version : 0.2
//Only plain function calls supported
//Last update 16/9 2005

//Change log

//13/9 2005: Initial version 0.1 made by Dennis Christensen
//16/9 2005: 0.2 Dothan function added by Dennis Christensen

interface

uses
 Graphics;

procedure RGBToBGRFastcodeP4P(SrcDestBitmap : TBitmap);
procedure RGBToBGRFastcodeP4N(SrcDestBitmap : TBitmap);
procedure RGBToBGRFastcodePMD(SrcDestBitmap : TBitmap);
procedure RGBToBGRFastcodePMB(SrcDestBitmap : TBitmap);
procedure RGBToBGRFastcodeAMD64(SrcDestBitmap : TBitmap);
procedure RGBToBGRFastcodeXP(SrcDestBitmap : TBitmap);
procedure RGBToBGRFastcodeBlended(SrcDestBitmap : TBitmap);
procedure RGBToBGRFastcodeRTL(SrcDestBitmap : TBitmap);
procedure RGBToBGRFastcodePascal(SrcDestBitmap : TBitmap);

implementation

uses
 SysUtils;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32
//Original name:     RGBToBGR_DKC_IA32_7

procedure RGBToBGRFastcodeP4P(SrcDestBitmap : TBitmap);
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

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32
//Original name:     RGBToBGR_JOH_PAS

procedure RGBToBGRFastcodeP4N(SrcDestBitmap : TBitmap);
var
  H, W  : Integer;
  P, P2 : PByteArray;
  B     : Byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  H := SrcDestBitmap.Height;
  W := SrcDestBitmap.Width;
  if (H > 0) and (W > 0) then
    begin
      P := SrcDestBitmap.ScanLine[0];
      if H > 1 then
        begin {Allow for Top-Down or Botton-Up DIB Orientation}
          P2 := P;
          P  := SrcDestBitmap.ScanLine[H-1];
          if Integer(P2) < Integer(P) then
            P := P2;
        end;
      P2 := @P[W * H * 4];
      repeat
        B    := P[0];
        P[0] := P[2];
        P[2] := B;
        Inc(Integer(P), 4);
      until P = P2;
    end;
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32
//Original name:     RGBToBGR_JOH_PAS

procedure RGBToBGRFastcodePMD(SrcDestBitmap : TBitmap);
var
  H, W  : Integer;
  P, P2 : PByteArray;
  B     : Byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  H := SrcDestBitmap.Height;
  W := SrcDestBitmap.Width;
  if (H > 0) and (W > 0) then
    begin
      P := SrcDestBitmap.ScanLine[0];
      if H > 1 then
        begin {Allow for Top-Down or Botton-Up DIB Orientation}
          P2 := P;
          P  := SrcDestBitmap.ScanLine[H-1];
          if Integer(P2) < Integer(P) then
            P := P2;
        end;
      P2 := @P[W * H * 4];
      repeat
        B    := P[0];
        P[0] := P[2];
        P[2] := B;
        Inc(Integer(P), 4);
      until P = P2;
    end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32, MMX, SSE
//Original name:     RGBToBGR_DKC_SSE_2

procedure RGBToBGRFastcodePMB(SrcDestBitmap : TBitmap);
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

//Author:            John O'Harrow
//Date:
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32
//Original name:     RGBToBGR_JOH_PAS

procedure RGBToBGRFastcodeAMD64(SrcDestBitmap : TBitmap);
var
  H, W  : Integer;
  P, P2 : PByteArray;
  B     : Byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  H := SrcDestBitmap.Height;
  W := SrcDestBitmap.Width;
  if (H > 0) and (W > 0) then
    begin
      P := SrcDestBitmap.ScanLine[0];
      if H > 1 then
        begin {Allow for Top-Down or Botton-Up DIB Orientation}
          P2 := P;
          P  := SrcDestBitmap.ScanLine[H-1];
          if Integer(P2) < Integer(P) then
            P := P2;
        end;
      P2 := @P[W * H * 4];
      repeat
        B    := P[0];
        P[0] := P[2];
        P[2] := B;
        Inc(Integer(P), 4);
      until P = P2;
    end;
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32
//Original name:     RGBToBGR_JOH_PAS

procedure RGBToBGRFastcodeXP(SrcDestBitmap : TBitmap);
var
  H, W  : Integer;
  P, P2 : PByteArray;
  B     : Byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  H := SrcDestBitmap.Height;
  W := SrcDestBitmap.Width;
  if (H > 0) and (W > 0) then
    begin
      P := SrcDestBitmap.ScanLine[0];
      if H > 1 then
        begin {Allow for Top-Down or Botton-Up DIB Orientation}
          P2 := P;
          P  := SrcDestBitmap.ScanLine[H-1];
          if Integer(P2) < Integer(P) then
            P := P2;
        end;
      P2 := @P[W * H * 4];
      repeat
        B    := P[0];
        P[0] := P[2];
        P[2] := B;
        Inc(Integer(P), 4);
      until P = P2;
    end;
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:     RGBToBGR_JOH_PAS

procedure RGBToBGRFastcodeBlended(SrcDestBitmap : TBitmap);
var
  H, W  : Integer;
  P, P2 : PByteArray;
  B     : Byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  H := SrcDestBitmap.Height;
  W := SrcDestBitmap.Width;
  if (H > 0) and (W > 0) then
    begin
      P := SrcDestBitmap.ScanLine[0];
      if H > 1 then
        begin {Allow for Top-Down or Botton-Up DIB Orientation}
          P2 := P;
          P  := SrcDestBitmap.ScanLine[H-1];
          if Integer(P2) < Integer(P) then
            P := P2;
        end;
      P2 := @P[W * H * 4];
      repeat
        B    := P[0];
        P[0] := P[2];
        P[2] := B;
        Inc(Integer(P), 4);
      until P = P2;
    end;
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:     RGBToBGR_JOH_PAS

procedure RGBToBGRFastcodeRTL(SrcDestBitmap : TBitmap);
var
  H, W  : Integer;
  P, P2 : PByteArray;
  B     : Byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  H := SrcDestBitmap.Height;
  W := SrcDestBitmap.Width;
  if (H > 0) and (W > 0) then
    begin
      P := SrcDestBitmap.ScanLine[0];
      if H > 1 then
        begin {Allow for Top-Down or Botton-Up DIB Orientation}
          P2 := P;
          P  := SrcDestBitmap.ScanLine[H-1];
          if Integer(P2) < Integer(P) then
            P := P2;
        end;
      P2 := @P[W * H * 4];
      repeat
        B    := P[0];
        P[0] := P[2];
        P[2] := B;
        Inc(Integer(P), 4);
      until P = P2;
    end;
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:     RGBToBGR_JOH_PAS

procedure RGBToBGRFastcodePascal(SrcDestBitmap : TBitmap);
var
  H, W  : Integer;
  P, P2 : PByteArray;
  B     : Byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  H := SrcDestBitmap.Height;
  W := SrcDestBitmap.Width;
  if (H > 0) and (W > 0) then
    begin
      P := SrcDestBitmap.ScanLine[0];
      if H > 1 then
        begin {Allow for Top-Down or Botton-Up DIB Orientation}
          P2 := P;
          P  := SrcDestBitmap.ScanLine[H-1];
          if Integer(P2) < Integer(P) then
            P := P2;
        end;
      P2 := @P[W * H * 4];
      repeat
        B    := P[0];
        P[0] := P[2];
        P[2] := B;
        Inc(Integer(P), 4);
      until P = P2;
    end;
end;

end.
