unit IDCT_DKC_Unit;

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

// Descale and range limit to byte domain. We shift right over
// 12 bits: 9 bits to remove precision, and 3 bits to get rid of the additional
// factor 8 introducted by the IDCT transform.

function DescaleAndRangeLimit(A : Integer): Integer;{$IFDEF Ver170}inline;{$ENDIF}
                                                    {$IFDEF Ver180}inline;{$ENDIF}
                                                    {$IFDEF Ver185}inline;{$ENDIF}
begin
 Result := A div (1 shl 12) + 128;
 if Result < 0 then
  Result := 0
 else
  if Result > 255 then
   Result := 255;
end;

//function MultiplyRef(A, B : Integer) : Integer;
//begin
//  Result := (Int64(A) * Int64(B)) div (1 shl 9);
//end;

function Multiply(A, B : Integer) : Integer;{$IFDEF Ver170}inline;{$ENDIF}
                                            {$IFDEF Ver180}inline;{$ENDIF}
                                            {$IFDEF Ver185}inline;{$ENDIF}
begin
 Result := (A * B) div (1 shl 9);
end;

function Multiply2(A, B : Integer) : Integer;{$IFDEF Ver170}inline;{$ENDIF}
                                             {$IFDEF Ver180}inline;{$ENDIF}
                                             {$IFDEF Ver185}inline;{$ENDIF}
begin
 Result := (A * B);
 if Result > 0 then
  Result := Result shr 9
 else
  begin
   Result := -Result;
   Result := Result shr 9;
   Result := -Result;
  end;
end;

function Multiply3(A, B : Integer) : Integer; {$IFDEF Ver170}inline;{$ENDIF}
                                              {$IFDEF Ver180}inline;{$ENDIF}
                                              {$IFDEF Ver185}inline;{$ENDIF}
var
 SignBit, Sign : Integer;

begin
 Result := (A * B);
 SignBit := Result and (1 shl 31);
 Sign := SignBit shr 31;
 Result := Abs(Result);
 Result := Result shr 9;
 if Sign <> 0 then
  Result := -Result;
end;

//Based heavily on function by Nils Haeck

procedure InverseDCT_DKC_Pas_1_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
  i, QIdx: integer;
  dci: integer;
  dcs: byte;
  p0, p1, p2, p3, p4, p5, p6, p7: Psmallint;
  w0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
  s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
  z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
  tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp10, tmp11, tmp12,
tmp13: integer;
begin
  QIdx := 0;
  // First do the columns
  p0 := @Coef[ 0]; p1 := @Coef[ 8]; p2 := @Coef[16]; p3 := @Coef[24];
  p4 := @Coef[32]; p5 := @Coef[40]; p6 := @Coef[48]; p7 := @Coef[56];
  w0 := @Wrksp[ 0]; w1 := @Wrksp[ 8]; w2 := @Wrksp[16]; w3 := @Wrksp[24];
  w4 := @Wrksp[32]; w5 := @Wrksp[40]; w6 := @Wrksp[48]; w7 := @Wrksp[56];
  for i := 0 to 7 do
  begin
    if (p1^ = 0) and (p2^ = 0) and (p3^ = 0) and (p4^ = 0) and
       (p5^ = 0) and (p6^ = 0) and (p7^ = 0) then
    begin
      dci := p0^ * Quant[QIdx];
      w0^ := dci; w1^ := dci; w2^ := dci; w3^ := dci;
      w4^ := dci; w5^ := dci; w6^ := dci; w7^ := dci;
    end else
    begin
      { Even part: reverse the even part of the forward DCT. }
      { The rotator is sqrt(2)*c(-6). }

      z2 := p2^ * Quant[QIdx + 2 * 8];
      z3 := p6^ * Quant[QIdx + 6 * 8];

      z1 := Multiply(z2 + z3, FIX_0_541196100);
      tmp2 := z1 + Multiply(z3, - FIX_1_847759065);
      tmp3 := z1 + Multiply(z2, FIX_0_765366865);

      z2 := p0^ * Quant[QIdx + 0 * 8];
      z3 := p4^ * Quant[QIdx + 4 * 8];

      tmp0 := (z2 + z3);
      tmp1 := (z2 - z3);

      tmp10 := tmp0 + tmp3;
      tmp13 := tmp0 - tmp3;
      tmp11 := tmp1 + tmp2;
      tmp12 := tmp1 - tmp2;

      { Odd part per figure 8; the matrix is unitary and hence its
        transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

      tmp0 := p7^ * Quant[QIdx + 7 * 8];
      tmp1 := p5^ * Quant[QIdx + 5 * 8];
      tmp2 := p3^ * Quant[QIdx + 3 * 8];
      tmp3 := p1^ * Quant[QIdx + 1 * 8];

      z1 := tmp0 + tmp3;
      z2 := tmp1 + tmp2;
      z3 := tmp0 + tmp2;
      z4 := tmp1 + tmp3;
      z5 := Multiply(z3 + z4, FIX_1_175875602); { sqrt(2) * c3 }

      tmp0 := Multiply(tmp0, FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
      tmp1 := Multiply(tmp1, FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
      tmp2 := Multiply(tmp2, FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
      tmp3 := Multiply(tmp3, FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }
      z1 := Multiply(z1, - FIX_0_899976223); { sqrt(2) * (c7-c3) }
      z2 := Multiply(z2, - FIX_2_562915447); { sqrt(2) * (-c1-c3) }
      z3 := Multiply(z3, - FIX_1_961570560); { sqrt(2) * (-c3-c5) }
      z4 := Multiply(z4, - FIX_0_390180644); { sqrt(2) * (c5-c3) }

      Inc(z3, z5);
      Inc(z4, z5);

      Inc(tmp0, z1 + z3);
      Inc(tmp1, z2 + z4);
      Inc(tmp2, z2 + z3);
      Inc(tmp3, z1 + z4);

      { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

      w0^ := tmp10 + tmp3;
      w7^ := tmp10 - tmp3;
      w1^ := tmp11 + tmp2;
      w6^ := tmp11 - tmp2;
      w2^ := tmp12 + tmp1;
      w5^ := tmp12 - tmp1;
      w3^ := tmp13 + tmp0;
      w4^ := tmp13 - tmp0;

    end;
    // Advance block pointers
    inc(p0); inc(p1); inc(p2); inc(p3); inc(p4); inc(p5); inc(p6); inc(p7);
    inc(w0); inc(w1); inc(w2); inc(w3); inc(w4); inc(w5); inc(w6); inc(w7);
    inc(QIdx);
  end;

  // Next do the rows
  w0 := @Wrksp[0]; w1 := @Wrksp[1]; w2 := @Wrksp[2]; w3 := @Wrksp[3];
  w4 := @Wrksp[4]; w5 := @Wrksp[5]; w6 := @Wrksp[6]; w7 := @Wrksp[7];
  s0 := @Sample[0]; s1 := @Sample[1]; s2 := @Sample[2]; s3 := @Sample[3];
  s4 := @Sample[4]; s5 := @Sample[5]; s6 := @Sample[6]; s7 := @Sample[7];
  for i := 0 to 7 do
  begin
    if (w1^ = 0) and (w2^ = 0) and (w3^ = 0) and (w4^ = 0) and
       (w5^ = 0) and (w6^ = 0) and (w7^ = 0) then
    begin
      dcs := DescaleAndRangeLimit(w0^);
      s0^ := dcs; s1^ := dcs; s2^ := dcs; s3^ := dcs;
      s4^ := dcs; s5^ := dcs; s6^ := dcs; s7^ := dcs;
    end else
    begin
      { Even part: reverse the even part of the forward DCT. }
      { The rotator is sqrt(2)*c(-6). }

      z2 := w2^;
      z3 := w6^;

      z1 := Multiply(z2 + z3, FIX_0_541196100);
      tmp2 := z1 + Multiply(z3, - FIX_1_847759065);
      tmp3 := z1 + Multiply(z2, FIX_0_765366865);

      tmp0 := w0^ + w4^;
      tmp1 := w0^ - w4^;

      tmp10 := tmp0 + tmp3;
      tmp13 := tmp0 - tmp3;
      tmp11 := tmp1 + tmp2;
      tmp12 := tmp1 - tmp2;

      { Odd part per figure 8; the matrix is unitary and hence its
        transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

      tmp0 := w7^;
      tmp1 := w5^;
      tmp2 := w3^;
      tmp3 := w1^;

      z1 := tmp0 + tmp3;
      z2 := tmp1 + tmp2;
      z3 := tmp0 + tmp2;
      z4 := tmp1 + tmp3;
      z5 := Multiply(z3 + z4, FIX_1_175875602); { sqrt(2) * c3 }

      tmp0 := Multiply(tmp0, FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
      tmp1 := Multiply(tmp1, FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
      tmp2 := Multiply(tmp2, FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
      tmp3 := Multiply(tmp3, FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }
      z1 := Multiply(z1, - FIX_0_899976223); { sqrt(2) * (c7-c3) }
      z2 := Multiply(z2, - FIX_2_562915447); { sqrt(2) * (-c1-c3) }
      z3 := Multiply(z3, - FIX_1_961570560); { sqrt(2) * (-c3-c5) }
      z4 := Multiply(z4, - FIX_0_390180644); { sqrt(2) * (c5-c3) }

      Inc(z3, z5);
      Inc(z4, z5);

      Inc(tmp0, z1 + z3);
      Inc(tmp1, z2 + z4);
      Inc(tmp2, z2 + z3);
      Inc(tmp3, z1 + z4);

      { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

      s0^ := DescaleAndRangeLimit(tmp10 + tmp3);
      s7^ := DescaleAndRangeLimit(tmp10 - tmp3);
      s1^ := DescaleAndRangeLimit(tmp11 + tmp2);
      s6^ := DescaleAndRangeLimit(tmp11 - tmp2);
      s2^ := DescaleAndRangeLimit(tmp12 + tmp1);
      s5^ := DescaleAndRangeLimit(tmp12 - tmp1);
      s3^ := DescaleAndRangeLimit(tmp13 + tmp0);
      s4^ := DescaleAndRangeLimit(tmp13 - tmp0);

    end;
    // Advance block pointers
    inc(s0, 8); inc(s1, 8); inc(s2, 8); inc(s3, 8);
    inc(s4, 8); inc(s5, 8); inc(s6, 8); inc(s7, 8);
    inc(w0, 8); inc(w1, 8); inc(w2, 8); inc(w3, 8);
    inc(w4, 8); inc(w5, 8); inc(w6, 8); inc(w7, 8);
  end;
end;

//Based heavily on function by Nils Haeck

procedure InverseDCT_DKC_Pas_2_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
 i, QIdx: integer;
 dci: integer;
 dcs: byte;
 W0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
 z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp10, tmp11, tmp12, tmp13: integer;

begin
 QIdx := 0;
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
    begin
     dci := Coef[I] * Quant[QIdx];
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

     z2 := Coef[I+16] * Quant[QIdx + 16];
     z3 := Coef[I+48] * Quant[QIdx + 48];

     z1 := Multiply(z2 + z3, FIX_0_541196100);
     tmp2 := z1 + Multiply(z3, - FIX_1_847759065);
     tmp3 := z1 + Multiply(z2, FIX_0_765366865);

     z2 := Coef[I] * Quant[QIdx];
     z3 := Coef[I+32] * Quant[QIdx + 32];

     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);

     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := Coef[I+56] * Quant[QIdx+56];
     tmp1 := Coef[I+40] * Quant[QIdx+40];
     tmp2 := Coef[I+24] * Quant[QIdx+24];
     tmp3 := Coef[I+8] * Quant[QIdx+8];

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := Multiply(z3 + z4, FIX_1_175875602); { sqrt(2) * c3 }

     tmp0 := Multiply(tmp0, FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := Multiply(tmp1, FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := Multiply(tmp2, FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := Multiply(tmp3, FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }

     z1 := Multiply(z1, - FIX_0_899976223); { sqrt(2) * (c7-c3) }
     z2 := Multiply(z2, - FIX_2_562915447); { sqrt(2) * (-c1-c3) }
     z3 := Multiply(z3, - FIX_1_961570560); { sqrt(2) * (-c3-c5) }
     z4 := Multiply(z4, - FIX_0_390180644); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

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
   inc(QIdx);
  end;

 // Next do the rows
 w0 := @Wrksp[0];
 w1 := @Wrksp[1];
 w2 := @Wrksp[2];
 w3 := @Wrksp[3];
 w4 := @Wrksp[4];
 w5 := @Wrksp[5];
 w6 := @Wrksp[6];
 w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 for i := 0 to 7 do
  begin
//    if (w1^ = 0) and (w2^ = 0) and (w3^ = 0) and (w4^ = 0) and
//       (w5^ = 0) and (w6^ = 0) and (w7^ = 0) then
//    begin
//      dcs := DescaleAndRangeLimit(w0^);
//      s0^ := dcs; s1^ := dcs; s2^ := dcs; s3^ := dcs;
//      s4^ := dcs; s5^ := dcs; s6^ := dcs; s7^ := dcs;
//    end else
//    begin
   { Even part: reverse the even part of the forward DCT. }
   { The rotator is sqrt(2)*c(-6). }

   z2 := w2^;
   z3 := w6^;

   z1 := Multiply(z2 + z3, FIX_0_541196100);
   tmp2 := z1 + Multiply(z3, - FIX_1_847759065);
   tmp3 := z1 + Multiply(z2, FIX_0_765366865);

   tmp0 := w0^ + w4^;
   tmp1 := w0^ - w4^;

   tmp10 := tmp0 + tmp3;
   tmp13 := tmp0 - tmp3;
   tmp11 := tmp1 + tmp2;
   tmp12 := tmp1 - tmp2;

   { Odd part per figure 8; the matrix is unitary and hence its
     transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

   tmp0 := w7^;
   tmp1 := w5^;
   tmp2 := w3^;
   tmp3 := w1^;

   z1 := tmp0 + tmp3;
   z2 := tmp1 + tmp2;
   z3 := tmp0 + tmp2;
   z4 := tmp1 + tmp3;
   z5 := Multiply(z3 + z4, FIX_1_175875602); { sqrt(2) * c3 }

   tmp0 := Multiply(tmp0, FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
   tmp1 := Multiply(tmp1, FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
   tmp2 := Multiply(tmp2, FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
   tmp3 := Multiply(tmp3, FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }
   z1 := Multiply(z1, - FIX_0_899976223); { sqrt(2) * (c7-c3) }
   z2 := Multiply(z2, - FIX_2_562915447); { sqrt(2) * (-c1-c3) }
   z3 := Multiply(z3, - FIX_1_961570560); { sqrt(2) * (-c3-c5) }
   z4 := Multiply(z4, - FIX_0_390180644); { sqrt(2) * (c5-c3) }

   Inc(z3, z5);
   Inc(z4, z5);

   Inc(tmp0, z1 + z3);
   Inc(tmp1, z2 + z4);
   Inc(tmp2, z2 + z3);
   Inc(tmp3, z1 + z4);

   { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

   s0^ := DescaleAndRangeLimit(tmp10 + tmp3);
   s7^ := DescaleAndRangeLimit(tmp10 - tmp3);
   s1^ := DescaleAndRangeLimit(tmp11 + tmp2);
   s6^ := DescaleAndRangeLimit(tmp11 - tmp2);
   s2^ := DescaleAndRangeLimit(tmp12 + tmp1);
   s5^ := DescaleAndRangeLimit(tmp12 - tmp1);
   s3^ := DescaleAndRangeLimit(tmp13 + tmp0);
   s4^ := DescaleAndRangeLimit(tmp13 - tmp0);

   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
   inc(w0, 8);
   inc(w1, 8);
   inc(w2, 8);
   inc(w3, 8);
   inc(w4, 8);
   inc(w5, 8);
   inc(w6, 8);
   inc(w7, 8);
  end;
end;

//Based heavily on function by Nils Haeck

procedure InverseDCT_DKC_Pas_3_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
 i, QIdx: integer;
 dci: integer;
 dcs: byte;
 W0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
 z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp10, tmp11, tmp12, tmp13: Integer;

begin
 QIdx := 0;
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
    begin
     dci := Coef[I] * Quant[QIdx];
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

     z2 := Coef[I+16] * Quant[QIdx + 16];
     z3 := Coef[I+48] * Quant[QIdx + 48];

     //z1 := Multiply(z2 + z3, FIX_0_541196100);
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);

     //tmp2 := z1 + Multiply(z3, - FIX_1_847759065);
     tmp2 := z1 + (z3 * - FIX_1_847759065) div (1 shl 9);
     //tmp3 := z1 + Multiply(z2, FIX_0_765366865);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[QIdx];
     z3 := Coef[I+32] * Quant[QIdx + 32];

     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);

     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := Coef[I+56] * Quant[QIdx+56];
     tmp1 := Coef[I+40] * Quant[QIdx+40];
     tmp2 := Coef[I+24] * Quant[QIdx+24];
     tmp3 := Coef[I+8] * Quant[QIdx+8];

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     //z5 := Multiply(z3 + z4, FIX_1_175875602); { sqrt(2) * c3 }
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

     //tmp0 := Multiply(tmp0, FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
     //tmp1 := Multiply(tmp1, FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
     //tmp2 := Multiply(tmp2, FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
     //tmp3 := Multiply(tmp3, FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

     //z1 := Multiply(z1, - FIX_0_899976223); { sqrt(2) * (c7-c3) }
     z1 := (z1 * -FIX_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     //z2 := Multiply(z2, -FIX_2_562915447); { sqrt(2) * (-c1-c3) }
     z2 := (z2 * -FIX_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     //z3 := Multiply(z3, - FIX_1_961570560); { sqrt(2) * (-c3-c5) }
     z3 := (z3 * -FIX_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     //z4 := Multiply(z4, - FIX_0_390180644); { sqrt(2) * (c5-c3) }
     z4 := (z4 * -FIX_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

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
   inc(QIdx);
  end;

 // Next do the rows
 w0 := @Wrksp[0];
 w1 := @Wrksp[1];
 w2 := @Wrksp[2];
 w3 := @Wrksp[3];
 w4 := @Wrksp[4];
 w5 := @Wrksp[5];
 w6 := @Wrksp[6];
 w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 for i := 0 to 7 do
  begin
   { Even part: reverse the even part of the forward DCT. }
   { The rotator is sqrt(2)*c(-6). }

   z2 := w2^;
   z3 := w6^;

   //z1 := Multiply(z2 + z3, FIX_0_541196100);
   z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
   //tmp2 := z1 + Multiply(z3, - FIX_1_847759065);
   tmp2 := z1 + (z3 * -FIX_1_847759065) div (1 shl 9);
   //tmp3 := z1 + Multiply(z2, FIX_0_765366865);
   tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);

   tmp0 := w0^ + w4^;
   tmp1 := w0^ - w4^;

   tmp10 := tmp0 + tmp3;
   tmp13 := tmp0 - tmp3;
   tmp11 := tmp1 + tmp2;
   tmp12 := tmp1 - tmp2;

   { Odd part per figure 8; the matrix is unitary and hence its
     transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

   tmp0 := w7^;
   tmp1 := w5^;
   tmp2 := w3^;
   tmp3 := w1^;

   z1 := tmp0 + tmp3;
   z2 := tmp1 + tmp2;
   z3 := tmp0 + tmp2;
   z4 := tmp1 + tmp3;
   //z5 := Multiply(z3 + z4, FIX_1_175875602); { sqrt(2) * c3 }
   z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

   //tmp0 := Multiply(tmp0, FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
   tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
   //tmp1 := Multiply(tmp1, FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
   tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
   //tmp2 := Multiply(tmp2, FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
   tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
   //tmp3 := Multiply(tmp3, FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }
   tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

   //z1 := Multiply(z1, - FIX_0_899976223); { sqrt(2) * (c7-c3) }
   z1 := (z1 * -FIX_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
   //z2 := Multiply(z2, - FIX_2_562915447); { sqrt(2) * (-c1-c3) }
   z2 := (z2 * -FIX_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
   //z3 := Multiply(z3, - FIX_1_961570560); { sqrt(2) * (-c3-c5) }
   z3 := (z3 * -FIX_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
   //z4 := Multiply(z4, - FIX_0_390180644); { sqrt(2) * (c5-c3) }
   z4 := (z4 * -FIX_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

   Inc(z3, z5);
   Inc(z4, z5);

   Inc(tmp0, z1 + z3);
   Inc(tmp1, z2 + z4);
   Inc(tmp2, z2 + z3);
   Inc(tmp3, z1 + z4);

   { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

   s0^ := DescaleAndRangeLimit(tmp10 + tmp3);
   s7^ := DescaleAndRangeLimit(tmp10 - tmp3);
   s1^ := DescaleAndRangeLimit(tmp11 + tmp2);
   s6^ := DescaleAndRangeLimit(tmp11 - tmp2);
   s2^ := DescaleAndRangeLimit(tmp12 + tmp1);
   s5^ := DescaleAndRangeLimit(tmp12 - tmp1);
   s3^ := DescaleAndRangeLimit(tmp13 + tmp0);
   s4^ := DescaleAndRangeLimit(tmp13 - tmp0);

   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
   inc(w0, 8);
   inc(w1, 8);
   inc(w2, 8);
   inc(w3, 8);
   inc(w4, 8);
   inc(w5, 8);
   inc(w6, 8);
   inc(w7, 8);
  end;
end;

//Based heavily on function by Nils Haeck

procedure InverseDCT_DKC_Pas_4_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
 i, QIdx: integer;
 dci: integer;
 dcs: byte;
 W0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
 z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp10, tmp11, tmp12, tmp13, Temp: Integer;

begin
 QIdx := 0;
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
    begin
     dci := Coef[I] * Quant[QIdx];
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

     z2 := Coef[I+16] * Quant[QIdx + 16];
     z3 := Coef[I+48] * Quant[QIdx + 48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     tmp2 := z1 + (z3 * - FIX_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[QIdx];
     z3 := Coef[I+32] * Quant[QIdx + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := Coef[I+56] * Quant[QIdx+56];
     tmp1 := Coef[I+40] * Quant[QIdx+40];
     tmp2 := Coef[I+24] * Quant[QIdx+24];
     tmp3 := Coef[I+8] * Quant[QIdx+8];

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

     z1 := (z1 * -FIX_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     z2 := (z2 * -FIX_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     z3 := (z3 * -FIX_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     z4 := (z4 * -FIX_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

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
   inc(QIdx);
  end;

 // Next do the rows
 w0 := @Wrksp[0];
 w1 := @Wrksp[1];
 w2 := @Wrksp[2];
 w3 := @Wrksp[3];
 w4 := @Wrksp[4];
 w5 := @Wrksp[5];
 w6 := @Wrksp[6];
 w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 for i := 0 to 7 do
  begin
   { Even part: reverse the even part of the forward DCT. }
   { The rotator is sqrt(2)*c(-6). }

   z2 := w2^;
   z3 := w6^;

   z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
   tmp2 := z1 + (z3 * -FIX_1_847759065) div (1 shl 9);
   tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);

   tmp0 := w0^ + w4^;
   tmp1 := w0^ - w4^;

   tmp10 := tmp0 + tmp3;
   tmp13 := tmp0 - tmp3;
   tmp11 := tmp1 + tmp2;
   tmp12 := tmp1 - tmp2;

   { Odd part per figure 8; the matrix is unitary and hence its
     transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

   tmp0 := w7^;
   tmp1 := w5^;
   tmp2 := w3^;
   tmp3 := w1^;

   z1 := tmp0 + tmp3;
   z2 := tmp1 + tmp2;
   z3 := tmp0 + tmp2;
   z4 := tmp1 + tmp3;
   z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

   tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
   tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
   tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
   tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

   z1 := (z1 * -FIX_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
   z2 := (z2 * -FIX_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
   z3 := (z3 * -FIX_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
   z4 := (z4 * -FIX_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

   Inc(z3, z5);
   Inc(z4, z5);

   Inc(tmp0, z1 + z3);
   Inc(tmp1, z2 + z4);
   Inc(tmp2, z2 + z3);
   Inc(tmp3, z1 + z4);

   { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

   //s0^ := DescaleAndRangeLimit(tmp10 + tmp3);
   Temp := (tmp10 + tmp3) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s0^ := Temp;
   //s7^ := DescaleAndRangeLimit(tmp10 - tmp3);
   Temp := (tmp10 - tmp3) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s7^ := Temp;
   //s1^ := DescaleAndRangeLimit(tmp11 + tmp2);
   Temp := (tmp11 + tmp2) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s1^ := Temp;
   //s6^ := DescaleAndRangeLimit(tmp11 - tmp2);
   Temp := (tmp11 - tmp2) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s6^ := Temp;
   //s2^ := DescaleAndRangeLimit(tmp12 + tmp1);
   Temp := (tmp12 + tmp1) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s2^ := Temp;
   //s5^ := DescaleAndRangeLimit(tmp12 - tmp1);
   Temp := (tmp12 - tmp1) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s5^ := Temp;
   //s3^ := DescaleAndRangeLimit(tmp13 + tmp0);
   Temp := (tmp13 + tmp0) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s3^ := Temp;
   //s4^ := DescaleAndRangeLimit(tmp13 - tmp0);
   Temp := (tmp13 - tmp0) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s4^ := Temp;

   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
   inc(w0, 8);
   inc(w1, 8);
   inc(w2, 8);
   inc(w3, 8);
   inc(w4, 8);
   inc(w5, 8);
   inc(w6, 8);
   inc(w7, 8);
  end;
end;

//Based heavily on function by Nils Haeck

procedure InverseDCT_DKC_Pas_5_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
 i, QIdx: integer;
 dci: integer;
 dcs: byte;
 W0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
 z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp10, tmp11, tmp12, tmp13, Temp: Integer;

begin
 QIdx := 0;
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
    begin
     dci := Coef[I] * Quant[QIdx];
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

     z2 := Coef[I+16] * Quant[QIdx + 16];
     z3 := Coef[I+48] * Quant[QIdx + 48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     //tmp2 := z1 + (z3 * - FIX_1_847759065) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[QIdx];
     z3 := Coef[I+32] * Quant[QIdx + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := Coef[I+56] * Quant[QIdx+56];
     tmp1 := Coef[I+40] * Quant[QIdx+40];
     tmp2 := Coef[I+24] * Quant[QIdx+24];
     tmp3 := Coef[I+8] * Quant[QIdx+8];

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

     //z1 := (z1 * -FIX_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     //z2 := (z2 * -FIX_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     //z3 := (z3 * -FIX_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     //z4 := (z4 * -FIX_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

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
   inc(QIdx);
  end;

 // Next do the rows
 w0 := @Wrksp[0];
 w1 := @Wrksp[1];
 w2 := @Wrksp[2];
 w3 := @Wrksp[3];
 w4 := @Wrksp[4];
 w5 := @Wrksp[5];
 w6 := @Wrksp[6];
 w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 for i := 0 to 7 do
  begin
   { Even part: reverse the even part of the forward DCT. }
   { The rotator is sqrt(2)*c(-6). }

   z2 := w2^;
   z3 := w6^;

   z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
   //tmp2 := z1 + (z3 * -FIX_1_847759065) div (1 shl 9);
   tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
   tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);

   tmp0 := w0^ + w4^;
   tmp1 := w0^ - w4^;

   tmp10 := tmp0 + tmp3;
   tmp13 := tmp0 - tmp3;
   tmp11 := tmp1 + tmp2;
   tmp12 := tmp1 - tmp2;

   { Odd part per figure 8; the matrix is unitary and hence its
     transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

   tmp0 := w7^;
   tmp1 := w5^;
   tmp2 := w3^;
   tmp3 := w1^;

   z1 := tmp0 + tmp3;
   z2 := tmp1 + tmp2;
   z3 := tmp0 + tmp2;
   z4 := tmp1 + tmp3;
   z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

   tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
   tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
   tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
   tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

   //z1 := (z1 * -FIX_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
   z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
   //z2 := (z2 * -FIX_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
   z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
   //z3 := (z3 * -FIX_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
   z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
   //z4 := (z4 * -FIX_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }
   z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

   Inc(z3, z5);
   Inc(z4, z5);

   Inc(tmp0, z1 + z3);
   Inc(tmp1, z2 + z4);
   Inc(tmp2, z2 + z3);
   Inc(tmp3, z1 + z4);

   { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

   //s0^ := DescaleAndRangeLimit(tmp10 + tmp3);
   Temp := (tmp10 + tmp3) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s0^ := Temp;
   //s7^ := DescaleAndRangeLimit(tmp10 - tmp3);
   Temp := (tmp10 - tmp3) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s7^ := Temp;
   //s1^ := DescaleAndRangeLimit(tmp11 + tmp2);
   Temp := (tmp11 + tmp2) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s1^ := Temp;
   //s6^ := DescaleAndRangeLimit(tmp11 - tmp2);
   Temp := (tmp11 - tmp2) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s6^ := Temp;
   //s2^ := DescaleAndRangeLimit(tmp12 + tmp1);
   Temp := (tmp12 + tmp1) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s2^ := Temp;
   //s5^ := DescaleAndRangeLimit(tmp12 - tmp1);
   Temp := (tmp12 - tmp1) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s5^ := Temp;
   //s3^ := DescaleAndRangeLimit(tmp13 + tmp0);
   Temp := (tmp13 + tmp0) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s3^ := Temp;
   //s4^ := DescaleAndRangeLimit(tmp13 - tmp0);
   Temp := (tmp13 - tmp0) div (1 shl 12) + 128;
   if Temp < 0 then
    Temp := 0
   else
    if Temp > 255 then
     Temp := 255;
   s4^ := Temp;

   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
   inc(w0, 8);
   inc(w1, 8);
   inc(w2, 8);
   inc(w3, 8);
   inc(w4, 8);
   inc(w5, 8);
   inc(w6, 8);
   inc(w7, 8);
  end;
end;

//Based heavily on function by Nils Haeck

procedure InverseDCT_DKC_Pas_6_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
 i, QIdx: integer;
 dci: integer;
 dcs: Byte;
 W0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
 z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp10, tmp11, tmp12, tmp13, Temp: Integer;

begin
 QIdx := 0;
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
    begin
     dci := Coef[I] * Quant[QIdx];
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

     z2 := Coef[I+16] * Quant[QIdx + 16];
     z3 := Coef[I+48] * Quant[QIdx + 48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     //tmp2 := z1 + (z3 * - FIX_1_847759065) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[QIdx];
     z3 := Coef[I+32] * Quant[QIdx + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := Coef[I+56] * Quant[QIdx+56];
     tmp1 := Coef[I+40] * Quant[QIdx+40];
     tmp2 := Coef[I+24] * Quant[QIdx+24];
     tmp3 := Coef[I+8] * Quant[QIdx+8];

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

     //z1 := (z1 * -FIX_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     //z2 := (z2 * -FIX_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     //z3 := (z3 * -FIX_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     //z4 := (z4 * -FIX_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

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
   inc(QIdx);
  end;

 // Next do the rows
 w0 := @Wrksp[0];
 w1 := @Wrksp[1];
 w2 := @Wrksp[2];
 w3 := @Wrksp[3];
 w4 := @Wrksp[4];
 w5 := @Wrksp[5];
 w6 := @Wrksp[6];
 w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 for i := 0 to 7 do
  begin
   if (w1^ = 0) and (w2^ = 0) and (w3^ = 0) and (w4^ = 0) and
      (w5^ = 0) and (w6^ = 0) and (w7^ = 0) then
    begin
     //dcs := DeScaleRangeLimit(w0^);
     Temp := w0^ div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     s0^ := dcs;
     s1^ := dcs;
     s2^ := dcs;
     s3^ := dcs;
     s4^ := dcs;
     s5^ := dcs;
     s6^ := dcs;
     s7^ := dcs;
    end
   else
    begin
     { Even part: reverse the even part of the forward DCT. }
     { The rotator is sqrt(2)*c(-6). }

     z2 := w2^;
     z3 := w6^;

     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     //tmp2 := z1 + (z3 * -FIX_1_847759065) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);

     tmp0 := w0^ + w4^;
     tmp1 := w0^ - w4^;

     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := w7^;
     tmp1 := w5^;
     tmp2 := w3^;
     tmp3 := w1^;

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

     //z1 := (z1 * -FIX_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     //z2 := (z2 * -FIX_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     //z3 := (z3 * -FIX_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     //z4 := (z4 * -FIX_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

     { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

     //s0^ := DescaleAndRangeLimit(tmp10 + tmp3);
     Temp := (tmp10 + tmp3) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s0^ := Temp;
     //s7^ := DescaleAndRangeLimit(tmp10 - tmp3);
     Temp := (tmp10 - tmp3) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s7^ := Temp;
     //s1^ := DescaleAndRangeLimit(tmp11 + tmp2);
     Temp := (tmp11 + tmp2) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s1^ := Temp;
     //s6^ := DescaleAndRangeLimit(tmp11 - tmp2);
     Temp := (tmp11 - tmp2) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s6^ := Temp;
     //s2^ := DescaleAndRangeLimit(tmp12 + tmp1);
     Temp := (tmp12 + tmp1) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s2^ := Temp;
     //s5^ := DescaleAndRangeLimit(tmp12 - tmp1);
     Temp := (tmp12 - tmp1) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s5^ := Temp;
     //s3^ := DescaleAndRangeLimit(tmp13 + tmp0);
     Temp := (tmp13 + tmp0) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s3^ := Temp;
     //s4^ := DescaleAndRangeLimit(tmp13 - tmp0);
     Temp := (tmp13 - tmp0) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s4^ := Temp;
    end;
   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
   inc(w0, 8);
   inc(w1, 8);
   inc(w2, 8);
   inc(w3, 8);
   inc(w4, 8);
   inc(w5, 8);
   inc(w6, 8);
   inc(w7, 8);
  end;
end;

//Based heavily on function by Nils Haeck - stealing ideas from InverseDCT_LC_Pas_1_a

procedure InverseDCT_DKC_Pas_7_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
 I : integer;
 dci: integer;
 dcs: Byte;
 W0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
 z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp10, tmp11, tmp12, tmp13, Temp: Integer;

begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
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

     z2 := Coef[I+16] * Quant[I + 16];
     z3 := Coef[I+48] * Quant[I + 48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

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
 w0 := @Wrksp[0];
 w1 := @Wrksp[1];
 w2 := @Wrksp[2];
 w3 := @Wrksp[3];
 w4 := @Wrksp[4];
 w5 := @Wrksp[5];
 w6 := @Wrksp[6];
 w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 for i := 0 to 7 do
  begin
   if (w1^ = 0) and (w2^ = 0) and (w3^ = 0) and (w4^ = 0) and
      (w5^ = 0) and (w6^ = 0) and (w7^ = 0) then
    begin
     Temp := w0^ div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     s0^ := dcs;
     s1^ := dcs;
     s2^ := dcs;
     s3^ := dcs;
     s4^ := dcs;
     s5^ := dcs;
     s6^ := dcs;
     s7^ := dcs;
    end
   else
    begin
     { Even part: reverse the even part of the forward DCT. }
     { The rotator is sqrt(2)*c(-6). }

     z2 := w2^;
     z3 := w6^;

     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);

     tmp0 := w0^ + w4^;
     tmp1 := w0^ - w4^;

     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := w7^;
     tmp1 := w5^;
     tmp2 := w3^;
     tmp3 := w1^;

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }

     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

     { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

     Temp := (tmp10 + tmp3) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s0^ := Temp;
     Temp := (tmp10 - tmp3) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s7^ := Temp;
     Temp := (tmp11 + tmp2) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s1^ := Temp;
     Temp := (tmp11 - tmp2) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s6^ := Temp;
     Temp := (tmp12 + tmp1) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s2^ := Temp;
     Temp := (tmp12 - tmp1) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s5^ := Temp;
     Temp := (tmp13 + tmp0) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s3^ := Temp;
     Temp := (tmp13 - tmp0) div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s4^ := Temp;
    end;
   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
   inc(w0, 8);
   inc(w1, 8);
   inc(w2, 8);
   inc(w3, 8);
   inc(w4, 8);
   inc(w5, 8);
   inc(w6, 8);
   inc(w7, 8);
  end;
end;

procedure InverseDCT_DKC_Pas_8_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
 I : integer;
 dci: integer;
 dcs: Byte;
 W0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
 z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp10, tmp11, tmp12, tmp13, Temp: Integer;
  tmp2_a: Integer;
  tmp3_a: Integer;
  tmp2_b: Integer;
  tmp3_b: Integer;

begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
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

     z2 := Coef[I+16] * Quant[I + 16];
     z3 := Coef[I+48] * Quant[I + 48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }

     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

     Inc(z3, z5);
     Inc(z4, z5);

     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
     Inc(tmp0, z1 + z3);
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
     Inc(tmp1, z2 + z4);
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
     Inc(tmp2, z2 + z3);
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }
     Inc(tmp3, z1 + z4);

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
 w0 := @Wrksp[0];
 w1 := @Wrksp[1];
 w2 := @Wrksp[2];
 w3 := @Wrksp[3];
 w4 := @Wrksp[4];
 w5 := @Wrksp[5];
 w6 := @Wrksp[6];
 w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 for i := 0 to 7 do
  begin
   if (w1^ = 0) and (w2^ = 0) and (w3^ = 0) and (w4^ = 0) and
      (w5^ = 0) and (w6^ = 0) and (w7^ = 0) then
    begin
     Temp := w0^ div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     s0^ := dcs;
     s1^ := dcs;
     s2^ := dcs;
     s3^ := dcs;
     s4^ := dcs;
     s5^ := dcs;
     s6^ := dcs;
     s7^ := dcs;
    end
   else
    begin
     { Even part: reverse the even part of the forward DCT. }
     { The rotator is sqrt(2)*c(-6). }

     z2 := w2^;
     z3 := w6^;

//     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
//     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
//     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);

     //Pospone descale
     z1 := ((z2 + z3) * FIX_0_541196100);
     tmp2 := (z1 + z3 * FIX_Minus_1_847759065);
     tmp3 := (z1 + z2 * FIX_0_765366865);


//     tmp0 := w0^ + w4^;
//     tmp1 := w0^ - w4^;

     //Scale up to compensate for later descale
     tmp0 := (w0^ + w4^) shl 9;
     tmp1 := (w0^ - w4^) shl 9;



     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;

     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }

     tmp0 := w7^;
     tmp1 := w5^;
     tmp2 := w3^;
     tmp3 := w1^;

     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     //Pospone descale
//     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }
//
//     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
//     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
//     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
//     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }
//
//     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
//     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
//     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
//     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }

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

     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);

     { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

     //all in one descale
     //Temp := (tmp10 + tmp3) div (1 shl 12) + 128;
     Temp := (tmp10 + tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s0^ := Temp;
     //Temp := (tmp10 - tmp3) div (1 shl 12) + 128;
     Temp := (tmp10 - tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s7^ := Temp;
     //Temp := (tmp11 + tmp2) div (1 shl 12) + 128;
     Temp := (tmp11 + tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s1^ := Temp;
     //Temp := (tmp11 - tmp2) div (1 shl 12) + 128;
     Temp := (tmp11 - tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s6^ := Temp;
     //Temp := (tmp12 + tmp1) div (1 shl 12) + 128;
     Temp := (tmp12 + tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s2^ := Temp;
     //Temp := (tmp12 - tmp1) div (1 shl 12) + 128;
     Temp := (tmp12 - tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s5^ := Temp;
     //Temp := (tmp13 + tmp0) div (1 shl 12) + 128;
     Temp := (tmp13 + tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s3^ := Temp;
     //Temp := (tmp13 - tmp0) div (1 shl 12) + 128;
     Temp := (tmp13 - tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s4^ := Temp;
    end;
   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
   inc(w0, 8);
   inc(w1, 8);
   inc(w2, 8);
   inc(w3, 8);
   inc(w4, 8);
   inc(w5, 8);
   inc(w6, 8);
   inc(w7, 8);
  end;
end;

procedure InverseDCT_DKC_Pas_9_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
var
 I : integer;
 dci: integer;
 dcs: Byte;
 W0, w1, w2, w3, w4, w5, w6, w7: Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7: Pbyte;
 z1, z2, z3, z4, z5, z10, z11, z12, z13: integer;
 tmp0, tmp1, tmp2, tmp3, tmp7, tmp10, tmp11, tmp12, tmp13, Temp: Integer;

begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
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
     z2 := Coef[I+16] * Quant[I + 16];
     z3 := Coef[I+48] * Quant[I + 48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }
     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9); { sqrt(2) * c3 }
     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9); { sqrt(2) * (c7-c3) }
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9); { sqrt(2) * (-c1-c3) }
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9); { sqrt(2) * (-c3-c5) }
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9); { sqrt(2) * (c5-c3) }
     Inc(z3, z5);
     Inc(z4, z5);
//     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
//     Inc(tmp0, z1 + z3);
//     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
//     Inc(tmp1, z2 + z4);
//     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
//     Inc(tmp2, z2 + z3);
//     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }
//     Inc(tmp3, z1 + z4);
//     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9); { sqrt(2) * (-c1+c3+c5-c7) }
//     tmp0 := tmp0 + z1 + z3;
//     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9); { sqrt(2) * ( c1+c3-c5+c7) }
//     tmp1 := tmp1 + z2 + z4;
//     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9); { sqrt(2) * ( c1+c3+c5-c7) }
//     tmp2 := tmp2 + z2 + z3;
//     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9); { sqrt(2) * ( c1+c3-c5-c7) }
//     tmp3 := tmp3 + z1 + z4;
     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9) + z1 + z3;
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9) + z2 + z4;
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9) + z2 + z3;
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9) + z1 + z4;

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
 w0 := @Wrksp[0];
 w1 := @Wrksp[1];
 w2 := @Wrksp[2];
 w3 := @Wrksp[3];
 w4 := @Wrksp[4];
 w5 := @Wrksp[5];
 w6 := @Wrksp[6];
 w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 for i := 0 to 7 do
  begin
   if (w1^ = 0) and (w2^ = 0) and (w3^ = 0) and (w4^ = 0) and
      (w5^ = 0) and (w6^ = 0) and (w7^ = 0) then
    begin
     Temp := w0^ div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     s0^ := dcs;
     s1^ := dcs;
     s2^ := dcs;
     s3^ := dcs;
     s4^ := dcs;
     s5^ := dcs;
     s6^ := dcs;
     s7^ := dcs;
    end
   else
    begin
     { Even part: reverse the even part of the forward DCT. }
     { The rotator is sqrt(2)*c(-6). }
     z2 := w2^;
     z3 := w6^;
     //Pospone descale
     z1 := ((z2 + z3) * FIX_0_541196100);
     tmp2 := (z1 + z3 * FIX_Minus_1_847759065);
     tmp3 := (z1 + z2 * FIX_0_765366865);
     //Scale up to compensate for later descale
     tmp0 := (w0^ + w4^) shl 9;
     tmp1 := (w0^ - w4^) shl 9;
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     { Odd part per figure 8; the matrix is unitary and hence its
       transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively. }
     tmp0 := w7^;
     tmp1 := w5^;
     tmp2 := w3^;
     tmp3 := w1^;
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     //Pospone descale
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
     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);
     { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }
     //all in one descale
     Temp := (tmp10 + tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s0^ := Temp;
     Temp := (tmp10 - tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s7^ := Temp;
     Temp := (tmp11 + tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s1^ := Temp;
     Temp := (tmp11 - tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s6^ := Temp;
     Temp := (tmp12 + tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s2^ := Temp;
     Temp := (tmp12 - tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s5^ := Temp;
     Temp := (tmp13 + tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s3^ := Temp;
     Temp := (tmp13 - tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s4^ := Temp;
    end;
   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
   inc(w0, 8);
   inc(w1, 8);
   inc(w2, 8);
   inc(w3, 8);
   inc(w4, 8);
   inc(w5, 8);
   inc(w6, 8);
   inc(w7, 8);
  end;
end;

procedure InverseDCT_DKC_Pas_10_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var Wrksp: TsdIntArray64);
var
 I : integer;
 dci: integer;
 dcs: Byte;
// W0, w1, w2, w3, w4, w5, w6, w7 : Pinteger;
 s0, s1, s2, s3, s4, s5, s6, s7 : Pbyte;
 z1, z2, z3, z4, z5 : integer;
 tmp0, tmp1, tmp2, tmp3, tmp10, tmp11, tmp12, tmp13, Temp: Integer;
 pWorkRow : ^TsdIntArray64;
 //pSampleRow : ^TsdSampleBlock;

begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
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
     //Even part: reverse the even part of the forward DCT.
     z2 := Coef[I+16] * Quant[I+16];
     z3 := Coef[I+48] * Quant[I+48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9);
     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9);
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9);
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9);
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9);
     Inc(z3, z5);
     Inc(z4, z5);
     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9) + z1 + z3;
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9) + z2 + z4;
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9) + z2 + z3;
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9) + z1 + z4;
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
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
// w0 := @Wrksp[0];
// w1 := @Wrksp[1];
// w2 := @Wrksp[2];
// w3 := @Wrksp[3];
// w4 := @Wrksp[4];
// w5 := @Wrksp[5];
// w6 := @Wrksp[6];
// w7 := @Wrksp[7];
 s0 := @Sample[0];
 s1 := @Sample[1];
 s2 := @Sample[2];
 s3 := @Sample[3];
 s4 := @Sample[4];
 s5 := @Sample[5];
 s6 := @Sample[6];
 s7 := @Sample[7];
 pWorkRow := @Wrksp[0];
 //pSampleRow := @Sample[0];
 for i := 0 to 7 do
  begin
   if (pWorkRow[1] = 0) and (pWorkRow[2] = 0) and (pWorkRow[3] = 0) and (pWorkRow[4] = 0) and
      (pWorkRow[5] = 0) and (pWorkRow[6] = 0) and (pWorkRow[7] = 0) then
    begin
     Temp := pWorkRow[0] div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     s0^ := dcs;
     s1^ := dcs;
     s2^ := dcs;
     s3^ := dcs;
     s4^ := dcs;
     s5^ := dcs;
     s6^ := dcs;
     s7^ := dcs;
    end
   else
    begin
     //Even part: reverse the even part of the forward DCT.
     z2 := pWorkRow[2];
     z3 := pWorkRow[6];
     //Pospone descale
     z1 := ((z2 + z3) * FIX_0_541196100);
     tmp2 := (z1 + z3 * FIX_Minus_1_847759065);
     tmp3 := (z1 + z2 * FIX_0_765366865);
     //Scale up to compensate for later descale
     tmp0 := (pWorkRow[0] + pWorkRow[4]) shl 9;
     tmp1 := (pWorkRow[0] - pWorkRow[4]) shl 9;
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     tmp0 := pWorkRow[7];
     tmp1 := pWorkRow[5];
     tmp2 := pWorkRow[3];
     tmp3 := pWorkRow[1];
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     //Pospone descale
     z5 := ((z3 + z4) * FIX_1_175875602);
     tmp0 := (tmp0 * FIX_0_298631336);
     tmp1 := (tmp1 * FIX_2_053119869);
     tmp2 := (tmp2 * FIX_3_072711026);
     tmp3 := (tmp3 * FIX_1_501321110);
     z1 := (z1 * FIX_Minus_0_899976223);
     z2 := (z2 * FIX_Minus_2_562915447);
     z3 := (z3 * FIX_Minus_1_961570560);
     z4 := (z4 * FIX_Minus_0_390180644);
     //Inc(z3, z5);
     z3 := z3 + z5;
     //Inc(z4, z5);
     z4 := z4 + z5;
     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);
     { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }
     //all in one descale
     Temp := (tmp10 + tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s0^ := Temp;
     Temp := (tmp10 - tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s7^ := Temp;
     Temp := (tmp11 + tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s1^ := Temp;
     Temp := (tmp11 - tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s6^ := Temp;
     Temp := (tmp12 + tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s2^ := Temp;
     Temp := (tmp12 - tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s5^ := Temp;
     Temp := (tmp13 + tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s3^ := Temp;
     Temp := (tmp13 - tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     s4^ := Temp;
    end;
   // Advance block pointers
   inc(s0, 8);
   inc(s1, 8);
   inc(s2, 8);
   inc(s3, 8);
   inc(s4, 8);
   inc(s5, 8);
   inc(s6, 8);
   inc(s7, 8);
//   inc(w0, 8);
//   inc(w1, 8);
//   inc(w2, 8);
//   inc(w3, 8);
//   inc(w4, 8);
//   inc(w5, 8);
//   inc(w6, 8);
//   inc(w7, 8);
   //Increment row pointers
   Inc(PChar(pWorkRow), 32);
   //Inc(PChar(pSampleRow), 8);
  end;
end;

procedure InverseDCT_DKC_Pas_11_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var Wrksp: TsdIntArray64);
var
 I : integer;
 dci: integer;
 dcs: Byte;
 z1, z2, z3, z4, z5 : integer;
 tmp0, tmp1, tmp2, tmp3, tmp10, tmp11, tmp12, tmp13, Temp: Integer;
 pWorkRow : ^TsdIntArray64;
 pSampleRow : ^TsdSampleBlock;

begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
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
     //Even part: reverse the even part of the forward DCT.
     z2 := Coef[I+16] * Quant[I+16];
     z3 := Coef[I+48] * Quant[I+48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9);
     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9);
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9);
     z3 := (z3 * FIX_Minus_1_961570560) div (1 shl 9);
     z4 := (z4 * FIX_Minus_0_390180644) div (1 shl 9);
     Inc(z3, z5);
     Inc(z4, z5);
     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9) + z1 + z3;
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9) + z2 + z4;
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9) + z2 + z3;
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9) + z1 + z4;
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
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
 pWorkRow := @Wrksp[0];
 pSampleRow := @Sample[0];
 for i := 0 to 7 do
  begin
   if (pWorkRow[1] = 0) and (pWorkRow[2] = 0) and (pWorkRow[3] = 0) and (pWorkRow[4] = 0) and
      (pWorkRow[5] = 0) and (pWorkRow[6] = 0) and (pWorkRow[7] = 0) then
    begin
     Temp := pWorkRow[0] div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     pSampleRow[0] := dcs;
     pSampleRow[1] := dcs;
     pSampleRow[2] := dcs;
     pSampleRow[3] := dcs;
     pSampleRow[4] := dcs;
     pSampleRow[5] := dcs;
     pSampleRow[6] := dcs;
     pSampleRow[7] := dcs;
    end
   else
    begin
     //Even part: reverse the even part of the forward DCT.
     z2 := pWorkRow[2];
     z3 := pWorkRow[6];
     //Pospone descale
     z1 := ((z2 + z3) * FIX_0_541196100);
     tmp2 := (z1 + z3 * FIX_Minus_1_847759065);
     tmp3 := (z1 + z2 * FIX_0_765366865);
     //Scale up to compensate for later descale
     tmp0 := (pWorkRow[0] + pWorkRow[4]) shl 9;
     tmp1 := (pWorkRow[0] - pWorkRow[4]) shl 9;
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     tmp0 := pWorkRow[7];
     tmp1 := pWorkRow[5];
     tmp2 := pWorkRow[3];
     tmp3 := pWorkRow[1];
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     //Pospone descale
     z5 := ((z3 + z4) * FIX_1_175875602);
     tmp0 := (tmp0 * FIX_0_298631336);
     tmp1 := (tmp1 * FIX_2_053119869);
     tmp2 := (tmp2 * FIX_3_072711026);
     tmp3 := (tmp3 * FIX_1_501321110);
     z1 := (z1 * FIX_Minus_0_899976223);
     z2 := (z2 * FIX_Minus_2_562915447);
     z3 := (z3 * FIX_Minus_1_961570560);
     z4 := (z4 * FIX_Minus_0_390180644);
     z3 := z3 + z5;
     z4 := z4 + z5;
     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
     //all in one descale
     Temp := (tmp10 + tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[0] := Temp;
     Temp := (tmp10 - tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[7] := Temp;
     Temp := (tmp11 + tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[1] := Temp;
     Temp := (tmp11 - tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[6] := Temp;
     Temp := (tmp12 + tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[2] := Temp;
     Temp := (tmp12 - tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[5] := Temp;
     Temp := (tmp13 + tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[3] := Temp;
     Temp := (tmp13 - tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[4] := Temp;
    end;
   //Increment row pointers
   Inc(PChar(pWorkRow), 32);
   Inc(PChar(pSampleRow), 8);
  end;
end;

procedure InverseDCT_DKC_Pas_12_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var Wrksp: TsdIntArray64);
var
 I : integer;
 dci: integer;
 dcs: Byte;
 z1, z2, z3, z4, z5 : integer;
 tmp0, tmp1, tmp2, tmp3, tmp10, tmp11, tmp12, tmp13, Temp: Integer;
 pWorkRow : ^TsdIntArray64;
 pSampleRow : ^TsdSampleBlock;

begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
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
     //Even part: reverse the even part of the forward DCT.
     z2 := Coef[I+16] * Quant[I+16];
     z3 := Coef[I+48] * Quant[I+48];
     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9);
     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9);
     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9);
     z3 := z5 + (z3 * FIX_Minus_1_961570560) div (1 shl 9);
     z4 := z5 + (z4 * FIX_Minus_0_390180644) div (1 shl 9);
     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9) + z1 + z3;
     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9) + z2 + z4;
     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9) + z2 + z3;
     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9) + z1 + z4;
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
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
 pWorkRow := @Wrksp[0];
 pSampleRow := @Sample[0];
 for i := 0 to 7 do
  begin
   if (pWorkRow[1] = 0) and (pWorkRow[2] = 0) and (pWorkRow[3] = 0) and (pWorkRow[4] = 0) and
      (pWorkRow[5] = 0) and (pWorkRow[6] = 0) and (pWorkRow[7] = 0) then
    begin
     Temp := pWorkRow[0] div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     pSampleRow[0] := dcs;
     pSampleRow[1] := dcs;
     pSampleRow[2] := dcs;
     pSampleRow[3] := dcs;
     pSampleRow[4] := dcs;
     pSampleRow[5] := dcs;
     pSampleRow[6] := dcs;
     pSampleRow[7] := dcs;
    end
   else
    begin
     //Even part: reverse the even part of the forward DCT.
//     z2 := pWorkRow[2];
//     z3 := pWorkRow[6];
     //Pospone descale
     z1 := ((pWorkRow[2] + pWorkRow[6]) * FIX_0_541196100);
     tmp2 := (z1 + pWorkRow[6] * FIX_Minus_1_847759065);
     tmp3 := (z1 + pWorkRow[2] * FIX_0_765366865);
     //Scale up to compensate for later descale
     tmp0 := (pWorkRow[0] + pWorkRow[4]) shl 9;
     tmp1 := (pWorkRow[0] - pWorkRow[4]) shl 9;
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     //tmp0 := pWorkRow[7];
     //tmp1 := pWorkRow[5];
     //tmp2 := pWorkRow[3];
     //tmp3 := pWorkRow[1];
     z1 := pWorkRow[7] + pWorkRow[1];
     z2 := pWorkRow[5] + pWorkRow[3];
     z3 := pWorkRow[7] + pWorkRow[3];
     z4 := pWorkRow[5] + pWorkRow[1];
     //Pospone descale
     z5 := ((z3 + z4) * FIX_1_175875602);
     tmp0 := (pWorkRow[7] * FIX_0_298631336);
     tmp1 := (pWorkRow[5] * FIX_2_053119869);
     tmp2 := (pWorkRow[3] * FIX_3_072711026);
     tmp3 := (pWorkRow[1] * FIX_1_501321110);
     z1 := (z1 * FIX_Minus_0_899976223);
     z2 := (z2 * FIX_Minus_2_562915447);
     z3 := (z3 * FIX_Minus_1_961570560);
     z4 := (z4 * FIX_Minus_0_390180644);
     z3 := z3 + z5;
     z4 := z4 + z5;
     Inc(tmp0, z1 + z3);
     Inc(tmp1, z2 + z4);
     Inc(tmp2, z2 + z3);
     Inc(tmp3, z1 + z4);
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
     //all in one descale
     Temp := (tmp10 + tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[0] := Temp;
     Temp := (tmp10 - tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[7] := Temp;
     Temp := (tmp11 + tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[1] := Temp;
     Temp := (tmp11 - tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[6] := Temp;
     Temp := (tmp12 + tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[2] := Temp;
     Temp := (tmp12 - tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[5] := Temp;
     Temp := (tmp13 + tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[3] := Temp;
     Temp := (tmp13 - tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[4] := Temp;
    end;
   //Increment row pointers
   Inc(PChar(pWorkRow), 32);
   Inc(PChar(pSampleRow), 8);
  end;
end;

procedure InverseDCT_DKC_Pas_13_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var Wrksp: TsdIntArray64);
var
 I : integer;
 dci: integer;
 dcs: Byte;
 z1, z2, z3, z4, z5 : integer;
 tmp0, tmp1, tmp2, tmp3, tmp10, tmp11, tmp12, tmp13, Temp: Integer;
 pWorkRow : ^TsdIntArray64;
 pSampleRow : ^TsdSampleBlock;

begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
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
     //Even part: reverse the even part of the forward DCT.
     z2 := Coef[I+16] * Quant[I+16];
     z3 := Coef[I+48] * Quant[I+48];
//     z1 := ((z2 + z3) * FIX_0_541196100) div (1 shl 9);
//     tmp2 := z1 + (z3 * FIX_Minus_1_847759065) div (1 shl 9);
//     tmp3 := z1 + (z2 * FIX_0_765366865) div (1 shl 9);
     z1 := (z2 + z3) * FIX_0_541196100;
     tmp2 := (z1 + z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := (z1 + z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     //z5 := ((z3 + z4) * FIX_1_175875602) div (1 shl 9);
     z5 := (z3 + z4) * FIX_1_175875602;
//     z1 := (z1 * FIX_Minus_0_899976223) div (1 shl 9);
//     z2 := (z2 * FIX_Minus_2_562915447) div (1 shl 9);
     z1 := z1 * FIX_Minus_0_899976223;
     z2 := z2 * FIX_Minus_2_562915447;
//     z3 := z5 + (z3 * FIX_Minus_1_961570560) div (1 shl 9);
//     z4 := z5 + (z4 * FIX_Minus_0_390180644) div (1 shl 9);
//     z3 := (z5 + z3 * FIX_Minus_1_961570560) div (1 shl 9);
//     z4 := (z5 + z4 * FIX_Minus_0_390180644) div (1 shl 9);
     z3 := z5 + z3 * FIX_Minus_1_961570560;
     z4 := z5 + z4 * FIX_Minus_0_390180644;
//     tmp0 := (tmp0 * FIX_0_298631336) div (1 shl 9) + z1 + z3;
//     tmp1 := (tmp1 * FIX_2_053119869) div (1 shl 9) + z2 + z4;
//     tmp2 := (tmp2 * FIX_3_072711026) div (1 shl 9) + z2 + z3;
//     tmp3 := (tmp3 * FIX_1_501321110) div (1 shl 9) + z1 + z4;
     tmp0 := (tmp0 * FIX_0_298631336 + z1 + z3) div (1 shl 9);
     tmp1 := (tmp1 * FIX_2_053119869 + z2 + z4) div (1 shl 9);
     tmp2 := (tmp2 * FIX_3_072711026 + z2 + z3) div (1 shl 9);
     tmp3 := (tmp3 * FIX_1_501321110 + z1 + z4) div (1 shl 9);
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
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
 pWorkRow := @Wrksp[0];
 pSampleRow := @Sample[0];
 for i := 0 to 7 do
  begin
   if (pWorkRow[1] = 0) and (pWorkRow[2] = 0) and (pWorkRow[3] = 0) and (pWorkRow[4] = 0) and
      (pWorkRow[5] = 0) and (pWorkRow[6] = 0) and (pWorkRow[7] = 0) then
    begin
     Temp := pWorkRow[0] div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     pSampleRow[0] := dcs;
     pSampleRow[1] := dcs;
     pSampleRow[2] := dcs;
     pSampleRow[3] := dcs;
     pSampleRow[4] := dcs;
     pSampleRow[5] := dcs;
     pSampleRow[6] := dcs;
     pSampleRow[7] := dcs;
    end
   else
    begin
     //Even part: reverse the even part of the forward DCT.
     //Pospone descale
     z1 := ((pWorkRow[2] + pWorkRow[6]) * FIX_0_541196100);
     tmp2 := (z1 + pWorkRow[6] * FIX_Minus_1_847759065);
     tmp3 := (z1 + pWorkRow[2] * FIX_0_765366865);
     //Scale up to compensate for later descale
     tmp0 := (pWorkRow[0] + pWorkRow[4]) shl 9;
     tmp1 := (pWorkRow[0] - pWorkRow[4]) shl 9;
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     z1 := pWorkRow[7] + pWorkRow[1];
     z2 := pWorkRow[5] + pWorkRow[3];
     z3 := pWorkRow[7] + pWorkRow[3];
     z4 := pWorkRow[5] + pWorkRow[1];
     z5 := ((z3 + z4) * FIX_1_175875602);
     tmp0 := (pWorkRow[7] * FIX_0_298631336);
     tmp1 := (pWorkRow[5] * FIX_2_053119869);
     tmp2 := (pWorkRow[3] * FIX_3_072711026);
     tmp3 := (pWorkRow[1] * FIX_1_501321110);
     z1 := (z1 * FIX_Minus_0_899976223);
     z2 := (z2 * FIX_Minus_2_562915447);
     z3 := (z3 * FIX_Minus_1_961570560);
     z4 := (z4 * FIX_Minus_0_390180644);
     z3 := z3 + z5;
     z4 := z4 + z5;
     //Inc(tmp0, z1 + z3);
     tmp0 := tmp0 + z1 + z3;
     //Inc(tmp1, z2 + z4);
     tmp1 := tmp1 + z2 + z4;
     //Inc(tmp2, z2 + z3);
     tmp2 := tmp2 + z2 + z3;
     //Inc(tmp3, z1 + z4);
     tmp3 := tmp3 + z1 + z4;
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
     //all in one descale
     Temp := (tmp10 + tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[0] := Temp;
     Temp := (tmp10 - tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[7] := Temp;
     Temp := (tmp11 + tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[1] := Temp;
     Temp := (tmp11 - tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[6] := Temp;
     Temp := (tmp12 + tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[2] := Temp;
     Temp := (tmp12 - tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[5] := Temp;
     Temp := (tmp13 + tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[3] := Temp;
     Temp := (tmp13 - tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[4] := Temp;
    end;
   //Increment row pointers
   Inc(PChar(pWorkRow), 32);
   Inc(PChar(pSampleRow), 8);
  end;
end;

procedure InverseDCT_DKC_Pas_14_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var Wrksp: TsdIntArray64);
var
 I : Integer;
 dci : Integer;
 dcs : Byte;
 z1, z2, z3, z4, z5 : Integer;
 tmp0, tmp1, tmp2, tmp3, tmp10, tmp11, tmp12, tmp13, Temp: Integer;
 pWorkRow : ^TsdIntArray64;
 pSampleRow : ^TsdSampleBlock;

begin
 // First do the columns
 for I := 0 to 7 do
  begin
   if (Coef[I+8] = 0) and (Coef[I+16] = 0) and (Coef[I+24] = 0) and (Coef[I+32] = 0) and
      (Coef[I+40] = 0) and (Coef[I+48] = 0) and (Coef[I+56] = 0) then
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
     //Even part: reverse the even part of the forward DCT.
     z2 := Coef[I+16] * Quant[I+16];
     z3 := Coef[I+48] * Quant[I+48];
     z1 := (z2 + z3) * FIX_0_541196100;
     tmp2 := (z1 + z3 * FIX_Minus_1_847759065) div (1 shl 9);
     tmp3 := (z1 + z2 * FIX_0_765366865) div (1 shl 9);
     z2 := Coef[I] * Quant[I];
     z3 := Coef[I+32] * Quant[I + 32];
     tmp0 := (z2 + z3);
     tmp1 := (z2 - z3);
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     tmp0 := Coef[I+56] * Quant[I+56];
     tmp1 := Coef[I+40] * Quant[I+40];
     tmp2 := Coef[I+24] * Quant[I+24];
     tmp3 := Coef[I+8] * Quant[I+8];
     z1 := tmp0 + tmp3;
     z2 := tmp1 + tmp2;
     z3 := tmp0 + tmp2;
     z4 := tmp1 + tmp3;
     z5 := (z3 + z4) * FIX_1_175875602;
     z3 := z5 + z3 * FIX_Minus_1_961570560;
     z4 := z5 + z4 * FIX_Minus_0_390180644;
     z1 := z1 * FIX_Minus_0_899976223;
     z2 := z2 * FIX_Minus_2_562915447;
     tmp0 := (tmp0 * FIX_0_298631336 + z1 + z3) div (1 shl 9);
     tmp1 := (tmp1 * FIX_2_053119869 + z2 + z4) div (1 shl 9);
     tmp2 := (tmp2 * FIX_3_072711026 + z2 + z3) div (1 shl 9);
     tmp3 := (tmp3 * FIX_1_501321110 + z1 + z4) div (1 shl 9);
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
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
 pWorkRow := @Wrksp[0];
 pSampleRow := @Sample[0];
 for i := 0 to 7 do
  begin
   if (pWorkRow[1] = 0) and (pWorkRow[2] = 0) and (pWorkRow[3] = 0) and (pWorkRow[4] = 0) and
      (pWorkRow[5] = 0) and (pWorkRow[6] = 0) and (pWorkRow[7] = 0) then
    begin
     Temp := pWorkRow[0] div (1 shl 12) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     dcs := Temp;
     pSampleRow[0] := dcs;
     pSampleRow[1] := dcs;
     pSampleRow[2] := dcs;
     pSampleRow[3] := dcs;
     pSampleRow[4] := dcs;
     pSampleRow[5] := dcs;
     pSampleRow[6] := dcs;
     pSampleRow[7] := dcs;
    end
   else
    begin
     //Even part: reverse the even part of the forward DCT.
     //Pospone descale
     z1 := ((pWorkRow[2] + pWorkRow[6]) * FIX_0_541196100);
     tmp2 := (z1 + pWorkRow[6] * FIX_Minus_1_847759065);
     tmp3 := (z1 + pWorkRow[2] * FIX_0_765366865);
     //Scale up to compensate for later descale
     tmp0 := (pWorkRow[0] + pWorkRow[4]) shl 9;
     tmp1 := (pWorkRow[0] - pWorkRow[4]) shl 9;
     tmp10 := tmp0 + tmp3;
     tmp13 := tmp0 - tmp3;
     tmp11 := tmp1 + tmp2;
     tmp12 := tmp1 - tmp2;
     //Odd part per figure 8; the matrix is unitary and hence its
     //transpose is its inverse.  i0..i3 are y7,y5,y3,y1 respectively.
     z1 := pWorkRow[7] + pWorkRow[1];
     z2 := pWorkRow[5] + pWorkRow[3];
     z3 := pWorkRow[7] + pWorkRow[3];
     z4 := pWorkRow[5] + pWorkRow[1];
     z5 := ((z3 + z4) * FIX_1_175875602);
     tmp0 := (pWorkRow[7] * FIX_0_298631336);
     tmp1 := (pWorkRow[5] * FIX_2_053119869);
     tmp2 := (pWorkRow[3] * FIX_3_072711026);
     tmp3 := (pWorkRow[1] * FIX_1_501321110);
     z1 := (z1 * FIX_Minus_0_899976223);
     z2 := (z2 * FIX_Minus_2_562915447);
     z3 := (z3 * FIX_Minus_1_961570560);
     z4 := (z4 * FIX_Minus_0_390180644);
     z3 := z3 + z5;
     z4 := z4 + z5;
     tmp0 := tmp0 + z1 + z3;
     tmp1 := tmp1 + z2 + z4;
     tmp2 := tmp2 + z2 + z3;
     tmp3 := tmp3 + z1 + z4;
     //Final output stage: inputs are tmp10..tmp13, tmp0..tmp3
     Temp := (tmp10 + tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[0] := Temp;
     Temp := (tmp10 - tmp3) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[7] := Temp;
     Temp := (tmp11 + tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[1] := Temp;
     Temp := (tmp11 - tmp2) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[6] := Temp;
     Temp := (tmp12 + tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[2] := Temp;
     Temp := (tmp12 - tmp1) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[5] := Temp;
     Temp := (tmp13 + tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[3] := Temp;
     Temp := (tmp13 - tmp0) div (1 shl 21) + 128;
     if Temp < 0 then
      Temp := 0
     else
      if Temp > 255 then
       Temp := 255;
     pSampleRow[4] := Temp;
    end;
   //Increment row pointers
   Inc(PChar(pWorkRow), 32);
   Inc(PChar(pSampleRow), 8);
  end;
end;

//Made by Nils Haeck and Dennis Kjaer Christensen .... unfinished

procedure InverseDCT_DKC_Pas_66_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
const
 BlockSize = 8;
type
 TBlock = array[0..BlockSize - 1, 0..BlockSize - 1] of Double;
var
 Src, Dst : TBlock;
 I, I1, I2 : Integer;

 procedure IDCT8x8(var Src, Dst : TBlock);
 var
  u, v, x, y : Integer;
  Tot, Cu, Cv : Double;

 begin
  for x := 0 to BlockSize - 1 do
   begin
    for y := 0 to BlockSize - 1 do
     begin
      Tot := 0;
      for v := 0 to BlockSize - 1 do
       begin
        if v = 0 then
         Cv := 1/sqrt(2)
        else
         Cv := 1;
        for u := 0 to BlockSize - 1 do
         begin
          if u = 0 then
           Cu := 1/sqrt(2)
          else
           Cu := 1;
          Tot := Tot + 0.5*Cu * Src[v, u] * cos((2 * x + 1) * u * pi / 16) * cos((2 * y + 1)*v * pi / 16);
         end;
       end;
      Dst[x, y] := Tot * 0.5*Cv;
     end;
   end;
 end;

begin
 I := 0;
 for I1 := 0 to BlockSize - 1 do
  for I2 := 0 to BlockSize - 1 do
   begin
    Src[I1, I2] := Coef[I] * Quant[I];
    Inc(I);
   end;
 IDCT8x8(Src, Dst);
 I := 0;
 for I1 := 0 to BlockSize - 1 do
  for I2 := 0 to BlockSize - 1 do
   begin
    Sample[I] := DescaleAndRangeLimit(Round(Dst[I1, I2]));
    Inc(I);
   end;
end;

initialization

 //MainForm.RegisterFunction('InverseDCT_DKC_Pas_1_a', @InverseDCT_DKC_Pas_1_a);
 //MainForm.RegisterFunction('InverseDCT_DKC_Pas_2_a', @InverseDCT_DKC_Pas_2_a);
 //MainForm.RegisterFunction('InverseDCT_DKC_Pas_3_a', @InverseDCT_DKC_Pas_3_a);
 //MainForm.RegisterFunction('InverseDCT_DKC_Pas_4_a', @InverseDCT_DKC_Pas_4_a);
 //MainForm.RegisterFunction('InverseDCT_DKC_Pas_5_a', @InverseDCT_DKC_Pas_5_a);
 MainForm.RegisterFunction('InverseDCT_DKC_Pas_6_a', @InverseDCT_DKC_Pas_6_a);
 MainForm.RegisterFunction('InverseDCT_DKC_Pas_7_a', @InverseDCT_DKC_Pas_7_a);
 MainForm.RegisterFunction('InverseDCT_DKC_Pas_8_a', @InverseDCT_DKC_Pas_8_a);
 MainForm.RegisterFunction('InverseDCT_DKC_Pas_9_a', @InverseDCT_DKC_Pas_9_a);
 MainForm.RegisterFunction('InverseDCT_DKC_Pas_10_a', @InverseDCT_DKC_Pas_10_a);
 MainForm.RegisterFunction('InverseDCT_DKC_Pas_11_a', @InverseDCT_DKC_Pas_11_a);
 MainForm.RegisterFunction('InverseDCT_DKC_Pas_12_a', @InverseDCT_DKC_Pas_12_a);
 //MainForm.RegisterFunction('InverseDCT_DKC_Pas_13_a', @InverseDCT_DKC_Pas_13_a);//Fails validation
 //MainForm.RegisterFunction('InverseDCT_DKC_Pas_14_a', @InverseDCT_DKC_Pas_14_a);

end.

