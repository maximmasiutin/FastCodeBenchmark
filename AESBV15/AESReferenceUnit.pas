unit AESReferenceUnit;

interface

type

 TKeyMaterial = array[0..65] of Byte;

 TKeySchedule = array[0..14, 0..3, 0..7] of Byte;

 TBlock = array[0..3, 0..3] of Byte;//4*4 bytes = 16 bytes = 128 bit block

 TKeyBlock = array[0..3, 0..7] of Byte;//MAXKC = 8 => 4*8 bytes = 32 bytes = 256 bit key

 TKeyInstance = record
  Direction : Byte;
  KeyLength : Integer;
  KeyMaterial : TKeyMaterial;
  BlockLength : Integer;
  KeySchedule : TKeySchedule;
 end;

const
 DIR_ENCRYPT : Integer = 0;
 DIR_DECRYPT : Integer = 1;

//function MakeKeyPas(var Key : TKeyInstance; Direction : Integer; KeyLength : Integer; var keyMaterial : TKeyMaterial) : Integer;
function RijndaelKeySched(K : TKeyBlock; KeyBits : Integer; BlockBits : Integer; var W : TKeySchedule) : Integer;
function RijndaelEncryptPascal(var Block : TBlock; KeyBits, BlockBits : Integer; const RoundKeys : TKeySchedule) : Integer;
function RijndaelDecryptPascal(var Block : TBlock; KeyBits, BlockBits : Integer; const RoundKeys : TKeySchedule) : Integer;

implementation

uses
 Math;

const
 MAXKC : Integer = 8;
 MAXBC : Cardinal = 8;
 MAX_KEY_SIZE : Integer = 64;
 BAD_KEY_DIR : Integer = -1;
 BAD_KEY_MAT : Integer = -2;
 TRUE : Integer = 1;

 S : array[$00..$FF] of Byte =
   (99, 124, 119, 123, 242, 107, 111, 197,  48,   1, 103,  43, 254, 215, 171, 118,
   202, 130, 201, 125, 250,  89,  71, 240, 173, 212, 162, 175, 156, 164, 114, 192,
   183, 253, 147,  38,  54,  63, 247, 204,  52, 165, 229, 241, 113, 216,  49,  21,
     4, 199,  35, 195,  24, 150,   5, 154,   7,  18, 128, 226, 235,  39, 178, 117,
     9, 131,  44,  26,  27, 110,  90, 160,  82,  59, 214, 179,  41, 227,  47, 132,
    83, 209,   0, 237,  32, 252, 177,  91, 106, 203, 190,  57,  74,  76,  88, 207,
   208, 239, 170, 251,  67,  77,  51, 133,  69, 249,   2, 127,  80,  60, 159, 168,
    81, 163,  64, 143, 146, 157,  56, 245, 188, 182, 218,  33,  16, 255, 243, 210,
   205,  12,  19, 236,  95, 151,  68,  23, 196, 167, 126,  61, 100,  93,  25, 115,
    96, 129,  79, 220,  34,  42, 144, 136,  70, 238, 184,  20, 222,  94,  11, 219,
   224,  50,  58,  10,  73,   6,  36,  92, 194, 211, 172,  98, 145, 149, 228, 121,
   231, 200,  55, 109, 141, 213,  78, 169, 108,  86, 244, 234, 101, 122, 174,   8,
   186, 120,  37,  46,  28, 166, 180, 198, 232, 221, 116,  31,  75, 189, 139, 138,
   112,  62, 181, 102,  72,   3, 246,  14,  97,  53,  87, 185, 134, 193,  29, 158,
   225, 248, 152,  17, 105, 217, 142, 148, 155,  30, 135, 233, 206,  85,  40, 223,
   140, 161, 137,  13, 191, 230,  66, 104,  65, 153,  45,  15, 176,  84, 187,  22);

 Sinverse : array[$00..$FF] of Byte =(
   82,   9, 106, 213,  48,  54, 165,  56, 191,  64, 163, 158, 129, 243, 215, 251,
  124, 227,  57, 130, 155,  47, 255, 135,  52, 142,  67,  68, 196, 222, 233, 203,
   84, 123, 148,  50, 166, 194,  35,  61, 238,  76, 149,  11,  66, 250, 195,  78,
    8,  46, 161, 102,  40, 217,  36, 178, 118,  91, 162,  73, 109, 139, 209,  37,
  114, 248, 246, 100, 134, 104, 152,  22, 212, 164,  92, 204,  93, 101, 182, 146,
  108, 112,  72,  80, 253, 237, 185, 218,  94,  21,  70,  87, 167, 141, 157, 132,
  144, 216, 171,   0, 140, 188, 211,  10, 247, 228,  88,   5, 184, 179,  69,   6,
  208,  44,  30, 143, 202,  63,  15,   2, 193, 175, 189,   3,   1,  19, 138, 107,
   58, 145,  17,  65,  79, 103, 220, 234, 151, 242, 207, 206, 240, 180, 230, 115,
  150, 172, 116,  34, 231, 173,  53, 133, 226, 249,  55, 232,  28, 117, 223, 110,
   71, 241,  26, 113,  29,  41, 197, 137, 111, 183,  98,  14, 170,  24, 190,  27,
  252,  86,  62,  75, 198, 210, 121,  32, 154, 219, 192, 254, 120, 205,  90, 244,
   31, 221, 168,  51, 136,   7, 199,  49, 177,  18,  16,  89,  39, 128, 236,  95,
   96,  81, 127, 169,  25, 181,  74,  13,  45, 229, 122, 159, 147, 201, 156, 239,
  160, 224,  59,  77, 174,  42, 245, 176, 200, 235, 187,  60, 131,  83, 153,  97,
   23,  43,   4, 126, 186, 119, 214,  38, 225, 105,  20,  99,  85,  33,  12, 125);

 rcon : array[0..29] of Byte = (
  $01,$02, $04, $08, $10, $20, $40, $80, $1b, $36, $6c, $d8, $ab, $4d, $9a, $2f, $5e, $bc, $63, $c6, $97, $35, $6a, $d4, $b3, $7d, $fa, $ef, $c5, $91);

 shifts : array[0..2, 0..3, 0..1] of Byte = (
   ((0, 0), (1, 3), (2, 2), (3, 1)),
   ((0, 0), (1, 5), (2, 4), (3, 3)),
   ((0, 0), (1, 7), (3, 5), (4, 4)));

 Alogtable : array[0..255] of Byte = (
    1,   3,   5,  15,  17,  51,  85, 255,  26,  46, 114, 150, 161, 248,  19,  53,
   95, 225,  56,  72, 216, 115, 149, 164, 247,   2,   6,  10,  30,  34, 102, 170,
  229,  52,  92, 228,  55,  89, 235,  38, 106, 190, 217, 112, 144, 171, 230,  49,
   83, 245,   4,  12,  20,  60,  68, 204,  79, 209, 104, 184, 211, 110, 178, 205,
   76, 212, 103, 169, 224,  59,  77, 215,  98, 166, 241,   8,  24,  40, 120, 136,
  131, 158, 185, 208, 107, 189, 220, 127, 129, 152, 179, 206,  73, 219, 118, 154,
  181, 196,  87, 249,  16,  48,  80, 240,  11,  29,  39, 105, 187, 214,  97, 163,
  254,  25,  43, 125, 135, 146, 173, 236,  47, 113, 147, 174, 233,  32,  96, 160,
  251,  22,  58,  78, 210, 109, 183, 194,  93, 231,  50,  86, 250,  21,  63,  65,
  195,  94, 226,  61,  71, 201,  64, 192,  91, 237,  44, 116, 156, 191, 218, 117,
  159, 186, 213, 100, 172, 239,  42, 126, 130, 157, 188, 223, 122, 142, 137, 128,
  155, 182, 193,  88, 232,  35, 101, 175, 234,  37, 111, 177, 200,  67, 197,  84,
  252,  31,  33,  99, 165, 244,   7,   9,  27,  45, 119, 153, 176, 203,  70, 202,
   69, 207,  74, 222, 121, 139, 134, 145, 168, 227,  62,  66, 198,  81, 243,  14,
   18,  54,  90, 238,  41, 123, 141, 140, 143, 138, 133, 148, 167, 242,  13,  23,
   57,  75, 221, 124, 132, 151, 162, 253,  28,  36, 108, 180, 199,  82, 246,   1);

 Logtable : array[0..255] of Byte = (
    0,   0,  25,   1,  50,   2,  26, 198,  75, 199,  27, 104,  51, 238, 223,   3,
  100,   4, 224,  14,  52, 141, 129, 239,  76, 113,   8, 200, 248, 105,  28, 193,
  125, 194,  29, 181, 249, 185,  39, 106,  77, 228, 166, 114, 154, 201,   9, 120,
  101,  47, 138,   5,  33,  15, 225,  36,  18, 240, 130,  69,  53, 147, 218, 142,
  150, 143, 219, 189,  54, 208, 206, 148,  19,  92, 210, 241,  64,  70, 131,  56,
  102, 221, 253,  48, 191,   6, 139,  98, 179,  37, 226, 152,  34, 136, 145,  16,
  126, 110,  72, 195, 163, 182,  30,  66,  58, 107,  40,  84, 250, 133,  61, 186,
   43, 121,  10,  21, 155, 159,  94, 202,  78, 212, 172, 229, 243, 115, 167,  87,
  175,  88, 168,  80, 244, 234, 214, 116,  79, 174, 233, 213, 231, 230, 173, 232,
   44, 215, 117, 122, 235,  22,  11, 245,  89, 203,  95, 176, 156, 169,  81, 160,
  127,  12, 246, 111,  23, 196,  73, 236, 216,  67,  31,  45, 164, 118, 123, 183,
  204, 187,  62,  90, 251,  96, 177, 134,  59,  82, 161, 108, 170,  85,  41, 157,
  151, 178, 135, 144,  97, 190, 220, 252, 188, 149, 207, 205,  55,  63,  91, 209,
   83,  57, 132,  60,  65, 162, 109,  71,  20,  42, 158,  93,  86, 242, 211, 171,
   68,  17, 146, 217,  35,  32,  46, 137, 180, 124, 184,  38, 119, 153, 227, 165,
  103,  74, 237, 222, 197,  49, 254,  24,  13,  99, 140, 128, 192, 247, 112,   7);

type

 TWord8 = Byte;

function RijndaelKeySched(K : TKeyBlock; KeyBits : Integer; BlockBits : Integer; var W : TKeySchedule) : Integer;
var
 KC, BC, ROUNDS, X : Integer;
 T1, I1, I2, I3, I4, I5, I6, I7, I8, J1, J2, J3, J4, J5, J6, rconpointer : Integer;
 tk : TKeyBlock;
 Xtemp, Ktemp, A, B : Integer;

begin
 rconpointer := 0;
 // Calculate the necessary round keys
 // The number of calculations depends on keyBits and blockBits
 case KeyBits of
  128 : KC := 4;
  192 : KC := 6;
  256 : KC := 8;
 else
  begin
   Result := -1;
   Exit;
  end;
 end;
 case BlockBits of
  128 : BC := 4;
  192 : BC := 6;
  256 : BC := 8;
 else
  begin
   Result := -2;
   Exit;
  end;
 end;
 X := Max(KeyBits, BlockBits);
 case X of
  128 : ROUNDS := 10;
  192 : ROUNDS := 12;
  256 : ROUNDS := 14;
 else
  begin
   Result := -3;
   Exit;
  end;
 end;
 for J1 := 0 to KC-1 do
  for I1 := 0 to 3 do
   begin
    tk[I1,J1] := K[I1,J1];
   end;
 // copy values into round key array
 T1 := 0;
 J2 := 0;
 while ((J2 < KC) and (T1 < (ROUNDS+1)*BC)) do
  begin
   I2 := 0;
   while(I2 < 4) do
    begin
     W[T1 div BC, I2, T1 mod BC] := tk[I2, J2];
     Inc(I2);
    end;
   Inc(J2);
   Inc(T1);
  end;
 // while not enough round key material calculated */
 // calculate new values */
 while (T1 < (ROUNDS+1)*BC) do
  begin
   for I3 := 0 to 3 do
    tk[I3, 0] := tk[I3, 0] xor (S[tk[(I3+1) mod 4, KC-1]]);
   tk[0, 0] := tk[0, 0] xor rcon[rconpointer];
   Inc(rconpointer);
   if (KC <> 8) then
    begin
     for J3 := 1 to KC-1 do
      for I4 := 0 to 3 do
       tk[I4, J3] := tk[I4, J3] xor tk[I4, J3-1];
    end
   else
    begin
     for J4 := 1 to (KC div 2)-1 do
      for I5 := 0 to 3 do
       tk[I5, J4] := tk[I5, J4] xor tk[I5, J4-1];
     for I6 := 0 to 3 do
      tk[I6, KC div 2] := tk[I6, KC div 2] xor S[tk[I6, KC div 2 - 1]];
     for J5 := (KC div 2) + 1 to KC-1 do
      for I7 := 0 to 3 do
       tk[I7, J5] := tk[I7, J5] xor tk[I7, J5-1];
    end;
   // copy values into round key array */
   J6 := 0;
   while (J6 < KC) and (T1 < (ROUNDS+1)*BC) do
    begin
     for I8 := 0 to 3 do
      begin
       A := T1 div BC;
       B := T1 mod BC;
       Xtemp := tk[I8, J6];
       W[A, I8, B] := Xtemp;
      end;
     Inc(J6);
     Inc(T1);
    end;
  end;
 Result := 0;
end;

function MakeKeyPas(var Key : TKeyInstance; Direction : Integer; KeyLength : Integer; var keyMaterial : TKeyMaterial) : Integer;
var
 K : TKeyBlock;
 T : Byte;
 I, J, F, G, IMax : Integer;

begin
{ if Key = nil then
  begin
   Result := BAD_KEY_INSTANCE;
   Exit;
  end;}
 if ((direction = DIR_ENCRYPT) or (direction = DIR_DECRYPT)) then
  Key.Direction := Direction
 else
  begin
   Result := BAD_KEY_DIR;
   Exit;
  end;
 if (KeyLength = 128) or (KeyLength = 192) or (KeyLength = 256) then
  Key.KeyLength := KeyLength
 else
  begin
   Result := BAD_KEY_MAT;
   Exit;
  end;
 //if KeyMaterial then
 Move(KeyMaterial, Key.KeyMaterial, KeyLength div 4);
 // initialize key schedule
 IMax := (Key.KeyLength div 8) - 1;
 for I := 0 to IMax do
  begin
   T := Key.KeyMaterial[2*I];
   if ((T >= Ord('0')) and (T <= Ord('9'))) then
    J := Ord(T) - Ord('0') shl 4
   else if ((T >= Ord('a')) and (T <= Ord('f'))) then
    J := (Ord(T) - Ord('a') + 10) shl 4
   else if ((T >= Ord('A')) and (T <= Ord('F'))) then
    J := (Ord(T) - Ord('A') + 10) shl 4
   else
    begin
     Result := BAD_KEY_MAT;
     Exit;
    end;
   T := Key.KeyMaterial[2*I + 1];
   if ((T >= Ord('0')) and (T <= Ord('9'))) then
    J := J xor (Ord(T) - Ord('0'))
   else if ((T >= Ord('a')) and (T <= Ord('f'))) then
    J := J xor (Ord(T) - Ord('a') + 10)
   else if ((T >= Ord('A')) and (T <= Ord('F'))) then
    J := J xor (Ord(T) - Ord('A') + 10)
   else
    begin
     Result := BAD_KEY_MAT;
     Exit;
    end;
   F := I mod 4;
   G := I div 4;
   K[F, G] := J; //Incorrect "migth not have been initialized" warning ???????????????
  end;
 RijndaelKeySched(K, Key.KeyLength, Key.BlockLength, Key.KeySchedule);
 Result := TRUE;
end;

procedure AddRoundKeyPascal(var A : TBlock; const RKx : TKeySchedule; BC : Byte; RKEntry : Integer);
var
 I, J : Integer;

begin
 for I := 0 to 3 do
  for J := 0 to BC-1 do
   A[I, J] := A[I, J] xor RKx[RKEntry, I, J];
end;

procedure SubstitutionPascal(var A : TBlock; BC : Byte); //Uses globally defined S = SBox
var
 I, J : Integer;

begin
 // Replace every byte of the input by the byte at that place in the nonlinear S-box.
 // This routine implements SubBytes and InvSubBytes
 for I := 0 to 3 do
  for J := 0 to BC-1 do
   A[I, J] := S[A[I, J]];
end;

procedure InverseSubstitutionPascal(var A : TBlock; BC : Byte); //Uses globally defined Sinv = SBox
var
 I, J : Integer;

begin
 // Replace every byte of the input by the byte at that place in the nonlinear S-box.
 // This routine implements SubBytes and InvSubBytes
 for I := 0 to 3 do
  for J := 0 to BC-1 do
   A[I, J] := Sinverse[A[I, J]];
end;

procedure ShiftRowsPascal(var A : TBlock; D, BC : Byte);
var
 I, J1, J2, SC : Integer;
 Temp : array[0..3] of Byte;

begin
 //BC = 4 always for AES
 // Row 0 remains unchanged. The other three rows are shifted a variable amount
 SC  := (BC - 4) shr 1;
 for I := 1 to 3 do
  begin
   for J1 := 0 to BC-1 do
    Temp[J1] := A[I, (J1 + Shifts[SC, I, D]) mod BC];
   for J2 := 0 to BC-1 do
    A[I, J2] := Temp[J2];
  end;
end;

function MulGF2m(A, B : Byte) : Byte;
begin
 // Multiply two elements of GF(2^m). Needed for MixColumn and InvMixColumn
 if (A <> 0) and (B <> 0) then
  Result := Alogtable[(Logtable[A] + Logtable[B]) mod 255]
 else
  Result := 0;
end;

procedure MixColumnsPascal(var A : TBlock; BC : Byte);
var
 B : array[0..3] of array[0..3] of Byte;
 I, J : Integer;

begin
 // Mix the four bytes of every column in a linear way
 for J := 0 to BC-1 do
  for I := 0 to 3 do
   begin
    B[I, J] := MulGF2m(2, A[I,J])
           xor MulGF2m(3, A[(I+1) mod 4, J])
           xor A[(I+ 2) mod 4, J]
           xor A[(I+ 3) mod 4, J];
   end;
 for I := 0 to 3 do
  for J := 0 to BC-1 do
   A[I, J] := B[I, J];
end;

function RijndaelEncryptPascal(var Block : TBlock; KeyBits, BlockBits : Integer; const RoundKeys : TKeySchedule) : Integer;
var
 Rounds, R, BC, X : Integer;

begin
 case BlockBits of
  128 : BC := 4;  //Only valid entry for AES
  //192 : BC := 6;
  //256 : BC := 8;
 else
  Result := -2;
  Exit;
 end;
 X := Max(BlockBits, KeyBits);
 case X of
  128 : Rounds := 10;
  192 : Rounds := 12;
  256 : Rounds := 14;
 else
  Result := -3;
  Exit;
 end;
 AddRoundKeyPascal(Block, RoundKeys, BC, 0);
 for R := 1 to Rounds-1 do
  begin
   SubstitutionPascal(Block, BC); //Uses SBox Originally it is send as parameter
   ShiftRowsPascal(Block, 0, BC);
   MixColumnsPascal(Block, BC);
   AddRoundKeyPascal(Block, RoundKeys, BC, R);
  end;
 SubstitutionPascal(Block, BC);
 ShiftRowsPascal(Block, 0, BC);
 AddRoundKeyPascal(Block, RoundKeys, BC, Rounds);
 Result := 0;
end;

procedure InverseMixColumnsPascal(var A : TBlock; BC : Byte);
var
 B : array[0..3] of array[0..3] of Byte;
 I, J : Integer;

begin
 // Mix the four bytes of every column in a linear way
 // This is the opposite operation of Mixcolumns
 for J := 0 to BC-1 do
  for I := 0 to 3 do
   begin
    B[I, J] := MulGF2m($E, A[I,J])
           xor MulGF2m($B, A[(I+1) mod 4, J])
           xor MulGF2m($D, A[(I+2) mod 4, J])
           xor MulGF2m($9, A[(I+3) mod 4, J])
   end;
 for I := 0 to 3 do
  for J := 0 to BC-1 do
   A[I, J] := B[I, J];
end;

function RijndaelDecryptPascal(var Block : TBlock; KeyBits, BlockBits : Integer; const RoundKeys : TKeySchedule) : Integer;
var
 R, BC, ROUNDS, X : Integer;

begin
 case BlockBits of
  128 : BC := 4;
  192 : BC := 6;
  256 : BC := 8;
 else
  begin
   Result := -2;
   Exit;
  end;
 end;
 X := Max(KeyBits, BlockBits);
 case X of
  128 : ROUNDS := 10;
  192 : ROUNDS := 12;
  256 : ROUNDS := 14;
 else
  begin
   Result := -3;
   Exit;
  end;
 end;
 // First the special round: without InvMixColumns with extra AddRoundKey
 AddRoundKeyPascal(Block, RoundKeys, BC, ROUNDS);
 InverseSubstitutionPascal(Block, BC); //Uses SBox Originally it is send as parameter
 ShiftRowsPascal(Block, 1, BC);
 for R := Rounds-1 downto 1 do
  begin
   AddRoundKeyPascal(Block, RoundKeys, BC, R);
   InverseMixColumnsPascal(Block, BC);
   InverseSubstitutionPascal(Block, BC); //Uses inverse SBox Originally it is send as parameter
   ShiftRowsPascal(Block, 1, BC);
  end;
 // End with the extra key addition
 AddRoundKeyPascal(Block, RoundKeys, BC, 0);
 Result := 0;
end;

end.
