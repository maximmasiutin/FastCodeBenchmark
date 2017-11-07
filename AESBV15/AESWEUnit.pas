unit AESWEUnit;

interface

// Global encryption/decryption contexts, quick hack to
// get a working model for the suggested AESBV06+ interface
// (c) W.Ehrhardt Aug.2004


procedure MakeContextsAES_WE_PAS_5(const Key; KeySize: cardinal);
  {-Initialize unit global contexts, keysize = keybits div 32}

procedure EncryptAES_WE_PAS_5(var Block);
  {-encrypt one block with encryption context}

procedure DecryptAES_WE_PAS_5(var Block);
  {-decrypt one block with decryption context}


implementation


uses
  AES_Type, AES_Encr, AES_Decr, SysUtils {for exceptions};


var
  ctx: array[boolean] of TAES_WE_Context;  {true=enc, false=dec}


{---------------------------------------------------------------------------}
procedure MakeContextsAES_WE_PAS_5(const Key; KeySize: cardinal);
  {-Initialize unit global contexts, keysize = keybits div 32}
var
  KeyBits: word;
begin
  KeyBits := 32*KeySize;
  {** Note: final version should return error code instead of raising exceptions **}
  if AES_Init_Encr(Key, KeyBits, ctx[true])<>0 then begin
    raise Exception.Create('AES_Init_Encr failed');
  end;
  if AES_Init_Decr(Key, KeyBits, ctx[false])<>0 then begin
    raise Exception.Create('AES_Init_Decr failed');
  end;
end;


{---------------------------------------------------------------------------}
procedure EncryptAES_WE_PAS_5(var Block);
  {-encrypt one block with encryption context}
begin
  AES_WE_Encrypt(ctx[true], TAES_WE_Block(Block), TAES_WE_Block(Block));
end;


{---------------------------------------------------------------------------}
procedure DecryptAES_WE_PAS_5(var Block);
  {-decrypt one block with decryption context}
begin
  AES_WE_Decrypt(ctx[false], TAES_WE_Block(Block), TAES_WE_Block(Block));
end;

end.

