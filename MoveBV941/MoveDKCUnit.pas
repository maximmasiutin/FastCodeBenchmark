unit MoveDKCUnit;

interface

procedure Move_DKC_Pas_16(const Source; var Dest; Count : Integer);
procedure Move_DKC_Pas_37(const Source; var Dest; Count : Integer);
procedure Move_DKC_Pas_38(const Source; var Dest; Count : Integer);
procedure Move_DKC_IA32_1(const Source; var Dest; count : Integer);
procedure Move_DKC_IA32_2(const Source; var Dest; count : Integer);
procedure Move_DKC_IA32_3(const Source; var Dest; count : Integer);
procedure Move_DKC_IA32_4(const Source; var Dest; count : Integer);
procedure Move_DKC_IA32_5(const Source; var Dest; count : Integer);
procedure Move_DKC_SSE_1(const Source; var Dest; Count : Integer);
procedure Move_DKC_SSE2_2(const Source; var Dest; Count : Integer);
procedure Move_DKC_SSE2_3(const Source; var Dest; Count : Integer);
procedure Move_DKC_SSE3_1(const Source; var Dest; Count : Integer);

implementation

uses DKCFastcodeCPUID;

type
 PIntegerArray = ^TIntegerArray;
 TIntegerArray = array[0..MaxInt div 4 -1] of Integer;

var
 L2CACHESIZE : Integer;


//Author:            Dennis Kjaer Christensen
//Date:              19/5 2006
//Instructionset(s): IA32

procedure Move_DKC_Pas_16(const Source; var Dest; Count : Integer);
var
 IntNo, NoOfIntMoves, NoOfByteMoves, NoOfIntLoops, SourceAddress, DestAddress : Cardinal;
 SrcI, DstI : PIntegerArray;
 SrcB, DstB : PChar;
 NeedRewMove : Boolean;
 ByteNo, EndOfByteMoves : Integer;
begin
 if Count <= 0 then
  Exit;
 //Detect the need for rewerse move in overlapped case
 SourceAddress := Cardinal(@Source);
 DestAddress := Cardinal(@Dest);
 if SourceAddress = DestAddress then
  Exit;
 NeedRewMove := False;
 if (DestAddress > SourceAddress) then
  if ((DestAddress - SourceAddress) < Cardinal(Count)) then
   NeedRewMove := True;
 SrcI := @Source;
 DstI := @Dest;
 SrcB := @Source;
 DstB := @Dest;
 if not NeedRewMove then
  begin
   //Forward move
   if Count >= 8 then
    begin
     NoOfIntLoops  := Count div 8;
     NoOfIntMoves := NoOfIntLoops * 2;
     if(NoOfIntMoves > 0) then
      begin
       IntNo := 0;
       repeat
        DstI[IntNo] := SrcI[IntNo];
        Inc(IntNo);
        DstI[IntNo] := SrcI[IntNo];
        Inc(IntNo);
       until(IntNo >= NoOfIntMoves);
      end;
     NoOfByteMoves := Cardinal(Count) - 8 * NoOfIntLoops;
     if(NoOfByteMoves > 0) then
      begin
       ByteNo := NoOfIntMoves*4;
       EndOfByteMoves := NoOfIntMoves*4 + NoOfByteMoves;
       repeat
        DstB[ByteNo] := SrcB[ByteNo];
        Inc(ByteNo);
       until(ByteNo >= EndOfByteMoves);
      end;
    end
   else
    begin
     ByteNo := 0;
     repeat
      DstB[ByteNo] := SrcB[ByteNo];
      Inc(ByteNo);
     until(ByteNo >= Count);
    end;
  end
 else
  begin
   //Rewerse move
   repeat
    DstB[Count-1] := SrcB[Count-1];
    Dec(Count);
   until(Count <= 0);
  end;
end;


//Author:            Dennis Kjaer Christensen
//Date:              22/5 2006
//Instructionset(s): IA32

procedure Move_DKC_Pas_37(const Source; var Dest; Count : Integer);
var
 SrcI, DstI : PIntegerArray;
 SrcB, DstB : PChar;
 NoOfByteMoves, IntNo, ByteNo, EndOfByteMoves, NoOfIntMoves : Integer;
 NoOfIntLoops, DestAddress2, MisAlignment : Cardinal;
 NeedRewMove : Boolean;

label L1;

begin
 if Count <= 0 then
  Exit;
 //Detect the need for rewerse move in overlapped case
 if Cardinal(@Source) = Cardinal(@Dest) then
  Exit;
 NeedRewMove := False;
 if (Cardinal(@Dest) > Cardinal(@Source)) then
  if ((Cardinal(@Dest) - Cardinal(@Source)) < Cardinal(Count)) then
   NeedRewMove := True;
 if not NeedRewMove then
  begin
   //Forward move
   case Count of
    1:
     begin
      PChar(@Dest)[0] := PChar(@Source)[0];
     end;
    2:
     begin
      PChar(@Dest)[0] := PChar(@Source)[0];
      PChar(@Dest)[1] := PChar(@Source)[1];
     end;
    3:
     begin
      PChar(@Dest)[0] := PChar(@Source)[0];
      PChar(@Dest)[1] := PChar(@Source)[1];
      PChar(@Dest)[2] := PChar(@Source)[2];
     end;
    4:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
     end;
    5:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PChar(@Dest)[4] := PChar(@Source)[4];
     end;
    6:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PChar(@Dest)[4] := PChar(@Source)[4];
      PChar(@Dest)[5] := PChar(@Source)[5];
     end;
    7:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PChar(@Dest)[4] := PChar(@Source)[4];
      PChar(@Dest)[5] := PChar(@Source)[5];
      PChar(@Dest)[6] := PChar(@Source)[6];
     end;
    8:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
     end;
    9:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PChar(@Dest)[8] := PChar(@Source)[8];
     end;
    10:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PChar(@Dest)[8] := PChar(@Source)[8];
      PChar(@Dest)[9] := PChar(@Source)[9];
     end;
    11:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PChar(@Dest)[8] := PChar(@Source)[8];
      PChar(@Dest)[9] := PChar(@Source)[9];
      PChar(@Dest)[10] := PChar(@Source)[10];
     end;
    12:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
     end;
    13:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PChar(@Dest)[12] := PChar(@Source)[12];
     end;
    14:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PChar(@Dest)[12] := PChar(@Source)[12];
      PChar(@Dest)[13] := PChar(@Source)[13];
     end;
    15:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PChar(@Dest)[12] := PChar(@Source)[12];
      PChar(@Dest)[13] := PChar(@Source)[13];
      PChar(@Dest)[14] := PChar(@Source)[14];
     end;
    16:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
     end;
    17:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PChar(@Dest)[16] := PChar(@Source)[16];
     end;
    18:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PChar(@Dest)[16] := PChar(@Source)[16];
      PChar(@Dest)[17] := PChar(@Source)[17];
     end;
    19:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PChar(@Dest)[16] := PChar(@Source)[16];
      PChar(@Dest)[17] := PChar(@Source)[17];
      PChar(@Dest)[18] := PChar(@Source)[18];
     end;
    20:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
     end;
    21:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PChar(@Dest)[20] := PChar(@Source)[20];
     end;
    22:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PChar(@Dest)[20] := PChar(@Source)[20];
      PChar(@Dest)[21] := PChar(@Source)[21];
     end;
    23:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PChar(@Dest)[20] := PChar(@Source)[20];
      PChar(@Dest)[21] := PChar(@Source)[21];
      PChar(@Dest)[22] := PChar(@Source)[22];
     end;
    24:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
     end;
    25:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PChar(@Dest)[24] := PChar(@Source)[24];
     end;
    26:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PChar(@Dest)[24] := PChar(@Source)[24];
      PChar(@Dest)[25] := PChar(@Source)[25];
     end;
    27:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PChar(@Dest)[24] := PChar(@Source)[24];
      PChar(@Dest)[25] := PChar(@Source)[25];
      PChar(@Dest)[26] := PChar(@Source)[26];
     end;
    28:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
     end;
    29:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
      PChar(@Dest)[28] := PChar(@Source)[28];
     end;
    30:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
      PChar(@Dest)[28] := PChar(@Source)[28];
      PChar(@Dest)[29] := PChar(@Source)[29];
     end;
    31:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
      PChar(@Dest)[28] := PChar(@Source)[28];
      PChar(@Dest)[29] := PChar(@Source)[29];
      PChar(@Dest)[30] := PChar(@Source)[30];
     end;
    32:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
      PIntegerArray(@Dest)[7] := PIntegerArray(@Source)[7];
     end;
    else
     begin
      //4 byte align source
      DestAddress2 := Cardinal(@Dest);
      MisAlignment := DestAddress2 mod 4;
      if MisAlignment = 0 then
       goto L1;
      PChar(@Dest)[0] := PChar(@Source)[0];
      if MisAlignment = 1 then
       goto L1;
      PChar(@Dest)[1] := PChar(@Source)[1];
      if MisAlignment = 2 then
       goto L1;
      PChar(@Dest)[2] := PChar(@Source)[2];
     L1 :
      SrcI := @Source;
      DstI := @Dest;
      Inc(PChar(SrcI), MisAlignment);
      Inc(PChar(DstI), MisAlignment);
      SrcB := PChar(SrcI);
      DstB := PChar(DstI);
      Count := Cardinal(Count) - MisAlignment;
      NoOfIntLoops  := Count div 8;
      NoOfIntMoves := NoOfIntLoops * 2;
      NoOfByteMoves := Cardinal(Count) - 8 * NoOfIntLoops;
      if(NoOfIntMoves > 0) then
       begin
        IntNo := 0;
        repeat
         DstI[IntNo] := SrcI[IntNo];
         Inc(IntNo);
         DstI[IntNo] := SrcI[IntNo];
         Inc(IntNo);
        until(IntNo >= NoOfIntMoves);
       end;
      if(NoOfByteMoves > 0) then
       begin
        ByteNo := NoOfIntMoves*4;
        EndOfByteMoves := NoOfIntMoves*4 + NoOfByteMoves;
        repeat
         DstB[ByteNo] := SrcB[ByteNo];
         Inc(ByteNo);
         if (ByteNo >= EndOfByteMoves) then
          Break;
         DstB[ByteNo] := SrcB[ByteNo];
         Inc(ByteNo);
        until(ByteNo >= EndOfByteMoves);
       end;
     end;
   end;
  end
 else
  begin
   //Rewerse move
   if Count >= 16 then
    begin
     NoOfIntMoves  := Count shr 2;
     EndOfByteMoves := NoOfIntMoves shl 2;
     NoOfByteMoves := Count - EndOfByteMoves;
     if(NoOfByteMoves > 0) then
      begin
       repeat
        Dec(Count);
        PChar(@Dest)[Count] := PChar(@Source)[Count];
        if Count <= EndOfByteMoves then
         Break;
        Dec(Count);
        PChar(@Dest)[Count] := PChar(@Source)[Count];
       until(Count <= EndOfByteMoves);
      end;
     if(NoOfIntMoves > 0) then
      begin
       repeat
        Dec(NoOfIntMoves);
        PIntegerArray(@Dest)[NoOfIntMoves] := PIntegerArray(@Source)[NoOfIntMoves];
        if NoOfIntMoves <= 0 then
         Break;
        Dec(NoOfIntMoves);
        PIntegerArray(@Dest)[NoOfIntMoves] := PIntegerArray(@Source)[NoOfIntMoves];
       until(NoOfIntMoves <= 0);
      end;
    end
   else
    begin
     repeat
      Dec(Count);
      PChar(@Dest)[Count] := PChar(@Source)[Count];
      if Count <= 0 then
       Break;
      Dec(Count);
      PChar(@Dest)[Count] := PChar(@Source)[Count];
      if Count <= 0 then
       Break;
      Dec(Count);
      PChar(@Dest)[Count] := PChar(@Source)[Count];
      if Count <= 0 then
       Break;
      Dec(Count);
      PChar(@Dest)[Count] := PChar(@Source)[Count];
     until(Count <= 0);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              22/5 2006
//Instructionset(s): IA32

procedure Move_DKC_Pas_38(const Source; var Dest; Count : Integer);
var
 SrcI, DstI : PIntegerArray;
 SrcB, DstB : PChar;
 NoOfByteMoves, IntNo, ByteNo, EndOfByteMoves, NoOfIntMoves : Integer;
 NoOfIntLoops, DestAddress2, MisAlignment : Cardinal;
 NeedRewMove : Boolean;

label L1;

begin
 if Count <= 0 then
  Exit;
 //Detect the need for rewerse move in overlapped case
 if Cardinal(@Source) = Cardinal(@Dest) then
  Exit;
 NeedRewMove := False;
 if (Cardinal(@Dest) > Cardinal(@Source)) then
  if ((Cardinal(@Dest) - Cardinal(@Source)) < Cardinal(Count)) then
   NeedRewMove := True;
 if not NeedRewMove then
  begin
   //Forward move
   case Count of
    1:
     begin
      PChar(@Dest)[0] := PChar(@Source)[0];
     end;
    2:
     begin
      PChar(@Dest)[0] := PChar(@Source)[0];
      PChar(@Dest)[1] := PChar(@Source)[1];
     end;
    3:
     begin
      PChar(@Dest)[0] := PChar(@Source)[0];
      PChar(@Dest)[1] := PChar(@Source)[1];
      PChar(@Dest)[2] := PChar(@Source)[2];
     end;
    4:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
     end;
    5:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PChar(@Dest)[4] := PChar(@Source)[4];
     end;
    6:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PChar(@Dest)[4] := PChar(@Source)[4];
      PChar(@Dest)[5] := PChar(@Source)[5];
     end;
    7:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PChar(@Dest)[4] := PChar(@Source)[4];
      PChar(@Dest)[5] := PChar(@Source)[5];
      PChar(@Dest)[6] := PChar(@Source)[6];
     end;
    8:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
     end;
    9:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PChar(@Dest)[8] := PChar(@Source)[8];
     end;
    10:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PChar(@Dest)[8] := PChar(@Source)[8];
      PChar(@Dest)[9] := PChar(@Source)[9];
     end;
    11:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PChar(@Dest)[8] := PChar(@Source)[8];
      PChar(@Dest)[9] := PChar(@Source)[9];
      PChar(@Dest)[10] := PChar(@Source)[10];
     end;
    12:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
     end;
    13:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PChar(@Dest)[12] := PChar(@Source)[12];
     end;
    14:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PChar(@Dest)[12] := PChar(@Source)[12];
      PChar(@Dest)[13] := PChar(@Source)[13];
     end;
    15:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PChar(@Dest)[12] := PChar(@Source)[12];
      PChar(@Dest)[13] := PChar(@Source)[13];
      PChar(@Dest)[14] := PChar(@Source)[14];
     end;
    16:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
     end;
    17:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PChar(@Dest)[16] := PChar(@Source)[16];
     end;
    18:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PChar(@Dest)[16] := PChar(@Source)[16];
      PChar(@Dest)[17] := PChar(@Source)[17];
     end;
    19:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PChar(@Dest)[16] := PChar(@Source)[16];
      PChar(@Dest)[17] := PChar(@Source)[17];
      PChar(@Dest)[18] := PChar(@Source)[18];
     end;
    20:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
     end;
    21:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PChar(@Dest)[20] := PChar(@Source)[20];
     end;
    22:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PChar(@Dest)[20] := PChar(@Source)[20];
      PChar(@Dest)[21] := PChar(@Source)[21];
     end;
    23:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PChar(@Dest)[20] := PChar(@Source)[20];
      PChar(@Dest)[21] := PChar(@Source)[21];
      PChar(@Dest)[22] := PChar(@Source)[22];
     end;
    24:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
     end;
    25:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PChar(@Dest)[24] := PChar(@Source)[24];
     end;
    26:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PChar(@Dest)[24] := PChar(@Source)[24];
      PChar(@Dest)[25] := PChar(@Source)[25];
     end;
    27:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PChar(@Dest)[24] := PChar(@Source)[24];
      PChar(@Dest)[25] := PChar(@Source)[25];
      PChar(@Dest)[26] := PChar(@Source)[26];
     end;
    28:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
     end;
    29:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
      PChar(@Dest)[28] := PChar(@Source)[28];
     end;
    30:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
      PChar(@Dest)[28] := PChar(@Source)[28];
      PChar(@Dest)[29] := PChar(@Source)[29];
     end;
    31:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
      PChar(@Dest)[28] := PChar(@Source)[28];
      PChar(@Dest)[29] := PChar(@Source)[29];
      PChar(@Dest)[30] := PChar(@Source)[30];
     end;
    32:
     begin
      PIntegerArray(@Dest)[0] := PIntegerArray(@Source)[0];
      PIntegerArray(@Dest)[1] := PIntegerArray(@Source)[1];
      PIntegerArray(@Dest)[2] := PIntegerArray(@Source)[2];
      PIntegerArray(@Dest)[3] := PIntegerArray(@Source)[3];
      PIntegerArray(@Dest)[4] := PIntegerArray(@Source)[4];
      PIntegerArray(@Dest)[5] := PIntegerArray(@Source)[5];
      PIntegerArray(@Dest)[6] := PIntegerArray(@Source)[6];
      PIntegerArray(@Dest)[7] := PIntegerArray(@Source)[7];
     end;
    else
     begin
      //4 byte align source
      DestAddress2 := Cardinal(@Dest);
      MisAlignment := DestAddress2 mod 4;
      if MisAlignment = 0 then
       goto L1;
      PChar(@Dest)[0] := PChar(@Source)[0];
      if MisAlignment = 1 then
       goto L1;
      PChar(@Dest)[1] := PChar(@Source)[1];
      if MisAlignment = 2 then
       goto L1;
      PChar(@Dest)[2] := PChar(@Source)[2];
     L1 :
      SrcI := @Source;
      DstI := @Dest;
      Inc(PChar(SrcI), MisAlignment);
      Inc(PChar(DstI), MisAlignment);
      SrcB := PChar(SrcI);
      DstB := PChar(DstI);
      Count := Cardinal(Count) - MisAlignment;
      NoOfIntLoops  := Count shr 3;
      NoOfIntMoves := NoOfIntLoops * 2;
      NoOfByteMoves := Cardinal(Count) - 8 * NoOfIntLoops;
      if(NoOfIntMoves > 0) then
       begin
        IntNo := 0;
        repeat
         DstI[IntNo] := SrcI[IntNo];
         Inc(IntNo);
         DstI[IntNo] := SrcI[IntNo];
         Inc(IntNo);
        until(IntNo >= NoOfIntMoves);
       end;
      if(NoOfByteMoves > 0) then
       begin
        ByteNo := NoOfIntMoves*4;
        EndOfByteMoves := ByteNo + NoOfByteMoves;
        repeat
         DstB[ByteNo] := SrcB[ByteNo];
         Inc(ByteNo);
         if (ByteNo >= EndOfByteMoves) then
          Break;
         DstB[ByteNo] := SrcB[ByteNo];
         Inc(ByteNo);
        until(ByteNo >= EndOfByteMoves);
       end;
     end;
   end;
  end
 else
  begin
   //Rewerse move
   if Count >= 16 then
    begin
     NoOfIntMoves  := Count shr 2;
     EndOfByteMoves := NoOfIntMoves shl 2;
     NoOfByteMoves := Count - EndOfByteMoves;
     if(NoOfByteMoves > 0) then
      begin
       repeat
        Dec(Count);
        PChar(@Dest)[Count] := PChar(@Source)[Count];
        if Count <= EndOfByteMoves then
         Break;
        Dec(Count);
        PChar(@Dest)[Count] := PChar(@Source)[Count];
       until(Count <= EndOfByteMoves);
      end;
     if(NoOfIntMoves > 0) then
      begin
       repeat
        Dec(NoOfIntMoves);
        PIntegerArray(@Dest)[NoOfIntMoves] := PIntegerArray(@Source)[NoOfIntMoves];
        if NoOfIntMoves <= 0 then
         Break;
        Dec(NoOfIntMoves);
        PIntegerArray(@Dest)[NoOfIntMoves] := PIntegerArray(@Source)[NoOfIntMoves];
       until(NoOfIntMoves <= 0);
      end;
    end
   else
    begin
     repeat
      Dec(Count);
      PChar(@Dest)[Count] := PChar(@Source)[Count];
      if Count <= 0 then
       Break;
      Dec(Count);
      PChar(@Dest)[Count] := PChar(@Source)[Count];
      if Count <= 0 then
       Break;
      Dec(Count);
      PChar(@Dest)[Count] := PChar(@Source)[Count];
      if Count <= 0 then
       Break;
      Dec(Count);
      PChar(@Dest)[Count] := PChar(@Source)[Count];
     until(Count <= 0);
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/1 2005
//Optimized for:     RTL Replacement
//Instructionset(s): IA32

procedure Move_DKC_IA32_1(const Source; var Dest; count : Integer);
asm
   push  ebx
   test  ecx,ecx
   jle   @Exit
   cmp   edx,eax
   jz    @Exit
   jb    @ForwardMove
   mov   ebx,edx
   sub   ebx,eax
   cmp   ebx,ecx
   jb    @RewerseMove
 @ForwardMove :
   cmp   ecx,7
   ja    @ForwardLoop
   jmp   dword ptr [ecx*4+@Case1JmpTable]
 @ForwardCaseCount1:
   mov  bl, [eax]
   mov  [edx],bl
   jmp  @Exit
 @ForwardCaseCount2:
   mov  bx,[eax]
   mov  [edx],bx
   jmp  @Exit
 @ForwardCaseCount3:
   mov  bx,[eax]
   mov  [edx],bx
   mov  bl,[eax+2]
   mov  [edx+2],bl
   jmp  @Exit
 @ForwardCaseCount4:
   mov  ebx,[eax]
   mov  [edx],ebx
   jmp  @Exit
 @ForwardCaseCount5:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bl,[eax+4]
   mov  [edx+4],bl
   jmp  @Exit
 @ForwardCaseCount6:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bx,[eax+4]
   mov  [edx+4],bx
   jmp  @Exit
 @ForwardCaseCount7:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bx,[eax+4]
   mov  [edx+4],bx
   mov  bl,[eax+6]
   mov  [edx+6],bl
 @ForwardCaseCount0:
   jmp  @Exit
 @ForwardLoop :
   push  edi
   xor   edi,edi
   sub   ecx,7
 @ForwardLoopBegin :
   fild  qword ptr [eax+edi]
   fistp qword ptr [edx+edi]
   add   edi,8
   cmp   edi,ecx
   jb    @ForwardLoopBegin
   add   ecx,7
   cmp   edi,ecx
   jae   @ByteMoveEnd1
 @ForLoop3Begin :
   mov   bl,[eax+edi]
   mov   [edx+edi],bl
   add   edi,1
   cmp   edi,ecx
   jnz   @ForLoop3Begin
 @ByteMoveEnd1 :
   pop   edi
   jmp   @Exit
 @RewerseMove :
   cmp   ecx,8
   jb    @ForLoop1Begin
 @ForLoop4Begin :
   sub   ecx,8
   mov   ebx,[eax+ecx+4]
   mov   [edx+ecx+4],ebx
   mov   ebx,[eax+ecx]
   mov   [edx+ecx],ebx
   cmp   ecx,8
   jae   @ForLoop4Begin
   cmp   ecx,0
   jbe   @Exit
 @ForLoop1Begin :
   sub   ecx,1
   mov   bl,[eax+ecx]
   mov   [edx+ecx],bl
   jnz   @ForLoop1Begin
 @Exit :
   pop   ebx
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

end;

//Author:            Dennis Kjaer Christensen
//Date:              31/1 2005
//Optimized for:     RTL Replacement
//Instructionset(s): IA32

procedure Move_DKC_IA32_2(const Source; var Dest; count : Integer);
asm
   push  ebx
   test  ecx,ecx
   jle   @Exit
   cmp   edx,eax
   jz    @Exit
   jb    @ForwardMove
   mov   ebx,edx
   sub   ebx,eax
   cmp   ebx,ecx
   jb    @RewerseMove
 @ForwardMove :
   cmp   ecx,7
   ja    @ForwardLoop
   jmp   dword ptr [ecx*4+@Case1JmpTable]
 @ForwardCaseCount1:
   mov  bl, [eax]
   mov  [edx],bl
   jmp  @Exit
 @ForwardCaseCount2:
   mov  bx,[eax]
   mov  [edx],bx
   jmp  @Exit
 @ForwardCaseCount3:
   mov  bx,[eax]
   mov  [edx],bx
   mov  bl,[eax+2]
   mov  [edx+2],bl
   jmp  @Exit
 @ForwardCaseCount4:
   mov  ebx,[eax]
   mov  [edx],ebx
   jmp  @Exit
 @ForwardCaseCount5:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bl,[eax+4]
   mov  [edx+4],bl
   jmp  @Exit
 @ForwardCaseCount6:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bx,[eax+4]
   mov  [edx+4],bx
   jmp  @Exit
 @ForwardCaseCount7:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bx,[eax+4]
   mov  [edx+4],bx
   mov  bl,[eax+6]
   mov  [edx+6],bl
 @ForwardCaseCount0:
   jmp  @Exit
 @ForwardLoop :
   push  edi
   xor   edi,edi
   cmp   ecx,132
   Jb    @L222
   push  esi
   mov   ebx,edx
   and   ebx,$07
   mov   esi,8
   sub   esi,ebx
   test  esi,esi
   jz    @L222
 @XL111:
   mov   bl, [eax+edi]
   mov   [edx+edi], bl
   add   edi, 1
   cmp   edi, esi
   jb    @XL111
   pop   esi
 @L222 :
   sub   ecx,7
 @ForwardLoopBegin :
   fild  qword ptr [eax+edi]
   fistp qword ptr [edx+edi]
   add   edi,8
   cmp   edi,ecx
   jb    @ForwardLoopBegin
   add   ecx,7
   cmp   edi,ecx
   jae   @ByteMoveEnd1
 @ForLoop3Begin :
   mov   bl,[eax+edi]
   mov   [edx+edi],bl
   add   edi,1
   cmp   edi,ecx
   jnz   @ForLoop3Begin
 @ByteMoveEnd1 :
   pop   edi
   jmp   @Exit
 @RewerseMove :
   cmp   ecx,8
   jb    @ForLoop1Begin
 @ForLoop4Begin :
   sub   ecx,8
   mov   ebx,[eax+ecx+4]
   mov   [edx+ecx+4],ebx
   mov   ebx,[eax+ecx]
   mov   [edx+ecx],ebx
   cmp   ecx,8
   jae   @ForLoop4Begin
   cmp   ecx,0
   jbe   @Exit
 @ForLoop1Begin :
   sub   ecx,1
   mov   bl,[eax+ecx]
   mov   [edx+ecx],bl
   jnz   @ForLoop1Begin
 @Exit :
   pop   ebx
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

end;

//Author:            Dennis Kjaer Christensen
//Date:              28/2 2005
//Optimized for:     RTL Replacement
//Instructionset(s): IA32

procedure Move_DKC_IA32_3(const Source; var Dest; count : Integer);
asm
   push  ebx
   test  ecx,ecx
   jle   @Exit
   cmp   edx,eax
   jz    @Exit
   jb    @ForwardMove
   mov   ebx,edx
   sub   ebx,eax
   cmp   ebx,ecx
   jb    @RewerseMove
 @ForwardMove :
   cmp   ecx,7
   ja    @ForwardLoop
   jmp   dword ptr [ecx*4+@Case1JmpTable]
 @ForwardCaseCount1:
   mov  bl, [eax]
   mov  [edx],bl
   jmp  @Exit
 @ForwardCaseCount2:
   mov  bx,[eax]
   mov  [edx],bx
   jmp  @Exit
 @ForwardCaseCount3:
   mov  bx,[eax]
   mov  [edx],bx
   mov  bl,[eax+2]
   mov  [edx+2],bl
   jmp  @Exit
 @ForwardCaseCount4:
   mov  ebx,[eax]
   mov  [edx],ebx
   jmp  @Exit
 @ForwardCaseCount5:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bl,[eax+4]
   mov  [edx+4],bl
   jmp  @Exit
 @ForwardCaseCount6:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bx,[eax+4]
   mov  [edx+4],bx
   jmp  @Exit
 @ForwardCaseCount7:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bx,[eax+4]
   mov  [edx+4],bx
   mov  bl,[eax+6]
   mov  [edx+6],bl
 @ForwardCaseCount0:
   jmp  @Exit
 @ForwardLoop :
   push  edi
   xor   edi,edi
   cmp   ecx,132
   Jb    @L222
   push  esi
   mov   ebx,edx
   and   ebx,$07
   mov   esi,8
   sub   esi,ebx
   test  esi,esi
   jz    @L222
 @XL111:
   mov   bl, [eax+edi]
   mov   [edx+edi], bl
   add   edi, 1
   cmp   edi, esi
   jb    @XL111
   pop   esi
 @L222 :
   sub   ecx,7
 @ForwardLoopBegin :
   fild  qword ptr [eax+edi]
   fistp qword ptr [edx+edi]
   add   edi,8
   cmp   edi,ecx
   jb    @ForwardLoopBegin
   add   ecx,7
   cmp   edi,ecx
   jae   @ByteMoveEnd1
 @ForLoop3Begin :
   mov   bl,[eax+edi]
   mov   [edx+edi],bl
   add   edi,1
   cmp   edi,ecx
   jnz   @ForLoop3Begin
 @ByteMoveEnd1 :
   pop   edi
   jmp   @Exit
 @RewerseMove :
   cmp   ecx,8
   jb    @ForLoop1Begin
 @ForLoop4Begin :
   sub   ecx,8
   mov   ebx,[eax+ecx+4]
   mov   [edx+ecx+4],ebx
   mov   ebx,[eax+ecx]
   mov   [edx+ecx],ebx
   cmp   ecx,8
   jae   @ForLoop4Begin
   cmp   ecx,0
   jbe   @Exit
 @ForLoop1Begin :
   sub   ecx,1
   mov   bl,[eax+ecx]
   mov   [edx+ecx],bl
   jnz   @ForLoop1Begin
 @Exit :
   pop   ebx
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

end;

//Author:            Dennis Kjaer Christensen
//Date:              4/3 2005
//Optimized for:     RTL Replacement
//Instructionset(s): IA32

procedure Move_DKC_IA32_4(const Source; var Dest; count : Integer);
asm
   push  ebx
   test  ecx,ecx
   jle   @Exit
   cmp   edx,eax
   jz    @Exit
   jb    @ForwardMove
   mov   ebx,edx
   sub   ebx,eax
   cmp   ebx,ecx
   jb    @RewerseMove
 @ForwardMove :
   cmp   ecx,7
   ja    @ForwardLoop
   jmp   dword ptr [ecx*4+@Case1JmpTable]
 @ForwardCaseCount1:
   mov  bl, [eax]
   mov  [edx],bl
   jmp  @Exit
 @ForwardCaseCount2:
   mov  bx,[eax]
   mov  [edx],bx
   jmp  @Exit
 @ForwardCaseCount3:
   mov  bx,[eax]
   mov  [edx],bx
   mov  bl,[eax+2]
   mov  [edx+2],bl
   jmp  @Exit
 @ForwardCaseCount4:
   mov  ebx,[eax]
   mov  [edx],ebx
   jmp  @Exit
 @ForwardCaseCount5:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bl,[eax+4]
   mov  [edx+4],bl
   jmp  @Exit
 @ForwardCaseCount6:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bx,[eax+4]
   mov  [edx+4],bx
   jmp  @Exit
 @ForwardCaseCount7:
   mov  ebx,[eax]
   mov  [edx],ebx
   mov  bx,[eax+4]
   mov  [edx+4],bx
   mov  bl,[eax+6]
   mov  [edx+6],bl
 @ForwardCaseCount0:
   jmp  @Exit
 @ForwardLoop :
   push  edi
   xor   edi,edi
   cmp   ecx,132
   Jb    @L222
   push  esi
   mov   ebx,edx
   and   ebx,$07
   mov   esi,8
   sub   esi,ebx
   test  esi,esi
   jz    @L222
 @XL111:
   mov   bl, [eax+edi]
   mov   [edx+edi], bl
   add   edi, 1
   cmp   edi, esi
   jb    @XL111
   pop   esi
 @L222 :
   sub   ecx,7
 @ForwardLoopBegin :
   fild  qword ptr [eax+edi]
   fistp qword ptr [edx+edi]
   add   edi,8
   cmp   edi,ecx
   jb    @ForwardLoopBegin
   add   ecx,7
   cmp   edi,ecx
   jae   @ByteMoveEnd1
 @ForLoop3Begin :
   mov   bl,[eax+edi]
   mov   [edx+edi],bl
   add   edi,1
   cmp   edi,ecx
   jnz   @ForLoop3Begin
 @ByteMoveEnd1 :
   pop   edi
   jmp   @Exit
 @RewerseMove :
   cmp   ecx,8
   jb    @ForLoop1Begin
 @ForLoop4Begin :
   sub   ecx,8
   fild  qword ptr [eax+ecx]
   fistp qword ptr [edx+ecx]

//   mov   ebx,[eax+ecx+4]
//   mov   [edx+ecx+4],ebx
//   mov   ebx,[eax+ecx]
//   mov   [edx+ecx],ebx
   cmp   ecx,8
   jae   @ForLoop4Begin
   cmp   ecx,0
   jbe   @Exit
 @ForLoop1Begin :
   sub   ecx,1
   mov   bl,[eax+ecx]
   mov   [edx+ecx],bl
   jnz   @ForLoop1Begin
 @Exit :
   pop   ebx
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

end;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Optimized for:     RTL Replacement
//Instructionset(s): IA32

procedure Move_DKC_IA32_5(const Source; var Dest; count : Integer);
asm
 cmp   ecx, 0
 jle   @Exit
 cmp   edx,eax
 jz    @Exit
 ja    @ElseBegin
 push  ebx
 push  edi
 xor   edi,edi
 cmp   ecx,8
 jb    @ForLoop3Begin
 sub   ecx,7
@ForLoop2Begin :
 fild  qword ptr [eax+edi]
 fistp qword ptr [edx+edi]
 add   edi,8
 cmp   edi,ecx
 jb    @ForLoop2Begin
 add   ecx,7
 cmp   edi,ecx
 jae   @ByteMoveEnd1
@ForLoop3Begin :
 mov   bl,[eax+edi]
 mov   [edx+edi],bl
 add   edi,1
 cmp   edi,ecx
 jnz   @ForLoop3Begin
@ByteMoveEnd1 :
 pop   edi
 pop   ebx
 ret
@ElseBegin :
 push  ebx
 cmp   ecx,8
 jb    @ForLoop1Begin
@ForLoop4Begin :
 sub   ecx,8
 mov  ebx,[eax+ecx+4]
 mov  [edx+ecx+4],ebx
 mov  ebx,[eax+ecx]
 mov  [edx+ecx],ebx
 cmp   ecx,8
 jae   @ForLoop4Begin
 cmp   ecx,0
 jbe   @ByteMoveEnd2
@ForLoop1Begin :
 sub   ecx,1
 mov   bl,[eax+ecx]
 mov   [edx+ecx],bl
 jnz   @ForLoop1Begin
@ByteMoveEnd2 :
 pop   ebx
@Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/2 2005
//Optimized for:     P4 Northwood
//Instructionset(s): IA32, MMX, SSE, SSE2
//Under development

procedure TinyMoves(const Source; var Dest; Count : Integer);
asm
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
     //jmp     @Exit

 @Exit :
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


end;

//Author:            Dennis Kjaer Christensen
//Date:              10/6 2004
//Optimized for:     Opteron
//Instructionset(s): IA32, MMX, SSE

procedure Move_DKC_SSE_1(const Source; var Dest; Count : Integer);
asm
     //Exit if Count is negative
     test    ecx, ecx
     js      @Exit
     //Detect the need for rewerse move in overlapped case
     cmp     eax, edx                   // if (DestAddress > SourceAddress) then
     jnb     @ForwardMove
     push    ebx
     mov     ebx, edx
     sub     ebx, eax                   // (DestAddress - SourceAddress)
     cmp     ebx, edx                   // if ((DestAddress - SourceAddress) < Count) then
     pop     ebx
     jb      @RewMove
@ForwardMove:
     cmp     ecx, 55
     jnbe    @ForwardCaseElse
     jmp     dword ptr [ecx*4+@Case1JmpTable]
@ForwardCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
@ForwardCaseCount0:
     ret
@ForwardCaseCount2:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     ret
@ForwardCaseCount3:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax+2]
     mov     [edx+2], cl
     ret
@ForwardCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@ForwardCaseCount5:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     ret
@ForwardCaseCount6:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     ret
@ForwardCaseCount7:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+6]
     mov     [edx+6], cl
     ret
@ForwardCaseCount8:
     movq    mm0, [eax]
     movq    [edx], mm0
     emms
     ret
@ForwardCaseCount9:
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     emms
     ret
@ForwardCaseCount10 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     emms
     ret
@ForwardCaseCount11 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+10]
     mov     [edx+10], cl
     emms
     ret
@ForwardCaseCount12:
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     emms
     ret
@ForwardCaseCount13 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     emms
     ret
@ForwardCaseCount14 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     emms
     ret
@ForwardCaseCount15 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+14]
     mov     [edx+14], cl
     emms
     ret
@ForwardCaseCount16 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     emms
     ret
@ForwardCaseCount17 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     emms
     ret
@ForwardCaseCount18 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     emms
     ret
@ForwardCaseCount19 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+18]
     mov     [edx+18], cl
     emms
     ret
@ForwardCaseCount20 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     emms
     ret
@ForwardCaseCount21 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     emms
     ret
@ForwardCaseCount22 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     emms
     ret
@ForwardCaseCount23 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+22]
     mov     [edx+22], cl
     emms
     ret
@ForwardCaseCount24 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     emms
     ret
@ForwardCaseCount25 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     emms
     ret
@ForwardCaseCount26 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     emms
     ret
@ForwardCaseCount27 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+26]
     mov     [edx+26], cl
     emms
     ret
@ForwardCaseCount28 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     emms
     ret
@ForwardCaseCount29 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     emms
     ret
@ForwardCaseCount30 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     emms
     ret
@ForwardCaseCount31 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+30]
     mov     [edx+30], cl
     emms
     ret
@ForwardCaseCount32 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     emms
     ret
@ForwardCaseCount33 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     emms
     ret
@ForwardCaseCount34 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     emms
     ret
@ForwardCaseCount35 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+34]
     mov     [edx+34], cl
     emms
     ret
@ForwardCaseCount36 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     emms
     ret
@ForwardCaseCount37 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     emms
     ret
@ForwardCaseCount38 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     emms
     ret
@ForwardCaseCount39 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+38]
     mov     [edx+38], cl
     emms
     ret
@ForwardCaseCount40 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     emms
     ret
@ForwardCaseCount41 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     emms
     ret
@ForwardCaseCount42 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     emms
     ret
@ForwardCaseCount43 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+42]
     mov     [edx+42], cl
     emms
     ret
@ForwardCaseCount44 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     emms
     ret
@ForwardCaseCount45 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     emms
     ret
@ForwardCaseCount46 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     emms
     ret
@ForwardCaseCount47 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+46]
     mov     [edx+46], cl
     emms
     ret
@ForwardCaseCount48 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     emms
     ret
@ForwardCaseCount49 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     emms
     ret
@ForwardCaseCount50 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     emms
     ret
@ForwardCaseCount51 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     emms
     ret
@ForwardCaseCount52 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     emms
     ret
@ForwardCaseCount53 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     emms
     ret
@ForwardCaseCount54 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     emms
     ret
@ForwardCaseCount55 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl,[eax+54]
     mov     [edx+54],cl
     emms
     ret
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @ForwardCaseElse:
     cmp     ecx, 800
     jnle    @Else9
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     mov     edi, ecx
     shr     edi, 5
     shl     edi, 5
     xor     ebx, ebx
 @L11:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    mm2, [eax+ebx+16]
     movq    mm3, [eax+ebx+24]
     movq    [edx+ebx], mm0
     movq    [edx+ebx+8], mm1
     movq    [edx+ebx+16], mm2
     movq    [edx+ebx+24], mm3
     add     ebx, 32
     cmp     ebx, edi
     jb      @L11
     emms
     add     eax, edi
     add     edx, edi
     sub     ecx, edi  //Remaining moves
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
     nop
     nop
     nop
     nop
     nop
 @Else9:
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     //Align destination
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
     mov     esi, ecx
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     //Both source and destination are 16 byte aligned
     cmp     ecx, 240000            // if Count < 1M then
     jnl     @Else2
     shr     ecx,4
     shl     ecx,4
     xor     ebx, ebx
 @L1111:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L1111
     jmp     @Fedtmule
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @Else2:
     shr     ecx, 7                  // NoOfIntLoops  := Count div 16;    16, 32, 48, 64, 80, 96, 112, 128
     shl     ecx, 7                  // NoOfIntMoves := NoOfIntLoops * 4;  4,  8, 12, 16, 20, 24,  28,  32
     xor     ebx, ebx
 @L10:
     movaps  xmm0, [eax+ebx]
     movaps  xmm1, [eax+ebx+16]
     movaps  xmm2, [eax+ebx+32]
     movaps  xmm3, [eax+ebx+48]
     movaps  xmm4, [eax+ebx+64]
     movaps  xmm5, [eax+ebx+80]
     movaps  xmm6, [eax+ebx+96]
     movaps  xmm7, [eax+ebx+112]
     movntps [edx+ebx],     xmm0
     movntps [edx+ebx+16],  xmm1
     movntps [edx+ebx+32],  xmm2
     movntps [edx+ebx+48],  xmm3
     movntps [edx+ebx+64],  xmm4
     movntps [edx+ebx+80],  xmm5
     movntps [edx+ebx+96],  xmm6
     movntps [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @L10
 @L20:
     jmp     @Fedtmule
     nop
     nop
     nop
     nop
     nop
     //else if (SourceAddress2 mod 8 = 0) then
 @ElseIf1:
     //Source is at least 8 byte aligned and destination is at least 16 byte aligned
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     //Destination 16 byte aligned, Source unaligned
     shr     ecx, 4               // NoOfIntLoops  := Count div 16;
     shl     ecx, 4               // NoOfIntMoves := NoOfIntLoops * 4;
     xor     ebx, ebx
 @L100:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L100
 @L200:
     jmp     @Fedtmule
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @Else1:
     //Destination 16 byte aligned. Source unaligned
     shr     ecx, 4
     shl     ecx, 4
     xor     ebx, ebx
 @L1000:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L1000
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @Fedtmule:
     // Small moves after big 16 byte destination aligned moves
     add     eax, ecx
     add     edx, ecx
     sub     esi, ecx  //Remaining moves
     mov     ecx, esi
     cmp     ecx, 55
     ja      @L1239
     pop     esi
     pop     edi
     pop     ebx
     emms
     jmp     dword ptr [ecx*4+@Case1JmpTable]
     nop
     nop
     nop
     nop
     nop
 @L1239:
     add     ecx, eax
 @L123:
     mov     bl, [eax]          // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx], bl
     inc     eax
     inc     edx
     cmp     eax, ecx
     jb      @L123                  // until(ByteNo >= EndOfByteMoves);
     pop     esi
     pop     edi
     pop     ebx
     emms
     ret
 @RewMove:
     cmp     ecx,64
     jnbe    @Case1Else
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @RewerseCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
 @RewerseCaseCount0:
     ret
 @RewerseCaseCount2:
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax]
     mov     [edx], cl
     ret
 @RewerseCaseCount3:
     mov     cl, [eax+2]
     mov     [edx+2], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax]
     mov     [edx], cl
     ret
 @RewerseCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount5:
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount6:
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount7:
     mov     cl, [eax+6]
     mov     [edx+6], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount8:
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount9:
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount10:
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount11:
     mov     cl, [eax+10]
     mov     [edx+10], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount12 :
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount13 :
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
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
     ret
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
     ret
@RewerseCaseCount16 :
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount17 :
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount18 :
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount19 :
     mov     cl, [eax+18]
     mov     [edx+18], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount20 :
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount21 :
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount22 :
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount23 :
     mov     cl, [eax+22]
     mov     [edx+22], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount24 :
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount25 :
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount26 :
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount27 :
     mov     cl, [eax+26]
     mov     [edx+26], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount28 :
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount29 :
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount30 :
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount31 :
     mov     cl, [eax+30]
     mov     [edx+30], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount32 :
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount33 :
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount34 :
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount35 :
     mov     cl, [eax+34]
     mov     [edx+34], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount36 :
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount37 :
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8], mm2
     movq    [edx], mm3
     emms
     ret
@RewerseCaseCount38 :
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount39 :
     mov     cl, [eax+38]
     mov     [edx+38], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount40 :
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount41 :
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount42 :
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount43 :
     mov     cl, [eax+42]
     mov     [edx+42], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount44 :
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount45 :
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount46 :
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount47 :
     mov     cl, [eax+46]
     mov     [edx+46], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount48 :
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount49 :
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount50 :
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount51 :
     mov     cl, [eax+50]
     mov     [edx+50], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount52 :
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount53 :
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount54 :
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount55 :
     mov     cl, [eax+54]
     mov     [edx+54], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount56 :
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount57 :
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount58 :
     mov     cl, [eax+57]
     mov     [edx+57], cl
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount59 :
     mov     cl, [eax+58]
     mov     [edx+58], cl
     mov     cl, [eax+57]
     mov     [edx+57], cl
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount60 :
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount61 :
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount62 :
     mov     cl, [eax+61]
     mov     [edx+61], cl
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount63 :
     mov     cl, [eax+62]
     mov     [edx+62], cl
     mov     cl, [eax+61]
     mov     [edx+61], cl
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount64 :
     movq    mm0, [eax+56]
     movq    mm1, [eax+48]
     movq    mm2, [eax+40]
     movq    mm3, [eax+32]
     movq    mm4, [eax+24]
     movq    mm5, [eax+16]
     movq    mm6, [eax+8]
     movq    mm7, [eax]
     movq    [edx+56], mm0
     movq    [edx+48], mm1
     movq    [edx+40], mm2
     movq    [edx+32], mm3
     movq    [edx+24], mm4
     movq    [edx+16], mm5
     movq    [edx+8],  mm6
     movq    [edx],    mm7
     emms
     ret
     nop
     nop
     nop
 @Case1Else:
     push    ebx
     push    edi
 @L15:
     sub     ecx, 1
     mov     bl, [eax+ecx]
     mov     [edx+ecx], bl
     mov     edi, edx               // ecx is destination pointer
     add     edi, ecx
     and     edi, $07
     test    edi, edi
     jnz     @L15                    // until((SrcAddress2 mod 16) = 0);
     sub     ecx, 16
     mov     ebx, ecx
 @L67:
     movq    mm0, [eax+ecx+8]
     movq    [edx+ecx+8], mm0
     movq    mm1, [eax+ecx]
     movq    [edx+ecx], mm1
     sub     ecx, 16
     jns     @L67
     emms
     add     ecx,16
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @Exit:
     ret
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop

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
 dd @RewerseCaseCount56
 dd @RewerseCaseCount57
 dd @RewerseCaseCount58
 dd @RewerseCaseCount59
 dd @RewerseCaseCount60
 dd @RewerseCaseCount61
 dd @RewerseCaseCount62
 dd @RewerseCaseCount63
 dd @RewerseCaseCount64

end;

procedure Move_DKC_SSE2_2(const Source; var Dest; Count : Integer);
const
 SPLIT1 : Cardinal = 120;
 SPLIT2 : Cardinal = 4000;
 
asm
     //Exit if Count is negative
     test    ecx, ecx
     js      @Exit
     //Detect the need for rewerse move in overlapped case
     cmp     eax, edx                   // if (DestAddress > SourceAddress) then
     jnb     @ForwardMove
     push    ebx
     mov     ebx, edx
     sub     ebx, eax                   // (DestAddress - SourceAddress)
     cmp     ebx, edx                   // if ((DestAddress - SourceAddress) < Count) then
     pop     ebx
     jb      @RewMove
@L2:
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
     cmp     ecx, SPLIT1
     ja      @BiggerThanSPLIT1
     push    ebx
     push    esi
     sub     ecx, 7
     xor     esi,esi
 @L11:
     mov     ebx, [eax+esi]
     mov     [edx+esi], ebx
     mov     ebx, [eax+esi+4]
     mov     [edx+esi+4], ebx
     add     esi, 8
     cmp     esi, ecx
     jb      @L11
     add     ecx, 7
     sub     esi, 1
 @L3:
     mov     bl, [eax+esi]
     mov     [edx+esi], bl
     add     esi, 1
     cmp     esi, ecx
     jb      @L3
     pop     esi
     pop     ebx
     jmp     @Exit
 @BiggerThanSPLIT1 :
     cmp     ecx, SPLIT2
     ja      @BiggerThanSPLIT2
     push    ebx
     push    edi
     push    esi
     //Align destination
     mov     ebx, edx
     and     ebx, $0f
     test    ebx, ebx
     jz      @L222
     mov     esi, 16
     sub     esi, ebx
     test    esi, esi
     jz      @L222
     push    ebp
     mov     ebp,ecx
     mov     ecx,esi
     mov     edi,edx
     mov     ebx,eax
     call    TinyMoves
     mov     edx,edi
     mov     eax,ebx
     mov     ecx,ebp
     pop     ebp
     add     eax, esi
     add     edx, esi
     sub     ecx, esi
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then
     //Both source and destination are 16 byte aligned
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     cmp     ecx, L2CACHESIZE
     jnl     @Else2
     sub     ecx, 31
     xor     ebx, ebx
 @L1111:
     movaps  xmm0, [eax+ebx]
     movaps  xmm1, [eax+ebx+16]
     movaps  [edx+ebx],    xmm0
     movaps  [edx+ebx+16], xmm1
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L1111
     add     ecx, 31
     // Small moves after big 16 byte aligned moves
     mov     edi,ecx
     sub     ecx,ebx
     cmp     ecx,4
     jb      @ByteMove3Start
     sub     edi,3
 @4ByteMove3:
     mov     ecx, [eax+ebx]
     mov     [edx+ebx], ecx
     add     ebx,4
     cmp     ebx,edi
     jb      @4ByteMove3
     add     edi,3
 @ByteMove3Start:
     mov     ecx,edi
     sub     ecx,ebx
     test    ecx,ecx
     jz      @ByteMove3End
 @ByteMove3:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove3
 @ByteMove3End :
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @Else2:
     sub     ecx,127
     xor     ebx, ebx
 @L10:
     movdqa  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqa  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqa  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqa  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqa  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqa  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqa  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqa  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @L10
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @ByteMove1:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove1
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
     //else if (SourceAddress2 mod 8 = 0) then
     //Both source and destination are at least 8 byte aligned
 @ElseIf1:
     cmp     ecx, L2CACHESIZE
     ja      @ElseDennis
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     xor     ebx, ebx
     sub     ecx, 31
 @L100:
     movdqu    xmm0, [eax+ebx]
     movdqa    [edx+ebx], xmm0
     movdqu    xmm2, [eax+ebx+16]
     movdqa    [edx+ebx+16], xmm2
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L100
     add     ecx, 31
 @L200:
     add     eax, ebx
     add     edx, ebx
     sub     ecx, ebx
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
 @Else1:
     sub     ecx, 31
     xor     ebx, ebx
 @L1000:
     movups  xmm0, [eax+ebx]
     movups  xmm1, [eax+ebx+16]
     movaps  [edx+ebx],    xmm0
     movaps  [edx+ebx+16], xmm1
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L1000
     add     ecx, 31
     mov     edi,ecx
     sub     ecx,ebx
     cmp     ecx,4
     jb      @ByteMove2Start
     sub     edi,3
 @4ByteMove2:
     mov     ecx, [eax+ebx]
     mov     [edx+ebx], ecx
     add     ebx, 4
     cmp     ebx, edi
     jb      @4ByteMove2
     add     edi,3
 @ByteMove2Start :
     sub     ebx,1
 @ByteMove2:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove2
 @ByteMove2End:
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @ElseDennis:
     sub     ecx,127
     xor     ebx, ebx
 @Yps3:
     movdqu  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqu  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqu  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqu  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqu  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqu  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqu  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqu  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @Yps3
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @ByteMove7:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove7
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @BiggerThanSPLIT2 :
     push    ebx
     push    edi
     push    esi
     //Align destination
     mov     ebx, edx
     and     ebx, $0f
     mov     esi, 16
     sub     esi, ebx
     test    esi, esi
     jz      @XL222
     xor     edi, edi
 @XL111:
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jb      @XL111
 @XByteMoveExit :
     add     eax, edi
     add     edx, edi
     sub     ecx, edi
 @XL222:
     //if (SourceAddress2 mod 16 = 0) then
     //Both source and destination are 16 byte aligned
     mov     ebx, eax
     and     ebx, $0f
     jnz     @XElseIf1
     cmp     ecx, L2CACHESIZE
     jnl     @XElse2
     sub     ecx, 47
     xor     ebx, ebx
 @XL1111:
     movaps  xmm0, [eax+ebx]
     movaps  [edx+ebx], xmm0
     movaps  xmm1, [eax+ebx+16]
     movaps  [edx+ebx+16], xmm1
     movaps  xmm2, [eax+ebx+32]
     movaps  [edx+ebx+32], xmm2
     add     ebx, 48
     cmp     ebx, ecx
     jb      @XL1111
     add     ecx, 47
     // Small moves after big 16 byte aligned moves
     sub     ebx,1
     mov     edi, ecx
 @XL123:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @XL123
 @XL234:
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @XElse2:
     sub     ecx,127
     xor     ebx, ebx
 @XL10:
     movdqa  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqa  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqa  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqa  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqa  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqa  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqa  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqa  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @XL10
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @XByteMove1:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @XByteMove1
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
     //else if (SourceAddress2 mod 8 = 0) then
     //Both source and destination are at least 8 byte aligned
 @XElseIf1:
     cmp     ecx, L2CACHESIZE
     ja      @XElseDennis
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @XElse1
     xor     ebx, ebx
     sub     ecx, 31
 @XL100:
     movq    xmm0, [eax+ebx]
     movq    [edx+ebx], xmm0
     movq    xmm1, [eax+ebx+8]
     movq    [edx+ebx+8], xmm1
     movq    xmm2, [eax+ebx+16]
     movq    [edx+ebx+16], xmm2
     movq    xmm3, [eax+ebx+24]
     movq    [edx+ebx+24], xmm3
     add     ebx, 32
     cmp     ebx, ecx
     jb      @XL100
     add     ecx, 31
 @XL200:
     add     eax, ebx
     add     edx, ebx
     sub     ecx, ebx
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
 @XElse1:
     sub     ecx, 31
     xor     ebx, ebx
 @XL1000:
     movdqu  xmm0, [eax+ebx]
     movdqa  [edx+ebx], xmm0
     movdqu  xmm1, [eax+ebx+16]
     movdqa  [edx+ebx+16], xmm1
     add     ebx, 32
     cmp     ebx, ecx
     jb      @XL1000
     add     ecx, 31
     sub     ebx, 1
     mov     edi, ecx
 @XByteMove2:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @XByteMove2
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @XElseDennis:
     sub     ecx,127
     xor     ebx, ebx
 @XYps3:
     movdqu  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqu  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqu  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqu  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqu  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqu  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqu  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqu  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @XYps3
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @XByteMove7:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @XByteMove7
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @ForwardCaseEnd:
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
     push    edi
     push    esi
     push    ebx
     mov     edi, edx
     add     edi, ecx
     and     edi, $0f
     test    edi, edi
     jz      @Aligned
     mov     esi, ecx
     sub     esi, edi
     sub     ecx, 1
     sub     esi, 1
 @L15:
     mov     bl, [eax+ecx]
     mov     [edx+ecx], bl
     sub     ecx, 1
     cmp     ecx, esi
     ja      @L15
     add     ecx, 1
 @Aligned :
     sub     ecx, 32
 @L35:
     movups  xmm0, [eax+ecx+16]
     movaps  [edx+ecx+16], xmm0
     movups  xmm0, [eax+ecx]
     movaps  [edx+ecx], xmm0
     sub     ecx, 32
     jns     @L35
     add     ecx, 32
     pop     ebx
     pop     esi
     pop     edi
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @L25:
     pop     ebx
     pop     esi
     pop     edi
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

procedure Move_DKC_SSE2_3(const Source; var Dest; Count : Integer);
const
 SPLIT1 : Cardinal = 120;
 SPLIT2 : Cardinal = 4000;

asm
     //Exit if Count is negative
     test    ecx, ecx
     js      @Exit
     //Detect the need for rewerse move in overlapped case
     cmp     eax, edx                   // if (DestAddress > SourceAddress) then
     jnb     @ForwardMove
     push    ebx
     mov     ebx, edx
     sub     ebx, eax                   // (DestAddress - SourceAddress)
     cmp     ebx, edx                   // if ((DestAddress - SourceAddress) < Count) then
     pop     ebx
     jb      @RewMove
@L2:
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
     cmp     ecx, SPLIT1
     ja      @BiggerThanSPLIT1
     push    ebx
     push    esi
     sub     ecx, 7
     xor     esi,esi
 @L11:
     mov     ebx, [eax+esi]
     mov     [edx+esi], ebx
     mov     ebx, [eax+esi+4]
     mov     [edx+esi+4], ebx
     add     esi, 8
     cmp     esi, ecx
     jb      @L11
     add     ecx, 7
     sub     esi, 1
 @L3:
     mov     bl, [eax+esi]
     mov     [edx+esi], bl
     add     esi, 1
     cmp     esi, ecx
     jb      @L3
     pop     esi
     pop     ebx
     jmp     @Exit
 @BiggerThanSPLIT1 :
     cmp     ecx, SPLIT2
     ja      @BiggerThanSPLIT2
     push    ebx
     push    edi
     push    esi
     //Align destination
     mov     ebx, edx
     and     ebx, $0f
     test    ebx, ebx
     jz      @L222
     mov     esi, 16
     sub     esi, ebx
     test    esi, esi
     jz      @L222
     push    ebp
     mov     ebp,ecx
     mov     ecx,esi
     mov     edi,edx
     mov     ebx,eax
     call    TinyMoves
     mov     edx,edi
     mov     eax,ebx
     mov     ecx,ebp
     pop     ebp
     add     eax, esi
     add     edx, esi
     sub     ecx, esi
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then
     //Both source and destination are 16 byte aligned
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     cmp     ecx, L2CACHESIZE
     jnl     @Else2
     sub     ecx, 31
     xor     ebx, ebx
 @L1111:
     movaps  xmm0, [eax+ebx]
     movaps  xmm1, [eax+ebx+16]
     movaps  [edx+ebx],    xmm0
     movaps  [edx+ebx+16], xmm1
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L1111
     add     ecx, 31
     // Small moves after big 16 byte aligned moves
     mov     edi,ecx
     sub     ecx,ebx
     cmp     ecx,4
     jb      @ByteMove3Start
     sub     edi,3
 @4ByteMove3:
     mov     ecx, [eax+ebx]
     mov     [edx+ebx], ecx
     add     ebx,4
     cmp     ebx,edi
     jb      @4ByteMove3
     add     edi,3
 @ByteMove3Start:
     mov     ecx,edi
     sub     ecx,ebx
     test    ecx,ecx
     jz      @ByteMove3End
 @ByteMove3:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove3
 @ByteMove3End :
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @Else2:
     sub     ecx,127
     xor     ebx, ebx
 @L10:
     movdqa  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqa  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqa  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqa  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqa  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqa  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqa  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqa  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @L10
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @ByteMove1:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove1
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
     //else if (SourceAddress2 mod 8 = 0) then
     //Both source and destination are at least 8 byte aligned
 @ElseIf1:
     cmp     ecx, L2CACHESIZE
     ja      @ElseDennis
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     xor     ebx, ebx
     sub     ecx, 31
 @L100:
     movdqu    xmm0, [eax+ebx]
     movdqa    [edx+ebx], xmm0
     movdqu    xmm2, [eax+ebx+16]
     movdqa    [edx+ebx+16], xmm2
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L100
     add     ecx, 31
 @L200:
     add     eax, ebx
     add     edx, ebx
     sub     ecx, ebx
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
 @Else1:
     sub     ecx, 31
     xor     ebx, ebx
 @L1000:
     movups  xmm0, [eax+ebx]
     movups  xmm1, [eax+ebx+16]
     movaps  [edx+ebx],    xmm0
     movaps  [edx+ebx+16], xmm1
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L1000
     add     ecx, 31
     mov     edi,ecx
     sub     ecx,ebx
     cmp     ecx,4
     jb      @ByteMove2Start
     sub     edi,3
 @4ByteMove2:
     mov     ecx, [eax+ebx]
     mov     [edx+ebx], ecx
     add     ebx, 4
     cmp     ebx, edi
     jb      @4ByteMove2
     add     edi,3
 @ByteMove2Start :
     sub     ebx,1
 @ByteMove2:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove2
 @ByteMove2End:
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @ElseDennis:
     sub     ecx,127
     xor     ebx, ebx
 @Yps3:
     movdqu  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqu  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqu  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqu  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqu  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqu  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqu  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqu  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @Yps3
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @ByteMove7:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove7
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @BiggerThanSPLIT2 :
     push    ebx
     push    edi
     push    esi
     //Align destination
     mov     ebx, edx
     and     ebx, $0f
     mov     esi, 16
     sub     esi, ebx
     test    esi, esi
     jz      @XL222
     xor     edi, edi
 @XL111:
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @XByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jb      @XL111
 @XByteMoveExit :
     add     eax, edi
     add     edx, edi
     sub     ecx, edi
 @XL222:
     //if (SourceAddress2 mod 16 = 0) then
     //Both source and destination are 16 byte aligned
     mov     ebx, eax
     and     ebx, $0f
     jnz     @XElseIf1
     cmp     ecx, L2CACHESIZE
     jnl     @XElse2
     sub     ecx, 47
     xor     ebx, ebx
 @XL1111:
     movaps  xmm0, [eax+ebx]
     movaps  [edx+ebx], xmm0
     movaps  xmm1, [eax+ebx+16]
     movaps  [edx+ebx+16], xmm1
     movaps  xmm2, [eax+ebx+32]
     movaps  [edx+ebx+32], xmm2
     add     ebx, 48
     cmp     ebx, ecx
     jb      @XL1111
     add     ecx, 47
     // Small moves after big 16 byte aligned moves
     sub     ebx,1
     mov     edi, ecx
 @XL123:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @XL123
 @XL234:
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @XElse2:
     sub     ecx,127
     xor     ebx, ebx
 @XL10:
     movdqa  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqa  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqa  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqa  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqa  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqa  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqa  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqa  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @XL10
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @XByteMove1:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @XByteMove1
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
     //else if (SourceAddress2 mod 8 = 0) then
     //Both source and destination are at least 8 byte aligned
 @XElseIf1:
     cmp     ecx, L2CACHESIZE
     ja      @XElseDennis
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @XElse1
     xor     ebx, ebx
     sub     ecx, 31
 @XL100:
     movq    xmm0, [eax+ebx]
     movq    [edx+ebx], xmm0
     movq    xmm1, [eax+ebx+8]
     movq    [edx+ebx+8], xmm1
     movq    xmm2, [eax+ebx+16]
     movq    [edx+ebx+16], xmm2
     movq    xmm3, [eax+ebx+24]
     movq    [edx+ebx+24], xmm3
     add     ebx, 32
     cmp     ebx, ecx
     jb      @XL100
     add     ecx, 31
 @XL200:
     add     eax, ebx
     add     edx, ebx
     sub     ecx, ebx
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
 @XElse1:
     sub     ecx, 31
     xor     ebx, ebx
 @XL1000:
     movdqu  xmm0, [eax+ebx]
     movdqa  [edx+ebx], xmm0
     movdqu  xmm1, [eax+ebx+16]
     movdqa  [edx+ebx+16], xmm1
     add     ebx, 32
     cmp     ebx, ecx
     jb      @XL1000
     add     ecx, 31
     sub     ebx, 1
     mov     edi, ecx
 @XByteMove2:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @XByteMove2
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @XElseDennis:
     sub     ecx,127
     xor     ebx, ebx
 @XYps3:
     movdqu  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqu  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqu  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqu  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqu  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqu  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqu  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqu  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @XYps3
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @XByteMove7:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @XByteMove7
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit
 @ForwardCaseEnd:
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
     push    edi
     push    esi
     push    ebx
     mov     edi, edx
     add     edi, ecx
     and     edi, $0f
     test    edi, edi
     jz      @Aligned
     mov     esi, ecx
     sub     esi, edi
     sub     ecx, 1
     sub     esi, 1
 @L15:
     mov     bl, [eax+ecx]
     mov     [edx+ecx], bl
     sub     ecx, 1
     cmp     ecx, esi
     ja      @L15
     add     ecx, 1
 @Aligned :
     sub     ecx, 32
 @L35:
     movups  xmm0, [eax+ecx+16]
     movaps  [edx+ecx+16], xmm0
     movups  xmm0, [eax+ecx]
     movaps  [edx+ecx], xmm0
     sub     ecx, 32
     jns     @L35
     add     ecx, 32
     pop     ebx
     pop     esi
     pop     edi
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @L25:
     pop     ebx
     pop     esi
     pop     edi
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
//Date:              26/2 2004
//Optimized for:     P4 Prescott
//Instructionset(s): IA32, MMX, SSE, SSE2, SSE3

procedure Move_DKC_SSE3_1(const Source; var Dest; Count : Integer);
const
 L2CACHESIZE : Cardinal = 1000000;
 SPLIT1 : Cardinal = 150;

asm
     //Exit if Count is negative
     test    ecx, ecx
     js      @Exit
     //Detect the need for rewerse move in overlapped case
     cmp     eax, edx                   // if (DestAddress > SourceAddress) then
     jnb     @ForwardMove
     push    ebx
     mov     ebx, edx
     sub     ebx, eax                   // (DestAddress - SourceAddress)
     cmp     ebx, edx                   // if ((DestAddress - SourceAddress) < Count) then
     pop     ebx
     jb      @RewMove
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
     cmp     ecx, SPLIT1
     ja      @Else9
     push    ebx                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     sub     ecx, 7
     xor     esi,esi
 @L11:
     mov     ebx, [eax+esi]
     mov     [edx+esi], ebx
     mov     ebx, [eax+esi+4]
     mov     [edx+esi+4], ebx
     add     esi, 8
     cmp     esi, ecx
     jb      @L11
     add     ecx, 7
     sub     esi, 1
 @L3:
     mov     bl, [eax+esi]
     mov     [edx+esi], bl
     add     esi, 1
     cmp     esi, ecx
     jb      @L3
     pop     esi
     pop     ebx
     jmp     @Exit1
 @Else9:
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     //Align destination
     mov     ebx, edx
     and     ebx, $0f
     mov     esi, 16
     sub     esi, ebx
     test    esi, esi
     jz      @L222
     xor     edi, edi
 @L111:
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jb      @L111
 @ByteMoveExit :
     add     eax, edi                // SrcB is aligned now - "SrcI := SrcI + ByteNo1;" Not valid Pascal
     add     edx, edi                // DstB is aligned now - "DstI := DstI + ByteNo1;" Not valid Pascal
     sub     ecx, edi                // Count := Count - ByteNo1;
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then //Both source and destination are 16 byte aligned
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     cmp     ecx, L2CACHESIZE
     jnl     @Else2
     sub     ecx, 47
     xor     ebx, ebx
 @L1111:
     movaps  xmm0, [eax+ebx]
     movaps  [edx+ebx], xmm0
     movaps  xmm1, [eax+ebx+16]
     movaps  [edx+ebx+16], xmm1
     movaps  xmm2, [eax+ebx+32]
     movaps  [edx+ebx+32], xmm2
     add     ebx, 48
     cmp     ebx, ecx
     jb      @L1111
     add     ecx, 47
     // Small moves after big 16 byte aligned moves
     sub     ebx,1
     mov     edi, ecx
@L123:
     mov     cl, [eax+ebx]           // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @L123                   // until(ByteNo >= EndOfByteMoves);
 @L234:
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
 @Else2:
     sub     ecx,127
     xor     ebx, ebx
 @L10:
     movdqa  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqa  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqa  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqa  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqa  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqa  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqa  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqa  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128                 //  4, 8, 12, 16, 20, 24, 28, 32
     cmp     ebx, ecx
     jb      @L10
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @ByteMove1:
     mov     cl, [eax+ebx]           // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove1                   // until(ByteNo >= EndOfByteMoves);
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
     //else if (SourceAddress2 mod 8 = 0) then //Both source and destination are at least 8 byte aligned
 @ElseIf1:
     cmp     ecx, L2CACHESIZE
     ja      @ElseDennis
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     xor     ebx, ebx
     sub     ecx, 31
 @L100:
     movq    xmm0, [eax+ebx]
     movq    [edx+ebx], xmm0
     movq    xmm1, [eax+ebx+8]
     movq    [edx+ebx+8], xmm1
     movq    xmm2, [eax+ebx+16]
     movq    [edx+ebx+16], xmm2
     movq    xmm3, [eax+ebx+24]
     movq    [edx+ebx+24], xmm3
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L100
     add     ecx, 31
 @L200:
     add     eax, ebx
     add     edx, ebx
     sub     ecx, ebx
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
 @Else1:
     sub     ecx, 31
     xor     ebx, ebx
 @L1000:
     //movdqu  xmm0, [eax+ebx]
     db $F2 db $0F db $F0 db $04 db $03
     movdqa  [edx+ebx], xmm0
     //movdqu  xmm1, [eax+ebx+16]
     db $F2 db $0F db $F0 db $4C db $03 db $10
     movdqa  [edx+ebx+16], xmm1
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L1000
     add     ecx, 31
     sub     ebx, 1
     mov     edi, ecx
 @ByteMove2:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove2
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
 @ElseDennis:
     sub     ecx,127
     xor     ebx, ebx
 @Yps3:
     //movdqu  xmm0, [eax+ebx]
     db $F2 db $0F db $F0 db $04 db $03
     movntdq [edx+ebx], xmm0
     //movdqu  xmm1, [eax+ebx+16]
     db $F2 db $0F db $F0 db $4C db $03 db $10
     movntdq [edx+ebx+16], xmm1
     //movdqu  xmm2, [eax+ebx+32]
     db $F2 db $0F db $F0 db $54 db $03 db $20
     movntdq [edx+ebx+32], xmm2
     //movdqu  xmm3, [eax+ebx+48]
     db $F2 db $0F db $F0 db $5C db $03 db $30
     movntdq [edx+ebx+48], xmm3
     //movdqu  xmm4, [eax+ebx+64]
     db $F2 db $0F db $F0 db $64 db $03 db $40
     movntdq [edx+ebx+64], xmm4
     //movdqu  xmm5, [eax+ebx+80]
     db $F2 db $0F db $F0 db $6C db $03 db $50
     movntdq [edx+ebx+80], xmm5
     //movdqu  xmm6, [eax+ebx+96]
     db $F2 db $0F db $F0 db $74 db $03 db $60
     movntdq [edx+ebx+96], xmm6
     //movdqu  xmm7, [eax+ebx+112]
     db $F2 db $0F db $F0 db $7C db $03 db $70
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128                 //  4, 8, 12, 16, 20, 24, 28, 32
     cmp     ebx, ecx
     jb      @Yps3
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @ByteMove7:
     mov     cl, [eax+ebx]           // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove7                   // until(ByteNo >= EndOfByteMoves);
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
 @ForwardCaseEnd:
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
     push    edi
     push    esi
     push    ebx
     mov     edi, edx
     add     edi, ecx
     and     edi, $0f
     test    edi, edi
     jz      @Aligned
     mov     esi, ecx
     sub     esi, edi
     sub     ecx, 1
     sub     esi, 1
 @L15:
     mov     bl, [eax+ecx]
     mov     [edx+ecx], bl
     sub     ecx, 1
     cmp     ecx, esi
     ja      @L15
     add     ecx, 1
 @Aligned :
     sub     ecx, 32
 @L35:
     //movdqu  xmm0, [eax+ecx+16]
     db $F2 db $0F db $F0 db $44 db $01 db $10
     movdqa  [edx+ecx+16], xmm0
     //movdqu  xmm0, [eax+ecx]
     db $F2 db $0F db $F0 db $04 db $01
     movdqa  [edx+ecx], xmm0
     sub     ecx, 32
     jns     @L35
     add     ecx, 32
     pop     ebx
     pop     esi
     pop     edi
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @L25:
     pop     ebx
     pop     esi
     pop     edi
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

var
 DKCCPU : TCPU;

initialization

 DKCCPU := RequestCPUInfo;
 L2CACHESIZE := 1024 * DKCCPU.L2CacheSize;

end.
