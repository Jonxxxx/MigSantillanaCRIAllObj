page 75007 "Conversion NAV MdM"
{
    ApplicationArea = Basic, Suite, Service;
    DelayedInsert = true;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = 75007;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo Registro"; Rec."Tipo Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Registro';
                }
                field("Codigo MdM"; Rec."Codigo MdM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo MdM';
                }
                field("Codigo NAV"; Rec."Codigo NAV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo NAV';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetDimFilter;
    end;
}

