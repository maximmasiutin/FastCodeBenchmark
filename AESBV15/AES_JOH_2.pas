unit AES_JOH_2;

interface

procedure InitAES_JOH_PAS_2(const Key; KeySize: cardinal);
procedure EncryptAES_JOH_PAS_2(var Block);
procedure DecryptAES_JOH_PAS_2(var Block);

implementation

uses
  SysUtils;

const
  SB: array[Byte] of Byte =
   ($63, $7c, $77, $7b, $f2, $6b, $6f, $c5, $30, $01, $67, $2b, $fe, $d7, $ab, $76,
    $ca, $82, $c9, $7d, $fa, $59, $47, $f0, $ad, $d4, $a2, $af, $9c, $a4, $72, $c0,
    $b7, $fd, $93, $26, $36, $3f, $f7, $cc, $34, $a5, $e5, $f1, $71, $d8, $31, $15,
    $04, $c7, $23, $c3, $18, $96, $05, $9a, $07, $12, $80, $e2, $eb, $27, $b2, $75,
    $09, $83, $2c, $1a, $1b, $6e, $5a, $a0, $52, $3b, $d6, $b3, $29, $e3, $2f, $84,
    $53, $d1, $00, $ed, $20, $fc, $b1, $5b, $6a, $cb, $be, $39, $4a, $4c, $58, $cf,
    $d0, $ef, $aa, $fb, $43, $4d, $33, $85, $45, $f9, $02, $7f, $50, $3c, $9f, $a8,
    $51, $a3, $40, $8f, $92, $9d, $38, $f5, $bc, $b6, $da, $21, $10, $ff, $f3, $d2,
    $cd, $0c, $13, $ec, $5f, $97, $44, $17, $c4, $a7, $7e, $3d, $64, $5d, $19, $73,
    $60, $81, $4f, $dc, $22, $2a, $90, $88, $46, $ee, $b8, $14, $de, $5e, $0b, $db,
    $e0, $32, $3a, $0a, $49, $06, $24, $5c, $c2, $d3, $ac, $62, $91, $95, $e4, $79,
    $e7, $c8, $37, $6d, $8d, $d5, $4e, $a9, $6c, $56, $f4, $ea, $65, $7a, $ae, $08,
    $ba, $78, $25, $2e, $1c, $a6, $b4, $c6, $e8, $dd, $74, $1f, $4b, $bd, $8b, $8a,
    $70, $3e, $b5, $66, $48, $03, $f6, $0e, $61, $35, $57, $b9, $86, $c1, $1d, $9e,
    $e1, $f8, $98, $11, $69, $d9, $8e, $94, $9b, $1e, $87, $e9, $ce, $55, $28, $df,
    $8c, $a1, $89, $0d, $bf, $e6, $42, $68, $41, $99, $2d, $0f, $b0, $54, $bb, $16);

  SI: array[Byte] of Byte =
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

  TE: array[0..1023] of Cardinal =
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
    $c3414182, $b0999929, $772d2d5a, $110f0f1e, $cbb0b07b, $fc5454a8, $d6bbbb6d, $3a16162c,
    $6363c6a5, $7c7cf884, $7777ee99, $7b7bf68d, $f2f2ff0d, $6b6bd6bd, $6f6fdeb1, $c5c59154,
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
    $414182c3, $999929b0, $2d2d5a77, $0f0f1e11, $b0b07bcb, $5454a8fc, $bbbb6dd6, $16162c3a,
    $63c6a563, $7cf8847c, $77ee9977, $7bf68d7b, $f2ff0df2, $6bd6bd6b, $6fdeb16f, $c59154c5,
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
    $4182c341, $9929b099, $2d5a772d, $0f1e110f, $b07bcbb0, $54a8fc54, $bb6dd6bb, $162c3a16,
    $c6a56363, $f8847c7c, $ee997777, $f68d7b7b, $ff0df2f2, $d6bd6b6b, $deb16f6f, $9154c5c5,
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

  TD: array[0..1023] of Cardinal =
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
    $7101a839, $deb30c08, $9ce4b4d8, $90c15664, $6184cb7b, $70b632d5, $745c6c48, $4257b8d0,
    $a7f45150, $65417e53, $a4171ac3, $5e273a96, $6bab3bcb, $459d1ff1, $58faacab, $03e34b93,
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
    $01a83971, $b30c08de, $e4b4d89c, $c1566490, $84cb7b61, $b632d570, $5c6c4874, $57b8d042,
    $f45150a7, $417e5365, $171ac3a4, $273a965e, $ab3bcb6b, $9d1ff145, $faacab58, $e34b9303,
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
    $a8397101, $0c08deb3, $b4d89ce4, $566490c1, $cb7b6184, $32d570b6, $6c48745c, $b8d04257,
    $5150a7f4, $7e536541, $1ac3a417, $3a965e27, $3bcb6bab, $1ff1459d, $acab58fa, $4b9303e3,
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

type
  AESBlock  = packed array[0.. 3] of Cardinal;
  TKeyArray = packed array[0..99] of Cardinal;
  PKeyArray = ^TKeyArray;

var
  EncryptKey, DecryptKey : packed array[0..14] of AESBlock;
  AESRounds              : Cardinal;

procedure InitAES_JOH_PAS_2(const Key; KeySize: Cardinal);
const
  RCon: packed array[0..9] of Cardinal = ($01,$02,$04,$08,$10,$20,$40,$80,$1B,$36);
var
  I, K : Cardinal;
  PD   : PCardinal;
  PK   : PKeyArray;
begin
  if (KeySize <> 4) and (KeySize <> 6) and (KeySize <> 8) then
    raise Exception.Create('AES Init Failed');
  PK := Pointer(@EncryptKey);
  Move(Key, PK^, 4*KeySize);
  case KeySize of
    4  : begin
           AESRounds := 10;
           for I := 0 to 9 do
             begin
               K := PK[3];
               PK[4] := SB[(K shr  8) and $ff]        or
                        SB[(K shr 16) and $ff] shl  8 or
                        SB[(K shr 24)        ] shl 16 or
                        SB[(K       ) and $ff] shl 24 xor PK[0] xor RCon[I];
               PK[5] := PK[1] xor PK[4];
               PK[6] := PK[2] xor PK[5];
               PK[7] := PK[3] xor PK[6];
               Inc(Cardinal(PK), 4 * SizeOf(Cardinal));
             end;
         end;
    6  : begin
           AESRounds := 12;
           for I := 0 to 7 do
             begin
               K := PK[5];
               PK[6] := SB[(K shr  8) and $ff]        or
                        SB[(K shr 16) and $ff] shl  8 or
                        SB[(K shr 24)        ] shl 16 or
                        SB[(K       ) and $ff] shl 24 xor PK[0] xor RCon[I];
               PK[7] := PK[1] xor PK[6];
               PK[8] := PK[2] xor PK[7];
               PK[9] := PK[3] xor PK[8];
               if I = 7 then
                 Break;
               PK[10] := PK[4] xor PK[ 9];
               PK[11] := PK[5] xor PK[10];
               Inc(Cardinal(PK), 6 * SizeOf(Cardinal));
             end;
         end;
    else begin
           AESRounds := 14;
           for I := 0 to 6 do
             begin
               K := PK[7];
               PK[ 8] := SB[(K shr  8) and $ff]        or
                         SB[(K shr 16) and $ff] shl  8 or
                         SB[(K shr 24)        ] shl 16 or
                         SB[(K       ) and $ff] shl 24 xor PK[0] xor RCon[I];
               PK[ 9] := PK[1] xor PK[ 8];
               PK[10] := PK[2] xor PK[ 9];
               PK[11] := PK[3] xor PK[10];
               if I = 6 then
                 Break;
               K := PK[11];
               PK[12] := SB[(K       ) and $ff]        or
                         SB[(K shr  8) and $ff] shl  8 or
                         SB[(K shr 16) and $ff] shl 16 or
                         SB[(K shr 24)        ] shl 24 xor PK[4];
               PK[13] := PK[5] xor PK[12];
               PK[14] := PK[6] xor PK[13];
               PK[15] := PK[7] xor PK[14];
               Inc(Cardinal(PK), 8 * SizeOf(Cardinal));
             end;
         end;
  end;
  DecryptKey := EncryptKey;
  PD := PCardinal(@DecryptKey[1]);
  for I := 1 to 4*(AESRounds-1) do
    begin
      PD^ := TD[SB[PD^        and $ff]       ] xor
             TD[SB[PD^ shr  8 and $ff] + $100] xor
             TD[SB[PD^ shr 16 and $ff] + $200] xor
             TD[SB[PD^ shr 24        ] + $300];
      Inc(PD);
    end;
end;
                    
procedure EncryptAES_JOH_PAS_2(var Block);
var
  B  : AESBlock absolute Block;
  I  : Cardinal;
  PK : PKeyArray;
  b0, b1, b2, b3 : Cardinal;
  s0, s1, s2, s3 : Cardinal;
begin
  PK := @EncryptKey;
  s0 := B[0] xor PK[0];
  s1 := B[1] xor PK[1];
  s2 := B[2] xor PK[2];
  s3 := B[3] xor PK[3];
  Inc(Cardinal(PK), 4 * SizeOf(Cardinal));
      b0 := TE[s0 and $ff] xor TE[s1 shr 8 and $ff + $100] xor TE[s2 shr 16 and $ff + $200] xor TE[s3 shr 24 + $300];
      b1 := TE[s1 and $ff] xor TE[s2 shr 8 and $ff + $100] xor TE[s3 shr 16 and $ff + $200] xor TE[s0 shr 24 + $300];
      b2 := TE[s2 and $ff] xor TE[s3 shr 8 and $ff + $100] xor TE[s0 shr 16 and $ff + $200] xor TE[s1 shr 24 + $300];
      b3 := TE[s3 and $ff] xor TE[s0 shr 8 and $ff + $100] xor TE[s1 shr 16 and $ff + $200] xor TE[s2 shr 24 + $300];
      s0 := b0 xor PK[0];
      s1 := b1 xor PK[1];
      s2 := b2 xor PK[2];
      s3 := b3 xor PK[3];
      Inc(Cardinal(PK), 4 * SizeOf(Cardinal));
  for I := 1 to (AESRounds-2) div 2 do
    begin
      b0 := TE[s0 and $ff] xor TE[s1 shr 8 and $ff + $100] xor TE[s2 shr 16 and $ff + $200] xor TE[s3 shr 24 + $300] xor PK[0];
      b1 := TE[s1 and $ff] xor TE[s2 shr 8 and $ff + $100] xor TE[s3 shr 16 and $ff + $200] xor TE[s0 shr 24 + $300] xor PK[1];
      b2 := TE[s2 and $ff] xor TE[s3 shr 8 and $ff + $100] xor TE[s0 shr 16 and $ff + $200] xor TE[s1 shr 24 + $300] xor PK[2];
      b3 := TE[s3 and $ff] xor TE[s0 shr 8 and $ff + $100] xor TE[s1 shr 16 and $ff + $200] xor TE[s2 shr 24 + $300] xor PK[3];
      s0 := TE[b0 and $ff] xor TE[b1 shr 8 and $ff + $100] xor TE[b2 shr 16 and $ff + $200] xor TE[b3 shr 24 + $300] xor PK[4];
      s1 := TE[b1 and $ff] xor TE[b2 shr 8 and $ff + $100] xor TE[b3 shr 16 and $ff + $200] xor TE[b0 shr 24 + $300] xor PK[5];
      s2 := TE[b2 and $ff] xor TE[b3 shr 8 and $ff + $100] xor TE[b0 shr 16 and $ff + $200] xor TE[b1 shr 24 + $300] xor PK[6];
      s3 := TE[b3 and $ff] xor TE[b0 shr 8 and $ff + $100] xor TE[b1 shr 16 and $ff + $200] xor TE[b2 shr 24 + $300] xor PK[7];
      Inc(Cardinal(PK), 8 * SizeOf(Cardinal));
    end;
  B[0] := (SB[s0        and $ff]        or
           SB[s1 shr  8 and $ff] shl  8 or
           SB[s2 shr 16 and $ff] shl 16 or
           SB[s3 shr 24        ] shl 24) xor PK[0];
  B[1] := (SB[s1        and $ff]        or
           SB[s2 shr  8 and $ff] shl  8 or
           SB[s3 shr 16 and $ff] shl 16 or
           SB[s0 shr 24        ] shl 24) xor PK[1];
  B[2] := (SB[s2        and $ff]        or
           SB[s3 shr  8 and $ff] shl  8 or
           SB[s0 shr 16 and $ff] shl 16 or
           SB[s1 shr 24        ] shl 24) xor PK[2];
  B[3] := (SB[s3        and $ff]        or
           SB[s0 shr  8 and $ff] shl  8 or
           SB[s1 shr 16 and $ff] shl 16 or
           SB[s2 shr 24        ] shl 24) xor PK[3];
end; {AES_Encrypt}

procedure DecryptAES_JOH_PAS_2(var Block);
var
  B  : AESBlock absolute Block;
  I  : Cardinal;
  PK : PKeyArray;
  b0, b1, b2, b3 : Cardinal;
  s0, s1, s2, s3 : Cardinal;
begin
  PK := Pointer(@DecryptKey[AESRounds]);
  s0 := B[0] xor PK[0];
  s1 := B[1] xor PK[1];
  s2 := B[2] xor PK[2];
  s3 := B[3] xor PK[3];
  Dec(Cardinal(PK), 4 * SizeOf(Cardinal));
  for I := 1 to AESRounds-1 do
    begin
      b0 := TD[s0 and $ff] xor TD[s3 shr 8 and $ff + $100] xor TD[s2 shr 16 and $ff + $200] xor TD[s1 shr 24 + $300];
      b1 := TD[s1 and $ff] xor TD[s0 shr 8 and $ff + $100] xor TD[s3 shr 16 and $ff + $200] xor TD[s2 shr 24 + $300];
      b2 := TD[s2 and $ff] xor TD[s1 shr 8 and $ff + $100] xor TD[s0 shr 16 and $ff + $200] xor TD[s3 shr 24 + $300];
      b3 := TD[s3 and $ff] xor TD[s2 shr 8 and $ff + $100] xor TD[s1 shr 16 and $ff + $200] xor TD[s0 shr 24 + $300];
      s0 := b0 xor PK[0];
      s1 := b1 xor PK[1];                     
      s2 := b2 xor PK[2];
      s3 := b3 xor PK[3];
      Dec(Cardinal(PK), 4 * SizeOf(Cardinal));
    end;
  B[0] := (SI[s0        and $ff]        or
           SI[s3 shr  8 and $ff] shl  8 or
           SI[s2 shr 16 and $ff] shl 16 or
           SI[s1 shr 24        ] shl 24) xor PK[0];
  B[1] := (SI[s1        and $ff]        or
           SI[s0 shr  8 and $ff] shl  8 or
           SI[s3 shr 16 and $ff] shl 16 or
           SI[s2 shr 24        ] shl 24) xor PK[1];
  B[2] := (SI[s2 and $ff       ]        or
           SI[s1 shr  8 and $ff] shl  8 or
           SI[s0 shr 16 and $ff] shl 16 or
           SI[s3 shr 24        ] shl 24) xor PK[2];
  B[3] := (SI[s3 and $ff       ]        or
           SI[s2 shr  8 and $ff] shl  8 or
           SI[s1 shr 16 and $ff] shl 16 or
           SI[s0 shr 24        ] shl 24) xor PK[3];
end; {AES_Decrypt}

end.
