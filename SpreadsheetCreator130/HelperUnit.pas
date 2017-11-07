unit HelperUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  THelperForm = class(TForm)
    AllFunctionsRichEdit: TRichEdit;
    FunctionSizesRichEdit: TRichEdit;
    MatchRichEdit: TRichEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    CompareButton: TButton;
    Label3: TLabel;
    procedure CompareButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HelperForm: THelperForm;

implementation

{$R *.dfm}

uses
 Math;
 
var
 LineNo : Integer;

function GetLineEnd(RichEdit : TRichEdit; LineNo : Integer) : Integer;
var
 I, Len, SumLength : Integer;

begin
 SumLength := 0;
 for I := 0 to LineNo - 1 do
  begin
   Len := Length(RichEdit.Lines[I]);
   SumLength := SumLength + Len + 2;
  end;
 Result := SumLength;
end;

procedure THelperForm.CompareButtonClick(Sender: TObject);
var
 AllFunctionsLineStart, FunctionSizesLineStart, Count1, Count2, MinCount : Integer;
 S1, S2 : AnsiString;

begin
 Count1 := AllFunctionsRichEdit.Lines.Count;
 Count2 := FunctionSizesRichEdit.Lines.Count;
 MinCount := Min(Count1, Count2);
 if LineNo >= MinCount then
  LineNo := 0;
 Inc(LineNo);
 AllFunctionsRichEdit.SelectAll;
 AllFunctionsRichEdit.SelAttributes.Color := clBlack;
 FunctionSizesRichEdit.SelectAll;
 FunctionSizesRichEdit.SelAttributes.Color := clBlack;
 AllFunctionsLineStart := GetLineEnd(AllFunctionsRichEdit, LineNo-1);
 AllFunctionsRichEdit.SelStart := AllFunctionsLineStart;
 AllFunctionsRichEdit.SelLength := Length(AllFunctionsRichEdit.Lines[LineNo-1]);
 FunctionSizesLineStart := GetLineEnd(AllFunctionsRichEdit, LineNo-1);
 FunctionSizesRichEdit.SelStart := FunctionSizesLineStart;
 FunctionSizesRichEdit.SelLength := Length(AllFunctionsRichEdit.Lines[LineNo-1]);
 S1 := AllFunctionsRichEdit.Lines[LineNo-1];
 S2 := FunctionSizesRichEdit.Lines[LineNo-1];
 if S1 = S2 then
  begin
   AllFunctionsRichEdit.SelAttributes.Color := clGreen;
   FunctionSizesRichEdit.SelAttributes.Color := clGreen;
  end
 else
  begin
   AllFunctionsRichEdit.SelAttributes.Color := clRed;
   FunctionSizesRichEdit.SelAttributes.Color := clRed;
  end;
end;

end.
