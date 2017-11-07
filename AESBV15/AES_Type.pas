unit AES_Type;

(*************************************************************************

 DESCRIPTION     :  AES type definitions

 REQUIREMENTS    :  TP5-7, D1-D7, FPC, VP  [*see note]

 EXTERNAL DATA   :  ---

 MEMORY USAGE    :  ---

 DISPLAY MODE    :  ---

 REFERENCES      :  ---


 Version  Date      Author      Modification
 -------  --------  -------     ------------------------------------------
 1.00     16.08.03  we          Sepatate unit from AESCrypt
 1.10     15.09.03  we          with IncProc
 1.20     21.09.03  we          with Flag, error codes
 1.21     05.10.03  we          with STD.INC
 1.23     05.10.03  we          with AES_Err_MultipleIncProcs
 1.24     12.06.04  we          with AES_Err_NIL_Pointer, const BLKSIZE
 1.25     02.07.04  we          {$ifdef DLL} stdcall; {$endif}
 1.26     19.09.04  we/dkc      Cardinals, Delphi4..7 only, no DLL code
**************************************************************************)


(*-------------------------------------------------------------------------
 (C) Copyright 2002-2004 Wolfgang Ehrhardt

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

[*note]
This source code is a special edition for the FastCode AES project:
http://dennishomepage.gugs-cats.dk/AESBVxx.zip, xx=01..06.
Dennis Kjaer Christensen stripped the support for pascal compilers other than
Delphi 4..7. This is an updated version of the dkc changes, the full source
code is availables from of http://home.netsurf.de/wolfgang.ehrhardt
----------------------------------------------------------------------------*)


interface


const
  AES_WE_MaxRounds = 14;

const
  AES_Err_Invalid_Key_Size      = -1;  {Key size <> 128, 192, or 256 Bits}
  AES_Err_Invalid_Mode          = -2;  {Encr/Decr with Init for Decr/Encr}
  AES_Err_Invalid_Length        = -3;  {No full block for cipher stealing}
  AES_Err_Multiple_Short_Blocks = -4;  {More than one short block call   }
  AES_Err_MultipleIncProcs      = -5;  {More than one IncProc Setting    }
  AES_Err_NIL_Pointer           = -6;  {nil pointer to block with nonzero length}

type
  TAES_WE_Block   = packed array[0..15] of byte;
  PAESBlock       = ^TAES_WE_Block;
  TKeyArray       = packed array[0..AES_WE_MaxRounds] of TAES_WE_Block;
  TIncProc        = procedure(var CTR: TAES_WE_Block);   {user supplied IncCTR proc}

  TAES_WE_Context = packed record
                       RK      : TKeyArray;     {Key (encr. or decr.)   }
                       IV      : TAES_WE_Block; {IV or CTR              }
                       buf     : TAES_WE_Block; {Work buffer            }
                       bLen    : word;          {Bytes used in buf      }
                       Rounds  : word;          {Number of rounds       }
                       KeyBits : word;          {Number of bits in key  }
                       Decrypt : byte;          {<>0 if decrypting key  }
                       Flag    : byte;          {Bit 1: Short block     }
                       IncProc : TIncProc;      {Increment proc CTR-Mode}
                     end;

const
  BLKSIZE = sizeof(TAES_WE_Block);

implementation

end.
