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
                field("Tipo Registro"; "Tipo Registro")
                {
                }
                field("Codigo MdM"; "Codigo MdM")
                {
                }
                field("Codigo NAV"; "Codigo NAV")
                {
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

