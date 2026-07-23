page 34002521 "Lista Pagos TPV"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 34002521;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Fecha; Fecha)
                {
                }
                field(Tienda; Tienda)
                {
                }
                field(TPV; TPV)
                {
                }
                field(Cajero; Cajero)
                {
                }
                field("Forma pago TPV"; "Forma pago TPV")
                {
                }
                field("No. Borrador"; "No. Borrador")
                {
                }
                field(Importe; Importe)
                {
                }
                field("No. Factura"; "No. Factura")
                {
                }
                field("No. Nota Credito"; "No. Nota Credito")
                {
                }
                field(Hora; Hora)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
        cfComunes: Codeunit 34002503;
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

