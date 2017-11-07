unit AnsiStringReplace_EWC;
//*********************************************************************
//  Author: Eric W. Carman
//          EWCarman@aol.com
//          EWCarman@ecsoftwareconsulting.com
//*********************************************************************
{.$R+}

interface

uses SysUtils, Windows;

function StringReplace_EWC_IA32_1(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;

implementation

var
  UpperCaseString: array[0..255] of char;

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
function StringReplace_EWC_IA32_1(const S, OldPattern, NewPattern: string;
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

  //var
  //  Len: Integer;
  //  Source, Dest, Trans: PChar;
  //begin
  //  Len := Length(S);
  //  SetLength(Result, Len);
  //  Source := Pointer(S);
  //  Dest := Pointer(Result);
  //  Trans := UpperCaseString;
  //  while Len <> 0 do
  //    begin
  //      Dest^ := PChar(@Trans[PByte(Source)^])^;
  //
  //      Inc(Source);
  //      Inc(Dest);
  //      Dec(Len);
  //    end;
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
  //  This will do specific character compares for the first N characters
  //  in the Pattern.  This minimizes the overhead of a loop for small strings
  //  yet maintains the flexibility for larger ones.
  //
  //  The number of character compares (our friend N from above) to do in this
  //  manner was determined in two ways.
  //
  //    1. Continue to add a choice until there was no appreciable effect.
  //       (admittedly this is a test data dependent choice.)
  //    2. Most of my personal use of string replace is on smaller OldPattern strings.
  //       In fact, I usually use it to replace YYYY masks with a year.
  //       Therefore, 4 character direct check with loop handling anything
  //       greater.
  //*********************************************************************
  function MatchPattern(const Pattern, Source: String; const SourceOffset: Integer): Boolean;
  //Pattern = edi
  //Source  = esi
  //SourceOffset = ecx
  //PatternLength = ebx
  //Result = eax
  asm
    push esi
    push edi
    mov edi,eax
    lea esi,[edx+ecx]

    //Calling routine ensures that Pattern is not an empty string
    mov edx,[edi-$04]   //Get String Pattern Length

    //First Character has already been checked prior to calling this routine.

    sub edx,1           //Decrement Pattern Length
    jz @Return_True     //If edx = zero, no more to compare - pattern matched

    mov al,[esi]        //Get Source[Offset + 1]
    cmp al,[edi+$01]    //Compare to Pattern[2]
    jnz @Return_False
    sub edx,1           //Decrement Pattern Length
    jz @Return_True     //If edx = zero, no more to compare - pattern matched

    mov al,[esi+$01]
    cmp al,[edi+$02]    //Compare to Pattern[3]
    jnz @Return_False
    sub edx,1           //Decrement Pattern Length
    jz @Return_True     //If edx = zero, no more to compare - pattern matched

    mov al,[esi+$02]
    cmp al,[edi+$03]    //Compare to Pattern[4]
    jnz @Return_False
    sub edx,1           //Decrement Pattern Length
    jz @Return_True     //If edx = zero, no more to compare - pattern matched

    //Inline Compare Pattern
    lea esi,[esi+$03]   //Advance the Source pointer to next character to scan
    lea edi,[edi+$04]   //Advance the Pattern pointer to the next character to scan

  @BeginLoop:
    mov al,[esi]        //Get Pattern Character
    cmp al,[edi]        //Compare to Source Character
    jnz @Return_False   //If no match, break loop

                        //Otherwise continue with next character
    lea esi, [esi+1]    //Inc(Pattern)
    lea edi, [edi+1]    //Inc(Source)
    sub edx, 1          //Dec(Len) - also sets ZF flag
    jnz @BeginLoop      //If Len = 0 then, end loop - pattern is found

  @Return_True:
    mov al,$01
    pop edi
    pop esi
    ret

  @Return_False:
    xor eax, eax

  @EndProc:
    pop edi
    pop esi
    ret

  //Match Pattern
  //var
  //  PatternLength: Integer;
  //begin
  //  PatternLength := Length(Pattern);
  //  case PatternLength of
  //    1:  Result := (Pattern[1] = Source[SourceOffset]);
  //    2:  Result := (Pattern[1] = Source[SourceOffset]) and
  //                  (Pattern[2] = Source[SourceOffset + 1]);
  //    3:  Result := (Pattern[1] = Source[SourceOffset]) and
  //                  (Pattern[2] = Source[SourceOffset + 1]) and
  //                  (Pattern[3] = Source[SourceOffset + 2]);
  //    4:  Result := (Pattern[1] = Source[SourceOffset]) and
  //                  (Pattern[2] = Source[SourceOffset + 1]) and
  //                  (Pattern[3] = Source[SourceOffset + 2]) and
  //                  (Pattern[4] = Source[SourceOffset + 3]);
  //    else
  //      begin
  //        Result := (Pattern[1] = Source[SourceOffset]) and
  //                  (Pattern[2] = Source[SourceOffset + 1]) and
  //                  (Pattern[3] = Source[SourceOffset + 2]) and
  //                  (Pattern[4] = Source[SourceOffset + 3]) and
  //                  (Pattern[5] = Source[SourceOffset + 4]) and
  //                  (ComparePattern(@Pattern[6], @Source[SourceOffset + 5], PatternLength - 5));
  //      end;
  //  end;

  //Compare Pattern
  //begin
  //  Result := True;
  //  while Len <> 0 do
  //    begin
  //      if Pattern^ <> Source^ then
  //        begin
  //          Result := False;
  //          Break;
  //        end;
  //
  //      Inc(Pattern);
  //      Inc(Source);
  //      Dec(Len);
  //    end;

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

  LenRes: Integer;  //In Use length of the Result String

  bMatch: Boolean;  //Set when the old pattern is found in the Source

  SearchStr, Patt: string;

  Buffer: array[0..511] of char; //Bufferred area to hold the string prior to
                                 // adding it to the result set.  The idea is
                                 // to reduce the number of Move and SetLength
                                 // calls that must be made. Trial and error
                                 // used to set buffer length.  Given benchmark
                                 // data, little/no benefits in increasing to
                                 // 1024.
begin
  //Test for empty string in old pattern and source.
  LenOld := Length(OldPattern);
  if LenOld = 0 then
    begin
      Result := S;
      Exit;
    end;

  LenSrc := Length(S);
  if LenSrc = 0 then
    begin
      Result := '';
      Exit;
    end;

  LenNew := Length(NewPattern);

  //When the iChar reaches this point, no match can be made.
  ChkEnd := LenSrc - LenOld + 2;

  if rfIgnoreCase in Flags then
    begin
      //An attempt to speed up the routine by improving the UpperCase function.
      SearchStr := UpperCase_EWC(S);
      Patt := UpperCase_EWC(OldPattern);
    end
  else
    begin
      SearchStr := S;
      Patt := OldPattern;
    end;

  iBuff  := 0;
  iLow   := 1;
  iChar  := 1;

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

      if LenMax = 0 then
        LenMax := Length(Buffer) + 1 //If overflow, force into unbuffered segment.
      else if LenSrc > LenMax then
        LenMax := LenSrc;

      if LenMax > Length(Buffer) then
        begin
          //Initial allocation of result buffer
          //Attempt to determine an intelligent result size for the string.
          //No way to know how many will be replaced, so just default to string size.
          SetLength(Result, LenSrc);

          while iChar < ChkEnd do
            begin
              //An attempt to reduce the number of times the Pattern Match function is called.
              if (Patt[1] = SearchStr[iChar]) and MatchPattern(Patt, SearchStr, iChar) then
                begin
                  //Load Bufferred String
                  iLen := LenRes;
                  //Set the length of Result to include itself, the buffer and new Pattern
                  LenRes := iLen + iChar - iLow + LenNew;
                  if LenRes > Length(Result) then
                    SetLength(Result, LenRes);
                  Move_NoOverlap(S[iLow], Result[iLen + 1], iChar - iLow);

                  //Load New Pattern
                  Inc(iLen, iChar - iLow); //Reset len to match the filled portion of Result
                  if LenNew > 0 then
                    Move_NoOverlap(NewPattern[1], Result[iLen + 1], LenNew);

                  iLow  := iChar + LenOld; //Reposition low pointer
                  iChar := iLow;
                end
              else
                begin
                  Inc(iChar);
                end;
            end;

          //Dump the remainder of the string, if any, to the result.
          if iLow <= LenSrc then // < iChar then
            begin
              iLen := LenRes;
              LenRes := iLen + LenSrc + 1 - iLow;
              if LenRes > Length(Result) then
                SetLength(Result, LenRes);
              Move_NoOverlap(S[iLow], Result[iLen + 1], LenSrc + 1 - iLow);
            end;

          //Trims the buffer if there is any extra space allocated at the end of result
          // due to the initial allocation or reallocations with freespace.
          if LenRes < Length(Result) then
            SetLength(Result, LenRes);
        end
      else
        begin
          //Maximum Length of the result string will fit into the buffer
          // without the need to dump it at intermediate stages.  Therefore,
          // there is no need to check on it.
          while iChar < ChkEnd do
            begin
              //An attempt to reduce the number of times the Pattern Match function is called.

              if (Patt[1] = SearchStr[iChar]) and MatchPattern(Patt, SearchStr, iChar) then
                begin
                  //Load New Pattern
                  if LenNew > 0 then
                    begin
                      Move_NoOverlap(NewPattern[1], Buffer[iBuff], LenNew);
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
            Move_NoOverlap(Buffer, Result[1], iBuff);
        end;
    end
  else
    begin
      bMatch := False;
      while iChar < ChkEnd do
        begin
          if (Patt[1] = SearchStr[iChar]) and MatchPattern(Patt, SearchStr, iChar) then
            begin
              bMatch := True;

              SetLength(Result, LenSrc + LenNew - LenOld);
              iLen := iChar - 1;  //Set up pointer for load new pattern
              if (LenSrc + LenNew - LenOld) = 0 then
                Break;

              //Write out beginning data in the string.
              Move_NoOverlap(S[1], Result[1], iLen);

              //Load New Pattern
              if LenNew > 0 then
                Move_NoOverlap(NewPattern[1], Result[iChar], LenNew);

              //Load Remainder of the String
              Inc(iLen, LenNew);
              iLow := iChar + LenOld;
              if (LenSrc - iLow + 1) > 0 then
                Move_NoOverlap(S[iLow], Result[iLen + 1], LenSrc - iLow + 1);

              Break;
            end
          else
            begin
              Inc(iChar);
            end;
        end;

      //If no match, copy string to result
      if not bMatch then
        begin
          SetLength(Result, LenSrc);
          Move_NoOverlap(S[1], Result[1], LenSrc);
        end;
    end;
end;

var
  i: Integer;

initialization
  for i := 0 to 255 do
    UpperCaseString[i] := Chr(i);
  CharUpperBuff(UpperCaseString, 256);

//    if (Chr(i) >= 'a') and (Chr(i) <= 'z') then
//      UpperCaseString[i] := Chr(i - 32)
//    else
//      UpperCaseString[i] := Chr(i);

end.
