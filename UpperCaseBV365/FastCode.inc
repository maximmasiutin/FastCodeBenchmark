// Fastcode Library definitions //

{Define this if you want to use fctIA32SizePenalty instead of fctIA32, fctSSESizePenalty instead of fctSSE, FastcodePascalSizePenalty instead of FastcodePascal}
{.$DEFINE FastcodeSizePenalty}

{Define either FastcodeCPUID or one of next five}
{$IFNDEF DisableFastCode}
  {$DEFINE FastcodeCPUID}
  {.$DEFINE FastcodeIA32}
  {.$DEFINE FastcodeMMX}
  {.$DEFINE FastcodeSSE}
  {.$DEFINE FastcodeSSE2}
  {.$DEFINE FastcodePascal}
{$ENDIF}

{Default to FastcodeIA32 / FastcodeIA32SizePenalty if No Fastcode Compile Option Selected}
{$IFNDEF FastcodeIA32}
 {$IFNDEF FastcodeMMX}
  {$IFNDEF FastcodeSSE}
   {$IFNDEF FastcodeSSE2}
    {$IFNDEF FastcodePascal}
     {$IFNDEF FastcodeCPUID}
       {$DEFINE FastcodeIA32}
     {$ENDIF}
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{Ensure Only One Fastcode Compile Option (Best) is Selected}
{$IFDEF FastcodeCPUID}
  {$UNDEF FastcodeMMX}
  {$UNDEF FastcodeSSE}
  {$UNDEF FastcodeSSE2}
  {$UNDEF FastcodeIA32}
  {$UNDEF FastcodePascal}
{$ENDIF}

{$IFDEF FastcodeSSE2}
  {$UNDEF FastcodeIA32}
  {$UNDEF FastcodePascal}
  {$UNDEF FastcodeMMX}
  {$UNDEF FastcodeSSE}
  {$UNDEF FastcodeCPUID}
{$ENDIF}

{$IFDEF FastcodeSSE}
  {$UNDEF FastcodeIA32}
  {$UNDEF FastcodePascal}
  {$UNDEF FastcodeMMX}
  {$UNDEF FastcodeSSE2}
  {$UNDEF FastcodeCPUID}
{$ENDIF}

{$IFDEF FastcodeMMX}
  {$UNDEF FastcodeIA32}
  {$UNDEF FastcodePascal}
  {$UNDEF FastcodeIA32}
  {$UNDEF FastcodeSSE}
  {$UNDEF FastcodeSSE2}
  {$UNDEF FastcodeCPUID}
{$ENDIF}

{$IFDEF FastcodeIA32}
  {$UNDEF FastcodePascal}
  {$UNDEF FastcodeMMX}
  {$UNDEF FastcodeSSE}
  {$UNDEF FastcodeSSE2}
  {$UNDEF FastcodeCPUID}
{$ENDIF}

// Delphi Version definitions //

{$IFDEF VER120}
  {$DEFINE Delphi4}
{$ENDIF}

{$IFDEF VER130}
  {$DEFINE Delphi4}
  {$DEFINE Delphi5}
{$ENDIF}

{$IFDEF VER140}
  {$DEFINE Delphi4}
  {$DEFINE Delphi5}
  {$DEFINE Delphi6}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

{$IFDEF VER150}
  {$DEFINE Delphi4}
  {$DEFINE Delphi5}
  {$DEFINE Delphi6}
  {$DEFINE Delphi7}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}

{$IFDEF VER170}
  {$DEFINE Delphi4}
  {$DEFINE Delphi5}
  {$DEFINE Delphi6}
  {$DEFINE Delphi7}
  {$DEFINE Delphi9}
{$ENDIF}

{$IFDEF VER180}
  {$DEFINE Delphi4}
  {$DEFINE Delphi5}
  {$DEFINE Delphi6}
  {$DEFINE Delphi7}
  {$DEFINE Delphi9}
  {$DEFINE Delphi10}
  {$DEFINE INLINE}
{$ENDIF}

{$IFDEF VER190}
  {$DEFINE Delphi4}
  {$DEFINE Delphi5}
  {$DEFINE Delphi6}
  {$DEFINE Delphi7}
  {$DEFINE Delphi9}
  {$DEFINE Delphi10}
  {$DEFINE Delphi11}
  {$DEFINE INLINE}
{$ENDIF}
