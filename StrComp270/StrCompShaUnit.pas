unit StrCompShaUnit;

interface

function StrComp_Sha_Pas_4_a(const str1, str2: pchar): integer;
function StrComp_Sha_Pas_4_b(const str1, str2: pchar): integer;
function StrComp_Sha_Pas_4_c(const str1, str2: pchar): integer;
function StrComp_Sha_Pas_4_d(const str1, str2: pchar): integer;
function StrComp_Sha_Pas_5_a(const str1, str2: pchar): integer;
function StrComp_Sha_Pas_5_b(const str1, str2: pchar): integer;
function StrComp_Sha_Pas_5_c(const str1, str2: pchar): integer;
function StrComp_Sha_Pas_5_d(const str1, str2: pchar): integer;
function StrComp_Sha_IA32_3_a(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_3_b(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_3_c(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_3_d(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_4_a(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_4_b(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_4_c(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_4_d(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_5_a(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_5_b(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_5_c(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_5_d(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_7_a(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_7_b(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_7_c(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_7_d(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_8_a(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_8_b(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_8_c(const Str1, Str2: PChar): Integer;
function StrComp_Sha_IA32_8_d(const Str1, Str2: PChar): Integer;

implementation

function StrComp_Sha_IA32_3_a(const Str1, Str2: PChar): Integer; assembler;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   add   eax, 1
   test  cl, cl
   jz    @last
   cmp   cl, [eax-1]
   je    @next
@last:
   movzx eax, [eax-1]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_3_b(const Str1, Str2: PChar): Integer; assembler;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   add   eax, 1
   test  cl, cl
   jz    @last
   cmp   cl, [eax-1]
   je    @next
@last:
   movzx eax, [eax-1]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_3_c(const Str1, Str2: PChar): Integer; assembler;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   add   eax, 1
   test  cl, cl
   jz    @last
   cmp   cl, [eax-1]
   je    @next
@last:
   movzx eax, [eax-1]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_3_d(const Str1, Str2: PChar): Integer;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   add   eax, 1
   test  cl, cl
   jz    @last
   cmp   cl, [eax-1]
   je    @next
@last:
   movzx eax, [eax-1]
   sub   eax, ecx
   end;


function StrComp_Sha_IA32_4_a(const Str1, Str2: PChar): Integer; assembler;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   test  cl, cl
   jz    @last
   cmp   cl, [eax]
   jne   @last
   movzx ecx, [eax+edx+1]
   add   eax, 2
   test  cl, cl
   jz    @last1
   cmp   cl, [eax-1]
   je    @next
@last1:
   sub   eax,1
@last:
   movzx eax, [eax]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_4_b(const Str1, Str2: PChar): Integer; assembler;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   test  cl, cl
   jz    @last
   cmp   cl, [eax]
   jne   @last
   movzx ecx, [eax+edx+1]
   add   eax, 2
   test  cl, cl
   jz    @last1
   cmp   cl, [eax-1]
   je    @next
@last1:
   sub   eax,1
@last:
   movzx eax, [eax]
   sub   eax, ecx
   end;

procedure Filler1;
asm
 nop
end;

function StrComp_Sha_IA32_4_c(const Str1, Str2: PChar): Integer; assembler;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   test  cl, cl
   jz    @last
   cmp   cl, [eax]
   jne   @last
   movzx ecx, [eax+edx+1]
   add   eax, 2
   test  cl, cl
   jz    @last1
   cmp   cl, [eax-1]
   je    @next
@last1:
   sub   eax,1
@last:
   movzx eax, [eax]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_4_d(const Str1, Str2: PChar): Integer; assembler;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   test  cl, cl
   jz    @last
   cmp   cl, [eax]
   jne   @last
   movzx ecx, [eax+edx+1]
   add   eax, 2
   test  cl, cl
   jz    @last1
   cmp   cl, [eax-1]
   je    @next
@last1:
   sub   eax,1
@last:
   movzx eax, [eax]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_5_a(const Str1, Str2: PChar): Integer;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   test  cl, cl
   jz    @last
   cmp   cl, [eax]
   jne   @last
   movzx ecx, [eax+edx+1]
   test  cl, cl
   jz    @last1
   cmp   cl, [eax+1]
   jne   @last1
   movzx ecx, [eax+edx+2]
   test  cl, cl
   jz    @last2
   cmp   cl, [eax+2]
   jne   @last2
   movzx ecx, [eax+edx+3]
   add   eax, 4
   test  cl, cl
   jz    @last3
   cmp   cl, [eax-1]
   je    @next
@last3:
   sub   eax, 3
@last2:
   add   eax, 1
@last1:
   add   eax, 1
@last:
   movzx eax, [eax]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_5_b(const Str1, Str2: PChar): Integer;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   test  cl, cl
   jz    @last
   cmp   cl, [eax]
   jne   @last
   movzx ecx, [eax+edx+1]
   test  cl, cl
   jz    @last1
   cmp   cl, [eax+1]
   jne   @last1
   movzx ecx, [eax+edx+2]
   test  cl, cl
   jz    @last2
   cmp   cl, [eax+2]
   jne   @last2
   movzx ecx, [eax+edx+3]
   add   eax, 4
   test  cl, cl
   jz    @last3
   cmp   cl, [eax-1]
   je    @next
@last3:
   sub   eax, 3
@last2:
   add   eax, 1
@last1:
   add   eax, 1
@last:
   movzx eax, [eax]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_5_c(const Str1, Str2: PChar): Integer;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   test  cl, cl
   jz    @last
   cmp   cl, [eax]
   jne   @last
   movzx ecx, [eax+edx+1]
   test  cl, cl
   jz    @last1
   cmp   cl, [eax+1]
   jne   @last1
   movzx ecx, [eax+edx+2]
   test  cl, cl
   jz    @last2
   cmp   cl, [eax+2]
   jne   @last2
   movzx ecx, [eax+edx+3]
   add   eax, 4
   test  cl, cl
   jz    @last3
   cmp   cl, [eax-1]
   je    @next
@last3:
   sub   eax, 3
@last2:
   add   eax, 1
@last1:
   add   eax, 1
@last:
   movzx eax, [eax]
   sub   eax, ecx
   end;

function StrComp_Sha_IA32_5_d(const Str1, Str2: PChar): Integer;
asm
   sub   edx, eax //pointers MUST be not NULL
@next:
   movzx ecx, [eax+edx]
   test  cl, cl
   jz    @last
   cmp   cl, [eax]
   jne   @last
   movzx ecx, [eax+edx+1]
   test  cl, cl
   jz    @last1
   cmp   cl, [eax+1]
   jne   @last1
   movzx ecx, [eax+edx+2]
   test  cl, cl
   jz    @last2
   cmp   cl, [eax+2]
   jne   @last2
   movzx ecx, [eax+edx+3]
   add   eax, 4
   test  cl, cl
   jz    @last3
   cmp   cl, [eax-1]
   je    @next
@last3:
   sub   eax, 3
@last2:
   add   eax, 1
@last1:
   add   eax, 1
@last:
   movzx eax, [eax]
   sub   eax, ecx
   end;

function StrComp_Sha_Pas_4_a(const str1, str2: pchar): integer;
var
  dist: integer;
  p: pchar;
label
  make;
begin;
   dist:=str1-str2;
   p:=str2;
   repeat;
     Result:=shortint(p[dist]);
     if (Result=0) or (chr(Result)<>p[0]) then goto make;
     Result:=shortint(p[dist+1]);
     inc(p,2);
     until (Result=0) or (chr(Result)<>p[-1]);
   dec(p);
make:
   Result:=byte(Result)-byte(p[0]);
   end;

function StrComp_Sha_Pas_4_b(const str1, str2: pchar): integer;
var
  dist: integer;
  p: pchar;
label
  make;
begin;
   dist:=str1-str2;
   p:=str2;
   repeat;
     Result:=shortint(p[dist]);
     if (Result=0) or (chr(Result)<>p[0]) then goto make;
     Result:=shortint(p[dist+1]);
     inc(p,2);
     until (Result=0) or (chr(Result)<>p[-1]);
   dec(p);
make:
   Result:=byte(Result)-byte(p[0]);
   end;

function StrComp_Sha_Pas_4_c(const str1, str2: pchar): integer;
var
  dist: integer;
  p: pchar;
label
  make;
begin;
   dist:=str1-str2;
   p:=str2;
   repeat;
     Result:=shortint(p[dist]);
     if (Result=0) or (chr(Result)<>p[0]) then goto make;
     Result:=shortint(p[dist+1]);
     inc(p,2);
     until (Result=0) or (chr(Result)<>p[-1]);
   dec(p);
make:
   Result:=byte(Result)-byte(p[0]);
   end;

function StrComp_Sha_Pas_4_d(const str1, str2: pchar): integer;
var
  dist: integer;
  p: pchar;
label
  make;
begin;
   dist:=str1-str2;
   p:=str2;
   repeat;
     Result:=shortint(p[dist]);
     if (Result=0) or (chr(Result)<>p[0]) then goto make;
     Result:=shortint(p[dist+1]);
     inc(p,2);
     until (Result=0) or (chr(Result)<>p[-1]);
   dec(p);
make:
   Result:=byte(Result)-byte(p[0]);
   end;

function StrComp_Sha_Pas_5_a(const str1, str2: pchar): integer;
var
  dist: integer;
  p: pchar;
label
  make, make1, make2;
begin;
   dist:=str1-str2;
   p:=str2;
   repeat;
     Result:=shortint(p[dist]);
     if (Result=0) or (chr(Result)<>p[0]) then goto make;
     Result:=shortint(p[dist+1]);
     if (Result=0) or (chr(Result)<>p[1]) then goto make1;
     Result:=shortint(p[dist+2]);
     if (Result=0) or (chr(Result)<>p[2]) then goto make2;
     Result:=shortint(p[dist+3]);
     inc(p,4);
     until (Result=0) or (chr(Result)<>p[-1]);
   dec(p,3);
make2:
   inc(p);
make1:
   inc(p);
make:
   Result:=byte(Result)-byte(p[0]);
   end;

function StrComp_Sha_Pas_5_b(const str1, str2: pchar): integer;
var
  dist: integer;
  p: pchar;
label
  make, make1, make2;
begin;
   dist:=str1-str2;
   p:=str2;
   repeat;
     Result:=shortint(p[dist]);
     if (Result=0) or (chr(Result)<>p[0]) then goto make;
     Result:=shortint(p[dist+1]);
     if (Result=0) or (chr(Result)<>p[1]) then goto make1;
     Result:=shortint(p[dist+2]);
     if (Result=0) or (chr(Result)<>p[2]) then goto make2;
     Result:=shortint(p[dist+3]);
     inc(p,4);
     until (Result=0) or (chr(Result)<>p[-1]);
   dec(p,3);
make2:
   inc(p);
make1:
   inc(p);
make:
   Result:=byte(Result)-byte(p[0]);
   end;

function StrComp_Sha_Pas_5_c(const str1, str2: pchar): integer;
var
  dist: integer;
  p: pchar;
label
  make, make1, make2;
begin;
   dist:=str1-str2;
   p:=str2;
   repeat;
     Result:=shortint(p[dist]);
     if (Result=0) or (chr(Result)<>p[0]) then goto make;
     Result:=shortint(p[dist+1]);
     if (Result=0) or (chr(Result)<>p[1]) then goto make1;
     Result:=shortint(p[dist+2]);
     if (Result=0) or (chr(Result)<>p[2]) then goto make2;
     Result:=shortint(p[dist+3]);
     inc(p,4);
     until (Result=0) or (chr(Result)<>p[-1]);
   dec(p,3);
make2:
   inc(p);
make1:
   inc(p);
make:
   Result:=byte(Result)-byte(p[0]);
   end;

function StrComp_Sha_Pas_5_d(const str1, str2: pchar): integer;
var
  dist: integer;
  p: pchar;
label
  make, make1, make2;
begin;
   dist:=str1-str2;
   p:=str2;
   repeat;
     Result:=shortint(p[dist]);
     if (Result=0) or (chr(Result)<>p[0]) then goto make;
     Result:=shortint(p[dist+1]);
     if (Result=0) or (chr(Result)<>p[1]) then goto make1;
     Result:=shortint(p[dist+2]);
     if (Result=0) or (chr(Result)<>p[2]) then goto make2;
     Result:=shortint(p[dist+3]);
     inc(p,4);
     until (Result=0) or (chr(Result)<>p[-1]);
   dec(p,3);
make2:
   inc(p);
make1:
   inc(p);
make:
   Result:=byte(Result)-byte(p[0]);
   end;

function StrComp_Sha_IA32_7_a(const Str1, Str2: PChar): Integer;
asm
   sub   eax, edx
   jz    @ret
@loop:
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @stop
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @stop1
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @stop2
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @stop3
   add   edx, 4
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @stop
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @stop1
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @stop2
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @stop3
   add   edx, 4
   test  cl, cl
   jnz   @loop
@eq:
   xor   eax, eax
@ret:
   ret
@stop3:
   add   edx, 1
@stop2:
   add   edx, 1
@stop1:
   add   edx, 1
@stop:
   mov   eax, ecx
   movzx edx, [edx]
   sub   eax, edx
   end;

function StrComp_Sha_IA32_7_b(const Str1, Str2: PChar): Integer;
asm
   sub   eax, edx
   jz    @ret
@loop:
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @stop
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @stop1
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @stop2
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @stop3
   add   edx, 4
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @stop
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @stop1
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @stop2
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @stop3
   add   edx, 4
   test  cl, cl
   jnz   @loop
@eq:
   xor   eax, eax
@ret:
   ret
@stop3:
   add   edx, 1
@stop2:
   add   edx, 1
@stop1:
   add   edx, 1
@stop:
   mov   eax, ecx
   movzx edx, [edx]
   sub   eax, edx
   end;

function StrComp_Sha_IA32_7_c(const Str1, Str2: PChar): Integer;
asm
   sub   eax, edx
   jz    @ret
@loop:
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @stop
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @stop1
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @stop2
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @stop3
   add   edx, 4
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @stop
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @stop1
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @stop2
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @stop3
   add   edx, 4
   test  cl, cl
   jnz   @loop
@eq:
   xor   eax, eax
@ret:
   ret
@stop3:
   add   edx, 1
@stop2:
   add   edx, 1
@stop1:
   add   edx, 1
@stop:
   mov   eax, ecx
   movzx edx, [edx]
   sub   eax, edx
   end;

function StrComp_Sha_IA32_7_d(const Str1, Str2: PChar): Integer;
asm
   sub   eax, edx
   jz    @ret
@loop:
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @stop
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @stop1
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @stop2
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @stop3
   add   edx, 4
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @stop
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @stop1
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @stop2
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @stop3
   add   edx, 4
   test  cl, cl
   jnz   @loop
@eq:
   xor   eax, eax
@ret:
   ret
@stop3:
   add   edx, 1
@stop2:
   add   edx, 1
@stop1:
   add   edx, 1
@stop:
   mov   eax, ecx
   movzx edx, [edx]
   sub   eax, edx
   end;

function StrComp_Sha_IA32_8_a(const Str1, Str2: PChar): Integer;
asm
   sub   eax, edx
   jz    @ret
@loop:
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+4]
   cmp   cl, [edx+4]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+5]
   cmp   cl, [edx+5]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+6]
   cmp   cl, [edx+6]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+7]
   cmp   cl, [edx+7]
   jne   @ne
   add   edx, 8
   test  cl, cl
   jnz   @loop
@eq:
   xor   eax, eax
@ret:
   ret
@ne:
   mov   eax, -1
   jae   @ae
   ret
@ae:
   neg   eax
   end;

function StrComp_Sha_IA32_8_b(const Str1, Str2: PChar): Integer;
asm
   sub   eax, edx
   jz    @ret
@loop:
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+4]
   cmp   cl, [edx+4]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+5]
   cmp   cl, [edx+5]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+6]
   cmp   cl, [edx+6]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+7]
   cmp   cl, [edx+7]
   jne   @ne
   add   edx, 8
   test  cl, cl
   jnz   @loop
@eq:
   xor   eax, eax
@ret:
   ret
@ne:
   mov   eax, -1
   jae   @ae
   ret
@ae:
   neg   eax
   end;

function StrComp_Sha_IA32_8_c(const Str1, Str2: PChar): Integer;
asm
   sub   eax, edx
   jz    @ret
@loop:
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+4]
   cmp   cl, [edx+4]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+5]
   cmp   cl, [edx+5]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+6]
   cmp   cl, [edx+6]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+7]
   cmp   cl, [edx+7]
   jne   @ne
   add   edx, 8
   test  cl, cl
   jnz   @loop
@eq:
   xor   eax, eax
@ret:
   ret
@ne:
   mov   eax, -1
   jae   @ae
   ret
@ae:
   neg   eax
   end;

function StrComp_Sha_IA32_8_d(const Str1, Str2: PChar): Integer;
asm
   sub   eax, edx
   jz    @ret
@loop:
   movzx ecx, [eax+edx]
   cmp   cl, [edx]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+1]
   cmp   cl, [edx+1]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+2]
   cmp   cl, [edx+2]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+3]
   cmp   cl, [edx+3]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+4]
   cmp   cl, [edx+4]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+5]
   cmp   cl, [edx+5]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+6]
   cmp   cl, [edx+6]
   jne   @ne
   test  cl, cl
   jz    @eq
   movzx ecx, [eax+edx+7]
   cmp   cl, [edx+7]
   jne   @ne
   add   edx, 8
   test  cl, cl
   jnz   @loop
@eq:
   xor   eax, eax
@ret:
   ret
@ne:
   mov   eax, -1
   jae   @ae
   ret
@ae:
   neg   eax
   end;

initialization

 Filler1;

end.
