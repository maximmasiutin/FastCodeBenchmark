unit MinFPJOHUnit;

interface

function MinJOH_RTL(const A, B : Single) : Single; overload;
function MinJOH_RTL(const A, B : Double) : Double; overload;
function MinJOH_RTL(const A, B : Extended) : Extended; overload;
function MinJOH(const A, B : Single) : Single; overload;
function MinJOH(const A, B : Double) : Double; overload;
function MinJOH(const A, B : Extended) : Extended; overload;

implementation

function MinJOH_RTL(const A, B : Single) : Single; overload;
asm
  fld    A
  fcomp  B
  fstsw  ax
  and    eax, $100
  shr    eax, 6 {eax = 0 or 4}
  fld    dword ptr [ebp+eax+8]
end;

function MinJOH_RTL(const A, B : Double) : Double; overload;
asm
  fld   A
  fld   B
  fcom
  fstsw ax
  sahf
  jc    @done
  fxch
@done:
  ffree st(1)
end;

function MinJOH_RTL(const A, B : Extended) : Extended; overload;
asm
  fld   A
  fld   B
  fcom
  fstsw ax
  sahf
  jc    @done
  fxch
@done:
  ffree st(1)
end;

function MinJOH(const A, B : Single) : Single; overload;
asm
  fld     A
  fld     B
  fcomi   st(0), st(1)
  fcmovnb st(0), st(1)
  ffree   st(1)
end;

function MinJOH(const A, B : Double) : Double; overload;
asm
  fld     A
  fld     B
  fcomi   st(0), st(1)
  fcmovnb st(0), st(1)
  ffree   st(1)
end;

function MinJOH(const A, B : Extended) : Extended; overload;
asm
  fld     A
  fld     B
  fcomi   st(0), st(1)
  fcmovnb st(0), st(1)
  ffree   st(1)
end;

end.
