unit PosExEWCUnit;

interface

function PosEx_EWC_IA32_1_a(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_1_b(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_1_c(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_1_d(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_2_a(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_2_b(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_2_c(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_2_d(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_3_a(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_3_b(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_3_c(const SubStr, S: string; Offset: Integer = 1):Integer;
function PosEx_EWC_IA32_3_d(const SubStr, S: string; Offset: Integer = 1):Integer;

implementation

function PosEx_EWC_IA32_1_a(const SubStr, S: string; Offset: Integer = 1):Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.
  jmp @BeginLoop

@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  mov al,[edi]        //Get Pattern Character
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, break loop

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 1          //Make Pattern Count an Offset/Dec Loop Counter
  jle @Found          //If end of Pattern then must be found
  mov al, [edi+edx]   //Get Pattern Char
  cmp al, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_1_b(const SubStr, S: string; Offset: Integer = 1):Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.
  jmp @BeginLoop

@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  mov al,[edi]        //Get Pattern Character
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, break loop

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 1          //Make Pattern Count an Offset/Dec Loop Counter
  jle @Found          //If end of Pattern then must be found
  mov al, [edi+edx]   //Get Pattern Char
  cmp al, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_1_c(const SubStr, S: string; Offset: Integer = 1):Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.
  jmp @BeginLoop

@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  mov al,[edi]        //Get Pattern Character
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, break loop

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 1          //Make Pattern Count an Offset/Dec Loop Counter
  jle @Found          //If end of Pattern then must be found
  mov al, [edi+edx]   //Get Pattern Char
  cmp al, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_1_d(const SubStr, S: string; Offset: Integer = 1):Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.
  jmp @BeginLoop

@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  mov al,[edi]        //Get Pattern Character
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, break loop

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 1          //Make Pattern Count an Offset/Dec Loop Counter
  jle @Found          //If end of Pattern then must be found
  mov al, [edi+edx]   //Get Pattern Char
  cmp al, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_2_a(const SubStr, S: string; Offset: Integer = 1):
Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.

  mov al,[edi]        //Get Pattern Character
  jmp @BeginLoop

@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, break loop

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 1          //Make Pattern Count an Offset/Dec Loop Counter
  jle @Found          //If end of Pattern then must be found
  mov ah, [edi+edx]   //Get Pattern Char
  cmp ah, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_2_b(const SubStr, S: string; Offset: Integer = 1):
Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.

  mov al,[edi]        //Get Pattern Character
  jmp @BeginLoop

@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, break loop

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 1          //Make Pattern Count an Offset/Dec Loop Counter
  jle @Found          //If end of Pattern then must be found
  mov ah, [edi+edx]   //Get Pattern Char
  cmp ah, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_2_c(const SubStr, S: string; Offset: Integer = 1):
Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.

  mov al,[edi]        //Get Pattern Character
  jmp @BeginLoop

@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, break loop

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 1          //Make Pattern Count an Offset/Dec Loop Counter
  jle @Found          //If end of Pattern then must be found
  mov ah, [edi+edx]   //Get Pattern Char
  cmp ah, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_2_d(const SubStr, S: string; Offset: Integer = 1):
Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.

  mov al,[edi]        //Get Pattern Character
  jmp @BeginLoop

@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, break loop

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 1          //Make Pattern Count an Offset/Dec Loop Counter
  jle @Found          //If end of Pattern then must be found
  mov ah, [edi+edx]   //Get Pattern Char
  cmp ah, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_3_a(const SubStr, S: string; Offset: Integer = 1): Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.

  mov al,[edi]        //Get Pattern Character

  cmp edx,1           //If Pattern is One Character
  je @BeginLoop1      //  use One Character Optimized Search

  test edx,$0003      //If Pattern is Multiple of four Characters
  jz @BeginLoop4      //  use Optimized Search

  test edx,$0001      //If Pattern is Multiple of two Characters
  jz @BeginLoop2      //  use Optimized Search

  jmp @BeginLoop

//-----------------------------------------------------------------------
//  Search for a Pattern which is 1 character in length
//-----------------------------------------------------------------------
@NextSourceChar1:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop1:
  cmp al,[esi]        //Compare to Source Character
  jz @Found1          //If match, Found

@NextSource1:
  sub ecx, 1
  jnz @NextSourceChar1
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for a Pattern which is a multiple 4 characters in length
//-----------------------------------------------------------------------
@NextSourceChar4:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop4:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource2    //If no match, check next character

@BeginPattern4:
  push edx            //Save Pattern Length

@PatternLoop4:        //Note: Ends up retesting the first character
  sub edx, 4          //Make Pattern Count an Offset/Dec Loop Counter
  jl @Found           //If end of Pattern then must be found
  mov eax, [edi+edx]  //Get Pattern Char
  cmp eax, [esi+edx]  //Compare to Source Char
  je @PatternLoop4    //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource4:
  sub ecx, 1
  jnz @NextSourceChar4
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for a Pattern which is a multiple 2 characters in length
//-----------------------------------------------------------------------
@NextSourceChar2:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop2:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource2    //If no match, check next character

@BeginPattern2:
  push edx            //Save Pattern Length

@PatternLoop2:        //Note: Ends up retesting the first character
  sub edx, 2          //Make Pattern Count an Offset/Dec Loop Counter
  jl @Found           //If end of Pattern then must be found
  mov ax, [edi+edx]   //Get Pattern Char
  cmp ax, [esi+edx]   //Compare to Source Char
  je @PatternLoop2    //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource2:
  sub ecx, 1
  jnz @NextSourceChar2
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for Pattern which is not a multiple of 2 characters in length
//-----------------------------------------------------------------------
@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, check next character

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 2          //Make Pattern Count an Offset/Dec Loop Counter
  cmp edx, 1          //Can skip the test of the first Character - already done
  jl @Found           //If end of Pattern then must be found
  mov ax, [edi+edx]   //Get Pattern Char
  cmp ax, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
@Found1:
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_3_b(const SubStr, S: string; Offset: Integer = 1): Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.

  mov al,[edi]        //Get Pattern Character

  cmp edx,1           //If Pattern is One Character
  je @BeginLoop1      //  use One Character Optimized Search

  test edx,$0003      //If Pattern is Multiple of four Characters
  jz @BeginLoop4      //  use Optimized Search

  test edx,$0001      //If Pattern is Multiple of two Characters
  jz @BeginLoop2      //  use Optimized Search

  jmp @BeginLoop

//-----------------------------------------------------------------------
//  Search for a Pattern which is 1 character in length
//-----------------------------------------------------------------------
@NextSourceChar1:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop1:
  cmp al,[esi]        //Compare to Source Character
  jz @Found1          //If match, Found

@NextSource1:
  sub ecx, 1
  jnz @NextSourceChar1
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for a Pattern which is a multiple 4 characters in length
//-----------------------------------------------------------------------
@NextSourceChar4:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop4:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource2    //If no match, check next character

@BeginPattern4:
  push edx            //Save Pattern Length

@PatternLoop4:        //Note: Ends up retesting the first character
  sub edx, 4          //Make Pattern Count an Offset/Dec Loop Counter
  jl @Found           //If end of Pattern then must be found
  mov eax, [edi+edx]  //Get Pattern Char
  cmp eax, [esi+edx]  //Compare to Source Char
  je @PatternLoop4    //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource4:
  sub ecx, 1
  jnz @NextSourceChar4
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for a Pattern which is a multiple 2 characters in length
//-----------------------------------------------------------------------
@NextSourceChar2:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop2:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource2    //If no match, check next character

@BeginPattern2:
  push edx            //Save Pattern Length

@PatternLoop2:        //Note: Ends up retesting the first character
  sub edx, 2          //Make Pattern Count an Offset/Dec Loop Counter
  jl @Found           //If end of Pattern then must be found
  mov ax, [edi+edx]   //Get Pattern Char
  cmp ax, [esi+edx]   //Compare to Source Char
  je @PatternLoop2    //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource2:
  sub ecx, 1
  jnz @NextSourceChar2
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for Pattern which is not a multiple of 2 characters in length
//-----------------------------------------------------------------------
@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, check next character

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 2          //Make Pattern Count an Offset/Dec Loop Counter
  cmp edx, 1          //Can skip the test of the first Character - already done
  jl @Found           //If end of Pattern then must be found
  mov ax, [edi+edx]   //Get Pattern Char
  cmp ax, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
@Found1:
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_3_c(const SubStr, S: string; Offset: Integer = 1): Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.

  mov al,[edi]        //Get Pattern Character

  cmp edx,1           //If Pattern is One Character
  je @BeginLoop1      //  use One Character Optimized Search

  test edx,$0003      //If Pattern is Multiple of four Characters
  jz @BeginLoop4      //  use Optimized Search

  test edx,$0001      //If Pattern is Multiple of two Characters
  jz @BeginLoop2      //  use Optimized Search

  jmp @BeginLoop

//-----------------------------------------------------------------------
//  Search for a Pattern which is 1 character in length
//-----------------------------------------------------------------------
@NextSourceChar1:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop1:
  cmp al,[esi]        //Compare to Source Character
  jz @Found1          //If match, Found

@NextSource1:
  sub ecx, 1
  jnz @NextSourceChar1
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for a Pattern which is a multiple 4 characters in length
//-----------------------------------------------------------------------
@NextSourceChar4:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop4:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource2    //If no match, check next character

@BeginPattern4:
  push edx            //Save Pattern Length

@PatternLoop4:        //Note: Ends up retesting the first character
  sub edx, 4          //Make Pattern Count an Offset/Dec Loop Counter
  jl @Found           //If end of Pattern then must be found
  mov eax, [edi+edx]  //Get Pattern Char
  cmp eax, [esi+edx]  //Compare to Source Char
  je @PatternLoop4    //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource4:
  sub ecx, 1
  jnz @NextSourceChar4
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for a Pattern which is a multiple 2 characters in length
//-----------------------------------------------------------------------
@NextSourceChar2:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop2:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource2    //If no match, check next character

@BeginPattern2:
  push edx            //Save Pattern Length

@PatternLoop2:        //Note: Ends up retesting the first character
  sub edx, 2          //Make Pattern Count an Offset/Dec Loop Counter
  jl @Found           //If end of Pattern then must be found
  mov ax, [edi+edx]   //Get Pattern Char
  cmp ax, [esi+edx]   //Compare to Source Char
  je @PatternLoop2    //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource2:
  sub ecx, 1
  jnz @NextSourceChar2
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for Pattern which is not a multiple of 2 characters in length
//-----------------------------------------------------------------------
@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, check next character

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 2          //Make Pattern Count an Offset/Dec Loop Counter
  cmp edx, 1          //Can skip the test of the first Character - already done
  jl @Found           //If end of Pattern then must be found
  mov ax, [edi+edx]   //Get Pattern Char
  cmp ax, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
@Found1:
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

function PosEx_EWC_IA32_3_d(const SubStr, S: string; Offset: Integer = 1): Integer;
//Pattern = edi
//Source  = esi
//SourceOffset/LoopVar = ecx
//PatternLength = edx
//Result = eax
asm
  test    eax, eax
  jz      @NotFound

  test    edx, edx
  jz      @NotFound

  cmp     ecx, 0
  jle     @NotFound

  push esi
  push edi
  mov edi,eax

  sub ecx, 1          //Make Offset relative to zero
  lea esi,[edx+ecx]   //Load esi with starting addr of source string

  mov eax,[edx-$04]   //Get String Source Length
  push eax
  mov edx,[edi-$04]   //Get String Pattern Length

  test    eax, eax
  jz      @NotFoundPop
  test    edx, edx
  jz      @NotFoundPop

                      //Calculate Number of Loops to execute
  sub eax,ecx         //  Subtract the Offset from the Length of the String
  sub eax,edx         //  Backoff the Length of the Pattern
  lea ecx,[eax+1]     //  Add 1 and move the result to the LoopVar

  test ecx,ecx        //If Pattern is longer than the remaining Source
  jle @NotFoundPop    //  Pattern was not found.

  mov al,[edi]        //Get Pattern Character

  cmp edx,1           //If Pattern is One Character
  je @BeginLoop1      //  use One Character Optimized Search

  test edx,$0003      //If Pattern is Multiple of four Characters
  jz @BeginLoop4      //  use Optimized Search

  test edx,$0001      //If Pattern is Multiple of two Characters
  jz @BeginLoop2      //  use Optimized Search

  jmp @BeginLoop

//-----------------------------------------------------------------------
//  Search for a Pattern which is 1 character in length
//-----------------------------------------------------------------------
@NextSourceChar1:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop1:
  cmp al,[esi]        //Compare to Source Character
  jz @Found1          //If match, Found

@NextSource1:
  sub ecx, 1
  jnz @NextSourceChar1
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for a Pattern which is a multiple 4 characters in length
//-----------------------------------------------------------------------
@NextSourceChar4:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop4:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource2    //If no match, check next character

@BeginPattern4:
  push edx            //Save Pattern Length

@PatternLoop4:        //Note: Ends up retesting the first character
  sub edx, 4          //Make Pattern Count an Offset/Dec Loop Counter
  jl @Found           //If end of Pattern then must be found
  mov eax, [edi+edx]  //Get Pattern Char
  cmp eax, [esi+edx]  //Compare to Source Char
  je @PatternLoop4    //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource4:
  sub ecx, 1
  jnz @NextSourceChar4
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for a Pattern which is a multiple 2 characters in length
//-----------------------------------------------------------------------
@NextSourceChar2:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop2:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource2    //If no match, check next character

@BeginPattern2:
  push edx            //Save Pattern Length

@PatternLoop2:        //Note: Ends up retesting the first character
  sub edx, 2          //Make Pattern Count an Offset/Dec Loop Counter
  jl @Found           //If end of Pattern then must be found
  mov ax, [edi+edx]   //Get Pattern Char
  cmp ax, [esi+edx]   //Compare to Source Char
  je @PatternLoop2    //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource2:
  sub ecx, 1
  jnz @NextSourceChar2
  jmp @NotFoundPop

//-----------------------------------------------------------------------
//  Search for Pattern which is not a multiple of 2 characters in length
//-----------------------------------------------------------------------
@NextSourceChar:
  lea esi, [esi+1]    //Advance to next Source character

@BeginLoop:
  cmp al,[esi]        //Compare to Source Character
  jnz @NextSource     //If no match, check next character

@BeginPattern:
  push edx            //Save Pattern Length

@PatternLoop:
  sub edx, 2          //Make Pattern Count an Offset/Dec Loop Counter
  cmp edx, 1          //Can skip the test of the first Character - already done
  jl @Found           //If end of Pattern then must be found
  mov ax, [edi+edx]   //Get Pattern Char
  cmp ax, [esi+edx]   //Compare to Source Char
  je @PatternLoop     //if Pattern Char Matches

  pop edx             //Restore Pattern Count if not found
  mov al,[edi]        //Restore Pattern Character

@NextSource:
  sub ecx, 1
  jnz @NextSourceChar

@NotFoundPop:
  pop eax
  pop edi
  pop esi
@NotFound:
  xor eax, eax
  jmp @Done

@Found:
  pop edx
@Found1:
  pop eax             //Length of Source String
  pop edi
  pop esi

  sub eax, ecx       //Subtract Number of Iterations Left
  sub eax, edx       //Add the Length of the Pattern
  lea eax,[eax+2]

@Done:

end;

end.
