library MMUsageDll;

{$I FASTCODE_MM.INC}

uses
{$IFDEF MM_BUCKETMM}
  BucketMem // Robert Houdart's BucketMM
{$ENDIF}
{$IFDEF MM_BUCKETMM_ASM}
  BucketMem_Asm // Robert Houdart's BucketMM
{$ENDIF}
{$IFDEF MM_BucketMMDKC_ASM}
  BucketMemDKC_Asm // Robert Houdart's BucketMM with some optimization from Dennis Christensen
{$ENDIF}
{$IFDEF MM_DKCIA32MM}
  DKC_IA32_MM_Unit // Dennis Christensen slowcode entry version 0.18
{$ENDIF}
{$IFDEF MM_EWCMM}
  EWCMM // Eric Carman's EWCMM
{$ENDIF}
{$IFDEF MM_FASTMM2}
  FastMM // Pierre le Riche's Fastcode challenge entry v2.05
{$ENDIF}
{$IFDEF MM_FASTMM3}
  FastMM3 // Pierre le Riche's Fastcode challenge entry v3.01
{$ENDIF}
{$IFDEF MM_FASTMM4}
  FastMM4 // Pierre le Riche's Fastcode challenge entry v4.xx
{$ENDIF}
{$IFDEF MM_FASTMM4_16}
  FastMM4_16 // Pierre le Riche's Fastcode challenge entry v4.xx
{$ENDIF}
{$IFDEF MM_MULTIMM}
  MultiMM // Robert Lee's HPMM
{$ENDIF}
{$IFDEF MM_NEXUSMM}
  nxReplacementMemoryManager // NexusDB Memory Manager
{$ENDIF}
{$IFDEF MM_QMEMORY}
  QMemory // Andrew Driazgov's QMemory
{$ENDIF}
{$IFDEF MM_RECYCLERMM}
  RecyclerMM // Eric Grange's RecyclerMM
{$ENDIF}
{$IFDEF MM_TOPMM}
  TopMemory // Ivo Top's TopMM
{$ENDIF}
{$IFDEF MM_WINMEM}
  WinMem // Mike Lischke's WinMem (Uses the windows heap)
{$ENDIF}

{$IFDEF MM_HEAPMM}
  HeapMM // Vladimir Kladov's HeapMM
{$ENDIF}
{$IFDEF MM_LOCALHEAP}
  LocalHeapMM // Carsten Zeumer's LocalHeapMM (Uses the windows heap)
{$ENDIF}
{$IFDEF MM_PSDMM}
  PSDMemoryManager // Pierre le Riche's PSDMemoryManager v1.xx
{$ENDIF}

// Deliberately cause a compile time error if no valid MM is defined
{$IFNDEF MM_RTLMM},{$ENDIF}

  MMUseMemory in 'MMUseMemory.pas';

{$R *.RES}

exports UseSomeMemory;
exports LeakSomeMemory;

begin
end.
