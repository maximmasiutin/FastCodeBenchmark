unit AnsiStringReplaceJOHIA32Unit14;

interface

{$R-,Q-}

{$I version.inc}

uses
  Windows, SysUtils, StrUtils;

{Equivalent of StringReplace for Non Multi Byte Character Sets}
function StringReplace_JOH_IA32_14(const Str, Old, New: AnsiString;
                                   Flags: TReplaceFlags): AnsiString;

implementation

{$IFNDEF Delphi2005Plus}
  {$I D7PosEx.inc}
{$ENDIF}

{Size = 956 Bytes + 256 Byte Lookup Table + 4 Byte Code Page = 1216 Bytes}

function StringReplace_JOH_IA32_14(const Str, Old, New: AnsiString;
                                   Flags: TReplaceFlags): AnsiString;
const
  srCodePage    : UINT = 0; {Active Windows CodePage}
  AnsiUpcase    : string[255] = ''; {256 Character Upcase Lookup Table}
  StaticBufSize = 16; {Static Buffer Size}
  StaticBufMem  = StaticBufSize * SizeOf(Integer); {Static Buffer Memory Use}
var
  StaticBuffer  : array[0..StaticBufSize-1] of Integer;
  SaveStr       : Integer;
  SaveOld       : Integer;
  SaveNew       : Integer;
  StrLen        : Integer;
  OldLen        : Integer;
  NewLen        : Integer;
  Buffer        : Integer;
  BufSize       : Integer;
  Matches       : Integer;
  Start         : Integer;
  PosExFunc     : Integer;
asm
  push   ebx                   {Save Registers}
  push   edi
  push   esi
  test   eax, eax              {Str = nil?}
  mov    SaveStr, eax          {Save Str}
  mov    SaveOld, edx          {Save Old}
  mov    SaveNew, ecx          {Save New}
  jz     @@NilResult           {Str = nil, Exit Setting Result = ''}
  test   edx, edx              {OldPatterm = nil?}
  mov    ebx, [eax-4]          {Length(Str)}
  jz     @@SetResult           {OldPatterm = nil, Exit Setting Result = Str}
  mov    edi, [edx-4]          {Length(Old)}
  test   edi, edi              {OldLen = 0?}
  jz     @@SetResult           {Yes, Exit Setting Result = Str}
  cmp    ebx, edi              {StrLen < OldLen?}
  jb     @@SetResult           {Yes, Exit Setting Result = Str}
  xor    esi, esi              {Set NewLen = 0}
  test   ecx, ecx              {New = nil?}
  jz     @@GotLengths          {Yes, NewLen = 0}
  mov    esi, [ecx-4]          {NewLen}
@@GotLengths:
  test   Flags, 2              {rfIgnoreCase in Flags?}
  mov    PosExFunc, offset PosEx {Set PosExFunc to system.PosEx}
  jz     @@CheckReplace        {Case Sensitive, Use system.PosEx Function}
  mov    PosExFunc, offset @@AnsiPosExIC {Change PosExFunc to AnsiPosExIC}
  call   GetACP                {Get Active Code Page}
  cmp    eax, srCodePage       {Code Page Changed or Not Set?}
  jne    @@SetCodePage         {Yes, Setup AnsiUpcase Lookup Table}
@@CheckReplace:
  test   Flags, 1              {rfReplaceAll in Flags?}
  mov    ecx, 1                {Initial PosEx Start Offset}
  jz     @@ReplaceFirstOnly    {Replace First Occurance Only}
  cmp    esi, ecx              {NewLen = 1?}
  jne    @@NotSingleChar       {No, Not Single Character Replacement}
  cmp    edi, ecx              {OldLen = 1?}
  jne    @@NotSingleChar       {No, Not Single Character Replacement}
  mov    eax, Result           {@Result}
  mov    edx, ebx              {StrLen(Remainder)}
  call   system.@LStrSetLength {Set Result Length to StrLen}
  mov    edx, Result           {@Result}
  mov    eax, SaveStr          {Str}
  mov    edx, [edx]            {Result}
  mov    ecx, ebx              {StrLen}
  mov    edi, edx              {Save Result}
  call   Move                  {Result = Str}
  mov    eax, SaveOld          {Old}
  mov    edx, SaveNew          {New}
  dec    edi                   {Remainder}
  movzx  eax, [eax]            {Old[1]}
  movzx  edx, [edx]            {New[1]}
  test   Flags, 2              {rfIgnoreCase in Flags}
  jz     @@CharLoopCS          {No, Case Sensitive}
  movzx  eax, [eax+AnsiUpcase] {AnsiUpcase(Old[1])}

@@CharLoopIC:                  {Replace All Ignoring Case}
  movzx  ecx, [edi+ebx]        {Next Char of Result}
  cmp    al, [ecx+AnsiUpcase]
  jne    @@CharCheckIC         {No Match, Ready for Next Char}
  mov    [edi+ebx], dl         {Yes, Replace Char}
@@CharCheckIC:
  dec    ebx                   {Remainder = 0?}
  jnz    @@CharLoopIC          {No, Loop}
  jmp    @@Done                {Finished}

@@CharLoopCS:                  {Case Sensitive Replace All}
  cmp    al, [edi+ebx]
  jne    @@CharCheckCS         {No Match, Ready for Next Char}
  mov    [edi+ebx], dl         {Yes, Replace Char}
@@CharCheckCS:
  dec    ebx                   {Remainder = 0?}
  jnz    @@CharLoopCS          {No, Loop}
  jmp    @@Done                {Finished}

@@SetResult:
  test   ebx, ebx              {StrLen = 0?}
  jz     @@NilResult           {Yes, Return Result = nil}
  mov    edx, SaveStr          {Str}
  mov    eax, Result           {Result}
  call   system.@LStrAsg       {Result := S}
  jmp    @@Done                {Finished}

@@NilResult:
  mov    eax, Result           {Result}
  call   system.@LStrClr       {Result := ''}
  jmp    @@Done                {Finished}

@@SetCodePage:
  mov    srCodePage, eax       {Save CodePage}
  lea    eax, AnsiUpcase       {Setup AnsiUpcase Lookup Table}
  xor    ecx, ecx
@@AnsiUpcaseLoop:              {Set each Character in Table}
  mov    [eax+ecx], cl         { to its own Character Position}
  inc    ecx
  test   cl, cl
  jnz    @@AnsiUpcaseLoop      {Repeat 256 times}
  push   ecx                   {256}
  push   eax                   {srCodePage}
  call   CharUpperBuffA        {Convert AnsiUpcase Table to Uppercase}
  jmp    @@CheckReplace        {AnsiUpcase Lookup Table Created}

{function AnsiPosExIC(const SubStr, Str: string; Offset: Integer): Integer;}
@@AnsiPosExIC:
  push   ebx
  push   esi
  push   edx                   {@Str}
  mov    esi, ecx
  mov    ecx, [edx-4]          {Length(Str) (S<>nil)}
  mov    ebx, [eax-4]          {Length(SubStr) (SubStr<>nil)}
  add    ecx, edx
  sub    ecx, ebx              {Max Start Pos for a Full Match}
  lea    edx, [edx+esi-1]      {Set Start Position}
  cmp    edx, ecx
  jg     @@NotFound            {StartPos > Max Start Pos}
  sub    ebx, 2                {Length(SubStr) - 2}
  jc     @@SingleChar          {Length(SubStr) <= 1 (Len<>0)}
  push   edi
  push   ebp
  push   ebx                   {Save Remainder to Check = Length(SubStr) - 2}
  push   ecx                   {Save Max Start Position}
  mov    esi, eax
  movzx  ebx, [eax]            {Search Character = 1st Char of SubStr}
  lea    edi, AnsiUpcase       {Uppercase Lookup Table}
  movzx  ebx, [edi+ebx]        {Convert to Uppercase}
@@Loop:                        {Loop Comparing 2 Characters per Loop}
  movzx  eax, [edx]            {Get Next Character}
  cmp    bl, [edi+eax]
  jne    @@NotChar1
  mov    ebp, [esp+4]          {Remainder to Check}
@@Char1Loop:
  movzx  eax, [esi+ebp]
  movzx  ecx, [edx+ebp]
  movzx  eax, [edi+eax]        {Convert to Uppercase}
  cmp    al, [edi+ecx]
  jne    @@NotChar1
  movzx  eax, [esi+ebp+1]
  movzx  ecx, [edx+ebp+1]
  movzx  eax, [edi+eax]        {Convert to Uppercase}
  cmp    al, [edi+ecx]
  jne    @@NotChar1
  sub    ebp, 2
  jge    @@Char1Loop
  pop    ecx
  pop    eax
  pop    ebp
  pop    edi
  jmp    @@SetPosResult
@@NotChar1:
  movzx  eax, [edx+1]          {Get Next Character}
  cmp    bl, [edi+eax]
  jne    @@NotChar2
  mov    ebp, [esp+4]          {Remainder to Check}
@@Char2Loop:
  movzx  eax, [esi+ebp]
  movzx  ecx, [edx+ebp+1]
  movzx  eax, [edi+eax]        {Convert to Uppercase}
  cmp    al, [edi+ecx]
  jne    @@NotChar2
  movzx  eax, [esi+ebp+1]
  movzx  ecx, [edx+ebp+2]
  movzx  eax, [edi+eax]        {Convert to Uppercase}
  cmp    al, [edi+ecx]
  jne    @@NotChar2
  sub    ebp, 2
  jge    @@Char2Loop
  pop    ecx
  pop    eax
  pop    ebp
  pop    edi
  jmp    @@CheckPosResult      {Check Match is within String Data}
@@NotChar2:
  add    edx, 2
  cmp    edx, [esp]            {Compare to Max Start Position}
  jle    @@Loop                {Loop until Start Pos > Max Start Pos}
  pop    ecx                   {Dump Start Position}
  pop    eax                   {Dump Remainder to Check}
  pop    ebp
  pop    edi              
  jmp    @@NotFound
@@SingleChar: 
  movzx  ebx, [eax]            {1st Char of SubStr}
  lea    esi, AnsiUpcase
  movzx  ebx, [esi+ebx]        {Convert to Uppercase}
@@CharLoop:
  movzx  eax, [edx]
  cmp    bl, [esi+eax]
  je     @@SetPosResult
  inc    edx
  cmp    edx, ecx
  jle    @@CharLoop
@@NotFound:
  xor    eax, eax
  pop    edx
  pop    esi
  pop    ebx
  ret
@@CheckPosResult:              {Check Match is within String Data}
  cmp    edx, ecx
  jge    @@NotFound
  inc    edx                   {OK - Adjust Result}
@@SetPosResult:                {Set Result Position}
  mov    eax, edx
  inc    eax
  pop    ecx                   {@Str}
  pop    esi
  pop    ebx
  sub    eax, ecx
  ret
{End of function AnsiPosExIC}

@@NotSingleChar:               {Not a Single Character Replacement}
  mov    eax, SaveOld          {Old}
  mov    edx, SaveStr          {Str}
  call   PosExFunc             {Call PosEx Function}
  test   eax, eax              {Match Found?}
  jz     @@SetResult           {No, Result = Str}
  mov    ecx, eax              {Yes, Save Match Position}
  mov    StrLen, ebx           {StrLen = Length(Str)}
  mov    OldLen, edi           {OldLen = Length(Old)}
  mov    NewLen, esi           {NewLen = Length(New)}
  lea    edx, StaticBuffer     {Static Buffer Address}
  mov    BufSize, StaticBufSize{Initial Buffer Size}
  mov    Buffer, edx           {Set Buffer Address}
  xor    ebx, ebx              {Matches-1}
  mov    [edx], eax            {Buffer[0] = Match Position}
@@SearchLoop:
  inc    ebx                   {Matches}
  mov    eax, SaveOld          {Old}
  mov    edx, SaveStr          {Str}
  add    ecx, edi              {Inc(Match Position, OldLen)}
  call   PosExFunc             {PosEx(Old, Str, Match Position)}
  test   eax, eax              {Match Found?}
  mov    ecx, eax              {Match Position}
  jz     @@GotAllMatches       {No More Matches Found}
  cmp    ebx, BufSize          {Matches = BufSize?}
  je     @@BufferFull          {Create or Expand Dynamic Buffer}
@@SaveMatchPosition:           {Save Match Position}
  mov    eax, Buffer           {Buffer Address}
  mov    [eax+ebx*4], ecx      {Buffer[Matches] = Match Position}
  jmp    @@SearchLoop          {Repeat Until No More Matches Found}

@@BufferFull:                  {Create or Expand Dynamic Buffer}
  push   ecx                   {Save Match Position}
  mov    edx, ebx              {BufSize}
  shr    edx, 1                {Buffer Size / 2}
  lea    eax, [ebx+edx]        {Grow Buffer by 50%}
  mov    BufSize, eax          {Save Buffer Size}
  lea    edx, StaticBuffer     {Static Buffer Address}
  cmp    Buffer, edx           {Buffer = Static Buffer?}
  jne    @@Expand              {No, Expand Dynamic Buffer}
  shl    eax, 2                {BufSize * SizeOf(Integer)}
  call   system.@GetMem        {Create Dynamic Buffer}
  mov    Buffer, eax           {Save Dynamic Buffer Address}
  mov    edx, eax              {Dynamic Buffer Address}
  lea    eax, StaticBuffer     {Static Buffer Address}
  mov    ecx, StaticBufMem     {Static Buffer Size}
  call   Move                  {Copy Static Buffer Data into Dynamic Buffer}
  pop    ecx                   {Restore Match Position}
  jmp    @@SaveMatchPosition   {Save Match Position}
@@Expand:                      {Expand Dynamic Buffer}
  shl    eax, 2                {BufSize * SizeOf(Integer)}
  mov    edx, eax              {Buffer Size (Bytes)}
  lea    eax, Buffer           {Buffer Address}
  call   system.@ReAllocMem    {Increase Buffer Size by 50%}
  mov    Buffer, eax           {Save Buffer Address}
  pop    ecx                   {Restore Match Position}
  jmp    @@SaveMatchPosition   {Save Match Position}

@@GotAllMatches:               {All Match Positions Found}
  mov    edx, esi              {NewLen}
  sub    edx, edi              {NewLen - Oldlen}
  imul   edx, ebx              {Matches * (NewLen - OldLen)}
  add    edx, StrLen           {StrLen + (Matches * (NewLen - OldLen))}
  mov    eax, Result           {@Result}
  call   System.@LStrSetLength {Set Result Length}
  mov    esi, SaveStr          {Str}
  mov    edi, Result           {@Result}
  mov    edi, [edi]            {Result}
  mov    Matches, ebx          {Save Matches}
  mov    Start, 1              {Start = 1}
  xor    ebx, ebx              {Match = 0}
@@ReplaceLoop:                 {Replace Chars at Next Match Position}
  mov    eax, Buffer           {Buffer Address}
  mov    eax, [eax+ebx*4]      {Match Position = Buffer[Match]}
  inc    ebx                   {Increment Match for Next Loop}
  mov    ecx, eax              {Match Position}
  add    eax, OldLen           {Match Position + OldLen}
  sub    ecx, Start            {Count = Match Position - Start}
  mov    Start, eax            {Start = Match Position + OldLen}
  jz     @@Moved1              {If Count = 0, No Move Needed}
  push   ecx                   {Save Count}
  mov    eax, esi              {PStr}
  mov    edx, edi              {PRes}
  call   Move                  {Move(PStr^, PRes^, Count)}
  pop    ecx                   {Restore Count}
  add    edi, ecx              {Inc(PRes, Count)}
@@Moved1:
  add    ecx, OldLen           {Count + OldLen)}
  mov    eax, SaveNew          {New}
  add    esi, ecx              {Inc(PStr, Count + OldLen)}
  mov    edx, edi              {PRes}
  mov    ecx, NewLen           {NewLen}
  add    edi, ecx              {PRes + NewLen}
  call   Move                  {Move(New, PRes, NewLen)}
  cmp    ebx, Matches          {All Matches Processed}
  jne    @@ReplaceLoop         {No, Process Next Match}
  mov    ecx, StrLen           {StrLen}
  sub    ecx, Start            {Remainder = StrLen - Start}
  jb     @@Moved2              {No Move if Remainder < 0}
  mov    eax, esi              {PStr}
  mov    edx, edi              {PRes}
  inc    ecx                   {Remainder - 1}
  call   Move                  {Move(PStr, PRes, Remainder - 1)}
@@Moved2:
  cmp    BufSize, StaticBufSize{Buffer = Static Buffer?}
  je     @@Done                {Yes, Finished}
  mov    eax, Buffer           {Buffer Address}
  call   system.@FreeMem       {Delete Dynamic Buffer}
  jmp    @@Done                {Finished}

@@ReplaceFirstOnly:            {Replace First Occurance Only}
  mov    eax, SaveOld          {Old}
  mov    edx, SaveStr          {Str}
  mov    ecx, 1                {PosEx Offset = 1}
  call   PosExFunc             {Call PosEx Function}
  sub    eax, 1                {Match Position-1}
  jc     @@SetResult           {No Match, Result = Str}
  mov    StrLen, ebx           {StrLen}
  sub    ebx, edi              {StrLen - OldLen}
  lea    edx, [ebx+esi]        {StrLen - OldLen + NewLen}
  mov    ebx, eax              {Save Match Position-1}
  mov    eax, Result           {@Result}
  call   system.@LStrSetLength {SetLength(Result, StrLen-OldLen+NewLen)}
  cmp    edi, esi              {OldLen = NewLen?}
  jne    @@DiffLen             {No, Different Lengths}
  mov    edx, Result           {@Result}
  mov    eax, SaveStr          {Str}
  mov    edx, [edx]            {Result}
  mov    ecx, StrLen           {StrLen}
  add    ebx, edx              {Result + Match Position-1}
  call   Move                  {Result = Str}
  mov    eax, SaveNew          {New}
  mov    edx, ebx              {Result + Match Position-1}
  mov    ecx, esi              {NewLen}
  jmp    @@FinalMove           {Perform Final Move then Finish}
@@DiffLen:
  mov    OldLen, edi           {OldLen}
  push   esi                   {NewLen}
  mov    eax, Result           {@Result}
  mov    esi, SaveStr          {Str}
  mov    edi, [eax]            {Result}
  test   ebx, ebx              {Match at Position 1?}
  jz     @@Moved3              {Yes, Skip First Move}
  mov    eax, esi              {Str}
  mov    edx, edi              {Result}
  mov    ecx, ebx              {Match Position-1}
  call   Move                  {Move(PStr^, PRes^, Match Position)}
  add    esi, ebx              {Str + Match Position-1}
  add    edi, ebx              {Result + Match Position-1}
@@Moved3:
  add    esi, OldLen           {Str + OldLen}
  mov    eax, SaveNew          {New}
  mov    edx, edi              {Result + Match Position-1}
  pop    ecx                   {NewLen}
  add    edi, ecx              {Result + Match Position-1 + NewLen}
  call   Move                  {Move(Pointer(New)^, PRes^, NewLen)}
  mov    ecx, StrLen           {StrLen}
  sub    ecx, ebx              {StrLen - Match Position-1}
  sub    ecx, OldLen           {StrLen - Match Position-1 - OldLen}
  jz     @@Done                {Finished if Match om Last Character}
  mov    eax, esi              {Str + OldLen}
  mov    edx, edi              {Result + Match Position-1 + NewLen}
@@FinalMove:
  call   Move                  {Perform Final Move}

@@Done:
  pop    esi                   {Restore Registers}
  pop    edi
  pop    ebx
end;

end.
