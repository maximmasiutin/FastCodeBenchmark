unit LinkedListBenchmark;

interface

uses
  Classes, BenchmarkClassUnit, Math;

const
   LinkedListBenchmark_cNB_LIST_ITEMS =
   {$IFDEF WIN64}
   1200000
   {$ELSE}
    600000
   {$ENDIF}
   ;

   LinkedListBenchmark_Iter = 
   {$IFDEF WIN64}
    2
   {$ELSE}
    17
   {$ENDIF}
   ;


type

  TLinkedListBench = class(TFastcodeMMBenchmark)
  public
    constructor CreateBenchmark; override;
    destructor Destroy; override;
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetSpeedWeight: Double; override;
    class function GetCategory: TBenchmarkCategory; override;
    class function Is32BitSpecial: Boolean; override;
  end;

implementation

{ TSmallResizeBench }

constructor TLinkedListBench.CreateBenchmark;
begin
  inherited;
end;

destructor TLinkedListBench.Destroy;
begin
  inherited;
end;

class function TLinkedListBench.GetBenchmarkDescription: string;
begin
  Result:= 'Allocates a linked list containers and then navigates back and '
          +'forth through it multiple times.';
end;

class function TLinkedListBench.GetBenchmarkName: string;
begin
  Result := 'Linked-list container benchmark';
end;

class function TLinkedListBench.GetCategory: TBenchmarkCategory;
begin
  Result := bmMemoryAccessSpeed;
end;

class function TLinkedListBench.GetSpeedWeight: Double;
begin
  {Speed is of the essence here}
  Result := 0.8;
end;

class function TLinkedListBench.Is32BitSpecial: Boolean;
begin
  Result := True;
end;

type
   TExternalRefObject1 = class
      Padding : array [0..50] of Integer;
   end;
   TExternalRefObject2 = class(TExternalRefObject1)
      Padding2 : array [0..50] of Integer;
   end;
   TExternalRefObject3 = class(TExternalRefObject2)
      Padding3 : array [0..50] of Integer;
   end;
   TExternalRefObject4 = class(TExternalRefObject3)
      Padding4 : array [0..50] of Integer;
   end;

   PLinkedListItem = ^TLinkedListItem;
   TLinkedListItem = record
      Next, Prev : PLinkedListItem;
      List : TList;
      ExternalRef : TExternalRefObject1;
   end;

   TLinkedList = class
      First, Last : PLinkedListItem;
   end;

procedure Dummy;
begin
end;

procedure TLinkedListBench.RunBenchmark;
var
   j, i : Integer;
   list : TLinkedList;
   current : PLinkedListItem;
   NextValue: Integer;
begin
 inherited;
 for j := 0 to LinkedListBenchmark_Iter-1 do
 begin
   // allocate the list
   NextValue := 199; // prime
   list:=TLinkedList.Create;
   New(current);
   current^.Next:=nil;
   current^.Prev:=nil;
   current^.ExternalRef:=TExternalRefObject1.Create;
   list.First:=current;
   list.Last:=list.First;
   for i:=2 to LinkedListBenchmark_cNB_LIST_ITEMS do begin
      New(current);
      current^.Next:=nil;
      list.Last^.Next:=current;
      current^.Prev:=list.Last;
      list.Last:=current;
      case NextValue mod 4 of // allocate from a small variety of external refs
         0 : current^.ExternalRef:=TExternalRefObject1.Create;
         1 : current^.ExternalRef:=TExternalRefObject2.Create;
         2 : current^.ExternalRef:=TExternalRefObject3.Create;
         3 : current^.ExternalRef:=TExternalRefObject4.Create;
      end;
      Inc(NextValue, 199); // prime
   end;

   // peak usage reached now
   UpdateUsageStatistics;

   // do the bench
   for i:=1 to 100 do begin
      current:=list.First;
      while current<>nil do begin
         if current^.ExternalRef.Padding[0]=-1 then Dummy; // access the ExternalRef
         current:=current^.Next;
      end;
      current:=list.Last;
      while current<>nil do begin
         if current^.ExternalRef.Padding[0]=-1 then Dummy; // access the ExternalRef
         current:=current^.Prev;
      end;
   end;

   // cleanup
   current:=list.First;
   while current<>nil do begin
      list.First:=current^.Next;
      current^.ExternalRef.Free;
      Dispose(current);
      current:=list.First;
   end;
   list.Free;
   list := nil;
  end;
end;

end.
