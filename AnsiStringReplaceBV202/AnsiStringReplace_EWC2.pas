unit AnsiStringReplace_EWC2;
//*********************************************************************
//  Author: Eric W. Carman
//          EWCarman@aol.com
//          EWCarman@ecsoftwareconsulting.com
//*********************************************************************
{.$R+}

{$UNDEF OptimizationCheck}
{$IFOPT O-}
  {$O+}
  {$DEFINE OptimizationCheck}
{$ENDIF}

interface

uses SysUtils, Windows;

function StringReplace_EWC_IA32_2(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;

implementation

var
  UpperCaseString: array[0..255] of char;
  SameCaseString: array[0..255] of char;

//***** StringReplace Routines *****

//*********************************************************************
//  Attempt to divide the task into separate cases and optimize each case.
//
//  1. Replace All
//    1.1 Keep a buffer in which to place intermediate results.  This
//        buffer will help to minimize the number of moves and string length
//        calls when replacing a pattern.  This is effective when the maximum
//        size of the result string can be calculated is not too large.
//        Some experimentation here might yield a better buffer size.  However,
//        based on the benchmark data, this buffer size seems to offer a
//        decent trade off - on my machine.
//
//    1.2 When the result string might be greater than the buffer size,
//        this method will keep a trailing pointer in the original string
//        and move blocks of data at a time when a pattern is matched.
//
//  2. Replace Once
//    2.1 When a pattern is found, build the result string at that point.
//        If no pattern is found, copy the original string to the result string.    
//*********************************************************************
function StringReplace_EWC_IA32_2(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;

  //*********************************************************************
  //  As I didn't write any of the fastcode uppercase functions, I had to
  //  come up with my own.  I started with this table based version prior
  //  to the requirement of dealing with character values > 128.  At least
  //  it was fairly easy to adapt.
  //
  //  This relies on the initialization code to fill the target
  //  UpperCaseString.  This simply prefills the uppercase equivalent
  //  for each character between 0 and 255.
  //
  //  Uppercasing a character is then a matter of indexing into the string
  //  using the character as an index and substituting its uppercase
  //  equivalent.
  //
  //  This varies from the original pascal, in that the counter is converted
  //  to an offset and the string is uppercased from right to left.
  //
  //  This might be subject to issues if the language is changed once the
  //  program has started.  I suppose it would be possible to hook a windows
  //  event to register this type of activity and then alter the stored
  //  string.  In this case, it would be necessary to plan for any collisions
  //  that may result if the string replace were currently running.  Probably
  //  beyond the scope of the challenge at this time.
  //
  //  Alternatively, the very slow AnsiUpperCase function could be used.
  //*********************************************************************
  function UpperCase_EWC(const S: String): String;
  //S      = eax
  //Len    = ebx
  //Result = edi
  //UppercaseString = edx/esi
  asm
    push ebx
    push esi
    push edi
    mov edi,edx
    mov esi,eax

    //Calling Routing ensures that String Length is > 0

    mov ebx,[esi-$04]   //Get String S Length

    mov eax,edi         //Set eax to result string
    mov edx,ebx         //Set edx to desired length
    call System.@LStrSetLength  //Set the string length for the result string

    mov eax,esi         //Set eax to point to String S (Source)
    mov edi,[edi]       //Set edi to point to the newly allocated Result String

    mov edx,OFFSET UpperCaseString //Load the address of the UpperCaseString to edx

    xor ecx,ecx         //Clear ecx.  Used to get character offset into UpperCaseString

    //String Length can't be zero

    sub ebx, 1          //Convert ebx to offset from length

  @BeginLoop:
    mov cl,[eax + ebx]

    mov cl,[edx+ecx]    //Move UppercaseString character to cl
    mov [edi+ebx],cl    //Move that character to the Result String

    sub ebx, 1          //Decrement the Length/Loop Counter.  This also sets ZF
    jns @BeginLoop      //If Offset < 0 then end the loop, otherwise branch to BeginLoop

  @EndProc:
    pop edi
    pop esi
    pop ebx
    ret
  end;

  //*********************************************************************
  //  An attempt to reduce the number of times the Pattern Match function
  //  is called.
  //
  //  The first character is checked for a match in the calling routine.
  //  This effectively limits the number of calls to this routine to 1 in 256
  //  possible times.  However, it would be more realistic to assume that
  //  the letters A-Z and numbers 0-9 would dominate real world uses and so
  //  a reduction on the order of 1 in 36 is more likely.
  //
  //  Modified this to run backwards and do the uppercase comparisons on
  //  the fly.  This removed loop counters and some extraneous compares.
  //*********************************************************************
  function MatchPattern(const Pattern, Source: String; const SourceOffset: Integer): Boolean;
  //Pattern = edi
  //Source  = esi
  //SourceOffset = ecx
  //UpperCaseString = ecx
  //PatternLength = edx
  //Result = eax
  asm
    push esi
    push edi
    lea edi,[eax+$01]   //Advance the Pattern pointer to the next character to scan
    lea esi,[edx+ecx]

    //Calling routine ensures that Pattern is not an empty string
    mov edx,[eax-$04]   //Get String Pattern Length

    //First Character has already been checked prior to calling this routine.

    sub edx,2           //Decrement Pattern Length/Convert Length to Offset
    jl @Return_True     //If edx < zero, no more to compare - pattern matched

    //If Ignore Case, branch to case sensitive compares
    mov al, Flags
    test al, $02
    jnz @IgnoreCase     //Ignore Case

  @BeginLoop:
    mov al,[esi+edx]    //Get Pattern Character
    cmp al,[edi+edx]    //Compare to Source Character
    jnz @Return_False   //If no match, break loop

                        //Otherwise continue with next character
    sub edx, 1          //Dec(Len) - also sets ZF flag
    jnl @BeginLoop      //If Len = 0 then, end loop - pattern is found

  @Return_True:
    mov al,$01
    pop edi
    pop esi
    ret

  @Return_False:
    xor eax, eax
    pop edi
    pop esi
    ret

  //Moved case sensitive compares here to avoid having to call the uppercase
  // function on the source string.
  @IgnoreCase:
    mov ecx,OFFSET UpperCaseString
    xor eax, eax

  @BeginLoopIC:
    mov al,[esi+edx]    //Get Source Character
    mov al, [ecx+eax]   //Translate to UpperCase
    cmp al,[edi+edx]    //Compare to Pattern Character
    jnz @Return_FalseIC //If no match, break loop

                        //Otherwise continue with next character
    sub edx, 1          //Dec(Len) - also sets ZF flag
    jnl @BeginLoopIC    //If Len < 0 then, end loop - pattern is found

  @Return_TrueIC:
    mov al,$01
    pop edi
    pop esi
    ret

  @Return_FalseIC:
    xor eax, eax
    pop edi
    pop esi
    ret
  end;

  //*********************************************************************
  //  An attempt to speed up the move routine.  The calling routine will
  //  only call this if the count is >= zero and the source and dest
  //  strings won't overlap.
  //
  //  Started with Borland's move and removed extra checks that wouldn't
  //  apply here.  Then made the move run backwards so that I could
  //  get rid of two loop counters.
  //*********************************************************************
  procedure Move_NoOverlap(const Source; var Dest; Count: Integer);
  asm
    push esi
    push edi
    mov esi,eax
    mov edi,edx
    mov edx,ecx

    //Calling Routine ensures that source and dest don't overlap.
    //Calling Routine ensures that Count >= 0

    sub ecx, 4          //ecx div 4
    jl @MoveRemainder

  @MoveWord:
    mov eax, [esi+ecx]
    mov [edi+ecx], eax

    sub ecx, 4          //Dec(Count) - also sets ZF flag
    jns @MoveWord       //If Offset < 0 then, end loop

  @MoveRemainder:
    and edx, $03        //edx mod 4
    jz @EndProc

    sub edx, 1          //Convert to offset from length

  @MoveChar:
    mov al, [esi+edx]
    mov [edi+edx], al

    sub edx, 1          //Dec(Count) - also sets ZF flag
    jns @MoveChar       //If Offset < 0 then, end loop

  @EndProc:
    pop edi
    pop esi
    ret
  end;

  //*********************************************************************
  //  John O'Harrow pointed out a possible overflow condition which could
  //  cause some logic to take an access violation.  It turns out that mine
  //  might be subject to that as well.  So this code was stripped from the
  //  pascal below and an overflow is tested for directly.
  //*********************************************************************
  function CalcMaxResultLength(LenSrc, LenOld, LenNew: Integer): Integer;
  asm
    push ebx
    push esi
    mov esi,edx
    mov ebx,eax

    mov eax,ebx
    cdq
    idiv esi            //LenSrc div LenOld

    sub ecx,esi         //LenNew - LenOld

    imul ecx,eax        //Result * (LenNew - LenOld)
    jo @Overflow        //If overflow, set result to zero

    add ecx,ebx         //LenSrc + Result....
    jo @Overflow        //If overflow, set result to zero

    mov eax,ecx         //Move to Result

    cmp eax,ebx         //if LenSrc > Result then set Result to LenSrc
    jnl @EndProc

    mov eax,ebx

  @EndProc:
    pop esi
    pop ebx
    ret

  @Overflow:
    xor eax, eax

    pop esi
    pop ebx
    ret

  //begin
  //  Result := LenSrc div LenOld;  //Number of Old Patterns that could exist in the string
  //                                //Number of bytes if every character replaced by New Pattern
  //  Result := LenSrc + (Result * (LenNew - LenOld));
  //
  //  if LenSrc > Result then
  //    Result := LenSrc;

  end;

  //*********************************************************************
  //  Test suggestion by Hallvard Vassbotn on substitute for
  //  Ansi String Length function.
  //*********************************************************************
  function GetStrLength(Str: String): Integer;
  asm
    test eax,eax
    jz @EndProc
    mov eax,[eax-$04]
  @EndProc:
    ret
  end;

var
  iChar:  Integer;  //Current Position in Source String
  iLen:   Integer;  //Current Position in Result String
  iBuff:  Integer;  //Current Position in Buffer
  iLow:   Integer;  //Starting Position in Source String for current source buffer

  LenSrc: Integer;  //Length of Source String
  LenOld: Integer;  //Length of the Old Pattern
  LenNew: Integer;  //Length of the New Pattern
  LenMax: Integer;  //Maximum Length of the Result String - used in ReplaceAll case
  ChkEnd: Integer;  //Point on the string where the Old Pattern is larger than
                    // the remaining length of the string to validate.

  pNewPattern: PChar;
  pResult:     PChar;
  pSource:     PChar;
  pTransChar:  PChar;

  LenRes: Integer;  //In Use length of the Result String

  bMatch: Boolean;  //Set when the old pattern is found in the Source

  Patt: string;

  Buffer: array[0..511] of char; //Bufferred area to hold the string prior to
                                 // adding it to the result set.  The idea is
                                 // to reduce the number of Move and SetLength
                                 // calls that must be made. Trial and error
                                 // used to set buffer length.  Given benchmark
                                 // data, little/no benefits in increasing to
                                 // 1024.
begin
  //Test for empty string in old pattern and source.
  LenOld := GetStrLength(OldPattern);
  if LenOld = 0 then
    begin
      Result := S;
      Exit;
    end;

  LenSrc := GetStrLength(S);
  if LenSrc = 0 then
    begin
      Result := '';
      Exit;
    end;

  LenNew := GetStrLength(NewPattern);

  //When the iChar reaches this point, no match can be made.
  ChkEnd := LenSrc - LenOld + 2;

  if rfIgnoreCase in Flags then
    begin
      //An attempt to speed up the routine by improving the UpperCase function.
      Patt := UpperCase_EWC(OldPattern);
      pTransChar := UpperCaseString;
    end
  else
    begin
      Patt := OldPattern;
      pTransChar := SameCaseString;
    end;

  iBuff  := 0;
  iLow   := 1;
  iChar  := 1;

  pNewPattern := Pointer(NewPattern);
  pSource     := Pointer(S);

  //Initial used length of the result string = 0
  LenRes := 0;

  //While this results in some duplicate code, it prevents some questions
  // i.e. (rfReplaceAll in Flags) from being asked with each character tested.
  if (rfReplaceAll in Flags) then
    begin
      //Calculate the Maximum length of the result string.  If the max length is
      // less than the buffer size, then choose alternate path which skips
      // checking intermediate steps for a full buffer.
      LenMax := CalcMaxResultLength(LenSrc, LenOld, LenNew);

      //If overflow, force into unbuffered segment.
      if LenMax = 0 then
        LenMax := Length(Buffer) + 1;

      if LenMax > Length(Buffer) then
        begin
          //Initial allocation of result buffer
          //Attempt to determine an intelligent result size for the string.
          //Default the size allocated to account for one replace if the new pattern
          // is larger than the old pattern.  Otherwise default to the source size.
          if LenNew > LenOld then
            SetLength(Result, LenSrc + LenNew - LenOld)
          else
            SetLength(Result, LenSrc);

          if LenOld = 1 then
            begin
              while iChar < ChkEnd do
                begin
                  //An attempt to reduce the number of times the Pattern Match function is called.
                  if (Patt[1] = pTransChar[Byte(S[iChar])]) then
                    begin
                      //Load Bufferred String
                      iLen := LenRes;
                      //Set the length of Result to include itself, the buffer and new Pattern
                      LenRes := iLen + iChar - iLow + LenNew;
                      if LenRes > GetStrLength(Result) then
                        SetLength(Result, LenRes);

                      pResult := Pointer(Result);
                      Inc(pResult, iLen);
                      Move_NoOverlap(S[iLow], pResult^, iChar - iLow);

                      //Load New Pattern
                      if LenNew = 1 then
                        begin
                          Inc(pResult, iChar - iLow);
                          pResult^ := pNewPattern^
                        end
                      else if LenNew > 0 then
                        begin
                          Inc(pResult, iChar - iLow);
                          Move_NoOverlap(pNewPattern^, pResult^, LenNew);
                        end;

                      Inc(iChar);
                      iLow := iChar; //Reposition Low Pointer
                    end
                  else
                    begin
                      Inc(iChar);
                    end;
                end;
            end
          else
            begin
              while iChar < ChkEnd do
                begin
                  //An attempt to reduce the number of times the Pattern Match function is called.
                  if (Patt[1] = pTransChar[Byte(S[iChar])]) and
                     MatchPattern(Patt, S, iChar) then
                    begin
                      //Load Bufferred String
                      iLen := LenRes;
                      //Set the length of Result to include itself, the buffer and new Pattern
                      LenRes := iLen + iChar - iLow + LenNew;
                      if LenRes > GetStrLength(Result) then
                        SetLength(Result, LenRes);

                      pResult := Pointer(Result);
                      Inc(pResult, iLen);
                      Move_NoOverlap(S[iLow], pResult^, iChar - iLow);

                      //Load New Pattern
                      if LenNew = 1 then
                        begin
                          Inc(pResult, iChar - iLow);
                          pResult^ := pNewPattern^
                        end
                      else if LenNew > 0 then
                        begin
                          Inc(pResult, iChar - iLow);
                          Move_NoOverlap(pNewPattern^, pResult^, LenNew);
                        end;

                      iLow  := iChar + LenOld; //Reposition low pointer
                      iChar := iLow;
                    end
                  else
                    begin
                      Inc(iChar);
                    end;
                end;
            end;

          //Dump the remainder of the string, if any, to the result.
          if iLow <= LenSrc then // < iChar then
            begin
              iLen := LenRes;
              LenRes := iLen + LenSrc + 1 - iLow;
              if LenRes > GetStrLength(Result) then
                SetLength(Result, LenRes);
              pResult := Pointer(Result);
              Inc(pResult, iLen);
              Move_NoOverlap(S[iLow], pResult^, LenSrc + 1 - iLow);
            end;

          //Trims the buffer if there is any extra space allocated at the end of result
          // due to the initial allocation or reallocations with freespace.
          if LenRes < GetStrLength(Result) then
            SetLength(Result, LenRes);
        end
      else
        begin
          //Maximum Length of the result string will fit into the buffer
          // without the need to dump it at intermediate stages.  Therefore,
          // there is no need to check on it.
          if LenOld = 1 then
            begin
              while iChar < ChkEnd do
                begin
                  //An attempt to reduce the number of times the Pattern Match function is called.

                  if (Patt[1] = pTransChar[Byte(S[iChar])]) then
                    begin
                      //Load New Pattern
                      if LenNew = 1 then
                        begin
                          Buffer[iBuff] := pNewPattern^;
                          Inc(iBuff);
                        end
                      else if LenNew > 0 then
                        begin
                          Move_NoOverlap(pNewPattern^, Buffer[iBuff], LenNew);
                          Inc(iBuff, LenNew);
                        end;
                      Inc(iChar);
                    end
                  else
                    begin
                      //Copy Character to buffer
                      Buffer[iBuff] := S[iChar];
                      Inc(iBuff);
                      Inc(iChar);
                    end;
                end;
            end
          else
            begin
              while iChar < ChkEnd do
                begin
                  //An attempt to reduce the number of times the Pattern Match function is called.

                  if (Patt[1] = pTransChar[Byte(S[iChar])]) and
                     MatchPattern(Patt, S, iChar) then
                    begin
                      //Load New Pattern
                      if LenNew = 1 then
                        begin
                          Buffer[iBuff] := pNewPattern^;
                          Inc(iBuff);
                        end
                      else if LenNew > 0 then
                        begin
                          Move_NoOverlap(pNewPattern^, Buffer[iBuff], LenNew);
                          Inc(iBuff, LenNew);
                        end;
                      Inc(iChar, LenOld);
                    end
                  else
                    begin
                      //Copy Character to buffer
                      Buffer[iBuff] := S[iChar];
                      Inc(iBuff);
                      Inc(iChar);
                    end;
                end;
            end;

          //Load characters remaining beyond ChkEnd, if any
          for iLow := iChar to LenSrc do
            begin
              //Copy Character to buffer
              Buffer[iBuff] := S[iLow];
              Inc(iBuff);
            end;

          //We know exactly how long the result string is at this point.
          SetLength(Result, iBuff);
          if iBuff > 0 then
            begin
              pResult := Pointer(Result);
              Move_NoOverlap(Buffer, pResult^, iBuff);
            end;
        end;
    end
  else
    begin
      bMatch := False;
      if LenOld = 1 then
        begin
          while iChar < ChkEnd do
            begin
              if (Patt[1] = pTransChar[Byte(S[iChar])]) then
                begin
                  bMatch := True;

                  SetLength(Result, LenSrc + LenNew - LenOld);
                  iLen := iChar - 1;  //Set up pointer for load new pattern
                  if GetStrLength(Result) = 0 then //(LenSrc + LenNew - LenOld) = 0 then
                    Break;

                  //Write out beginning data in the string.
                  pResult := Pointer(Result);
                  Move_NoOverlap(pSource^, pResult^, iLen);

                  Inc(pResult, iLen);
                  //Load New Pattern
                  if LenNew = 1 then
                    pResult^ := pNewPattern^
                  else if LenNew > 0 then
                    Move_NoOverlap(pNewPattern^, pResult^, LenNew);

                  //Load Remainder of the String
                  Inc(pResult, LenNew);
                  Inc(pSource, iLen + LenOld);
                  iLen := LenSrc - (iChar + LenOld) + 1;  //Calculate length of move
                  if (iLen) > 0 then
                    Move_NoOverlap(pSource^, pResult^, iLen);

                  Break;
                end
              else
                begin
                  Inc(iChar);
                end;
            end;
        end
      else
        begin
          while iChar < ChkEnd do
            begin
              if (Patt[1] = pTransChar[Byte(S[iChar])]) and
                 MatchPattern(Patt, S, iChar) then
                begin
                  bMatch := True;

                  SetLength(Result, LenSrc + LenNew - LenOld);
                  iLen := iChar - 1;  //Set up pointer for load new pattern
                  if GetStrLength(Result) = 0 then //(LenSrc + LenNew - LenOld) = 0 then
                    Break;

                  //Write out beginning data in the string.
                  pResult := Pointer(Result);
                  Move_NoOverlap(pSource^, pResult^, iLen);

                  Inc(pResult, iLen);
                  //Load New Pattern
                  if LenNew = 1 then
                    pResult^ := pNewPattern^
                  else if LenNew > 0 then
                    Move_NoOverlap(pNewPattern^, pResult^, LenNew);

                  //Load Remainder of the String
                  Inc(pResult, LenNew);
                  Inc(pSource, iLen + LenOld);
                  iLen := LenSrc - (iChar + LenOld) + 1;  //Calculate length of move
                  if (iLen) > 0 then
                    Move_NoOverlap(pSource^, pResult^, iLen);

                  Break;
                end
              else
                begin
                  Inc(iChar);
                end;
            end;
        end;

      //If no match, copy string to result
      if not bMatch then
        begin
          SetLength(Result, LenSrc);
          pResult := Pointer(Result);
          Move_NoOverlap(pSource^, pResult^, LenSrc);
        end;
    end;
end;

{$IFDEF OptimizationCheck}
  {$O-}
  {$UNDEF OptimizationCheck}
{$ENDIF}

var
  i: Integer;

initialization
  for i := 0 to 255 do
    begin
      UpperCaseString[i] := Chr(i);
      SameCaseString[i] := Chr(i);
    end;
  CharUpperBuff(UpperCaseString, 256);

end.
