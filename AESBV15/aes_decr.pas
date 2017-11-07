unit AES_Decr;


(*************************************************************************

 DESCRIPTION     :  AES decrypt functions
                    (not needed for CFB/CTR/OFB mode)

 REQUIREMENTS    :  TP5-7, D1-D7, FPC, VP (Undef BASM16 for 286) [*see note]

 EXTERNAL DATA   :  ---

 MEMORY USAGE    :  ---

 DISPLAY MODE    :  ---

 REFERENCES      :  [1] http://csrc.nist.gov/fips/fips-197.pdf
                    [2] rijndael-alg-fst.c V2.0/3.0: Rijmen et al Aug1999/Dec2000

 Version  Date      Author      Modification
 -------  --------  -------     ------------------------------------------
 0.22     16.08.03  we          Cardinal statt word32
 0.23     16.08.03  we          separate aes_decr
 0.24     16.08.03  we          new xor_block
 0.25     18.09.03  we          Static tables, GF routines from aes_base, D4+
 0.26     20.09.03  we          optimized round code, no more move/if
 0.27     21.09.03  we          with Flag, functions, error codes
 0.28     27.09.03  we          without GFMul and -tables
 0.29     27.09.03  we          FPC/go32v2
 0.30     28.09.03  we          reorder round loop: gain 1 transformation t->block
 0.31     28.09.03  we          merge last xorblock
 0.32     28.09.03  we          two rounds in each loop
 0.33     03.10.03  we          3-para encr/decr
 0.34     03.10.03  we          two local blocks if partial unroll
 0.35     03.10.03  we          BASM for BP7
 0.36     04.10.03  we          remove add di,4
 0.37     05.10.03  we          STD.INC, TP6
 0.38     05.10.03  we          TP5,TP5.5
 0.39     28.12.03  we          DPerm removed
 0.40     29.12.03  we          BASM16: Bugfix if seg(BO)<>ds, xorblock in asm
 0.41     29.12.03  we          Delphi/VP: Pointer version
 0.42     29.12.03  we          InvMixColumn with SBox,T5..T8, Bugfix
 0.43     29.12.03  we          InvMixColumn with TBA4 if not BIT32
 0.44     15.01.04  we          InvMixColumn inline
 0.45     16.01.04  we          MakeDecrKey as BIT32, BASM16, BIT16
 0.46     19.09.04  we/dkc      Cardinals, Delphi4..7 only, no DLL code
                                interfaced procedure MakeDecrKey
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

procedure MakeDecrKey(var ctx: TAES_WE_Context);
  {-Calculate decryption key from encrytion key}

function AES_Init_Decr(const Key; KeyBits: word; var ctx: TAES_WE_Context): integer;
  {-AES key expansion, InvMixColumn(Key) for Decypt, error if invalid key size}

procedure AES_WE_Decrypt(var ctx: TAES_WE_Context; const BI: TAES_WE_Block; var BO: TAES_WE_Block);
  {-decrypt one block (in ECB mode)}

implementation

type
  PLong = ^Cardinal;

const
  InvSBox: array[byte] of byte =
   ($52, $09, $6a, $d5, $30, $36, $a5, $38, $bf, $40, $a3, $9e, $81, $f3, $d7, $fb,
    $7c, $e3, $39, $82, $9b, $2f, $ff, $87, $34, $8e, $43, $44, $c4, $de, $e9, $cb,
    $54, $7b, $94, $32, $a6, $c2, $23, $3d, $ee, $4c, $95, $0b, $42, $fa, $c3, $4e,
    $08, $2e, $a1, $66, $28, $d9, $24, $b2, $76, $5b, $a2, $49, $6d, $8b, $d1, $25,
    $72, $f8, $f6, $64, $86, $68, $98, $16, $d4, $a4, $5c, $cc, $5d, $65, $b6, $92,
    $6c, $70, $48, $50, $fd, $ed, $b9, $da, $5e, $15, $46, $57, $a7, $8d, $9d, $84,
    $90, $d8, $ab, $00, $8c, $bc, $d3, $0a, $f7, $e4, $58, $05, $b8, $b3, $45, $06,
    $d0, $2c, $1e, $8f, $ca, $3f, $0f, $02, $c1, $af, $bd, $03, $01, $13, $8a, $6b,
    $3a, $91, $11, $41, $4f, $67, $dc, $ea, $97, $f2, $cf, $ce, $f0, $b4, $e6, $73,
    $96, $ac, $74, $22, $e7, $ad, $35, $85, $e2, $f9, $37, $e8, $1c, $75, $df, $6e,
    $47, $f1, $1a, $71, $1d, $29, $c5, $89, $6f, $b7, $62, $0e, $aa, $18, $be, $1b,
    $fc, $56, $3e, $4b, $c6, $d2, $79, $20, $9a, $db, $c0, $fe, $78, $cd, $5a, $f4,
    $1f, $dd, $a8, $33, $88, $07, $c7, $31, $b1, $12, $10, $59, $27, $80, $ec, $5f,
    $60, $51, $7f, $a9, $19, $b5, $4a, $0d, $2d, $e5, $7a, $9f, $93, $c9, $9c, $ef,
    $a0, $e0, $3b, $4d, $ae, $2a, $f5, $b0, $c8, $eb, $bb, $3c, $83, $53, $99, $61,
    $17, $2b, $04, $7e, $ba, $77, $d6, $26, $e1, $69, $14, $63, $55, $21, $0c, $7d);

const
  T5: array[byte] of Cardinal =
   ($50a7f451, $5365417e, $c3a4171a, $965e273a, $cb6bab3b, $f1459d1f, $ab58faac, $9303e34b,
    $55fa3020, $f66d76ad, $9176cc88, $254c02f5, $fcd7e54f, $d7cb2ac5, $80443526, $8fa362b5,
    $495ab1de, $671bba25, $980eea45, $e1c0fe5d, $02752fc3, $12f04c81, $a397468d, $c6f9d36b,
    $e75f8f03, $959c9215, $eb7a6dbf, $da595295, $2d83bed4, $d3217458, $2969e049, $44c8c98e,
    $6a89c275, $78798ef4, $6b3e5899, $dd71b927, $b64fe1be, $17ad88f0, $66ac20c9, $b43ace7d,
    $184adf63, $82311ae5, $60335197, $457f5362, $e07764b1, $84ae6bbb, $1ca081fe, $942b08f9,
    $58684870, $19fd458f, $876cde94, $b7f87b52, $23d373ab, $e2024b72, $578f1fe3, $2aab5566,
    $0728ebb2, $03c2b52f, $9a7bc586, $a50837d3, $f2872830, $b2a5bf23, $ba6a0302, $5c8216ed,
    $2b1ccf8a, $92b479a7, $f0f207f3, $a1e2694e, $cdf4da65, $d5be0506, $1f6234d1, $8afea6c4,
    $9d532e34, $a055f3a2, $32e18a05, $75ebf6a4, $39ec830b, $aaef6040, $069f715e, $51106ebd,
    $f98a213e, $3d06dd96, $ae053edd, $46bde64d, $b58d5491, $055dc471, $6fd40604, $ff155060,
    $24fb9819, $97e9bdd6, $cc434089, $779ed967, $bd42e8b0, $888b8907, $385b19e7, $dbeec879,
    $470a7ca1, $e90f427c, $c91e84f8, $00000000, $83868009, $48ed2b32, $ac70111e, $4e725a6c,
    $fbff0efd, $5638850f, $1ed5ae3d, $27392d36, $64d90f0a, $21a65c68, $d1545b9b, $3a2e3624,
    $b1670a0c, $0fe75793, $d296eeb4, $9e919b1b, $4fc5c080, $a220dc61, $694b775a, $161a121c,
    $0aba93e2, $e52aa0c0, $43e0223c, $1d171b12, $0b0d090e, $adc78bf2, $b9a8b62d, $c8a91e14,
    $8519f157, $4c0775af, $bbdd99ee, $fd607fa3, $9f2601f7, $bcf5725c, $c53b6644, $347efb5b,
    $7629438b, $dcc623cb, $68fcedb6, $63f1e4b8, $cadc31d7, $10856342, $40229713, $2011c684,
    $7d244a85, $f83dbbd2, $1132f9ae, $6da129c7, $4b2f9e1d, $f330b2dc, $ec52860d, $d0e3c177,
    $6c16b32b, $99b970a9, $fa489411, $2264e947, $c48cfca8, $1a3ff0a0, $d82c7d56, $ef903322,
    $c74e4987, $c1d138d9, $fea2ca8c, $360bd498, $cf81f5a6, $28de7aa5, $268eb7da, $a4bfad3f,
    $e49d3a2c, $0d927850, $9bcc5f6a, $62467e54, $c2138df6, $e8b8d890, $5ef7392e, $f5afc382,
    $be805d9f, $7c93d069, $a92dd56f, $b31225cf, $3b99acc8, $a77d1810, $6e639ce8, $7bbb3bdb,
    $097826cd, $f418596e, $01b79aec, $a89a4f83, $656e95e6, $7ee6ffaa, $08cfbc21, $e6e815ef,
    $d99be7ba, $ce366f4a, $d4099fea, $d67cb029, $afb2a431, $31233f2a, $3094a5c6, $c066a235,
    $37bc4e74, $a6ca82fc, $b0d090e0, $15d8a733, $4a9804f1, $f7daec41, $0e50cd7f, $2ff69117,
    $8dd64d76, $4db0ef43, $544daacc, $df0496e4, $e3b5d19e, $1b886a4c, $b81f2cc1, $7f516546,
    $04ea5e9d, $5d358c01, $737487fa, $2e410bfb, $5a1d67b3, $52d2db92, $335610e9, $1347d66d,
    $8c61d79a, $7a0ca137, $8e14f859, $893c13eb, $ee27a9ce, $35c961b7, $ede51ce1, $3cb1477a,
    $59dfd29c, $3f73f255, $79ce1418, $bf37c773, $eacdf753, $5baafd5f, $146f3ddf, $86db4478,
    $81f3afca, $3ec468b9, $2c342438, $5f40a3c2, $72c31d16, $0c25e2bc, $8b493c28, $41950dff,
    $7101a839, $deb30c08, $9ce4b4d8, $90c15664, $6184cb7b, $70b632d5, $745c6c48, $4257b8d0);

  T6: array[byte] of Cardinal =
   ($a7f45150, $65417e53, $a4171ac3, $5e273a96, $6bab3bcb, $459d1ff1, $58faacab, $03e34b93,
    $fa302055, $6d76adf6, $76cc8891, $4c02f525, $d7e54ffc, $cb2ac5d7, $44352680, $a362b58f,
    $5ab1de49, $1bba2567, $0eea4598, $c0fe5de1, $752fc302, $f04c8112, $97468da3, $f9d36bc6,
    $5f8f03e7, $9c921595, $7a6dbfeb, $595295da, $83bed42d, $217458d3, $69e04929, $c8c98e44,
    $89c2756a, $798ef478, $3e58996b, $71b927dd, $4fe1beb6, $ad88f017, $ac20c966, $3ace7db4,
    $4adf6318, $311ae582, $33519760, $7f536245, $7764b1e0, $ae6bbb84, $a081fe1c, $2b08f994,
    $68487058, $fd458f19, $6cde9487, $f87b52b7, $d373ab23, $024b72e2, $8f1fe357, $ab55662a,
    $28ebb207, $c2b52f03, $7bc5869a, $0837d3a5, $872830f2, $a5bf23b2, $6a0302ba, $8216ed5c,
    $1ccf8a2b, $b479a792, $f207f3f0, $e2694ea1, $f4da65cd, $be0506d5, $6234d11f, $fea6c48a,
    $532e349d, $55f3a2a0, $e18a0532, $ebf6a475, $ec830b39, $ef6040aa, $9f715e06, $106ebd51,
    $8a213ef9, $06dd963d, $053eddae, $bde64d46, $8d5491b5, $5dc47105, $d406046f, $155060ff,
    $fb981924, $e9bdd697, $434089cc, $9ed96777, $42e8b0bd, $8b890788, $5b19e738, $eec879db,
    $0a7ca147, $0f427ce9, $1e84f8c9, $00000000, $86800983, $ed2b3248, $70111eac, $725a6c4e,
    $ff0efdfb, $38850f56, $d5ae3d1e, $392d3627, $d90f0a64, $a65c6821, $545b9bd1, $2e36243a,
    $670a0cb1, $e757930f, $96eeb4d2, $919b1b9e, $c5c0804f, $20dc61a2, $4b775a69, $1a121c16,
    $ba93e20a, $2aa0c0e5, $e0223c43, $171b121d, $0d090e0b, $c78bf2ad, $a8b62db9, $a91e14c8,
    $19f15785, $0775af4c, $dd99eebb, $607fa3fd, $2601f79f, $f5725cbc, $3b6644c5, $7efb5b34,
    $29438b76, $c623cbdc, $fcedb668, $f1e4b863, $dc31d7ca, $85634210, $22971340, $11c68420,
    $244a857d, $3dbbd2f8, $32f9ae11, $a129c76d, $2f9e1d4b, $30b2dcf3, $52860dec, $e3c177d0,
    $16b32b6c, $b970a999, $489411fa, $64e94722, $8cfca8c4, $3ff0a01a, $2c7d56d8, $903322ef,
    $4e4987c7, $d138d9c1, $a2ca8cfe, $0bd49836, $81f5a6cf, $de7aa528, $8eb7da26, $bfad3fa4,
    $9d3a2ce4, $9278500d, $cc5f6a9b, $467e5462, $138df6c2, $b8d890e8, $f7392e5e, $afc382f5,
    $805d9fbe, $93d0697c, $2dd56fa9, $1225cfb3, $99acc83b, $7d1810a7, $639ce86e, $bb3bdb7b,
    $7826cd09, $18596ef4, $b79aec01, $9a4f83a8, $6e95e665, $e6ffaa7e, $cfbc2108, $e815efe6,
    $9be7bad9, $366f4ace, $099fead4, $7cb029d6, $b2a431af, $233f2a31, $94a5c630, $66a235c0,
    $bc4e7437, $ca82fca6, $d090e0b0, $d8a73315, $9804f14a, $daec41f7, $50cd7f0e, $f691172f,
    $d64d768d, $b0ef434d, $4daacc54, $0496e4df, $b5d19ee3, $886a4c1b, $1f2cc1b8, $5165467f,
    $ea5e9d04, $358c015d, $7487fa73, $410bfb2e, $1d67b35a, $d2db9252, $5610e933, $47d66d13,
    $61d79a8c, $0ca1377a, $14f8598e, $3c13eb89, $27a9ceee, $c961b735, $e51ce1ed, $b1477a3c,
    $dfd29c59, $73f2553f, $ce141879, $37c773bf, $cdf753ea, $aafd5f5b, $6f3ddf14, $db447886,
    $f3afca81, $c468b93e, $3424382c, $40a3c25f, $c31d1672, $25e2bc0c, $493c288b, $950dff41,
    $01a83971, $b30c08de, $e4b4d89c, $c1566490, $84cb7b61, $b632d570, $5c6c4874, $57b8d042);

  T7: array[byte] of Cardinal =
   ($f45150a7, $417e5365, $171ac3a4, $273a965e, $ab3bcb6b, $9d1ff145, $faacab58, $e34b9303,
    $302055fa, $76adf66d, $cc889176, $02f5254c, $e54ffcd7, $2ac5d7cb, $35268044, $62b58fa3,
    $b1de495a, $ba25671b, $ea45980e, $fe5de1c0, $2fc30275, $4c8112f0, $468da397, $d36bc6f9,
    $8f03e75f, $9215959c, $6dbfeb7a, $5295da59, $bed42d83, $7458d321, $e0492969, $c98e44c8,
    $c2756a89, $8ef47879, $58996b3e, $b927dd71, $e1beb64f, $88f017ad, $20c966ac, $ce7db43a,
    $df63184a, $1ae58231, $51976033, $5362457f, $64b1e077, $6bbb84ae, $81fe1ca0, $08f9942b,
    $48705868, $458f19fd, $de94876c, $7b52b7f8, $73ab23d3, $4b72e202, $1fe3578f, $55662aab,
    $ebb20728, $b52f03c2, $c5869a7b, $37d3a508, $2830f287, $bf23b2a5, $0302ba6a, $16ed5c82,
    $cf8a2b1c, $79a792b4, $07f3f0f2, $694ea1e2, $da65cdf4, $0506d5be, $34d11f62, $a6c48afe,
    $2e349d53, $f3a2a055, $8a0532e1, $f6a475eb, $830b39ec, $6040aaef, $715e069f, $6ebd5110,
    $213ef98a, $dd963d06, $3eddae05, $e64d46bd, $5491b58d, $c471055d, $06046fd4, $5060ff15,
    $981924fb, $bdd697e9, $4089cc43, $d967779e, $e8b0bd42, $8907888b, $19e7385b, $c879dbee,
    $7ca1470a, $427ce90f, $84f8c91e, $00000000, $80098386, $2b3248ed, $111eac70, $5a6c4e72,
    $0efdfbff, $850f5638, $ae3d1ed5, $2d362739, $0f0a64d9, $5c6821a6, $5b9bd154, $36243a2e,
    $0a0cb167, $57930fe7, $eeb4d296, $9b1b9e91, $c0804fc5, $dc61a220, $775a694b, $121c161a,
    $93e20aba, $a0c0e52a, $223c43e0, $1b121d17, $090e0b0d, $8bf2adc7, $b62db9a8, $1e14c8a9,
    $f1578519, $75af4c07, $99eebbdd, $7fa3fd60, $01f79f26, $725cbcf5, $6644c53b, $fb5b347e,
    $438b7629, $23cbdcc6, $edb668fc, $e4b863f1, $31d7cadc, $63421085, $97134022, $c6842011,
    $4a857d24, $bbd2f83d, $f9ae1132, $29c76da1, $9e1d4b2f, $b2dcf330, $860dec52, $c177d0e3,
    $b32b6c16, $70a999b9, $9411fa48, $e9472264, $fca8c48c, $f0a01a3f, $7d56d82c, $3322ef90,
    $4987c74e, $38d9c1d1, $ca8cfea2, $d498360b, $f5a6cf81, $7aa528de, $b7da268e, $ad3fa4bf,
    $3a2ce49d, $78500d92, $5f6a9bcc, $7e546246, $8df6c213, $d890e8b8, $392e5ef7, $c382f5af,
    $5d9fbe80, $d0697c93, $d56fa92d, $25cfb312, $acc83b99, $1810a77d, $9ce86e63, $3bdb7bbb,
    $26cd0978, $596ef418, $9aec01b7, $4f83a89a, $95e6656e, $ffaa7ee6, $bc2108cf, $15efe6e8,
    $e7bad99b, $6f4ace36, $9fead409, $b029d67c, $a431afb2, $3f2a3123, $a5c63094, $a235c066,
    $4e7437bc, $82fca6ca, $90e0b0d0, $a73315d8, $04f14a98, $ec41f7da, $cd7f0e50, $91172ff6,
    $4d768dd6, $ef434db0, $aacc544d, $96e4df04, $d19ee3b5, $6a4c1b88, $2cc1b81f, $65467f51,
    $5e9d04ea, $8c015d35, $87fa7374, $0bfb2e41, $67b35a1d, $db9252d2, $10e93356, $d66d1347,
    $d79a8c61, $a1377a0c, $f8598e14, $13eb893c, $a9ceee27, $61b735c9, $1ce1ede5, $477a3cb1,
    $d29c59df, $f2553f73, $141879ce, $c773bf37, $f753eacd, $fd5f5baa, $3ddf146f, $447886db,
    $afca81f3, $68b93ec4, $24382c34, $a3c25f40, $1d1672c3, $e2bc0c25, $3c288b49, $0dff4195,
    $a8397101, $0c08deb3, $b4d89ce4, $566490c1, $cb7b6184, $32d570b6, $6c48745c, $b8d04257);

  T8: array[byte] of Cardinal =
   ($5150a7f4, $7e536541, $1ac3a417, $3a965e27, $3bcb6bab, $1ff1459d, $acab58fa, $4b9303e3,
    $2055fa30, $adf66d76, $889176cc, $f5254c02, $4ffcd7e5, $c5d7cb2a, $26804435, $b58fa362,
    $de495ab1, $25671bba, $45980eea, $5de1c0fe, $c302752f, $8112f04c, $8da39746, $6bc6f9d3,
    $03e75f8f, $15959c92, $bfeb7a6d, $95da5952, $d42d83be, $58d32174, $492969e0, $8e44c8c9,
    $756a89c2, $f478798e, $996b3e58, $27dd71b9, $beb64fe1, $f017ad88, $c966ac20, $7db43ace,
    $63184adf, $e582311a, $97603351, $62457f53, $b1e07764, $bb84ae6b, $fe1ca081, $f9942b08,
    $70586848, $8f19fd45, $94876cde, $52b7f87b, $ab23d373, $72e2024b, $e3578f1f, $662aab55,
    $b20728eb, $2f03c2b5, $869a7bc5, $d3a50837, $30f28728, $23b2a5bf, $02ba6a03, $ed5c8216,
    $8a2b1ccf, $a792b479, $f3f0f207, $4ea1e269, $65cdf4da, $06d5be05, $d11f6234, $c48afea6,
    $349d532e, $a2a055f3, $0532e18a, $a475ebf6, $0b39ec83, $40aaef60, $5e069f71, $bd51106e,
    $3ef98a21, $963d06dd, $ddae053e, $4d46bde6, $91b58d54, $71055dc4, $046fd406, $60ff1550,
    $1924fb98, $d697e9bd, $89cc4340, $67779ed9, $b0bd42e8, $07888b89, $e7385b19, $79dbeec8,
    $a1470a7c, $7ce90f42, $f8c91e84, $00000000, $09838680, $3248ed2b, $1eac7011, $6c4e725a,
    $fdfbff0e, $0f563885, $3d1ed5ae, $3627392d, $0a64d90f, $6821a65c, $9bd1545b, $243a2e36,
    $0cb1670a, $930fe757, $b4d296ee, $1b9e919b, $804fc5c0, $61a220dc, $5a694b77, $1c161a12,
    $e20aba93, $c0e52aa0, $3c43e022, $121d171b, $0e0b0d09, $f2adc78b, $2db9a8b6, $14c8a91e,
    $578519f1, $af4c0775, $eebbdd99, $a3fd607f, $f79f2601, $5cbcf572, $44c53b66, $5b347efb,
    $8b762943, $cbdcc623, $b668fced, $b863f1e4, $d7cadc31, $42108563, $13402297, $842011c6,
    $857d244a, $d2f83dbb, $ae1132f9, $c76da129, $1d4b2f9e, $dcf330b2, $0dec5286, $77d0e3c1,
    $2b6c16b3, $a999b970, $11fa4894, $472264e9, $a8c48cfc, $a01a3ff0, $56d82c7d, $22ef9033,
    $87c74e49, $d9c1d138, $8cfea2ca, $98360bd4, $a6cf81f5, $a528de7a, $da268eb7, $3fa4bfad,
    $2ce49d3a, $500d9278, $6a9bcc5f, $5462467e, $f6c2138d, $90e8b8d8, $2e5ef739, $82f5afc3,
    $9fbe805d, $697c93d0, $6fa92dd5, $cfb31225, $c83b99ac, $10a77d18, $e86e639c, $db7bbb3b,
    $cd097826, $6ef41859, $ec01b79a, $83a89a4f, $e6656e95, $aa7ee6ff, $2108cfbc, $efe6e815,
    $bad99be7, $4ace366f, $ead4099f, $29d67cb0, $31afb2a4, $2a31233f, $c63094a5, $35c066a2,
    $7437bc4e, $fca6ca82, $e0b0d090, $3315d8a7, $f14a9804, $41f7daec, $7f0e50cd, $172ff691,
    $768dd64d, $434db0ef, $cc544daa, $e4df0496, $9ee3b5d1, $4c1b886a, $c1b81f2c, $467f5165,
    $9d04ea5e, $015d358c, $fa737487, $fb2e410b, $b35a1d67, $9252d2db, $e9335610, $6d1347d6,
    $9a8c61d7, $377a0ca1, $598e14f8, $eb893c13, $ceee27a9, $b735c961, $e1ede51c, $7a3cb147,
    $9c59dfd2, $553f73f2, $1879ce14, $73bf37c7, $53eacdf7, $5f5baafd, $df146f3d, $7886db44,
    $ca81f3af, $b93ec468, $382c3424, $c25f40a3, $1672c31d, $bc0c25e2, $288b493c, $ff41950d,
    $397101a8, $08deb30c, $d89ce4b4, $6490c156, $7b6184cb, $d570b632, $48745c6c, $d04257b8);


{---------------------------------------------------------------------------}
procedure MakeDecrKey(var ctx: TAES_WE_Context);
  {-Calculate decryption key from encrytion key}
var
  i: integer;
  p: PLong;
  x: Cardinal;
begin
  p := PLong(@ctx.RK[1]);
  for i:=1 to 4*(ctx.Rounds-1) do begin
    x  := p^;
    p^ := T8[SBox[x shr 24]] xor T7[SBox[x shr 16 and $ff]] xor T6[SBox[x shr 8 and $ff]] xor T5[SBox[x and $ff]];
    inc(p);
  end;
end;

{---------------------------------------------------------------------------}
function AES_Init_Decr(const Key; KeyBits: word; var ctx: TAES_WE_Context): integer;
  {-AES key expansion, InvMixColumn(Key) for decrypt, error if invalid key size}
begin
  AES_Init_Decr := AES_Init(Key, KeyBits, ctx);
  MakeDecrKey(ctx);
  ctx.Decrypt := 1;
end;


{Normally used for Delphi, VP (and during development BP7)}

{---------------------------------------------------------------------------}
procedure AES_WE_Decrypt(var ctx: TAES_WE_Context; const BI: TAES_WE_Block; var BO: TAES_WE_Block);
  {-decrypt one block (in ECB mode)}
var
  r: integer;             {round loop countdown counter     }
  pK,pO: PLong;           {pointer to RK[] and and BO[]     }
  s0,s1,s2,s3: Cardinal;  {TAESBlock s as separate variables}
begin

  pK := PLong(@ctx.RK[ctx.Rounds]);
  pO := PLong(@BO);

  s0 := TWA4(BI)[0] xor pK^; inc(pK);
  s1 := TWA4(BI)[1] xor pK^; inc(pK);
  s2 := TWA4(BI)[2] xor pK^; inc(pK);
  s3 := TWA4(BI)[3] xor pK^; dec(pK,4);

  for r:=ctx.Rounds-1 downto 1 do begin
    {pO -> BO[0]}
    pO^ := T5[s0 and $ff] xor T6[s3 shr 8 and $ff] xor T7[s2 shr 16 and $ff] xor T8[s1 shr 24]; inc(PO);
    pO^ := T5[s1 and $ff] xor T6[s0 shr 8 and $ff] xor T7[s3 shr 16 and $ff] xor T8[s2 shr 24]; inc(pO);
    pO^ := T5[s2 and $ff] xor T6[s1 shr 8 and $ff] xor T7[s0 shr 16 and $ff] xor T8[s3 shr 24]; inc(pO);
(*
**  Next to statements can be merged:
**  pO^ := T5[s3 and $ff] xor T6[s2 shr 8 and $ff] xor T7[s1 shr 16 and $ff] xor T8[s0 shr 24];
**  s3  := pO^ xor pK^; dec(pK); dec(pO);}
*)
    s3  :=(T5[s3 and $ff] xor T6[s2 shr 8 and $ff] xor T7[s1 shr 16 and $ff] xor T8[s0 shr 24]) xor PK^;  dec(pK); dec(pO);
    s2  := pO^ xor pK^; dec(pK); dec(pO);
    s1  := pO^ xor pK^; dec(pK); dec(pO);
    s0  := pO^ xor pK^; dec(pK);
  end;

  inc(pO,3); {pO -> BO[3]}

  {Uses InvSbox and shl whereas [2] uses Td4 and masks. Needs type cast}
  {Cardinal() for 16 bit compilers: here InvSbox is byte, Td4 is Cardinal}
  pO^ := (Cardinal(InvSBox[s3 and $ff       ])        xor
          Cardinal(InvSBox[s2 shr  8 and $ff]) shl  8 xor
          Cardinal(InvSBox[s1 shr 16 and $ff]) shl 16 xor
          Cardinal(InvSBox[s0 shr 24        ]) shl 24    ) xor pK^;
  dec(PO);
  Dec(pK);

  pO^ := (Cardinal(InvSBox[s2 and $ff       ])        xor
          Cardinal(InvSBox[s1 shr  8 and $ff]) shl  8 xor
          Cardinal(InvSBox[s0 shr 16 and $ff]) shl 16 xor
          Cardinal(InvSBox[s3 shr 24        ]) shl 24    ) xor pK^;
  dec(PO);
  Dec(pK);

  pO^ := (Cardinal(InvSBox[s1        and $ff])        xor
          Cardinal(InvSBox[s0 shr  8 and $ff]) shl  8 xor
          Cardinal(InvSBox[s3 shr 16 and $ff]) shl 16 xor
          Cardinal(InvSBox[s2 shr 24        ]) shl 24    ) xor pK^;
  dec(PO);
  Dec(pK);

  pO^ := (Cardinal(InvSBox[s0        and $ff])        xor
          Cardinal(InvSBox[s3 shr  8 and $ff]) shl  8 xor
          Cardinal(InvSBox[s2 shr 16 and $ff]) shl 16 xor
          Cardinal(InvSBox[s1 shr 24        ]) shl 24    ) xor pK^;

end;

end.
