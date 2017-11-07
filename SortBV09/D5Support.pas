unit D5Support;

interface

{$INCLUDE Defines.inc}

{$IFNDEF Delphi6Plus}

uses
  Windows;
  
type
  PByte = ^Byte;
  PWord = ^Word;
  PDWord = ^DWORD;
  PInteger = ^Integer;

  // Field masks for the 64-bit Double type as suggested by Jon Shemitz
const
  dSignMask         = $8000000000000000;
  dExponentMask     = $7FF0000000000000;
  dMantissaMask     = $000FFFFFFFFFFFFF;

  // Bit pattern suggested by Jon Shemitz
const
  NANSignalingBits  : Int64 = dExponentMask or 1; // $7FF0000000000001;

var
  NANSignaling      : Double absolute NANSignalingBits;

function NAN: Double;                   // The "Quiet" Nan

function Infinity: Double;      //  INF
function NegInfinity: Double;      // -INF

// "Is" functions
function IsNAN(const d: Double): Boolean;
function IsInfinite(const d: Double): Boolean;

// Hex String Conversions
function DoubleToHex(const d: Double): string;
function HexToDouble(const hex: string): Double;

// Math
function RandomRange(const RangeFrom, RangeTo: Integer): Integer;

{$ENDIF}

implementation

{$IFNDEF Delphi6Plus}

uses
  SysUtils;                             // IntToHex

type
  EIEEEMath = class(Exception);

  // Bit patterns for the NAN & INF constants suggested by Jon Shemitz
const
  NANQuietBits      : Int64 = dExponentMask or dMantissaMask; // $7FFFFFFFFFFFFFFF;
  PositiveInfinityBits: Int64 = dExponentMask; // $7FF0000000000000;
  NegativeInfinityBits: Int64 = dExponentMask or dSignMask; // $FFF0000000000000;

var
  dNANQuiet         : Double absolute NANQuietBits;
  dPositiveInfinity : Double absolute PositiveInfinityBits;
  dNegativeInfinity : Double absolute NegativeInfinityBits;

  // Since a NAN is not a single, unique value, a special function is needed
  // for this test

function IsNAN(const D: Double): Boolean; // By Jon Shemitz
var
  Overlay           : Int64 absolute d;
begin
  Result := ((Overlay and dExponentMask) = dExponentMask) and
    ((Overlay and dMantissaMask) <> 0)
end {IsNAN};

function IsInfinite(const d: Double): Boolean; // By Jon Shemtiz
var
  Overlay           : Int64 absolute d;
begin
  Result := ((Overlay and dExponentMask) = dExponentMask) and
    ((Overlay and dMantissaMask) = 0)
end {IsInfinity};

function DoubleToHex(const d: Double): string;
var
  Overlay           : Int64 absolute d;
begin
  Result := IntToHex(Overlay, 16)
end {DoubleToHex};

function HexToDouble(const hex: string): Double;
var
  d                 : Double;
  Overlay           : array[1..2] of LongInt absolute d;
begin
  if Length(hex) <> 16 then raise EIEEEMath.Create('Invalid hex string for HexToDouble');

  Overlay[1] := StrToInt('$' + Copy(hex, 9, 8));
  Overlay[2] := StrToInt('$' + Copy(hex, 1, 8));

  Result := d
end {HexToDouble};

function NAN: Double;
begin
  Result := dNANQuiet
end {NAN};


function Infinity: Double;
begin
  Result := dPositiveInfinity
end {PositiveInfinity};


function NegInfinity: Double;
begin
  Result := dNegativeInfinity
end {NegativeInfinity};

function RandomRange(const RangeFrom, RangeTo: Integer): Integer;
begin
  Result := RangeFrom + Random(RangeTo-RangeFrom);
end;

{$ENDIF}

end.


