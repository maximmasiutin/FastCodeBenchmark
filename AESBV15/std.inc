(*************************************************************************

 DESCRIPTION     :  Standard definitions and options

 REQUIREMENTS    :  TP5-7, D1-D7, FPC, VP

 Version  Date      Author      Modification
 -------  --------  -------     ------------------------------------------
 1.00     05.10.03  W.Ehrhardt  Initial version
 1.01     05.10.03  we          X_OPT, removed TP4
 1.02     30.10.03  we          WINCRT
 1.03     09.12.03  we          {$R+,S+} {$ifdef debug}
 1.04     26.12.03  we          VP: {&Optimise+,SmartLink+,Speed+} ifndef debug
 1.05     28.12.03  we          DELPHI = Delphi32 (no Delphi 1!)
 1.06     12.04.04  we          Delphi 7
**************************************************************************)


(*-------------------------------------------------------------------------
 (C) Copyright 2003-2004 Wolfgang Ehrhardt

 This software is provided 'as-is', without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it
 freely, subject to the following restrictions:

 1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software in
    a product, an acknowledgment in the product documentation would be
    appreciated but is not required.

 2. Altered source versions must be plainly marked as such, and must not be
    misrepresented as being the original software.

 3. This notice may not be removed or altered from any source distribution.
----------------------------------------------------------------------------*)


{$undef  BIT16}     {16 Bit code, Pascal / D1}
{$undef  BIT32}     {32 Bit code}
{$undef  DELPHI}    {Delphi2+ and BCB++}
{$undef  G_OPT}     {G+ option support}
{$undef  D4PLUS}    {Delphi 4 and higher}
{$undef  BASM16}    {16 Bit BASM}
{$undef  LoadArgs}  {Register params}
{$undef  WINCRT}    {Use WinCRT for console}

{$define CONST}     {const in proc declaration}
{$define Q_OPT}     {Q- option support}
{$define X_OPT}     {X+ option support}


{$ifdef VER10}      {TPW 1.0/1.5??}
  {$define BIT16}
  {$define BASM16}
  {$define G_OPT}
{$endif}

{$ifdef VER50 }
  {$define BIT16}
  {$undef  CONST}
  {$undef  Q_OPT}
  {$undef  X_OPT}
{$endif}

{$ifdef VER55 }
  {$define BIT16}
  {$undef  CONST}
  {$undef  Q_OPT}
  {$undef  X_OPT}
{$endif}

{$ifdef VER60 }
  {$define BIT16}
  {$undef  CONST}
  {$undef  Q_OPT}
  {$define G_OPT}
  {$define BASM16}
{$endif}

{$ifdef VER70 }
  {$define BIT16}
  {$define G_OPT}
  {$define BASM16}
{$endif}

{$ifdef VER80}
  {.$define DELPHI}   {D1} {*we V1.05}
  {$define BIT16 }
  {$define G_OPT }
  {$define BASM16}
  {$define WINCRT}
{$endif}

{$ifdef VER90 }
  {$define DELPHI}  {D2}
{$endif}

{$ifdef VER93 }
  {$define DELPHI}  {BCB++1}
{$endif}

{$ifdef VER100}
  {$define DELPHI}  {D3}
{$endif}

{$ifdef VER110}
  {$define DELPHI}  {BCB++3}
{$endif}

{$ifdef VER120}
  {$define DELPHI}  {D4}
  {$define D4PLUS}
{$endif}

{$ifdef VER125}
  {$define DELPHI}  {BCB++4}
  {$define D4PLUS}
{$endif}

{$ifdef VER130}
  {$define DELPHI}  {D5}
  {$define D4PLUS}
{$endif}

{$ifdef VER140}
  {$define DELPHI}  {D6}
  {$define D4PLUS}
{$endif}

{$ifdef VER150}
  {$define DELPHI}  {D7}
  {$define D4PLUS}
{$endif}

{$ifdef CONDITIONALEXPRESSIONS}  {D6+}
  {$define D4PLUS}
{$endif}


{$ifdef VER70}
  {$ifdef windows}
    {$define WINCRT}
  {$endif}
{$endif}

{$ifdef VirtualPascal}
  {$define G_OPT}
{$endif}

{$ifndef BIT16}
  {$define BIT32}
{$endif}

{$ifdef FPC}
  {$define LoadArgs}
  {$ASMmode intel}
{$endif}

{$ifdef VirtualPascal}
  {$ifndef debug}
    {&Optimise+,SmartLink+,Speed+}
  {$endif}
  {$define LoadArgs}
{$endif}


{$ifdef G_OPT}
  {$G+}
{$endif}
{$ifdef Q_OPT}
  {$Q-}
{$endif}


{$ifdef debug}
  {$R+,S+}
{$else}
  {$R-,S-}
{$endif}

