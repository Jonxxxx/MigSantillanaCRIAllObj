page 34002550 "Lineas Registro Ventas DsPoS"
{
    // #217374, RRT, 30.08.19: Mostrar informacion de firma.

    ApplicationArea = Basic, Suite;
    Caption = 'Lineas Registro Ventas DsPoS';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = 34002534;
    SourceTableView = SORTING("Fecha Documento", Tienda, TPV, "No. Documento")
                      ORDER(Ascending);
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Fecha Documento"; "Fecha Documento")
                {
                }
                field(Tienda; Tienda)
                {
                }
                field(TPV; TPV)
                {
                }
                field("Tipo Documento"; "Tipo Documento")
                {
                }
                field("No. Documento"; "No. Documento")
                {
                }
                field(Texto; Texto)
                {
                }
                field(Error; Error)
                {
                }
                field(Registrado; Registrado)
                {
                }
                field(Liquidado; Liquidado)
                {
                }
                field(Firmado; Firmado)
                {
                }
                field("No. documento NAV"; "No. documento NAV")
                {
                }
            }
        }
    }

    actions
    {
    }
}

