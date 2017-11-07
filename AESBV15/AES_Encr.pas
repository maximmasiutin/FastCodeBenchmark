unit AES_Encr;


(*************************************************************************

 DESCRIPTION     :  AES encrypt functions

 REQUIREMENTS    :  TP5-7, D1-D7, FPC, VP (Undef BASM16 for 286) [*see note]

 EXTERNAL DATA   :  ---

 MEMORY USAGE    :  ---

 DISPLAY MODE    :  ---

 REFERENCES      :  [1] http://csrc.nist.gov/fips/fips-197.pdf
                    [2] rijndael-alg-fst.c V2.0/3.0: Rijmen et al Aug1999/Dec2000


 Version  Date      Author      Modification
 -------  --------  -------     ------------------------------------------
 0.22     16.08.03  we          Cardinal statt word32
 0.23     16.08.03  we          separate aes_encr
 0.24     16.08.03  we          new xor_block
 0.25     18.09.03  we          Static tables, D4+
 0.26     20.09.03  we          optimized round code, no more move/if
 0.27     21.09.03  we          functions, error codes
 0.28     27.09.03  we          FPC/go32v2
 0.29     28.09.03  we          removed temporary s-Block
 0.30     28.09.03  we          two rounds in each loop, merge last xorblock
 0.31     03.10.03  we          3-para encr/decr
 0.32     03.10.03  we          two local blocks if partial unroll
 0.33     03.10.03  we          BASM for BP7
 0.34     04.10.03  we          remove add di,4
 0.35     05.10.03  we          STD.INC, TP6
 0.36     05.10.03  we          TP5,TP5.5
 0.37     27.12.03  we          EPerm removed
 0.38     28.12.03  we          Delphi/VP: Pointer version
                                BASM16: changed variable order
 0.39     28.12.03  we          BASM16: SBox code in asm,
                                PTR: merge SBox code with XOR RK
 0.40     29.12.03  we          BASM16: xorblock in asm, PTR: reorder
 0.41     02.07.04  we          {$ifdef DLL} stdcall; {$endif}
 0.42     19.09.04  we/dkc      Cardinals, Delphi4..7 only, no DLL code
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


uses AES_Type, AES_Base;

function  AES_Init_Encr(const  Key; KeyBits: word; var ctx: TAES_WE_Context): integer;
  {-AES key expansion, error if invalid key size}

procedure AES_WE_Encrypt(var ctx: TAES_WE_Context; const BI: TAES_WE_Block; var BO: TAES_WE_Block);
  {-encrypt one block, not checked: key must be encryption key}

implementation

const
  T1: array[byte] of Cardinal =
   ($a56363c6, $847c7cf8, $997777ee, $8d7b7bf6, $0df2f2ff, $bd6b6bd6, $b16f6fde, $54c5c591,
    $50303060, $03010102, $a96767ce, $7d2b2b56, $19fefee7, $62d7d7b5, $e6abab4d, $9a7676ec,
    $45caca8f, $9d82821f, $40c9c989, $877d7dfa, $15fafaef, $eb5959b2, $c947478e, $0bf0f0fb,
    $ecadad41, $67d4d4b3, $fda2a25f, $eaafaf45, $bf9c9c23, $f7a4a453, $967272e4, $5bc0c09b,
    $c2b7b775, $1cfdfde1, $ae93933d, $6a26264c, $5a36366c, $413f3f7e, $02f7f7f5, $4fcccc83,
    $5c343468, $f4a5a551, $34e5e5d1, $08f1f1f9, $937171e2, $73d8d8ab, $53313162, $3f15152a,
    $0c040408, $52c7c795, $65232346, $5ec3c39d, $28181830, $a1969637, $0f05050a, $b59a9a2f,
    $0907070e, $36121224, $9b80801b, $3de2e2df, $26ebebcd, $6927274e, $cdb2b27f, $9f7575ea,
    $1b090912, $9e83831d, $742c2c58, $2e1a1a34, $2d1b1b36, $b26e6edc, $ee5a5ab4, $fba0a05b,
    $f65252a4, $4d3b3b76, $61d6d6b7, $ceb3b37d, $7b292952, $3ee3e3dd, $712f2f5e, $97848413,
    $f55353a6, $68d1d1b9, $00000000, $2cededc1, $60202040, $1ffcfce3, $c8b1b179, $ed5b5bb6,
    $be6a6ad4, $46cbcb8d, $d9bebe67, $4b393972, $de4a4a94, $d44c4c98, $e85858b0, $4acfcf85,
    $6bd0d0bb, $2aefefc5, $e5aaaa4f, $16fbfbed, $c5434386, $d74d4d9a, $55333366, $94858511,
    $cf45458a, $10f9f9e9, $06020204, $817f7ffe, $f05050a0, $443c3c78, $ba9f9f25, $e3a8a84b,
    $f35151a2, $fea3a35d, $c0404080, $8a8f8f05, $ad92923f, $bc9d9d21, $48383870, $04f5f5f1,
    $dfbcbc63, $c1b6b677, $75dadaaf, $63212142, $30101020, $1affffe5, $0ef3f3fd, $6dd2d2bf,
    $4ccdcd81, $140c0c18, $35131326, $2fececc3, $e15f5fbe, $a2979735, $cc444488, $3917172e,
    $57c4c493, $f2a7a755, $827e7efc, $473d3d7a, $ac6464c8, $e75d5dba, $2b191932, $957373e6,
    $a06060c0, $98818119, $d14f4f9e, $7fdcdca3, $66222244, $7e2a2a54, $ab90903b, $8388880b,
    $ca46468c, $29eeeec7, $d3b8b86b, $3c141428, $79dedea7, $e25e5ebc, $1d0b0b16, $76dbdbad,
    $3be0e0db, $56323264, $4e3a3a74, $1e0a0a14, $db494992, $0a06060c, $6c242448, $e45c5cb8,
    $5dc2c29f, $6ed3d3bd, $efacac43, $a66262c4, $a8919139, $a4959531, $37e4e4d3, $8b7979f2,
    $32e7e7d5, $43c8c88b, $5937376e, $b76d6dda, $8c8d8d01, $64d5d5b1, $d24e4e9c, $e0a9a949,
    $b46c6cd8, $fa5656ac, $07f4f4f3, $25eaeacf, $af6565ca, $8e7a7af4, $e9aeae47, $18080810,
    $d5baba6f, $887878f0, $6f25254a, $722e2e5c, $241c1c38, $f1a6a657, $c7b4b473, $51c6c697,
    $23e8e8cb, $7cdddda1, $9c7474e8, $211f1f3e, $dd4b4b96, $dcbdbd61, $868b8b0d, $858a8a0f,
    $907070e0, $423e3e7c, $c4b5b571, $aa6666cc, $d8484890, $05030306, $01f6f6f7, $120e0e1c,
    $a36161c2, $5f35356a, $f95757ae, $d0b9b969, $91868617, $58c1c199, $271d1d3a, $b99e9e27,
    $38e1e1d9, $13f8f8eb, $b398982b, $33111122, $bb6969d2, $70d9d9a9, $898e8e07, $a7949433,
    $b69b9b2d, $221e1e3c, $92878715, $20e9e9c9, $49cece87, $ff5555aa, $78282850, $7adfdfa5,
    $8f8c8c03, $f8a1a159, $80898909, $170d0d1a, $dabfbf65, $31e6e6d7, $c6424284, $b86868d0,
    $c3414182, $b0999929, $772d2d5a, $110f0f1e, $cbb0b07b, $fc5454a8, $d6bbbb6d, $3a16162c);

  T2: array[byte] of Cardinal =
   ($6363c6a5, $7c7cf884, $7777ee99, $7b7bf68d, $f2f2ff0d, $6b6bd6bd, $6f6fdeb1, $c5c59154,
    $30306050, $01010203, $6767cea9, $2b2b567d, $fefee719, $d7d7b562, $abab4de6, $7676ec9a,
    $caca8f45, $82821f9d, $c9c98940, $7d7dfa87, $fafaef15, $5959b2eb, $47478ec9, $f0f0fb0b,
    $adad41ec, $d4d4b367, $a2a25ffd, $afaf45ea, $9c9c23bf, $a4a453f7, $7272e496, $c0c09b5b,
    $b7b775c2, $fdfde11c, $93933dae, $26264c6a, $36366c5a, $3f3f7e41, $f7f7f502, $cccc834f,
    $3434685c, $a5a551f4, $e5e5d134, $f1f1f908, $7171e293, $d8d8ab73, $31316253, $15152a3f,
    $0404080c, $c7c79552, $23234665, $c3c39d5e, $18183028, $969637a1, $05050a0f, $9a9a2fb5,
    $07070e09, $12122436, $80801b9b, $e2e2df3d, $ebebcd26, $27274e69, $b2b27fcd, $7575ea9f,
    $0909121b, $83831d9e, $2c2c5874, $1a1a342e, $1b1b362d, $6e6edcb2, $5a5ab4ee, $a0a05bfb,
    $5252a4f6, $3b3b764d, $d6d6b761, $b3b37dce, $2929527b, $e3e3dd3e, $2f2f5e71, $84841397,
    $5353a6f5, $d1d1b968, $00000000, $ededc12c, $20204060, $fcfce31f, $b1b179c8, $5b5bb6ed,
    $6a6ad4be, $cbcb8d46, $bebe67d9, $3939724b, $4a4a94de, $4c4c98d4, $5858b0e8, $cfcf854a,
    $d0d0bb6b, $efefc52a, $aaaa4fe5, $fbfbed16, $434386c5, $4d4d9ad7, $33336655, $85851194,
    $45458acf, $f9f9e910, $02020406, $7f7ffe81, $5050a0f0, $3c3c7844, $9f9f25ba, $a8a84be3,
    $5151a2f3, $a3a35dfe, $404080c0, $8f8f058a, $92923fad, $9d9d21bc, $38387048, $f5f5f104,
    $bcbc63df, $b6b677c1, $dadaaf75, $21214263, $10102030, $ffffe51a, $f3f3fd0e, $d2d2bf6d,
    $cdcd814c, $0c0c1814, $13132635, $ececc32f, $5f5fbee1, $979735a2, $444488cc, $17172e39,
    $c4c49357, $a7a755f2, $7e7efc82, $3d3d7a47, $6464c8ac, $5d5dbae7, $1919322b, $7373e695,
    $6060c0a0, $81811998, $4f4f9ed1, $dcdca37f, $22224466, $2a2a547e, $90903bab, $88880b83,
    $46468cca, $eeeec729, $b8b86bd3, $1414283c, $dedea779, $5e5ebce2, $0b0b161d, $dbdbad76,
    $e0e0db3b, $32326456, $3a3a744e, $0a0a141e, $494992db, $06060c0a, $2424486c, $5c5cb8e4,
    $c2c29f5d, $d3d3bd6e, $acac43ef, $6262c4a6, $919139a8, $959531a4, $e4e4d337, $7979f28b,
    $e7e7d532, $c8c88b43, $37376e59, $6d6ddab7, $8d8d018c, $d5d5b164, $4e4e9cd2, $a9a949e0,
    $6c6cd8b4, $5656acfa, $f4f4f307, $eaeacf25, $6565caaf, $7a7af48e, $aeae47e9, $08081018,
    $baba6fd5, $7878f088, $25254a6f, $2e2e5c72, $1c1c3824, $a6a657f1, $b4b473c7, $c6c69751,
    $e8e8cb23, $dddda17c, $7474e89c, $1f1f3e21, $4b4b96dd, $bdbd61dc, $8b8b0d86, $8a8a0f85,
    $7070e090, $3e3e7c42, $b5b571c4, $6666ccaa, $484890d8, $03030605, $f6f6f701, $0e0e1c12,
    $6161c2a3, $35356a5f, $5757aef9, $b9b969d0, $86861791, $c1c19958, $1d1d3a27, $9e9e27b9,
    $e1e1d938, $f8f8eb13, $98982bb3, $11112233, $6969d2bb, $d9d9a970, $8e8e0789, $949433a7,
    $9b9b2db6, $1e1e3c22, $87871592, $e9e9c920, $cece8749, $5555aaff, $28285078, $dfdfa57a,
    $8c8c038f, $a1a159f8, $89890980, $0d0d1a17, $bfbf65da, $e6e6d731, $424284c6, $6868d0b8,
    $414182c3, $999929b0, $2d2d5a77, $0f0f1e11, $b0b07bcb, $5454a8fc, $bbbb6dd6, $16162c3a);

  T3: array[byte] of Cardinal =
   ($63c6a563, $7cf8847c, $77ee9977, $7bf68d7b, $f2ff0df2, $6bd6bd6b, $6fdeb16f, $c59154c5,
    $30605030, $01020301, $67cea967, $2b567d2b, $fee719fe, $d7b562d7, $ab4de6ab, $76ec9a76,
    $ca8f45ca, $821f9d82, $c98940c9, $7dfa877d, $faef15fa, $59b2eb59, $478ec947, $f0fb0bf0,
    $ad41ecad, $d4b367d4, $a25ffda2, $af45eaaf, $9c23bf9c, $a453f7a4, $72e49672, $c09b5bc0,
    $b775c2b7, $fde11cfd, $933dae93, $264c6a26, $366c5a36, $3f7e413f, $f7f502f7, $cc834fcc,
    $34685c34, $a551f4a5, $e5d134e5, $f1f908f1, $71e29371, $d8ab73d8, $31625331, $152a3f15,
    $04080c04, $c79552c7, $23466523, $c39d5ec3, $18302818, $9637a196, $050a0f05, $9a2fb59a,
    $070e0907, $12243612, $801b9b80, $e2df3de2, $ebcd26eb, $274e6927, $b27fcdb2, $75ea9f75,
    $09121b09, $831d9e83, $2c58742c, $1a342e1a, $1b362d1b, $6edcb26e, $5ab4ee5a, $a05bfba0,
    $52a4f652, $3b764d3b, $d6b761d6, $b37dceb3, $29527b29, $e3dd3ee3, $2f5e712f, $84139784,
    $53a6f553, $d1b968d1, $00000000, $edc12ced, $20406020, $fce31ffc, $b179c8b1, $5bb6ed5b,
    $6ad4be6a, $cb8d46cb, $be67d9be, $39724b39, $4a94de4a, $4c98d44c, $58b0e858, $cf854acf,
    $d0bb6bd0, $efc52aef, $aa4fe5aa, $fbed16fb, $4386c543, $4d9ad74d, $33665533, $85119485,
    $458acf45, $f9e910f9, $02040602, $7ffe817f, $50a0f050, $3c78443c, $9f25ba9f, $a84be3a8,
    $51a2f351, $a35dfea3, $4080c040, $8f058a8f, $923fad92, $9d21bc9d, $38704838, $f5f104f5,
    $bc63dfbc, $b677c1b6, $daaf75da, $21426321, $10203010, $ffe51aff, $f3fd0ef3, $d2bf6dd2,
    $cd814ccd, $0c18140c, $13263513, $ecc32fec, $5fbee15f, $9735a297, $4488cc44, $172e3917,
    $c49357c4, $a755f2a7, $7efc827e, $3d7a473d, $64c8ac64, $5dbae75d, $19322b19, $73e69573,
    $60c0a060, $81199881, $4f9ed14f, $dca37fdc, $22446622, $2a547e2a, $903bab90, $880b8388,
    $468cca46, $eec729ee, $b86bd3b8, $14283c14, $dea779de, $5ebce25e, $0b161d0b, $dbad76db,
    $e0db3be0, $32645632, $3a744e3a, $0a141e0a, $4992db49, $060c0a06, $24486c24, $5cb8e45c,
    $c29f5dc2, $d3bd6ed3, $ac43efac, $62c4a662, $9139a891, $9531a495, $e4d337e4, $79f28b79,
    $e7d532e7, $c88b43c8, $376e5937, $6ddab76d, $8d018c8d, $d5b164d5, $4e9cd24e, $a949e0a9,
    $6cd8b46c, $56acfa56, $f4f307f4, $eacf25ea, $65caaf65, $7af48e7a, $ae47e9ae, $08101808,
    $ba6fd5ba, $78f08878, $254a6f25, $2e5c722e, $1c38241c, $a657f1a6, $b473c7b4, $c69751c6,
    $e8cb23e8, $dda17cdd, $74e89c74, $1f3e211f, $4b96dd4b, $bd61dcbd, $8b0d868b, $8a0f858a,
    $70e09070, $3e7c423e, $b571c4b5, $66ccaa66, $4890d848, $03060503, $f6f701f6, $0e1c120e,
    $61c2a361, $356a5f35, $57aef957, $b969d0b9, $86179186, $c19958c1, $1d3a271d, $9e27b99e,
    $e1d938e1, $f8eb13f8, $982bb398, $11223311, $69d2bb69, $d9a970d9, $8e07898e, $9433a794,
    $9b2db69b, $1e3c221e, $87159287, $e9c920e9, $ce8749ce, $55aaff55, $28507828, $dfa57adf,
    $8c038f8c, $a159f8a1, $89098089, $0d1a170d, $bf65dabf, $e6d731e6, $4284c642, $68d0b868,
    $4182c341, $9929b099, $2d5a772d, $0f1e110f, $b07bcbb0, $54a8fc54, $bb6dd6bb, $162c3a16);

  T4: array[byte] of Cardinal =
   ($c6a56363, $f8847c7c, $ee997777, $f68d7b7b, $ff0df2f2, $d6bd6b6b, $deb16f6f, $9154c5c5,
    $60503030, $02030101, $cea96767, $567d2b2b, $e719fefe, $b562d7d7, $4de6abab, $ec9a7676,
    $8f45caca, $1f9d8282, $8940c9c9, $fa877d7d, $ef15fafa, $b2eb5959, $8ec94747, $fb0bf0f0,
    $41ecadad, $b367d4d4, $5ffda2a2, $45eaafaf, $23bf9c9c, $53f7a4a4, $e4967272, $9b5bc0c0,
    $75c2b7b7, $e11cfdfd, $3dae9393, $4c6a2626, $6c5a3636, $7e413f3f, $f502f7f7, $834fcccc,
    $685c3434, $51f4a5a5, $d134e5e5, $f908f1f1, $e2937171, $ab73d8d8, $62533131, $2a3f1515,
    $080c0404, $9552c7c7, $46652323, $9d5ec3c3, $30281818, $37a19696, $0a0f0505, $2fb59a9a,
    $0e090707, $24361212, $1b9b8080, $df3de2e2, $cd26ebeb, $4e692727, $7fcdb2b2, $ea9f7575,
    $121b0909, $1d9e8383, $58742c2c, $342e1a1a, $362d1b1b, $dcb26e6e, $b4ee5a5a, $5bfba0a0,
    $a4f65252, $764d3b3b, $b761d6d6, $7dceb3b3, $527b2929, $dd3ee3e3, $5e712f2f, $13978484,
    $a6f55353, $b968d1d1, $00000000, $c12ceded, $40602020, $e31ffcfc, $79c8b1b1, $b6ed5b5b,
    $d4be6a6a, $8d46cbcb, $67d9bebe, $724b3939, $94de4a4a, $98d44c4c, $b0e85858, $854acfcf,
    $bb6bd0d0, $c52aefef, $4fe5aaaa, $ed16fbfb, $86c54343, $9ad74d4d, $66553333, $11948585,
    $8acf4545, $e910f9f9, $04060202, $fe817f7f, $a0f05050, $78443c3c, $25ba9f9f, $4be3a8a8,
    $a2f35151, $5dfea3a3, $80c04040, $058a8f8f, $3fad9292, $21bc9d9d, $70483838, $f104f5f5,
    $63dfbcbc, $77c1b6b6, $af75dada, $42632121, $20301010, $e51affff, $fd0ef3f3, $bf6dd2d2,
    $814ccdcd, $18140c0c, $26351313, $c32fecec, $bee15f5f, $35a29797, $88cc4444, $2e391717,
    $9357c4c4, $55f2a7a7, $fc827e7e, $7a473d3d, $c8ac6464, $bae75d5d, $322b1919, $e6957373,
    $c0a06060, $19988181, $9ed14f4f, $a37fdcdc, $44662222, $547e2a2a, $3bab9090, $0b838888,
    $8cca4646, $c729eeee, $6bd3b8b8, $283c1414, $a779dede, $bce25e5e, $161d0b0b, $ad76dbdb,
    $db3be0e0, $64563232, $744e3a3a, $141e0a0a, $92db4949, $0c0a0606, $486c2424, $b8e45c5c,
    $9f5dc2c2, $bd6ed3d3, $43efacac, $c4a66262, $39a89191, $31a49595, $d337e4e4, $f28b7979,
    $d532e7e7, $8b43c8c8, $6e593737, $dab76d6d, $018c8d8d, $b164d5d5, $9cd24e4e, $49e0a9a9,
    $d8b46c6c, $acfa5656, $f307f4f4, $cf25eaea, $caaf6565, $f48e7a7a, $47e9aeae, $10180808,
    $6fd5baba, $f0887878, $4a6f2525, $5c722e2e, $38241c1c, $57f1a6a6, $73c7b4b4, $9751c6c6,
    $cb23e8e8, $a17cdddd, $e89c7474, $3e211f1f, $96dd4b4b, $61dcbdbd, $0d868b8b, $0f858a8a,
    $e0907070, $7c423e3e, $71c4b5b5, $ccaa6666, $90d84848, $06050303, $f701f6f6, $1c120e0e,
    $c2a36161, $6a5f3535, $aef95757, $69d0b9b9, $17918686, $9958c1c1, $3a271d1d, $27b99e9e,
    $d938e1e1, $eb13f8f8, $2bb39898, $22331111, $d2bb6969, $a970d9d9, $07898e8e, $33a79494,
    $2db69b9b, $3c221e1e, $15928787, $c920e9e9, $8749cece, $aaff5555, $50782828, $a57adfdf,
    $038f8c8c, $59f8a1a1, $09808989, $1a170d0d, $65dabfbf, $d731e6e6, $84c64242, $d0b86868,
    $82c34141, $29b09999, $5a772d2d, $1e110f0f, $7bcbb0b0, $a8fc5454, $6dd6bbbb, $2c3a1616);

{---------------------------------------------------------------------------}
function AES_Init_Encr(const Key; KeyBits: word; var ctx: TAES_WE_Context): integer;
  {-AES key expansion, error if invalid key size}
begin
  AES_Init_Encr := AES_Init(Key, KeyBits, ctx);
end;


{---------------------------------------------------------------------------}
procedure AES_WE_Encrypt(var ctx: TAES_WE_Context; const BI: TAES_WE_Block; var BO: TAES_WE_Block);
  {-encrypt one block, not checked: key must be encryption key}
type
  PLong = ^Cardinal;
var
  r: integer;              {round loop countdown counter     }
  pK,pO: PLong;            {pointer to RK[] and and BO[]     }
  s0,s1,s2,s3: Cardinal;   {TAESBlock s as separate variables}
begin

  pK := PLong(@ctx.RK);
  pO := PLong(@TWA4(BO)[3]);

  s0 := TWA4(BI)[0] xor pK^; inc(pK);
  s1 := TWA4(BI)[1] xor pK^; inc(pK);
  s2 := TWA4(BI)[2] xor pK^; inc(pK);
  s3 := TWA4(BI)[3] xor pK^; inc(pK);

  for r := ctx.Rounds-1 downto 1 do begin
    {pO -> BO[3]}
    pO^ := T1[s3 and $ff] xor T2[s0 shr 8 and $ff] xor T3[s1 shr 16 and $ff] xor T4[s2 shr 24]; dec(PO);
    pO^ := T1[s2 and $ff] xor T2[s3 shr 8 and $ff] xor T3[s0 shr 16 and $ff] xor T4[s1 shr 24]; dec(pO);
    pO^ := T1[s1 and $ff] xor T2[s2 shr 8 and $ff] xor T3[s3 shr 16 and $ff] xor T4[s0 shr 24]; dec(pO);
(*
**  Next to statements can be merged;
**  pO^ := T1[s0 and $ff] xor T2[s1 shr 8 and $ff] xor T3[s2 shr 16 and $ff] xor T4[s3 shr 24];
**  s0  := pO^ xor pK^; inc(pK); inc(pO);
*)
    s0  :=(T1[s0 and $ff] xor T2[s1 shr 8 and $ff] xor T3[s2 shr 16 and $ff] xor T4[s3 shr 24]) xor pK^; inc(pK); inc(pO);
    s1  := pO^ xor pK^; inc(pK); inc(pO);
    s2  := pO^ xor pK^; inc(pK); inc(pO);
    s3  := pO^ xor pK^; inc(pK);
  end;

  dec(pO,3);  {pO -> BO[0]}

  {Uses Sbox and shl whereas [2] uses Te4 and masks. Needs type cast}
  {Cardinal() for 16 bit compilers: here Sbox is byte, Te4 is Cardinal}
  pO^ := (Cardinal(SBox[s0        and $ff])        xor
          Cardinal(SBox[s1 shr  8 and $ff]) shl  8 xor
          Cardinal(SBox[s2 shr 16 and $ff]) shl 16 xor
          Cardinal(SBox[s3 shr 24])         shl 24    ) xor pK^;
  inc(pO);
  inc(pK);

  pO^ := (Cardinal(SBox[s1        and $ff])        xor
          Cardinal(SBox[s2 shr  8 and $ff]) shl  8 xor
          Cardinal(SBox[s3 shr 16 and $ff]) shl 16 xor
          Cardinal(SBox[s0 shr 24])         shl 24    ) xor pK^;
  inc(pO);
  inc(pK);

  pO^ := (Cardinal(SBox[s2        and $ff])        xor
          Cardinal(SBox[s3 shr  8 and $ff]) shl  8 xor
          Cardinal(SBox[s0 shr 16 and $ff]) shl 16 xor
          Cardinal(SBox[s1 shr 24])         shl 24    ) xor pK^;
  inc(pO);
  inc(pK);

  pO^ := (Cardinal(SBox[s3        and $ff])        xor
          Cardinal(SBox[s0 shr  8 and $ff]) shl  8 xor
          Cardinal(SBox[s1 shr 16 and $ff]) shl 16 xor
          Cardinal(SBox[s2 shr 24])         shl 24    ) xor pK^;

end;

end.
