unit SystemInfoUnit;
{
Version  Date         By
-------  -------      --
 1.0.0                      Initial Release
 1.0.1   12-Nov-2006  JOH : Added detection code for Yonah, Conroe, Presler,
                            Athlon 64 X2 and Sempron
 1.0.2   20-Nov-2006  JOH : Fixed SystemInfoCompileFlags
                            Added Function SystemInfoVersion
}
interface

{$INCLUDE Version.inc}

{$IFDEF Delphi6Plus}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
{$ENDIF}

function SystemInfoCompiler     : string;
function SystemInfoCompileFlags : string;
function SystemInfoCPU          : string;
//function SystemInfoCPUDetails   : string;
function SystemInfoWindows      : string;
function SystemInfoVersion      : string;

implementation

uses
  SysUtils, Windows;

type
  TCpuIdRecord = record
    EAX, EBX, ECX, EDX: LongWord;
  end;

  TCpuCount = record
    Log: LongWord;
    LogPerCore: LongWord;
    CorePerPhys: LongWord;
  end;

var
  FrequencyCPU: Double;
  FrequencyCPUKnown: Boolean;

function RdTsc: Int64;
asm
  db $0F,$31 // rdtsc
end;

procedure CpuId(InfoIndex: LongWord; out Res: TCpuIdRecord);
asm
  push   ebx
  push   esi
  mov    esi,   edx
  db     $0F, $A2 // cpuid
  mov    [esi+TCpuIdRecord.&EAX], eax
  mov    [esi+TCpuIdRecord.&EBX], ebx
  mov    [esi+TCpuIdRecord.&ECX], ecx
  mov    [esi+TCpuIdRecord.&EDX], edx
  pop    esi
  pop    ebx
end;

function CalculateFrequencyCPU: Double;
var
  PerfEnd, PerfFreq, PerfStart, PerfTemp, TscEnd, TscStart: Int64;
begin
  if not FrequencyCPUKnown then
  begin
    Win32Check(QueryPerformanceFrequency(PerfFreq));

    // First allow SpeedStep some time
    Win32Check(QueryPerformanceCounter(PerfStart));
    PerfEnd := PerfStart + (PerfFreq div 2);
    repeat
      Win32Check(QueryPerformanceCounter(PerfTemp));
    until PerfTemp >= PerfEnd;

    // Now comes the real test
    Win32Check(QueryPerformanceCounter(PerfStart));
    TscStart := RdTsc;
    PerfEnd := PerfStart + (PerfFreq div 4);
    repeat
      Win32Check(QueryPerformanceCounter(PerfTemp));
    until PerfTemp >= PerfEnd;
    TscEnd := RdTsc;

    FrequencyCPU := (TscEnd-TscStart)*PerfFreq / (PerfTemp-PerfStart);
    FrequencyCPUKnown := True;
  end;
  Result := FrequencyCPU;
end;

function CheckHTEnabledThread(Param: Pointer): DWORD; stdcall;
var
  CIR: TCpuIdRecord;
begin
  CpuId(1, CIR);
  PLongWord(Param)^ := (CIR.EBX shr 24) and $FF;
  Result := 0;
end;

function CheckHTEnabled(const CpuCount: TCpuCount): Boolean;
var
  ApicIds: array of LongWord;
  I: Integer;
  Threads: array of THandle;
  ThreadId: LongWord;
begin
  SetLength(ApicIds, CpuCount.Log);
  SetLength(Threads, CpuCount.Log);

  for I := Low(Threads) to High(Threads) do
    Threads[I] := 0;
  try

    for I := Low(Threads) to High(Threads) do
    begin
      Threads[I] := CreateThread(nil, 0, @CheckHTEnabledThread, @ApicIds[I], CREATE_SUSPENDED, ThreadId);
      Win32Check(Threads[I] <> 0);
      Win32Check(SetThreadAffinityMask(Threads[i], 1 shl I) <> 0);
      Win32Check(ResumeThread(Threads[I]) <> $FFFFFFFF);
    end;

    Win32Check(
      (WaitForMultipleObjects(Length(Threads), @Threads[0], True, 1000) - WAIT_OBJECT_0) in
      [Low(Threads), High(Threads)]);

  finally
    for I := Low(Threads) to High(Threads) do
      if Threads[I] <> 0 then
        CloseHandle(Threads[I]);
  end;

  Result := False;
  for I := Low(ApicIds) to High(ApicIds) do
    if ApicIds[I] and 1 <> 0 then
    begin
      Result := True;
      Break;
    end;
end;

function CountCPUsAMD: TCpuCount;
var
  CIR: TCpuIdRecord;
  InfoCount, LogPerPhys: LongWord;
  SystemInfo: TSystemInfo;
begin
  GetSystemInfo(SystemInfo);
  Result.Log := SystemInfo.dwNumberOfProcessors;
  Result.LogPerCore := 1;
  Result.CorePerPhys := 1;

  CPUID(0, CIR);
  InfoCount := CIR.EAX;

  if InfoCount >= 1 then
  begin
    CPUID(1, CIR);
    if (CIR.EDX and (1 shl 28)) <> 0 then
    begin
      LogPerPhys := CIR.EBX shr 16 and $FF;
      if LogPerPhys >= 1 then
      begin
        CPUID($80000000, CIR);
        if CIR.EAX >= $80000008 then
        begin
          CPUID($80000008, CIR);
          Result.CorePerPhys := (CIR.ECX and $FF) + 1;
          Result.LogPerCore := LogPerPhys div Result.CorePerPhys;
          if (Result.LogPerCore > 1) and not CheckHTEnabled(Result) then
            Result.LogPerCore := 1;
        end;
      end;
    end;
  end;
end;

function CountCPUsIntel: TCpuCount;
var
  CIR: TCpuIdRecord;
  InfoCount: LongWord;
  SystemInfo: TSystemInfo;
begin
  GetSystemInfo(SystemInfo);
  Result.Log := SystemInfo.dwNumberOfProcessors;
  Result.LogPerCore := 1;
  Result.CorePerPhys := 1;

  CPUID(0, CIR);
  InfoCount := CIR.EAX;

  if InfoCount >= 4 then
  begin
    CPUID(4, CIR);
    Result.CorePerPhys := (CIR.EAX shr 26) + 1;
  end;

  if InfoCount >= 1 then
  begin
    CPUID(1, CIR);
    if (CIR.EDX and (1 shl 28)) <> 0 then
    begin
      Result.LogPerCore := CIR.EBX shr 16 and $FF;
      if Result.LogPerCore < 1 then
        Result.LogPerCore := 1
      else
        if (Result.LogPerCore > 1) and not CheckHTEnabled(Result) then
          Result.LogPerCore := 1;
    end;
  end;
end;

function GetCPUName(const VendorString: string; CPUType, CPUFamily, CPUModel, CPUStepping: Integer; const CPUMHz: Double): string;
{Processors below with comment //001 added on 12-Nov-2006 by JOH}
begin
  Result := '';
  if VendorString = 'GenuineIntel' then
    case CPUFamily of
      4: case CPUModel of
           0, 1:  Result := 'Intel 486 DX';
           2:     Result := 'Intel 486 SX';
           3:     Result := 'Intel 486 DX/2';
           4:     Result := 'Intel 486 SL';
           5:     Result := 'Intel 486 SX/2';
           7:     Result := 'Intel 486 DX/2-WB';
           8:     Result := 'Intel 486 DX/4';
           9:     Result := 'Intel 486 DX/4-WB';
         end;
      5: case CPUModel of
           0..2:  Result := 'Intel Pentium';
           4:     Result := 'Intel Pentium MMX';
           7:     Result := 'Intel Mobile Pentium';
           8:     Result := 'Intel Mobile Pentium MMX';
         end;
      6: case CPUModel of
           1:     Result := 'Intel Pentium Pro';
           3:     Result := 'Intel Pentium II [Klamath]';
           5:     Result := 'Intel Pentium II [Deschutes]';
           6:     Result := 'Intel Celeron [Mendocino]';
           7:     Result := 'Intel Pentium III [Katmai]';
           8:     Result := 'Intel Pentium III [Coppermine]';
           9:     Result := 'Intel Pentium M [Banias]';
           10:    Result := 'Intel Pentium III Xeon';
           11:    Result := 'Intel Pentium III';
           13:    Result := 'Intel Pentium M [Dothan]';
           14:    Result := 'Intel Pentium M Core Duo [Yonah]'; //001
           15:    Result := 'Intel Core 2 Duo [Conroe]';        //001
         end;
      15: case CPUModel of
            0, 1: Result := 'Intel Pentium 4 [Willamette]';
            2:    Result := 'Intel Pentium 4 [Northwood]';
            3, 4: Result := 'Intel Pentium 4 [Prescott]';
            6:    Result := 'Intel Pentium D [Presler]';        //001
          end;
    end
  else if VendorString = 'AuthenticAMD' then
    case CPUFamily of
      4: case CPUModel of
           3:     Result := 'AMD 486 DX/2';
           7:     Result := 'AMD 486 DX/2-WB';
           8:     Result := 'AMD 486 DX/4';
           9:     Result := 'AMD 486 DX/4-WB';
           14:    Result := 'AMD Am5x86-WT';
           15:    Result := 'AMD Am5x86-WB';
         end;
      5: case CPUModel of
           0:     Result := 'AMD K5/SSA5';
           1..3:  Result := 'AMD K5';
           6, 7:  Result := 'AMD K6';
           8:     Result := 'AMD K6-2';
           9:     Result := 'AMD K6-3';
           13:    Result := 'AMD K6-2+ / K6-III+';
         end;
      6: case CPUModel of
           0..2:  Result := 'AMD Athlon';
           3:     Result := 'AMD Duron';
           4:     Result := 'AMD Athlon [Thunderbird]';
           6:     Result := 'AMD Athlon [Palamino]';
           7:     Result := 'AMD Duron [Morgan]';
           8:     Result := 'AMD Athlon [Thoroughbred]';
           10:    Result := 'AMD Athlon [Barton]';
         end;
      15: case CPUModel of
            3:    Result := 'AMD Athlon 64 X2 [Toledo]';        //001
            4:    Result := 'AMD Athlon 64';
            5:    Result := 'AMD Athlon 64 FX / Opteron';
            7:    Result := 'AMD Athlon 64';
            11:   Result := 'AMD Athlon 64 X2 [Manchester]';    //001
            12:   Result := 'AMD Sempron [Albany]';             //001
          end;
    end;
end;

function SystemInfoCompiler: string;
begin
  Result := 'Delphi'
    {$IFDEF Delphi1}+'1'{$ENDIF}
    {$IFDEF Delphi2}+'2'{$ENDIF}
    {$IFDEF Delphi3}+'3'{$ENDIF}
    {$IFDEF Delphi4}+'4'{$ENDIF}
    {$IFDEF Delphi5}+'5'{$ENDIF}
    {$IFDEF Delphi6}+'6'{$ENDIF}
    {$IFDEF Delphi7}+'7'{$ENDIF}
    {$IFDEF Delphi8}+'8'{$ENDIF}
    {$IFDEF Delphi2005}+'2005'{$ENDIF}
    {$IFDEF Delphi2006}+'2006'{$ENDIF}
    {$IFDEF Delphi2007}+'2007'{$ENDIF};
end;

function SystemInfoCompileFlags: string;
begin
  Result := {$IFOPT O+}'O+'{$ELSE}'O-'{$ENDIF}+','
            {$IFOPT Q+}+'Q+'{$ELSE}+'Q-'{$ENDIF}+','
            {$IFOPT R+}+'R+'{$ELSE}+'R-'{$ENDIF};
end;

function SystemInfoCPU: string;
var
  CIR: TCpuIdRecord;
  CPUMHz: Double;
  CPUFamily, CPUModel, CPUStepping, CPUType, InfoCount: LongWord;
  CPUCount: TCpuCount;
  CPUCountStr, CPUName: string;
  BrandString: array[0..47] of AnsiChar;
  VendorString: array[0..12] of AnsiChar;
begin
  CpuId(0, CIR);
  InfoCount := CIR.EAX;
  Move(CIR.EBX, VendorString[0], SizeOf(CIR.EBX));
  Move(CIR.EDX, VendorString[4], SizeOf(CIR.EDX));
  Move(CIR.ECX, VendorString[8], SizeOf(CIR.ECX));
  VendorString[12] := #0;

  CPUMHz := CalculateFrequencyCPU / 1000000;
  if InfoCount >= 1 then
  begin
    CpuId(1, CIR);
    CPUType := (CIR.EAX shr 12) and $3;
    CPUFamily := (CIR.EAX shr 8) and $F;
    CPUModel := (CIR.EAX shr 4) and $F;
    CPUStepping := CIR.EAX and $F;
    if CPUFamily = $F then
    begin
      CPUFamily := CPUFamily + (CIR.EAX shr 16) and $FF0;
      CPUModel := CPUModel + (CIR.EAX shr 12) and $F0;
      Result := Format('%s, type %.1x, family %.3x, model %.2x, stepping %.1x',
        [VendorString, CPUType, CPUFamily, CPUModel, CPUStepping, CPUMHz]);
    end
    else
      Result := Format('%s, type %.1x, family %.1x, model %.1x, stepping %.1x',
        [VendorString, CPUType, CPUFamily, CPUModel, CPUStepping, CPUMHz]);

    // Does this work on Pentium III and earlier? Intel says need to check
    // CIR.EAX and $80000000, but that doesn't seem to work.
    CpuId($80000000, CIR);
    if CIR.EAX >= $80000004 then
    begin
      CpuId($80000002, CIR);
      Move(CIR, BrandString[0], SizeOf(CIR));
      CpuId($80000003, CIR);
      Move(CIR, BrandString[16], SizeOf(CIR));
      CpuId($80000004, CIR);
      Move(CIR, BrandString[32], SizeOf(CIR));
      Result := Format('%s (%s)', [TrimLeft(BrandString), Result]);
    end
    else
    begin
      CPUName := GetCPUName(VendorString, CPUType, CPUFamily, CPUModel, CPUStepping, CPUMHz);
      if CPUName <> '' then
        Result := Format('%s (%s)', [CPUName, Result]);
    end;
  end;

  if VendorString = 'AuthenticAMD' then
    CPUCount := CountCPUsAMD
  else
    CPUCount := CountCPUsIntel;

  CPUCountStr := '';
  if CPUCount.Log > 1 then
  begin
    if CPUCount.LogPerCore > 1 then
      CPUCountStr := CPUCountStr + Format(', %d logical CPUs', [CPUCount.Log]);
    if CPUCount.CorePerPhys > 1 then
      CPUCountStr := CPUCountStr + Format(', %d CPU cores', [CPUCount.Log div CPUCount.LogPerCore]);
    CPUCountStr := CPUCountStr + Format(', %d physical CPUs', [CPUCount.Log div (CPUCount.LogPerCore * CPUCount.CorePerPhys)]);
  end;

  Result := Format('%s, %.1f MHz%s', [Result, CPUMHz, CPUCountStr]);
end;

//function SystemInfoCPUDetails: string;
//begin
//  Result := VendorStr[CPU.Vendor];
//  if (isMMX in CPU.InstructionSupport) then Result := Result + ' MMX';
//  if (isSSE in CPU.InstructionSupport) then Result := Result + ' SSE';
//  if (isSSE2 in CPU.InstructionSupport) then Result := Result + ' SSE2';
//  if (isSSE3 in CPU.InstructionSupport) then Result := Result + ' SSE3';
//  if (isSSSE3 in CPU.InstructionSupport) then Result := Result + ' SSSE3';
//end;

function SystemInfoWindows: string;
var
  VI: TOSVersionInfo;
begin
  Result := '';
  VI.dwOSVersionInfoSize := SizeOf(VI);
  Win32Check(GetVersionEx(VI));
  if VI.dwPlatformId = VER_PLATFORM_WIN32_NT then
  begin
    case VI.dwMajorVersion of
      3: if VI.dwMinorVersion = 51 then Result := 'Windows NT 3.51';
      4: if VI.dwMinorVersion = 0 then Result := 'Windows NT 4.0';
      5: case VI.dwMinorVersion of
           0: Result := 'Windows 2000';
           1: Result := 'Windows XP';
           2: Result := 'Windows Server 2003';
         end;
      6: if VI.dwMinorVersion = 0 then Result := 'Windows Vista';
    end;
    Result := Result+' (NT.';
  end
  else if VI.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
  begin
    if VI.dwMajorVersion = 4 then
      case VI.dwMinorVersion of
        0: Result := Result+'Windows 95';
        10: Result := Result+'Windows 98';
        90: Result := Result+'Windows Me';
      end;
    Result := Result+' (9x.';
  end;
  Result := Result+
    Format('%d.%d.%d', [VI.dwMajorVersion, VI.dwMinorVersion, VI.dwBuildNumber])+') '+
    VI.szCSDVersion;
end;

function SystemInfoVersion: string;
var
  Size, Handle : Cardinal;
  Fname, Buffer: string;
  FixedFileInfo: PVSFixedFileInfo;
begin
  Result := 'Unknown';
  Fname := GetModuleName(HInstance);
  SetLength(Buffer, GetFileVersionInfoSize(PChar(Fname), Handle));
  if Buffer <> '' then
    if GetFileVersionInfo(PChar(Fname), Handle, Length(Buffer), PChar(Buffer)) then
      if VerQueryValue(PChar(Buffer), '\', Pointer(FixedFileInfo), Size) then
        if Size = SizeOf(TVSFixedFileInfo) then
          with FixedFileInfo^ do
            Result := Format('%d.%d.%d',
              [HIWORD(dwFileVersionMS), LOWORD(dwFileVersionMS), HIWORD(dwFileVersionLS)]);
end;

end.
