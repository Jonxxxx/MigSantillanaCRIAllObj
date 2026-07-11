page 130404 "CAL Test Missing Codeunits"
{
    Caption = 'Missing Codeunits List';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = 2000000026;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater("<Codeunit List>")
            {
                Caption = 'Codeunit List';
                field(Number; Number)
                {
                    ApplicationArea = All;
                    Caption = 'Codeunit ID';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Retry)
            {
                ApplicationArea = All;
                Caption = 'Retry';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF FINDFIRST THEN
                        CALTestMgt.AddMissingTestCodeunits(Rec, CurrentTestSuite);
                end;
            }
        }
    }

    var
        CALTestMgt: Codeunit 130401;
        CurrentTestSuite: Code[10];

    procedure Initialize(var CUIds Record: 2000000026" temporary;TestSuiteName: Code[10])
    begin
        CurrentTestSuite := TestSuiteName;
        COPY(CUIds, TRUE);
    end;
}

