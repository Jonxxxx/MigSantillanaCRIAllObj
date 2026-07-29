page 34002139 "Lista Cxc Empleados"
{
    Caption = 'Create employee loan';
    CardPageID = "CxC Empleados";
    PageType = List;
    SourceTable = 34002145;

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
                field("Codigo Empleado"; Rec."Codigo Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Empleado';
                }
                field("Fecha Registro CxC"; Rec."Fecha Registro CxC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro CxC';
                }
                field("Tipo CxC"; Rec."Tipo CxC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo CxC';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field(Cuotas; Rec.Cuotas)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuotas';
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field(Pendiente; Rec.Pendiente)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pendiente';
                }
                field("Tipo Contrapartida"; Rec."Tipo Contrapartida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Contrapartida';
                }
                field("Cta. Contrapartida"; Rec."Cta. Contrapartida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Contrapartida';
                }
            }
        }
    }

    actions
    {
    }
}

