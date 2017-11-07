unit StrCopyUnit;

interface

function StrCopyDKCPas1(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas2(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas3(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas4(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas5(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas6(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas7(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas8(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas9(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas10(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas11(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas12(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas13(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas47(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas48(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas49(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCPas50(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCAsm_IA32_1(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCASM1(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCASM2(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCASM3(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCASM4(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCAsm5(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCAsm6(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCAsm7(Dest: PChar; const Source: PChar): PChar;
function StrCopyDKCAsm8(Dest: PChar; const Source: PChar): PChar;

implementation

uses
 SysUtils;

function StrLenDKCPas1(const Str: PChar) : Cardinal;
begin
 Result := 0;
 repeat
  Inc(Result);
 until(Str[Result-1] = #0);
 Result := Result-1;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Optimized for:
//Instructionset(s): IA32

function StrCopyDKCPas1(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := 0;
 repeat
  Dest[I] := Source[I];
  Inc(I);
 until(Source[I-1] = #0);
 Result := Dest;
end;


//Author:            Dennis Kjaer Christensen
//Date:              27/2 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2
//Under development

procedure MoveDKC60Special(const Source; var Dest; Count : Integer);
asm
     //Exit if Count is negative
     {test    ecx, ecx
     js      @Exit
     //Detect the need for rewerse move in overlapped case
     cmp     eax, edx                   // if (DestAddress > SourceAddress) then
     jnb     @ForwardMove
     push    ebx
     mov     ebx, edx
     sub     ebx, eax                   // (DestAddress - SourceAddress)
     cmp     ebx, edx                   // if ((DestAddress - SourceAddress) < Count) then
     pop     ebx
     jb      @RewMove}
@L2:
@L1:
@ForwardMove:
     cmp     ecx, 55
     jnbe    @ForwardCaseElse
     jmp     dword ptr [ecx*4+@Case1JmpTable]
@ForwardCaseCount0:
     jmp     @Exit
@ForwardCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
     jmp     @Exit
@ForwardCaseCount2:
     mov     cx, [eax]
     mov     [edx], cx
     jmp     @Exit
@ForwardCaseCount3:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax+2]
     mov     [edx+2], cl
     jmp     @Exit
@ForwardCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@ForwardCaseCount5:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     jmp     @Exit
@ForwardCaseCount6:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     jmp     @Exit
@ForwardCaseCount7:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+6]
     mov     [edx+6], cl
     jmp     @Exit
@ForwardCaseCount8:
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
@ForwardCaseCount9:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     jmp     @Exit
@ForwardCaseCount10 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     jmp     @Exit
@ForwardCaseCount11 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+10]
     mov     [edx+10], cl
     jmp     @Exit
@ForwardCaseCount12:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     jmp     @Exit
@ForwardCaseCount13 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     jmp     @Exit
@ForwardCaseCount14 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     jmp     @Exit
@ForwardCaseCount15 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+14]
     mov     [edx+14], cl
     jmp     @Exit
@ForwardCaseCount16 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     jmp     @Exit
@ForwardCaseCount17 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     jmp     @Exit
@ForwardCaseCount18 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     jmp     @Exit
@ForwardCaseCount19 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+18]
     mov     [edx+18], cl
     jmp     @Exit
@ForwardCaseCount20 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     jmp     @Exit
@ForwardCaseCount21 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     jmp     @Exit
@ForwardCaseCount22 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     jmp     @Exit
@ForwardCaseCount23 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+22]
     mov     [edx+22], cl
     jmp     @Exit
@ForwardCaseCount24 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     jmp     @Exit
@ForwardCaseCount25 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     jmp     @Exit
@ForwardCaseCount26 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     jmp     @Exit
@ForwardCaseCount27 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+26]
     mov     [edx+26], cl
     jmp     @Exit
@ForwardCaseCount28 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     jmp     @Exit
@ForwardCaseCount29 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     jmp     @Exit
@ForwardCaseCount30 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     jmp     @Exit
@ForwardCaseCount31 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+30]
     mov     [edx+30], cl
     jmp     @Exit
@ForwardCaseCount32 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     jmp     @Exit
@ForwardCaseCount33 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     jmp     @Exit
@ForwardCaseCount34 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     jmp     @Exit
@ForwardCaseCount35 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+34]
     mov     [edx+34], cl
     jmp     @Exit
@ForwardCaseCount36 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     jmp     @Exit
@ForwardCaseCount37 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     jmp     @Exit
@ForwardCaseCount38 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     jmp     @Exit
@ForwardCaseCount39 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+38]
     mov     [edx+38], cl
     jmp     @Exit
@ForwardCaseCount40 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     jmp     @Exit
@ForwardCaseCount41 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     jmp     @Exit
@ForwardCaseCount42 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     jmp     @Exit
@ForwardCaseCount43 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+42]
     mov     [edx+42], cl
     jmp     @Exit
@ForwardCaseCount44 :
     movdqu  xmm0, [eax]
     movdqu  [edx], xmm0
     movdqu  xmm2, [eax+16]
     movdqu  [edx+16], xmm2
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     jmp     @Exit
@ForwardCaseCount45 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     jmp     @Exit
@ForwardCaseCount46 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     jmp     @Exit
@ForwardCaseCount47 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+46]
     mov     [edx+46], cl
     jmp     @Exit
@ForwardCaseCount48 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     jmp     @Exit
@ForwardCaseCount49 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     jmp     @Exit
@ForwardCaseCount50 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     jmp     @Exit
@ForwardCaseCount51 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     jmp     @Exit
@ForwardCaseCount52 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     mov     cl, [eax+51]
     mov     [edx+51], cl
     jmp     @Exit
@ForwardCaseCount53 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     jmp     @Exit
@ForwardCaseCount54 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+$04]
     mov     [edx+$04], ecx
     mov     ecx, [eax+$08]
     mov     [edx+$08], ecx
     mov     ecx, [eax+$0c]
     mov     [edx+$0c], ecx
     mov     ecx, [eax+$10]
     mov     [edx+$10], ecx
     mov     ecx, [eax+$14]
     mov     [edx+$14], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     jmp     @Exit
@ForwardCaseCount55 :
     movdqu  xmm0, [eax]
     movdqu  [edx], xmm0
     movdqu  xmm1, [eax+16]
     movdqu  [edx+16], xmm1
     movdqu  xmm3, [eax+32]
     movdqu  [edx+32], xmm3
     mov     ecx,[eax+48]
     mov     [edx+48],ecx
     mov     cl,[eax+52]
     mov     [edx+52],cl
     mov     cl,[eax+53]
     mov     [edx+53],cl
     mov     cl,[eax+54]
     mov     [edx+54],cl
     jmp     @Exit
 @ForwardCaseElse:
     cmp     ecx, 140
     jnle    @Else9
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     mov     edi, ecx
     shr     edi, 3
     add     edi, edi
     test    edi, edi
     jbe     @L22                    // if NoOfIntMoves < 0
     xor     ebx, ebx
 @L11:
     mov     esi, [eax+ebx*4]
     mov     [edx+ebx*4], esi
     mov     esi, [eax+ebx*4+4]
     mov     [edx+ebx*4+4], esi
     add     ebx, 2
     cmp     ebx, edi
     jb      @L11
 @L22:                               // NoOfByteMoves := Count - NoOfIntMoves*4;
     add     edi, edi                // edi = NoOfIntMoves*4
     add     edi, edi
     sub     ecx, edi                // ecx = NoOfByteMoves
     test    ecx, ecx
     jbe     @L4
     mov     esi, edi                // ByteNo := NoOfIntMoves*4;
     add     edi, ecx                // EndOfByteMoves := ByteNo + NoOfByteMoves;
 @L3:
     mov     cl, [eax+esi]           // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx+esi], cl
     add     esi, 1
     cmp     edi, esi
     jnbe    @L3                     // until(ByteNo >= NoOfByteMoves);
 @L4:
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
 @Else9:
     push    ebp                     // Pop is done at exit1
     mov     ebp,esp
     add     esp,-$14
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     mov     [ebp-$10], ecx
     //Align destination
     mov     ebx, edx
     and     ebx, $0f
     test    ebx, ebx                // if SrcB mod 16 = 0
     jz      @L222                   // if aligned then skip alignment
     xor     edi, edi                // ByteNo1 := 0;
 @L111:
     mov     bl, [eax+edi]           // DstB[ByteNo1] := SrcB[ByteNo1];
     mov     [edx+edi], bl
     add     edi, 1                  // Inc(ByteNo1);
     mov     ebx, edx                // edx is destination pointer
     add     ebx, edi
     and     ebx, $0f
     test    ebx, ebx
     jnz     @L111                   // until((SrcAddress2 mod 16) = 0);
     add     eax, edi                // SrcB is aligned now - "SrcI := SrcI + ByteNo1;" Not valid Pascal
     add     edx, edi                // DstB is aligned now - "DstI := DstI + ByteNo1;" Not valid Pascal
     sub     ecx, edi                // Count := Count - ByteNo1;
     mov     [ebp-$10], ecx
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then //Both source and destination are 16 byte aligned
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     cmp     ecx, 89000              // if Count < 71000 then
     jnl     @Else2
     mov     edi, eax                // Back up eax
     mov     esi, edx
     mov     eax, ecx
     mov     ebx, 48
     xor     edx, edx
     div     ebx
     mov     ecx, eax                // NoOfIntLoops  := Count div 48;
     mov     eax, edi                // Restore eax
     mov     edx, esi
     add     ecx, ecx
     add     ecx, ecx
     mov     edi, ecx
     add     ecx, ecx
     add     ecx, edi
     test    ecx, ecx
     jbe     @L2222                  // if(NoOfIntMoves > 0) then
     xor     ebx, ebx
 @L1111:
     movaps  xmm0, [eax+ebx*4]
     movaps  [edx+ebx*4], xmm0
     movaps  xmm1, [eax+ebx*4+16]
     movaps  [edx+ebx*4+16], xmm1
     movaps  xmm2, [eax+ebx*4+32]
     movaps  [edx+ebx*4+32], xmm2
     add     ebx, 12
     cmp     ebx, ecx
     jb      @L1111
 @L2222:
     jmp     @Fedtmule
 @Else2:
     shr     ecx, 7                  // NoOfIntLoops  := Count div 16;    16, 32, 48, 64, 80, 96, 112, 128
     shl     ecx, 5                  // NoOfIntMoves := NoOfIntLoops * 4;  4,  8, 12, 16, 20, 24,  28,  32
     test    ecx, ecx
     jbe     @L20                    // if(NoOfIntMoves > 0) then
     xor     ebx, ebx
 @L10:
     movdqu  xmm0, [eax+ebx*4]
     movntdq [edx+ebx*4], xmm0
     movdqu  xmm1, [eax+ebx*4+16]
     movntdq [edx+ebx*4+16], xmm1
     movdqu  xmm2, [eax+ebx*4+32]
     movntdq [edx+ebx*4+32], xmm2
     movdqu  xmm3, [eax+ebx*4+48]
     movntdq [edx+ebx*4+48], xmm3
     movdqu  xmm4, [eax+ebx*4+64]
     movntdq [edx+ebx*4+64], xmm4
     movdqu  xmm5, [eax+ebx*4+80]
     movntdq [edx+ebx*4+80], xmm5
     movdqu  xmm6, [eax+ebx*4+96]
     movntdq [edx+ebx*4+96], xmm6
     movdqu  xmm7, [eax+ebx*4+112]
     movntdq [edx+ebx*4+112], xmm7
     add     ebx, 32                 //  4, 8, 12, 16, 20, 24, 28, 32
     cmp     ebx, ecx
     jb      @L10
     sfence
 @L20:
     jmp     @Fedtmule
     //else if (SourceAddress2 mod 8 = 0) then //Both source and destination are at least 8 byte aligned
 @ElseIf1:
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     shr     ecx, 4                  // NoOfIntLoops  := Count div 16;
     shl     ecx, 2                  // NoOfIntMoves := NoOfIntLoops * 4;
     test    ecx, ecx
     jbe     @L200                   // if(NoOfIntMoves > 0) then
     xor     ebx, ebx
 @L100:
     movq    mm0, [eax+ebx*4]
     movq    [edx+ebx*4], mm0
     movq    mm1, [eax+ebx*4+8]
     movq    [edx+ebx*4+8], mm1
     add     ebx, 4
     cmp     ebx, ecx
     jb      @L100
     emms
 @L200:
     jmp     @Fedtmule
 @Else1:
     mov     edi, eax                // Save eax because div uses it
     mov     esi, edx                // Save edx because div uses it
     mov     eax, ecx
     mov     ebx, 32
     xor     edx, edx
     div     ebx                     // NoOfIntLoops  := Count div 24;
     mov     ecx, eax                // NoOfIntMoves := NoOfIntLoops * 6; //Latency 15-18 cycles
     add     ecx, ecx                // 0.5 cycles Latency
     add     ecx, ecx
     add     ecx, ecx                // 0.5 cycles Latency 2 cycles versus imul 15-18
     test    ecx, ecx
     mov     eax, edi                // Restore eax
     mov     edx, esi                // Restore edx
     jbe     @L2000                  // if(NoOfIntMoves > 0) then
     xor     ebx, ebx
 @L1000:
     movdqu  xmm0, [edi+ebx*4]
     movdqa  [esi+ebx*4], xmm0
     movdqu  xmm1, [edi+ebx*4+16]
     movdqa  [esi+ebx*4+16], xmm1
     add     ebx, 8
     cmp     ebx, ecx
     jb      @L1000
 @L2000:
 @Fedtmule:
     // Small moves after big 16 byte aligned moves
     mov     esi, ecx
     shl     esi, 2                  // ByteNo := NoOfIntMoves*4;
     mov     edi, [ebp-$10]
     sub     edi, esi                // edi = NoOfByteMoves
     test    edi, edi
     jbe     @L234                   // if(NoOfByteMoves > 0) then
     add     edi, esi                // edx = Count
@L123:
     mov     bl, [eax+esi]           // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx+esi], bl
     add     esi, 1
     cmp     edi, esi
     jnbe    @L123                   // until(ByteNo >= EndOfByteMoves);
 @L234:
     pop     esi
     pop     edi
     pop     ebx
     mov     esp,ebp
     pop     ebp
     jmp     @Exit1
 @ForwardCaseEnd:
   //Rewerse move
 @RewMove:
     cmp     ecx,$37
     jnbe    @Case1Else
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @RewerseCaseCount0:
     jmp     @Exit
 @RewerseCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
     jmp     @Exit
 @RewerseCaseCount2:
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax]
     mov     [edx], cl
     jmp     @Exit
 @RewerseCaseCount3:
     mov     cl, [eax+2]
     mov     [edx+2], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax]
     mov     [edx], cl
     jmp     @Exit
 @RewerseCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
 @RewerseCaseCount5:
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
 @RewerseCaseCount6:
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
 @RewerseCaseCount7:
     mov     cl, [eax+6]
     mov     [edx+6], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
 @RewerseCaseCount8:
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
 @RewerseCaseCount9:
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
 @RewerseCaseCount10:
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+8]
     mov     [edx+8], cl
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
 @RewerseCaseCount11:
     mov     cl, [eax+10]
     mov     [edx+10], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+8]
     mov     [edx+8], cl
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
 @RewerseCaseCount12 :
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
 @RewerseCaseCount13 :
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount14 :
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount15 :
     mov     cl, [eax+14]
     mov     [edx+14], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount16 :
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
@RewerseCaseCount17 :
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
@RewerseCaseCount18 :
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount19 :
     mov     cl, [eax+18]
     mov     [edx+18], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount20 :
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount21 :
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount22 :
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount23 :
     mov     cl, [eax+22]
     mov     [edx+22], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount24 :
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount25 :
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount26 :
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount27 :
     mov     cl, [eax+26]
     mov     [edx+26], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount28 :
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount29 :
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount30 :
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount31 :
     mov     cl, [eax+30]
     mov     [edx+30], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount32 :
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
@RewerseCaseCount33 :
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount34 :
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount35 :
     mov     cl, [eax+34]
     mov     [edx+34], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount36 :
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount37 :
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount38 :
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount39 :
     mov     cl, [eax+38]
     mov     [edx+38], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount40 :
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount41 :
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount42 :
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount43 :
     mov     cl, [eax+42]
     mov     [edx+42], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount44 :
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount45 :
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount46 :
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount47 :
     mov     cl, [eax+46]
     mov     [edx+46], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount48 :
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount49 :
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount50 :
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount51 :
     mov     cl, [eax+50]
     mov     [edx+50], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount52 :
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount53 :
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount54 :
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@RewerseCaseCount55 :
     mov     cl, [eax+54]
     mov     [edx+54], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+20]
     mov     [edx+20], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
 @Case1Else:
     //Align destination
     push    ebp
     mov     ebp,esp
     add     esp,-$14
     push    edi
     push    esi
     mov     esi, eax
     mov     edi, edx
     mov     eax, edi
     mov     edx, ecx
     add     eax, edx
     and     eax, $0f
     test    eax, eax                // if SrcB mod 16 = 0
     jz      @L35
 @L15:
     mov     cl, [esi+edx-1]
     mov     [edi+edx-1], cl
     sub     edx, 1
     mov     eax, edi                // ecx is destination pointer
     add     eax, edx
     and     eax, $0f
     test    eax, eax
     jnz     @L15                    // until((SrcAddress2 mod 8) = 0);
 @L35:                               // Destination is 16 byte aligned
     movups  xmm0, [esi+edx-16]
     movaps  [edi+edx-16], xmm0
     movups  xmm1, [esi+edx-32]
     movaps  [edi+edx-32], xmm1
     sub     edx, 32
     cmp     edx, 32
     jnb     @L35
     test    edx, edx
     jz      @L25
 @L45:
     mov     cl, [esi+edx-1]
     mov     [edi+edx-1], cl
     sub     edx, 1
     cmp     edx, 0
     jnbe    @L45
 @L25:
     pop     esi
     pop     edi
     mov     esp,ebp
     pop     ebp
 @Exit1:
 @Exit:
     ret

@Case1JmpTable:
 dd @ForwardCaseCount0
 dd @ForwardCaseCount1
 dd @ForwardCaseCount2
 dd @ForwardCaseCount3
 dd @ForwardCaseCount4
 dd @ForwardCaseCount5
 dd @ForwardCaseCount6
 dd @ForwardCaseCount7
 dd @ForwardCaseCount8
 dd @ForwardCaseCount9
 dd @ForwardCaseCount10
 dd @ForwardCaseCount11
 dd @ForwardCaseCount12
 dd @ForwardCaseCount13
 dd @ForwardCaseCount14
 dd @ForwardCaseCount15
 dd @ForwardCaseCount16
 dd @ForwardCaseCount17
 dd @ForwardCaseCount18
 dd @ForwardCaseCount19
 dd @ForwardCaseCount20
 dd @ForwardCaseCount21
 dd @ForwardCaseCount22
 dd @ForwardCaseCount23
 dd @ForwardCaseCount24
 dd @ForwardCaseCount25
 dd @ForwardCaseCount26
 dd @ForwardCaseCount27
 dd @ForwardCaseCount28
 dd @ForwardCaseCount29
 dd @ForwardCaseCount30
 dd @ForwardCaseCount31
 dd @ForwardCaseCount32
 dd @ForwardCaseCount33
 dd @ForwardCaseCount34
 dd @ForwardCaseCount35
 dd @ForwardCaseCount36
 dd @ForwardCaseCount37
 dd @ForwardCaseCount38
 dd @ForwardCaseCount39
 dd @ForwardCaseCount40
 dd @ForwardCaseCount41
 dd @ForwardCaseCount42
 dd @ForwardCaseCount43
 dd @ForwardCaseCount44
 dd @ForwardCaseCount45
 dd @ForwardCaseCount46
 dd @ForwardCaseCount47
 dd @ForwardCaseCount48
 dd @ForwardCaseCount49
 dd @ForwardCaseCount50
 dd @ForwardCaseCount51
 dd @ForwardCaseCount52
 dd @ForwardCaseCount53
 dd @ForwardCaseCount54
 dd @ForwardCaseCount55

@Case2JmpTable:
 dd @RewerseCaseCount0
 dd @RewerseCaseCount1
 dd @RewerseCaseCount2
 dd @RewerseCaseCount3
 dd @RewerseCaseCount4
 dd @RewerseCaseCount5
 dd @RewerseCaseCount6
 dd @RewerseCaseCount7
 dd @RewerseCaseCount8
 dd @RewerseCaseCount9
 dd @RewerseCaseCount10
 dd @RewerseCaseCount11
 dd @RewerseCaseCount12
 dd @RewerseCaseCount13
 dd @RewerseCaseCount14
 dd @RewerseCaseCount15
 dd @RewerseCaseCount16
 dd @RewerseCaseCount17
 dd @RewerseCaseCount18
 dd @RewerseCaseCount19
 dd @RewerseCaseCount20
 dd @RewerseCaseCount21
 dd @RewerseCaseCount22
 dd @RewerseCaseCount23
 dd @RewerseCaseCount24
 dd @RewerseCaseCount25
 dd @RewerseCaseCount26
 dd @RewerseCaseCount27
 dd @RewerseCaseCount28
 dd @RewerseCaseCount29
 dd @RewerseCaseCount30
 dd @RewerseCaseCount31
 dd @RewerseCaseCount32
 dd @RewerseCaseCount33
 dd @RewerseCaseCount34
 dd @RewerseCaseCount35
 dd @RewerseCaseCount36
 dd @RewerseCaseCount37
 dd @RewerseCaseCount38
 dd @RewerseCaseCount39
 dd @RewerseCaseCount40
 dd @RewerseCaseCount41
 dd @RewerseCaseCount42
 dd @RewerseCaseCount43
 dd @RewerseCaseCount44
 dd @RewerseCaseCount45
 dd @RewerseCaseCount46
 dd @RewerseCaseCount47
 dd @RewerseCaseCount48
 dd @RewerseCaseCount49
 dd @RewerseCaseCount50
 dd @RewerseCaseCount51
 dd @RewerseCaseCount52
 dd @RewerseCaseCount53
 dd @RewerseCaseCount54
 dd @RewerseCaseCount55

end;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Optimized for:
//Instructionset(s): IA32

function StrCopyDKCPas2(Dest: PChar; const Source: PChar): PChar;
var
 LenSource : Cardinal;

begin
 LenSource := StrLenDKCPas1(Source);
 Move(Source[0], Dest[0], LenSource+1);
 Result := Dest;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Optimized for:
//Instructionset(s): IA32

function StrCopyDKCPas3(Dest: PChar; const Source: PChar): PChar;
var
 LenSource : Cardinal;

begin
 LenSource := 0;
 repeat
  Inc(LenSource);
 until(Source[LenSource-1] = #0);
 //MoveDKC60(Source[0], Dest[0], LenSource+1);  //Not really a Pas function
 Move(Source[0], Dest[0], LenSource);         //Now it is a Pas function
 Result := Dest;
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/9 2003
//Optimized for:
//Instructionset(s): IA32

function StrCopyDKCPas4(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := 0;
 repeat
  Dest[I] := Source[I];
  Inc(I);
  if (Source[I-1] = #0) then
   Break;
  Dest[I] := Source[I];
  Inc(I);
 until(Source[I-1] = #0);
 Result := Dest;
end;

function StrCopyDKCPas5(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas6(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas7(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas8(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas9(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas10(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas11(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas12(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas13(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopyDKCPas47(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function StrCopyDKCAsm_IA32_1(Dest: PChar; const Source: PChar): PChar;
asm
       push eax
 @@1:  mov  cl,[edx]
       add  edx,1
       mov  [eax],cl
       add  eax,1
       test cl, cl
       jnz  @@1
       pop  eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Optimized for:
//Instructionset(s): IA32, MMX, SSE, SSE2

function StrCopyDKCASM1(Dest: PChar; const Source: PChar): PChar;
var
 LenSource : Cardinal;

begin
 LenSource := 0;
 repeat
  Inc(LenSource);
 until(Source[LenSource-1] = #0);
 MoveDKC60Special(Source[0], Dest[0], LenSource);  //Not really a Pas function
 Result := Dest;
end;

function StrCopyDKCASM2(Dest: PChar; const Source: PChar): PChar;
var
 LenSource : Integer;

begin
 if Source[0] = #0 then
  begin
   Dest[0] := #0;
  end
 else
  begin
   LenSource := -1;
   repeat
    Inc(LenSource);
   until(Source[LenSource] = #0);
   MoveDKC60Special(Source[0], Dest[0], LenSource+1);  //Not really a Pas function
  end;
 Result := Dest;
end;

function StrCopyDKCASM3(Dest: PChar; const Source: PChar): PChar;
var
 LenSource : Integer;

begin
 if Source[0] = #0 then
  begin
   Dest[0] := #0;
  end
 else if Source[1] = #0 then
  begin
   Dest[0] := Source[0];
   Dest[1] := Source[1];
  end
 else if Source[2] = #0 then
  begin
   Dest[0] := Source[0];
   Dest[1] := Source[1];
   Dest[2] := Source[2];
  end
 else if Source[3] = #0 then
  begin
   Dest[0] := Source[0];
   Dest[1] := Source[1];
   Dest[2] := Source[2];
   Dest[3] := Source[3];
  end
 else
  begin
   LenSource := 2;
   repeat
    Inc(LenSource);
   until(Source[LenSource] = #0);
   MoveDKC60Special(Source[0], Dest[0], LenSource+1);
  end;
 Result := Dest;
end;

function StrCopyDKCASM4(Dest: PChar; const Source: PChar): PChar;
asm
   push eax
   push ebx
   //if Source[0] = #0 then
   mov  bl,[edx]
   test bl,bl
   jnz  @If1End
   //Dest[0] := #0;
   mov  [eax],bl
   jmp  @Exit
 @If1End :
   //else if Source[1] = #0 then
   mov  bh,[edx+$01]
   test bh,bh
   jnz  @ElseIf1End
   //Dest[0] := Source[0];
   //Dest[1] := Source[1];
   mov  [eax],bx
   jmp  @Exit
 @ElseIf1End :
   //else if Source[2] = #0 then
   mov  cl, [edx+$02]
   test cl,cl
   jnz  @ElseIf2End
   //Dest[0] := Source[0];
   //Dest[1] := Source[1];
   mov  [eax],bx
   //Dest[2] := Source[2];
   mov  [eax+$02],cl
   jmp  @Exit
 @ElseIf2End :
   //else if Source[3] = #0 then
   mov  ch,[edx+$03]
   test ch,ch
   jnz  @ElseIf3End
   //Dest[0] := Source[0];
   //Dest[1] := Source[1];
   mov  [eax],bx
   //Dest[2] := Source[2];
   //Dest[3] := Source[3];
   mov  [eax+$02],cx
   jmp  @Exit
 @ElseIf3End :
   //else
   //LenSource := 2;
   mov  ebx,2
 @RepeatStart :
   //Inc(LenSource);
   add  ebx,1
   //until(Source[LenSource] = #0);
   cmp  byte ptr [edx+ebx],0
   jnz  @RepeatStart
   //MoveDKC60(Source[0], Dest[0], LenSource+1);
   lea  ecx,[ebx+$01]
   xchg eax,edx
   cmp  ecx, 55
   ja   @BigString
   //SmallStringMove

     jmp     dword ptr [ecx*4+@Case1JmpTable]
 @ForwardCaseCount0:
     jmp     @Exit
 @ForwardCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
     jmp     @Exit
 @ForwardCaseCount2:
     mov     cx, [eax]
     mov     [edx], cx
     jmp     @Exit
 @ForwardCaseCount3:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax+2]
     mov     [edx+2], cl
     jmp     @Exit
@ForwardCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@ForwardCaseCount5:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     jmp     @Exit
@ForwardCaseCount6:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     jmp     @Exit
@ForwardCaseCount7:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+6]
     mov     [edx+6], cl
     jmp     @Exit
@ForwardCaseCount8:
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
@ForwardCaseCount9:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     jmp     @Exit
@ForwardCaseCount10 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     jmp     @Exit
@ForwardCaseCount11 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+10]
     mov     [edx+10], cl
     jmp     @Exit
@ForwardCaseCount12:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     jmp     @Exit
@ForwardCaseCount13 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     jmp     @Exit
@ForwardCaseCount14 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     jmp     @Exit
@ForwardCaseCount15 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+14]
     mov     [edx+14], cl
     jmp     @Exit
@ForwardCaseCount16 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     jmp     @Exit
@ForwardCaseCount17 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     jmp     @Exit
@ForwardCaseCount18 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     jmp     @Exit
@ForwardCaseCount19 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+18]
     mov     [edx+18], cl
     jmp     @Exit
@ForwardCaseCount20 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     jmp     @Exit
@ForwardCaseCount21 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     jmp     @Exit
@ForwardCaseCount22 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     jmp     @Exit
@ForwardCaseCount23 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+22]
     mov     [edx+22], cl
     jmp     @Exit
@ForwardCaseCount24 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     jmp     @Exit
@ForwardCaseCount25 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     jmp     @Exit
@ForwardCaseCount26 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     jmp     @Exit
@ForwardCaseCount27 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+26]
     mov     [edx+26], cl
     jmp     @Exit
@ForwardCaseCount28 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     jmp     @Exit
@ForwardCaseCount29 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     jmp     @Exit
@ForwardCaseCount30 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     jmp     @Exit
@ForwardCaseCount31 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+30]
     mov     [edx+30], cl
     jmp     @Exit
@ForwardCaseCount32 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     jmp     @Exit
@ForwardCaseCount33 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     jmp     @Exit
@ForwardCaseCount34 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     jmp     @Exit
@ForwardCaseCount35 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+34]
     mov     [edx+34], cl
     jmp     @Exit
@ForwardCaseCount36 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     jmp     @Exit
@ForwardCaseCount37 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     jmp     @Exit
@ForwardCaseCount38 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     jmp     @Exit
@ForwardCaseCount39 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+38]
     mov     [edx+38], cl
     jmp     @Exit
@ForwardCaseCount40 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     jmp     @Exit
@ForwardCaseCount41 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     jmp     @Exit
@ForwardCaseCount42 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     jmp     @Exit
@ForwardCaseCount43 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+42]
     mov     [edx+42], cl
     jmp     @Exit
@ForwardCaseCount44 :
     movdqu  xmm0, [eax]
     movdqu  [edx], xmm0
     movdqu  xmm2, [eax+16]
     movdqu  [edx+16], xmm2
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     jmp     @Exit
@ForwardCaseCount45 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     jmp     @Exit
@ForwardCaseCount46 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     jmp     @Exit
@ForwardCaseCount47 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+46]
     mov     [edx+46], cl
     jmp     @Exit
@ForwardCaseCount48 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     jmp     @Exit
@ForwardCaseCount49 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     jmp     @Exit
@ForwardCaseCount50 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     jmp     @Exit
@ForwardCaseCount51 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     jmp     @Exit
@ForwardCaseCount52 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     mov     cl, [eax+51]
     mov     [edx+51], cl
     jmp     @Exit
@ForwardCaseCount53 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     jmp     @Exit
@ForwardCaseCount54 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+$04]
     mov     [edx+$04], ecx
     mov     ecx, [eax+$08]
     mov     [edx+$08], ecx
     mov     ecx, [eax+$0c]
     mov     [edx+$0c], ecx
     mov     ecx, [eax+$10]
     mov     [edx+$10], ecx
     mov     ecx, [eax+$14]
     mov     [edx+$14], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     jmp     @Exit
@ForwardCaseCount55 :
     movdqu  xmm0, [eax]
     movdqu  [edx], xmm0
     movdqu  xmm1, [eax+16]
     movdqu  [edx+16], xmm1
     movdqu  xmm3, [eax+32]
     movdqu  [edx+32], xmm3
     mov     ecx,[eax+48]
     mov     [edx+48],ecx
     mov     cl,[eax+52]
     mov     [edx+52],cl
     mov     cl,[eax+53]
     mov     [edx+53],cl
     mov     cl,[eax+54]
     mov     [edx+54],cl
     jmp     @Exit

 @BigString :

   call MoveDKC60Special
 @Exit :
   //Result := Dest;
   pop  ebx
   pop  eax
   ret

@Case1JmpTable:
 dd @ForwardCaseCount0
 dd @ForwardCaseCount1
 dd @ForwardCaseCount2
 dd @ForwardCaseCount3
 dd @ForwardCaseCount4
 dd @ForwardCaseCount5
 dd @ForwardCaseCount6
 dd @ForwardCaseCount7
 dd @ForwardCaseCount8
 dd @ForwardCaseCount9
 dd @ForwardCaseCount10
 dd @ForwardCaseCount11
 dd @ForwardCaseCount12
 dd @ForwardCaseCount13
 dd @ForwardCaseCount14
 dd @ForwardCaseCount15
 dd @ForwardCaseCount16
 dd @ForwardCaseCount17
 dd @ForwardCaseCount18
 dd @ForwardCaseCount19
 dd @ForwardCaseCount20
 dd @ForwardCaseCount21
 dd @ForwardCaseCount22
 dd @ForwardCaseCount23
 dd @ForwardCaseCount24
 dd @ForwardCaseCount25
 dd @ForwardCaseCount26
 dd @ForwardCaseCount27
 dd @ForwardCaseCount28
 dd @ForwardCaseCount29
 dd @ForwardCaseCount30
 dd @ForwardCaseCount31
 dd @ForwardCaseCount32
 dd @ForwardCaseCount33
 dd @ForwardCaseCount34
 dd @ForwardCaseCount35
 dd @ForwardCaseCount36
 dd @ForwardCaseCount37
 dd @ForwardCaseCount38
 dd @ForwardCaseCount39
 dd @ForwardCaseCount40
 dd @ForwardCaseCount41
 dd @ForwardCaseCount42
 dd @ForwardCaseCount43
 dd @ForwardCaseCount44
 dd @ForwardCaseCount45
 dd @ForwardCaseCount46
 dd @ForwardCaseCount47
 dd @ForwardCaseCount48
 dd @ForwardCaseCount49
 dd @ForwardCaseCount50
 dd @ForwardCaseCount51
 dd @ForwardCaseCount52
 dd @ForwardCaseCount53
 dd @ForwardCaseCount54
 dd @ForwardCaseCount55
 

end;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Optimized for:
//Instructionset(s): IA32

function StrCopyDKCPas48(Dest: PChar; const Source: PChar): PChar;
var
 Src : PChar;

begin
 Result := Dest;
 Src := Source;
 Dec(Dest);
 Dec(Src);
 repeat
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
 until(Dest^ = #0);
end;

function StrCopyDKCPas49(Dest: PChar; const Source: PChar): PChar;
var
 Src : PChar;

begin
 Result := Dest;
 Src := Source;
 Dec(Dest);
 Dec(Src);
 repeat
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
 until(Dest^ = #0);
end;

function StrCopyDKCPas50(Dest: PChar; const Source: PChar): PChar;
var
 Src : PChar;

begin
 Result := Dest;
 Src := Source;
 Dec(Dest);
 Dec(Src);
 repeat
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
  if Dest^ = #0 then
   Break;
  Inc(Dest);
  Inc(Src);
  Dest^ := Src^;
 until(Dest^ = #0);
end;


function StrCopyDKCAsm5a(Dest: PChar; const Source: PChar): PChar;
var
 Src : PChar;

begin
{
push esi
}
 Result := Dest;
 {
 0047B735 8BF0             mov esi,eax
 }
 Src := Source;
 Dec(Dest);
 {
 0047B737 48               dec eax
 }
 Dec(Src);
 {
 0047B738 4A               dec edx
 }
 repeat
  Inc(Dest);
  {
  0047B739 40               inc eax
  }
  Inc(Src);
  {
  0047B73A 42               inc edx
  }
  Dest^ := Src^;
  {
  0047B73B 8A0A             mov cl,[edx]
  0047B73D 8808             mov [eax],cl
  }
  if Dest^ = #0 then
  {
  0047B73F 84C9             test cl,cl
  }
   Break;
   {
   jz
   }
  Inc(Dest);
  {
  0047B743 40               inc eax
  }
  Inc(Src);
  {
  0047B744 42               inc edx
  }
  Dest^ := Src^;
  {
  0047B745 8A0A             mov cl,[edx]
  0047B747 8808             mov [eax],cl
  }
 until(Dest^ = #0);
 {
 0047B749 84C9             test cl,cl
 0047B74B 75EC             jnz -$14
 0047B74D 8BC6             mov eax,esi
 0047B74F 5E               pop esi
 }
end;

function StrCopyDKCAsm5(Dest: PChar; const Source: PChar): PChar;
var
 Src : PChar;

asm
 push eax
 dec eax
 dec edx
@LoopStart :
 inc eax
 inc edx
 mov cl,[edx]
 mov [eax],cl
 test cl,cl
 jz @Exit
 inc eax
 inc edx
 mov cl,[edx]
 mov [eax],cl
 test cl,cl
 jnz @LoopStart
@Exit :
 pop eax
end;

function StrCopyDKCAsm6(Dest: PChar; const Source: PChar): PChar;
var
 Src : PChar;

asm
 push  eax
 sub   eax,1
 sub   edx,1
@LoopStart :
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jnz   @LoopStart
@Exit :
 pop   eax
end;

function StrCopyDKCAsm7(Dest: PChar; const Source: PChar): PChar;
var
 Src : PChar;

asm
 push  eax
 sub   eax,1
 sub   edx,1
 jmp   @LoopStart
 nop
 nop
 nop
 nop
 nop
 nop
 nop
@LoopStart :
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jnz   @LoopStart
@Exit :
 pop   eax
end;

function StrCopyDKCAsm8(Dest: PChar; const Source: PChar): PChar;
var
 Src : PChar;

asm
 push  eax
 sub   eax,1
 sub   edx,1
@LoopStart :
add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jz    @Exit
 add   eax,1
 add   edx,1
 movzx ecx,[edx]
 mov   [eax],cl
 test  cl,cl
 jnz   @LoopStart
@Exit :
 pop   eax
end;

end.
