unit IsPrimeCGUnit;

interface

function IsPrimeCJGPas4(Number : Cardinal) : Boolean;
function IsPrimeCJGPas5(Number : Cardinal) : Boolean;
function IsPrimeCJGPas6(Number : Cardinal) : Boolean;
function IsPrimeCJGPas7(Number : Cardinal) : Boolean;
//function b_SPRP(N, B: Cardinal): Boolean;
//function MulMod(x, y, m: Cardinal): Cardinal;

implementation

function MulMod(x, y, m: Cardinal): Cardinal;
var
  i : Integer;
begin
  Result := 0;
  repeat
    if Odd(y) then
      begin
        Inc(Result, x);
        if (Result < x) or (Result >= m) then
          Dec(Result, m);
      end;
    if y > 0 then
      begin
        y := y shr 1;
        i := x;
        x := x shl 1;
        if (i < 0) or (x >= m) then
          Dec(x, m);
      end;
  until y = 0;
end;

function b_SPRP(N, B: Cardinal): Boolean;
var
  d, a, r, s : Cardinal;
begin
    { we need to Find d and s that satisfy N - 1 = 2^s * d,
    where d is odd and s >= 0. }
    d := N - 1;
    s := 0;
    while not odd(d) do
    begin
      d := d shr 1;
      Inc(s);
    end;

    { Use right-to-left binary exponentiation to Calculate B^d mod N,
      result in a. }
    r := B;
    a := 1;
    while (d > 1) do
    begin
      if odd(d) then
      begin
        a := MulMod(a, r, N);
      end;
      d := d shr 1;
      r := MulMod(r, r, N);
    end;
    a := MulMod(a, r, N);

    { If a = 1 or a = N - 1, then N is a SPRP base B.}
    Result := (a = 1) or (a = N - 1);

    { If the above conditions are not true then we need to see wether
    a^(2^r) mod N = N - 1, where 0 <= r < s. }
    while ((Not Result) and (s > 0)) do
    begin
      a:= MulMod(a, a, N);
      Result := (a = N - 1);
      Dec(s);
    end;

end;

function IsPrimeCJGPas4(Number : Cardinal) : Boolean;

const
  PF: array[0..29] of Cardinal = (7,  11,  13,  17,  19,  23,  29,  31,
37,  41,
                                  43, 47,  53,  59,  61,  67,  71,  73,
79,  83,
                                  89, 97, 101, 103, 107, 109, 113, 127,
131, 137);
var
  I,J: Cardinal;
  label ender;
begin
  case Number of
    0..1: Result := False;
    { 0 and 1 are neither prime nor composite. }
    2, 3, 5, 7, 31, 61, 73: Result := True;
    { These three rogues break the test, so deal with them here. }
    else
      begin
        Result := False;
        If Odd(Number) then
        begin
          if Number mod 3 = 0 then Exit;
          if Number mod 5 = 0 then Exit;
          I := 0;
          J := PF[I];
          while (J < Number) and (I <= 29) do
          begin
            if Number mod J = 0 then Exit;
            Inc (I,1);
            J := PF[I];
          end;

          if J = Number then goto ender;

          If Number < 9080191 then
          begin
            if not b_SPRP(Number, 31) then exit;
            if not b_SPRP(Number, 73) then exit;
ender:      Result := True;
            exit;
          end
          else
          begin
            if not b_SPRP(Number, 2) then exit;
            if not b_SPRP(Number, 61) then exit;
            if not b_SPRP(Number, 7) then exit;
            Result := True;
            exit;
          end;
        end
        else exit;
      end;
  end;
end; { function IsPrime }

function IsPrimeCJGPas5(Number : Cardinal) : Boolean;

const
  PF: array[0..305] of Word = {excluding 2,3,5 and 7}
    (11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,
     79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,
     163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,
     241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,
     337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,
     431,433,439,443,449,457,461,463,467,479,487,491,499,503,509,
     521,523,541,547,557,563,569,571,577,587,593,599,601,607,613,
     617,619,631,641,643,647,653,659,661,673,677,683,691,701,709,
     719,727,733,739,743,751,757,761,769,773,787,797,809,811,821,
     823,827,829,839,853,857,859,863,877,881,883,887,907,911,919,
     929,937,941,947,953,967,971,977,983,991,997,1009,1013,1019,
     1021,1031,1033,1039,1049,1051,1061,1063,1069,1087,1091,1093,
     1097,1103,1109,1117,1123,1129,1151,1153,1163,1171,1181,1187,
     1193,1201,1213,1217,1223,1229,1231,1237,1249,1259,1277,1279,
     1283,1289,1291,1297,1301,1303,1307,1319,1321,1327,1361,1367,
     1373,1381,1399,1409,1423,1427,1429,1433,1439,1447,1451,1453,
     1459,1471,1481,1483,1487,1489,1493,1499,1511,1523,1531,1543,
     1549,1553,1559,1567,1571,1579,1583,1597,1601,1607,1609,1613,
     1619,1621,1627,1637,1657,1663,1667,1669,1693,1697,1699,1709,
     1721,1723,1733,1741,1747,1753,1759,1777,1783,1787,1789,1801,
     1811,1823,1831,1847,1861,1867,1871,1873,1877,1879,1889,1901,
     1907,1913,1931,1933,1949,1951,1973,1979,1987,1993,1997,1999,
     2003,2011,2017,2027,2029,2039,2053);

var
  i,j: Cardinal;
  label ender;
begin
  if not Odd(Number) then
  begin
    Result := Number = 2;
    Exit;
  end
  else
  begin
    if Number <= 7 then
    begin
      Result := not(Number = 1);
      Exit;
    end;

    Result := False;
    if Number mod 3 = 0  then Exit;
    if Number mod 5 = 0  then Exit;
    if Number mod 7 = 0  then Exit;

    if Number < 4214809 then
    begin
      if Number <= 1849 then
      begin
        if Number in [11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,

71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,

149,151,157,163,167,173,179,181,191,193,197,199,211,
                      223,227,229,233,239,241,251] then goto ender;
        if (Number-256) in
[1,7,13,15,21,25,27,37,51,55,57,61,75,81,91,93,

97,103,111,117,123,127,133,141,145,153,163,165,175,

177,183,187,193,201,205,207,211,223,231,235,243,247,
                      253] then goto ender;
        if (Number-512) in
[9,11,29,35,45,51,57,59,65,75,81,87,89,95,101,

105,107,119,129,131,135,141,147,149,161,165,171,179,
                      189,197,207,215,221,227,231,239,245,249] then
goto ender;

        I := 131;
        while (PF[I] <= Number) do
        begin
          if Number = PF[I] then goto ender;
          Inc (I,1);
        end;

        Exit;
      end
      else
      begin
        I := 0;
        j := round(sqrt(Number));
        while (PF[I] <= J) do
        begin
          if Number mod PF[I] = 0 then Exit;
          Inc (I,1);
        end;

  Ender:Result := True;
        Exit;

      end;
    end
    else
    begin
      if Number mod 11 = 0 then Exit;
      if Number mod 13 = 0 then Exit;
      if Number mod 17 = 0 then Exit;
      if Number mod 19 = 0 then Exit;
      if Number mod 23 = 0 then Exit;
      if Number mod 29 = 0 then Exit;
      if Number mod 31 = 0 then Exit;
      if Number mod 37 = 0 then Exit;

      if Number < 27722857  then
      begin
        if not b_SPRP(Number, 80) then exit;
        if not b_SPRP(Number, 23) then exit;
        Result := True;
        exit;
      end;

      if Number mod 41 = 0 then Exit;
      if Number mod 43 = 0 then Exit;
      if Number mod 47 = 0 then Exit;
      if not b_SPRP(Number, 2)  then exit;
      if not b_SPRP(Number, 61) then exit;
      if not b_SPRP(Number, 7)  then exit;
      Result := True;
      exit;

    end;
  end;
end; { function IsPrime }

function IsPrimeCJGPas6(Number : Cardinal) : Boolean;
  const
  PF1: array[0..199] of Word = {excluding 2,3,5}
    (7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,
     79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,
     163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,
     241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,
     337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,
     431,433,439,443,449,457,461,463,467,479,487,491,499,503,509,
     521,523,541,547,557,563,569,571,577,587,593,599,601,607,613,
     617,619,631,641,643,647,653,659,661,673,677,683,691,701,709,
     719,727,733,739,743,751,757,761,769,773,787,797,809,811,821,
     823,827,829,839,853,857,859,863,877,881,883,887,907,911,919,
     929,937,941,947,953,967,971,977,983,991,997,1009,1013,1019,
     1021,1031,1033,1039,1049,1051,1061,1063,1069,1087,1091,1093,
     1097,1103,1109,1117,1123,1129,1151,1153,1163,1171,1181,1187,
     1193,1201,1213,1217,1223,1229,1231,1237);

var
  I,J,K: Cardinal;
  label Ender;
begin
  if not Odd(Number) then
  begin
    Result := Number = 2;
  end
  else
  begin
    if Number <= 7 then
    begin
      Result := not(Number = 1);
    end
    else
    begin
      Result := False;
      If Odd(Number) then
      begin
        if Number mod 3 = 0 then Exit;
        if Number mod 5 = 0 then Exit;
        if Number <= (1237 * 1237) then
        begin
          I := 0;
          J := round(sqrt(Number));
          K := PF1[I];
          while (K <= J) do
          begin
            if Number mod K = 0 then Exit;
            Inc (I,1);
            K := PF1[I];
          end;
          Result := True;
        end
        else
        begin
          I := 0;
          J := PF1[I];
          while (J < Number) and (I <= 90) do
          begin
            if Number mod J = 0 then Exit;
            Inc (I,1);
            J := PF1[I];
          end;

          if J = Number then goto Ender;

          If Number < 27956503 then
          begin
            if not b_SPRP(Number, 6108) then Exit;
            if not b_SPRP(Number, 23) then Exit;
            Result := True;
          end
          else
          begin
            if not b_SPRP(Number, 2)  then Exit;
            if not b_SPRP(Number, 61) then Exit;
            if not b_SPRP(Number, 7)  then Exit;
Ender:      Result := True;
          end;
        end;
      end;
    end;
  end;
end;

function IsPrimeCJGPas7(Number : Cardinal) : Boolean;
  const
  PF1: array[0..69] of Word = {excluding 2,3,5}
    (7,    11,   13,   17,   19,   23,   29,   31,   37,   41,
     43,   47,   53,   59,   61,   67,   71,   73,   79,   83,
     89,   97,   101,  103,  107,  109,  113,  127,  131,  137,
     139,  149,  151,  157,  163,  167,  173,  179,  181,  191,
     193,  197,  199,  211,  223,  227,  229,  233,  239,  241,
     251,  257,  263,  269,  271,  277,  281,  283,  293,  307,
     311,  313,  317,  331,  337,  347,  349,  353,  359,  367);

  PF2: array[0..87] of Cardinal = (
      1907851,    4181921,    4469471,    5256091,    9006401,
9863461,
      14709241,   25326001,   40987201,   55729957,   58449847,
67194401,
      94502701,   100618933,  109437751,  114305441,  133800661,
135969401,
      147028001,  153928133,  161304001,  192857761,  196049701,
213035761,
      226359547,  245950561,  271763467,  290953921,  317365933,
331658081,
      382536001,  407889161,  410680357,  418617281,  418667401,
419184481,
      424411501,  437866087,  439309261,  501172241,  534782293,
535252867,
      600893921,  609361567,  611812321,  702683101,  710721001,
717096641,
      746331041,  770909107,  832048447,  923437213,  960946321,
967287751,
      1072898711, 1106595493, 1157839381, 1282568741, 1404253369,
1485061471,
      1503705601, 1565893201, 1787934881, 1791426787, 1934350351,
2016481477,
      2036224321, 2076192007, 2331181621, 2550780277, 2621977627,
2634284801,
      2840871041, 2916247819, 2945208001, 3014101261, 3037781251,
3083053387,
      3156599161, 3215031751, 3219808411, 3222693421, 3538213381,
3697278427,
      3897241129, 4100934241, 4108970251, 4271267333);

var
  I,J,K: Cardinal;
  label Ender;
begin
  if not Odd(Number) then
  begin
    Result := Number = 2;
  end
  else
  begin
    if Number <= 7 then
    begin
      Result := not(Number = 1);
    end
    else
    begin
      Result := False;
      if Number mod 3 = 0 then Exit;
      if Number mod 5 = 0 then Exit;
      if Number < (367 * 367) then
      begin
        I := 0;
        J := round(sqrt(Number));
        K := PF1[I];
        while (K <= J) do
        begin
          if Number mod K = 0 then Exit;
          Inc (I,1);
          K := PF1[I];
        end;
        Result := True;
      end
      else
      begin
        I := 0;
        J := PF1[I];
        while (J < Number) and (I <= 9) do
        begin
          if Number mod J = 0 then Exit;
          if Number mod PF1[I+1] = 0 then Exit;
          Inc (I,2);
          J := PF1[I];
        end;

        if J = Number then goto Ender;

        if not b_SPRP(Number, 2) then Exit;
        if not b_SPRP(Number, 7) then Exit;

        // Check those false primes which are missed in the b_SPRP 2 and 7
        if Number <= 4206295433 then
        begin
          I := 0;
          K := PF2[I];
          while (K <= Number) do
          begin
            if Number = PF2[I] then Exit;
            Inc (I,1);
            K := PF2[I];
          end;
        end;

Ender:  Result := True;
      end;
    end;
  end;
end;

end.
