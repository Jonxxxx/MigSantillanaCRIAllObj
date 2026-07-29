page 67066 "Colegio - Personal Jerarquico"
{
    PageType = Card;
    SourceTable = 67056;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
            }
            part(PagePart; 67067)
            {
                SubPageLink = "Cod. Colegio" = FIELD("Cod. Colegio"),
                              "Cod. Docente" = FIELD("Cod. Local"),
                              "Nombre colegio" = FIELD("Cod. Nivel"),
                              "Nombre docente" = FIELD("Cod. Turno");
            }
        }
    }

    actions
    {
    }
}

