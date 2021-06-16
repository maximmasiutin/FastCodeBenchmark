program FastcodeMMChallengeBV;

(*

Fastcode Memory Manager Benchmark and Validation Tool 
Support for the Win64 platform added by Maxim Masiutin <maxim@masiutin.com>

Version 3.0.2

Copyright (C) 2003-2013 Dennis Kjaer Christensen and contributors. All rights reserved
Copyright (C) 2017-2021 Maxim Masiutin. All rights reserved

See the file ReleaseNotes.txt for more details

*)


{$I FASTCODE_MM.INC}

uses
{$IFDEF MM_FASTMM5}
  FastMM5 // Pierre le Riche's Fastcode challenge entry v5.xx
{$ENDIF}
{$IFDEF MM_FASTMM4_AVX}
  FastMM4 // FastMM4-AVX
{$ENDIF}
{$IFDEF MM_FASTMM4}
  FastMM4 // Pierre le Riche's Fastcode challenge entry v4.xx
{$ENDIF}
//  {Must be first to measure the initial VM Usage}
//  BenchmarkUtilities in 'BenchmarkUtilities.pas',
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

  // FastMove,   // uncomment if you want to benchmark with FastMove
  {Other units}
  SelfTest in 'SelfTest.pas',
  PrimeNumbers in 'PrimeNumbers.pas' {fBenchmark},
  BenchmarkForm in 'BenchmarkForm.pas' {fBenchmark},
  RenameMMForm in 'RenameMMForm.pas' {fRenameMM},
  FragmentationTestUnit in 'FragmentationTestUnit.pas',
  NexusDBBenchmarkUnit in 'NexusDBBenchmarkUnit.pas',
  ReallocMemBenchmark in 'ReallocMemBenchmark.pas',
  DownsizeTestUnit in 'DownsizeTestUnit.pas',
  ReplayBenchmarkUnit in 'ReplayBenchmarkUnit.pas',
  WildThreadsBenchmarkUnit in 'WildThreadsBenchmarkUnit.pas',
  BlockSizeSpreadBenchmark in 'BlockSizeSpreadBenchmark.pas',
  SmallUpsizeBenchmark in 'SmallUpsizeBenchmark.pas',
  SmallDownsizeBenchmark in 'SmallDownsizeBenchmark.pas',
  RawPerformanceSingleThread in 'RawPerformanceSingleThread.pas',
  RawPerformanceMultiThread in 'RawPerformanceMultiThread.pas',
  AddressSpaceCreepBenchmark in 'AddressSpaceCreepBenchmark.pas',
  LargeBlockSpreadBenchmark in 'LargeBlockSpreadBenchmark.pas',
  StringThread in 'StringThread.pas',
  StringThreadTestUnit in 'StringThreadTestUnit.pas',
  ArrayUpsizeSingleThread in 'ArrayUpsizeSingleThread.pas',
  SingleFPBenchmark1Unit in 'SingleFPBenchmark1Unit.pas',
  SingleFPBenchmark2Unit in 'SingleFPBenchmark2Unit.pas',
  DoubleFPBenchmark1Unit in 'DoubleFPBenchmark1Unit.pas',
  DoubleFPBenchmark2Unit in 'DoubleFPBenchmark2Unit.pas',
  DoubleFPBenchmark3Unit in 'DoubleFPBenchmark3Unit.pas',
  MoveBenchmark1Unit in 'MoveBenchmark1Unit.pas',
  MoveBenchmark2Unit in 'MoveBenchmark2Unit.pas',
  AddressSpaceCreepBenchmarkLarge in 'AddressSpaceCreepBenchmarkLarge.pas',
  LinkedListBenchmark in 'LinkedListBenchmark.pas',
  BenchmarkClassUnit in 'BenchmarkClassUnit.pas',
  MultiThreadedAllocAndFree in 'MultiThreadedAllocAndFree.pas',
  MultiThreadedReallocate in 'MultiThreadedReallocate.pas',
  SingleThreadedAllocAndFree in 'SingleThreadedAllocAndFree.pas',
  SingleThreadedReallocate in 'SingleThreadedReallocate.pas',
  SortIntArrayBenchmark2Unit in 'SortIntArrayBenchmark2Unit.pas',
  SortExtendedArrayBenchmark2Unit in 'SortExtendedArrayBenchmark2Unit.pas',
  SingleThreadedAllocMem in 'SingleThreadedAllocMem.pas',
  MMvalidation in 'MMvalidation.pas',
  GeneralFunctions in 'GeneralFunctions.pas'
  {$IFDEF FPC}, Interfaces{$ENDIF}
  ,Forms;

{$R *.res}

begin
{$IFDEF FPC}
  Application.Scaled:=True;
{$ENDIF}
  Application.Initialize;
  Application.CreateForm(TfBenchmark, fBenchmark);
  Application.Run;
end.

