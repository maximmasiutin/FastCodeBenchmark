{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_LIBRARY OFF}

unit PosLPUnit;

interface


 //function PosLP       (const lcpSubStr, lcpStr: string): Integer; register;//Uses memory below stackpointer
 //function PosLP_Athlon(const lcpSubStr, lcpStr: string): Integer; register;//Uses memory below stackpointer
 //function PosLP_SSE   (const lcpSubStr, lcpStr: string): Integer; register;//Uses memory below stackpointer
 //function PosLP_SSE2  (const lcpSubStr, lcpStr: string): Integer; register;//Uses memory below stackpointer


implementation

uses Windows;

 function mcfSearchBuf_SmlCnt(lnpB: Byte; var lvpBuf; lnpCnt: Integer): Integer; register; forward;

const
 lucSL = 4;  //negative offset to string length


{========================================================================================================}
{
function PosLP(const lcpSubStr, lcpStr: string): Integer; register;
asm
 jmp      PosLP_Athlon
end;
}
{========================================================================================================}
{for Athlon and any other CPU that does not have SSE but will handle conditional moves}
{Although Athlon will run PosLP_SSE, it will actually be faster here}
function PosLP_Athlon(const lcpSubStr, lcpStr: string): Integer; register;
asm
 test     edx, edx
 cmovz    eax, edx
 test     eax, eax
 jz       @exit      //exit if SubStr or Str is empty

 mov      ecx, [edx-lucSL]
 inc      ecx
 sub      ecx, [eax-lucSL]
 jle      @zeroexit

 push     esi
 mov      esi, eax
 mov      al, [eax]
 push     edi
 mov      edi, edx
 mov      [esp-4], edx
@srchloop:
 repne    scasb
 jne      @notfound
 mov      edx, [esi-lucSL]
 dec      edx
@cmploop:
 mov      ah, [edi+edx-1]
 cmp      ah, [esi+edx]
 jne      @srchloop
 sub      edx, 1
 jg       @cmploop
 mov      eax, edi
 pop      edi
 sub      eax, [esp-8]
 pop      esi
 ret

@notfound:
 pop      edi
 pop      esi
@zeroexit:
 xor      eax, eax
@exit:
end;
{========================================================================================================}
{For Pentium 3 only. Athlon does not benefit from SSE}
function PosLP_SSE(const lcpSubStr, lcpStr: string): Integer; register;
asm
 test     edx, edx
 cmovz    eax, edx
 test     eax, eax
 jz       @exit          //exit if SubStr or Str is empty

 mov      ecx, [edx-lucSL]
 inc      ecx
 sub      ecx, [eax-lucSL]
 jle      @zeroexit

 mov      [esp-32], edx  //save for result calculation
 cmp      ecx, 16
 jg       @longstr

 push     esi
 mov      esi, eax        //esi <- @SubStr
 mov      al, [eax]
 dec      edx
 push     ebx
@smlsrchloop:
 inc      edx
 dec      ecx
 cmp      al, [edx]
 je       @smlcmp
@smlsrch:
 test     ecx, ecx
 jnz      @smlsrchloop
 pop      ebx
 xor      eax, eax
 pop      esi
 ret
@smlcmp:
 mov      ebx, [esi-lucSL]
 dec      ebx
@smlcmploop:
 mov      ah, [edx+ebx]
 cmp      ah, [esi+ebx]
 jne      @smlsrch
 sub      ebx, 1
 jg       @smlcmploop
 pop      ebx
 lea      eax, [edx+1]
 pop      esi
 sub      eax, [esp-32]
 ret
@zeroexit:
 xor      eax, eax
@exit:
 ret

@longstr:
 mov      [esp-8], eax
 cmp      dword ptr[eax-lucSL], 1
 mov      al, [eax]
 mov      ah, al
 movd     mm1, eax
 pshufw   mm1, mm1, 0
 je       @searchone      //if length of SubStr = 1 then jump
 push     esi
 mov      esi, [esp-4]    //esi <- @SubStr
 push     edi
 mov      edi, edx        //edi <- @Str
 push     ebp
 mov      ebp, ecx
 push     ebx
 mov      bl, al
@srchloop:
 mov      edx, edi
 mov      ecx, ebp
 mov      al, bl
 call     @searchfirst
 jz       @notfound
 add      edi, eax
 sub      ebp, eax
 mov      ecx, [esi-lucSL]
 dec      ecx
@cmploop:
 mov      al, [edi+ecx-1]
 cmp      al, [esi+ecx]
 jne      @srchloop
 sub      ecx, 1
 jnz      @cmploop
@found:
 mov      eax, edi
 sub      eax, [esp-16]
@notfound:
 emms
 pop      ebx
 pop      ebp
 pop      edi
 pop      esi
 ret

@searchfirst:
 cmp      ecx, 16
 jle      mcfSearchBuf_SmlCnt
 movq     mm0, mm1
 pcmpeqb  mm0, [edx]
 pmovmskb eax, mm0
 bsf      eax, eax
 jnz      @foundfirst2
 mov      eax, edx
 not      eax
 sub      ecx, 8
 and      eax, 7
 mov      [esp-4], ecx
 add      eax, 1
 add      edx, ecx
 sub      ecx, eax
 neg      ecx
@loop:
 movq     mm0, mm1
 pcmpeqb  mm0, [edx+ecx]
 pmovmskb eax, mm0
 bsf      eax, eax
 jnz      @foundfirst
 add      ecx, 8
 js       @loop
 movq     mm0, mm1
 pcmpeqb  mm0, [edx]
 pmovmskb eax, mm0
 bsf      eax, eax
 jnz      @foundfirst1
 ret                //eax is already zero
@foundfirst:
 add      eax, ecx
@foundfirst1:
 add      eax, [esp-4]
@foundfirst2:
 add      eax, 1
 ret
@searchone:
 call     @searchfirst
 emms
end;
{========================================================================================================}
{For Pentium 4 and later}
function PosLP_SSE2(const lcpSubStr, lcpStr: string): Integer; register;
asm
 test     edx, edx
 cmovz    eax, edx
 test     eax, eax
 jz       @exit      //exit if SubStr or Str is empty

 mov      ecx, [edx-lucSL]
 inc      ecx
 sub      ecx, [eax-lucSL]
 jle      @zeroexit

 mov      [esp-32], edx   //save for result calculation
 cmp      ecx, 32
 jg       @longstr

 push     esi
 mov      esi, eax        //esi <- @SubStr
 mov      al, [eax]
 dec      edx
 push     ebx
@smlsrchloop:
 inc      edx
 dec      ecx
 cmp      al, [edx]
 je       @smlcmp
@smlsrch:
 test     ecx, ecx
 jnz      @smlsrchloop
 pop      ebx
 xor      eax, eax
 pop      esi
 ret
@smlcmp:
 mov      ebx, [esi-lucSL]
 dec      ebx
@smlcmploop:
 mov      ah, [edx+ebx]
 cmp      ah, [esi+ebx]
 jne      @smlsrch
 sub      ebx, 1
 jg       @smlcmploop
 pop      ebx
 lea      eax, [edx+1]
 pop      esi
 sub      eax, [esp-32]
 ret
@zeroexit:
 xor      eax, eax
@exit:
 ret

@longstr:
 mov      [esp-8], eax
 cmp      dword ptr[eax-lucSL], 1
 mov      al, [eax]
 mov      ah, al
 movd     xmm1, eax
 pshuflw  xmm1, xmm1, 0
 pshufd   xmm1, xmm1, 0
 je       @searchfirst    //if length of SubStr = 1 then jump
 push     esi
 mov      esi, [esp-4]    //esi <- @SubStr
 push     edi
 mov      edi, edx        //edi <- @Str
 push     ebp
 mov      ebp, ecx
 push     ebx
 mov      bl, al
@srchloop:
 mov      edx, edi
 mov      ecx, ebp
 mov      al, bl
 call     @searchfirst
 jz       @notfound
 add      edi, eax
 sub      ebp, eax
 mov      ecx, [esi-lucSL]
 dec      ecx
@cmploop:
 mov      al, [edi+ecx-1]
 cmp      al, [esi+ecx]
 jne      @srchloop
 sub      ecx, 1
 jnz      @cmploop
@found:
 mov      eax, edi
 sub      eax, [esp-16]
@notfound:
 pop      ebx
 pop      ebp
 pop      edi
 pop      esi
 ret

@searchfirst:
 cmp      ecx, 32
 jle      mcfSearchBuf_SmlCnt
 movdqu   xmm2, [edx]
 movdqa   xmm0, xmm1
 pcmpeqb  xmm0, xmm2
 pmovmskb eax, xmm0
 bsf      eax, eax
 jnz      @foundfirst2
 mov      eax, edx
 not      eax
 sub      ecx, 16
 and      eax, 15
 mov      [esp-4], ecx
 add      eax, 1
 add      edx, ecx
 sub      ecx, eax
 neg      ecx
@loop:
 movdqa   xmm0, xmm1
 pcmpeqb  xmm0, [edx+ecx]
 pmovmskb eax, xmm0
 bsf      eax, eax
 jnz      @foundfirst
 add      ecx, 16
 js       @loop
 movdqu   xmm2, [edx]
 movdqa   xmm0, xmm1
 pcmpeqb  xmm0, xmm2
 pmovmskb eax, xmm0
 bsf      eax, eax
 jnz      @foundfirst1
 ret                //eax is already zero
@foundfirst:
 add      eax, ecx
@foundfirst1:
 add      eax, [esp-4]
@foundfirst2:
 add      eax, 1
end;
{========================================================================================================}
function mcfSearchBuf_SmlCnt(lnpB: Byte; var lvpBuf; lnpCnt: Integer): Integer; register;
asm
 push     ecx
@loop:
 test     ecx, ecx
 jle      @exit
 inc      edx
 dec      ecx
 cmp      al, [edx-1]
 jne      @loop
@exit:
 pop      eax
 sub      eax, ecx
end;
{========================================================================================================}


type
 TCompatibleRec = packed record
                   Orig : Pointer;
                   Subst: Pointer;
                   Cond : Cardinal
                  end;

var
 guvCpuFlags: Cardinal;
{========================================================================================================}
procedure MakeGoodCpuUse(const lcpData: array of TCompatibleRec);
 type
  TJump = packed record
           Instr: Byte;
           Ofs: Integer
          end;
  PJump = ^TJump;
 var
  fx: Integer;
  lfvJump: TJump;
  lfvOldProtect, lfvProtect: DWord;
begin
 lfvJump.Instr := $E9;
 for fx := Low(lcpData) to High(lcpData) do
  with lcpData[fx] do
   begin
    if (Cond and guvCpuFlags) <> Cond then Continue;  //current cpu is not compatible
    lfvJump.Ofs := Integer(Subst) - Integer(Orig) - SizeOf(TJump);
    VirtualProtect(Orig, SizeOf(TJump), PAGE_READWRITE, lfvOldProtect);
    PJump(Orig)^ := lfvJump;
    VirtualProtect(Orig, SizeOf(TJump), lfvOldProtect, lfvProtect);
    FlushInstructionCache(GetCurrentProcess, Orig, Sizeof(TJump))
   end {with}
end;
{========================================================================================================}
procedure CheckCPU; register;
asm
 push     ebx
 push     edi
 xor      edi, edi
 {check for existence of CPUID instruction}
 pushfd
 pop      eax
 mov      ecx, eax
 xor      eax, $00200000
 push     eax
 popfd
 pushfd
 pop      eax
 cmp      eax, ecx
 je       @exit           //no CPUID istruction available
 or       di, $0080       //set cpuHasId on
 xor      eax, eax
 cpuid
 {check if AMD}
 cmp      ebx, 'htuA'
 jne      @cpuintel
 cmp      edx, 'itne'
 jne      @cpuintel
 cmp      ecx, 'DMAc'
 jne      @cpuintel
 or       edi, $80000000  //set cpuAMD on
 jmp      @getfeat
@cpuintel:
 or       edi, $40000000  //intel cpu
@getfeat:
 cmp      eax, 1
 jb       @getextfeat
 mov      eax, 1
 cpuid
 mov      eax, edi
 bt       edx, 26         //SSE2
 rcl      al, 1
 bt       edx, 25         //SSE
 rcl      al, 1
 bt       edx, 23         //MMX
 rcl      al, 1
 bt       edx, 15         //CMOV
 rcl      al, 1
 bt       edx, 0          //FPU
 rcl      al, 1
 or       al, $80         //cpuHasId
 mov      edi, eax
@getextfeat:
 test     edi, $80000000  //set ext features only if amd
 jz       @exit
 mov      eax, $80000000
 cpuid
 cmp      eax, $80000001
 jb       @exit
 mov      eax, edi
 bt       edx, 30         //3DNow extensions
 rcl      ah, 1
 bt       edx, 30         //3DNow
 rcl      ah, 1
 bt       edx, 22         //MMX extensions
 rcl      ah, 1
 mov      edi, eax
@exit:
 mov      guvCpuFlags, edi
 pop      edi
 pop      ebx
end;
{========================================================================================================}
const
 cpuFPU         = $00000001;  //build in FPU present
 cpuCMOV        = $00000002;  //supports CMOVcc, FCMOVcc, FCOMI instrustions
 cpuMMX         = $00000004;  //MMX supported
 cpuSSE         = $00000008;  //SSE supported
 cpuSSE2        = $00000010;  //SSE2 supported
 cpuHasId       = $00000080;  //cpuid instruction present -> at least 486 -> instructions: bswap, xadd, cmpxchg are available

 cpuMMXExt      = $00000100;  //MMX extensions
 cpu3DNow       = $00000200;  //3DNow supported
 cpu3DNowExt    = $00000400;  //extensions to 3DNow supported

 cpuIntel       = $40000000;  //Intel (or any other non AMD) cpu
 cpuAMD         = $80000000;  //AMD cpu

 //lucComp: array[0..1] of TCompatibleRec =
 //((Orig: Addr(PosLP); Subst: Addr(PosLP_SSE) ; Cond: cpuSSE or cpuIntel), //must be first
  //(Orig: Addr(PosLP); Subst: Addr(PosLP_SSE2); Cond: cpuSSE2));

initialization
 CheckCPU;
 //MakeGoodCpuUse(lucComp)

end.
