unit AESLBGUnit;

interface

procedure EncryptAES_LBG_PAS_1(const Context; var Block);

implementation

uses
 AESTurboLockUnit;

type
 TAESVectors = array[0..3] of TAESVector;

procedure EncryptAES_LBG_PAS_1(const Context; var Block);
var
  i : byte;
  pContext : ^TAESContext;
  e : TAESVectors;
  begin
    pContext := @Context;
    if PContext.Encrypt then
  begin
   TAESVectors(Block)[0].dw := TAESVectors(Block)[0].dw xor
TAESVectors(pContext.RoundKeys.Rk[0])[0].dw;
   TAESVectors(Block)[1].dw := TAESVectors(Block)[1].dw xor
TAESVectors(pContext.RoundKeys.Rk[0])[1].dw;
   TAESVectors(Block)[2].dw := TAESVectors(Block)[2].dw xor
TAESVectors(pContext.RoundKeys.Rk[0])[2].dw;
   TAESVectors(Block)[3].dw := TAESVectors(Block)[3].dw xor
TAESVectors(pContext.RoundKeys.Rk[0])[3].dw;
   for i := 1 to (pContext.Rounds - 1) do
     Begin
       e[0].dw := AES_T0[TAESVectors(Block)[0].bt[0]] xor
                  AES_T1[TAESVectors(Block)[1].bt[1]] xor
                  AES_T2[TAESVectors(Block)[2].bt[2]] xor
                  AES_T3[TAESVectors(Block)[3].bt[3]];
       e[1].dw := AES_T0[TAESVectors(Block)[1].bt[0]] xor
                  AES_T1[TAESVectors(Block)[2].bt[1]] xor
                  AES_T2[TAESVectors(Block)[3].bt[2]] xor
                  AES_T3[TAESVectors(Block)[0].bt[3]];
       e[2].dw := AES_T0[TAESVectors(Block)[2].bt[0]] xor
                  AES_T1[TAESVectors(Block)[3].bt[1]] xor
                  AES_T2[TAESVectors(Block)[0].bt[2]] xor
                  AES_T3[TAESVectors(Block)[1].bt[3]];
       e[3].dw := AES_T0[TAESVectors(Block)[3].bt[0]] xor
                  AES_T1[TAESVectors(Block)[0].bt[1]] xor
                  AES_T2[TAESVectors(Block)[1].bt[2]] xor
                  AES_T3[TAESVectors(Block)[2].bt[3]];
       TAESVectors(Block)[0].dw := E[0].dw xor
TAESVectors(pContext.RoundKeys.Rk[i])[0].dw ;
       TAESVectors(Block)[1].dw := E[1].dw xor
TAESVectors(pContext.RoundKeys.Rk[i])[1].dw ;
       TAESVectors(Block)[2].dw := E[2].dw xor
TAESVectors(pContext.RoundKeys.Rk[i])[2].dw;
       TAESVectors(Block)[3].dw := E[3].dw xor
TAESVectors(pContext.RoundKeys.Rk[i])[3].dw;
     end;
     e[0].dw :=  AESSBox[TAESVectors(Block)[0].bt[0]] +
                 AESSBox[TAESVectors(Block)[1].bt[1]] shl 8 +
                 AESSBox[TAESVectors(Block)[2].bt[2]] shl 16 +
                 AESSBox[TAESVectors(Block)[3].bt[3]] shl 24;
     e[1].dw :=  AESSBox[TAESVectors(Block)[0].bt[3]] shl 24 +
                 AESSBox[TAESVectors(Block)[2].bt[1]] shl 8 +
                 AESSBox[TAESVectors(Block)[3].bt[2]] shl 16 +
                 AESSBox[TAESVectors(Block)[1].bt[0]];
     e[2].dw :=  AESSBox[TAESVectors(Block)[2].bt[0]]  +
                 AESSBox[TAESVectors(Block)[3].bt[1]] shl 8 +
                 AESSBox[TAESVectors(Block)[0].bt[2]] shl 16 +
                 AESSBox[TAESVectors(Block)[1].bt[3]] shl 24;
     e[3].dw :=  AESSBox[TAESVectors(Block)[3].bt[0]]  +
                 AESSBox[TAESVectors(Block)[0].bt[1]] shl 8 +
                 AESSBox[TAESVectors(Block)[1].bt[2]] shl 16 +
                 AESSBox[TAESVectors(Block)[2].bt[3]] shl 24;
     TAESVectors(Block)[0].dw := E[0].dw xor
TAESVectors(pContext.RoundKeys.Rk[pContext.Rounds])[0].dw;
     TAESVectors(Block)[1].dw := e[1].dw xor
TAESVectors(pContext.RoundKeys.Rk[pContext.Rounds])[1].dw;
     TAESVectors(Block)[2].dw := e[2].dw xor
TAESVectors(pContext.RoundKeys.Rk[pContext.Rounds])[2].dw;
     TAESVectors(Block)[3].dw := e[3].dw xor
TAESVectors(pContext.RoundKeys.Rk[pContext.Rounds])[3].dw;
   end
   else begin
     TAESVectors(Block)[0].dw := TAESVectors(Block)[0].dw xor
TAESVectors(pContext.RoundKeys.Rk[pContext.Rounds])[0].dw;
     TAESVectors(Block)[1].dw := TAESVectors(Block)[1].dw xor
TAESVectors(pContext.RoundKeys.Rk[pContext.Rounds])[1].dw;
     TAESVectors(Block)[2].dw := TAESVectors(Block)[2].dw xor
TAESVectors(pContext.RoundKeys.Rk[pContext.Rounds])[2].dw;
     TAESVectors(Block)[3].dw := TAESVectors(Block)[3].dw xor
TAESVectors(pContext.RoundKeys.Rk[pContext.Rounds])[3].dw;
     e[0].bt[0] := AESInvSBox[TAESVectors(Block)[0].bt[0]];
     e[0].bt[1] := AESInvSBox[TAESVectors(Block)[3].bt[1]];
     e[0].bt[2] := AESInvSBox[TAESVectors(Block)[2].bt[2]];
     e[0].bt[3] := AESInvSBox[TAESVectors(Block)[1].bt[3]];
     e[1].bt[0] := AESInvSBox[TAESVectors(Block)[1].bt[0]];
     e[1].bt[1] := AESInvSBox[TAESVectors(Block)[0].bt[1]];
     e[1].bt[2] := AESInvSBox[TAESVectors(Block)[3].bt[2]];
     e[1].bt[3] := AESInvSBox[TAESVectors(Block)[2].bt[3]];
     e[2].bt[0] := AESInvSBox[TAESVectors(Block)[2].bt[0]];
     e[2].bt[1] := AESInvSBox[TAESVectors(Block)[1].bt[1]];
     e[2].bt[2] := AESInvSBox[TAESVectors(Block)[0].bt[2]];
     e[2].bt[3] := AESInvSBox[TAESVectors(Block)[3].bt[3]];
     e[3].bt[0] := AESInvSBox[TAESVectors(Block)[3].bt[0]];
     e[3].bt[1] := AESInvSBox[TAESVectors(Block)[2].bt[1]];
     e[3].bt[2] := AESInvSBox[TAESVectors(Block)[1].bt[2]];
     e[3].bt[3] := AESInvSBox[TAESVectors(Block)[0].bt[3]];
     TAESVectors(Block)[0].dw := TAESVectors(e)[0].dw;
     TAESVectors(Block)[1].dw := TAESVectors(e)[1].dw;
     TAESVectors(Block)[2].dw := TAESVectors(e)[2].dw;
     TAESVectors(Block)[3].dw := TAESVectors(e)[3].dw;
     for i := (pContext.Rounds - 1) downto 1 do
     begin
       TAESVectors(Block)[0].dw := TAESVectors(Block)[0].dw xor
TAESVectors(pContext.RoundKeys.Rk[i])[0].dw;
       TAESVectors(Block)[1].dw := TAESVectors(Block)[1].dw xor
TAESVectors(pContext.RoundKeys.Rk[i])[1].dw;
       TAESVectors(Block)[2].dw := TAESVectors(Block)[2].dw xor
TAESVectors(pContext.RoundKeys.Rk[i])[2].dw;
       TAESVectors(Block)[3].dw := TAESVectors(Block)[3].dw xor
TAESVectors(pContext.RoundKeys.Rk[i])[3].dw;
       e[0].dw := AES_InvT0[TAESVectors(Block)[0].bt[0]] xor
                  AES_InvT1[TAESVectors(Block)[0].bt[1]] xor
                  AES_InvT2[TAESVectors(Block)[0].bt[2]] xor
                  AES_InvT3[TAESVectors(Block)[0].bt[3]];
       e[1].dw := AES_InvT0[TAESVectors(Block)[1].bt[0]] xor
                  AES_InvT1[TAESVectors(Block)[1].bt[1]] xor
                  AES_InvT2[TAESVectors(Block)[1].bt[2]] xor
                  AES_InvT3[TAESVectors(Block)[1].bt[3]];
       e[2].dw := AES_InvT0[TAESVectors(Block)[2].bt[0]] xor
                  AES_InvT1[TAESVectors(Block)[2].bt[1]] xor
                  AES_InvT2[TAESVectors(Block)[2].bt[2]] xor
                  AES_InvT3[TAESVectors(Block)[2].bt[3]];
       e[3].dw := AES_InvT0[TAESVectors(Block)[3].bt[0]] xor
                  AES_InvT1[TAESVectors(Block)[3].bt[1]] xor
                  AES_InvT2[TAESVectors(Block)[3].bt[2]] xor
                  AES_InvT3[TAESVectors(Block)[3].bt[3]];
      TAESVectors(Block)[0].dw := AESInvSBox[e[0].bt[0]] +
                                  AESInvSBox[e[3].bt[1]] shl 8 +
                                  AESInvSBox[e[2].bt[2]] shl 16 +
                                  AESInvSBox[e[1].bt[3]] shl 24;
      TAESVectors(Block)[1].dw := AESInvSBox[e[1].bt[0]] +
                                  AESInvSBox[e[0].bt[1]] shl 8 +
                                  AESInvSBox[e[3].bt[2]] shl 16 +
                                  AESInvSBox[e[2].bt[3]] shl 24;
      TAESVectors(Block)[2].dw := AESInvSBox[e[2].bt[0]] +
                                  AESInvSBox[e[1].bt[1]] shl 8 +
                                  AESInvSBox[e[0].bt[2]] shl 16 +
                                  AESInvSBox[e[3].bt[3]] shl 24;
      TAESVectors(Block)[3].dw := AESInvSBox[e[3].bt[0]] +
                                  AESInvSBox[e[2].bt[1]] shl 8 +
                                  AESInvSBox[e[1].bt[2]] shl 16 +
                                  AESInvSBox[e[0].bt[3]] shl 24;
     end;
     TAESVectors(Block)[0].dw := TAESVectors(Block)[0].dw xor
TAESVectors(pContext.RoundKeys.Rk[0])[0].dw;
     TAESVectors(Block)[1].dw := TAESVectors(Block)[1].dw xor
TAESVectors(pContext.RoundKeys.Rk[0])[1].dw;
     TAESVectors(Block)[2].dw := TAESVectors(Block)[2].dw xor
TAESVectors(pContext.RoundKeys.Rk[0])[2].dw;
     TAESVectors(Block)[3].dw := TAESVectors(Block)[3].dw xor
TAESVectors(pContext.RoundKeys.Rk[0])[3].dw;
  end;
end;

end.

