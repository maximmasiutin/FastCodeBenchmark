unit IDCT_LC_Unit;

interface

implementation

uses
 MainUnit, IDCTREFUnit;

const
  // we use 9 bits of precision, so must multiply by 2^9
  cIAccConstScale = 1 shl 9;
  FIX_0_298631336 : Integer = Round(cIAccConstScale * 0.298631336);
  FIX_0_390180644 : Integer = Round(cIAccConstScale * 0.390180644);
  FIX_0_541196100 : Integer = Round(cIAccConstScale * 0.541196100);
  FIX_0_765366865 : Integer = Round(cIAccConstScale * 0.765366865);
  FIX_0_899976223 : Integer = Round(cIAccConstScale * 0.899976223);
  FIX_1_175875602 : Integer = Round(cIAccConstScale * 1.175875602);
  FIX_1_501321110 : Integer = Round(cIAccConstScale * 1.501321110);
  FIX_1_847759065 : Integer = Round(cIAccConstScale * 1.847759065);
  FIX_1_961570560 : Integer = Round(cIAccConstScale * 1.961570560);
  FIX_2_053119869 : Integer = Round(cIAccConstScale * 2.053119869);
  FIX_2_562915447 : Integer = Round(cIAccConstScale * 2.562915447);
  FIX_3_072711026 : Integer = Round(cIAccConstScale * 3.072711026);
  FIX_1_414213562 : Integer = Round(cIAccConstScale * 1.414213562);
  FIX_1_082392200 : Integer = Round(cIAccConstScale * 1.082392200);
  FIX_2_613125930 : Integer = Round(cIAccConstScale * 2.613125930);
  FIX_Minus_0_899976223 : Integer = -Round(cIAccConstScale * 0.899976223);
  FIX_Minus_2_562915447 : Integer = -Round(cIAccConstScale * 2.562915447);
  FIX_Minus_1_961570560 : Integer = -Round(cIAccConstScale * 1.961570560);
  FIX_Minus_0_390180644 : Integer = -Round(cIAccConstScale * 0.390180644);
  FIX_Minus_1_847759065 : Integer = -Round(cIAccConstScale * 1.847759065);

// Based heavily on function InverseDCT_DKC_Pas_6_a
procedure InverseDCT_LC_Pas_1_a(const Coef: TsdCoefBlock;
                                const Quant : TsdIntArray64; out Sample: TsdSampleBlock;
                                var Wrksp: TsdIntArray64);
var
 I: integer;
 dci: integer;
 dcs: Byte;
 z1, z2, z3, z4, z5: integer;
 tmp0, tmp1, tmp2, tmp3, tmp10, tmp11, tmp12, tmp13, Temp: Integer;
 srow: PsdSampleBlock;
 wrow: ^TsdIntArray64;
begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and 
      (Coef[I+32] = 0) and (Coef[I+40] = 0) and (Coef[I+48] = 0) and
      (Coef[I+56] = 0) then
    begin
     dci := Coef[I] * Quant[I];
     Wrksp[I] := dci;
     Wrksp[I+8] := dci;
     Wrksp[I+16] := dci;
     Wrksp[I+24] := dci;
     Wrksp[I+32] := dci;
     Wrksp[I+40] := dci;
     Wrksp[I+48] := dci;
     Wrksp[I+56] := dci;
    end
   else
    begin
     { Even part: reverse the even part of the forward DCT. }
     { The rotator is sqrt(2)*c(-6). }

     z2 := Coef[I+16] * Quant[I+16];
     z3 := Coef[I+48] * Quant[I+48];

     z1 := ((z2 + z3) * FIX_0_541196100);
     tmp2 := (z1 + z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := (z1 + z2 * FIX_0_765366865) div (1 shl 9);

     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I+32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse. i0..i3 are y7,y5,y3,y1 respectively.}

     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;

     z5 := ((z3 + z4) * FIX_1_175875602); { sqrt(2) * c3 }

     tmp0 := (tmp0 * FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := (tmp1 * FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := (tmp2 * FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := (tmp3 * FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }

     z1 := (z1 * FIX_Minus_0_899976223); { sqrt(2) * (c7-c3) }
     z2 := (z2 * FIX_Minus_2_562915447); { sqrt(2) * (-c1-c3) }
     z3 := (z3 * FIX_Minus_1_961570560); { sqrt(2) * (-c3-c5) }
     z4 := (z4 * FIX_Minus_0_390180644); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     tmp0:= (tmp0 + z1 + z3) div (1 shl 9);
     tmp1:= (tmp1 + z2 + z4) div (1 shl 9);
     tmp2:= (tmp2 + z2 + z3) div (1 shl 9);
     tmp3:= (tmp3 + z1 + z4) div (1 shl 9);

     { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

     Wrksp[I] := tmp10 + tmp3;
     Wrksp[I+56] := tmp10 - tmp3;
     Wrksp[I+8] := tmp11 + tmp2;
     Wrksp[I+48] := tmp11 - tmp2;
     Wrksp[I+16] := tmp12 + tmp1;
     Wrksp[I+40] := tmp12 - tmp1;
     Wrksp[I+24] := tmp13 + tmp0;
     Wrksp[I+32] := tmp13 - tmp0;
    end;
  end;

 // Next do the rows
 srow:= @Sample[0];
 wrow:= @Wrksp[0];

 for i := 0 to 7 do
  begin
   if (wrow[1] = 0) and (wrow[2] = 0) and (wrow[3] = 0) and 
      (wrow[4] = 0) and (wrow[5] = 0) and (wrow[6] = 0) and 
      (wrow[7] = 0) then
    begin
     //dcs := DeScaleRangeLimit(w0^);
     Temp := wrow[0] div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     srow[0] := dcs;
     srow[1] := dcs;
     srow[2] := dcs;
     srow[3] := dcs;
     srow[4] := dcs;
     srow[5] := dcs;
     srow[6] := dcs;
     srow[7] := dcs;
    end
   else
    begin
     { Even part: reverse the even part of the forward DCT. }
     { The rotator is sqrt(2)*c(-6). }

     z2 := wrow[2];
     z3 := wrow[6];

     z1 := ((z2 + z3) * FIX_0_541196100);
     tmp2 := (z1 + z3 * FIX_Minus_1_847759065);
     tmp3 := (z1 + z2 * FIX_0_765366865);

     tmp0 := (wrow[0] + wrow[4]) shl 9;
     tmp1 := (wrow[0] - wrow[4]) shl 9;

     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse. i0..i3 are y7,y5,y3,y1 respectively.}

     z1 := wrow[7] + wrow[1];
     z2 := wrow[5] + wrow[3];
     z3 := wrow[7] + wrow[3];
     z4 := wrow[5] + wrow[1];
     z5 := ((z3 + z4) * FIX_1_175875602); { sqrt(2) * c3 }

     tmp0 := (wrow[7] * FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := (wrow[5] * FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := (wrow[3] * FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := (wrow[1] * FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }
     
     z1 := (z1 * FIX_Minus_0_899976223); { sqrt(2) * (c7-c3) }
     z2 := (z2 * FIX_Minus_2_562915447); { sqrt(2) * (-c1-c3) }
     z3 := (z3 * FIX_Minus_1_961570560); { sqrt(2) * (-c3-c5) }
     z4 := (z4 * FIX_Minus_0_390180644); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

     { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

     // 9+12 = 21 bits
     Temp := (tmp10 + tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     srow[0] := Temp;

     Temp := (tmp10 - tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     srow[7] := Temp;

     Temp := (tmp11 + tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     srow[1] := Temp;

     Temp := (tmp11 - tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     srow[6] := Temp;

     Temp := (tmp12 + tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     srow[2] := Temp;

     Temp := (tmp12 - tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     srow[5] := Temp;

     Temp := (tmp13 + tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     srow[3] := Temp;

     Temp := (tmp13 - tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     srow[4] := Temp;
    end;
   // Advance block pointers
   inc(PChar(srow), 8);
   inc(PChar(wrow), 8*4);
  end;
end;

initialization
 MainForm.RegisterFunction('InverseDCT_LC_Pas_1_a', @InverseDCT_LC_Pas_1_a);

end.
