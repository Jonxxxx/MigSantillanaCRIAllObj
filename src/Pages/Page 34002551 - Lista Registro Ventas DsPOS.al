page 34002551 "Lista Registro Ventas DsPOS"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Lista Registro Ventas DsPOS';
    CardPageID = "Log Registro Ventas DsPOS";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 34002533;
    SourceTableView = SORTING("No. Log")
                      ORDER(Ascending);
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
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
        }
    }

    actions
    {
    }
}

