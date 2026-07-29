page 34002216 "Lista Miembros Cooperativa"
{
    Caption = 'Cooperative member list';
    CardPageID = "Ficha Miembros Coop.";
    Editable = false;
    PageType = List;
    SourceTable = 34002195;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo de miembro"; Rec."Tipo de miembro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de miembro';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No.';
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                }
                field("Fecha inscripcion"; Rec."Fecha inscripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion';
                }
                field("Tipo de aporte"; Rec."Tipo de aporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de aporte';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Ahorro acumulado"; Rec."Ahorro acumulado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ahorro acumulado';
                }
                field("Prestamos pendientes"; Rec."Prestamos pendientes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Prestamos pendientes';
                }
                field("Importe pendiente"; Rec."Importe pendiente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe pendiente';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
            }
        }

    }

    actions
    {
    }
}

