page 130407 "CAL Test Objects To Select"
{
    Caption = 'CAL Test Objects To Select';
    Editable = false;
    PageType = List;
    SourceTable = Table2000000001;
    SourceTableView = WHERE(Type = FILTER(> TableData));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(ID; ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID that applies.';
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the test objects selected.';
                }
                field(HitBy; CountTestCodeunits)
                {
                    ApplicationArea = All;
                    Caption = 'Hit By Test Codeunits';

                    trigger OnDrillDown()
                    begin
                        IF CALTestCoverageMap.FINDFIRST THEN
                            PAGE.RUNMODAL(0, CALTestCoverageMap);
                    end;
                }
                field(Caption; Caption)
                {
                    ApplicationArea = All;
                    DrillDown = false;
                    Visible = false;
                }
                field(Modified; Modified)
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Time)
                {
                    ApplicationArea = All;
                }
                field("Version List"; "Version List")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CALTestCoverageMap.SETRANGE("Object Type", Type);
        CALTestCoverageMap.SETRANGE("Object ID", ID);
    end;

    var
        CALTestCoverageMap Record: 130406;

    local procedure CountTestCodeunits(): Integer
    begin
        IF CALTestCoverageMap.FINDFIRST THEN BEGIN
            CALTestCoverageMap.CALCFIELDS("Hit by Test Codeunits");
            EXIT(CALTestCoverageMap."Hit by Test Codeunits");
        END;
        EXIT(0);
    end;
}

