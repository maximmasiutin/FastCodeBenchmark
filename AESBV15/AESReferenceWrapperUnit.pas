unit AESReferenceWrapperUnit;

interface

uses
 AESTurboLockUnit;

//procedure EncryptAES_REF_PAS_1(const Context : TAESContext; var Block : TAESBlock);
procedure EncryptAES_REF_PAS_2(const Context; var Block);

procedure MakeContextsAES_REF_PAS_3(const Key; KeySize : Cardinal);
procedure EncryptAES_REF_PAS_3(var Block);
procedure DecryptAES_REF_PAS_3(var Block);

implementation

uses
 AESReferenceUnit, SysUtils;
{
procedure EncryptAES_REF_PAS_1(const Context : TAESContext; var Block : TAESBlock);
var
 Block1 : TBlockRecord;
 KeyBits, BlockBits, Res, J1, J2, J3, J4, I1, I2, I3, I4, I5, I6 : Integer;
 RoundKeys : TKeyScheduleRecord;

begin
 KeyBits := Context.KeySize * 32;
 BlockBits := 128;
 for J1 := 0 to 14 do
  begin
   J4 := 0;
   for J2 := 0 to 3 do
    begin
     for J3 := 0 to 3 do
      begin
       RoundKeys.KeyScheduleFuck[J1, J3, J2] := Context.RoundKeys.RK[J1][J4];
       Inc(J4);
      end;
    end;
  end;
 I3 := 0;
 for I1 := 0 to 3 do
  begin
   for I2 := 0 to 3 do
    begin
     Block1.BlockFuck[I2, I1] := Block[I3];
     Inc(I3);
    end;
  end;
 if Context.Encrypt then
  Res := RijndaelEncryptPascal(Block1, KeyBits, BlockBits, RoundKeys)
 else
  Res := RijndaelDecryptPascal(Block1, KeyBits, BlockBits, RoundKeys);
 if Res <> 0 then
  raise Exception.Create('sefasfga');
 I6 := 0;
 for I4 := 0 to 3 do
  for I5 := 0 to 3 do
   begin
    Block[I6] := Block1.BlockFuck[I5, I4];
    Inc(I6);
   end;
end;
}
procedure EncryptAES_REF_PAS_2(const Context; var Block);
var
 Block1 : TBlock;
 KeyBits, BlockBits, Res, J1, J2, J3, J4, I1, I2, I3, I4, I5, I6 : Integer;
 RoundKeys : TKeySchedule;
 pContext : ^TAESContext;
 pBlock : ^TAESBlock;

begin
 pContext := @Context;
 pBlock := @Block;
 KeyBits := pContext.KeySize * 32;
 BlockBits := 128;
 for J1 := 0 to 14 do
  begin
   J4 := 0;
   for J2 := 0 to 3 do
    begin
     for J3 := 0 to 3 do
      begin
       RoundKeys[J1, J3, J2] := pContext.RoundKeys.RK[J1][J4];
       Inc(J4);
      end;
    end;
  end;
 I3 := 0;
 for I1 := 0 to 3 do
  begin
   for I2 := 0 to 3 do
    begin
     Block1[I2, I1] := pBlock[I3];
     Inc(I3);
    end;
  end;
 if pContext.Encrypt then
  Res := RijndaelEncryptPascal(Block1, KeyBits, BlockBits, RoundKeys)
 else
  Res := RijndaelDecryptPascal(Block1, KeyBits, BlockBits, RoundKeys);
 if Res <> 0 then
  raise Exception.Create('sefasfga');
 I6 := 0;
 for I4 := 0 to 3 do
  for I5 := 0 to 3 do
   begin
    pBlock[I6] := Block1[I5, I4];
    Inc(I6);
   end;
end;

var
 EncryptRoundKeys : TKeySchedule;
 DecryptRoundKeys : TKeySchedule;
 KeyBits, BlockBits : Integer;

type
 TAESKeyBlock  = array[0..33] of Byte;

procedure MakeContextsAES_REF_PAS_3(const Key; KeySize : Cardinal);
var
 K : TKeyBlock;//TKeyBlock = array[0..3, 0..7] of Byte;
 Result, I, J : Integer;

begin
 KeyBits := KeySize * 32;
 BlockBits := 128;
 for I := 0 to 3 do
  for J := 0 to 7 do
   K[I, J] := 0;
 if KeyBits = 128 then
  begin
   K[0, 0] := TAESKeyBlock(Key)[0];
   K[1, 0] := TAESKeyBlock(Key)[1];
   K[2, 0] := TAESKeyBlock(Key)[2];
   K[3, 0] := TAESKeyBlock(Key)[3];
   K[0, 1] := TAESKeyBlock(Key)[4];
   K[1, 1] := TAESKeyBlock(Key)[5];
   K[2, 1] := TAESKeyBlock(Key)[6];
   K[3, 1] := TAESKeyBlock(Key)[7];
   K[0, 2] := TAESKeyBlock(Key)[8];
   K[1, 2] := TAESKeyBlock(Key)[9];
   K[2, 2] := TAESKeyBlock(Key)[10];
   K[3, 2] := TAESKeyBlock(Key)[11];
   K[0, 3] := TAESKeyBlock(Key)[12];
   K[1, 3] := TAESKeyBlock(Key)[13];
   K[2, 3] := TAESKeyBlock(Key)[14];
   K[3, 3] := TAESKeyBlock(Key)[15];
  end
 else if KeyBits = 192 then
  begin
   K[0, 0] := TAESKeyBlock(Key)[0];
   K[1, 0] := TAESKeyBlock(Key)[1];
   K[2, 0] := TAESKeyBlock(Key)[2];
   K[3, 0] := TAESKeyBlock(Key)[3];
   K[0, 1] := TAESKeyBlock(Key)[4];
   K[1, 1] := TAESKeyBlock(Key)[5];
   K[2, 1] := TAESKeyBlock(Key)[6];
   K[3, 1] := TAESKeyBlock(Key)[7];
   K[0, 2] := TAESKeyBlock(Key)[8];
   K[1, 2] := TAESKeyBlock(Key)[9];
   K[2, 2] := TAESKeyBlock(Key)[10];
   K[3, 2] := TAESKeyBlock(Key)[11];
   K[0, 3] := TAESKeyBlock(Key)[12];
   K[1, 3] := TAESKeyBlock(Key)[13];
   K[2, 3] := TAESKeyBlock(Key)[14];
   K[3, 3] := TAESKeyBlock(Key)[15];
   K[0, 4] := TAESKeyBlock(Key)[16];
   K[1, 4] := TAESKeyBlock(Key)[17];
   K[2, 4] := TAESKeyBlock(Key)[18];
   K[3, 4] := TAESKeyBlock(Key)[19];
   K[0, 5] := TAESKeyBlock(Key)[20];
   K[1, 5] := TAESKeyBlock(Key)[21];
   K[2, 5] := TAESKeyBlock(Key)[22];
   K[3, 5] := TAESKeyBlock(Key)[23];
  end
 else if KeyBits = 256 then
  begin
   K[0, 0] := TAESKeyBlock(Key)[0];
   K[1, 0] := TAESKeyBlock(Key)[1];
   K[2, 0] := TAESKeyBlock(Key)[2];
   K[3, 0] := TAESKeyBlock(Key)[3];
   K[0, 1] := TAESKeyBlock(Key)[4];
   K[1, 1] := TAESKeyBlock(Key)[5];
   K[2, 1] := TAESKeyBlock(Key)[6];
   K[3, 1] := TAESKeyBlock(Key)[7];
   K[0, 2] := TAESKeyBlock(Key)[8];
   K[1, 2] := TAESKeyBlock(Key)[9];
   K[2, 2] := TAESKeyBlock(Key)[10];
   K[3, 2] := TAESKeyBlock(Key)[11];
   K[0, 3] := TAESKeyBlock(Key)[12];
   K[1, 3] := TAESKeyBlock(Key)[13];
   K[2, 3] := TAESKeyBlock(Key)[14];
   K[3, 3] := TAESKeyBlock(Key)[15];
   K[0, 4] := TAESKeyBlock(Key)[16];
   K[1, 4] := TAESKeyBlock(Key)[17];
   K[2, 4] := TAESKeyBlock(Key)[18];
   K[3, 4] := TAESKeyBlock(Key)[19];
   K[0, 5] := TAESKeyBlock(Key)[20];
   K[1, 5] := TAESKeyBlock(Key)[21];
   K[2, 5] := TAESKeyBlock(Key)[22];
   K[3, 5] := TAESKeyBlock(Key)[23];
   K[0, 6] := TAESKeyBlock(Key)[24];
   K[1, 6] := TAESKeyBlock(Key)[25];
   K[2, 6] := TAESKeyBlock(Key)[26];
   K[3, 6] := TAESKeyBlock(Key)[27];
   K[0, 7] := TAESKeyBlock(Key)[28];
   K[1, 7] := TAESKeyBlock(Key)[29];
   K[2, 7] := TAESKeyBlock(Key)[30];
   K[3, 7] := TAESKeyBlock(Key)[31];
  end
 else
  raise Exception.Create('Invalid KeySize');
 //function RijndaelKeySched(K : TKeyBlock; KeyBits : Integer; BlockBits : Integer; var W : TKeySchedule) : Integer;
 Result := RijndaelKeySched(K, KeyBits, BlockBits, EncryptRoundKeys);
 if Result <> 0 then
  raise Exception.Create('RijndaelKeySched failed');
 Result := RijndaelKeySched(K, KeyBits, BlockBits, DecryptRoundKeys);
 if Result <> 0 then
  raise Exception.Create('RijndaelKeySched failed');
end;

procedure EncryptAES_REF_PAS_3(var Block);
var
 RefBlock : TBlock;//TBlock = array[0..3, 0..3] of Byte;
 Result : Integer;

begin
 //function RijndaelEncryptPascal(var Block : TBlockRecord; KeyBits, BlockBits : Integer; const RoundKeys : TKeyScheduleRecord) : Integer;
 RefBlock[0, 0] := TAESBlock(Block)[0];
 RefBlock[1, 0] := TAESBlock(Block)[1];
 RefBlock[2, 0] := TAESBlock(Block)[2];
 RefBlock[3, 0] := TAESBlock(Block)[3];
 RefBlock[0, 1] := TAESBlock(Block)[4];
 RefBlock[1, 1] := TAESBlock(Block)[5];
 RefBlock[2, 1] := TAESBlock(Block)[6];
 RefBlock[3, 1] := TAESBlock(Block)[7];
 RefBlock[0, 2] := TAESBlock(Block)[8];
 RefBlock[1, 2] := TAESBlock(Block)[9];
 RefBlock[2, 2] := TAESBlock(Block)[10];
 RefBlock[3, 2] := TAESBlock(Block)[11];
 RefBlock[0, 3] := TAESBlock(Block)[12];
 RefBlock[1, 3] := TAESBlock(Block)[13];
 RefBlock[2, 3] := TAESBlock(Block)[14];
 RefBlock[3, 3] := TAESBlock(Block)[15];
 Result := RijndaelEncryptPascal(RefBlock, KeyBits, BlockBits, EncryptRoundKeys);
 if Result <> 0 then
  raise Exception.Create('RijndaelEncryptPascal failed');
 TAESBlock(Block)[0] := RefBlock[0, 0];
 TAESBlock(Block)[1] := RefBlock[1, 0];
 TAESBlock(Block)[2] := RefBlock[2, 0];
 TAESBlock(Block)[3] := RefBlock[3, 0];
 TAESBlock(Block)[4] := RefBlock[0, 1];
 TAESBlock(Block)[5] := RefBlock[1, 1];
 TAESBlock(Block)[6] := RefBlock[2, 1];
 TAESBlock(Block)[7] := RefBlock[3, 1];
 TAESBlock(Block)[8] := RefBlock[0, 2];
 TAESBlock(Block)[9] := RefBlock[1, 2];
 TAESBlock(Block)[10] := RefBlock[2, 2];
 TAESBlock(Block)[11] := RefBlock[3, 2];
 TAESBlock(Block)[12] := RefBlock[0, 3];
 TAESBlock(Block)[13] := RefBlock[1, 3];
 TAESBlock(Block)[14] := RefBlock[2, 3];
 TAESBlock(Block)[15] := RefBlock[3, 3];
end;

procedure DecryptAES_REF_PAS_3(var Block);
var
 RefBlock : TBlock;
 Result : Integer;

begin
 RefBlock[0, 0] := TAESBlock(Block)[0];
 RefBlock[1, 0] := TAESBlock(Block)[1];
 RefBlock[2, 0] := TAESBlock(Block)[2];
 RefBlock[3, 0] := TAESBlock(Block)[3];
 RefBlock[0, 1] := TAESBlock(Block)[4];
 RefBlock[1, 1] := TAESBlock(Block)[5];
 RefBlock[2, 1] := TAESBlock(Block)[6];
 RefBlock[3, 1] := TAESBlock(Block)[7];
 RefBlock[0, 2] := TAESBlock(Block)[8];
 RefBlock[1, 2] := TAESBlock(Block)[9];
 RefBlock[2, 2] := TAESBlock(Block)[10];
 RefBlock[3, 2] := TAESBlock(Block)[11];
 RefBlock[0, 3] := TAESBlock(Block)[12];
 RefBlock[1, 3] := TAESBlock(Block)[13];
 RefBlock[2, 3] := TAESBlock(Block)[14];
 RefBlock[3, 3] := TAESBlock(Block)[15];
 //function RijndaelDecryptPascal(var Block : TBlockRecord; KeyBits, BlockBits : Integer; const RoundKeys : TKeyScheduleRecord) : Integer;
 Result := RijndaelDecryptPascal(RefBlock, KeyBits, BlockBits, DecryptRoundKeys);
 if Result <> 0 then
  raise Exception.Create('RijndaelDecryptPascal failed');
 TAESBlock(Block)[0] := RefBlock[0, 0];
 TAESBlock(Block)[1] := RefBlock[1, 0];
 TAESBlock(Block)[2] := RefBlock[2, 0];
 TAESBlock(Block)[3] := RefBlock[3, 0];
 TAESBlock(Block)[4] := RefBlock[0, 1];
 TAESBlock(Block)[5] := RefBlock[1, 1];
 TAESBlock(Block)[6] := RefBlock[2, 1];
 TAESBlock(Block)[7] := RefBlock[3, 1];
 TAESBlock(Block)[8] := RefBlock[0, 2];
 TAESBlock(Block)[9] := RefBlock[1, 2];
 TAESBlock(Block)[10] := RefBlock[2, 2];
 TAESBlock(Block)[11] := RefBlock[3, 2];
 TAESBlock(Block)[12] := RefBlock[0, 3];
 TAESBlock(Block)[13] := RefBlock[1, 3];
 TAESBlock(Block)[14] := RefBlock[2, 3];
 TAESBlock(Block)[15] := RefBlock[3, 3];
end;

end.
