page 34002549 "Log Registro Ventas DsPOS"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Log Registro Ventas DsPOS';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 34002533;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. Log"; "No. Log")
                {
                    Editable = false;
                }
                field(Fecha; Fecha)
                {
                    Editable = false;
                }
                field("Hora Inicio"; "Hora Inicio")
                {
                    Editable = false;
                }
                field("Fecha Fin"; "Fecha Fin")
                {
                    Editable = false;
                }
                field("Hora Fin"; "Hora Fin")
                {
                    Editable = false;
                }
                field(Errores; Errores)
                {
                    Editable = false;
                }
                field("No. Facturas Registradas"; "No. Facturas Registradas")
                {
                    Editable = false;
                }
                field("No. Facturas Liquidadas"; "No. Facturas Liquidadas")
                {
                    Editable = false;
                }
                field("No. NC Registradas"; "No. NC Registradas")
                {
                    Editable = false;
                }
                field("No. NC Liquidadas"; "No. NC Liquidadas")
                {
                    Editable = false;
                }
            }
            part(PartPage; 34002550)
            {
                SubPageLink = "No. Log" = FIELD("No. Log");
            }
        }
    }

    actions
    {
    }
}

