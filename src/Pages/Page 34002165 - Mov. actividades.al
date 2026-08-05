page 34002165 "Mov. actividades"
{
    Caption = 'Activiry Entry';
    Editable = false;
    PageType = List;
    SourceTable = 55798;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Entry No.';
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                }
                field("Puesto trabajo"; Rec."Puesto trabajo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Puesto trabajo';
                }
                field("Apellidos y Nombre"; Rec."Apellidos y Nombre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Apellidos y Nombre';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job No.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Task No.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Resource No.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unit of Measure Code';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Qty. per Unit of Measure';
                }
                field("Job Task Name"; Rec."Job Task Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Task Name';
                }
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
                }
                field("Tipo concepto"; Rec."Tipo concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo concepto';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount';
                }
                field("Tipo Tarifa"; Rec."Tipo Tarifa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Tarifa';
                }
                field("Precio Tarifa"; Rec."Precio Tarifa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio Tarifa';
                }
                field("Inicio Periodo"; Rec."Inicio Periodo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inicio Periodo';
                }
                field("Fin Periodo"; Rec."Fin Periodo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fin Periodo';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Work Type Code';
                }
            }
        }
    }

    actions
    {
    }
}

