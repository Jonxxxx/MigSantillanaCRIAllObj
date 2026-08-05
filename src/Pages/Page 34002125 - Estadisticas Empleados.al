page 55766 "Estadisticas Empleados"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            field("Full Name"; Rec."Full Name")
            {
                ApplicationArea = All;
                ToolTip = 'Full Name';
                Editable = false;
            }
            field("Date Filter"; Rec."Date Filter")
            {
                ApplicationArea = All;
                ToolTip = 'Date Filter';
            }
            field("Dias Vacaciones"; Rec."Dias Vacaciones")
            {
                ApplicationArea = All;
                ToolTip = 'Dias Vacaciones';
                Editable = false;
            }
            group(General)
            {
                Caption = 'General';
                part(Income; 34002190)
                {
                    Caption = 'Income';
                    SubPageLink = "No. empleado" = FIELD("No."),
                                  "Tipo concepto" = CONST(Ingresos),
                                  "Filtro Fecha" = FIELD("Date Filter");
                }
                part(Deductions; 34002190)
                {
                    Caption = 'Deductions';
                    SubPageLink = "No. empleado" = FIELD("No."),
                                  "Tipo concepto" = CONST(Deducciones),
                                  "Filtro Fecha" = FIELD("Date Filter");
                }
            }
        }
    }

    actions
    {
    }

    var
    // TODO: Manual review - The verified payroll codeunit declaration has no caller in this page, so restoring it would not restore behavior.
    // Original code: FuncNom: Codeunit 55745;
}

