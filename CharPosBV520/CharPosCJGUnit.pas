unit CharPosCJGUnit;

interface

function CharPos_CJG_Pas_3_a(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_3_b(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_3_c(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_3_d(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_5_a(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_5_b(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_5_c(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_5_d(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_6_a(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_6_b(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_6_c(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_6_d(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_7_a(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_7_b(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_7_c(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_7_d(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_9_a(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_9_b(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_9_c(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_CJG_Pas_9_d(Ch : Char; const Str : AnsiString) : Integer;

implementation

function CharPos_CJG_Pas_3_a(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2 : Integer;
   P1, P2, P3 : PChar;
label Finish, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
  If Str='' then
    begin
      Result := 0;
      exit;
    end
  else
     begin
       Len := PInteger(Integer(Str)-4)^;
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                             this is only used as a reference}
       if (P1 < P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then goto Found0;
               if Ch = P1[1]  then goto Found1;
               if Ch = P1[2]  then goto Found2;
               if Ch = P1[3]  then goto Found3;
               if Ch = P1[4]  then goto Found4;
               if Ch = P1[5]  then goto Found5;
               if Ch = P1[6]  then goto Found6;
               if Ch = P1[7]  then goto Found7;
               if Ch = P1[8]  then goto Found8;
               if Ch = P1[9]  then goto Found9;
               if Ch = P1[10] then goto Found10;
               if Ch = P1[11] then goto Found11;
               if Ch = P1[12] then goto Found12;
               if Ch = P1[13] then goto Found13;
               if Ch = P1[14] then goto Found14;
               if Ch = P1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then goto Small;
             end;
         end
         else goto Small;

       Found15: Result := 16 + Len + P1 - P2; exit;
       Found14: Result := 15 + Len + P1 - P2; exit;
       Found13: Result := 14 + Len + P1 - P2; exit;
       Found12: Result := 13 + Len + P1 - P2; exit;
       Found11: Result := 12 + Len + P1 - P2; exit;
       Found10: Result := 11 + Len + P1 - P2; exit;
       Found9:  Result := 10 + Len + P1 - P2; exit;
       Found8:  Result := 9  + Len + P1 - P2; exit;
       Found7:  Result := 8  + Len + P1 - P2; exit;
       Found6:  Result := 7  + Len + P1 - P2; exit;
       Found5:  Result := 6  + Len + P1 - P2; exit;
       Found4:  Result := 5  + Len + P1 - P2; exit;
       Found3:  Result := 4  + Len + P1 - P2; exit;
       Found2:  Result := 3  + Len + P1 - P2; exit;
       Found1:  Result := 2  + Len + P1 - P2; exit;
       Found0:  Result := 1  + Len + P1 - P2; exit;

       Small:
         L2 := P2 - P1;

         case L2 of
           0:  goto Finish;
           1:  goto label1;
           2:  goto label2;
           3:  goto label3;
           4:  goto label4;
           5:  goto label5;
           6:  goto label6;
           7:  goto label7;
           8:  goto label8;
           9:  goto label9;
           10: goto label10;
           11: goto label11;
           12: goto label12;
           13: goto label13;
           14: goto label14;
           15: goto label15;
         end;

       label16: if Ch = P1^       then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0;        exit;

       F0:      Result := Len;      exit;
       F1:      Result := Len - 1;  exit;
       F2:      Result := Len - 2;  exit;
       F3:      Result := Len - 3;  exit;
       F4:      Result := Len - 4;  exit;
       F5:      Result := Len - 5;  exit;
       F6:      Result := Len - 6;  exit;
       F7:      Result := Len - 7;  exit;
       F8:      Result := Len - 8;  exit;
       F9:      Result := Len - 9;  exit;
       F10:     Result := Len - 10; exit;
       F11:     Result := Len - 11; exit;
       F12:     Result := Len - 12; exit;
       F13:     Result := Len - 13; exit;
       F14:     Result := Len - 14; exit;
       F15:     Result := Len - 15; exit;
     end;
end;

function CharPos_CJG_Pas_3_b(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2 : Integer;
   P1, P2, P3 : PChar;
label Finish, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
  If Str='' then
    begin
      Result := 0;
      exit;
    end
  else
     begin
       Len := PInteger(Integer(Str)-4)^;
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                             this is only used as a reference}
       if (P1 < P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then goto Found0;
               if Ch = P1[1]  then goto Found1;
               if Ch = P1[2]  then goto Found2;
               if Ch = P1[3]  then goto Found3;
               if Ch = P1[4]  then goto Found4;
               if Ch = P1[5]  then goto Found5;
               if Ch = P1[6]  then goto Found6;
               if Ch = P1[7]  then goto Found7;
               if Ch = P1[8]  then goto Found8;
               if Ch = P1[9]  then goto Found9;
               if Ch = P1[10] then goto Found10;
               if Ch = P1[11] then goto Found11;
               if Ch = P1[12] then goto Found12;
               if Ch = P1[13] then goto Found13;
               if Ch = P1[14] then goto Found14;
               if Ch = P1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then goto Small;
             end;
         end
         else goto Small;

       Found15: Result := 16 + Len + P1 - P2; exit;
       Found14: Result := 15 + Len + P1 - P2; exit;
       Found13: Result := 14 + Len + P1 - P2; exit;
       Found12: Result := 13 + Len + P1 - P2; exit;
       Found11: Result := 12 + Len + P1 - P2; exit;
       Found10: Result := 11 + Len + P1 - P2; exit;
       Found9:  Result := 10 + Len + P1 - P2; exit;
       Found8:  Result := 9  + Len + P1 - P2; exit;
       Found7:  Result := 8  + Len + P1 - P2; exit;
       Found6:  Result := 7  + Len + P1 - P2; exit;
       Found5:  Result := 6  + Len + P1 - P2; exit;
       Found4:  Result := 5  + Len + P1 - P2; exit;
       Found3:  Result := 4  + Len + P1 - P2; exit;
       Found2:  Result := 3  + Len + P1 - P2; exit;
       Found1:  Result := 2  + Len + P1 - P2; exit;
       Found0:  Result := 1  + Len + P1 - P2; exit;

       Small:
         L2 := P2 - P1;

         case L2 of
           0:  goto Finish;
           1:  goto label1;
           2:  goto label2;
           3:  goto label3;
           4:  goto label4;
           5:  goto label5;
           6:  goto label6;
           7:  goto label7;
           8:  goto label8;
           9:  goto label9;
           10: goto label10;
           11: goto label11;
           12: goto label12;
           13: goto label13;
           14: goto label14;
           15: goto label15;
         end;

       label16: if Ch = P1^       then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0;        exit;

       F0:      Result := Len;      exit;
       F1:      Result := Len - 1;  exit;
       F2:      Result := Len - 2;  exit;
       F3:      Result := Len - 3;  exit;
       F4:      Result := Len - 4;  exit;
       F5:      Result := Len - 5;  exit;
       F6:      Result := Len - 6;  exit;
       F7:      Result := Len - 7;  exit;
       F8:      Result := Len - 8;  exit;
       F9:      Result := Len - 9;  exit;
       F10:     Result := Len - 10; exit;
       F11:     Result := Len - 11; exit;
       F12:     Result := Len - 12; exit;
       F13:     Result := Len - 13; exit;
       F14:     Result := Len - 14; exit;
       F15:     Result := Len - 15; exit;
     end;
end;

procedure Filler1;
asm
 nop
 nop
 nop
 nop
 nop
end;

function CharPos_CJG_Pas_3_c(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2 : Integer;
   P1, P2, P3 : PChar;
label Finish, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
  If Str='' then
    begin
      Result := 0;
      exit;
    end
  else
     begin
       Len := PInteger(Integer(Str)-4)^;
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                             this is only used as a reference}
       if (P1 < P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then goto Found0;
               if Ch = P1[1]  then goto Found1;
               if Ch = P1[2]  then goto Found2;
               if Ch = P1[3]  then goto Found3;
               if Ch = P1[4]  then goto Found4;
               if Ch = P1[5]  then goto Found5;
               if Ch = P1[6]  then goto Found6;
               if Ch = P1[7]  then goto Found7;
               if Ch = P1[8]  then goto Found8;
               if Ch = P1[9]  then goto Found9;
               if Ch = P1[10] then goto Found10;
               if Ch = P1[11] then goto Found11;
               if Ch = P1[12] then goto Found12;
               if Ch = P1[13] then goto Found13;
               if Ch = P1[14] then goto Found14;
               if Ch = P1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then goto Small;
             end;
         end
         else goto Small;

       Found15: Result := 16 + Len + P1 - P2; exit;
       Found14: Result := 15 + Len + P1 - P2; exit;
       Found13: Result := 14 + Len + P1 - P2; exit;
       Found12: Result := 13 + Len + P1 - P2; exit;
       Found11: Result := 12 + Len + P1 - P2; exit;
       Found10: Result := 11 + Len + P1 - P2; exit;
       Found9:  Result := 10 + Len + P1 - P2; exit;
       Found8:  Result := 9  + Len + P1 - P2; exit;
       Found7:  Result := 8  + Len + P1 - P2; exit;
       Found6:  Result := 7  + Len + P1 - P2; exit;
       Found5:  Result := 6  + Len + P1 - P2; exit;
       Found4:  Result := 5  + Len + P1 - P2; exit;
       Found3:  Result := 4  + Len + P1 - P2; exit;
       Found2:  Result := 3  + Len + P1 - P2; exit;
       Found1:  Result := 2  + Len + P1 - P2; exit;
       Found0:  Result := 1  + Len + P1 - P2; exit;

       Small:
         L2 := P2 - P1;

         case L2 of
           0:  goto Finish;
           1:  goto label1;
           2:  goto label2;
           3:  goto label3;
           4:  goto label4;
           5:  goto label5;
           6:  goto label6;
           7:  goto label7;
           8:  goto label8;
           9:  goto label9;
           10: goto label10;
           11: goto label11;
           12: goto label12;
           13: goto label13;
           14: goto label14;
           15: goto label15;
         end;

       label16: if Ch = P1^       then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0;        exit;

       F0:      Result := Len;      exit;
       F1:      Result := Len - 1;  exit;
       F2:      Result := Len - 2;  exit;
       F3:      Result := Len - 3;  exit;
       F4:      Result := Len - 4;  exit;
       F5:      Result := Len - 5;  exit;
       F6:      Result := Len - 6;  exit;
       F7:      Result := Len - 7;  exit;
       F8:      Result := Len - 8;  exit;
       F9:      Result := Len - 9;  exit;
       F10:     Result := Len - 10; exit;
       F11:     Result := Len - 11; exit;
       F12:     Result := Len - 12; exit;
       F13:     Result := Len - 13; exit;
       F14:     Result := Len - 14; exit;
       F15:     Result := Len - 15; exit;
     end;
end;

procedure Filler2;
asm
 nop
 nop
 nop
 nop
 nop
end;

function CharPos_CJG_Pas_3_d(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2 : Integer;
   P1, P2, P3 : PChar;
label Finish, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
  If Str='' then
    begin
      Result := 0;
      exit;
    end
  else
     begin
       Len := PInteger(Integer(Str)-4)^;
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                             this is only used as a reference}
       if (P1 < P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then goto Found0;
               if Ch = P1[1]  then goto Found1;
               if Ch = P1[2]  then goto Found2;
               if Ch = P1[3]  then goto Found3;
               if Ch = P1[4]  then goto Found4;
               if Ch = P1[5]  then goto Found5;
               if Ch = P1[6]  then goto Found6;
               if Ch = P1[7]  then goto Found7;
               if Ch = P1[8]  then goto Found8;
               if Ch = P1[9]  then goto Found9;
               if Ch = P1[10] then goto Found10;
               if Ch = P1[11] then goto Found11;
               if Ch = P1[12] then goto Found12;
               if Ch = P1[13] then goto Found13;
               if Ch = P1[14] then goto Found14;
               if Ch = P1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then goto Small;
             end;
         end
         else goto Small;

       Found15: Result := 16 + Len + P1 - P2; exit;
       Found14: Result := 15 + Len + P1 - P2; exit;
       Found13: Result := 14 + Len + P1 - P2; exit;
       Found12: Result := 13 + Len + P1 - P2; exit;
       Found11: Result := 12 + Len + P1 - P2; exit;
       Found10: Result := 11 + Len + P1 - P2; exit;
       Found9:  Result := 10 + Len + P1 - P2; exit;
       Found8:  Result := 9  + Len + P1 - P2; exit;
       Found7:  Result := 8  + Len + P1 - P2; exit;
       Found6:  Result := 7  + Len + P1 - P2; exit;
       Found5:  Result := 6  + Len + P1 - P2; exit;
       Found4:  Result := 5  + Len + P1 - P2; exit;
       Found3:  Result := 4  + Len + P1 - P2; exit;
       Found2:  Result := 3  + Len + P1 - P2; exit;
       Found1:  Result := 2  + Len + P1 - P2; exit;
       Found0:  Result := 1  + Len + P1 - P2; exit;

       Small:
         L2 := P2 - P1;

         case L2 of
           0:  goto Finish;
           1:  goto label1;
           2:  goto label2;
           3:  goto label3;
           4:  goto label4;
           5:  goto label5;
           6:  goto label6;
           7:  goto label7;
           8:  goto label8;
           9:  goto label9;
           10: goto label10;
           11: goto label11;
           12: goto label12;
           13: goto label13;
           14: goto label14;
           15: goto label15;
         end;

       label16: if Ch = P1^       then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0;        exit;

       F0:      Result := Len;      exit;
       F1:      Result := Len - 1;  exit;
       F2:      Result := Len - 2;  exit;
       F3:      Result := Len - 3;  exit;
       F4:      Result := Len - 4;  exit;
       F5:      Result := Len - 5;  exit;
       F6:      Result := Len - 6;  exit;
       F7:      Result := Len - 7;  exit;
       F8:      Result := Len - 8;  exit;
       F9:      Result := Len - 9;  exit;
       F10:     Result := Len - 10; exit;
       F11:     Result := Len - 11; exit;
       F12:     Result := Len - 12; exit;
       F13:     Result := Len - 13; exit;
       F14:     Result := Len - 14; exit;
       F15:     Result := Len - 15; exit;
     end;
end;

function CharPos_CJG_Pas_5_a(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2    : Integer;
   P1, P2, P3 : PChar;
label Finish, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
   If Str='' then
   begin
     Result := 0;
     exit;
   end;
   Len := PInteger(Integer(Str)-4)^;
   if Len > 0 then
     begin
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                              this is only used as a reference}
       if (P1 < P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then Goto Found0;
               if Ch = p1[1]  then goto Found1;
               if Ch = p1[2]  then goto Found2;
               if Ch = p1[3]  then goto Found3;
               if Ch = p1[4]  then goto Found4;
               if Ch = p1[5]  then goto Found5;
               if Ch = p1[6]  then goto Found6;
               if Ch = p1[7]  then goto Found7;
               if Ch = p1[8]  then goto Found8;
               if Ch = p1[9]  then goto Found9;
               if Ch = p1[10] then goto Found10;
               if Ch = p1[11] then goto Found11;
               if Ch = p1[12] then goto Found12;
               if Ch = p1[13] then goto Found13;
               if Ch = p1[14] then goto Found14;
               if Ch = p1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then Goto Small;
             end;
        end
        else goto Small;

       Found0:  Result := Len + P1 - P2 + 1;  exit;
       Found1:  Result := Len + P1 - P2 + 2;  exit;
       Found2:  Result := Len + P1 - P2 + 3;  exit;
       Found3:  Result := Len + P1 - P2 + 4;  exit;
       Found4:  Result := Len + P1 - P2 + 5;  exit;
       Found5:  Result := Len + P1 - P2 + 6;  exit;
       Found6:  Result := Len + P1 - P2 + 7;  exit;
       Found7:  Result := Len + P1 - P2 + 8;  exit;
       Found8:  Result := Len + P1 - P2 + 9;  exit;
       Found9:  Result := Len + P1 - P2 + 10; exit;
       Found10: Result := Len + P1 - P2 + 11; exit;
       Found11: Result := Len + P1 - P2 + 12; exit;
       Found12: Result := Len + P1 - P2 + 13; exit;
       Found13: Result := Len + P1 - P2 + 14; exit;
       Found14: Result := Len + P1 - P2 + 15; exit;
       Found15: Result := Len + P1 - P2 + 16; exit;

       Small:
         L2 := P2 - P1;

       case L2 of
         0:  goto Finish;
         1:  goto label1;
         2:  goto label2;
         3:  goto label3;
         4:  goto label4;
         5:  goto label5;
         6:  goto label6;
         7:  goto label7;
         8:  goto label8;
         9:  goto label9;
         10: goto label10;
         11: goto label11;
         12: goto label12;
         13: goto label13;
         14: goto label14;
         15: goto label15;
       end;

       label16: if Ch = P1^ then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0; exit;

       F0:  Result := Len;      exit;
       F1:  Result := Len - 1;  exit;
       F2:  Result := Len - 2;  exit;
       F3:  Result := Len - 3;  exit;
       F4:  Result := Len - 4;  exit;
       F5:  Result := Len - 5;  exit;
       F6:  Result := Len - 6;  exit;
       F7:  Result := Len - 7;  exit;
       F8:  Result := Len - 8;  exit;
       F9:  Result := Len - 9;  exit;
       F10: Result := Len - 10; exit;
       F11: Result := Len - 11; exit;
       F12: Result := Len - 12; exit;
       F13: Result := Len - 13; exit;
       F14: Result := Len - 14; exit;
       F15: Result := Len - 15; exit;

     end
   else
     Result := 0;
end;

function CharPos_CJG_Pas_5_b(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2    : Integer;
   P1, P2, P3 : PChar;
label Finish, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
   If Str='' then
   begin
     Result := 0;
     exit;
   end;
   Len := PInteger(Integer(Str)-4)^;
   if Len > 0 then
     begin
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                              this is only used as a reference}
       if (P1 < P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then Goto Found0;
               if Ch = p1[1]  then goto Found1;
               if Ch = p1[2]  then goto Found2;
               if Ch = p1[3]  then goto Found3;
               if Ch = p1[4]  then goto Found4;
               if Ch = p1[5]  then goto Found5;
               if Ch = p1[6]  then goto Found6;
               if Ch = p1[7]  then goto Found7;
               if Ch = p1[8]  then goto Found8;
               if Ch = p1[9]  then goto Found9;
               if Ch = p1[10] then goto Found10;
               if Ch = p1[11] then goto Found11;
               if Ch = p1[12] then goto Found12;
               if Ch = p1[13] then goto Found13;
               if Ch = p1[14] then goto Found14;
               if Ch = p1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then Goto Small;
             end;
        end
        else goto Small;

       Found0:  Result := Len + P1 - P2 + 1;  exit;
       Found1:  Result := Len + P1 - P2 + 2;  exit;
       Found2:  Result := Len + P1 - P2 + 3;  exit;
       Found3:  Result := Len + P1 - P2 + 4;  exit;
       Found4:  Result := Len + P1 - P2 + 5;  exit;
       Found5:  Result := Len + P1 - P2 + 6;  exit;
       Found6:  Result := Len + P1 - P2 + 7;  exit;
       Found7:  Result := Len + P1 - P2 + 8;  exit;
       Found8:  Result := Len + P1 - P2 + 9;  exit;
       Found9:  Result := Len + P1 - P2 + 10; exit;
       Found10: Result := Len + P1 - P2 + 11; exit;
       Found11: Result := Len + P1 - P2 + 12; exit;
       Found12: Result := Len + P1 - P2 + 13; exit;
       Found13: Result := Len + P1 - P2 + 14; exit;
       Found14: Result := Len + P1 - P2 + 15; exit;
       Found15: Result := Len + P1 - P2 + 16; exit;

       Small:
         L2 := P2 - P1;

       case L2 of
         0:  goto Finish;
         1:  goto label1;
         2:  goto label2;
         3:  goto label3;
         4:  goto label4;
         5:  goto label5;
         6:  goto label6;
         7:  goto label7;
         8:  goto label8;
         9:  goto label9;
         10: goto label10;
         11: goto label11;
         12: goto label12;
         13: goto label13;
         14: goto label14;
         15: goto label15;
       end;

       label16: if Ch = P1^ then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0; exit;

       F0:  Result := Len;      exit;
       F1:  Result := Len - 1;  exit;
       F2:  Result := Len - 2;  exit;
       F3:  Result := Len - 3;  exit;
       F4:  Result := Len - 4;  exit;
       F5:  Result := Len - 5;  exit;
       F6:  Result := Len - 6;  exit;
       F7:  Result := Len - 7;  exit;
       F8:  Result := Len - 8;  exit;
       F9:  Result := Len - 9;  exit;
       F10: Result := Len - 10; exit;
       F11: Result := Len - 11; exit;
       F12: Result := Len - 12; exit;
       F13: Result := Len - 13; exit;
       F14: Result := Len - 14; exit;
       F15: Result := Len - 15; exit;

     end
   else
     Result := 0;
end;

function CharPos_CJG_Pas_5_c(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2    : Integer;
   P1, P2, P3 : PChar;
label Finish, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
   If Str='' then
   begin
     Result := 0;
     exit;
   end;
   Len := PInteger(Integer(Str)-4)^;
   if Len > 0 then
     begin
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                              this is only used as a reference}
       if (P1 < P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then Goto Found0;
               if Ch = p1[1]  then goto Found1;
               if Ch = p1[2]  then goto Found2;
               if Ch = p1[3]  then goto Found3;
               if Ch = p1[4]  then goto Found4;
               if Ch = p1[5]  then goto Found5;
               if Ch = p1[6]  then goto Found6;
               if Ch = p1[7]  then goto Found7;
               if Ch = p1[8]  then goto Found8;
               if Ch = p1[9]  then goto Found9;
               if Ch = p1[10] then goto Found10;
               if Ch = p1[11] then goto Found11;
               if Ch = p1[12] then goto Found12;
               if Ch = p1[13] then goto Found13;
               if Ch = p1[14] then goto Found14;
               if Ch = p1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then Goto Small;
             end;
        end
        else goto Small;

       Found0:  Result := Len + P1 - P2 + 1;  exit;
       Found1:  Result := Len + P1 - P2 + 2;  exit;
       Found2:  Result := Len + P1 - P2 + 3;  exit;
       Found3:  Result := Len + P1 - P2 + 4;  exit;
       Found4:  Result := Len + P1 - P2 + 5;  exit;
       Found5:  Result := Len + P1 - P2 + 6;  exit;
       Found6:  Result := Len + P1 - P2 + 7;  exit;
       Found7:  Result := Len + P1 - P2 + 8;  exit;
       Found8:  Result := Len + P1 - P2 + 9;  exit;
       Found9:  Result := Len + P1 - P2 + 10; exit;
       Found10: Result := Len + P1 - P2 + 11; exit;
       Found11: Result := Len + P1 - P2 + 12; exit;
       Found12: Result := Len + P1 - P2 + 13; exit;
       Found13: Result := Len + P1 - P2 + 14; exit;
       Found14: Result := Len + P1 - P2 + 15; exit;
       Found15: Result := Len + P1 - P2 + 16; exit;

       Small:
         L2 := P2 - P1;

       case L2 of
         0:  goto Finish;
         1:  goto label1;
         2:  goto label2;
         3:  goto label3;
         4:  goto label4;
         5:  goto label5;
         6:  goto label6;
         7:  goto label7;
         8:  goto label8;
         9:  goto label9;
         10: goto label10;
         11: goto label11;
         12: goto label12;
         13: goto label13;
         14: goto label14;
         15: goto label15;
       end;

       label16: if Ch = P1^ then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0; exit;

       F0:  Result := Len;      exit;
       F1:  Result := Len - 1;  exit;
       F2:  Result := Len - 2;  exit;
       F3:  Result := Len - 3;  exit;
       F4:  Result := Len - 4;  exit;
       F5:  Result := Len - 5;  exit;
       F6:  Result := Len - 6;  exit;
       F7:  Result := Len - 7;  exit;
       F8:  Result := Len - 8;  exit;
       F9:  Result := Len - 9;  exit;
       F10: Result := Len - 10; exit;
       F11: Result := Len - 11; exit;
       F12: Result := Len - 12; exit;
       F13: Result := Len - 13; exit;
       F14: Result := Len - 14; exit;
       F15: Result := Len - 15; exit;

     end
   else
     Result := 0;
end;

function CharPos_CJG_Pas_5_d(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2    : Integer;
   P1, P2, P3 : PChar;
label Finish, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
   If Str='' then
   begin
     Result := 0;
     exit;
   end;
   Len := PInteger(Integer(Str)-4)^;
   if Len > 0 then
     begin
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                              this is only used as a reference}
       if (P1 < P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then Goto Found0;
               if Ch = p1[1]  then goto Found1;
               if Ch = p1[2]  then goto Found2;
               if Ch = p1[3]  then goto Found3;
               if Ch = p1[4]  then goto Found4;
               if Ch = p1[5]  then goto Found5;
               if Ch = p1[6]  then goto Found6;
               if Ch = p1[7]  then goto Found7;
               if Ch = p1[8]  then goto Found8;
               if Ch = p1[9]  then goto Found9;
               if Ch = p1[10] then goto Found10;
               if Ch = p1[11] then goto Found11;
               if Ch = p1[12] then goto Found12;
               if Ch = p1[13] then goto Found13;
               if Ch = p1[14] then goto Found14;
               if Ch = p1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then Goto Small;
             end;
        end
        else goto Small;

       Found0:  Result := Len + P1 - P2 + 1;  exit;
       Found1:  Result := Len + P1 - P2 + 2;  exit;
       Found2:  Result := Len + P1 - P2 + 3;  exit;
       Found3:  Result := Len + P1 - P2 + 4;  exit;
       Found4:  Result := Len + P1 - P2 + 5;  exit;
       Found5:  Result := Len + P1 - P2 + 6;  exit;
       Found6:  Result := Len + P1 - P2 + 7;  exit;
       Found7:  Result := Len + P1 - P2 + 8;  exit;
       Found8:  Result := Len + P1 - P2 + 9;  exit;
       Found9:  Result := Len + P1 - P2 + 10; exit;
       Found10: Result := Len + P1 - P2 + 11; exit;
       Found11: Result := Len + P1 - P2 + 12; exit;
       Found12: Result := Len + P1 - P2 + 13; exit;
       Found13: Result := Len + P1 - P2 + 14; exit;
       Found14: Result := Len + P1 - P2 + 15; exit;
       Found15: Result := Len + P1 - P2 + 16; exit;

       Small:
         L2 := P2 - P1;

       case L2 of
         0:  goto Finish;
         1:  goto label1;
         2:  goto label2;
         3:  goto label3;
         4:  goto label4;
         5:  goto label5;
         6:  goto label6;
         7:  goto label7;
         8:  goto label8;
         9:  goto label9;
         10: goto label10;
         11: goto label11;
         12: goto label12;
         13: goto label13;
         14: goto label14;
         15: goto label15;
       end;

       label16: if Ch = P1^ then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0; exit;

       F0:  Result := Len;      exit;
       F1:  Result := Len - 1;  exit;
       F2:  Result := Len - 2;  exit;
       F3:  Result := Len - 3;  exit;
       F4:  Result := Len - 4;  exit;
       F5:  Result := Len - 5;  exit;
       F6:  Result := Len - 6;  exit;
       F7:  Result := Len - 7;  exit;
       F8:  Result := Len - 8;  exit;
       F9:  Result := Len - 9;  exit;
       F10: Result := Len - 10; exit;
       F11: Result := Len - 11; exit;
       F12: Result := Len - 12; exit;
       F13: Result := Len - 13; exit;
       F14: Result := Len - 14; exit;
       F15: Result := Len - 15; exit;

     end
   else
     Result := 0;
end;

function CharPos_CJG_Pas_6_a(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2 : Integer;
   P1, P2, P3 : PChar;
label Finish, Looper, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
  If Str='' then
    begin
      Result := 0;
      exit;
    end
   else
     begin
       Len := PInteger(Integer(Str)-4)^;
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                              this is only used as a reference}
       if (P1 <= P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then goto Found0;
               if Ch = p1[1]  then goto Found1;
               if Ch = p1[2]  then goto Found2;
               if Ch = p1[3]  then goto Found3;
               if Ch = p1[4]  then goto Found4;
               if Ch = p1[5]  then goto Found5;
               if Ch = p1[6]  then goto Found6;
               if Ch = p1[7]  then goto Found7;
               if Ch = p1[8]  then goto Found8;
               if Ch = p1[9]  then goto Found9;
               if Ch = p1[10] then goto Found10;
               if Ch = p1[11] then goto Found11;
               if Ch = p1[12] then goto Found12;
               if Ch = p1[13] then goto Found13;
               if Ch = p1[14] then goto Found14;
               if Ch = p1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then goto Small;
             end;
         end
         else goto Small;

       Found15: Result := Len + P1 - P2 + 16; exit;
       Found14: Result := Len + P1 - P2 + 15; exit;
       Found13: Result := Len + P1 - P2 + 14; exit;
       Found12: Result := Len + P1 - P2 + 13; exit;
       Found11: Result := Len + P1 - P2 + 12; exit;
       Found10: Result := Len + P1 - P2 + 11; exit;
       Found9:  Result := Len + P1 - P2 + 10; exit;
       Found8:  Result := Len + P1 - P2 + 9;  exit;
       Found7:  Result := Len + P1 - P2 + 8;  exit;
       Found6:  Result := Len + P1 - P2 + 7;  exit;
       Found5:  Result := Len + P1 - P2 + 6;  exit;
       Found4:  Result := Len + P1 - P2 + 5;  exit;
       Found3:  Result := Len + P1 - P2 + 4;  exit;
       Found2:  Result := Len + P1 - P2 + 3;  exit;
       Found1:  Result := Len + P1 - P2 + 2;  exit;
       Found0:  Result := Len + P1 - P2 + 1;  exit;

       Small:
         L2 := P2 - P1;

         case L2 of
           0:  goto Finish;
           1:  goto label1;
           2:  goto label2;
           3:  goto label3;
           4:  goto label4;
           5:  goto label5;
           6:  goto label6;
           7:  goto label7;
           8:  goto label8;
           9:  goto label9;
           10: goto label10;
           11: goto label11;
           12: goto label12;
           13: goto label13;
           14: goto label14;
           15: goto label15;
         end;

       label16: if Ch = P1^ then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0;        exit;

       F0:      Result := Len;      exit;
       F1:      Result := Len - 1;  exit;
       F2:      Result := Len - 2;  exit;
       F3:      Result := Len - 3;  exit;
       F4:      Result := Len - 4;  exit;
       F5:      Result := Len - 5;  exit;
       F6:      Result := Len - 6;  exit;
       F7:      Result := Len - 7;  exit;
       F8:      Result := Len - 8;  exit;
       F9:      Result := Len - 9;  exit;
       F10:     Result := Len - 10; exit;
       F11:     Result := Len - 11; exit;
       F12:     Result := Len - 12; exit;
       F13:     Result := Len - 13; exit;
       F14:     Result := Len - 14; exit;
       F15:     Result := Len - 15; exit;
     end;
end;

function CharPos_CJG_Pas_6_b(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2 : Integer;
   P1, P2, P3 : PChar;
label Finish, Looper, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
  If Str='' then
    begin
      Result := 0;
      exit;
    end
   else
     begin
       Len := PInteger(Integer(Str)-4)^;
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                              this is only used as a reference}
       if (P1 <= P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then goto Found0;
               if Ch = p1[1]  then goto Found1;
               if Ch = p1[2]  then goto Found2;
               if Ch = p1[3]  then goto Found3;
               if Ch = p1[4]  then goto Found4;
               if Ch = p1[5]  then goto Found5;
               if Ch = p1[6]  then goto Found6;
               if Ch = p1[7]  then goto Found7;
               if Ch = p1[8]  then goto Found8;
               if Ch = p1[9]  then goto Found9;
               if Ch = p1[10] then goto Found10;
               if Ch = p1[11] then goto Found11;
               if Ch = p1[12] then goto Found12;
               if Ch = p1[13] then goto Found13;
               if Ch = p1[14] then goto Found14;
               if Ch = p1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then goto Small;
             end;
         end
         else goto Small;

       Found15: Result := Len + P1 - P2 + 16; exit;
       Found14: Result := Len + P1 - P2 + 15; exit;
       Found13: Result := Len + P1 - P2 + 14; exit;
       Found12: Result := Len + P1 - P2 + 13; exit;
       Found11: Result := Len + P1 - P2 + 12; exit;
       Found10: Result := Len + P1 - P2 + 11; exit;
       Found9:  Result := Len + P1 - P2 + 10; exit;
       Found8:  Result := Len + P1 - P2 + 9;  exit;
       Found7:  Result := Len + P1 - P2 + 8;  exit;
       Found6:  Result := Len + P1 - P2 + 7;  exit;
       Found5:  Result := Len + P1 - P2 + 6;  exit;
       Found4:  Result := Len + P1 - P2 + 5;  exit;
       Found3:  Result := Len + P1 - P2 + 4;  exit;
       Found2:  Result := Len + P1 - P2 + 3;  exit;
       Found1:  Result := Len + P1 - P2 + 2;  exit;
       Found0:  Result := Len + P1 - P2 + 1;  exit;

       Small:
         L2 := P2 - P1;

         case L2 of
           0:  goto Finish;
           1:  goto label1;
           2:  goto label2;
           3:  goto label3;
           4:  goto label4;
           5:  goto label5;
           6:  goto label6;
           7:  goto label7;
           8:  goto label8;
           9:  goto label9;
           10: goto label10;
           11: goto label11;
           12: goto label12;
           13: goto label13;
           14: goto label14;
           15: goto label15;
         end;

       label16: if Ch = P1^ then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0;        exit;

       F0:      Result := Len;      exit;
       F1:      Result := Len - 1;  exit;
       F2:      Result := Len - 2;  exit;
       F3:      Result := Len - 3;  exit;
       F4:      Result := Len - 4;  exit;
       F5:      Result := Len - 5;  exit;
       F6:      Result := Len - 6;  exit;
       F7:      Result := Len - 7;  exit;
       F8:      Result := Len - 8;  exit;
       F9:      Result := Len - 9;  exit;
       F10:     Result := Len - 10; exit;
       F11:     Result := Len - 11; exit;
       F12:     Result := Len - 12; exit;
       F13:     Result := Len - 13; exit;
       F14:     Result := Len - 14; exit;
       F15:     Result := Len - 15; exit;
     end;
end;

function CharPos_CJG_Pas_6_c(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2 : Integer;
   P1, P2, P3 : PChar;
label Finish, Looper, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
  If Str='' then
    begin
      Result := 0;
      exit;
    end
   else
     begin
       Len := PInteger(Integer(Str)-4)^;
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                              this is only used as a reference}
       if (P1 <= P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then goto Found0;
               if Ch = p1[1]  then goto Found1;
               if Ch = p1[2]  then goto Found2;
               if Ch = p1[3]  then goto Found3;
               if Ch = p1[4]  then goto Found4;
               if Ch = p1[5]  then goto Found5;
               if Ch = p1[6]  then goto Found6;
               if Ch = p1[7]  then goto Found7;
               if Ch = p1[8]  then goto Found8;
               if Ch = p1[9]  then goto Found9;
               if Ch = p1[10] then goto Found10;
               if Ch = p1[11] then goto Found11;
               if Ch = p1[12] then goto Found12;
               if Ch = p1[13] then goto Found13;
               if Ch = p1[14] then goto Found14;
               if Ch = p1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then goto Small;
             end;
         end
         else goto Small;

       Found15: Result := Len + P1 - P2 + 16; exit;
       Found14: Result := Len + P1 - P2 + 15; exit;
       Found13: Result := Len + P1 - P2 + 14; exit;
       Found12: Result := Len + P1 - P2 + 13; exit;
       Found11: Result := Len + P1 - P2 + 12; exit;
       Found10: Result := Len + P1 - P2 + 11; exit;
       Found9:  Result := Len + P1 - P2 + 10; exit;
       Found8:  Result := Len + P1 - P2 + 9;  exit;
       Found7:  Result := Len + P1 - P2 + 8;  exit;
       Found6:  Result := Len + P1 - P2 + 7;  exit;
       Found5:  Result := Len + P1 - P2 + 6;  exit;
       Found4:  Result := Len + P1 - P2 + 5;  exit;
       Found3:  Result := Len + P1 - P2 + 4;  exit;
       Found2:  Result := Len + P1 - P2 + 3;  exit;
       Found1:  Result := Len + P1 - P2 + 2;  exit;
       Found0:  Result := Len + P1 - P2 + 1;  exit;

       Small:
         L2 := P2 - P1;

         case L2 of
           0:  goto Finish;
           1:  goto label1;
           2:  goto label2;
           3:  goto label3;
           4:  goto label4;
           5:  goto label5;
           6:  goto label6;
           7:  goto label7;
           8:  goto label8;
           9:  goto label9;
           10: goto label10;
           11: goto label11;
           12: goto label12;
           13: goto label13;
           14: goto label14;
           15: goto label15;
         end;

       label16: if Ch = P1^ then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0;        exit;

       F0:      Result := Len;      exit;
       F1:      Result := Len - 1;  exit;
       F2:      Result := Len - 2;  exit;
       F3:      Result := Len - 3;  exit;
       F4:      Result := Len - 4;  exit;
       F5:      Result := Len - 5;  exit;
       F6:      Result := Len - 6;  exit;
       F7:      Result := Len - 7;  exit;
       F8:      Result := Len - 8;  exit;
       F9:      Result := Len - 9;  exit;
       F10:     Result := Len - 10; exit;
       F11:     Result := Len - 11; exit;
       F12:     Result := Len - 12; exit;
       F13:     Result := Len - 13; exit;
       F14:     Result := Len - 14; exit;
       F15:     Result := Len - 15; exit;
     end;
end;

function CharPos_CJG_Pas_6_d(Ch : Char; const Str : AnsiString) : Integer;
var
   Len, L2 : Integer;
   P1, P2, P3 : PChar;
label Finish, Looper, Small;
label label1, label2, label3, label4, label5, label6, label7, label8,
label9, label10, label11, label12, label13, label14, label15, label16;
label Found0, Found1, Found2, Found3, Found4, Found5, Found6, Found7,
Found8, Found9, Found10, Found11, Found12, Found13, Found14, Found15,
Found16;
label F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14,
F15, F16;
begin
  If Str='' then
    begin
      Result := 0;
      exit;
    end
   else
     begin
       Len := PInteger(Integer(Str)-4)^;
       P1 := Pointer(Str);   {Point to start of string}
       P2 := P1 + Len;       {Point to end of string}
       P3 := P2 - 16;        {Point to one sweep before end of string
                              this is only used as a reference}
       if (P1 <= P3) then
         begin
           while 1 = 1 do
             begin
               if Ch = P1^    then goto Found0;
               if Ch = p1[1]  then goto Found1;
               if Ch = p1[2]  then goto Found2;
               if Ch = p1[3]  then goto Found3;
               if Ch = p1[4]  then goto Found4;
               if Ch = p1[5]  then goto Found5;
               if Ch = p1[6]  then goto Found6;
               if Ch = p1[7]  then goto Found7;
               if Ch = p1[8]  then goto Found8;
               if Ch = p1[9]  then goto Found9;
               if Ch = p1[10] then goto Found10;
               if Ch = p1[11] then goto Found11;
               if Ch = p1[12] then goto Found12;
               if Ch = p1[13] then goto Found13;
               if Ch = p1[14] then goto Found14;
               if Ch = p1[15] then goto Found15;

               Inc(P1, 16);
               if P1 > P3 then goto Small;
             end;
         end
         else goto Small;

       Found15: Result := Len + P1 - P2 + 16; exit;
       Found14: Result := Len + P1 - P2 + 15; exit;
       Found13: Result := Len + P1 - P2 + 14; exit;
       Found12: Result := Len + P1 - P2 + 13; exit;
       Found11: Result := Len + P1 - P2 + 12; exit;
       Found10: Result := Len + P1 - P2 + 11; exit;
       Found9:  Result := Len + P1 - P2 + 10; exit;
       Found8:  Result := Len + P1 - P2 + 9;  exit;
       Found7:  Result := Len + P1 - P2 + 8;  exit;
       Found6:  Result := Len + P1 - P2 + 7;  exit;
       Found5:  Result := Len + P1 - P2 + 6;  exit;
       Found4:  Result := Len + P1 - P2 + 5;  exit;
       Found3:  Result := Len + P1 - P2 + 4;  exit;
       Found2:  Result := Len + P1 - P2 + 3;  exit;
       Found1:  Result := Len + P1 - P2 + 2;  exit;
       Found0:  Result := Len + P1 - P2 + 1;  exit;

       Small:
         L2 := P2 - P1;

         case L2 of
           0:  goto Finish;
           1:  goto label1;
           2:  goto label2;
           3:  goto label3;
           4:  goto label4;
           5:  goto label5;
           6:  goto label6;
           7:  goto label7;
           8:  goto label8;
           9:  goto label9;
           10: goto label10;
           11: goto label11;
           12: goto label12;
           13: goto label13;
           14: goto label14;
           15: goto label15;
         end;

       label16: if Ch = P1^ then goto F15;
       label15: if Ch = P1[L2-15] then goto F14;
       label14: if Ch = P1[L2-14] then goto F13;
       label13: if Ch = P1[L2-13] then goto F12;
       label12: if Ch = P1[L2-12] then goto F11;
       label11: if Ch = P1[L2-11] then goto F10;
       label10: if Ch = P1[L2-10] then goto F9;
       label9:  if Ch = P1[L2-9]  then goto F8;
       label8:  if Ch = P1[L2-8]  then goto F7;
       label7:  if Ch = P1[L2-7]  then goto F6;
       label6:  if Ch = P1[L2-6]  then goto F5;
       label5:  if Ch = P1[L2-5]  then goto F4;
       label4:  if Ch = P1[L2-4]  then goto F3;
       label3:  if Ch = P1[L2-3]  then goto F2;
       label2:  if Ch = P1[L2-2]  then goto F1;
       label1:  if Ch = P1[L2-1]  then goto F0;

       Finish:  Result := 0;        exit;

       F0:      Result := Len;      exit;
       F1:      Result := Len - 1;  exit;
       F2:      Result := Len - 2;  exit;
       F3:      Result := Len - 3;  exit;
       F4:      Result := Len - 4;  exit;
       F5:      Result := Len - 5;  exit;
       F6:      Result := Len - 6;  exit;
       F7:      Result := Len - 7;  exit;
       F8:      Result := Len - 8;  exit;
       F9:      Result := Len - 9;  exit;
       F10:     Result := Len - 10; exit;
       F11:     Result := Len - 11; exit;
       F12:     Result := Len - 12; exit;
       F13:     Result := Len - 13; exit;
       F14:     Result := Len - 14; exit;
       F15:     Result := Len - 15; exit;
     end;
end;

function CharPos_CJG_Pas_7_a(Ch : Char; const Str : AnsiString) : Integer;
var
   L0, L1 : Integer;
   PC, PD : PChar;
label NoAlignment, Ender;
label F0,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16;
label    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16;
begin
  If Str='' then
    begin
Ender:Result := 0;
      exit;
    end
  else
    begin
      L0 := PInteger(Integer(Str)-4)^; {Get The Length of the String}
      PC := Pointer(Str);              {Point to start of string}
      PD := PC + L0;
      L1 := L0 and 15;
      Inc(PC,L1);
      case L1 of
        0:  goto NoAlignment;
        1:  goto P1;
        2:  goto P2;
        3:  goto P3;
        4:  goto P4;
        5:  goto P5;
        6:  goto P6;
        7:  goto P7;
        8:  goto P8;
        9:  goto P9;
        10: goto P10;
        11: goto P11;
        12: goto P12;
        13: goto P13;
        14: goto P14;
        15: goto P15;
      end;

      NoAlignment:
        If L0 = 0 then goto Ender;
        Inc(PC,16);

        P16: if Ch = PC[-16] then goto F16;
        P15: if Ch = PC[-15] then goto F15;
        P14: if Ch = PC[-14] then goto F14;
        P13: if Ch = PC[-13] then goto F13;
        P12: if Ch = PC[-12] then goto F12;
        P11: if Ch = PC[-11] then goto F11;
        P10: if Ch = PC[-10] then goto F10;
        P9:  if Ch = PC[-9]  then goto F9;
        P8:  if Ch = PC[-8]  then goto F8;
        P7:  if Ch = PC[-7]  then goto F7;
        P6:  if Ch = PC[-6]  then goto F6;
        P5:  if Ch = PC[-5]  then goto F5;
        P4:  if Ch = PC[-4]  then goto F4;
        P3:  if Ch = PC[-3]  then goto F3;
        P2:  if Ch = PC[-2]  then goto F2;
        P1:  if Ch = PC[-1]  then goto F1;

        Inc(PC,16);
        if PC <= PD then goto P16;
        Result := 0; exit;

        F16: Result := PC - 15 - Pointer(Str); exit;
        F15: Result := PC - 14 - Pointer(Str); exit;
        F14: Result := PC - 13 - Pointer(Str); exit;
        F13: Result := PC - 12 - Pointer(Str); exit;
        F12: Result := PC - 11 - Pointer(Str); exit;
        F11: Result := PC - 10 - Pointer(Str); exit;
        F10: Result := PC - 9  - Pointer(Str); exit;
        F9:  Result := PC - 8  - Pointer(Str); exit;
        F8:  Result := PC - 7  - Pointer(Str); exit;
        F7:  Result := PC - 6  - Pointer(Str); exit;
        F6:  Result := PC - 5  - Pointer(Str); exit;
        F5:  Result := PC - 4  - Pointer(Str); exit;
        F4:  Result := PC - 3  - Pointer(Str); exit;
        F3:  Result := PC - 2  - Pointer(Str); exit;
        F2:  Result := PC - 1  - Pointer(Str); exit;
        F1:  Result := PC - Pointer(Str);
  end;
end;

function CharPos_CJG_Pas_7_b(Ch : Char; const Str : AnsiString) : Integer;
var
   L0, L1 : Integer;
   PC, PD : PChar;
label NoAlignment, Ender;
label F0,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16;
label    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16;
begin
  If Str='' then
    begin
Ender:Result := 0;
      exit;
    end
  else
    begin
      L0 := PInteger(Integer(Str)-4)^; {Get The Length of the String}
      PC := Pointer(Str);              {Point to start of string}
      PD := PC + L0;
      L1 := L0 and 15;
      Inc(PC,L1);
      case L1 of
        0:  goto NoAlignment;
        1:  goto P1;
        2:  goto P2;
        3:  goto P3;
        4:  goto P4;
        5:  goto P5;
        6:  goto P6;
        7:  goto P7;
        8:  goto P8;
        9:  goto P9;
        10: goto P10;
        11: goto P11;
        12: goto P12;
        13: goto P13;
        14: goto P14;
        15: goto P15;
      end;

      NoAlignment:
        If L0 = 0 then goto Ender;
        Inc(PC,16);

        P16: if Ch = PC[-16] then goto F16;
        P15: if Ch = PC[-15] then goto F15;
        P14: if Ch = PC[-14] then goto F14;
        P13: if Ch = PC[-13] then goto F13;
        P12: if Ch = PC[-12] then goto F12;
        P11: if Ch = PC[-11] then goto F11;
        P10: if Ch = PC[-10] then goto F10;
        P9:  if Ch = PC[-9]  then goto F9;
        P8:  if Ch = PC[-8]  then goto F8;
        P7:  if Ch = PC[-7]  then goto F7;
        P6:  if Ch = PC[-6]  then goto F6;
        P5:  if Ch = PC[-5]  then goto F5;
        P4:  if Ch = PC[-4]  then goto F4;
        P3:  if Ch = PC[-3]  then goto F3;
        P2:  if Ch = PC[-2]  then goto F2;
        P1:  if Ch = PC[-1]  then goto F1;

        Inc(PC,16);
        if PC <= PD then goto P16;
        Result := 0; exit;

        F16: Result := PC - 15 - Pointer(Str); exit;
        F15: Result := PC - 14 - Pointer(Str); exit;
        F14: Result := PC - 13 - Pointer(Str); exit;
        F13: Result := PC - 12 - Pointer(Str); exit;
        F12: Result := PC - 11 - Pointer(Str); exit;
        F11: Result := PC - 10 - Pointer(Str); exit;
        F10: Result := PC - 9  - Pointer(Str); exit;
        F9:  Result := PC - 8  - Pointer(Str); exit;
        F8:  Result := PC - 7  - Pointer(Str); exit;
        F7:  Result := PC - 6  - Pointer(Str); exit;
        F6:  Result := PC - 5  - Pointer(Str); exit;
        F5:  Result := PC - 4  - Pointer(Str); exit;
        F4:  Result := PC - 3  - Pointer(Str); exit;
        F3:  Result := PC - 2  - Pointer(Str); exit;
        F2:  Result := PC - 1  - Pointer(Str); exit;
        F1:  Result := PC - Pointer(Str);
  end;
end;

function CharPos_CJG_Pas_7_c(Ch : Char; const Str : AnsiString) : Integer;
var
   L0, L1 : Integer;
   PC, PD : PChar;
label NoAlignment, Ender;
label F0,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16;
label    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16;
begin
  If Str='' then
    begin
Ender:Result := 0;
      exit;
    end
  else
    begin
      L0 := PInteger(Integer(Str)-4)^; {Get The Length of the String}
      PC := Pointer(Str);              {Point to start of string}
      PD := PC + L0;
      L1 := L0 and 15;
      Inc(PC,L1);
      case L1 of
        0:  goto NoAlignment;
        1:  goto P1;
        2:  goto P2;
        3:  goto P3;
        4:  goto P4;
        5:  goto P5;
        6:  goto P6;
        7:  goto P7;
        8:  goto P8;
        9:  goto P9;
        10: goto P10;
        11: goto P11;
        12: goto P12;
        13: goto P13;
        14: goto P14;
        15: goto P15;
      end;

      NoAlignment:
        If L0 = 0 then goto Ender;
        Inc(PC,16);

        P16: if Ch = PC[-16] then goto F16;
        P15: if Ch = PC[-15] then goto F15;
        P14: if Ch = PC[-14] then goto F14;
        P13: if Ch = PC[-13] then goto F13;
        P12: if Ch = PC[-12] then goto F12;
        P11: if Ch = PC[-11] then goto F11;
        P10: if Ch = PC[-10] then goto F10;
        P9:  if Ch = PC[-9]  then goto F9;
        P8:  if Ch = PC[-8]  then goto F8;
        P7:  if Ch = PC[-7]  then goto F7;
        P6:  if Ch = PC[-6]  then goto F6;
        P5:  if Ch = PC[-5]  then goto F5;
        P4:  if Ch = PC[-4]  then goto F4;
        P3:  if Ch = PC[-3]  then goto F3;
        P2:  if Ch = PC[-2]  then goto F2;
        P1:  if Ch = PC[-1]  then goto F1;

        Inc(PC,16);
        if PC <= PD then goto P16;
        Result := 0; exit;

        F16: Result := PC - 15 - Pointer(Str); exit;
        F15: Result := PC - 14 - Pointer(Str); exit;
        F14: Result := PC - 13 - Pointer(Str); exit;
        F13: Result := PC - 12 - Pointer(Str); exit;
        F12: Result := PC - 11 - Pointer(Str); exit;
        F11: Result := PC - 10 - Pointer(Str); exit;
        F10: Result := PC - 9  - Pointer(Str); exit;
        F9:  Result := PC - 8  - Pointer(Str); exit;
        F8:  Result := PC - 7  - Pointer(Str); exit;
        F7:  Result := PC - 6  - Pointer(Str); exit;
        F6:  Result := PC - 5  - Pointer(Str); exit;
        F5:  Result := PC - 4  - Pointer(Str); exit;
        F4:  Result := PC - 3  - Pointer(Str); exit;
        F3:  Result := PC - 2  - Pointer(Str); exit;
        F2:  Result := PC - 1  - Pointer(Str); exit;
        F1:  Result := PC - Pointer(Str);
  end;
end;

function CharPos_CJG_Pas_7_d(Ch : Char; const Str : AnsiString) : Integer;
var
   L0, L1 : Integer;
   PC, PD : PChar;
label NoAlignment, Ender;
label F0,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16;
label    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16;
begin
  If Str='' then
    begin
Ender:Result := 0;
      exit;
    end
  else
    begin
      L0 := PInteger(Integer(Str)-4)^; {Get The Length of the String}
      PC := Pointer(Str);              {Point to start of string}
      PD := PC + L0;
      L1 := L0 and 15;
      Inc(PC,L1);
      case L1 of
        0:  goto NoAlignment;
        1:  goto P1;
        2:  goto P2;
        3:  goto P3;
        4:  goto P4;
        5:  goto P5;
        6:  goto P6;
        7:  goto P7;
        8:  goto P8;
        9:  goto P9;
        10: goto P10;
        11: goto P11;
        12: goto P12;
        13: goto P13;
        14: goto P14;
        15: goto P15;
      end;

      NoAlignment:
        If L0 = 0 then goto Ender;
        Inc(PC,16);

        P16: if Ch = PC[-16] then goto F16;
        P15: if Ch = PC[-15] then goto F15;
        P14: if Ch = PC[-14] then goto F14;
        P13: if Ch = PC[-13] then goto F13;
        P12: if Ch = PC[-12] then goto F12;
        P11: if Ch = PC[-11] then goto F11;
        P10: if Ch = PC[-10] then goto F10;
        P9:  if Ch = PC[-9]  then goto F9;
        P8:  if Ch = PC[-8]  then goto F8;
        P7:  if Ch = PC[-7]  then goto F7;
        P6:  if Ch = PC[-6]  then goto F6;
        P5:  if Ch = PC[-5]  then goto F5;
        P4:  if Ch = PC[-4]  then goto F4;
        P3:  if Ch = PC[-3]  then goto F3;
        P2:  if Ch = PC[-2]  then goto F2;
        P1:  if Ch = PC[-1]  then goto F1;

        Inc(PC,16);
        if PC <= PD then goto P16;
        Result := 0; exit;

        F16: Result := PC - 15 - Pointer(Str); exit;
        F15: Result := PC - 14 - Pointer(Str); exit;
        F14: Result := PC - 13 - Pointer(Str); exit;
        F13: Result := PC - 12 - Pointer(Str); exit;
        F12: Result := PC - 11 - Pointer(Str); exit;
        F11: Result := PC - 10 - Pointer(Str); exit;
        F10: Result := PC - 9  - Pointer(Str); exit;
        F9:  Result := PC - 8  - Pointer(Str); exit;
        F8:  Result := PC - 7  - Pointer(Str); exit;
        F7:  Result := PC - 6  - Pointer(Str); exit;
        F6:  Result := PC - 5  - Pointer(Str); exit;
        F5:  Result := PC - 4  - Pointer(Str); exit;
        F4:  Result := PC - 3  - Pointer(Str); exit;
        F3:  Result := PC - 2  - Pointer(Str); exit;
        F2:  Result := PC - 1  - Pointer(Str); exit;
        F1:  Result := PC - Pointer(Str);
  end;
end;

function CharPos_CJG_Pas_9_a(Ch : Char; const Str : AnsiString) : Integer;
var
   L0 : Integer;
label NoAlignment, Ender;
label       F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16;
label    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16;
begin
  If Str<>'' then
  begin
    L0 := PInteger(Integer(Str)-4)^; {Get The Length of the String}
    Result := L0 and 15;
    case Result of
      0:  goto NoAlignment;
      1:  goto P1;
      2:  goto P2;
      3:  goto P3;
      4:  goto P4;
      5:  goto P5;
      6:  goto P6;
      7:  goto P7;
      8:  goto P8;
      9:  goto P9;
      10: goto P10;
      11: goto P11;
      12: goto P12;
      13: goto P13;
      14: goto P14;
      15: goto P15;
    end;

    NoAlignment:
      If L0 = 0 then goto Ender;
      Inc(Result,16);

      P16: if Ch = PChar(Pointer(Str))[Result - 16] then goto F16;
      P15: if Ch = PChar(Pointer(Str))[Result - 15] then goto F15;
      P14: if Ch = PChar(Pointer(Str))[Result - 14] then goto F14;
      P13: if Ch = PChar(Pointer(Str))[Result - 13] then goto F13;
      P12: if Ch = PChar(Pointer(Str))[Result - 12] then goto F12;
      P11: if Ch = PChar(Pointer(Str))[Result - 11] then goto F11;
      P10: if Ch = PChar(Pointer(Str))[Result - 10] then goto F10;
      P9:  if Ch = PChar(Pointer(Str))[Result - 9]  then goto F9;
      P8:  if Ch = PChar(Pointer(Str))[Result - 8]  then goto F8;
      P7:  if Ch = PChar(Pointer(Str))[Result - 7]  then goto F7;
      P6:  if Ch = PChar(Pointer(Str))[Result - 6]  then goto F6;
      P5:  if Ch = PChar(Pointer(Str))[Result - 5]  then goto F5;
      P4:  if Ch = PChar(Pointer(Str))[Result - 4]  then goto F4;
      P3:  if Ch = PChar(Pointer(Str))[Result - 3]  then goto F3;
      P2:  if Ch = PChar(Pointer(Str))[Result - 2]  then goto F2;
      P1:  if Ch = PChar(Pointer(Str))[Result - 1]  then exit;

      Inc(Result,16);
      if Result <= L0 then goto P16;
      Result := 0; exit;

      F16: Dec(Result,15); exit;
      F15: Dec(Result,14); exit;
      F14: Dec(Result,13); exit;
      F13: Dec(Result,12); exit;
      F12: Dec(Result,11); exit;
      F11: Dec(Result,10); exit;
      F10: Dec(Result,9 ); exit;
      F9:  Dec(Result,8 ); exit;
      F8:  Dec(Result,7 ); exit;
      F7:  Dec(Result,6 ); exit;
      F6:  Dec(Result,5 ); exit;
      F5:  Dec(Result,4 ); exit;
      F4:  Dec(Result,3 ); exit;
      F3:  Dec(Result,2 ); exit;
      F2:  Dec(Result,1 ); exit;
  end
  else
Ender:Result := 0;
end;

function CharPos_CJG_Pas_9_b(Ch : Char; const Str : AnsiString) : Integer;
var
   L0 : Integer;
label NoAlignment, Ender;
label       F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16;
label    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16;
begin
  If Str<>'' then
  begin
    L0 := PInteger(Integer(Str)-4)^; {Get The Length of the String}
    Result := L0 and 15;
    case Result of
      0:  goto NoAlignment;
      1:  goto P1;
      2:  goto P2;
      3:  goto P3;
      4:  goto P4;
      5:  goto P5;
      6:  goto P6;
      7:  goto P7;
      8:  goto P8;
      9:  goto P9;
      10: goto P10;
      11: goto P11;
      12: goto P12;
      13: goto P13;
      14: goto P14;
      15: goto P15;
    end;

    NoAlignment:
      If L0 = 0 then goto Ender;
      Inc(Result,16);

      P16: if Ch = PChar(Pointer(Str))[Result - 16] then goto F16;
      P15: if Ch = PChar(Pointer(Str))[Result - 15] then goto F15;
      P14: if Ch = PChar(Pointer(Str))[Result - 14] then goto F14;
      P13: if Ch = PChar(Pointer(Str))[Result - 13] then goto F13;
      P12: if Ch = PChar(Pointer(Str))[Result - 12] then goto F12;
      P11: if Ch = PChar(Pointer(Str))[Result - 11] then goto F11;
      P10: if Ch = PChar(Pointer(Str))[Result - 10] then goto F10;
      P9:  if Ch = PChar(Pointer(Str))[Result - 9]  then goto F9;
      P8:  if Ch = PChar(Pointer(Str))[Result - 8]  then goto F8;
      P7:  if Ch = PChar(Pointer(Str))[Result - 7]  then goto F7;
      P6:  if Ch = PChar(Pointer(Str))[Result - 6]  then goto F6;
      P5:  if Ch = PChar(Pointer(Str))[Result - 5]  then goto F5;
      P4:  if Ch = PChar(Pointer(Str))[Result - 4]  then goto F4;
      P3:  if Ch = PChar(Pointer(Str))[Result - 3]  then goto F3;
      P2:  if Ch = PChar(Pointer(Str))[Result - 2]  then goto F2;
      P1:  if Ch = PChar(Pointer(Str))[Result - 1]  then exit;

      Inc(Result,16);
      if Result <= L0 then goto P16;
      Result := 0; exit;

      F16: Dec(Result,15); exit;
      F15: Dec(Result,14); exit;
      F14: Dec(Result,13); exit;
      F13: Dec(Result,12); exit;
      F12: Dec(Result,11); exit;
      F11: Dec(Result,10); exit;
      F10: Dec(Result,9 ); exit;
      F9:  Dec(Result,8 ); exit;
      F8:  Dec(Result,7 ); exit;
      F7:  Dec(Result,6 ); exit;
      F6:  Dec(Result,5 ); exit;
      F5:  Dec(Result,4 ); exit;
      F4:  Dec(Result,3 ); exit;
      F3:  Dec(Result,2 ); exit;
      F2:  Dec(Result,1 ); exit;
  end
  else
Ender:Result := 0;
end;

function CharPos_CJG_Pas_9_c(Ch : Char; const Str : AnsiString) : Integer;
var
   L0 : Integer;
label NoAlignment, Ender;
label       F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16;
label    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16;
begin
  If Str<>'' then
  begin
    L0 := PInteger(Integer(Str)-4)^; {Get The Length of the String}
    Result := L0 and 15;
    case Result of
      0:  goto NoAlignment;
      1:  goto P1;
      2:  goto P2;
      3:  goto P3;
      4:  goto P4;
      5:  goto P5;
      6:  goto P6;
      7:  goto P7;
      8:  goto P8;
      9:  goto P9;
      10: goto P10;
      11: goto P11;
      12: goto P12;
      13: goto P13;
      14: goto P14;
      15: goto P15;
    end;

    NoAlignment:
      If L0 = 0 then goto Ender;
      Inc(Result,16);

      P16: if Ch = PChar(Pointer(Str))[Result - 16] then goto F16;
      P15: if Ch = PChar(Pointer(Str))[Result - 15] then goto F15;
      P14: if Ch = PChar(Pointer(Str))[Result - 14] then goto F14;
      P13: if Ch = PChar(Pointer(Str))[Result - 13] then goto F13;
      P12: if Ch = PChar(Pointer(Str))[Result - 12] then goto F12;
      P11: if Ch = PChar(Pointer(Str))[Result - 11] then goto F11;
      P10: if Ch = PChar(Pointer(Str))[Result - 10] then goto F10;
      P9:  if Ch = PChar(Pointer(Str))[Result - 9]  then goto F9;
      P8:  if Ch = PChar(Pointer(Str))[Result - 8]  then goto F8;
      P7:  if Ch = PChar(Pointer(Str))[Result - 7]  then goto F7;
      P6:  if Ch = PChar(Pointer(Str))[Result - 6]  then goto F6;
      P5:  if Ch = PChar(Pointer(Str))[Result - 5]  then goto F5;
      P4:  if Ch = PChar(Pointer(Str))[Result - 4]  then goto F4;
      P3:  if Ch = PChar(Pointer(Str))[Result - 3]  then goto F3;
      P2:  if Ch = PChar(Pointer(Str))[Result - 2]  then goto F2;
      P1:  if Ch = PChar(Pointer(Str))[Result - 1]  then exit;

      Inc(Result,16);
      if Result <= L0 then goto P16;
      Result := 0; exit;

      F16: Dec(Result,15); exit;
      F15: Dec(Result,14); exit;
      F14: Dec(Result,13); exit;
      F13: Dec(Result,12); exit;
      F12: Dec(Result,11); exit;
      F11: Dec(Result,10); exit;
      F10: Dec(Result,9 ); exit;
      F9:  Dec(Result,8 ); exit;
      F8:  Dec(Result,7 ); exit;
      F7:  Dec(Result,6 ); exit;
      F6:  Dec(Result,5 ); exit;
      F5:  Dec(Result,4 ); exit;
      F4:  Dec(Result,3 ); exit;
      F3:  Dec(Result,2 ); exit;
      F2:  Dec(Result,1 ); exit;
  end
  else
Ender:Result := 0;
end;

function CharPos_CJG_Pas_9_d(Ch : Char; const Str : AnsiString) : Integer;
var
   L0 : Integer;
label NoAlignment, Ender;
label       F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16;
label    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16;
begin
  If Str<>'' then
  begin
    L0 := PInteger(Integer(Str)-4)^; {Get The Length of the String}
    Result := L0 and 15;
    case Result of
      0:  goto NoAlignment;
      1:  goto P1;
      2:  goto P2;
      3:  goto P3;
      4:  goto P4;
      5:  goto P5;
      6:  goto P6;
      7:  goto P7;
      8:  goto P8;
      9:  goto P9;
      10: goto P10;
      11: goto P11;
      12: goto P12;
      13: goto P13;
      14: goto P14;
      15: goto P15;
    end;

    NoAlignment:
      If L0 = 0 then goto Ender;
      Inc(Result,16);

      P16: if Ch = PChar(Pointer(Str))[Result - 16] then goto F16;
      P15: if Ch = PChar(Pointer(Str))[Result - 15] then goto F15;
      P14: if Ch = PChar(Pointer(Str))[Result - 14] then goto F14;
      P13: if Ch = PChar(Pointer(Str))[Result - 13] then goto F13;
      P12: if Ch = PChar(Pointer(Str))[Result - 12] then goto F12;
      P11: if Ch = PChar(Pointer(Str))[Result - 11] then goto F11;
      P10: if Ch = PChar(Pointer(Str))[Result - 10] then goto F10;
      P9:  if Ch = PChar(Pointer(Str))[Result - 9]  then goto F9;
      P8:  if Ch = PChar(Pointer(Str))[Result - 8]  then goto F8;
      P7:  if Ch = PChar(Pointer(Str))[Result - 7]  then goto F7;
      P6:  if Ch = PChar(Pointer(Str))[Result - 6]  then goto F6;
      P5:  if Ch = PChar(Pointer(Str))[Result - 5]  then goto F5;
      P4:  if Ch = PChar(Pointer(Str))[Result - 4]  then goto F4;
      P3:  if Ch = PChar(Pointer(Str))[Result - 3]  then goto F3;
      P2:  if Ch = PChar(Pointer(Str))[Result - 2]  then goto F2;
      P1:  if Ch = PChar(Pointer(Str))[Result - 1]  then exit;

      Inc(Result,16);
      if Result <= L0 then goto P16;
      Result := 0; exit;

      F16: Dec(Result,15); exit;
      F15: Dec(Result,14); exit;
      F14: Dec(Result,13); exit;
      F13: Dec(Result,12); exit;
      F12: Dec(Result,11); exit;
      F11: Dec(Result,10); exit;
      F10: Dec(Result,9 ); exit;
      F9:  Dec(Result,8 ); exit;
      F8:  Dec(Result,7 ); exit;
      F7:  Dec(Result,6 ); exit;
      F6:  Dec(Result,5 ); exit;
      F5:  Dec(Result,4 ); exit;
      F4:  Dec(Result,3 ); exit;
      F3:  Dec(Result,2 ); exit;
      F2:  Dec(Result,1 ); exit;
  end
  else
Ender:Result := 0;
end;

initialization

 Filler1;
 Filler2;

end.
