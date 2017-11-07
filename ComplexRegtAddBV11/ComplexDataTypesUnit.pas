unit ComplexDataTypesUnit;

interface

type

TRegtangularComplexS = packed record
 RealPart, ImaginaryPart : Single;
end;

TRegtangularComplexD = packed record
 RealPart, ImaginaryPart : Double;
end;

TRegtangularComplexE = packed record
 RealPart : Extended;
 Pad1 : Cardinal; //4 byte
 Pad2 : SmallInt; //2 byte
 ImaginaryPart : Extended;
 Pad3 : Cardinal; //4 byte
 Pad4 : SmallInt; //2 byte
end;

TPolarComplexS = packed record
 Amplitude, Phase : Single;
end;

TPolarComplexD = packed record
 Amplitude, Phase : Double;
end;

TPolarComplexE = packed record
 Amplitude : Extended;
 Pad1 : Cardinal; //4 byte
 Pad2 : SmallInt; //2 byte
 Phase : Extended;
 Pad3 : Cardinal; //4 byte
 Pad4 : SmallInt; //2 byte
end;

implementation

end.
