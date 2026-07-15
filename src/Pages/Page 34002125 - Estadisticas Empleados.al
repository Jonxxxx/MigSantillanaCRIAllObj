page 34002125 "Estadisticas Empleados"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            field("Full Name"; "Full Name")
            {
                Editable = false;
            }
            field("Date Filter"; "Date Filter")
            {
            }
            field("Dias Vacaciones"; "Dias Vacaciones")
            {
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
    //TODO: Ver FuncNom: Codeunit 34002104;
}

