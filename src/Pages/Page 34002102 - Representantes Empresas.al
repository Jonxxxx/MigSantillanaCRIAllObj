page 55743 "Representantes Empresas"
{
    AutoSplitKey = true;
    Caption = 'Company representatives';
    PageType = List;
    SourceTable = 55743;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Figurar; Rec.Figurar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Figurar';
                }
                field("RNC/CED"; Rec."RNC/CED")
                {
                    ApplicationArea = All;
                    ToolTip = 'RNC/CED';
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                }
                field("C.P."; Rec."C.P.")
                {
                    ApplicationArea = All;
                    ToolTip = 'C.P.';
                }
                field(Poblacion; Rec.Poblacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Poblacion';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
                }
                field(Teléfono; Rec.Teléfono)
                {
                    ApplicationArea = All;
                    ToolTip = 'Teléfono';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                }
            }
        }
    }

    actions
    {
    }
}

