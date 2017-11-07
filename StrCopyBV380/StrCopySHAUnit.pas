unit StrCopySHAUnit;

interface

function StrCopy_Sha_Pas_1_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_Pas_1_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_Pas_1_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_Pas_1_d(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_2_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_2_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_2_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_2_d(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_3_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_3_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_3_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_3_d(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_4_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_4_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_4_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Sha_IA32_4_d(Dest: PChar; const Source: PChar): PChar;

implementation

function StrCopy_Sha_Pas_1_a(Dest: PChar; const Source: PChar): PChar;
var
  d: integer;
  ch: char;
begin
  d:=integer(Source);
  Result:=Dest;
  dec(d,integer(Dest));
  repeat
    ch:=Dest[d+00]; Dest[00]:=ch; if ch=#0 then break;
    ch:=Dest[d+01]; Dest[01]:=ch; if ch=#0 then break;
    ch:=Dest[d+02]; Dest[02]:=ch; if ch=#0 then break;
    ch:=Dest[d+03]; Dest[03]:=ch; if ch=#0 then break;
    ch:=Dest[d+04]; Dest[04]:=ch; if ch=#0 then break;
    ch:=Dest[d+05]; Dest[05]:=ch; if ch=#0 then break;
    ch:=Dest[d+06]; Dest[06]:=ch; if ch=#0 then break;
    ch:=Dest[d+07]; Dest[07]:=ch; if ch=#0 then break;
    ch:=Dest[d+08]; Dest[08]:=ch; if ch=#0 then break;
    ch:=Dest[d+09]; Dest[09]:=ch; if ch=#0 then break;
    ch:=Dest[d+10]; Dest[10]:=ch; if ch=#0 then break;
    ch:=Dest[d+11]; Dest[11]:=ch; if ch=#0 then break;
    ch:=Dest[d+12]; Dest[12]:=ch; if ch=#0 then break;
    ch:=Dest[d+13]; Dest[13]:=ch; if ch=#0 then break;
    ch:=Dest[d+14]; Dest[14]:=ch; if ch=#0 then break;
    ch:=Dest[d+15]; Dest[15]:=ch; if ch=#0 then break;
    ch:=Dest[d+16]; Dest[16]:=ch; if ch=#0 then break;
    ch:=Dest[d+17]; Dest[17]:=ch; if ch=#0 then break;
    ch:=Dest[d+18]; Dest[18]:=ch; if ch=#0 then break;
    ch:=Dest[d+19]; Dest[19]:=ch; if ch=#0 then break;
    ch:=Dest[d+20]; Dest[20]:=ch; if ch=#0 then break;
    ch:=Dest[d+21]; Dest[21]:=ch; if ch=#0 then break;
    ch:=Dest[d+22]; Dest[22]:=ch; if ch=#0 then break;
    ch:=Dest[d+23]; Dest[23]:=ch; if ch=#0 then break;
    ch:=Dest[d+24]; Dest[24]:=ch; if ch=#0 then break;
    ch:=Dest[d+25]; Dest[25]:=ch; if ch=#0 then break;
    ch:=Dest[d+26]; Dest[26]:=ch; if ch=#0 then break;
    ch:=Dest[d+27]; Dest[27]:=ch; if ch=#0 then break;
    ch:=Dest[d+28]; Dest[28]:=ch; if ch=#0 then break;
    ch:=Dest[d+29]; Dest[29]:=ch; if ch=#0 then break;
    ch:=Dest[d+30]; Dest[30]:=ch; if ch=#0 then break;
    ch:=Dest[d+31]; Dest[31]:=ch;
    inc(Dest,32);
  until ch=#0;
end;

function StrCopy_Sha_Pas_1_b(Dest: PChar; const Source: PChar): PChar;
var
  d: integer;
  ch: char;
begin
  d:=integer(Source);
  Result:=Dest;
  dec(d,integer(Dest));
  repeat
    ch:=Dest[d+00]; Dest[00]:=ch; if ch=#0 then break;
    ch:=Dest[d+01]; Dest[01]:=ch; if ch=#0 then break;
    ch:=Dest[d+02]; Dest[02]:=ch; if ch=#0 then break;
    ch:=Dest[d+03]; Dest[03]:=ch; if ch=#0 then break;
    ch:=Dest[d+04]; Dest[04]:=ch; if ch=#0 then break;
    ch:=Dest[d+05]; Dest[05]:=ch; if ch=#0 then break;
    ch:=Dest[d+06]; Dest[06]:=ch; if ch=#0 then break;
    ch:=Dest[d+07]; Dest[07]:=ch; if ch=#0 then break;
    ch:=Dest[d+08]; Dest[08]:=ch; if ch=#0 then break;
    ch:=Dest[d+09]; Dest[09]:=ch; if ch=#0 then break;
    ch:=Dest[d+10]; Dest[10]:=ch; if ch=#0 then break;
    ch:=Dest[d+11]; Dest[11]:=ch; if ch=#0 then break;
    ch:=Dest[d+12]; Dest[12]:=ch; if ch=#0 then break;
    ch:=Dest[d+13]; Dest[13]:=ch; if ch=#0 then break;
    ch:=Dest[d+14]; Dest[14]:=ch; if ch=#0 then break;
    ch:=Dest[d+15]; Dest[15]:=ch; if ch=#0 then break;
    ch:=Dest[d+16]; Dest[16]:=ch; if ch=#0 then break;
    ch:=Dest[d+17]; Dest[17]:=ch; if ch=#0 then break;
    ch:=Dest[d+18]; Dest[18]:=ch; if ch=#0 then break;
    ch:=Dest[d+19]; Dest[19]:=ch; if ch=#0 then break;
    ch:=Dest[d+20]; Dest[20]:=ch; if ch=#0 then break;
    ch:=Dest[d+21]; Dest[21]:=ch; if ch=#0 then break;
    ch:=Dest[d+22]; Dest[22]:=ch; if ch=#0 then break;
    ch:=Dest[d+23]; Dest[23]:=ch; if ch=#0 then break;
    ch:=Dest[d+24]; Dest[24]:=ch; if ch=#0 then break;
    ch:=Dest[d+25]; Dest[25]:=ch; if ch=#0 then break;
    ch:=Dest[d+26]; Dest[26]:=ch; if ch=#0 then break;
    ch:=Dest[d+27]; Dest[27]:=ch; if ch=#0 then break;
    ch:=Dest[d+28]; Dest[28]:=ch; if ch=#0 then break;
    ch:=Dest[d+29]; Dest[29]:=ch; if ch=#0 then break;
    ch:=Dest[d+30]; Dest[30]:=ch; if ch=#0 then break;
    ch:=Dest[d+31]; Dest[31]:=ch;
    inc(Dest,32);
  until ch=#0;
end;

function StrCopy_Sha_Pas_1_c(Dest: PChar; const Source: PChar): PChar;
var
  d: integer;
  ch: char;
begin
  d:=integer(Source);
  Result:=Dest;
  dec(d,integer(Dest));
  repeat
    ch:=Dest[d+00]; Dest[00]:=ch; if ch=#0 then break;
    ch:=Dest[d+01]; Dest[01]:=ch; if ch=#0 then break;
    ch:=Dest[d+02]; Dest[02]:=ch; if ch=#0 then break;
    ch:=Dest[d+03]; Dest[03]:=ch; if ch=#0 then break;
    ch:=Dest[d+04]; Dest[04]:=ch; if ch=#0 then break;
    ch:=Dest[d+05]; Dest[05]:=ch; if ch=#0 then break;
    ch:=Dest[d+06]; Dest[06]:=ch; if ch=#0 then break;
    ch:=Dest[d+07]; Dest[07]:=ch; if ch=#0 then break;
    ch:=Dest[d+08]; Dest[08]:=ch; if ch=#0 then break;
    ch:=Dest[d+09]; Dest[09]:=ch; if ch=#0 then break;
    ch:=Dest[d+10]; Dest[10]:=ch; if ch=#0 then break;
    ch:=Dest[d+11]; Dest[11]:=ch; if ch=#0 then break;
    ch:=Dest[d+12]; Dest[12]:=ch; if ch=#0 then break;
    ch:=Dest[d+13]; Dest[13]:=ch; if ch=#0 then break;
    ch:=Dest[d+14]; Dest[14]:=ch; if ch=#0 then break;
    ch:=Dest[d+15]; Dest[15]:=ch; if ch=#0 then break;
    ch:=Dest[d+16]; Dest[16]:=ch; if ch=#0 then break;
    ch:=Dest[d+17]; Dest[17]:=ch; if ch=#0 then break;
    ch:=Dest[d+18]; Dest[18]:=ch; if ch=#0 then break;
    ch:=Dest[d+19]; Dest[19]:=ch; if ch=#0 then break;
    ch:=Dest[d+20]; Dest[20]:=ch; if ch=#0 then break;
    ch:=Dest[d+21]; Dest[21]:=ch; if ch=#0 then break;
    ch:=Dest[d+22]; Dest[22]:=ch; if ch=#0 then break;
    ch:=Dest[d+23]; Dest[23]:=ch; if ch=#0 then break;
    ch:=Dest[d+24]; Dest[24]:=ch; if ch=#0 then break;
    ch:=Dest[d+25]; Dest[25]:=ch; if ch=#0 then break;
    ch:=Dest[d+26]; Dest[26]:=ch; if ch=#0 then break;
    ch:=Dest[d+27]; Dest[27]:=ch; if ch=#0 then break;
    ch:=Dest[d+28]; Dest[28]:=ch; if ch=#0 then break;
    ch:=Dest[d+29]; Dest[29]:=ch; if ch=#0 then break;
    ch:=Dest[d+30]; Dest[30]:=ch; if ch=#0 then break;
    ch:=Dest[d+31]; Dest[31]:=ch;
    inc(Dest,32);
  until ch=#0;
end;

function StrCopy_Sha_Pas_1_d(Dest: PChar; const Source: PChar): PChar;
var
  d: integer;
  ch: char;
begin
  d:=integer(Source);
  Result:=Dest;
  dec(d,integer(Dest));
  repeat
    ch:=Dest[d+00]; Dest[00]:=ch; if ch=#0 then break;
    ch:=Dest[d+01]; Dest[01]:=ch; if ch=#0 then break;
    ch:=Dest[d+02]; Dest[02]:=ch; if ch=#0 then break;
    ch:=Dest[d+03]; Dest[03]:=ch; if ch=#0 then break;
    ch:=Dest[d+04]; Dest[04]:=ch; if ch=#0 then break;
    ch:=Dest[d+05]; Dest[05]:=ch; if ch=#0 then break;
    ch:=Dest[d+06]; Dest[06]:=ch; if ch=#0 then break;
    ch:=Dest[d+07]; Dest[07]:=ch; if ch=#0 then break;
    ch:=Dest[d+08]; Dest[08]:=ch; if ch=#0 then break;
    ch:=Dest[d+09]; Dest[09]:=ch; if ch=#0 then break;
    ch:=Dest[d+10]; Dest[10]:=ch; if ch=#0 then break;
    ch:=Dest[d+11]; Dest[11]:=ch; if ch=#0 then break;
    ch:=Dest[d+12]; Dest[12]:=ch; if ch=#0 then break;
    ch:=Dest[d+13]; Dest[13]:=ch; if ch=#0 then break;
    ch:=Dest[d+14]; Dest[14]:=ch; if ch=#0 then break;
    ch:=Dest[d+15]; Dest[15]:=ch; if ch=#0 then break;
    ch:=Dest[d+16]; Dest[16]:=ch; if ch=#0 then break;
    ch:=Dest[d+17]; Dest[17]:=ch; if ch=#0 then break;
    ch:=Dest[d+18]; Dest[18]:=ch; if ch=#0 then break;
    ch:=Dest[d+19]; Dest[19]:=ch; if ch=#0 then break;
    ch:=Dest[d+20]; Dest[20]:=ch; if ch=#0 then break;
    ch:=Dest[d+21]; Dest[21]:=ch; if ch=#0 then break;
    ch:=Dest[d+22]; Dest[22]:=ch; if ch=#0 then break;
    ch:=Dest[d+23]; Dest[23]:=ch; if ch=#0 then break;
    ch:=Dest[d+24]; Dest[24]:=ch; if ch=#0 then break;
    ch:=Dest[d+25]; Dest[25]:=ch; if ch=#0 then break;
    ch:=Dest[d+26]; Dest[26]:=ch; if ch=#0 then break;
    ch:=Dest[d+27]; Dest[27]:=ch; if ch=#0 then break;
    ch:=Dest[d+28]; Dest[28]:=ch; if ch=#0 then break;
    ch:=Dest[d+29]; Dest[29]:=ch; if ch=#0 then break;
    ch:=Dest[d+30]; Dest[30]:=ch; if ch=#0 then break;
    ch:=Dest[d+31]; Dest[31]:=ch;
    inc(Dest,32);
  until ch=#0;
end;

function StrCopy_Sha_IA32_2_a(Dest: PChar; const Source: PChar): PChar;
asm
  push eax;
  sub edx,eax;
@loop:
  movzx ecx,[eax+edx+00]; test cl,cl; mov [eax+00],cl; jz @ret;
  movzx ecx,[eax+edx+01]; test cl,cl; mov [eax+01],cl; jz @ret;
  movzx ecx,[eax+edx+02]; test cl,cl; mov [eax+02],cl; jz @ret;
  movzx ecx,[eax+edx+03]; test cl,cl; mov [eax+03],cl; jz @ret;
  movzx ecx,[eax+edx+04]; test cl,cl; mov [eax+04],cl; jz @ret;
  movzx ecx,[eax+edx+05]; test cl,cl; mov [eax+05],cl; jz @ret;
  movzx ecx,[eax+edx+06]; test cl,cl; mov [eax+06],cl; jz @ret;
  movzx ecx,[eax+edx+07]; test cl,cl; mov [eax+07],cl; jz @ret;
  movzx ecx,[eax+edx+08]; test cl,cl; mov [eax+08],cl; jz @ret;
  movzx ecx,[eax+edx+09]; test cl,cl; mov [eax+09],cl; jz @ret;
  movzx ecx,[eax+edx+10]; test cl,cl; mov [eax+10],cl; jz @ret;
  movzx ecx,[eax+edx+11]; test cl,cl; mov [eax+11],cl; jz @ret;
  movzx ecx,[eax+edx+12]; test cl,cl; mov [eax+12],cl; jz @ret;
  movzx ecx,[eax+edx+13]; test cl,cl; mov [eax+13],cl; jz @ret;
  movzx ecx,[eax+edx+14]; test cl,cl; mov [eax+14],cl; jz @ret;
  movzx ecx,[eax+edx+15]; test cl,cl; mov [eax+15],cl; jz @ret;
  movzx ecx,[eax+edx+16]; test cl,cl; mov [eax+16],cl; jz @ret;
  movzx ecx,[eax+edx+17]; test cl,cl; mov [eax+17],cl; jz @ret;
  movzx ecx,[eax+edx+18]; test cl,cl; mov [eax+18],cl; jz @ret;
  movzx ecx,[eax+edx+19]; test cl,cl; mov [eax+19],cl; jz @ret;
  movzx ecx,[eax+edx+20]; test cl,cl; mov [eax+20],cl; jz @ret;
  movzx ecx,[eax+edx+21]; test cl,cl; mov [eax+21],cl; jz @ret;
  movzx ecx,[eax+edx+22]; test cl,cl; mov [eax+22],cl; jz @ret;
  movzx ecx,[eax+edx+23]; test cl,cl; mov [eax+23],cl; jz @ret;
  movzx ecx,[eax+edx+24]; test cl,cl; mov [eax+24],cl; jz @ret;
  movzx ecx,[eax+edx+25]; test cl,cl; mov [eax+25],cl; jz @ret;
  movzx ecx,[eax+edx+26]; test cl,cl; mov [eax+26],cl; jz @ret;
  movzx ecx,[eax+edx+27]; test cl,cl; mov [eax+27],cl; jz @ret;
  movzx ecx,[eax+edx+28]; test cl,cl; mov [eax+28],cl; jz @ret;
  movzx ecx,[eax+edx+29]; test cl,cl; mov [eax+29],cl; jz @ret;
  movzx ecx,[eax+edx+30]; test cl,cl; mov [eax+30],cl; jz @ret;
  movzx ecx,[eax+edx+31]; mov [eax+31],cl;
  add eax,32;
  test cl,cl; jnz @loop;
@ret:
  pop eax;
end;

procedure Filler1;
asm
 nop
end;

function StrCopy_Sha_IA32_2_b(Dest: PChar; const Source: PChar): PChar;
asm
  push eax;
  sub edx,eax;
@loop:
  movzx ecx,[eax+edx+00]; test cl,cl; mov [eax+00],cl; jz @ret;
  movzx ecx,[eax+edx+01]; test cl,cl; mov [eax+01],cl; jz @ret;
  movzx ecx,[eax+edx+02]; test cl,cl; mov [eax+02],cl; jz @ret;
  movzx ecx,[eax+edx+03]; test cl,cl; mov [eax+03],cl; jz @ret;
  movzx ecx,[eax+edx+04]; test cl,cl; mov [eax+04],cl; jz @ret;
  movzx ecx,[eax+edx+05]; test cl,cl; mov [eax+05],cl; jz @ret;
  movzx ecx,[eax+edx+06]; test cl,cl; mov [eax+06],cl; jz @ret;
  movzx ecx,[eax+edx+07]; test cl,cl; mov [eax+07],cl; jz @ret;
  movzx ecx,[eax+edx+08]; test cl,cl; mov [eax+08],cl; jz @ret;
  movzx ecx,[eax+edx+09]; test cl,cl; mov [eax+09],cl; jz @ret;
  movzx ecx,[eax+edx+10]; test cl,cl; mov [eax+10],cl; jz @ret;
  movzx ecx,[eax+edx+11]; test cl,cl; mov [eax+11],cl; jz @ret;
  movzx ecx,[eax+edx+12]; test cl,cl; mov [eax+12],cl; jz @ret;
  movzx ecx,[eax+edx+13]; test cl,cl; mov [eax+13],cl; jz @ret;
  movzx ecx,[eax+edx+14]; test cl,cl; mov [eax+14],cl; jz @ret;
  movzx ecx,[eax+edx+15]; test cl,cl; mov [eax+15],cl; jz @ret;
  movzx ecx,[eax+edx+16]; test cl,cl; mov [eax+16],cl; jz @ret;
  movzx ecx,[eax+edx+17]; test cl,cl; mov [eax+17],cl; jz @ret;
  movzx ecx,[eax+edx+18]; test cl,cl; mov [eax+18],cl; jz @ret;
  movzx ecx,[eax+edx+19]; test cl,cl; mov [eax+19],cl; jz @ret;
  movzx ecx,[eax+edx+20]; test cl,cl; mov [eax+20],cl; jz @ret;
  movzx ecx,[eax+edx+21]; test cl,cl; mov [eax+21],cl; jz @ret;
  movzx ecx,[eax+edx+22]; test cl,cl; mov [eax+22],cl; jz @ret;
  movzx ecx,[eax+edx+23]; test cl,cl; mov [eax+23],cl; jz @ret;
  movzx ecx,[eax+edx+24]; test cl,cl; mov [eax+24],cl; jz @ret;
  movzx ecx,[eax+edx+25]; test cl,cl; mov [eax+25],cl; jz @ret;
  movzx ecx,[eax+edx+26]; test cl,cl; mov [eax+26],cl; jz @ret;
  movzx ecx,[eax+edx+27]; test cl,cl; mov [eax+27],cl; jz @ret;
  movzx ecx,[eax+edx+28]; test cl,cl; mov [eax+28],cl; jz @ret;
  movzx ecx,[eax+edx+29]; test cl,cl; mov [eax+29],cl; jz @ret;
  movzx ecx,[eax+edx+30]; test cl,cl; mov [eax+30],cl; jz @ret;
  movzx ecx,[eax+edx+31]; mov [eax+31],cl;
  add eax,32;
  test cl,cl; jnz @loop;
@ret:
  pop eax;
end;

procedure Filler2;
asm
 nop
end;

function StrCopy_Sha_IA32_2_c(Dest: PChar; const Source: PChar): PChar;
asm
  push eax;
  sub edx,eax;
@loop:
  movzx ecx,[eax+edx+00]; test cl,cl; mov [eax+00],cl; jz @ret;
  movzx ecx,[eax+edx+01]; test cl,cl; mov [eax+01],cl; jz @ret;
  movzx ecx,[eax+edx+02]; test cl,cl; mov [eax+02],cl; jz @ret;
  movzx ecx,[eax+edx+03]; test cl,cl; mov [eax+03],cl; jz @ret;
  movzx ecx,[eax+edx+04]; test cl,cl; mov [eax+04],cl; jz @ret;
  movzx ecx,[eax+edx+05]; test cl,cl; mov [eax+05],cl; jz @ret;
  movzx ecx,[eax+edx+06]; test cl,cl; mov [eax+06],cl; jz @ret;
  movzx ecx,[eax+edx+07]; test cl,cl; mov [eax+07],cl; jz @ret;
  movzx ecx,[eax+edx+08]; test cl,cl; mov [eax+08],cl; jz @ret;
  movzx ecx,[eax+edx+09]; test cl,cl; mov [eax+09],cl; jz @ret;
  movzx ecx,[eax+edx+10]; test cl,cl; mov [eax+10],cl; jz @ret;
  movzx ecx,[eax+edx+11]; test cl,cl; mov [eax+11],cl; jz @ret;
  movzx ecx,[eax+edx+12]; test cl,cl; mov [eax+12],cl; jz @ret;
  movzx ecx,[eax+edx+13]; test cl,cl; mov [eax+13],cl; jz @ret;
  movzx ecx,[eax+edx+14]; test cl,cl; mov [eax+14],cl; jz @ret;
  movzx ecx,[eax+edx+15]; test cl,cl; mov [eax+15],cl; jz @ret;
  movzx ecx,[eax+edx+16]; test cl,cl; mov [eax+16],cl; jz @ret;
  movzx ecx,[eax+edx+17]; test cl,cl; mov [eax+17],cl; jz @ret;
  movzx ecx,[eax+edx+18]; test cl,cl; mov [eax+18],cl; jz @ret;
  movzx ecx,[eax+edx+19]; test cl,cl; mov [eax+19],cl; jz @ret;
  movzx ecx,[eax+edx+20]; test cl,cl; mov [eax+20],cl; jz @ret;
  movzx ecx,[eax+edx+21]; test cl,cl; mov [eax+21],cl; jz @ret;
  movzx ecx,[eax+edx+22]; test cl,cl; mov [eax+22],cl; jz @ret;
  movzx ecx,[eax+edx+23]; test cl,cl; mov [eax+23],cl; jz @ret;
  movzx ecx,[eax+edx+24]; test cl,cl; mov [eax+24],cl; jz @ret;
  movzx ecx,[eax+edx+25]; test cl,cl; mov [eax+25],cl; jz @ret;
  movzx ecx,[eax+edx+26]; test cl,cl; mov [eax+26],cl; jz @ret;
  movzx ecx,[eax+edx+27]; test cl,cl; mov [eax+27],cl; jz @ret;
  movzx ecx,[eax+edx+28]; test cl,cl; mov [eax+28],cl; jz @ret;
  movzx ecx,[eax+edx+29]; test cl,cl; mov [eax+29],cl; jz @ret;
  movzx ecx,[eax+edx+30]; test cl,cl; mov [eax+30],cl; jz @ret;
  movzx ecx,[eax+edx+31]; mov [eax+31],cl;
  add eax,32;
  test cl,cl; jnz @loop;
@ret:
  pop eax;
end;

procedure Filler3;
asm
 nop
end;

function StrCopy_Sha_IA32_2_d(Dest: PChar; const Source: PChar): PChar;
asm
  push eax;
  sub edx,eax;
@loop:
  movzx ecx,[eax+edx+00]; test cl,cl; mov [eax+00],cl; jz @ret;
  movzx ecx,[eax+edx+01]; test cl,cl; mov [eax+01],cl; jz @ret;
  movzx ecx,[eax+edx+02]; test cl,cl; mov [eax+02],cl; jz @ret;
  movzx ecx,[eax+edx+03]; test cl,cl; mov [eax+03],cl; jz @ret;
  movzx ecx,[eax+edx+04]; test cl,cl; mov [eax+04],cl; jz @ret;
  movzx ecx,[eax+edx+05]; test cl,cl; mov [eax+05],cl; jz @ret;
  movzx ecx,[eax+edx+06]; test cl,cl; mov [eax+06],cl; jz @ret;
  movzx ecx,[eax+edx+07]; test cl,cl; mov [eax+07],cl; jz @ret;
  movzx ecx,[eax+edx+08]; test cl,cl; mov [eax+08],cl; jz @ret;
  movzx ecx,[eax+edx+09]; test cl,cl; mov [eax+09],cl; jz @ret;
  movzx ecx,[eax+edx+10]; test cl,cl; mov [eax+10],cl; jz @ret;
  movzx ecx,[eax+edx+11]; test cl,cl; mov [eax+11],cl; jz @ret;
  movzx ecx,[eax+edx+12]; test cl,cl; mov [eax+12],cl; jz @ret;
  movzx ecx,[eax+edx+13]; test cl,cl; mov [eax+13],cl; jz @ret;
  movzx ecx,[eax+edx+14]; test cl,cl; mov [eax+14],cl; jz @ret;
  movzx ecx,[eax+edx+15]; test cl,cl; mov [eax+15],cl; jz @ret;
  movzx ecx,[eax+edx+16]; test cl,cl; mov [eax+16],cl; jz @ret;
  movzx ecx,[eax+edx+17]; test cl,cl; mov [eax+17],cl; jz @ret;
  movzx ecx,[eax+edx+18]; test cl,cl; mov [eax+18],cl; jz @ret;
  movzx ecx,[eax+edx+19]; test cl,cl; mov [eax+19],cl; jz @ret;
  movzx ecx,[eax+edx+20]; test cl,cl; mov [eax+20],cl; jz @ret;
  movzx ecx,[eax+edx+21]; test cl,cl; mov [eax+21],cl; jz @ret;
  movzx ecx,[eax+edx+22]; test cl,cl; mov [eax+22],cl; jz @ret;
  movzx ecx,[eax+edx+23]; test cl,cl; mov [eax+23],cl; jz @ret;
  movzx ecx,[eax+edx+24]; test cl,cl; mov [eax+24],cl; jz @ret;
  movzx ecx,[eax+edx+25]; test cl,cl; mov [eax+25],cl; jz @ret;
  movzx ecx,[eax+edx+26]; test cl,cl; mov [eax+26],cl; jz @ret;
  movzx ecx,[eax+edx+27]; test cl,cl; mov [eax+27],cl; jz @ret;
  movzx ecx,[eax+edx+28]; test cl,cl; mov [eax+28],cl; jz @ret;
  movzx ecx,[eax+edx+29]; test cl,cl; mov [eax+29],cl; jz @ret;
  movzx ecx,[eax+edx+30]; test cl,cl; mov [eax+30],cl; jz @ret;
  movzx ecx,[eax+edx+31]; mov [eax+31],cl;
  add eax,32;
  test cl,cl; jnz @loop;
@ret:
  pop eax;
end;

function StrCopy_Sha_IA32_3_a(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

function StrCopy_Sha_IA32_3_b(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

function StrCopy_Sha_IA32_3_c(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

function StrCopy_Sha_IA32_3_d(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

function StrCopy_Sha_IA32_4_a(Dest: PChar; const Source: PChar): PChar;
asm
  sub   edx, eax
  test  eax, 1
  push  eax
  jz    @loop
  movzx ecx, byte ptr[eax+edx]
  mov   [eax], cl
  test  ecx, ecx
  jz    @ret
  inc   eax
@loop:
  movzx ecx, byte ptr[eax+edx]
  test  ecx, ecx
  jz    @move0
  movzx ecx, word ptr[eax+edx]
  mov   [eax], cx
  add   eax, 2
  cmp   ecx, 255
  ja    @loop
@ret:
  pop   eax
  ret
@move0:
  mov   [eax], cl
  pop   eax
end;

procedure Filler4;
asm
 nop
end;

function StrCopy_Sha_IA32_4_b(Dest: PChar; const Source: PChar): PChar;
asm
  sub   edx, eax
  test  eax, 1
  push  eax
  jz    @loop
  movzx ecx, byte ptr[eax+edx]
  mov   [eax], cl
  test  ecx, ecx
  jz    @ret
  inc   eax
@loop:
  movzx ecx, byte ptr[eax+edx]
  test  ecx, ecx
  jz    @move0
  movzx ecx, word ptr[eax+edx]
  mov   [eax], cx
  add   eax, 2
  cmp   ecx, 255
  ja    @loop
@ret:
  pop   eax
  ret
@move0:
  mov   [eax], cl
  pop   eax
end;

procedure Filler5;
asm
 nop
end;

function StrCopy_Sha_IA32_4_c(Dest: PChar; const Source: PChar): PChar;
asm
  sub   edx, eax
  test  eax, 1
  push  eax
  jz    @loop
  movzx ecx, byte ptr[eax+edx]
  mov   [eax], cl
  test  ecx, ecx
  jz    @ret
  inc   eax
@loop:
  movzx ecx, byte ptr[eax+edx]
  test  ecx, ecx
  jz    @move0
  movzx ecx, word ptr[eax+edx]
  mov   [eax], cx
  add   eax, 2
  cmp   ecx, 255
  ja    @loop
@ret:
  pop   eax
  ret
@move0:
  mov   [eax], cl
  pop   eax
end;

procedure Filler6;
asm
 nop
end;

function StrCopy_Sha_IA32_4_d(Dest: PChar; const Source: PChar): PChar;
asm
  sub   edx, eax
  test  eax, 1
  push  eax
  jz    @loop
  movzx ecx, byte ptr[eax+edx]
  mov   [eax], cl
  test  ecx, ecx
  jz    @ret
  inc   eax
@loop:
  movzx ecx, byte ptr[eax+edx]
  test  ecx, ecx
  jz    @move0
  movzx ecx, word ptr[eax+edx]
  mov   [eax], cx
  add   eax, 2
  cmp   ecx, 255
  ja    @loop
@ret:
  pop   eax
  ret
@move0:
  mov   [eax], cl
  pop   eax
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;

end.
