unit StringReplaceEGPasUnit;

interface

uses
  SysUtils;

function StringReplace_EG_MMX_1(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;

implementation

uses
   Windows;

var
   vAnsiUpperTable : packed array [#0..#255] of Char;

const
   cDefaultPosBufferSize = 16;

procedure PrepareAnsiTables;
var
   c : Char;
begin
   for c:=#0 to #255 do
      vAnsiUpperTable[c]:=AnsiUpperCase(c)[1];
end;

procedure MyMove(const Source; var Dest; Count: Integer); overload; forward;

procedure MyMove2(const Source : String; var Dest; Count: Integer); overload;
asm
   jmp MyMove
end;

procedure MyMove(const Source; var Dest; Count: Integer); overload;
asm
//   jmp Move

{     ->EAX     Pointer to source       }
{       EDX     Pointer to destination  }
{       ECX     Count                   }
@@Blocks16:
      cmp   ecx, 16
      jb    @@Block8
@@Blocks16bis:
      lea   ecx, [ecx-16]
      movq  mm0, [eax]        //fild  qword ptr [eax]
      movq  mm1, [eax+8]      //fild  qword ptr [eax+8]
      lea   eax, [eax+16]
      movq  [edx], mm0        //fistp qword ptr [edx+8]
      movq  [edx+8], mm1      //fistp qword ptr [edx]
      lea   edx, [edx+16]
      cmp   ecx, 16
      jge   @@Blocks16bis
      emms

@@Block8:
      cmp   ecx, 8
      jbe   @@Few
      lea   ecx, [ecx-8]
      fild  qword ptr [eax]
      lea   eax, [eax+8]
      fistp qword ptr [edx]
      lea   edx, [edx+8]

@@Few:
      jmp   dword ptr [@@JumpTable+ecx*4]

@@Three:
      mov   cx, [eax+1]
      mov   [edx+1], cx
@@One:
      mov   cl, [eax]
      mov   [edx], cl
      jmp   @@End
@@Two:
      mov   cx, [eax]
      mov   [edx], cx
      jmp   @@End
@@Five:
      mov   cl, [eax+4]
      mov   [edx+4], cl
@@Four:
      mov   ecx, [eax]
      mov   [edx], ecx
      jmp   @@End
@@Seven:
      mov   cl, [eax+6]
      mov   [edx+6], cl
@@Six:
      mov   cx, [eax+4]
      mov   [edx+4], cx
      mov   ecx, [eax]
      mov   [edx], ecx
      jmp   @@End
@@Eight:
      fild  qword ptr [eax]
      fistp qword ptr [edx]
      jmp   @@End

@@JumpTable:
      dd    @@End
      dd    @@One, @@Two, @@Three, @@Four, @@Five, @@Six, @@Seven, @@Eight

@@End:
end;

function StrFindHelper(const stringSearched : String; charToFind : Char; startPos : Integer) : Integer;
asm
   push  edi
   push  eax

   lea   edi, [eax+ecx-1]
   mov   eax, [eax-4]
   inc   eax
   sub   eax, ecx
   jle   @@NotFound

   lea   edi, [edi+eax]
   neg   eax
@@Loop:
   cmp   dl, [edi+eax]
   jz    @@LoopDone
   inc   eax
   jnz   @@Loop
   jmp   @@NotFound

@@LoopDone:
   mov   ecx, [esp]
   lea   eax, [edi+eax+1]
   sub   eax, ecx
   jmp   @@End

@@NotFound:
   mov   eax, -1

@@End:
   pop   edi
   pop   edi    
end;

function StrFind(const stringSearched, stringToFind : String;
					  startPos : Integer) : Integer;
var
	index1, index2, len2, endsearch : Integer;
begin
	if (stringSearched<>'') and (stringToFind<>'') then begin
      len2:=Length(stringToFind);
		endsearch:=Length(stringSearched)-len2+1;
		if startPos<=endsearch then while True do begin
         startPos:=StrFindHelper(stringSearched, stringToFind[1], startPos);
         if Cardinal(startPos)>Cardinal(endsearch) then Break;
         index1:=startPos;
         index2:=1;
         while (index2<len2) and (stringSearched[index1+1]=stringToFind[index2+1]) do begin
            Inc(index1);
            Inc(index2);
         end;
         if index2>=len2 then begin
            Result:=startPos;
            Exit;
         end;
         Inc(startPos);
      end;
	end;
	Result:=0;
end;

function StrIFind(const stringSearched, refStringToFind : String;
					  startPos : Integer) : Integer;
var
	index1, index2, len2, endSearch : Integer;
   firstChar : Char;
begin
	if (stringSearched<>'') and (refStringToFind<>'') then begin
      firstChar:=vAnsiUpperTable[refStringToFind[1]];
      len2:=Length(refStringToFind);
		endSearch:=Length(stringSearched)-len2+1;
		while startPos<=endSearch do begin
			if vAnsiUpperTable[stringSearched[startPos]]=firstChar then begin
 				index1:=startPos;
            index2:=1;
   			while (index2<len2) and (vAnsiUpperTable[stringSearched[index1+1]]=vAnsiUpperTable[refStringToFind[index2+1]]) do begin
	   			Inc(index1);
               Inc(index2);
			   end;
				if index2>=len2 then begin
					Result:=startPos;
					Exit;
				end;
			end;
         Inc(startPos);
      end;
	end;
	Result:=0;
end;

function StrReplaceAllChar(aChar, newChar : char; const aString : String) : string;
var
   i : Integer;
begin
   Result:=aString;
   for i:=1 to Length(Result) do
      if aString[i]=aChar then
         Result[i]:=newChar;
end;

function StrIReplaceAllChar(aChar, newChar : char; const aString : String) : string;
var
   i : Integer;
begin
   aChar:=vAnsiUpperTable[aChar];
   Result:=aString;
   for i:=1 to Length(Result) do
      if vAnsiUpperTable[aString[i]]=aChar then
         Result[i]:=newChar;
end;

function StrReplaceAll(const subString, newSubString, refStr : String) : String;
var
	p, i, np, lss, delta, nl, fp : integer;
   pResult : PChar;
   buffer : PIntegerArray;
   bufferCount, bufferCapacity : Integer;
   staticBuffer : array [0..cDefaultPosBufferSize-1] of Integer;
begin
   p:=Pos(subString, refStr);
   if p>0 then begin
	   lss:=Length(subString);
      delta:=Length(newSubString);
      bufferCapacity:=cDefaultPosBufferSize;
      buffer:=@staticBuffer[0];
      bufferCount:=1;
      buffer[0]:=p;
      Inc(p, lss);
      while True do begin
         p:=StrFind(refStr, subString, p);
         if p>0 then begin
            if bufferCount=bufferCapacity then begin
               bufferCapacity:=bufferCapacity+(bufferCapacity shr 1);
               if buffer=@staticBuffer[0] then begin
                  GetMem(buffer, bufferCapacity*SizeOf(Integer));
                  MyMove(staticBuffer[0], buffer[0], cDefaultPosBufferSize*SizeOf(Integer));
               end else ReallocMem(buffer, bufferCapacity*SizeOf(Integer));
            end;
            buffer[bufferCount]:=p;
            Inc(bufferCount);
            Inc(p, lss);
         end else Break;
      end;
      SetLength(Result, Length(refStr)+bufferCount*(delta-lss));
      pResult:=PChar(Result);
      p:=1;
      np:=0;
      for i:=0 to bufferCount-1 do begin
         fp:=buffer[i];
         if fp>p then begin
            MyMove(refStr[p], pResult[np], fp-p);
            Inc(np, fp-p);
         end;
         p:=fp+lss;
         if delta>0 then begin
            MyMove2(newSubString, pResult[np], delta);
            Inc(np, delta);
         end;
      end;
      nl:=Length(refStr);
      if p<=nl then
         MyMove(refStr[p], pResult[np], nl-p+1);
      if bufferCapacity<>cDefaultPosBufferSize then
         FreeMem(buffer);
   end else Result:=refStr;
end;

function StrIReplaceAll(const refSubString, newSubString, refStr : String) : String;
var
	p, i, np, lss, delta, nl, fp : integer;
   pResult : PChar;
   buffer : PIntegerArray;
   bufferCount, bufferCapacity : Integer;
   staticBuffer : array [0..cDefaultPosBufferSize-1] of Integer;
begin
   p:=StrIFind(refStr, refSubString, 1);
   if p>0 then begin
	   lss:=Length(refSubString);
      delta:=Length(newSubString);
      bufferCapacity:=cDefaultPosBufferSize;
      buffer:=@staticBuffer[0];
      bufferCount:=1;
      buffer[0]:=p;
      Inc(p, lss);
      while True do begin
         p:=StrIFind(refStr, refSubString, p);
         if p>0 then begin
            if bufferCount=bufferCapacity then begin
               bufferCapacity:=bufferCapacity+(bufferCapacity shr 1);
               if buffer=@staticBuffer[0] then begin
                  GetMem(buffer, bufferCapacity*SizeOf(Integer));
                  MyMove(staticBuffer[0], buffer[0], cDefaultPosBufferSize*SizeOf(Integer));
               end else ReallocMem(buffer, bufferCapacity*SizeOf(Integer));
            end;
            buffer[bufferCount]:=p;
            Inc(bufferCount);
            Inc(p, lss);
         end else Break;
      end;
      SetLength(Result, Length(refStr)+bufferCount*(delta-lss));
      pResult:=PChar(Result);
      p:=1;
      np:=0;
      for i:=0 to bufferCount-1 do begin
         fp:=buffer[i];
         if fp>p then begin
            MyMove(refStr[p], pResult[np], fp-p);
            Inc(np, fp-p);
         end;
         p:=fp+lss;
         if delta>0 then begin
            MyMove2(newSubString, pResult[np], delta);
            Inc(np, delta);
         end;
      end;
      nl:=Length(refStr);
      if p<=nl then
         MyMove(refStr[p], pResult[np], nl-p+1);
      if bufferCapacity<>cDefaultPosBufferSize then
         FreeMem(buffer);
   end else Result:=refStr;
end;

// The Wrapper
//
function StringReplace_EG_MMX_1(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
   i, lenOld, lenNew, lenS, n : Integer;
   pResult : PChar;
begin
   lenS:=Length(S);
   lenOld:=Length(OldPattern);
   if lenS=0 then
      Result:=''
   else if lenOld=0 then
      Result:=S
   else begin
      lenNew:=Length(NewPattern);
      if rfReplaceAll in flags then begin
         if rfIgnoreCase in flags then begin
            if (lenOld=1) and (lenNew=1) then
               Result:=StrIReplaceAllChar(OldPattern[1], NewPattern[1], S)
            else Result:=StrIReplaceAll(OldPattern, NewPattern, S)
         end else begin
            if (lenOld=1) and (lenNew=1) then
               Result:=StrReplaceAllChar(OldPattern[1], NewPattern[1], S)
            else Result:=StrReplaceAll(OldPattern, NewPattern, S)
         end;
      end else begin
         if rfIgnoreCase in flags then
            i:=StrIFind(S, OldPattern, 1)
         else i:=Pos(oldPattern, S);
         if i>0 then begin
            // code below is just a convoluted version of
            //  Result:=Copy(S, 1, i-1)+NewPattern+Copy(S, i+lenOld, MaxInt);
            SetLength(Result, lenS+lenNew-lenOld);
            pResult:=PChar(Result);
            if i>1 then
               MyMove2(S, pResult^, i-1);
            if lenNew>0 then
               MyMove2(NewPattern, pResult[i-1], lenNew);
            n:=lenS-i+1-lenOld;  
            if n>0 then
               MyMove(S[i+lenOld], pResult[i+lenNew-1], n);
         end else Result:=S;
      end;
   end;
end;

initialization

   PrepareAnsiTables;

end.
