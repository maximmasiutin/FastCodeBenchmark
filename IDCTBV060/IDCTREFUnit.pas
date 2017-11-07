unit IDCTREFUnit;

interface

type

 TsdCoefBlock = array[0..63] of SmallInt;
 PsdCoefBlock = ^TsdCoefBlock;
 TsdSampleBlock = array[0..63] of Byte;
 PsdSampleBlock = ^TsdSampleBlock;
 TsdIntArray64 = array[0..63] of Integer;

procedure InverseDCT_Ref_Pas_1_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);

implementation

uses
 MainUnit;

const
  // we use 9 bits of precision, so must multiply by 2^9
  cIAccConstScale = 1 shl 9;
  FIX_0_298631336 = Round(cIAccConstScale * 0.298631336);
  FIX_0_390180644 = Round(cIAccConstScale * 0.390180644);
  FIX_0_541196100 = Round(cIAccConstScale * 0.541196100);
  FIX_0_765366865 = Round(cIAccConstScale * 0.765366865);
  FIX_0_899976223 = Round(cIAccConstScale * 0.899976223);
  FIX_1_175875602 = Round(cIAccConstScale * 1.175875602);
  FIX_1_501321110 = Round(cIAccConstScale * 1.501321110);
  FIX_1_847759065 = Round(cIAccConstScale * 1.847759065);
  FIX_1_961570560 = Round(cIAccConstScale * 1.961570560);
  FIX_2_053119869 = Round(cIAccConstScale * 2.053119869);
  FIX_2_562915447 = Round(cIAccConstScale * 2.562915447);
  FIX_3_072711026 = Round(cIAccConstScale * 3.072711026);
  //Made by DKC
  FIX_1_414213562 = Round(cIAccConstScale * 1.414213562);
  FIX_1_082392200 = Round(cIAccConstScale * 1.082392200);
  FIX_2_613125930 = Round(cIAccConstScale * 2.613125930);

// Descale and range limit to byte domain. We shift right over
// 12 bits: 9 bits to remove precision, and 3 bits to get rid of the additional
// factor 8 introducted by the IDCT transform.

function RangeLimit(A: integer): integer;
begin
  // Delphi seems to convert the "div" here to SAR just fine (D7), so we
  // don't use ASM but plain pascal
  Result := A div (1 shl 12) + 128;
  if Result < 0 then
    Result := 0
  else
    if Result > 255 then
      Result := 255;
end;

function MultiplyRef(A, B : Integer) : Integer;
begin
  Result := (Int64(A) * Int64(B)) div (1 shl 9);
end;

procedure InverseDCT_Ref_Pas_1_a(const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);
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

      z1 := MultiplyRef(z2 + z3, FIX_0_541196100);
      tmp2 := z1 + MultiplyRef(z3, - FIX_1_847759065);
      tmp3 := z1 + MultiplyRef(z2, FIX_0_765366865);

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
      z5 := MultiplyRef(z3 + z4, FIX_1_175875602); { sqrt(2) * c3 }

      tmp0 := MultiplyRef(tmp0, FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
      tmp1 := MultiplyRef(tmp1, FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
      tmp2 := MultiplyRef(tmp2, FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
      tmp3 := MultiplyRef(tmp3, FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }
      z1 := MultiplyRef(z1, - FIX_0_899976223); { sqrt(2) * (c7-c3) }
      z2 := MultiplyRef(z2, - FIX_2_562915447); { sqrt(2) * (-c1-c3) }
      z3 := MultiplyRef(z3, - FIX_1_961570560); { sqrt(2) * (-c3-c5) }
      z4 := MultiplyRef(z4, - FIX_0_390180644); { sqrt(2) * (c5-c3) }

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
      dcs := RangeLimit(w0^);
      s0^ := dcs; s1^ := dcs; s2^ := dcs; s3^ := dcs;
      s4^ := dcs; s5^ := dcs; s6^ := dcs; s7^ := dcs;
    end else
    begin
      { Even part: reverse the even part of the forward DCT. }
      { The rotator is sqrt(2)*c(-6). }

      z2 := w2^;
      z3 := w6^;

      z1 := MultiplyRef(z2 + z3, FIX_0_541196100);
      tmp2 := z1 + MultiplyRef(z3, - FIX_1_847759065);
      tmp3 := z1 + MultiplyRef(z2, FIX_0_765366865);

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
      z5 := MultiplyRef(z3 + z4, FIX_1_175875602); { sqrt(2) * c3 }

      tmp0 := MultiplyRef(tmp0, FIX_0_298631336); { sqrt(2) * (-c1+c3+c5-c7) }
      tmp1 := MultiplyRef(tmp1, FIX_2_053119869); { sqrt(2) * ( c1+c3-c5+c7) }
      tmp2 := MultiplyRef(tmp2, FIX_3_072711026); { sqrt(2) * ( c1+c3+c5-c7) }
      tmp3 := MultiplyRef(tmp3, FIX_1_501321110); { sqrt(2) * ( c1+c3-c5-c7) }
      z1 := MultiplyRef(z1, - FIX_0_899976223); { sqrt(2) * (c7-c3) }
      z2 := MultiplyRef(z2, - FIX_2_562915447); { sqrt(2) * (-c1-c3) }
      z3 := MultiplyRef(z3, - FIX_1_961570560); { sqrt(2) * (-c3-c5) }
      z4 := MultiplyRef(z4, - FIX_0_390180644); { sqrt(2) * (c5-c3) }

      Inc(z3, z5);
      Inc(z4, z5);

      Inc(tmp0, z1 + z3);
      Inc(tmp1, z2 + z4);
      Inc(tmp2, z2 + z3);
      Inc(tmp3, z1 + z4);

      { Final output stage: inputs are tmp10..tmp13, tmp0..tmp3 }

      s0^ := RangeLimit(tmp10 + tmp3);
      s7^ := RangeLimit(tmp10 - tmp3);
      s1^ := RangeLimit(tmp11 + tmp2);
      s6^ := RangeLimit(tmp11 - tmp2);
      s2^ := RangeLimit(tmp12 + tmp1);
      s5^ := RangeLimit(tmp12 - tmp1);
      s3^ := RangeLimit(tmp13 + tmp0);
      s4^ := RangeLimit(tmp13 - tmp0);

    end;
    // Advance block pointers
    inc(s0, 8); inc(s1, 8); inc(s2, 8); inc(s3, 8);
    inc(s4, 8); inc(s5, 8); inc(s6, 8); inc(s7, 8);
    inc(w0, 8); inc(w1, 8); inc(w2, 8); inc(w3, 8);
    inc(w4, 8); inc(w5, 8); inc(w6, 8); inc(w7, 8);
  end;
end;

initialization

MainForm.RegisterFunction('InverseDCT_Ref_Pas_1_a', @InverseDCT_Ref_Pas_1_a);

end.


