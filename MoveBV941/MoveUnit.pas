unit MoveUnit;

//This unit contains Move function implementations

interface

procedure Move_RTL_PAS_1( const Source; var Dest; count : Integer );
procedure Move_RL_IA32_1(const Source; var Dest; Count: Integer);

implementation

uses MainUnit, SysUtils;

procedure Move_RTL_PAS_1( const Source; var Dest; count : Integer );
var
  S, D: PChar;
  I: Integer;
begin
  S := PChar(@Source);
  D := PChar(@Dest);
  if S = D then Exit;
  if Cardinal(D) > Cardinal(S) then
    for I := count-1 downto 0 do
      D[I] := S[I]
  else
    for I := 0 to count-1 do
      D[I] := S[I];
end;


//Using MMX

procedure AlignedFwdMoveRLDKC1(const Source,Dest;Count:Integer);
// assumes divisible by 16 and Count>16
asm
  lea eax,[eax+ecx]
  lea edx,[edx+ecx]
  neg ecx
  @Loop:
  movq    mm0,[EAX+ecx]
  movq    [EDX+ecx], mm0
  movq    mm1,[EAX+ecx+8]
  movq    [EDX+ecx+8], mm1
  add     ECX,16
  JNZ     @Loop
  emms
end;

procedure FwdMoveRLDKC1(const Source; var Dest; Count: integer);
// assume that count is >=0
asm
  push ebx
@move:
  cmp ecx,20
  jge @20Plus
  // tiny move
  lea ebx,[@16MinusTable+ecx*4]
  jmp [ebx]
@20plus:
  cmp ecx,256
  jge @256Plus
  push edi

  push [eax]  // load first 4
  push edx

  push ecx
  mov ecx,eax
  add ecx,3
  and ecx,-4
  sub ecx,eax

  add eax,ecx
  add edx,ecx
  mov ebx,ecx
  pop ecx
  sub ecx,ebx
  // we now have a 4 byte aligned move

  mov edi,16
@16PLoop:
  mov ebx,[eax+edi-16]
  mov [edx+edi-16],ebx
  mov ebx,[eax+edi-12]
  mov [edx+edi-12],ebx
  mov ebx,[eax+edi-8]
  mov [edx+edi-8],ebx
  mov ebx,[eax+edi-4]
  mov [edx+edi-4],ebx
  add edi,16
  cmp ecx,edi
  jge @16PLoop
  sub edi,16
  sub ecx,edi
  add eax,edi
  add edx,edi

  pop edi
  pop [edi]

  pop edi
  lea ebx,[@16MinusTable+ecx*4]
  jmp [ebx]
@256plus:  // big move
  mov ebx,ecx
  mov ecx,edx
  add ecx,15
  and ecx,-16
  push ecx
  sub ecx,edx
  push ecx
  call @TinyMove  // 16 byte align front
  // relies on eax and edx still being intact
  pop ecx
  add eax,ecx
  sub ebx,ecx
  pop edx
  mov ecx,ebx
  // we now have a 16 byte aligned move
  // align back end
  and ecx,-16
  sub ebx,ecx
  push eax
  push edx
  push ecx
  call AlignedFwdMoveRLDKC1
  pop ecx
  pop edx
  pop eax
  add edx,ecx
  add eax,ecx
  mov ecx,ebx
  lea ebx,[@16MinusTable+ecx*4]
  jmp [ebx]

@TinyMove:
  push ebx
  lea ebx,[@16MinusTable+ecx*4]
  jmp [ebx]

@16MinusTable:
  dd @0
  dd @1
  dd @2
  dd @3
  dd @4
  dd @5
  dd @6
  dd @7
  dd @8
  dd @9
  dd @A
  dd @B
  dd @C
  dd @D
  dd @E
  dd @F
  dd @10
  dd @11
  dd @12
  dd @13

@13:
  mov bl,[eax+ecx-$13+$0]  // source[count-15+0]
  mov [edx+ecx-$13+$0],bl
@12:
  mov bl,[eax+ecx-$13+$1]  // source[count-15+1]
  mov [edx+ecx-$13+$1],bl
@11:
  mov bl,[eax+ecx-$13+$2]  // source[count-15+2]
  mov [edx+ecx-$13+$2],bl
@10:
  mov ebx,[eax+ecx-$13+$3]  // source[count-15+3]
  mov [edx+ecx-$13+$3],ebx
  mov ebx,[eax+ecx-$13+$7]  // source[count-15+7]
  mov [edx+ecx-$13+$7],ebx
  mov ebx,[eax+ecx-$13+$b]  // source[count-15+b]
  mov [edx+ecx-$13+$b],ebx
  mov ebx,[eax+ecx-$13+$f]  // source[count-15+b]
  mov [edx+ecx-$13+$f],ebx
  pop ebx
  ret
@F:
  mov bl,[eax+ecx-$F+$0]  // source[count-15+0]
  mov [edx+ecx-$F+$0],bl
@E:
  mov bl,[eax+ecx-$F+$1]  // source[count-15+1]
  mov [edx+ecx-$F+$1],bl
@D:
  mov bl,[eax+ecx-$F+$2]  // source[count-15+2]
  mov [edx+ecx-$F+$2],bl
@C:
  mov ebx,[eax+ecx-$F+$3]  // source[count-15+3]
  mov [edx+ecx-$F+$3],ebx
  mov ebx,[eax+ecx-$F+$7]  // source[count-15+7]
  mov [edx+ecx-$F+$7],ebx
  mov ebx,[eax+ecx-$F+$b]  // source[count-15+b]
  mov [edx+ecx-$F+$b],ebx
  pop ebx
  ret
@B:
  mov bl,[eax+ecx-$F+$4]  // source[count-15+4]
  mov [edx+ecx-$F+$4],bl     //mov [edx+ecx-$F+$5],bl DKC
@A:
  mov bl,[eax+ecx-$F+$5]  // source[count-15+5]
  mov [edx+ecx-$F+$5],bl
@9:
  mov bl,[eax+ecx-$F+$6]  // source[count-15+6]
  mov [edx+ecx-$F+$6],bl
@8:
  mov ebx,[eax+ecx-$F+$7]  // source[count-15+7]
  mov [edx+ecx-$F+$7],ebx
  mov ebx,[eax+ecx-$F+$b]  // source[count-15+b]
  mov [edx+ecx-$F+$b],ebx
  pop ebx
  ret
@7:
  mov bl,[eax+ecx-$F+$8]  // source[count-15+8]
  mov [edx+ecx-$F+$8],bl
@6:
  mov bl,[eax+ecx-$F+$9]  // source[count-15+9]
  mov [edx+ecx-$F+$9],bl
@5:
  mov bl,[eax+ecx-$F+$A]  // source[count-15+a]
  mov [edx+ecx-$F+$A],bl
@4:
  mov ebx,[eax+ecx-$F+$b]  // source[count-15+b]
  mov [edx+ecx-$F+$b],ebx
  pop ebx
  ret
@3:
  mov bl,[eax+ecx-$F+$C]  // source[count-15+c]
  mov [edx+ecx-$F+$C],bl
@2:
  mov bl,[eax+ecx-$F+$D]  // source[count-15+d]
  mov [edx+ecx-$F+$D],bl
@1:
  mov bl,[eax+ecx-$F+$E]  // source[count-15+e]
  mov [edx+ecx-$F+$E],bl
@0:
  pop ebx
end;

procedure RevMoveRLDKC1(const Source; var Dest; Count: Integer);
asm
  cmp ecx,20
  jge @20Plus
  lea ecx,[@table+ecx*4]
  jmp [ecx]
@13:
  mov cl,[eax+$12]  // source[18]
  mov [edx+$12],cl
@12:
  mov cl,[eax+$11]  // source[17]
  mov [edx+$11],cl
@11:
  mov cl,[eax+$10]  // source[16]
  mov [edx+$10],cl
@10:
  mov cl,[eax+$F]  // source[15]
  mov [edx+$F],cl
@F:
  mov cl,[eax+$E]  // source[14]
  mov [edx+$E],cl
@E:
  mov cl,[eax+$D]  // source[13]
  mov [edx+$D],cl
@D:
  mov cl,[eax+$C]  // source[12]
  mov [edx+$C],cl
@C:
  mov cl,[eax+$B]  // source[11]
  mov [edx+$B],cl
@B:
  mov cl,[eax+$A]  // source[10]
  mov [edx+$A],cl
@A:
  mov cl,[eax+$9]  // source[9]
  mov [edx+$9],cl
@9:
  mov cl,[eax+$8]  // source[8]
  mov [edx+$8],cl
@8:
  mov cl,[eax+$7]  // source[7]
  mov [edx+$7],cl
@7:
  mov cl,[eax+$6]  // source[6]
  mov [edx+$6],cl
@6:
  mov cl,[eax+$5]  // source[5]
  mov [edx+$5],cl
@5:
  mov cl,[eax+$4]  // source[4]
  mov [edx+$4],cl
@4:
  mov cl,[eax+$3]  // source[3]
  mov [edx+$3],cl
@3:
  mov cl,[eax+$2]  // source[2]
  mov [edx+$2],cl
@2:
  mov cl,[eax+$1]  // source[1]
  mov [edx+$1],cl
@1:
  mov cl,[eax+$0]  // source[0]
  mov [edx+$0],cl
@0:
  ret
@table:
  dd @0
  dd @1
  dd @2
  dd @3
  dd @4
  dd @5
  dd @6
  dd @7
  dd @8
  dd @9
  dd @A
  dd @B
  dd @C
  dd @D
  dd @E
  dd @F
  dd @10;
  dd @11;
  dd @12;
  dd @13;
@20plus:
// split Fwd and rev moves
  // indyCount:=dest-source
  // if indyCount<16
  //    jmp  @RevMove(source,dest,count)// just do it all backwards
  // overlapCount:=count-indyCount
  // call FwdMove(source+ovlp,dest+ovlp,indyCount)
  // call @RevMove(source,dest,overlapcount)
  push esi
  push edi
  push ebx
  push ebp
  mov edi,edx
  mov esi,eax
  mov ebx,ecx

  mov ebp,edx
  sub ebp,eax
  cmp ebp,256
  // edx,edi = orig dest
  // eax,esi = orig src
  // ecx,ebx = orig len
  // ebp = free len
  jle @RevMove
// split fwd and rev
  sub ebx,ebp
  mov ecx,ebp
  add eax,ebx
  add edx,ebx
  // edi = orig dest
  // esi = orig src
  // ebx = ovlp len
  // ecx,ebp = free len
  // edx = ovlp dest
  // eax = ovlp src
  call FwdMoveRLDKC1
  // edi = orig dest
  // esi = orig src
  // ebx = ovlp len
  // ebp = empty
  mov eax,esi
  mov edx,edi
  mov ecx,ebx
  cmp ecx,20
  jl @TinyMove

@RevMove:
  // eax,esi = source
  // edx,edi = dest
  // ecx,ebx = count
  mov ebp,[eax+ecx-4] // get last dword

  lea esi,[eax+ecx]  // align reads on dword boundry
  and esi,3
  sub ecx,esi
  sub ecx,16
@Loop:
  mov esi,[eax+ecx+12]
  mov [edx+ecx+12],esi
  mov esi,[eax+ecx+8]
  mov [edx+ecx+8],esi
  mov esi,[eax+ecx+4]
  mov [edx+ecx+4],esi
  mov esi,[eax+ecx]
  mov [edx+ecx],esi
  sub ecx,16
  jge @Loop
  mov [edx+ebx-4],ebp
  add ecx,16
@TinyMove:
  // eax = source
  // edx = dest
  // ecx = count
  pop ebp
  pop ebx
  pop edi
  pop esi
  lea ecx,[@table+ecx*4]
  jmp [ecx]
end;

procedure AlignedFwdMoveRL1(const Source; var Dest; Count: integer);
asm
  push edi
  push esi
  shr ecx,2
  mov edi,edx
  mov esi,eax
  rep movsd
  pop esi
  pop edi
end;

procedure FwdMoveRL1(const Source; var Dest; Count: integer);
// assume that count is >=0
asm
  push ebx
@move:
  cmp ecx,20
  jge @20Plus
  // tiny move
  lea ebx,[@16MinusTable+ecx*4]
  jmp [ebx]
@20plus:
  cmp ecx,256
  jge @256Plus
  push edi

  push [eax]  // load first 4
  push edx

  push ecx
  mov ecx,eax
  add ecx,3
  and ecx,-4
  sub ecx,eax

  add eax,ecx
  add edx,ecx
  mov ebx,ecx
  pop ecx
  sub ecx,ebx
  // we now have a 4 byte aligned move

  mov edi,16
@16PLoop:
  mov ebx,[eax+edi-16]
  mov [edx+edi-16],ebx
  mov ebx,[eax+edi-12]
  mov [edx+edi-12],ebx
  mov ebx,[eax+edi-8]
  mov [edx+edi-8],ebx
  mov ebx,[eax+edi-4]
  mov [edx+edi-4],ebx
  add edi,16
  cmp ecx,edi
  jge @16PLoop
  sub edi,16
  sub ecx,edi
  add eax,edi
  add edx,edi

  pop edi
  pop [edi]

  pop edi
  lea ebx,[@16MinusTable+ecx*4]
  jmp [ebx]
@256plus:  // big move
  mov ebx,ecx
  mov ecx,edx
  add ecx,15
  and ecx,-16
  push ecx
  sub ecx,edx
  push ecx
  call @TinyMove  // 16 byte align front
  // relies on eax and edx still being intact
  pop ecx
  add eax,ecx
  sub ebx,ecx
  pop edx
  mov ecx,ebx
  // we now have a 16 byte aligned move
  // align back end
  and ecx,-16
  sub ebx,ecx
  push eax
  push edx
  push ecx
  call AlignedFwdMoveRL1
  pop ecx
  pop edx
  pop eax
  add edx,ecx
  add eax,ecx
  mov ecx,ebx
  lea ebx,[@16MinusTable+ecx*4]
  jmp [ebx]

@TinyMove:
  push ebx
  lea ebx,[@16MinusTable+ecx*4]
  jmp [ebx]

@16MinusTable:
  dd @0
  dd @1
  dd @2
  dd @3
  dd @4
  dd @5
  dd @6
  dd @7
  dd @8
  dd @9
  dd @A
  dd @B
  dd @C
  dd @D
  dd @E
  dd @F
  dd @10
  dd @11
  dd @12
  dd @13

@13:
  mov bl,[eax+ecx-$13+$0]  // source[count-15+0]
  mov [edx+ecx-$13+$0],bl
@12:
  mov bl,[eax+ecx-$13+$1]  // source[count-15+1]
  mov [edx+ecx-$13+$1],bl
@11:
  mov bl,[eax+ecx-$13+$2]  // source[count-15+2]
  mov [edx+ecx-$13+$2],bl
@10:
  mov ebx,[eax+ecx-$13+$3]  // source[count-15+3]
  mov [edx+ecx-$13+$3],ebx
  mov ebx,[eax+ecx-$13+$7]  // source[count-15+7]
  mov [edx+ecx-$13+$7],ebx
  mov ebx,[eax+ecx-$13+$b]  // source[count-15+b]
  mov [edx+ecx-$13+$b],ebx
  mov ebx,[eax+ecx-$13+$f]  // source[count-15+b]
  mov [edx+ecx-$13+$f],ebx
  pop ebx
  ret
@F:
  mov bl,[eax+ecx-$F+$0]  // source[count-15+0]
  mov [edx+ecx-$F+$0],bl
@E:
  mov bl,[eax+ecx-$F+$1]  // source[count-15+1]
  mov [edx+ecx-$F+$1],bl
@D:
  mov bl,[eax+ecx-$F+$2]  // source[count-15+2]
  mov [edx+ecx-$F+$2],bl
@C:
  mov ebx,[eax+ecx-$F+$3]  // source[count-15+3]
  mov [edx+ecx-$F+$3],ebx
  mov ebx,[eax+ecx-$F+$7]  // source[count-15+7]
  mov [edx+ecx-$F+$7],ebx
  mov ebx,[eax+ecx-$F+$b]  // source[count-15+b]
  mov [edx+ecx-$F+$b],ebx
  pop ebx
  ret
@B:
  mov bl,[eax+ecx-$F+$4]  // source[count-15+4]
  mov [edx+ecx-$F+$4],bl     //mov [edx+ecx-$F+$5],bl DKC
@A:
  mov bl,[eax+ecx-$F+$5]  // source[count-15+5]
  mov [edx+ecx-$F+$5],bl
@9:
  mov bl,[eax+ecx-$F+$6]  // source[count-15+6]
  mov [edx+ecx-$F+$6],bl
@8:
  mov ebx,[eax+ecx-$F+$7]  // source[count-15+7]
  mov [edx+ecx-$F+$7],ebx
  mov ebx,[eax+ecx-$F+$b]  // source[count-15+b]
  mov [edx+ecx-$F+$b],ebx
  pop ebx
  ret
@7:
  mov bl,[eax+ecx-$F+$8]  // source[count-15+8]
  mov [edx+ecx-$F+$8],bl
@6:
  mov bl,[eax+ecx-$F+$9]  // source[count-15+9]
  mov [edx+ecx-$F+$9],bl
@5:
  mov bl,[eax+ecx-$F+$A]  // source[count-15+a]
  mov [edx+ecx-$F+$A],bl
@4:
  mov ebx,[eax+ecx-$F+$b]  // source[count-15+b]
  mov [edx+ecx-$F+$b],ebx
  pop ebx
  ret
@3:
  mov bl,[eax+ecx-$F+$C]  // source[count-15+c]
  mov [edx+ecx-$F+$C],bl
@2:
  mov bl,[eax+ecx-$F+$D]  // source[count-15+d]
  mov [edx+ecx-$F+$D],bl
@1:
  mov bl,[eax+ecx-$F+$E]  // source[count-15+e]
  mov [edx+ecx-$F+$E],bl
@0:
  pop ebx
end;

procedure RevMoveRL1(const Source; var Dest; Count: Integer);
asm
  cmp ecx,20
  jge @20Plus
  lea ecx,[@table+ecx*4]
  jmp [ecx]
@13:
  mov cl,[eax+$12]  // source[18]
  mov [edx+$12],cl
@12:
  mov cl,[eax+$11]  // source[17]
  mov [edx+$11],cl
@11:
  mov cl,[eax+$10]  // source[16]
  mov [edx+$10],cl
@10:
  mov cl,[eax+$F]  // source[15]
  mov [edx+$F],cl
@F:
  mov cl,[eax+$E]  // source[14]
  mov [edx+$E],cl
@E:
  mov cl,[eax+$D]  // source[13]
  mov [edx+$D],cl
@D:
  mov cl,[eax+$C]  // source[12]
  mov [edx+$C],cl
@C:
  mov cl,[eax+$B]  // source[11]
  mov [edx+$B],cl
@B:
  mov cl,[eax+$A]  // source[10]
  mov [edx+$A],cl
@A:
  mov cl,[eax+$9]  // source[9]
  mov [edx+$9],cl
@9:
  mov cl,[eax+$8]  // source[8]
  mov [edx+$8],cl
@8:
  mov cl,[eax+$7]  // source[7]
  mov [edx+$7],cl
@7:
  mov cl,[eax+$6]  // source[6]
  mov [edx+$6],cl
@6:
  mov cl,[eax+$5]  // source[5]
  mov [edx+$5],cl
@5:
  mov cl,[eax+$4]  // source[4]
  mov [edx+$4],cl
@4:
  mov cl,[eax+$3]  // source[3]
  mov [edx+$3],cl
@3:
  mov cl,[eax+$2]  // source[2]
  mov [edx+$2],cl
@2:
  mov cl,[eax+$1]  // source[1]
  mov [edx+$1],cl
@1:
  mov cl,[eax+$0]  // source[0]
  mov [edx+$0],cl
@0:
  ret
@table:
  dd @0
  dd @1
  dd @2
  dd @3
  dd @4
  dd @5
  dd @6
  dd @7
  dd @8
  dd @9
  dd @A
  dd @B
  dd @C
  dd @D
  dd @E
  dd @F
  dd @10;
  dd @11;
  dd @12;
  dd @13;
@20plus:
// split Fwd and rev moves
  // indyCount:=dest-source
  // if indyCount<16
  //    jmp  @RevMove(source,dest,count)// just do it all backwards
  // overlapCount:=count-indyCount
  // call FwdMove(source+ovlp,dest+ovlp,indyCount)
  // call @RevMove(source,dest,overlapcount)
  push esi
  push edi
  push ebx
  push ebp
  mov edi,edx
  mov esi,eax
  mov ebx,ecx

  mov ebp,edx
  sub ebp,eax
  cmp ebp,256
  // edx,edi = orig dest
  // eax,esi = orig src
  // ecx,ebx = orig len
  // ebp = free len
  jle @RevMove
// split fwd and rev
  sub ebx,ebp
  mov ecx,ebp
  add eax,ebx
  add edx,ebx
  // edi = orig dest
  // esi = orig src
  // ebx = ovlp len
  // ecx,ebp = free len
  // edx = ovlp dest
  // eax = ovlp src
  call FwdMoveRL1
  // edi = orig dest
  // esi = orig src
  // ebx = ovlp len
  // ebp = empty
  mov eax,esi
  mov edx,edi
  mov ecx,ebx
  cmp ecx,20
  jl @TinyMove

@RevMove:
  // eax,esi = source
  // edx,edi = dest
  // ecx,ebx = count
  mov ebp,[eax+ecx-4] // get last dword

  lea esi,[eax+ecx]  // align reads on dword boundry
  and esi,3
  sub ecx,esi
  sub ecx,16
@Loop:
  mov esi,[eax+ecx+12]
  mov [edx+ecx+12],esi
  mov esi,[eax+ecx+8]
  mov [edx+ecx+8],esi
  mov esi,[eax+ecx+4]
  mov [edx+ecx+4],esi
  mov esi,[eax+ecx]
  mov [edx+ecx],esi
  sub ecx,16
  jge @Loop
  mov [edx+ebx-4],ebp
  add ecx,16
@TinyMove:
  // eax = source
  // edx = dest
  // ecx = count
  pop ebp
  pop ebx
  pop edi
  pop esi
  lea ecx,[@table+ecx*4]
  jmp [ecx]
end;

procedure Move_RL_IA32_1(const Source; var Dest; Count: Integer);
// assumes Count>0 just like system.move
// all paths require 6 instr with 2 cond jumps
// system.move requires 3 instr with 2 cond jumps
asm
  cmp ecx,0
  jle @exit
  cmp eax,edx
  jge FwdMoveRL1
// source<dest
  push eax
  add eax,ecx
  cmp eax,edx
  pop eax
  jle FwdMoveRL1
// source+Count>dest
  jmp RevMoveRL1
@exit:
end;


end.
