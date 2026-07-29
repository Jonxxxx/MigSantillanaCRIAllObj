page 34002219 "Lista prestamos cooperativa"
{
    Caption = 'Cooperative loans list';
    CardPageID = "Cab. prestamos cooperativa";
    Editable = false;
    PageType = List;
    SourceTable = 34002197;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Prestamo"; Rec."No. Prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Prestamo';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No.';
                }
                field("No. afiliado"; Rec."No. afiliado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. afiliado';
                }
                field("Tipo de miembro"; Rec."Tipo de miembro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de miembro';
                }
                field("Tipo prestamo"; Rec."Tipo prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo prestamo';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("% Interes"; Rec."% Interes")
                {
                    ApplicationArea = All;
                    ToolTip = '% Interes';
                }
                field("Cantidad de Cuotas"; Rec."Cantidad de Cuotas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de Cuotas';
                }
                field("Fecha Inicio Deduccion"; Rec."Fecha Inicio Deduccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio Deduccion';
                }
                field("1ra Quincena"; Rec."1ra Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '1ra Quincena';
                }
                field("2da Quincena"; Rec."2da Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '2da Quincena';
                }
                field("Motivo Prestamo"; Rec."Motivo Prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo Prestamo';
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                }
            }
        }
    }

    actions
    {
    }
}

